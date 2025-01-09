Return-Path: <linux-raid+bounces-3415-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5BA06A82
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2025 02:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52BC166FB6
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2025 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130F1547DE;
	Thu,  9 Jan 2025 01:56:50 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F33A8D2;
	Thu,  9 Jan 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387810; cv=none; b=Mo8e0KxGEDU7zELF3Skyi/rGHwAKJjht6ofF9jaFz2KN3pv2UBqCfYsg0whOx2iHyP0qAEKl5uH+GSDtZhOTzPPS3X32a2eF8KnKF1MewYykGGqC4wqF8aGHk5Y2OaN4TF5IGSFOtRC5dHzyhrAgN1wKKXCxcpAESsNIxui0o0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387810; c=relaxed/simple;
	bh=zCQsLVI4kZusdW7H/k+X3HrCdigvlylVBlt+ocaX4tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B41WYtCljWv2e9CrO14IPj3NF6PszV40c/Mn3aEbS0V4+SL0+I4FDzPQfScypNZ97Fgda/SphpQ3hKyL9H9tBzWf35rTA4I3ZIwR6uIh8igR4PXfCHEavhLsytzmZ7dk7FXT7X0Yt6wc4DeWcJ+WFfSwYSA9h5RpriqLOMm116o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YT7Dr0YD5z4f3jqr;
	Thu,  9 Jan 2025 09:56:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1A9521A08FC;
	Thu,  9 Jan 2025 09:56:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_YLH9nk+G_AQ--.844S6;
	Thu, 09 Jan 2025 09:56:42 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	xni@redhat.com,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 md-6.14 2/5] md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()
Date: Thu,  9 Jan 2025 09:51:42 +0800
Message-Id: <20250109015145.158868-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250109015145.158868-1-yukuai1@huaweicloud.com>
References: <20250109015145.158868-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_YLH9nk+G_AQ--.844S6
X-Coremail-Antispam: 1UD129KBjvAXoW3ur17KFyrAF18Zw48KF4xXrb_yoW8JryUuo
	Z5ZwnI9a1Fqw1rXFyDtr1ftFW3Was0k3ySy3WfWrs8WrZrXa4Fqr1xGrWfG3yUtryfZFW3
	Zr9Fqr48JF45Aw17n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY_7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
	kI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1c_TUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For the case that IO failed for one rdev, the bit will be mark as NEEDED
in following cases:

1) If badblocks is set and rdev is not faulty;
2) If rdev is faulty;

Case 1) is useless because synchronize data to badblocks make no sense.
Case 2) can be replaced with mddev->degraded.

Also remove R1BIO_Degraded, R10BIO_Degraded and STRIPE_DEGRADED since
case 2) no longer use them.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c   | 19 ++++++++++---------
 drivers/md/md-bitmap.h   |  2 +-
 drivers/md/raid1.c       | 26 +++-----------------------
 drivers/md/raid1.h       |  1 -
 drivers/md/raid10.c      | 23 +++--------------------
 drivers/md/raid10.h      |  1 -
 drivers/md/raid5-cache.c |  3 +--
 drivers/md/raid5.c       | 15 +++------------
 drivers/md/raid5.h       |  1 -
 9 files changed, 21 insertions(+), 70 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 84fb4cc67d5e..b40a84b01085 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1726,7 +1726,7 @@ static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
 }
 
 static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
-			    unsigned long sectors, bool success)
+			    unsigned long sectors)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
@@ -1745,15 +1745,16 @@ static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
 			return;
 		}
 
-		if (success && !bitmap->mddev->degraded &&
-		    bitmap->events_cleared < bitmap->mddev->events) {
-			bitmap->events_cleared = bitmap->mddev->events;
-			bitmap->need_sync = 1;
-			sysfs_notify_dirent_safe(bitmap->sysfs_can_clear);
-		}
-
-		if (!success && !NEEDED(*bmc))
+		if (!bitmap->mddev->degraded) {
+			if (bitmap->events_cleared < bitmap->mddev->events) {
+				bitmap->events_cleared = bitmap->mddev->events;
+				bitmap->need_sync = 1;
+				sysfs_notify_dirent_safe(
+						bitmap->sysfs_can_clear);
+			}
+		} else if (!NEEDED(*bmc)) {
 			*bmc |= NEEDED_MASK;
+		}
 
 		if (COUNTER(*bmc) == COUNTER_MAX)
 			wake_up(&bitmap->overflow_wait);
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index e87a1f493d3c..31c93019c76b 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -92,7 +92,7 @@ struct bitmap_operations {
 	int (*startwrite)(struct mddev *mddev, sector_t offset,
 			  unsigned long sectors);
 	void (*endwrite)(struct mddev *mddev, sector_t offset,
-			 unsigned long sectors, bool success);
+			 unsigned long sectors);
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 15ba7a001f30..4d09d85321b6 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -423,8 +423,7 @@ static void close_write(struct r1bio *r1_bio)
 	if (test_bit(R1BIO_BehindIO, &r1_bio->state))
 		mddev->bitmap_ops->end_behind_write(mddev);
 	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors,
-				    !test_bit(R1BIO_Degraded, &r1_bio->state));
+	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors);
 	md_write_end(mddev);
 }
 
@@ -481,8 +480,6 @@ static void raid1_end_write_request(struct bio *bio)
 		if (!test_bit(Faulty, &rdev->flags))
 			set_bit(R1BIO_WriteError, &r1_bio->state);
 		else {
-			/* Fail the request */
-			set_bit(R1BIO_Degraded, &r1_bio->state);
 			/* Finished with this branch */
 			r1_bio->bios[mirror] = NULL;
 			to_put = bio;
@@ -1536,11 +1533,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-		if (!rdev || test_bit(Faulty, &rdev->flags)) {
-			if (i < conf->raid_disks)
-				set_bit(R1BIO_Degraded, &r1_bio->state);
+		if (!rdev || test_bit(Faulty, &rdev->flags))
 			continue;
-		}
 
 		atomic_inc(&rdev->nr_pending);
 		if (test_bit(WriteErrorSeen, &rdev->flags)) {
@@ -1559,16 +1553,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 					 */
 					max_sectors = bad_sectors;
 				rdev_dec_pending(rdev, mddev);
-				/* We don't set R1BIO_Degraded as that
-				 * only applies if the disk is
-				 * missing, so it might be re-added,
-				 * and we want to know to recover this
-				 * chunk.
-				 * In this case the device is here,
-				 * and the fact that this chunk is not
-				 * in-sync is recorded in the bad
-				 * block log
-				 */
 				continue;
 			}
 			if (is_bad) {
@@ -2616,12 +2600,10 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * errors.
 			 */
 			fail = true;
-			if (!narrow_write_error(r1_bio, m)) {
+			if (!narrow_write_error(r1_bio, m))
 				md_error(conf->mddev,
 					 conf->mirrors[m].rdev);
 				/* an I/O failed, we can't clear the bitmap */
-				set_bit(R1BIO_Degraded, &r1_bio->state);
-			}
 			rdev_dec_pending(conf->mirrors[m].rdev,
 					 conf->mddev);
 		}
@@ -2712,8 +2694,6 @@ static void raid1d(struct md_thread *thread)
 			list_del(&r1_bio->retry_list);
 			idx = sector_to_idx(r1_bio->sector);
 			atomic_dec(&conf->nr_queued[idx]);
-			if (mddev->degraded)
-				set_bit(R1BIO_Degraded, &r1_bio->state);
 			if (test_bit(R1BIO_WriteError, &r1_bio->state))
 				close_write(r1_bio);
 			raid_end_bio_io(r1_bio);
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 5300cbaa58a4..33f318fcc268 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -188,7 +188,6 @@ struct r1bio {
 enum r1bio_state {
 	R1BIO_Uptodate,
 	R1BIO_IsSync,
-	R1BIO_Degraded,
 	R1BIO_BehindIO,
 /* Set ReadError on bios that experience a readerror so that
  * raid1d knows what to do with them.
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c3a93b2a26a6..340a4710c222 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -429,8 +429,7 @@ static void close_write(struct r10bio *r10_bio)
 	struct mddev *mddev = r10_bio->mddev;
 
 	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				    !test_bit(R10BIO_Degraded, &r10_bio->state));
+	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors);
 	md_write_end(mddev);
 }
 
@@ -500,7 +499,6 @@ static void raid10_end_write_request(struct bio *bio)
 				set_bit(R10BIO_WriteError, &r10_bio->state);
 			else {
 				/* Fail the request */
-				set_bit(R10BIO_Degraded, &r10_bio->state);
 				r10_bio->devs[slot].bio = NULL;
 				to_put = bio;
 				dec_rdev = 1;
@@ -1437,10 +1435,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->devs[i].bio = NULL;
 		r10_bio->devs[i].repl_bio = NULL;
 
-		if (!rdev && !rrdev) {
-			set_bit(R10BIO_Degraded, &r10_bio->state);
+		if (!rdev && !rrdev)
 			continue;
-		}
 		if (rdev && test_bit(WriteErrorSeen, &rdev->flags)) {
 			sector_t first_bad;
 			sector_t dev_sector = r10_bio->devs[i].addr;
@@ -1457,14 +1453,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 					 * to other devices yet
 					 */
 					max_sectors = bad_sectors;
-				/* We don't set R10BIO_Degraded as that
-				 * only applies if the disk is missing,
-				 * so it might be re-added, and we want to
-				 * know to recover this chunk.
-				 * In this case the device is here, and the
-				 * fact that this chunk is not in-sync is
-				 * recorded in the bad block log.
-				 */
 				continue;
 			}
 			if (is_bad) {
@@ -2964,11 +2952,8 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				if (!narrow_write_error(r10_bio, m)) {
+				if (!narrow_write_error(r10_bio, m))
 					md_error(conf->mddev, rdev);
-					set_bit(R10BIO_Degraded,
-						&r10_bio->state);
-				}
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
@@ -3027,8 +3012,6 @@ static void raid10d(struct md_thread *thread)
 			r10_bio = list_first_entry(&tmp, struct r10bio,
 						   retry_list);
 			list_del(&r10_bio->retry_list);
-			if (mddev->degraded)
-				set_bit(R10BIO_Degraded, &r10_bio->state);
 
 			if (test_bit(R10BIO_WriteError,
 				     &r10_bio->state))
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 2e75e88d0802..3f16ad6904a9 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -161,7 +161,6 @@ enum r10bio_state {
 	R10BIO_IsSync,
 	R10BIO_IsRecover,
 	R10BIO_IsReshape,
-	R10BIO_Degraded,
 /* Set ReadError on bios that experience a read error
  * so that raid10d knows what to do with them.
  */
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 4c7ecdd5c1f3..ba4f9577c737 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -314,8 +314,7 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
 			set_bit(R5_UPTODATE, &sh->dev[i].flags);
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state));
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		}
 	}
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 93cc7e252dd4..a5a619400d8f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1345,8 +1345,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				submit_bio_noacct(rbi);
 		}
 		if (!rdev && !rrdev) {
-			if (op_is_write(op))
-				set_bit(STRIPE_DEGRADED, &sh->state);
 			pr_debug("skip op %d on disc %d for sector %llu\n",
 				bi->bi_opf, i, (unsigned long long)sh->sector);
 			clear_bit(R5_LOCKED, &sh->dev[i].flags);
@@ -2884,7 +2882,6 @@ static void raid5_end_write_request(struct bio *bi)
 			set_bit(R5_MadeGoodRepl, &sh->dev[i].flags);
 	} else {
 		if (bi->bi_status) {
-			set_bit(STRIPE_DEGRADED, &sh->state);
 			set_bit(WriteErrorSeen, &rdev->flags);
 			set_bit(R5_WriteError, &sh->dev[i].flags);
 			if (!test_and_set_bit(WantReplacement, &rdev->flags))
@@ -3664,8 +3661,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		}
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false);
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
@@ -3711,8 +3707,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		}
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false);
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -4062,8 +4057,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 					wbi = wbi2;
 				}
 				conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state));
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 				if (head_sh->batch_head) {
 					sh = list_first_entry(&sh->batch_list,
 							      struct stripe_head,
@@ -4340,7 +4334,6 @@ static void handle_parity_checks5(struct r5conf *conf, struct stripe_head *sh,
 		s->locked++;
 		set_bit(R5_Wantwrite, &dev->flags);
 
-		clear_bit(STRIPE_DEGRADED, &sh->state);
 		set_bit(STRIPE_INSYNC, &sh->state);
 		break;
 	case check_state_run:
@@ -4497,7 +4490,6 @@ static void handle_parity_checks6(struct r5conf *conf, struct stripe_head *sh,
 			clear_bit(R5_Wantwrite, &dev->flags);
 			s->locked--;
 		}
-		clear_bit(STRIPE_DEGRADED, &sh->state);
 
 		set_bit(STRIPE_INSYNC, &sh->state);
 		break;
@@ -4899,7 +4891,6 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 
 		set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
 					    (1 << STRIPE_PREREAD_ACTIVE) |
-					    (1 << STRIPE_DEGRADED) |
 					    (1 << STRIPE_ON_UNPLUG_LIST)),
 			      head_sh->state & (1 << STRIPE_INSYNC));
 
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index d174e586698f..69000fb90bd5 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -358,7 +358,6 @@ enum {
 	STRIPE_REPLACED,
 	STRIPE_PREREAD_ACTIVE,
 	STRIPE_DELAYED,
-	STRIPE_DEGRADED,
 	STRIPE_BIT_DELAY,
 	STRIPE_EXPANDING,
 	STRIPE_EXPAND_SOURCE,
-- 
2.39.2


