Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE281050A3
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUKhq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40094 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUKhn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id p59so2340512edp.7
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdDJvPr5kWx1Dejg3N14Ou5riOKiKpnWY6KPdpeiYR8=;
        b=PbaOeJVXKx38VSwHzU4u38fAHIBJO0M4YQGdRa9wM3xjUCf6Ug3FwvPPWV2AVXQBhB
         LyVKjAH37uAdaRecNTv0imR1mH2X7uo0oB3iYn/aLhHQV5mnh33TGx77JCLtpCv6lslW
         2MgDsAkiti7mmJqfLGx8vMuQEApVYv86pjbG+Vt4X4ViWImIbtJY9jCkknDEqfC/yGeT
         hfWxcGBCfLKnK1CvSVydF20Mk82iecpvgXVFbUTauyrfhXSHpIpg6G0LImiNpnjDTOLx
         DdGJ6rqoTotXbszqMar4VEJh4M5mjBnEYssDVaBQ3Row3gUmsAkxwZr0WQR+bcRVuLs8
         zmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdDJvPr5kWx1Dejg3N14Ou5riOKiKpnWY6KPdpeiYR8=;
        b=caqVVvLcmwyhQ/i+tHR4SW9mSgKqJlBjpfnQtN5HhPU3+icUDTFY93cQMU7PjaG7Az
         iAR8YoHmW2cGVd+WHnvMIBIV6/rXiiohf4OIrAs/N15IJjqx1uKvlR3pOdu4Gfv1UUL7
         rd8lq6wOpqeo5BXbDviBiEVA7qfGa1cT3S4/qsnIG8E1GQAENE+6vp7mqbQYZgc6cvx4
         k+kgXite5VIdUrivzWubclfsFxRHJp0lyJF4rIRwVU0KHsgYusadIrhSlYZHMnfAUgdx
         Atwt18ZJXZJj4gQIaTksXphkWFz1F1N1SYMd8C1w6vj4XdApHNBEuA5CAWsRM5keiVJq
         nk1w==
X-Gm-Message-State: APjAAAWjZZup4nJmv2t0J78LAuzH+b379EwCNvZXZ+6FFeLK5r8EKxcX
        Wp28f+r31/StImISK/h+UMI=
X-Google-Smtp-Source: APXvYqz3YDDlHTsDdUMi/Syv8gEDG/XnJLZzKEBiEln7znm4o9+yrEAR858fGAxiOpp0/Ef2pg0E+g==
X-Received: by 2002:a17:906:1fd5:: with SMTP id e21mr12415427ejt.320.1574332661780;
        Thu, 21 Nov 2019 02:37:41 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:41 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 4/9] md: reorgnize mddev_create/destroy_serial_pool
Date:   Thu, 21 Nov 2019 11:37:23 +0100
Message-Id: <20191121103728.18919-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

So far, IO serialization is used for two scenarios:

1. raid1 which enables write-behind mode, and there is rdev in the array
which is multi-queue device and flaged with writemostly.
2. IO serialization is enabled or disabled by change serialize_policy.

So introduce rdev_need_serial to check the first scenario. And for 1, IO
serialization is enabled automatically while 2 is controlled manually.

And it is possible that both scenarios are true, so for create serial pool,
rdev/rdevs_init_serial should be separate from check the pool. Then for
destroy pool, we need to check if the pool is needed by other rdevs due
to the first scenario.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 75 +++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5321e73db90a..c352b48434bf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -147,29 +147,39 @@ static void rdevs_init_serial(struct mddev *mddev)
 }
 
 /*
- * Create serial_info_pool for raid1 under conditions:
- * 1. rdev is the first multi-queue device flaged with writemostly,
- *    also write-behind mode is enabled.
- * 2. is_force is true which means we want to enable serialization
- *    for normal raid1 array.
+ * rdev needs to enable serial stuffs if it meets the conditions:
+ * 1. it is multi-queue device flaged with writemostly.
+ * 2. the write-behind mode is enabled.
+ */
+static int rdev_need_serial(struct md_rdev *rdev)
+{
+	return (rdev && rdev->mddev->bitmap_info.max_write_behind > 0 &&
+		rdev->bdev->bd_queue->nr_hw_queues != 1 &&
+		test_bit(WriteMostly, &rdev->flags));
+}
+
+/*
+ * Init resource for rdev(s), then create serial_info_pool if:
+ * 1. rdev is the first device which return true from rdev_enable_serial.
+ * 2. is_force is true, means we want to enable serialization for all rdevs.
  */
 void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			      bool is_suspend, bool is_force)
 {
-	if (!is_force && (mddev->bitmap_info.max_write_behind == 0 ||
-			  (rdev && (rdev->bdev->bd_queue->nr_hw_queues == 1 ||
-				    !test_bit(WriteMostly, &rdev->flags)))))
+	if (!is_force && !rdev_need_serial(rdev) &&
+	    !test_bit(CollisionCheck, &rdev->flags))
 		return;
 
+	if (!is_suspend)
+		mddev_suspend(mddev);
+
+	if (is_force)
+		rdevs_init_serial(mddev);
+	else
+		rdev_init_serial(rdev);
 	if (mddev->serial_info_pool == NULL) {
 		unsigned int noio_flag;
 
-		if (!is_suspend)
-			mddev_suspend(mddev);
-		if (is_force)
-			rdevs_init_serial(mddev);
-		if (!is_force && rdev)
-			rdev_init_serial(rdev);
 		noio_flag = memalloc_noio_save();
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
@@ -177,15 +187,17 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		memalloc_noio_restore(noio_flag);
 		if (!mddev->serial_info_pool)
 			pr_err("can't alloc memory pool for serialization\n");
-		if (!is_suspend)
-			mddev_resume(mddev);
 	}
+
+	if (!is_suspend)
+		mddev_resume(mddev);
 }
 
 /*
- * Destroy serial_info_pool if rdev is the last device flaged with
- * CollisionCheck, or is_force is true when we disable serialization
- * for normal raid1.
+ * Free resource from rdev(s), and destroy serial_info_pool under conditions:
+ * 1. is_force is false and rdev is the last device flaged with CollisionCheck.
+ * 2. when bitmap is destroyed while policy is not enabled.
+ * 3. for disable policy, the pool is destroyed only when no rdev needs it.
  */
 static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 				      bool is_suspend, bool is_force)
@@ -195,30 +207,31 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 
 	if (mddev->serial_info_pool) {
 		struct md_rdev *temp;
-		int num = 0;
+		int num = 0; /* used to track if other rdevs need the pool */
 
-		/*
-		 * Check if other rdevs need serial_info_pool.
-		 */
 		if (!is_suspend)
 			mddev_suspend(mddev);
 		rdev_for_each(temp, mddev) {
 			if (is_force) {
-				clear_bit(CollisionCheck, &temp->flags);
-				continue;
-			}
-
-			if (temp != rdev &&
-			    test_bit(CollisionCheck, &temp->flags))
+				if (!rdev_need_serial(temp))
+					clear_bit(CollisionCheck, &temp->flags);
+				else
+					num++;
+			} else if (temp != rdev &&
+				   test_bit(CollisionCheck, &temp->flags))
 				num++;
 		}
 
-		if (!is_force)
+		if (!is_force && rdev)
 			clear_bit(CollisionCheck, &rdev->flags);
-		if (is_force || !num) {
+
+		if (num)
+			pr_info("The mempool could be used by other devices\n");
+		else {
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
 		}
+
 		if (!is_suspend)
 			mddev_resume(mddev);
 	}
-- 
2.17.1

