Return-Path: <linux-raid+bounces-5194-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC7B44F02
	for <lists+linux-raid@lfdr.de>; Fri,  5 Sep 2025 09:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A271C83A3C
	for <lists+linux-raid@lfdr.de>; Fri,  5 Sep 2025 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015B2F1FE2;
	Fri,  5 Sep 2025 07:16:01 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66672E8B69;
	Fri,  5 Sep 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056560; cv=none; b=Fj2V7pllZmaX7KMap9JhwZ4o1hkLsf5PkyqqW17wz6YKSi3FjYXllNUp11q5Ilt4hlXUOhjFolINbuBcTzanOb6NR6JrW4TlNtDL7Ef73aAPuuMVsldifajFxTMw5rhDsYScGPmsfy5nm3ImrDWMRted+Cci67FTmlMGAdeDxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056560; c=relaxed/simple;
	bh=3Y4c4LHNRMvVV5yZhsOPa317wHQMQoRBlIm3cYAe6RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mttgr9xlhSJbExs/cvEuWIlRtEWDVRgf+WhTX70eyzHKQk63Or640O5gh9PK3KIjCS35V/P3qLCHPxar+J0fKDrsvxMkgKG6sfnRbf4WCiyAAZgHqIEagdpvAIORYJO/xOxgjm65SUHoXv4asaGEhmE/3znL1b4hl4YlENlJVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ7183mRNzKHMgw;
	Fri,  5 Sep 2025 15:15:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7B0BD1A100F;
	Fri,  5 Sep 2025 15:15:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S10;
	Fri, 05 Sep 2025 15:15:56 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 06/16] block: factor out a helper bio_submit_split_bioset()
Date: Fri,  5 Sep 2025 15:06:33 +0800
Message-Id: <20250905070643.2533483-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47Aw13WFyDKw1rXr18Xwb_yoW5tw4Dpr
	4a9w13GrWkJFs29wnxJ3W7tas3KFZ0qrWUCay3J395JrnrtrnrK3W8XrWFvFyFkrW5C3yU
	Jw1vkay5Cw4UCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

No functional changes are intended, some drivers like mdraid will split
bio by internal processing, prepare to unify bio split codes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c      | 59 ++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5538356770a4..51fe4ed5b7c0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -104,33 +104,54 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
 	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
 
+/*
+ * bio_submit_split_bioset - Submit a bio, splitting it at a designated sector
+ * @bio:		the original bio to be submitted and split
+ * @split_sectors:	the sector count at which to split
+ * @bs:			the bio set used for allocating the new split bio
+ *
+ * The original bio is modified to contain the remaining sectors and submitted.
+ * The caller is responsible for submitting the returned bio.
+ *
+ * If succeed, the newly allocated bio representing the initial part will be
+ * returned, on failure NULL will be returned and original bio will fail.
+ */
+struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
+				    struct bio_set *bs)
+{
+	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
+
+	if (IS_ERR(split)) {
+		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+		bio_endio(bio);
+		return NULL;
+	}
+
+	bio_chain(split, bio);
+	trace_block_split(split, bio->bi_iter.bi_sector);
+	WARN_ON_ONCE(bio_zone_write_plugging(bio));
+	submit_bio_noacct(bio);
+
+	return split;
+}
+EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
+
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
-	if (unlikely(split_sectors < 0))
-		goto error;
+	if (unlikely(split_sectors < 0)) {
+		bio->bi_status = errno_to_blk_status(split_sectors);
+		bio_endio(bio);
+		return NULL;
+	}
 
 	if (split_sectors) {
-		struct bio *split;
-
-		split = bio_split(bio, split_sectors, GFP_NOIO,
+		bio = bio_submit_split_bioset(bio, split_sectors,
 				&bio->bi_bdev->bd_disk->bio_split);
-		if (IS_ERR(split)) {
-			split_sectors = PTR_ERR(split);
-			goto error;
-		}
-		split->bi_opf |= REQ_NOMERGE;
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		WARN_ON_ONCE(bio_zone_write_plugging(bio));
-		submit_bio_noacct(bio);
-		return split;
+		if (bio)
+			bio->bi_opf |= REQ_NOMERGE;
 	}
 
 	return bio;
-error:
-	bio->bi_status = errno_to_blk_status(split_sectors);
-	bio_endio(bio);
-	return NULL;
 }
 
 struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3c3b64684d14..0982874b65fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1000,6 +1000,8 @@ extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 void submit_bio_noacct(struct bio *bio);
 struct bio *bio_split_to_limits(struct bio *bio);
+struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
+				    struct bio_set *bs);
 
 extern int blk_lld_busy(struct request_queue *q);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
-- 
2.39.2


