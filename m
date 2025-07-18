Return-Path: <linux-raid+bounces-4693-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297FB09FB5
	for <lists+linux-raid@lfdr.de>; Fri, 18 Jul 2025 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54E25A74E5
	for <lists+linux-raid@lfdr.de>; Fri, 18 Jul 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92492BCF70;
	Fri, 18 Jul 2025 09:29:56 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05F29B20E;
	Fri, 18 Jul 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830996; cv=none; b=PrmBrE9Bvg0yaM2eGqErEJhS5zZnI0mmhTH4TqtahV+r5lkIky9glwhAZpjBUuTmXHbmz1pc2kp5dCXhBRhaVtYsY8lDNKfzOZswl8JU2wmjcT8CI++UrEtGsRtNKhM4A0bIbC8tW3wOSuTiYAsp0JPe6CYTpOlMQNkRuOpmzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830996; c=relaxed/simple;
	bh=DKCgqatAgAcB+bskp4H6uawA1wOWj45CgEkyC0OQnZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTI+qLJYUUwoiKGwOInNnExZE4bq6eRjUQnjU91bbCgfm3cQdTeZmIZoY9mEsIwHNaTkc6mJzD5DAqQCgQHNmNFSxcrb2YttVsFIr6yvZb2sbcm49iGtRtWZ5gR+MVn2JpdCZDfI7nCT8gRTyX5dN8rEiQeLIArx+suexh//7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bk4JD3jGfzYQvMK;
	Fri, 18 Jul 2025 17:29:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 41A7C1A1382;
	Fri, 18 Jul 2025 17:29:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxQGFHpoDl6qAg--.5172S5;
	Fri, 18 Jul 2025 17:29:47 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: corbet@lwn.net,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com,
	hare@suse.de
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 01/11] md: add a new parameter 'offset' to md_super_write()
Date: Fri, 18 Jul 2025 17:23:26 +0800
Message-Id: <20250718092336.3346644-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250718092336.3346644-1-yukuai1@huaweicloud.com>
References: <20250718092336.3346644-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxQGFHpoDl6qAg--.5172S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kXF1fAFWfKrWfKFW8Xrb_yoW7CryUpa
	y2vFyfJrW3trWYqw17JFWDua4Fq34DKrZrtry7C34xu3W7KrykKF15JFy8XryDuF9xCrs8
	Xw4jkFW7uF1xWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The parameter is always set to 0 for now, following patches will use
this helper to write llbitmap to underlying disks, allow writing
dirty sectors instead of the whole page.

Also rename md_super_write to md_write_metadata since there is nothing
super-block specific.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/md-bitmap.c |  3 ++-
 drivers/md/md.c        | 52 +++++++++++++++++++++++++-----------------
 drivers/md/md.h        |  5 ++--
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 28dd66ab8df9..3c8b8ecf0695 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -485,7 +485,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 			return -EINVAL;
 	}
 
-	md_super_write(mddev, rdev, sboff + ps, (int)min(size, bitmap_limit), page);
+	md_write_metadata(mddev, rdev, sboff + ps, (int)min(size, bitmap_limit),
+			  page, 0);
 	return 0;
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b36c09ca59dc..1a19a9c2b50d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1021,15 +1021,26 @@ static void super_written(struct bio *bio)
 		wake_up(&mddev->sb_wait);
 }
 
-void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
-		   sector_t sector, int size, struct page *page)
-{
-	/* write first size bytes of page to sector of rdev
-	 * Increment mddev->pending_writes before returning
-	 * and decrement it on completion, waking up sb_wait
-	 * if zero is reached.
-	 * If an error occurred, call md_error
-	 */
+/**
+ * md_write_metadata - write metadata to underlying disk, including
+ * array superblock, badblocks, bitmap superblock and bitmap bits.
+ * @mddev:	the array to write
+ * @rdev:	the underlying disk to write
+ * @sector:	the offset to @rdev
+ * @size:	the length of the metadata
+ * @page:	the metadata
+ * @offset:	the offset to @page
+ *
+ * Write @size bytes of @page start from @offset, to @sector of @rdev, Increment
+ * mddev->pending_writes before returning, and decrement it on completion,
+ * waking up sb_wait. Caller must call md_super_wait() after issuing io to all
+ * rdev. If an error occurred, md_error() will be called, and the @rdev will be
+ * kicked out from @mddev.
+ */
+void md_write_metadata(struct mddev *mddev, struct md_rdev *rdev,
+		       sector_t sector, int size, struct page *page,
+		       unsigned int offset)
+{
 	struct bio *bio;
 
 	if (!page)
@@ -1047,7 +1058,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	atomic_inc(&rdev->nr_pending);
 
 	bio->bi_iter.bi_sector = sector;
-	__bio_add_page(bio, page, size, 0);
+	__bio_add_page(bio, page, size, offset);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
 
@@ -1657,8 +1668,8 @@ super_90_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 	if ((u64)num_sectors >= (2ULL << 32) && rdev->mddev->level >= 1)
 		num_sectors = (sector_t)(2ULL << 32) - 2;
 	do {
-		md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
-		       rdev->sb_page);
+		md_write_metadata(rdev->mddev, rdev, rdev->sb_start,
+				  rdev->sb_size, rdev->sb_page, 0);
 	} while (md_super_wait(rdev->mddev) < 0);
 	return num_sectors;
 }
@@ -2306,8 +2317,8 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 	sb->super_offset = cpu_to_le64(rdev->sb_start);
 	sb->sb_csum = calc_sb_1_csum(sb);
 	do {
-		md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
-			       rdev->sb_page);
+		md_write_metadata(rdev->mddev, rdev, rdev->sb_start,
+				  rdev->sb_size, rdev->sb_page, 0);
 	} while (md_super_wait(rdev->mddev) < 0);
 	return num_sectors;
 
@@ -2816,18 +2827,17 @@ void md_update_sb(struct mddev *mddev, int force_change)
 			continue; /* no noise on spare devices */
 
 		if (!test_bit(Faulty, &rdev->flags)) {
-			md_super_write(mddev,rdev,
-				       rdev->sb_start, rdev->sb_size,
-				       rdev->sb_page);
+			md_write_metadata(mddev, rdev, rdev->sb_start,
+					  rdev->sb_size, rdev->sb_page, 0);
 			pr_debug("md: (write) %pg's sb offset: %llu\n",
 				 rdev->bdev,
 				 (unsigned long long)rdev->sb_start);
 			rdev->sb_events = mddev->events;
 			if (rdev->badblocks.size) {
-				md_super_write(mddev, rdev,
-					       rdev->badblocks.sector,
-					       rdev->badblocks.size << 9,
-					       rdev->bb_page);
+				md_write_metadata(mddev, rdev,
+						  rdev->badblocks.sector,
+						  rdev->badblocks.size << 9,
+						  rdev->bb_page, 0);
 				rdev->badblocks.size = 0;
 			}
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 6eb5dfdf2f55..f9fdcc5eea22 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -886,8 +886,9 @@ void md_account_bio(struct mddev *mddev, struct bio **bio);
 void md_free_cloned_bio(struct bio *bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
-extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
-			   sector_t sector, int size, struct page *page);
+void md_write_metadata(struct mddev *mddev, struct md_rdev *rdev,
+		       sector_t sector, int size, struct page *page,
+		       unsigned int offset);
 extern int md_super_wait(struct mddev *mddev);
 extern int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		struct page *page, blk_opf_t opf, bool metadata_op);
-- 
2.39.2


