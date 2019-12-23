Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED251293C2
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWJtQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41161 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfLWJtP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so14768548eds.8
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shN5fr+tumiSkHvSX1libal8BTDqFhsDXgkHSmmgm8M=;
        b=jxjjnVzA06EfL4H/R/KxD8QzlkdQWAf3CGZt027c0ZWY+5WKPli9OE6A1jMuZD3R4o
         0RtqwnAM3LkXIyfQXOZGiDruJ0Bu/l2hps4iAuM1LDUjPav2GFC38AzNOBLIVAaAFo4J
         2KebDyP9B7XTM8ZAAIxHKXRuQJWSSRVS3VTEMd/advtaSbVqrG1EKXMS4QG8c+A9peRS
         LzZWcOlqDmKTOz5Xc9xsFAro/seVf95vGkn+GgSKvUxgcThVcdQy0TltqEYvGVSz6PB8
         sNCbhgafXvFL+zczdU9ywr84khMgsaC2noovgxq+jA3Lc4EbYzVTf0j27cUcwSkx9p+k
         CLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shN5fr+tumiSkHvSX1libal8BTDqFhsDXgkHSmmgm8M=;
        b=i96Okrscp6lMviXZfEyVbhupsUIL927m9yLmh09d2x+SGyfutgeXlihH0ZB7M7TWI3
         rawnbzkGILvRb1WWAw3tK16fA9zXRKSg3Udx/ryY9eErdmlByf81WMTyMhbylfeS5FKo
         6gPAWnvnegWXradz+jtkOMYLUsqyzR7AU4dI+xzQwr+LMtl5Gp/i5jCbrsaw1NtL2Pks
         70DtS8eR5swEKO0JtaLNtoXY7WqH9/qB4P85fyK8C6vvz6EkF7/1GSdJDmmWCT9CfmP4
         9RkXbBHs4n9TtdSBS1JncwQQCjDUu+QrAtcXpTt0dSNuUANKpX5XeJKyU3RPLi6ISvWt
         7ABg==
X-Gm-Message-State: APjAAAVTc76BJhvlyagDFO9R0DLp1qoHS23caUnye1OdxOjSEQUFW4VZ
        bt67Cid3unXD6RfiDk41Ymx4Xall
X-Google-Smtp-Source: APXvYqyCNAGJewlehj9PU5nsa5UeCopRour9DMLwOhA7A2rpyQEHqw+2+xbu0OnuSfTTOOX7dGL7Bw==
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr30626388ejb.8.1577094553582;
        Mon, 23 Dec 2019 01:49:13 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:13 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 05/10] md: reorgnize mddev_create/destroy_serial_pool
Date:   Mon, 23 Dec 2019 10:48:57 +0100
Message-Id: <20191223094902.12704-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
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
rdev/rdevs_init_serial should be separate from check if the pool existed or
not. Then for destroy pool, we need to check if the pool is needed by other
rdevs due to the first scenario.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 71 +++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 796cf70e1c9f..788559f42d43 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -147,28 +147,40 @@ static void rdevs_init_serial(struct mddev *mddev)
 }
 
 /*
- * Create serial_info_pool for raid1 under conditions:
- * 1. rdev is the first multi-queue device flaged with writemostly,
- *    also write-behind mode is enabled.
- * 2. rdev is NULL, means want to enable serialization for all rdevs.
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
+ * 2. rdev is NULL, means we want to enable serialization for all rdevs.
  */
 void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			      bool is_suspend)
 {
-	if (rdev && (mddev->bitmap_info.max_write_behind == 0 ||
-		     rdev->bdev->bd_queue->nr_hw_queues == 1 ||
-		     !test_bit(WriteMostly, &rdev->flags)))
+	if (rdev && !rdev_need_serial(rdev) &&
+	    !test_bit(CollisionCheck, &rdev->flags))
 		return;
 
+	if (!is_suspend)
+		mddev_suspend(mddev);
+
+	if (!rdev)
+		rdevs_init_serial(mddev);
+	else
+		rdev_init_serial(rdev);
+
 	if (mddev->serial_info_pool == NULL) {
 		unsigned int noio_flag;
 
-		if (!is_suspend)
-			mddev_suspend(mddev);
-		if (!rdev)
-			rdevs_init_serial(mddev);
-		else
-			rdev_init_serial(rdev);
 		noio_flag = memalloc_noio_save();
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
@@ -176,15 +188,16 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		memalloc_noio_restore(noio_flag);
 		if (!mddev->serial_info_pool)
 			pr_err("can't alloc memory pool for serialization\n");
-		if (!is_suspend)
-			mddev_resume(mddev);
 	}
+	if (!is_suspend)
+		mddev_resume(mddev);
 }
 
 /*
- * Destroy serial_info_pool if rdev is the last device flaged with
- * CollisionCheck, or rdev is NULL when we disable serialization
- * for normal raid1.
+ * Free resource from rdev(s), and destroy serial_info_pool under conditions:
+ * 1. rdev is the last device flaged with CollisionCheck.
+ * 2. when bitmap is destroyed while policy is not enabled.
+ * 3. for disable policy, the pool is destroyed only when no rdev needs it.
  */
 static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 				      bool is_suspend)
@@ -194,27 +207,27 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 
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
 			if (!rdev) {
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
 
 		if (rdev)
 			clear_bit(CollisionCheck, &rdev->flags);
-		if (!rdev || !num) {
+
+		if (num)
+			pr_info("The mempool could be used by other devices\n");
+		else {
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
 		}
-- 
2.17.1

