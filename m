Return-Path: <linux-raid+bounces-5254-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48019B50E29
	for <lists+linux-raid@lfdr.de>; Wed, 10 Sep 2025 08:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FDB3B7CCF
	for <lists+linux-raid@lfdr.de>; Wed, 10 Sep 2025 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207773081BD;
	Wed, 10 Sep 2025 06:40:30 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007A2D1F6B;
	Wed, 10 Sep 2025 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486429; cv=none; b=Khsm7uRqVqNcFt2z+k3//58ALeXqoK2K08NwI8aLRdGkdcniPz0docSZhFbzNkpGZoDGDYKsFei/LX0iXjgdLHIvFDCmXFuF63inBNUwxDbw7nrYsiQddVcLwpq/4eANAnpha1juLGqxGFdd38y6uJ21kf1WWnEsaPFZpmXAlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486429; c=relaxed/simple;
	bh=wPIH+IE5qCGvIZA/hzu4fnUUpz60+6FPreJHhtCdwEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVgJ6Iaw0Fx6yz711UOqJds/3r5dormn5E8srKoD2gdPdNJH2fUXWEIS7oBECOcZ0XDVQgzIy+7LHDRuNN7qMWlIUBeXTsAco7ROwo6J45mgpGU45+F8whyntS0cKiZa4DIN3xkTeP+uoaFIkMPBJd83mIJvB8ueKpZ3XDM9Lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cM9zq3JRhzKHN5g;
	Wed, 10 Sep 2025 14:40:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A46451A110D;
	Wed, 10 Sep 2025 14:40:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY1UHcFo3ZIJCA--.51912S5;
	Wed, 10 Sep 2025 14:40:23 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 01/16] block: cleanup bio_issue
Date: Wed, 10 Sep 2025 14:30:41 +0800
Message-Id: <20250910063056.4159857-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
References: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY1UHcFo3ZIJCA--.51912S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy8uryrXr1UZF4kGF1rZwb_yoW7Gw47pr
	4fGr93Gr93tFsrWr48ta1DZ34rGrs5Cry3G398uwsaya1I9ry7JF1kZF40qFykCFZ5CFZ8
	XF18t3yYkw4Yk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIw0e
	DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that bio->bi_issue is only used by blk-iolatency to get bio issue
time, replace bio_issue with u64 time directly and remove bio_issue to
make code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               |  2 +-
 block/blk-cgroup.h        |  2 +-
 block/blk-iolatency.c     | 14 +++----------
 block/blk.h               | 42 ---------------------------------------
 include/linux/blk_types.h |  7 ++-----
 5 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9603ca3ec770..3a1a848940dd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -261,7 +261,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_private = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	bio->bi_blkg = NULL;
-	bio->bi_issue.value = 0;
+	bio->issue_time_ns = 0;
 	if (bdev)
 		bio_associate_blkg(bio);
 #ifdef CONFIG_BLK_CGROUP_IOCOST
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 83367086cb6a..8328427e3165 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -372,7 +372,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 
 static inline void blkcg_bio_issue_init(struct bio *bio)
 {
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+	bio->issue_time_ns = blk_time_get_ns();
 }
 
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2f8fdecdd7a9..554b191a6892 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -485,19 +485,11 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 		mod_timer(&blkiolat->timer, jiffies + HZ);
 }
 
-static void iolatency_record_time(struct iolatency_grp *iolat,
-				  struct bio_issue *issue, u64 now,
-				  bool issue_as_root)
+static void iolatency_record_time(struct iolatency_grp *iolat, u64 start,
+				  u64 now, bool issue_as_root)
 {
-	u64 start = bio_issue_time(issue);
 	u64 req_time;
 
-	/*
-	 * Have to do this so we are truncated to the correct time that our
-	 * issue is truncated to.
-	 */
-	now = __bio_issue_time(now);
-
 	if (now <= start)
 		return;
 
@@ -625,7 +617,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 		 * submitted, so do not account for it.
 		 */
 		if (iolat->min_lat_nsec && bio->bi_status != BLK_STS_AGAIN) {
-			iolatency_record_time(iolat, &bio->bi_issue, now,
+			iolatency_record_time(iolat, bio->issue_time_ns, now,
 					      issue_as_root);
 			window_start = atomic64_read(&iolat->window_start);
 			if (now > window_start &&
diff --git a/block/blk.h b/block/blk.h
index 7d420c247d81..41397688b941 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -681,48 +681,6 @@ static inline ktime_t blk_time_get(void)
 	return ns_to_ktime(blk_time_get_ns());
 }
 
-/*
- * From most significant bit:
- * 1 bit: reserved for other usage, see below
- * 12 bits: original size of bio
- * 51 bits: issue time of bio
- */
-#define BIO_ISSUE_RES_BITS      1
-#define BIO_ISSUE_SIZE_BITS     12
-#define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
-#define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BITS)
-#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
-#define BIO_ISSUE_SIZE_MASK     \
-	(((1ULL << BIO_ISSUE_SIZE_BITS) - 1) << BIO_ISSUE_SIZE_SHIFT)
-#define BIO_ISSUE_RES_MASK      (~((1ULL << BIO_ISSUE_RES_SHIFT) - 1))
-
-/* Reserved bit for blk-throtl */
-#define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
-
-static inline u64 __bio_issue_time(u64 time)
-{
-	return time & BIO_ISSUE_TIME_MASK;
-}
-
-static inline u64 bio_issue_time(struct bio_issue *issue)
-{
-	return __bio_issue_time(issue->value);
-}
-
-static inline sector_t bio_issue_size(struct bio_issue *issue)
-{
-	return ((issue->value & BIO_ISSUE_SIZE_MASK) >> BIO_ISSUE_SIZE_SHIFT);
-}
-
-static inline void bio_issue_init(struct bio_issue *issue,
-				       sector_t size)
-{
-	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
-	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
-			(blk_time_get_ns() & BIO_ISSUE_TIME_MASK) |
-			((u64)size << BIO_ISSUE_SIZE_SHIFT));
-}
-
 void bdev_release(struct file *bdev_file);
 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4bd098fd61cb..8e8d1cc8b06c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -198,10 +198,6 @@ static inline bool blk_path_error(blk_status_t error)
 	return true;
 }
 
-struct bio_issue {
-	u64 value;
-};
-
 typedef __u32 __bitwise blk_opf_t;
 
 typedef unsigned int blk_qc_t;
@@ -242,7 +238,8 @@ struct bio {
 	 * on release of the bio.
 	 */
 	struct blkcg_gq		*bi_blkg;
-	struct bio_issue	bi_issue;
+	/* Time that this bio was issued. */
+	u64			issue_time_ns;
 #ifdef CONFIG_BLK_CGROUP_IOCOST
 	u64			bi_iocost_cost;
 #endif
-- 
2.39.2


