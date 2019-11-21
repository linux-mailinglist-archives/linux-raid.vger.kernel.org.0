Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC81050A0
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKUKhm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34606 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKUKhl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id b72so2378749edf.1
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvU+iMJ040EAhZBl+griq41zsFfJkcAgAfQ0Xr3/uAs=;
        b=Ye2RC9T6+YfLBEGeMPswL9ofqYOHcgmIKQOHGHIqcLW3JY3YA9sAtl/6VRQbl8wI7h
         j4gXeE48zI4ZmbSpSk1n3jCIKvKf16VUsXNBEwVFu3e6ecKPTxm8Pjnf4x73UoL6GpCg
         7sgXG81WTkJ4MDZ3lfZErSnmgNGbbgITdThjyRajm5v6j2LIUXUUBegf0hcRONM0hFyf
         1zryn8Rp+uxk9L4ozTOcZClaj/XNu14kEMGiqJCzTWhB6NpXBqJqa1lBXYCEwA4No6Ht
         7rQtX6IuA+HfOaFvDulaQtdZakigMi2z+aAxi0mn1nBzZF5hKaWd4INNQOl2OaDY/+eO
         9h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvU+iMJ040EAhZBl+griq41zsFfJkcAgAfQ0Xr3/uAs=;
        b=SaWM+5sAXgWI5/iyoIHlBDNFnoWpchGSuzTOnkY6UOXMAL7djFuDgI5z0L6LxSMxkD
         oLf5RaqSShGUKUvqqrd1WscImsSr2N6BUFiyUMfBzvzAqDxz6QTKReDGPrURciQfpLuW
         AMXXY2nmcDP5SpweY/UOqlzjWdvvUZbIEn7TBu7epJhBgtuNQCGFm8S8Ljj5meDzj4Sv
         SArAgOJitvZCdCGZNFff8eE8mdjoFuZmqjl3w/i824gzYEEpj6jwPUVstrn6TRT1JDn6
         eMpJXYu9l5LNMu6+XjP+ZtXH+5ebo0Q7sw2RcZD3+R0wOwvYYIJ9CIcHfkkfQokH0rQU
         8ZIQ==
X-Gm-Message-State: APjAAAXGpqZscqCpsxN0SoGvPLLRFlavYL8NPecMVOxSoXity2ur+lSx
        csnh8GEf9VSlRny6B25q98o=
X-Google-Smtp-Source: APXvYqw0r/zInWZu2mdycmchCR8vdzqbuHJZK4bq1qNt7o0nMeSvr/I6vhtXdNbGYxZFIAzVHryj1A==
X-Received: by 2002:a17:906:5fd9:: with SMTP id k25mr12683563ejv.142.1574332659133;
        Thu, 21 Nov 2019 02:37:39 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:38 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 1/9] md: rename wb stuffs
Date:   Thu, 21 Nov 2019 11:37:20 +0100
Message-Id: <20191121103728.18919-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Previously, wb_info_pool and wb_list stuffs are introduced
to address potential data inconsistence issue for write
behind device.

Now rename them to serial related name, since the same
mechanism will be used to address reorder overlap write
issue for raid1.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c | 20 ++++++------
 drivers/md/md.c        | 70 ++++++++++++++++++++++--------------------
 drivers/md/md.h        | 24 +++++++--------
 drivers/md/raid1.c     | 43 +++++++++++++-------------
 4 files changed, 80 insertions(+), 77 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b092c7b5282f..5058716918ef 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1790,8 +1790,8 @@ void md_bitmap_destroy(struct mddev *mddev)
 		return;
 
 	md_bitmap_wait_behind_writes(mddev);
-	mempool_destroy(mddev->wb_info_pool);
-	mddev->wb_info_pool = NULL;
+	mempool_destroy(mddev->serial_info_pool);
+	mddev->serial_info_pool = NULL;
 
 	mutex_lock(&mddev->bitmap_info.mutex);
 	spin_lock(&mddev->lock);
@@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
 		goto out;
 
 	rdev_for_each(rdev, mddev)
-		mddev_create_wb_pool(mddev, rdev, true);
+		mddev_create_serial_pool(mddev, rdev, true);
 
 	if (mddev_is_clustered(mddev))
 		md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
@@ -2475,16 +2475,16 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
 	mddev->bitmap_info.max_write_behind = backlog;
-	if (!backlog && mddev->wb_info_pool) {
-		/* wb_info_pool is not needed if backlog is zero */
-		mempool_destroy(mddev->wb_info_pool);
-		mddev->wb_info_pool = NULL;
-	} else if (backlog && !mddev->wb_info_pool) {
-		/* wb_info_pool is needed since backlog is not zero */
+	if (!backlog && mddev->serial_info_pool) {
+		/* serial_info_pool is not needed if backlog is zero */
+		mempool_destroy(mddev->serial_info_pool);
+		mddev->serial_info_pool = NULL;
+	} else if (backlog && !mddev->serial_info_pool) {
+		/* serial_info_pool is needed since backlog is not zero */
 		struct md_rdev *rdev;
 
 		rdev_for_each(rdev, mddev)
-			mddev_create_wb_pool(mddev, rdev, false);
+			mddev_create_serial_pool(mddev, rdev, false);
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1be7abeb24fd..2a44c1db9061 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -125,72 +125,74 @@ static inline int speed_max(struct mddev *mddev)
 		mddev->sync_speed_max : sysctl_speed_limit_max;
 }
 
-static int rdev_init_wb(struct md_rdev *rdev)
+static int rdev_init_serial(struct md_rdev *rdev)
 {
 	if (rdev->bdev->bd_queue->nr_hw_queues == 1)
 		return 0;
 
-	spin_lock_init(&rdev->wb_list_lock);
-	INIT_LIST_HEAD(&rdev->wb_list);
-	init_waitqueue_head(&rdev->wb_io_wait);
-	set_bit(WBCollisionCheck, &rdev->flags);
+	spin_lock_init(&rdev->serial_list_lock);
+	INIT_LIST_HEAD(&rdev->serial_list);
+	init_waitqueue_head(&rdev->serial_io_wait);
+	set_bit(CollisionCheck, &rdev->flags);
 
 	return 1;
 }
 
 /*
- * Create wb_info_pool if rdev is the first multi-queue device flaged
+ * Create serial_info_pool if rdev is the first multi-queue device flaged
  * with writemostly, also write-behind mode is enabled.
  */
-void mddev_create_wb_pool(struct mddev *mddev, struct md_rdev *rdev,
+void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			  bool is_suspend)
 {
 	if (mddev->bitmap_info.max_write_behind == 0)
 		return;
 
-	if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_wb(rdev))
+	if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_serial(rdev))
 		return;
 
-	if (mddev->wb_info_pool == NULL) {
+	if (mddev->serial_info_pool == NULL) {
 		unsigned int noio_flag;
 
 		if (!is_suspend)
 			mddev_suspend(mddev);
 		noio_flag = memalloc_noio_save();
-		mddev->wb_info_pool = mempool_create_kmalloc_pool(NR_WB_INFOS,
-							sizeof(struct wb_info));
+		mddev->serial_info_pool =
+			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
+						sizeof(struct serial_info));
 		memalloc_noio_restore(noio_flag);
-		if (!mddev->wb_info_pool)
-			pr_err("can't alloc memory pool for writemostly\n");
+		if (!mddev->serial_info_pool)
+			pr_err("can't alloc memory pool for serialization\n");
 		if (!is_suspend)
 			mddev_resume(mddev);
 	}
 }
-EXPORT_SYMBOL_GPL(mddev_create_wb_pool);
+EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
 
 /*
- * destroy wb_info_pool if rdev is the last device flaged with WBCollisionCheck.
+ * Destroy serial_info_pool if rdev is the last device flaged with
+ * CollisionCheck.
  */
-static void mddev_destroy_wb_pool(struct mddev *mddev, struct md_rdev *rdev)
+static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 {
-	if (!test_and_clear_bit(WBCollisionCheck, &rdev->flags))
+	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
 		return;
 
-	if (mddev->wb_info_pool) {
+	if (mddev->serial_info_pool) {
 		struct md_rdev *temp;
 		int num = 0;
 
 		/*
-		 * Check if other rdevs need wb_info_pool.
+		 * Check if other rdevs need serial_info_pool.
 		 */
 		rdev_for_each(temp, mddev)
 			if (temp != rdev &&
-			    test_bit(WBCollisionCheck, &temp->flags))
+			    test_bit(CollisionCheck, &temp->flags))
 				num++;
 		if (!num) {
 			mddev_suspend(rdev->mddev);
-			mempool_destroy(mddev->wb_info_pool);
-			mddev->wb_info_pool = NULL;
+			mempool_destroy(mddev->serial_info_pool);
+			mddev->serial_info_pool = NULL;
 			mddev_resume(rdev->mddev);
 		}
 	}
@@ -2305,7 +2307,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_wb_pool(mddev, rdev, false);
+		mddev_create_serial_pool(mddev, rdev, false);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -2343,7 +2345,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
-	mddev_destroy_wb_pool(rdev->mddev, rdev);
+	mddev_destroy_serial_pool(rdev->mddev, rdev);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2856,10 +2858,10 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		}
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
-		mddev_create_wb_pool(rdev->mddev, rdev, false);
+		mddev_create_serial_pool(rdev->mddev, rdev, false);
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_wb_pool(rdev->mddev, rdev);
+		mddev_destroy_serial_pool(rdev->mddev, rdev);
 		clear_bit(WriteMostly, &rdev->flags);
 		err = 0;
 	} else if (cmd_match(buf, "blocked")) {
@@ -5731,14 +5733,14 @@ int md_run(struct mddev *mddev)
 
 		rdev_for_each(rdev, mddev) {
 			if (test_bit(WriteMostly, &rdev->flags) &&
-			    rdev_init_wb(rdev))
+			    rdev_init_serial(rdev))
 				creat_pool = true;
 		}
-		if (creat_pool && mddev->wb_info_pool == NULL) {
-			mddev->wb_info_pool =
-				mempool_create_kmalloc_pool(NR_WB_INFOS,
-						    sizeof(struct wb_info));
-			if (!mddev->wb_info_pool) {
+		if (creat_pool && mddev->serial_info_pool == NULL) {
+			mddev->serial_info_pool =
+				mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
+						    sizeof(struct serial_info));
+			if (!mddev->serial_info_pool) {
 				err = -ENOMEM;
 				goto bitmap_abort;
 			}
@@ -5983,8 +5985,8 @@ static void __md_stop_writes(struct mddev *mddev)
 			mddev->in_sync = 1;
 		md_update_sb(mddev, 1);
 	}
-	mempool_destroy(mddev->wb_info_pool);
-	mddev->wb_info_pool = NULL;
+	mempool_destroy(mddev->serial_info_pool);
+	mddev->serial_info_pool = NULL;
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index c5e3ff398b59..218950b88af6 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -111,11 +111,11 @@ struct md_rdev {
 					   */
 
 	/*
-	 * The members for check collision of write behind IOs.
+	 * The members for check collision of write IOs.
 	 */
-	struct list_head wb_list;
-	spinlock_t wb_list_lock;
-	wait_queue_head_t wb_io_wait;
+	struct list_head serial_list;
+	spinlock_t serial_list_lock;
+	wait_queue_head_t serial_io_wait;
 
 	struct work_struct del_work;	/* used for delayed sysfs removal */
 
@@ -201,9 +201,9 @@ enum flag_bits {
 				 * it didn't fail, so don't use FailFast
 				 * any more for metadata
 				 */
-	WBCollisionCheck,	/*
-				 * multiqueue device should check if there
-				 * is collision between write behind bios.
+	CollisionCheck,		/*
+				 * check if there is collision between raid1
+				 * serial bios.
 				 */
 };
 
@@ -263,9 +263,9 @@ enum mddev_sb_flags {
 	MD_SB_NEED_REWRITE,	/* metadata write needs to be repeated */
 };
 
-#define NR_WB_INFOS	8
-/* record current range of write behind IOs */
-struct wb_info {
+#define NR_SERIAL_INFOS		8
+/* record current range of serialize IOs */
+struct serial_info {
 	sector_t lo;
 	sector_t hi;
 	struct list_head list;
@@ -487,7 +487,7 @@ struct mddev {
 					  */
 	struct work_struct flush_work;
 	struct work_struct event_work;	/* used by dm to report failure event */
-	mempool_t *wb_info_pool;
+	mempool_t *serial_info_pool;
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
 	struct md_cluster_info		*cluster_info;
 	unsigned int			good_device_nr;	/* good device num within cluster raid */
@@ -737,7 +737,7 @@ extern struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
-extern void mddev_create_wb_pool(struct mddev *mddev, struct md_rdev *rdev,
+extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 				 bool is_suspend);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0466ee2453b4..9d708d0467cc 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -50,17 +50,17 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 
 #include "raid1-10.c"
 
-static int check_and_add_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
+static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
-	struct wb_info *wi, *temp_wi;
+	struct serial_info *wi, *temp_wi;
 	unsigned long flags;
 	int ret = 0;
 	struct mddev *mddev = rdev->mddev;
 
-	wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
+	wi = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
 
-	spin_lock_irqsave(&rdev->wb_list_lock, flags);
-	list_for_each_entry(temp_wi, &rdev->wb_list, list) {
+	spin_lock_irqsave(&rdev->serial_list_lock, flags);
+	list_for_each_entry(temp_wi, &rdev->serial_list, list) {
 		/* collision happened */
 		if (hi > temp_wi->lo && lo < temp_wi->hi) {
 			ret = -EBUSY;
@@ -71,34 +71,34 @@ static int check_and_add_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
 	if (!ret) {
 		wi->lo = lo;
 		wi->hi = hi;
-		list_add(&wi->list, &rdev->wb_list);
+		list_add(&wi->list, &rdev->serial_list);
 	} else
-		mempool_free(wi, mddev->wb_info_pool);
-	spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
+		mempool_free(wi, mddev->serial_info_pool);
+	spin_unlock_irqrestore(&rdev->serial_list_lock, flags);
 
 	return ret;
 }
 
-static void remove_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
+static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
-	struct wb_info *wi;
+	struct serial_info *wi;
 	unsigned long flags;
 	int found = 0;
 	struct mddev *mddev = rdev->mddev;
 
-	spin_lock_irqsave(&rdev->wb_list_lock, flags);
-	list_for_each_entry(wi, &rdev->wb_list, list)
+	spin_lock_irqsave(&rdev->serial_list_lock, flags);
+	list_for_each_entry(wi, &rdev->serial_list, list)
 		if (hi == wi->hi && lo == wi->lo) {
 			list_del(&wi->list);
-			mempool_free(wi, mddev->wb_info_pool);
+			mempool_free(wi, mddev->serial_info_pool);
 			found = 1;
 			break;
 		}
 
 	if (!found)
-		WARN(1, "The write behind IO is not recorded\n");
-	spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
-	wake_up(&rdev->wb_io_wait);
+		WARN(1, "The write IO is not recorded for serialization\n");
+	spin_unlock_irqrestore(&rdev->serial_list_lock, flags);
+	wake_up(&rdev->serial_io_wait);
 }
 
 /*
@@ -499,11 +499,11 @@ static void raid1_end_write_request(struct bio *bio)
 	}
 
 	if (behind) {
-		if (test_bit(WBCollisionCheck, &rdev->flags)) {
+		if (test_bit(CollisionCheck, &rdev->flags)) {
 			sector_t lo = r1_bio->sector;
 			sector_t hi = r1_bio->sector + r1_bio->sectors;
 
-			remove_wb(rdev, lo, hi);
+			remove_serial(rdev, lo, hi);
 		}
 		if (test_bit(WriteMostly, &rdev->flags))
 			atomic_dec(&r1_bio->behind_remaining);
@@ -1507,12 +1507,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		if (r1_bio->behind_master_bio) {
 			struct md_rdev *rdev = conf->mirrors[i].rdev;
 
-			if (test_bit(WBCollisionCheck, &rdev->flags)) {
+			if (test_bit(CollisionCheck, &rdev->flags)) {
 				sector_t lo = r1_bio->sector;
 				sector_t hi = r1_bio->sector + r1_bio->sectors;
 
-				wait_event(rdev->wb_io_wait,
-					   check_and_add_wb(rdev, lo, hi) == 0);
+				wait_event(rdev->serial_io_wait,
+					   check_and_add_serial(rdev, lo, hi)
+					   == 0);
 			}
 			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
-- 
2.17.1

