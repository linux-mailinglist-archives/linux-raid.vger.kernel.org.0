Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12824B4AD
	for <lists+linux-raid@lfdr.de>; Wed, 19 Jun 2019 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfFSJKh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Jun 2019 05:10:37 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:48344 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbfFSJKh (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Wed, 19 Jun 2019 05:10:37 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 19 Jun 2019 03:10:29 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     liu.song.a23@gmail.com, Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH 1/5 V2] md/raid1: fix potential data inconsistency issue with write behind device
Date:   Wed, 19 Jun 2019 17:30:46 +0800
Message-Id: <20190619093046.14066-1-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190614091039.32461-2-gqjiang@suse.com>
References: <20190614091039.32461-2-gqjiang@suse.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For write-behind mode, we think write IO is complete once it has
reached all the non-writemostly devices. It works fine for single
queue devices.

But for multiqueue device, if there are lots of IOs come from upper
layer, then the write-behind device could issue those IOs to different
queues, depends on the each queue's delay, so there is no guarantee
that those IOs can arrive in order.

To address the issue, we need to check the collision among write
behind IOs, we can only continue without collision, otherwise wait
for the completion of previous collisioned IO.

And WBCollision is introduced for multiqueue device which is worked
under write-behind mode.

But this patch doesn't handle below cases which could have the data
inconsistency issue as well, these cases will be handled in later
patches.

1. modify max_write_behind by write backlog node.
2. add or remove array's bitmap dynamically.
3. the change of member disk.

Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
V2 Changes:
1. use temp_wi in list_for_each_entry, thanks for Song's review. 

 drivers/md/md.c    | 41 ++++++++++++++++++++++++++++++++
 drivers/md/md.h    | 21 +++++++++++++++++
 drivers/md/raid1.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 45ffa23fa85d..3f816e4d4dd8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -131,6 +131,19 @@ static inline int speed_max(struct mddev *mddev)
 		mddev->sync_speed_max : sysctl_speed_limit_max;
 }
 
+static int rdev_init_wb(struct md_rdev *rdev)
+{
+	if (rdev->bdev->bd_queue->nr_hw_queues == 1)
+		return 0;
+
+	spin_lock_init(&rdev->wb_list_lock);
+	INIT_LIST_HEAD(&rdev->wb_list);
+	init_waitqueue_head(&rdev->wb_io_wait);
+	set_bit(WBCollisionCheck, &rdev->flags);
+
+	return 1;
+}
+
 static struct ctl_table_header *raid_table_header;
 
 static struct ctl_table raid_table[] = {
@@ -5604,6 +5617,32 @@ int md_run(struct mddev *mddev)
 		md_bitmap_destroy(mddev);
 		goto abort;
 	}
+
+	if (mddev->bitmap_info.max_write_behind > 0) {
+		bool creat_pool = false;
+
+		rdev_for_each(rdev, mddev) {
+			if (test_bit(WriteMostly, &rdev->flags) &&
+			    rdev_init_wb(rdev))
+				creat_pool = true;
+		}
+		if (creat_pool && mddev->wb_info_pool == NULL) {
+			mddev->wb_info_pool =
+				mempool_create_kmalloc_pool(NR_WB_INFOS,
+						    sizeof(struct wb_info));
+			if (!mddev->wb_info_pool) {
+				err = -ENOMEM;
+				mddev_detach(mddev);
+				if (mddev->private)
+					pers->free(mddev, mddev->private);
+				mddev->private = NULL;
+				module_put(pers->owner);
+				md_bitmap_destroy(mddev);
+				goto abort;
+			}
+		}
+	}
+
 	if (mddev->queue) {
 		bool nonrot = true;
 
@@ -5833,6 +5872,8 @@ static void __md_stop_writes(struct mddev *mddev)
 			mddev->in_sync = 1;
 		md_update_sb(mddev, 1);
 	}
+	mempool_destroy(mddev->wb_info_pool);
+	mddev->wb_info_pool = NULL;
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 257cb4c9e22b..ce9eb6db0538 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -116,6 +116,14 @@ struct md_rdev {
 					   * for reporting to userspace and storing
 					   * in superblock.
 					   */
+
+	/*
+	 * The members for check collision of write behind IOs.
+	 */
+	struct list_head wb_list;
+	spinlock_t wb_list_lock;
+	wait_queue_head_t wb_io_wait;
+
 	struct work_struct del_work;	/* used for delayed sysfs removal */
 
 	struct kernfs_node *sysfs_state; /* handle for 'state'
@@ -200,6 +208,10 @@ enum flag_bits {
 				 * it didn't fail, so don't use FailFast
 				 * any more for metadata
 				 */
+	WBCollisionCheck,	/*
+				 * multiqueue device should check if there
+				 * is collision between write behind bios.
+				 */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
@@ -252,6 +264,14 @@ enum mddev_sb_flags {
 	MD_SB_NEED_REWRITE,	/* metadata write needs to be repeated */
 };
 
+#define NR_WB_INFOS	8
+/* record current range of write behind IOs */
+struct wb_info {
+	sector_t lo;
+	sector_t hi;
+	struct list_head list;
+};
+
 struct mddev {
 	void				*private;
 	struct md_personality		*pers;
@@ -468,6 +488,7 @@ struct mddev {
 					  */
 	struct work_struct flush_work;
 	struct work_struct event_work;	/* used by dm to report failure event */
+	mempool_t *wb_info_pool;
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
 	struct md_cluster_info		*cluster_info;
 	unsigned int			good_device_nr;	/* good device num within cluster raid */
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0c8a098d220e..f1ea17b14b6e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -83,6 +83,57 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 
 #include "raid1-10.c"
 
+static int check_and_add_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
+{
+	struct wb_info *wi, *temp_wi;
+	unsigned long flags;
+	int ret = 0;
+	struct mddev *mddev = rdev->mddev;
+
+	wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
+
+	spin_lock_irqsave(&rdev->wb_list_lock, flags);
+	list_for_each_entry(temp_wi, &rdev->wb_list, list) {
+		/* collision happened */
+		if (hi > temp_wi->lo && lo < temp_wi->hi) {
+			ret = -EBUSY;
+			break;
+		}
+	}
+
+	if (!ret) {
+		wi->lo = lo;
+		wi->hi = hi;
+		list_add(&wi->list, &rdev->wb_list);
+	} else
+		mempool_free(wi, mddev->wb_info_pool);
+	spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
+
+	return ret;
+}
+
+static void remove_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
+{
+	struct wb_info *wi;
+	unsigned long flags;
+	int found = 0;
+	struct mddev *mddev = rdev->mddev;
+
+	spin_lock_irqsave(&rdev->wb_list_lock, flags);
+	list_for_each_entry(wi, &rdev->wb_list, list)
+		if (hi == wi->hi && lo == wi->lo) {
+			list_del(&wi->list);
+			mempool_free(wi, mddev->wb_info_pool);
+			found = 1;
+			break;
+		}
+
+	if (!found)
+		WARN_ON("The write behind IO is not recorded\n");
+	spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
+	wake_up(&rdev->wb_io_wait);
+}
+
 /*
  * for resync bio, r1bio pointer can be retrieved from the per-bio
  * 'struct resync_pages'.
@@ -484,6 +535,12 @@ static void raid1_end_write_request(struct bio *bio)
 	}
 
 	if (behind) {
+		if (test_bit(WBCollisionCheck, &rdev->flags)) {
+			sector_t lo = r1_bio->sector;
+			sector_t hi = r1_bio->sector + r1_bio->sectors;
+
+			remove_wb(rdev, lo, hi);
+		}
 		if (test_bit(WriteMostly, &rdev->flags))
 			atomic_dec(&r1_bio->behind_remaining);
 
@@ -1482,7 +1539,16 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
 
 		if (r1_bio->behind_master_bio) {
-			if (test_bit(WriteMostly, &conf->mirrors[i].rdev->flags))
+			struct md_rdev *rdev = conf->mirrors[i].rdev;
+
+			if (test_bit(WBCollisionCheck, &rdev->flags)) {
+				sector_t lo = r1_bio->sector;
+				sector_t hi = r1_bio->sector + r1_bio->sectors;
+
+				wait_event(rdev->wb_io_wait,
+					   check_and_add_wb(rdev, lo, hi) == 0);
+			}
+			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
 		}
 
-- 
2.12.3

