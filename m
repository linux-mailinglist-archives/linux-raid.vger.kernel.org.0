Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC9EC490
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKAOXN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42498 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKAOXM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id m13so1344037edv.9
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m2NTXgzkObMHt7ouF6DAWn1CVy1KDoBgE1+wLfmAVWI=;
        b=l72PPLzRo7BOVgMTjvGOudJSkqN40FPXkMXnmbeFmudE+0CgsToScuZLZrvTBDwxyt
         GkgvpYJBIcMWqOYRtrYJodN/YzNpwZkcDEOensZ5H9ggl4F7lJLg28z/ZGDBgIKvrpOl
         AWN4MLgrUy27CVX9tEGnlN2/UCZmlugvikC6N4crlpO4hkoyNFjJfpySaYgZxopk7b1C
         w4KAWwKRzB/dj2RCU9euv/dj6RnKjZ82cIC20MK+uBvwWKxW7pyb+SWbj1BH9bhn9y0F
         bxcuMYXZrZkcdMdQTZ48BFlO+YdvWrjXCZUgdJE7CcYxdlpK9d8YpTNiWTm/rEzgORRY
         qAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m2NTXgzkObMHt7ouF6DAWn1CVy1KDoBgE1+wLfmAVWI=;
        b=koPc/RaXt4wQ7h4yx0uPmb9IJBA9Rou/ONgPv5dmQG0OcMIFXosFfUW7yqkdmAcRi/
         8SrZ9l0yaKcoIuDEVAZXqgQeEoBm6fIQP3u9SojIfbVMgdXHhUysd84CEPYMHliGWvdV
         KnVRkxx+nwq+rMnoy5tHr9ZyamQtlsuKgwkCjE++oy7QaQcLvPyL8xhtAggAAf6Wz19C
         OpinbNI/1kCqs98D3pcK42I4O1A0C1qO7eMdXazMVT+dTP3ruwLnraC4k8oSrly0H3UA
         1PhwSzTOeXDwlaj7LQnvmBMCtfXTky0yINKJcYBEpdCH5jVCO3GxYYUrjgtFZp+tddEZ
         QVXA==
X-Gm-Message-State: APjAAAWkji3e4koXadckdEeeKlZZVXO/W+Jmqv2RggriBWKykfqBejJd
        zZ7Kb+krc2zER4Qf4xN/eVQ=
X-Google-Smtp-Source: APXvYqxaGbmlzOWpNZfo3ImcIb/COzfgVIA51rvkK8TcIuJq/GMCajTtvrxfxmcQl6AR2qkh676vaw==
X-Received: by 2002:a05:6402:797:: with SMTP id d23mr12900111edy.83.1572618189570;
        Fri, 01 Nov 2019 07:23:09 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:08 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/8] md: add is_force parameter for some funcs
Date:   Fri,  1 Nov 2019 15:22:25 +0100
Message-Id: <20191101142231.23359-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The related resources (spin_lock, list and waitqueue) are needed
for address raid1 reorder overlap issue too, so add "is_force"
parameter to funcs (mddev_create/destroy_serial_pool).

This parameter is set to true if we want to enable or disable
raid1 io serialization by writinng sysfs node (in later patch),
rdevs_init_serial is added and called when io serialization is
enabled.

Also rdev_init_serial and clear_bit(CollisionCheck, &rdev->flags)
should be called between suspend and resume.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c |  4 +--
 drivers/md/md.c        | 64 ++++++++++++++++++++++++++++--------------
 drivers/md/md.h        |  2 +-
 3 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 5058716918ef..eff297cf5a81 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
 		goto out;
 
 	rdev_for_each(rdev, mddev)
-		mddev_create_serial_pool(mddev, rdev, true);
+		mddev_create_serial_pool(mddev, rdev, true, false);
 
 	if (mddev_is_clustered(mddev))
 		md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
@@ -2484,7 +2484,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 		struct md_rdev *rdev;
 
 		rdev_for_each(rdev, mddev)
-			mddev_create_serial_pool(mddev, rdev, false);
+			mddev_create_serial_pool(mddev, rdev, false, false);
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index bbf10b9301b6..43b7da334e4a 100644
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
@@ -138,17 +135,27 @@ static int rdev_init_serial(struct md_rdev *rdev)
 	return 1;
 }
 
+static void rdevs_init_serial(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev)
+		rdev_init_serial(rdev);
+}
+
 /*
- * Create serial_info_pool if rdev is the first multi-queue device flaged
- * with writemostly, also write-behind mode is enabled.
+ * Create serial_info_pool for raid1 under conditions:
+ * 1. rdev is the first multi-queue device flaged with writemostly,
+ *    also write-behind mode is enabled.
+ * 2. is_force is true which means we want to enable serialization
+ *    for normal raid1 array.
  */
 void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			  bool is_suspend)
+			      bool is_suspend, bool is_force)
 {
-	if (mddev->bitmap_info.max_write_behind == 0)
-		return;
-
-	if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_serial(rdev))
+	if (!is_force && (mddev->bitmap_info.max_write_behind == 0 ||
+			  (rdev && (rdev->bdev->bd_queue->nr_hw_queues == 1 ||
+				    !test_bit(WriteMostly, &rdev->flags)))))
 		return;
 
 	if (mddev->serial_info_pool == NULL) {
@@ -156,6 +163,10 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 
 		if (!is_suspend)
 			mddev_suspend(mddev);
+		if (is_force)
+			rdevs_init_serial(mddev);
+		if (!is_force && rdev)
+			rdev_init_serial(rdev);
 		noio_flag = memalloc_noio_save();
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
@@ -171,11 +182,13 @@ EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
 
 /*
  * Destroy serial_info_pool if rdev is the last device flaged with
- * CollisionCheck.
+ * CollisionCheck, or is_force is true when we disable serialization
+ * for normal raid1.
  */
-static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
+static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+				      bool is_force)
 {
-	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
+	if (!(is_force || test_bit(CollisionCheck, &rdev->flags)))
 		return;
 
 	if (mddev->serial_info_pool) {
@@ -185,16 +198,25 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 		/*
 		 * Check if other rdevs need serial_info_pool.
 		 */
-		rdev_for_each(temp, mddev)
+		mddev_suspend(mddev);
+		rdev_for_each(temp, mddev) {
+			if (is_force) {
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
+		if (!is_force)
+			clear_bit(CollisionCheck, &rdev->flags);
+		if (is_force || !num) {
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
-			mddev_resume(rdev->mddev);
 		}
+		mddev_resume(mddev);
 	}
 }
 
@@ -2307,7 +2329,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, false);
+		mddev_create_serial_pool(mddev, rdev, false, false);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -2345,7 +2367,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
-	mddev_destroy_serial_pool(rdev->mddev, rdev);
+	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2858,10 +2880,10 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		}
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
-		mddev_create_serial_pool(rdev->mddev, rdev, false);
+		mddev_create_serial_pool(rdev->mddev, rdev, false, false);
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev);
+		mddev_destroy_serial_pool(rdev->mddev, rdev, false);
 		clear_bit(WriteMostly, &rdev->flags);
 		err = 0;
 	} else if (cmd_match(buf, "blocked")) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b77621476b1d..291a59a94528 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -738,7 +738,7 @@ extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
 extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				 bool is_suspend);
+				     bool is_suspend, bool is_force);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-- 
2.17.1

