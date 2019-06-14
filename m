Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E58457E1
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFNIv0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 04:51:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:38254 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfFNIv0 (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Fri, 14 Jun 2019 04:51:26 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 14 Jun 2019 02:51:19 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH 5/5] md: add bitmap_abort label in md_run
Date:   Fri, 14 Jun 2019 17:10:39 +0800
Message-Id: <20190614091039.32461-6-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190614091039.32461-1-gqjiang@suse.com>
References: <20190614091039.32461-1-gqjiang@suse.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now, there are two places need to consider about
the failure of destroy bitmap, so move the common
part between bitmap_abort and abort label.

Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 drivers/md/md.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7bab12a8d237..20db60a04145 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5673,15 +5673,8 @@ int md_run(struct mddev *mddev)
 			mddev->bitmap = bitmap;
 
 	}
-	if (err) {
-		mddev_detach(mddev);
-		if (mddev->private)
-			pers->free(mddev, mddev->private);
-		mddev->private = NULL;
-		module_put(pers->owner);
-		md_bitmap_destroy(mddev);
-		goto abort;
-	}
+	if (err)
+		goto bitmap_abort;
 
 	if (mddev->bitmap_info.max_write_behind > 0) {
 		bool creat_pool = false;
@@ -5697,13 +5690,7 @@ int md_run(struct mddev *mddev)
 						    sizeof(struct wb_info));
 			if (!mddev->wb_info_pool) {
 				err = -ENOMEM;
-				mddev_detach(mddev);
-				if (mddev->private)
-					pers->free(mddev, mddev->private);
-				mddev->private = NULL;
-				module_put(pers->owner);
-				md_bitmap_destroy(mddev);
-				goto abort;
+				goto bitmap_abort;
 			}
 		}
 	}
@@ -5769,6 +5756,13 @@ int md_run(struct mddev *mddev)
 	sysfs_notify(&mddev->kobj, NULL, "degraded");
 	return 0;
 
+bitmap_abort:
+	mddev_detach(mddev);
+	if (mddev->private)
+		pers->free(mddev, mddev->private);
+	mddev->private = NULL;
+	module_put(pers->owner);
+	md_bitmap_destroy(mddev);
 abort:
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
-- 
2.12.3

