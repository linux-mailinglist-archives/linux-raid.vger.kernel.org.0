Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABF1293C6
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLWJtT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45393 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfLWJtS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so14743276edw.12
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UfgZek1oQ/aK9kRKA4yjjErFxksJ61fbY2MAQvSkkgs=;
        b=izIU+PmzYCMWk8WraHfrH4z1EUaoqMgqbjP2xqa4/hcEFP+gEy0hZePSKkj1Kf6IBG
         QOrqR8d7BFIvaknMfOXCxHA6VBdUX4hqANd29NwP1UihGyA+U34YTYb0FqzEBAv+Xam/
         qP0SNqwxIY/ipVm5T48zxthTjXYgo71Uj7WRa3ZzRf+mDWnxMa/uc4JlcFizsWfcDjRB
         +GtfTMZkKhe5Vi/e1FbWJY6r6JppB6LurIuN2/jL3ivRhUNxZ295LvjhLI1rCvOxLFCu
         qn8lX3yaCkWXt7ahizPDIZuVsY2+NrB/UTFA7vSmvnOgDTlGkYjWCKzqQ/5BkXUW7E3v
         pX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UfgZek1oQ/aK9kRKA4yjjErFxksJ61fbY2MAQvSkkgs=;
        b=AJ2/YI+HzVVLIZoojYfRYrD71w1YItruUge2zh9ni3mPHpDYini+tOAVLE5jyGavlf
         O7XwevgS/zPhc8FHJjKMYGx0g4FxeqBSDZMK2QlozSKTYYNUHegYb2T8VkIgvTLyBGrM
         tEXRgxFTvedJTEUlDtIsi4gZpqCKed878/zzNEj4eHWVS8SQS66EYBuuGyCOudM3OZ6H
         58OHL+/jyGW/xeaA45Xb1nNCarIonrPIkEhcLjq0PFhyE9XphIS6FByQKe8VvbwdL9rd
         WEUKxqDbgJ+4twCNn8kcJMpPay78tZkfcz9mM3YbLUzEgfeH+Sgh2iKV0Q/z9zhCO8CG
         s9OQ==
X-Gm-Message-State: APjAAAVq0WJyhM6JLABFjV2QOQTmSzd+H61Pqh/5q8svFtl3JW9vHiKJ
        M0szz2HYfd/gIY375rZPq7Q=
X-Google-Smtp-Source: APXvYqzOb2paFWT+X/8CZWs423PHFGy8YAp0lUR4bfvB2KdlKymzRkQRjg8IrmFsM0vr3Kix7ZatBA==
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr31342235ejm.200.1577094556132;
        Mon, 23 Dec 2019 01:49:16 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:15 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 08/10] md: introduce a new struct for IO serialization
Date:   Mon, 23 Dec 2019 10:49:00 +0100
Message-Id: <20191223094902.12704-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Obviously, IO serialization could cause the degradation of
performance a lot. In order to reduce the degradation, so a
rb interval tree is added in raid1 to speed up the check of
collision.

So, a rb root is needed in md_rdev, then abstract all the
serialize related members to a new struct (serial_in_rdev),
embed it into md_rdev.

Of course, we need to free the struct if it is not needed
anymore, so rdev/rdevs_uninit_serial are added accordingly.
And they should be called when destroty memory pool or can't
alloc memory.

And we need to consider to call mddev_destroy_serial_pool
in case serialize_policy/write-behind is disabled, bitmap
is destroyed or in __md_stop_writes.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c | 12 +++----
 drivers/md/md.c        | 80 ++++++++++++++++++++++++++++++++----------
 drivers/md/md.h        | 26 +++++++++-----
 drivers/md/raid1.c     | 61 +++++++++++++++++---------------
 4 files changed, 116 insertions(+), 63 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 5dcf23837f1b..387a35a81ecb 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1790,10 +1790,8 @@ void md_bitmap_destroy(struct mddev *mddev)
 		return;
 
 	md_bitmap_wait_behind_writes(mddev);
-	if (!mddev->serialize_policy) {
-		mempool_destroy(mddev->serial_info_pool);
-		mddev->serial_info_pool = NULL;
-	}
+	if (!mddev->serialize_policy)
+		mddev_destroy_serial_pool(mddev, NULL, true);
 
 	mutex_lock(&mddev->bitmap_info.mutex);
 	spin_lock(&mddev->lock);
@@ -2479,10 +2477,8 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	mddev->bitmap_info.max_write_behind = backlog;
 	if (!backlog && mddev->serial_info_pool) {
 		/* serial_info_pool is not needed if backlog is zero */
-		if (!mddev->serialize_policy) {
-			mempool_destroy(mddev->serial_info_pool);
-			mddev->serial_info_pool = NULL;
-		}
+		if (!mddev->serialize_policy)
+			mddev_destroy_serial_pool(mddev, NULL, false);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
 		struct md_rdev *rdev;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 788559f42d43..9c4e61c988ac 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -125,25 +125,59 @@ static inline int speed_max(struct mddev *mddev)
 		mddev->sync_speed_max : sysctl_speed_limit_max;
 }
 
+static void rdev_uninit_serial(struct md_rdev *rdev)
+{
+	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
+		return;
+
+	kfree(rdev->serial);
+	rdev->serial = NULL;
+}
+
+static void rdevs_uninit_serial(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev)
+		rdev_uninit_serial(rdev);
+}
+
 static int rdev_init_serial(struct md_rdev *rdev)
 {
-	spin_lock_init(&rdev->serial_list_lock);
-	INIT_LIST_HEAD(&rdev->serial_list);
-	init_waitqueue_head(&rdev->serial_io_wait);
+	struct serial_in_rdev *serial = NULL;
+
+	if (test_bit(CollisionCheck, &rdev->flags))
+		return 0;
+
+	serial = kmalloc(sizeof(struct serial_in_rdev), GFP_KERNEL);
+	if (!serial)
+		return -ENOMEM;
+
+	spin_lock_init(&serial->serial_lock);
+	serial->serial_rb = RB_ROOT_CACHED;
+	init_waitqueue_head(&serial->serial_io_wait);
+	rdev->serial = serial;
 	set_bit(CollisionCheck, &rdev->flags);
 
-	return 1;
+	return 0;
 }
 
-static void rdevs_init_serial(struct mddev *mddev)
+static int rdevs_init_serial(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
+	int ret = 0;
 
 	rdev_for_each(rdev, mddev) {
-		if (test_bit(CollisionCheck, &rdev->flags))
-			continue;
-		rdev_init_serial(rdev);
+		ret = rdev_init_serial(rdev);
+		if (ret)
+			break;
 	}
+
+	/* Free all resources if pool is not existed */
+	if (ret && !mddev->serial_info_pool)
+		rdevs_uninit_serial(mddev);
+
+	return ret;
 }
 
 /*
@@ -166,6 +200,8 @@ static int rdev_need_serial(struct md_rdev *rdev)
 void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			      bool is_suspend)
 {
+	int ret = 0;
+
 	if (rdev && !rdev_need_serial(rdev) &&
 	    !test_bit(CollisionCheck, &rdev->flags))
 		return;
@@ -174,9 +210,11 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		mddev_suspend(mddev);
 
 	if (!rdev)
-		rdevs_init_serial(mddev);
+		ret = rdevs_init_serial(mddev);
 	else
-		rdev_init_serial(rdev);
+		ret = rdev_init_serial(rdev);
+	if (ret)
+		goto abort;
 
 	if (mddev->serial_info_pool == NULL) {
 		unsigned int noio_flag;
@@ -186,9 +224,13 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
 						sizeof(struct serial_info));
 		memalloc_noio_restore(noio_flag);
-		if (!mddev->serial_info_pool)
+		if (!mddev->serial_info_pool) {
+			rdevs_uninit_serial(mddev);
 			pr_err("can't alloc memory pool for serialization\n");
+		}
 	}
+
+abort:
 	if (!is_suspend)
 		mddev_resume(mddev);
 }
@@ -199,8 +241,8 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
  * 2. when bitmap is destroyed while policy is not enabled.
  * 3. for disable policy, the pool is destroyed only when no rdev needs it.
  */
-static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				      bool is_suspend)
+void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+			       bool is_suspend)
 {
 	if (rdev && !test_bit(CollisionCheck, &rdev->flags))
 		return;
@@ -213,8 +255,9 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mddev_suspend(mddev);
 		rdev_for_each(temp, mddev) {
 			if (!rdev) {
-				if (!rdev_need_serial(temp))
-					clear_bit(CollisionCheck, &temp->flags);
+				if (!mddev->serialize_policy ||
+				    !rdev_need_serial(temp))
+					rdev_uninit_serial(temp);
 				else
 					num++;
 			} else if (temp != rdev &&
@@ -223,7 +266,7 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		}
 
 		if (rdev)
-			clear_bit(CollisionCheck, &rdev->flags);
+			rdev_uninit_serial(rdev);
 
 		if (num)
 			pr_info("The mempool could be used by other devices\n");
@@ -6117,8 +6160,9 @@ static void __md_stop_writes(struct mddev *mddev)
 			mddev->in_sync = 1;
 		md_update_sb(mddev, 1);
 	}
-	mempool_destroy(mddev->serial_info_pool);
-	mddev->serial_info_pool = NULL;
+	/* disable policy to guarantee rdevs free resources for serialization */
+	mddev->serialize_policy = 0;
+	mddev_destroy_serial_pool(mddev, NULL, true);
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index f51a3afaee1b..acd681939112 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -32,6 +32,16 @@
  * be retried.
  */
 #define	MD_FAILFAST	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT)
+
+/*
+ * The struct embedded in rdev is used to serialize IO.
+ */
+struct serial_in_rdev {
+	struct rb_root_cached serial_rb;
+	spinlock_t serial_lock;
+	wait_queue_head_t serial_io_wait;
+};
+
 /*
  * MD's 'extended' device
  */
@@ -110,12 +120,7 @@ struct md_rdev {
 					   * in superblock.
 					   */
 
-	/*
-	 * The members for check collision of write IOs.
-	 */
-	struct list_head serial_list;
-	spinlock_t serial_list_lock;
-	wait_queue_head_t serial_io_wait;
+	struct serial_in_rdev *serial;  /* used for raid1 io serialization */
 
 	struct work_struct del_work;	/* used for delayed sysfs removal */
 
@@ -266,9 +271,10 @@ enum mddev_sb_flags {
 #define NR_SERIAL_INFOS		8
 /* record current range of serialize IOs */
 struct serial_info {
-	sector_t lo;
-	sector_t hi;
-	struct list_head list;
+	struct rb_node node;
+	sector_t start;		/* start sector of rb node */
+	sector_t last;		/* end sector of rb node */
+	sector_t _subtree_last; /* highest sector in subtree of rb node */
 };
 
 struct mddev {
@@ -740,6 +746,8 @@ extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
 extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 				     bool is_suspend);
+extern void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+				      bool is_suspend);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3ad2f5a59d08..5c6a03747448 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
+#include <linux/interval_tree_generic.h>
 
 #include <trace/events/block.h>
 
@@ -50,55 +51,58 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 
 #include "raid1-10.c"
 
+#define START(node) ((node)->start)
+#define LAST(node) ((node)->last)
+INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, _subtree_last,
+		     START, LAST, static inline, raid1_rb);
+
 static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
-	struct serial_info *wi, *temp_wi;
+	struct serial_info *si;
 	unsigned long flags;
 	int ret = 0;
 	struct mddev *mddev = rdev->mddev;
+	struct serial_in_rdev *serial = rdev->serial;
 
-	wi = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
-
-	spin_lock_irqsave(&rdev->serial_list_lock, flags);
-	list_for_each_entry(temp_wi, &rdev->serial_list, list) {
-		/* collision happened */
-		if (hi > temp_wi->lo && lo < temp_wi->hi) {
-			ret = -EBUSY;
-			break;
-		}
-	}
+	si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
 
+	spin_lock_irqsave(&serial->serial_lock, flags);
+	/* collision happened */
+	if (raid1_rb_iter_first(&serial->serial_rb, lo, hi))
+		ret = -EBUSY;
 	if (!ret) {
-		wi->lo = lo;
-		wi->hi = hi;
-		list_add(&wi->list, &rdev->serial_list);
+		si->start = lo;
+		si->last = hi;
+		raid1_rb_insert(si, &serial->serial_rb);
 	} else
-		mempool_free(wi, mddev->serial_info_pool);
-	spin_unlock_irqrestore(&rdev->serial_list_lock, flags);
+		mempool_free(si, mddev->serial_info_pool);
+	spin_unlock_irqrestore(&serial->serial_lock, flags);
 
 	return ret;
 }
 
 static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
-	struct serial_info *wi;
+	struct serial_info *si;
 	unsigned long flags;
 	int found = 0;
 	struct mddev *mddev = rdev->mddev;
-
-	spin_lock_irqsave(&rdev->serial_list_lock, flags);
-	list_for_each_entry(wi, &rdev->serial_list, list)
-		if (hi == wi->hi && lo == wi->lo) {
-			list_del(&wi->list);
-			mempool_free(wi, mddev->serial_info_pool);
+	struct serial_in_rdev *serial = rdev->serial;
+
+	spin_lock_irqsave(&serial->serial_lock, flags);
+	for (si = raid1_rb_iter_first(&serial->serial_rb, lo, hi);
+	     si; si = raid1_rb_iter_next(si, lo, hi)) {
+		if (si->start == lo && si->last == hi) {
+			raid1_rb_remove(si, &serial->serial_rb);
+			mempool_free(si, mddev->serial_info_pool);
 			found = 1;
 			break;
 		}
-
+	}
 	if (!found)
 		WARN(1, "The write IO is not recorded for serialization\n");
-	spin_unlock_irqrestore(&rdev->serial_list_lock, flags);
-	wake_up(&rdev->serial_io_wait);
+	spin_unlock_irqrestore(&serial->serial_lock, flags);
+	wake_up(&serial->serial_io_wait);
 }
 
 /*
@@ -1482,6 +1486,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
 		struct md_rdev *rdev = conf->mirrors[i].rdev;
+		struct serial_in_rdev *serial = rdev->serial;
 		if (!r1_bio->bios[i])
 			continue;
 
@@ -1510,13 +1515,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 		if (r1_bio->behind_master_bio) {
 			if (test_bit(CollisionCheck, &rdev->flags))
-				wait_event(rdev->serial_io_wait,
+				wait_event(serial->serial_io_wait,
 					   check_and_add_serial(rdev, lo, hi)
 					   == 0);
 			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
 		} else if (mddev->serialize_policy)
-			wait_event(rdev->serial_io_wait,
+			wait_event(serial->serial_io_wait,
 				   check_and_add_serial(rdev, lo, hi) == 0);
 
 		r1_bio->bios[i] = mbio;
-- 
2.17.1

