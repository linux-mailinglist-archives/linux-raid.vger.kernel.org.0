Return-Path: <linux-raid+bounces-2530-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35AD95AB63
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 04:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E762816AB
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 02:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB217D340;
	Thu, 22 Aug 2024 02:52:15 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070613CFBB;
	Thu, 22 Aug 2024 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295135; cv=none; b=fZyhkVh4vDaFAJHtwxo8pPZvzQDZBxa76GNvFjoxeEJ2TIdG9kJgUMP9oh9cTV4tQw+e/b1LFtCL622ZJ99xDShgPCbHBHuOyyiOz/5i+p1ZamXSSXaw8eYsBb+nNm8ljYvdWOs6XhyYRDS/rODYWuKELIZFkbKy7yGWvRCEtUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295135; c=relaxed/simple;
	bh=iC29LTyULxXO9r5ctpQa2iGXf8vHrqGzU52vEi+OF2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyWFZjfZs3KxHxWJhrtOiPYD/hsrsGIFSs1xcHJ3WZ1jGclGs8xBl6g7WFA7gwzPO3DRkkUlLyJ5ltL6rqEw5GUSX/C5lrJIWXDSOClMDFl39/kQSd4aqgRCPrqryBf+DmHtHi0SGUi39I30yba/7YVkvEq886zC1c6G+wKrdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq75R5WCcz4f3jsD;
	Thu, 22 Aug 2024 10:51:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 00BEB1A018D;
	Thu, 22 Aug 2024 10:52:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTNp8ZmyXl2CQ--.42363S26;
	Thu, 22 Aug 2024 10:52:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	mariusz.tkaczyk@linux.intel.com,
	l@damenly.org,
	xni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.12 22/41] md/md-bitmap: merge md_bitmap_startwrite() into bitmap_operations
Date: Thu, 22 Aug 2024 10:46:59 +0800
Message-Id: <20240822024718.2158259-23-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822024718.2158259-1-yukuai1@huaweicloud.com>
References: <20240822024718.2158259-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoTNp8ZmyXl2CQ--.42363S26
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWDuw47Ar4DuFWUAFyxXwb_yoW7Xw45pa
	1DGFya9rWYqF45Xw1DJFyDuFyFy3WktrZrtrWfX3s5uFyqvrnxWF48WFyUtw15CFy3AFW3
	Z3Z8trWUGr42qFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VU1zpBDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that the implementation won't be exposed, and it'll be possible
to invent a new bitmap by replacing bitmap_operations.

Also change the parameter from bitmap to mddev, to avoid access
bitmap outside md-bitmap.c as much as possible. And change the type
of 'behind' from int to bool.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  8 ++++++--
 drivers/md/md-bitmap.h |  5 +++--
 drivers/md/raid1.c     |  5 +++--
 drivers/md/raid10.c    |  3 ++-
 drivers/md/raid5.c     | 13 +++++--------
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 540b06dcc488..17e5ab0fc373 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1458,8 +1458,11 @@ __acquires(bitmap->lock)
 			&(bitmap->bp[page].map[pageoff]);
 }
 
-int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset, unsigned long sectors, int behind)
+static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
+			     unsigned long sectors, bool behind)
 {
+	struct bitmap *bitmap = mddev->bitmap;
+
 	if (!bitmap)
 		return 0;
 
@@ -1520,7 +1523,6 @@ int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset, unsigned long s
 	}
 	return 0;
 }
-EXPORT_SYMBOL(md_bitmap_startwrite);
 
 void md_bitmap_endwrite(struct bitmap *bitmap, sector_t offset,
 			unsigned long sectors, int success, int behind)
@@ -2728,6 +2730,8 @@ static struct bitmap_operations bitmap_ops = {
 	.write_all		= bitmap_write_all,
 	.dirty_bits		= bitmap_dirty_bits,
 
+	.startwrite		= bitmap_startwrite,
+
 	.update_sb		= bitmap_update_sb,
 	.get_stats		= bitmap_get_stats,
 };
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 875ecbb5b1e4..1433d13e447a 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -255,6 +255,9 @@ struct bitmap_operations {
 	void (*dirty_bits)(struct mddev *mddev, unsigned long s,
 			   unsigned long e);
 
+	int (*startwrite)(struct mddev *mddev, sector_t offset,
+			  unsigned long sectors, bool behind);
+
 	void (*update_sb)(struct bitmap *bitmap);
 	int (*get_stats)(struct bitmap *bitmap, struct md_bitmap_stats *stats);
 };
@@ -263,8 +266,6 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are exported */
-int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset,
-			 unsigned long sectors, int behind);
 void md_bitmap_endwrite(struct bitmap *bitmap, sector_t offset,
 			unsigned long sectors, int success, int behind);
 int md_bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks, int degraded);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d0bc5565057e..d8d425668680 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1617,8 +1617,9 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			    stats.behind_writes < max_write_behind)
 				alloc_behind_master_bio(r1_bio, bio);
 
-			md_bitmap_startwrite(bitmap, r1_bio->sector, r1_bio->sectors,
-					     test_bit(R1BIO_BehindIO, &r1_bio->state));
+			mddev->bitmap_ops->startwrite(
+				mddev, r1_bio->sector, r1_bio->sectors,
+				test_bit(R1BIO_BehindIO, &r1_bio->state));
 			first_clone = 0;
 		}
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index e55e020b5571..8f9172c3329a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1492,7 +1492,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	md_account_bio(mddev, &bio);
 	r10_bio->master_bio = bio;
 	atomic_set(&r10_bio->remaining, 1);
-	md_bitmap_startwrite(mddev->bitmap, r10_bio->sector, r10_bio->sectors, 0);
+	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors,
+				      false);
 
 	for (i = 0; i < conf->copies; i++) {
 		if (r10_bio->devs[i].bio)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c14cf2410365..c24036d1e6da 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3563,8 +3563,8 @@ static void __add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 		 */
 		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		spin_unlock_irq(&sh->stripe_lock);
-		md_bitmap_startwrite(conf->mddev->bitmap, sh->sector,
-				     RAID5_STRIPE_SECTORS(conf), 0);
+		conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sector,
+					RAID5_STRIPE_SECTORS(conf), false);
 		spin_lock_irq(&sh->stripe_lock);
 		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		if (!sh->batch_head) {
@@ -5788,13 +5788,10 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		}
 		spin_unlock_irq(&sh->stripe_lock);
 		if (conf->mddev->bitmap) {
-			for (d = 0;
-			     d < conf->raid_disks - conf->max_degraded;
+			for (d = 0; d < conf->raid_disks - conf->max_degraded;
 			     d++)
-				md_bitmap_startwrite(mddev->bitmap,
-						     sh->sector,
-						     RAID5_STRIPE_SECTORS(conf),
-						     0);
+				mddev->bitmap_ops->startwrite(mddev, sh->sector,
+					RAID5_STRIPE_SECTORS(conf), false);
 			sh->bm_seq = conf->seq_flush + 1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}
-- 
2.39.2


