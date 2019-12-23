Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4A1293C1
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLWJtO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43130 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLWJtN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so14759935edb.10
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1jL4fIkAh6GSgeziIPeFdf7qreB8fx7FOuEGZwRlAM=;
        b=EOCpK7D2BcdAO1ALSX78+SG9VbOmQUfzUYtn2Cz82XBLko8/+wCqxjuELBc3CKD7/l
         w3wrM3B3EBfzODnSNssp2K1ltrYHjqiAolmr6pX04as27XjdWDwKi67ouP734PnpdtGX
         8zVJq+OhdKjbPmbQuynnwjVpjThTnT/zpDaenlkFt1CMjiVrjzHZ8Y2BpF51S+E75EE9
         9mssbxrQOEQtwePSD47rAMYmItBVIK2gjNQ2x0u7F8IBucfVtkczgcw6a1mTH7M9icPw
         52dAmQGCve/fAn65xmoMWLBiBznyPoGDKAskHwZOjA2JnkD0Qk0ioWjzw/Bsq2ges+Lr
         2p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1jL4fIkAh6GSgeziIPeFdf7qreB8fx7FOuEGZwRlAM=;
        b=S7gMwjqihfl5gACgMBGAfPWl72/nZulEJTH4p+wYv6OGE2DJU8DfetbQDdHXZSxvbO
         +7ch5Ii7998uSBuieEkiIdjLWTegqXcgLRlSmJYgesngKG1HjlXpE47I/dYlidW15u6b
         /Ysbt4wO8fJXZRXzeRh2VR8a1gSBFNIp+KHGw2ONyjRB9xToyqBxYo35NKFdsgLKK77s
         hlu+3sV3r8pyOJIStPZW37mHCS5AiyKrNQMIWU2GPNW+932cpIS42peVA0A7+JP9tOeH
         veY730Zy5rwjy67MG+BZeSHF4yc8JVq2w0hv1A7LYeHkpEEfWJ/sED+ZyjLsHr4b0pja
         W8FQ==
X-Gm-Message-State: APjAAAUkG0Sy9l4ntuSnY0wj7l2RmOVIYuS0DP82C5RueEsttmXzNXEQ
        w+3MEFlTqxAU3PdGZHGbaAVrh+Ur
X-Google-Smtp-Source: APXvYqyI/GFrw6/pHDjZML9Ss50PtRu7J9Fc1lT/2HnNEMFn2amlMUsq15TwBA8ccVmQckbk1IYsCg==
X-Received: by 2002:a17:906:b2d1:: with SMTP id cf17mr31414036ejb.192.1577094551709;
        Mon, 23 Dec 2019 01:49:11 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:11 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 03/10] md: prepare for enable raid1 io serialization
Date:   Mon, 23 Dec 2019 10:48:55 +0100
Message-Id: <20191223094902.12704-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

1. The related resources (spin_lock, list and waitqueue) are needed for
address raid1 reorder overlap issue too, in this case, rdev is set to
NULL for mddev_create/destroy_serial_pool which implies all rdevs need
to handle these resources.

And also add "is_suspend" to mddev_destroy_serial_pool since it will
be called under suspended situation, which also makes both create and
destroy pool have same arguments.

2. Introduce rdevs_init_serial which is called if raid1 io serialization
is enabled since all rdevs need to init related stuffs.

3. rdev_init_serial and clear_bit(CollisionCheck, &rdev->flags) should
be called between suspend and resume.

No need to export mddev_create_serial_pool since it is only called in
md-mod module.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 65 ++++++++++++++++++++++++++++++++++---------------
 drivers/md/md.h |  2 +-
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8f5def0cb60a..b9b041b7e196 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -127,9 +127,6 @@ static inline int speed_max(struct mddev *mddev)
 
 static int rdev_init_serial(struct md_rdev *rdev)
 {
-	if (rdev->bdev->bd_queue->nr_hw_queues == 1)
-		return 0;
-
 	spin_lock_init(&rdev->serial_list_lock);
 	INIT_LIST_HEAD(&rdev->serial_list);
 	init_waitqueue_head(&rdev->serial_io_wait);
@@ -138,17 +135,29 @@ static int rdev_init_serial(struct md_rdev *rdev)
 	return 1;
 }
 
+static void rdevs_init_serial(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		if (test_bit(CollisionCheck, &rdev->flags))
+			continue;
+		rdev_init_serial(rdev);
+	}
+}
+
 /*
- * Create serial_info_pool if rdev is the first multi-queue device flaged
- * with writemostly, also write-behind mode is enabled.
+ * Create serial_info_pool for raid1 under conditions:
+ * 1. rdev is the first multi-queue device flaged with writemostly,
+ *    also write-behind mode is enabled.
+ * 2. rdev is NULL, means want to enable serialization for all rdevs.
  */
 void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			  bool is_suspend)
+			      bool is_suspend)
 {
-	if (mddev->bitmap_info.max_write_behind == 0)
-		return;
-
-	if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_serial(rdev))
+	if (rdev && (mddev->bitmap_info.max_write_behind == 0 ||
+		     rdev->bdev->bd_queue->nr_hw_queues == 1 ||
+		     !test_bit(WriteMostly, &rdev->flags)))
 		return;
 
 	if (mddev->serial_info_pool == NULL) {
@@ -156,6 +165,10 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 
 		if (!is_suspend)
 			mddev_suspend(mddev);
+		if (!rdev)
+			rdevs_init_serial(mddev);
+		else
+			rdev_init_serial(rdev);
 		noio_flag = memalloc_noio_save();
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
@@ -167,15 +180,16 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mddev_resume(mddev);
 	}
 }
-EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
 
 /*
  * Destroy serial_info_pool if rdev is the last device flaged with
- * CollisionCheck.
+ * CollisionCheck, or rdev is NULL when we disable serialization
+ * for normal raid1.
  */
-static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
+static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+				      bool is_suspend)
 {
-	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
+	if (rdev && !test_bit(CollisionCheck, &rdev->flags))
 		return;
 
 	if (mddev->serial_info_pool) {
@@ -185,16 +199,27 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 		/*
 		 * Check if other rdevs need serial_info_pool.
 		 */
-		rdev_for_each(temp, mddev)
+		if (!is_suspend)
+			mddev_suspend(mddev);
+		rdev_for_each(temp, mddev) {
+			if (!rdev) {
+				clear_bit(CollisionCheck, &temp->flags);
+				continue;
+			}
+
 			if (temp != rdev &&
 			    test_bit(CollisionCheck, &temp->flags))
 				num++;
-		if (!num) {
-			mddev_suspend(rdev->mddev);
+		}
+
+		if (rdev)
+			clear_bit(CollisionCheck, &rdev->flags);
+		if (!rdev || !num) {
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
-			mddev_resume(rdev->mddev);
 		}
+		if (!is_suspend)
+			mddev_resume(mddev);
 	}
 }
 
@@ -2377,7 +2402,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
-	mddev_destroy_serial_pool(rdev->mddev, rdev);
+	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2893,7 +2918,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		mddev_create_serial_pool(rdev->mddev, rdev, false);
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev);
+		mddev_destroy_serial_pool(rdev->mddev, rdev, false);
 		clear_bit(WriteMostly, &rdev->flags);
 		err = 0;
 	} else if (cmd_match(buf, "blocked")) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 7b811645cec7..de04a8d3a67a 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -738,7 +738,7 @@ extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
 extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				 bool is_suspend);
+				     bool is_suspend);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-- 
2.17.1

