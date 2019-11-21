Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364A51050A7
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUKhs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46903 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKUKhr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id t11so2304591eds.13
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=66MThcgY8kEcOHHYtkrKt8xx3Yq7ShQ2pxQfU+C7Gqs=;
        b=bh2cZUslus+/Jcjqr7fG7XlrVB1AjEdeCimkmBQ/Hl7ZkwL54iqtKWO7XyLucSKTXH
         HJQwGTf10DBMr5K8ClJZUgp3YJn+MyxLwaRlXeoDTmQE2xqSWFzmZpuUSyOp7ZAGzbLv
         CWrLJDIWu0D50+wl0SQAh5nq7Zp7IhajJb413pbZsEKh1R961SW+IFlWJ6tMFu/UsFgo
         fDAELiet6YNF+JLuQvgMGHi5lagK56MzUHPylEfQmJCRnGLKoBSL3ckq1L//yZFKkYss
         2l7a2rKbId8X5c6fNveZF/gyznXS1u88WITX8EfutejQ6fKlKO9XO/VVmZ9KP505lD8B
         cQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=66MThcgY8kEcOHHYtkrKt8xx3Yq7ShQ2pxQfU+C7Gqs=;
        b=iU9fACx+cuYmqvB4UUnRk+8uVYcuE9thjATDXBOX0iQufEHckCIp8hX2QzZdPXejJN
         mFFadAZ7V8kxOr5+FmHQfaHSXyEL881jYqhiof2uvBOfFy1mKx8FUjQB4MGuT6yTIGhb
         J6tTXWZbMbeLpHKWBMz5JPQyEHGkGIatOMNXWbRKoqGm6u50K6CndsaO2HDj5WvaE8E4
         68kNZz1A5HiBrqFkQadVx/99affjp4vFGumEY9/DA5fDsYsj9Kmf56Q7WYusFhgMGx6j
         tSvn9BDWiFnZdNyl2fwPppj/Pl2LaYgp56FdbJrJM9enSpA+e4joO4fX6Ufn9q97/Cip
         qC8A==
X-Gm-Message-State: APjAAAU/PPpt0/qPIGH3ZXdHM+4Q3He+pozVyrTEZCExPYHroj/3qZ6C
        Tkzvw2xj/witea+wZgxejm8=
X-Google-Smtp-Source: APXvYqy/1e4jMiwP82dJZ5FReypyQqrtC/Q5qiKbaXaQWtYP9EZECiBCar0xDWZtbLlKbcamkxquFQ==
X-Received: by 2002:a17:906:2e52:: with SMTP id r18mr13152225eji.178.1574332664237;
        Thu, 21 Nov 2019 02:37:44 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:43 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 7/9] md: introduce a new struct for IO serialization
Date:   Thu, 21 Nov 2019 11:37:26 +0100
Message-Id: <20191121103728.18919-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
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
index 63f819de2361..c2069898bd30 100644
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
+		mddev_destroy_serial_pool(mddev, NULL, true, true);
 
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
+			mddev_destroy_serial_pool(mddev, NULL, false, true);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
 		struct md_rdev *rdev;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c352b48434bf..4eb4b4c99248 100644
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
 			      bool is_suspend, bool is_force)
 {
+	int ret = 0;
+
 	if (!is_force && !rdev_need_serial(rdev) &&
 	    !test_bit(CollisionCheck, &rdev->flags))
 		return;
@@ -174,9 +210,12 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		mddev_suspend(mddev);
 
 	if (is_force)
-		rdevs_init_serial(mddev);
+		ret = rdevs_init_serial(mddev);
 	else
-		rdev_init_serial(rdev);
+		ret = rdev_init_serial(rdev);
+	if (ret)
+		goto abort;
+
 	if (mddev->serial_info_pool == NULL) {
 		unsigned int noio_flag;
 
@@ -185,10 +224,13 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
 						sizeof(struct serial_info));
 		memalloc_noio_restore(noio_flag);
-		if (!mddev->serial_info_pool)
+		if (!mddev->serial_info_pool) {
+			rdevs_uninit_serial(mddev);
 			pr_err("can't alloc memory pool for serialization\n");
+		}
 	}
 
+abort:
 	if (!is_suspend)
 		mddev_resume(mddev);
 }
@@ -199,8 +241,8 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
  * 2. when bitmap is destroyed while policy is not enabled.
  * 3. for disable policy, the pool is destroyed only when no rdev needs it.
  */
-static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				      bool is_suspend, bool is_force)
+void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+			       bool is_suspend, bool is_force)
 {
 	if (!(is_force || test_bit(CollisionCheck, &rdev->flags)))
 		return;
@@ -213,8 +255,9 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mddev_suspend(mddev);
 		rdev_for_each(temp, mddev) {
 			if (is_force) {
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
 
 		if (!is_force && rdev)
-			clear_bit(CollisionCheck, &rdev->flags);
+			rdev_uninit_serial(rdev);
 
 		if (num)
 			pr_info("The mempool could be used by other devices\n");
@@ -6076,8 +6119,9 @@ static void __md_stop_writes(struct mddev *mddev)
 			mddev->in_sync = 1;
 		md_update_sb(mddev, 1);
 	}
-	mempool_destroy(mddev->serial_info_pool);
-	mddev->serial_info_pool = NULL;
+	/* disable policy to guarantee rdevs free resources for serialization */
+	mddev->serialize_policy = 0;
+	mddev_destroy_serial_pool(mddev, NULL, true, true);
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b2cdc13f0511..22444c87c289 100644
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
 				     bool is_suspend, bool is_force);
+extern void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+				      bool is_suspend, bool is_force);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4f683a3d44c0..50d767240c8b 100644
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
@@ -1481,6 +1485,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
 		struct md_rdev *rdev = conf->mirrors[i].rdev;
+		struct serial_in_rdev *serial = rdev->serial;
 		if (!r1_bio->bios[i])
 			continue;
 
@@ -1509,13 +1514,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
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

