Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E865AEC495
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKAOXS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42507 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKAOXS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id m13so1344212edv.9
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5cTAtS3Rkg8KYV/bJtn94EguU+Jy8X9iJq3GHKQxK8=;
        b=TTKt1gKnjYkjLOOkhn1LXt8dG6feb1XinzBIXrl3f2UFdgNzDurrbW3PGCdWiHZP6o
         knfAt5Fnh7636NdX7/L4rqlwIq7c3ujT5OBrxFbkSWd+s68EDwXd5o1YEiuAUSwGc/O7
         1J4CIOsU5h03KWzK/uCmBFBj+sDpFngEET4CxjXOod+Lck6bgdcd4wAOuM3DRUtPboPh
         9e8zQsZbAraxJPAIDzu+vzShcOSsDIpYteYs7+vAABcH28dW/5r4Zq+5cxSsOqrbsRGS
         kVNk/IqgtEGPCxmMZHQKeftKqgKHGGzUe4+OoKSuI4NroVvoNaFnyEUQeG/gAdo2c9fK
         N+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5cTAtS3Rkg8KYV/bJtn94EguU+Jy8X9iJq3GHKQxK8=;
        b=MlKyAxw8DN31/RTcA7Xl5lkP/2luQ80xRHoe9aJOWOpZmWnTM16ibmAKt71ELz5NpZ
         80ebPdDTsOdX3y5UNx3OH54h1WzinHrGi9/bqnaJTKRknmR2Thdqhmm4cAZjfbkGPJDu
         pbzedXYok8/fCuxL0ae20OqfGneAWPGdx3YVf7ZiLcCCrZrcTbmwOURTDQCCrPRHeRzn
         MMNOqH5d3f27PM3YhSzjFrEi7/3YOHAjuY9ROMeWahzyPWymhutbwzL9dKc8eV5bRXEC
         V7UuEflccjN0PsmBicVlT/xcqfGr6C7HImZXohr7IOjbebaE9qA/9fvK6Czuy6q216DM
         ZVrg==
X-Gm-Message-State: APjAAAX8fnGtaoA5DJ/+ajuhM34z/JWpx2A5uB3dVmH+SlcDHHbYyJ25
        6C6KA55TfLjpF3JdN7wdzDPv6wXP
X-Google-Smtp-Source: APXvYqyNAfMA/3wI7spipwH9uZnP5H4Xt+hwRIM9AtFQ+j2q7wiLRArPkutN14yjZSBXCwu34YfQEQ==
X-Received: by 2002:aa7:c942:: with SMTP id h2mr13577991edt.238.1572618194758;
        Fri, 01 Nov 2019 07:23:14 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:13 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 7/8] md/raid1: use bucket based mechanism for IO serialization
Date:   Fri,  1 Nov 2019 15:22:30 +0100
Message-Id: <20191101142231.23359-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since raid1 had already used bucket based mechanism to reduce
the conflict between write IO and resync IO, it is possible to
speed up performance for io serialization with refer to the
same mechanism.

To align with the barrier bucket mechanism, we created arrays
(with the same number of BARRIER_BUCKETS_NR) for spinlock, rb
tree and waitqueue. Then we can reduce lock competition with
multiple spinlocks, boost search performance with multiple rb
trees and also reduce thundering herd problem with multiple
waitqueues.

Of course, we need to deal with below conditions:
1. Handle the failure of memory allocation since more memory
are needed. So the two functions (rdev_uninit_serial and
rdevs_uninit_serial) are introduced.

2. Free those allocated memory when serialization is disabled.
Which means mddev_destroy_serial_pool is also need when backlog
is cleared, write is stopped or bitmap is destroyed, so add
is_suspend parameter to mddev_destroy_serial_pool to make it
fits in all cases.

Also no need to export mddev_create_serial_pool since it is
only called in md-mod module.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c |  12 ++---
 drivers/md/md.c        | 114 ++++++++++++++++++++++++++++++++---------
 drivers/md/md.h        |   8 +--
 drivers/md/raid1.c     |  25 +++++----
 4 files changed, 114 insertions(+), 45 deletions(-)

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
index 6d0e076f8099..094ea55fd4db 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -125,22 +125,83 @@ static inline int speed_max(struct mddev *mddev)
 		mddev->sync_speed_max : sysctl_speed_limit_max;
 }
 
+static void rdev_uninit_serial(struct md_rdev *rdev)
+{
+	if (rdev->serial_rb_lock) {
+		kvfree(rdev->serial_rb_lock);
+		rdev->serial_rb_lock = NULL;
+	}
+
+	if (rdev->serial_io_wait) {
+		kvfree(rdev->serial_io_wait);
+		rdev->serial_io_wait = NULL;
+	}
+
+	if (rdev->serial_rb) {
+		kvfree(rdev->serial_rb);
+		rdev->serial_rb = NULL;
+	}
+	clear_bit(CollisionCheck, &rdev->flags);
+}
+
+/*
+ * returns 0 for success, otherwise return -1 if can't get enough memory
+ */
 static int rdev_init_serial(struct md_rdev *rdev)
 {
-	spin_lock_init(&rdev->serial_rb_lock);
-	rdev->serial_rb = RB_ROOT;
-	init_waitqueue_head(&rdev->serial_io_wait);
+	/* serial_nums equals with BARRIER_BUCKETS_NR */
+	int serial_nums = 1 << ((PAGE_SHIFT - ilog2(sizeof(atomic_t))));
+	int i;
+
+	rdev->serial_rb =
+		kvmalloc(sizeof(struct rb_root) * serial_nums, GFP_KERNEL);
+	rdev->serial_io_wait =
+		kvmalloc(sizeof(wait_queue_head_t) * serial_nums, GFP_KERNEL);
+	rdev->serial_rb_lock =
+		kvmalloc(sizeof(spinlock_t) * serial_nums, GFP_KERNEL);
+
+	if (!rdev->serial_rb_lock || !rdev->serial_rb
+				  || !rdev->serial_io_wait) {
+		pr_err("can't alloc memory for IO serialization\n");
+		rdev_uninit_serial(rdev);
+		return -1;
+	}
+
+	for (i = 0; i < serial_nums; i++) {
+		spin_lock_init(&rdev->serial_rb_lock[i]);
+		rdev->serial_rb[i] = RB_ROOT;
+		init_waitqueue_head(&rdev->serial_io_wait[i]);
+	}
 	set_bit(CollisionCheck, &rdev->flags);
 
-	return 1;
+	return 0;
 }
 
-static void rdevs_init_serial(struct mddev *mddev)
+static void rdevs_uninit_serial(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
 
 	rdev_for_each(rdev, mddev)
-		rdev_init_serial(rdev);
+		rdev_uninit_serial(rdev);
+}
+
+/*
+ * It has the same return value as rdev_init_serial.
+ */
+static int rdevs_init_serial(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+	int ret = 0;
+
+	rdev_for_each(rdev, mddev) {
+		ret = rdev_init_serial(rdev);
+		if (ret) {
+			rdevs_uninit_serial(mddev);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 /*
@@ -160,13 +221,17 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 
 	if (mddev->serial_info_pool == NULL) {
 		unsigned int noio_flag;
+		int ret = 0;
 
 		if (!is_suspend)
 			mddev_suspend(mddev);
 		if (is_force)
-			rdevs_init_serial(mddev);
+			ret = rdevs_init_serial(mddev);
 		if (!is_force && rdev)
-			rdev_init_serial(rdev);
+			ret = rdev_init_serial(rdev);
+		if (ret)
+			/* abort earlier due to limited memory */
+			goto abort;
 		noio_flag = memalloc_noio_save();
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
@@ -175,6 +240,7 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		if (!mddev->serial_info_pool)
 			pr_err("can't alloc memory pool for writemostly\n");
 		mddev->serialize_policy = true;
+abort:
 		if (!is_suspend)
 			mddev_resume(mddev);
 	}
@@ -186,8 +252,8 @@ EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
  * CollisionCheck, or is_force is true when we disable serialization
  * for normal raid1.
  */
-static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				      bool is_force)
+void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+			       bool is_suspend, bool is_force)
 {
 	if (!(is_force || test_bit(CollisionCheck, &rdev->flags)))
 		return;
@@ -199,26 +265,29 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		/*
 		 * Check if other rdevs need serial_info_pool.
 		 */
-		mddev_suspend(mddev);
+		if (!is_suspend)
+			mddev_suspend(mddev);
 		rdev_for_each(temp, mddev) {
-			if (is_force) {
-				clear_bit(CollisionCheck, &temp->flags);
-				continue;
-			}
+			if (is_force)
+				break;
 
 			if (temp != rdev &&
 			    test_bit(CollisionCheck, &temp->flags))
 				num++;
 		}
 
-		if (!is_force)
-			clear_bit(CollisionCheck, &rdev->flags);
+		if (is_force)
+			rdevs_uninit_serial(mddev);
+		else
+			rdev_uninit_serial(rdev);
+
 		if (is_force || !num) {
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
 		}
 		mddev->serialize_policy = false;
-		mddev_resume(mddev);
+		if (!is_suspend)
+			mddev_resume(mddev);
 	}
 }
 
@@ -2369,7 +2438,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
-	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+	mddev_destroy_serial_pool(rdev->mddev, rdev, false, false);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2885,7 +2954,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		mddev_create_serial_pool(rdev->mddev, rdev, false, false);
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+		mddev_destroy_serial_pool(rdev->mddev, rdev, false, false);
 		clear_bit(WriteMostly, &rdev->flags);
 		err = 0;
 	} else if (cmd_match(buf, "blocked")) {
@@ -5295,7 +5364,7 @@ serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
 	if (value)
 		mddev_create_serial_pool(mddev, NULL, false, true);
 	else
-		mddev_destroy_serial_pool(mddev, NULL, true);
+		mddev_destroy_serial_pool(mddev, NULL, false, true);
 unlock:
 	mddev_unlock(mddev);
 	return err ?: len;
@@ -6053,8 +6122,7 @@ static void __md_stop_writes(struct mddev *mddev)
 			mddev->in_sync = 1;
 		md_update_sb(mddev, 1);
 	}
-	mempool_destroy(mddev->serial_info_pool);
-	mddev->serial_info_pool = NULL;
+	mddev_destroy_serial_pool(mddev, NULL, true, true);
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index eeceb79ae226..740af6b268a1 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -113,9 +113,9 @@ struct md_rdev {
 	/*
 	 * The members for check collision of write behind IOs.
 	 */
-	struct rb_root serial_rb;
-	spinlock_t serial_rb_lock;
-	wait_queue_head_t serial_io_wait;
+	struct rb_root *serial_rb;
+	spinlock_t *serial_rb_lock;
+	wait_queue_head_t *serial_io_wait;
 
 	struct work_struct del_work;	/* used for delayed sysfs removal */
 
@@ -741,6 +741,8 @@ extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
 extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 				     bool is_suspend, bool is_force);
+extern void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+				      bool is_suspend, bool is_force);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 48e7cd8f26a8..08568edc1c5d 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -165,21 +165,22 @@ static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 	int ret = 0;
 	unsigned long size = (hi - lo) << 9;
 	struct mddev *mddev = rdev->mddev;
+	int idx = sector_to_idx(lo);
 
 	wi = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
 
-	spin_lock_irqsave(&rdev->serial_rb_lock, flags);
+	spin_lock_irqsave(&rdev->serial_rb_lock[idx], flags);
 	/* collision happened */
-	if (find_overlap(&rdev->serial_rb, lo, size))
+	if (find_overlap(&rdev->serial_rb[idx], lo, size))
 		ret = -EBUSY;
 
 	if (!ret) {
 		wi->sector = lo;
 		wi->size = size;
-		insert_interval(&rdev->serial_rb, wi);
+		insert_interval(&rdev->serial_rb[idx], wi);
 	} else
 		mempool_free(wi, mddev->serial_info_pool);
-	spin_unlock_irqrestore(&rdev->serial_rb_lock, flags);
+	spin_unlock_irqrestore(&rdev->serial_rb_lock[idx], flags);
 
 	return ret;
 }
@@ -190,17 +191,18 @@ static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 	unsigned long flags;
 	struct mddev *mddev = rdev->mddev;
 	unsigned long size = (hi - lo) << 9;
+	int idx = sector_to_idx(lo);
 
-	spin_lock_irqsave(&rdev->serial_rb_lock, flags);
-	wi = contains_interval(&rdev->serial_rb, lo, size);
+	spin_lock_irqsave(&rdev->serial_rb_lock[idx], flags);
+	wi = contains_interval(&rdev->serial_rb[idx], lo, size);
 	if (wi) {
-		remove_interval(&rdev->serial_rb, wi);
+		remove_interval(&rdev->serial_rb[idx], wi);
 		RB_CLEAR_NODE(&wi->rb);
 		mempool_free(wi, mddev->serial_info_pool);
 	} else
 		WARN(1, "The write IO is not recorded for serialization\n");
-	spin_unlock_irqrestore(&rdev->serial_rb_lock, flags);
-	wake_up(&rdev->serial_io_wait);
+	spin_unlock_irqrestore(&rdev->serial_rb_lock[idx], flags);
+	wake_up(&rdev->serial_io_wait[idx]);
 }
 
 /*
@@ -1438,6 +1440,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	int first_clone;
 	int max_sectors;
 	sector_t lo, hi;
+	int idx = sector_to_idx(bio->bi_iter.bi_sector);
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1611,13 +1614,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 		if (r1_bio->behind_master_bio) {
 			if (test_bit(CollisionCheck, &rdev->flags))
-				wait_event(rdev->serial_io_wait,
+				wait_event(rdev->serial_io_wait[idx],
 					   check_and_add_serial(rdev, lo, hi)
 					   == 0);
 			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
 		} else if (mddev->serialize_policy)
-			wait_event(rdev->serial_io_wait,
+			wait_event(rdev->serial_io_wait[idx],
 				   check_and_add_serial(rdev, lo, hi) == 0);
 
 		r1_bio->bios[i] = mbio;
-- 
2.17.1

