Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31816563
	for <lists+linux-raid@lfdr.de>; Tue,  7 May 2019 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGOIu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 May 2019 10:08:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:30177 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfEGOIu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 May 2019 10:08:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 07:08:49 -0700
X-ExtLoop1: 1
Received: from apaszkie-desk.igk.intel.com (HELO apaszkie-desk.ger.corp.intel.com) ([10.102.11.138])
  by fmsmga007.fm.intel.com with ESMTP; 07 May 2019 07:08:48 -0700
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] mdmon: fix wrong array state when disk fails during mdmon startup
Date:   Tue,  7 May 2019 16:08:47 +0200
Message-Id: <20190507140847.4776-1-artur.paszkiewicz@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If a member drive disappears and is set faulty by the kernel during
mdmon startup, after ss->load_container() but before manage_new(), mdmon
will try to readd the faulty drive to the array and start rebuilding.
Metadata on the active drive is updated, but the faulty drive is not
removed from the array and is left in a "blocked" state and any write
request to the array will block. If the faulty drive reappears in the
system e.g. after a reboot, the array will not assemble because metadata
on the drives will be incompatible (at least on imsm).

Fix this by adding a new option for sysfs_read(): "GET_DEVS_ALL". This
is an extension for the "GET_DEVS" option and causes all member devices
to be returned, even if the associated block device has been removed.
Use this option in manage_new() to include the faulty device on the
active_array's devices list. Mdmon will then properly remove the faulty
device from the array and update the metadata to reflect the degraded
state.

Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
---
 managemon.c   |  2 +-
 mdadm.h       |  1 +
 super-intel.c |  2 +-
 sysfs.c       | 23 ++++++++++++++---------
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/managemon.c b/managemon.c
index 29b91bad..200cf83e 100644
--- a/managemon.c
+++ b/managemon.c
@@ -678,7 +678,7 @@ static void manage_new(struct mdstat_ent *mdstat,
 	mdi = sysfs_read(-1, mdstat->devnm,
 			 GET_LEVEL|GET_CHUNK|GET_DISKS|GET_COMPONENT|
 			 GET_SAFEMODE|GET_DEVS|GET_OFFSET|GET_SIZE|GET_STATE|
-			 GET_LAYOUT);
+			 GET_LAYOUT|GET_DEVS_ALL);
 
 	if (!mdi)
 		return;
diff --git a/mdadm.h b/mdadm.h
index 705bd9b5..427cc523 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -647,6 +647,7 @@ enum sysfs_read_flags {
 	GET_ERROR	= (1 << 24),
 	GET_ARRAY_STATE = (1 << 25),
 	GET_CONSISTENCY_POLICY	= (1 << 26),
+	GET_DEVS_ALL	= (1 << 27),
 };
 
 /* If fd >= 0, get the array it is open on,
diff --git a/super-intel.c b/super-intel.c
index 2ba045aa..4fd5e84d 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -8560,7 +8560,7 @@ static void imsm_set_disk(struct active_array *a, int n, int state)
 	disk = get_imsm_disk(super, ord_to_idx(ord));
 
 	/* check for new failures */
-	if (state & DS_FAULTY) {
+	if (disk && (state & DS_FAULTY)) {
 		if (mark_failure(super, dev, disk, ord_to_idx(ord)))
 			super->updates_pending++;
 	}
diff --git a/sysfs.c b/sysfs.c
index df6fdda3..2dd9ab63 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -313,17 +313,22 @@ struct mdinfo *sysfs_read(int fd, char *devnm, unsigned long options)
 			/* assume this is a stale reference to a hot
 			 * removed device
 			 */
-			free(dev);
-			continue;
+			if (!(options & GET_DEVS_ALL)) {
+				free(dev);
+				continue;
+			}
+		} else {
+			sscanf(buf, "%d:%d", &dev->disk.major, &dev->disk.minor);
 		}
-		sscanf(buf, "%d:%d", &dev->disk.major, &dev->disk.minor);
 
-		/* special case check for block devices that can go 'offline' */
-		strcpy(dbase, "block/device/state");
-		if (load_sys(fname, buf, sizeof(buf)) == 0 &&
-		    strncmp(buf, "offline", 7) == 0) {
-			free(dev);
-			continue;
+		if (!(options & GET_DEVS_ALL)) {
+			/* special case check for block devices that can go 'offline' */
+			strcpy(dbase, "block/device/state");
+			if (load_sys(fname, buf, sizeof(buf)) == 0 &&
+			    strncmp(buf, "offline", 7) == 0) {
+				free(dev);
+				continue;
+			}
 		}
 
 		/* finally add this disk to the array */
-- 
2.19.2

