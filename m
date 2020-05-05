Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7D1C52E3
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEEKR3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 06:17:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:55397 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEKR3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 May 2020 06:17:29 -0400
IronPort-SDR: thcmRBEcwjsoXcV8tBOvjLP0/IS90Fp6WgXO8oVwTiQjiukpummhRQy8W8B6Ar9sB/4AQPhy3h
 ONmM9/sBw9XQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 03:17:26 -0700
IronPort-SDR: a/69aQ63xJLQMuy2jxQGIg4zE6caXrXC/x8RyYdK5S3oSo3cjYDlMjq9GT5fWLauN48BiPs5LJ
 lQvmeE1fG/cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="406778121"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2020 03:17:27 -0700
From:   Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] Assemble.c: respect force flag.
Date:   Tue,  5 May 2020 12:17:17 +0200
Message-Id: <20200505101717.29553-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>

If the array is dirty handler will set resync_start to 0 to inform kernel
that resync is needed. RWH affects only raid456 module, for other
levels array will be started even array is degraded and resync cannot be
performed.

Force is really meaningful for raid456. If array is degraded and resync
is requested, kernel will reject an attempt to start the array. To
respect force, it has to be marked as clean (this will be done for each
array without PPL) and remove the resync request (only for raid 456).
Data corruption may occur so proper warning is added.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
---
 Assemble.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/Assemble.c b/Assemble.c
index 6b5a7c8e..1206fb06 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -2030,6 +2030,15 @@ int assemble_container_content(struct supertype *st, int mdfd,
 			free(avail);
 			return err;
 		}
+	} else if (c->force) {
+		/* Set the array as 'clean' so that we can proceed with starting
+		 * it even if we don't have all devices. Mdmon doesn't care
+		 * if the dirty flag is set in metadata, it will start managing
+		 * it anyway.
+		 * This is really important for raid456 (RWH case), other levels
+		 * are started anyway.
+		 */
+		content->array.state |= 1;
 	}
 
 	if (enough(content->array.level, content->array.raid_disks,
@@ -2049,20 +2058,36 @@ int assemble_container_content(struct supertype *st, int mdfd,
 	}
 	free(avail);
 
-	if (c->runstop <= 0 &&
-	    (working + preexist + expansion) <
-	    content->array.working_disks) {
-		if (c->export && result)
-			*result |= INCR_UNSAFE;
-		else if (c->verbose >= 0) {
-			pr_err("%s assembled with %d device%s",
-			       chosen_name, preexist + working,
-			       preexist + working == 1 ? "":"s");
-			if (preexist)
-				fprintf(stderr, " (%d new)", working);
-			fprintf(stderr, " but not safe to start\n");
+	if ((working + preexist + expansion) < content->array.working_disks) {
+		if (c->runstop <= 0) {
+			if (c->export && result)
+				*result |= INCR_UNSAFE;
+			else if (c->verbose >= 0) {
+				pr_err("%s assembled with %d device%s",
+					chosen_name, preexist + working,
+					preexist + working == 1 ? "":"s");
+				if (preexist)
+					fprintf(stderr, " (%d new)", working);
+				fprintf(stderr, " but not safe to start\n");
+				if (c->force)
+					pr_err("Consider --run to start array as degraded.\n");
+			}
+			return 1;
+		} else if (content->array.level >= 4 &&
+			   content->array.level <= 6 &&
+			   content->resync_start != MaxSector &&
+			   c->force) {
+			/* Don't inform the kernel that the array is not
+			 * clean and requires resync.
+			 */
+			content->resync_start = MaxSector;
+			err = sysfs_set_num(content, NULL, "resync_start",
+					    MaxSector);
+			if (err)
+				return 1;
+			pr_err("%s array state forced to clean. It may cause data corruption.\n",
+				chosen_name);
 		}
-		return 1;
 	}
 
 
-- 
2.25.0

