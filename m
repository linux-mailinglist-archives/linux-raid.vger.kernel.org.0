Return-Path: <linux-raid+bounces-2411-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD03951551
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A6A28AE4F
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C715B125;
	Wed, 14 Aug 2024 07:15:42 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E51547C4;
	Wed, 14 Aug 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619742; cv=none; b=Df4smWcsPou09SYdeUT79/x+ug+TNnSt7aeu3zpdvG1ID0AY2qX1zjATa7kr6kOhdD+i9LFdHMxqoI+lUd1emnfXkVxOGU6UwcvH2S3qx18w3ZTYIniIjiIncYCAI+Tw7sR+llV6zOvD3SNDXKyykGzTvq0SyOYtQdvJR+VEZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619742; c=relaxed/simple;
	bh=e0hCYKoz9WrmZtdRkIziVJzjwpOJHTUQmvJf8G6fhEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYHGHKt3SCpqUezr8TLMuGePiacQs92vUPfLPl0Ex6UYZOYyIcQL0ive09eb60r2Y0/3LhnoFQxX0mKVY2L+Mrhtfv3udI3sx7xp1FJL3kFSKx6wMzd/F58uMz1FxoXQUaUOuZMmsh95Bx1S7ipP00E+Ek5QfTBtkwP3cw60h/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkKK50VWlz4f3kv7;
	Wed, 14 Aug 2024 15:15:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF81B1A0359;
	Wed, 14 Aug 2024 15:15:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHboSLWbxmIxKbBg--.47745S28;
	Wed, 14 Aug 2024 15:15:35 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mariusz.tkaczyk@linux.intel.com,
	hch@infradead.org,
	song@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next v2 24/41] md/md-bitmap: merge md_bitmap_start_sync() into bitmap_operations
Date: Wed, 14 Aug 2024 15:10:56 +0800
Message-Id: <20240814071113.346781-25-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814071113.346781-1-yukuai1@huaweicloud.com>
References: <20240814071113.346781-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboSLWbxmIxKbBg--.47745S28
X-Coremail-Antispam: 1UD129KBjvJXoW3ury7Jw1kKr4UAF13Kr45Jrb_yoWDuw1Upa
	17JFy3K3y5XFW5X3W5AryDuF1Fv3s7trZrtryfW34fGFykGrnxXF48WFyjqa4DKFy5AF98
	Zwn8Ar45Cry2qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQFxUU
	UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that the implementation won't be exposed, and it'll be possible
to invent a new bitmap by replacing bitmap_operations.

Also change the parameter from bitmap to mddev, to avoid access
bitmap outside md-bitmap.c as much as possible.

Also fix lots of code style.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 36 ++++++++++++++++++++----------------
 drivers/md/md-bitmap.h |  3 ++-
 drivers/md/raid1.c     | 10 +++++-----
 drivers/md/raid10.c    | 22 ++++++++++++----------
 drivers/md/raid5.c     | 10 ++++++----
 5 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 8da6e889d5f1..e42a0433e926 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1579,24 +1579,26 @@ static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
 	}
 }
 
-static int __bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks,
-			       int degraded)
+static bool __bitmap_start_sync(struct bitmap *bitmap, sector_t offset,
+				sector_t *blocks, bool degraded)
 {
 	bitmap_counter_t *bmc;
-	int rv;
+	bool rv;
+
 	if (bitmap == NULL) {/* FIXME or bitmap set as 'failed' */
 		*blocks = 1024;
-		return 1; /* always resync if no bitmap */
+		return true; /* always resync if no bitmap */
 	}
 	spin_lock_irq(&bitmap->counts.lock);
+
+	rv = false;
 	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0);
-	rv = 0;
 	if (bmc) {
 		/* locked */
-		if (RESYNC(*bmc))
-			rv = 1;
-		else if (NEEDED(*bmc)) {
-			rv = 1;
+		if (RESYNC(*bmc)) {
+			rv = true;
+		} else if (NEEDED(*bmc)) {
+			rv = true;
 			if (!degraded) { /* don't set/clear bits if degraded */
 				*bmc |= RESYNC_MASK;
 				*bmc &= ~NEEDED_MASK;
@@ -1604,11 +1606,12 @@ static int __bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t
 		}
 	}
 	spin_unlock_irq(&bitmap->counts.lock);
+
 	return rv;
 }
 
-int md_bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks,
-			 int degraded)
+static bool bitmap_start_sync(struct mddev *mddev, sector_t offset,
+			      sector_t *blocks, bool degraded)
 {
 	/* bitmap_start_sync must always report on multiples of whole
 	 * pages, otherwise resync (which is very PAGE_SIZE based) will
@@ -1617,19 +1620,19 @@ int md_bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t *block
 	 * At least PAGE_SIZE>>9 blocks are covered.
 	 * Return the 'or' of the result.
 	 */
-	int rv = 0;
+	bool rv = false;
 	sector_t blocks1;
 
 	*blocks = 0;
 	while (*blocks < (PAGE_SIZE>>9)) {
-		rv |= __bitmap_start_sync(bitmap, offset,
+		rv |= __bitmap_start_sync(mddev->bitmap, offset,
 					  &blocks1, degraded);
 		offset += blocks1;
 		*blocks += blocks1;
 	}
+
 	return rv;
 }
-EXPORT_SYMBOL(md_bitmap_start_sync);
 
 void md_bitmap_end_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks, int aborted)
 {
@@ -1723,7 +1726,7 @@ void md_bitmap_sync_with_cluster(struct mddev *mddev,
 	WARN((blocks > new_lo) && old_lo, "alignment is not correct for lo\n");
 
 	for (sector = old_hi; sector < new_hi; ) {
-		md_bitmap_start_sync(bitmap, sector, &blocks, 0);
+		bitmap_start_sync(mddev, sector, &blocks, false);
 		sector += blocks;
 	}
 	WARN((blocks > new_hi) && old_hi, "alignment is not correct for hi\n");
@@ -2005,7 +2008,7 @@ static int bitmap_load(struct mddev *mddev)
 	 */
 	while (sector < mddev->resync_max_sectors) {
 		sector_t blocks;
-		md_bitmap_start_sync(bitmap, sector, &blocks, 0);
+		bitmap_start_sync(mddev, sector, &blocks, false);
 		sector += blocks;
 	}
 	md_bitmap_close_sync(bitmap);
@@ -2731,6 +2734,7 @@ static struct bitmap_operations bitmap_ops = {
 
 	.startwrite		= bitmap_startwrite,
 	.endwrite		= bitmap_endwrite,
+	.start_sync		= bitmap_start_sync,
 
 	.update_sb		= bitmap_update_sb,
 	.get_stats		= bitmap_get_stats,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 223dc5d6f4e4..6fba3ff2f949 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -258,6 +258,8 @@ struct bitmap_operations {
 			  unsigned long sectors, bool behind);
 	void (*endwrite)(struct mddev *mddev, sector_t offset,
 			 unsigned long sectors, bool success, bool behind);
+	bool (*start_sync)(struct mddev *mddev, sector_t offset,
+			   sector_t *blocks, bool degraded);
 
 	void (*update_sb)(struct bitmap *bitmap);
 	int (*get_stats)(struct bitmap *bitmap, struct md_bitmap_stats *stats);
@@ -267,7 +269,6 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are exported */
-int md_bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks, int degraded);
 void md_bitmap_end_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks, int aborted);
 void md_bitmap_close_sync(struct bitmap *bitmap);
 void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index aeee09965817..555b56d15d92 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2767,7 +2767,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 	int wonly = -1;
 	int write_targets = 0, read_targets = 0;
 	sector_t sync_blocks;
-	int still_degraded = 0;
+	bool still_degraded = false;
 	int good_sectors = RESYNC_SECTORS;
 	int min_bad = 0; /* number of sectors that are bad in all devices */
 	int idx = sector_to_idx(sector_nr);
@@ -2809,7 +2809,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 	/* before building a request, check if we can skip these blocks..
 	 * This call the bitmap_start_sync doesn't actually record anything
 	 */
-	if (!md_bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
+	if (!mddev->bitmap_ops->start_sync(mddev, sector_nr, &sync_blocks, true) &&
 	    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
 		/* We can skip this block, and probably several more */
 		*skipped = 1;
@@ -2860,7 +2860,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags)) {
 			if (i < conf->raid_disks)
-				still_degraded = 1;
+				still_degraded = true;
 		} else if (!test_bit(In_sync, &rdev->flags)) {
 			bio->bi_opf = REQ_OP_WRITE;
 			bio->bi_end_io = end_sync_write;
@@ -2984,8 +2984,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (len == 0)
 			break;
 		if (sync_blocks == 0) {
-			if (!md_bitmap_start_sync(mddev->bitmap, sector_nr,
-						  &sync_blocks, still_degraded) &&
+			if (!mddev->bitmap_ops->start_sync(mddev, sector_nr,
+						&sync_blocks, still_degraded) &&
 			    !conf->fullsync &&
 			    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 				break;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 52f29b907ab6..2ab641166c8c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3289,10 +3289,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		r10_bio = NULL;
 
 		for (i = 0 ; i < conf->geo.raid_disks; i++) {
-			int still_degraded;
+			bool still_degraded;
 			struct r10bio *rb2;
 			sector_t sect;
-			int must_sync;
+			bool must_sync;
 			int any_working;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
@@ -3309,7 +3309,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			if (!mrdev && !mreplace)
 				continue;
 
-			still_degraded = 0;
+			still_degraded = false;
 			/* want to reconstruct this device */
 			rb2 = r10_bio;
 			sect = raid10_find_virt(conf, sector_nr, i);
@@ -3322,8 +3322,9 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			 * we only need to recover the block if it is set in
 			 * the bitmap
 			 */
-			must_sync = md_bitmap_start_sync(mddev->bitmap, sect,
-							 &sync_blocks, 1);
+			must_sync = mddev->bitmap_ops->start_sync(mddev, sect,
+								  &sync_blocks,
+								  true);
 			if (sync_blocks < max_sync)
 				max_sync = sync_blocks;
 			if (!must_sync &&
@@ -3361,13 +3362,13 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				struct md_rdev *rdev = conf->mirrors[j].rdev;
 
 				if (rdev == NULL || test_bit(Faulty, &rdev->flags)) {
-					still_degraded = 1;
+					still_degraded = false;
 					break;
 				}
 			}
 
-			must_sync = md_bitmap_start_sync(mddev->bitmap, sect,
-							 &sync_blocks, still_degraded);
+			must_sync = mddev->bitmap_ops->start_sync(mddev, sect,
+						&sync_blocks, still_degraded);
 
 			any_working = 0;
 			for (j=0; j<conf->copies;j++) {
@@ -3544,8 +3545,9 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 					mddev_is_clustered(mddev) &&
 					(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
 
-		if (!md_bitmap_start_sync(mddev->bitmap, sector_nr,
-					  &sync_blocks, mddev->degraded) &&
+		if (!mddev->bitmap_ops->start_sync(mddev, sector_nr,
+						   &sync_blocks,
+						   mddev->degraded) &&
 		    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED,
 						 &mddev->recovery)) {
 			/* We can skip this block */
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 93d582b9f922..313904dd6555 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6485,7 +6485,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	struct r5conf *conf = mddev->private;
 	struct stripe_head *sh;
 	sector_t sync_blocks;
-	int still_degraded = 0;
+	bool still_degraded = false;
 	int i;
 
 	if (sector_nr >= max_sector) {
@@ -6530,7 +6530,8 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	}
 	if (!test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    !conf->fullsync &&
-	    !md_bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
+	    !mddev->bitmap_ops->start_sync(mddev, sector_nr, &sync_blocks,
+					   true) &&
 	    sync_blocks >= RAID5_STRIPE_SECTORS(conf)) {
 		/* we can skip this block, and probably more */
 		do_div(sync_blocks, RAID5_STRIPE_SECTORS(conf));
@@ -6558,10 +6559,11 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 		struct md_rdev *rdev = conf->disks[i].rdev;
 
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags))
-			still_degraded = 1;
+			still_degraded = true;
 	}
 
-	md_bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, still_degraded);
+	mddev->bitmap_ops->start_sync(mddev, sector_nr, &sync_blocks,
+				      still_degraded);
 
 	set_bit(STRIPE_SYNC_REQUESTED, &sh->state);
 	set_bit(STRIPE_HANDLE, &sh->state);
-- 
2.39.2


