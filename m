Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA397140C62
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jan 2020 15:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgAQOYI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jan 2020 09:24:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:3747 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQOYI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jan 2020 09:24:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 06:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="424473079"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2020 06:24:07 -0800
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] imsm: fill working_disks according to metadata.
Date:   Fri, 17 Jan 2020 15:24:04 +0100
Message-Id: <20200117142404.25035-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Imsm tracts as "working_disk" each visible drive.
Assemble routine expects that the value will return count
of active member drives recorded in metadata.
As a side effect "--no-degraded" doesn't work correctly for imsm.
Align this field to others.
Added check, if the option --no-degraded is called with --scan.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 mdadm.c       | 9 ++++++---
 super-intel.c | 5 ++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mdadm.c b/mdadm.c
index 256a97ef..13dc24e4 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -1485,9 +1485,12 @@ int main(int argc, char *argv[])
 			rv = Manage_stop(devlist->devname, mdfd, c.verbose, 0);
 		break;
 	case ASSEMBLE:
-		if (devs_found == 1 && ident.uuid_set == 0 &&
-		    ident.super_minor == UnSet && ident.name[0] == 0 &&
-		    !c.scan ) {
+		if (!c.scan && c.runstop == -1) {
+			pr_err("--no-degraded not meaningful without a --scan assembly.\n");
+			exit(1);
+		} else if (devs_found == 1 && ident.uuid_set == 0 &&
+			   ident.super_minor == UnSet && ident.name[0] == 0 &&
+			   !c.scan) {
 			/* Only a device has been given, so get details from config file */
 			struct mddev_ident *array_ident = conf_get_ident(devlist->devname);
 			if (array_ident == NULL) {
diff --git a/super-intel.c b/super-intel.c
index 5c1f759f..47809bc2 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -7946,7 +7946,8 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
 				skip = 1;
 			if (!skip && (ord & IMSM_ORD_REBUILD))
 				recovery_start = 0;
-
+			if (!(ord & IMSM_ORD_REBUILD))
+				this->array.working_disks++;
 			/*
 			 * if we skip some disks the array will be assmebled degraded;
 			 * reset resync start to avoid a dirty-degraded
@@ -7988,8 +7989,6 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
 				else
 					this->array.spare_disks++;
 			}
-			if (info_d->recovery_start == MaxSector)
-				this->array.working_disks++;
 
 			info_d->events = __le32_to_cpu(mpb->generation_num);
 			info_d->data_offset = pba_of_lba0(map);
-- 
2.16.4

