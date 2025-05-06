Return-Path: <linux-raid+bounces-4102-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0CAAC4ED
	for <lists+linux-raid@lfdr.de>; Tue,  6 May 2025 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C43B1BC4243
	for <lists+linux-raid@lfdr.de>; Tue,  6 May 2025 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C435281366;
	Tue,  6 May 2025 12:57:23 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0628031C;
	Tue,  6 May 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536242; cv=none; b=VHG2Xa2AEsXNhIrrnV767z2p+riYyS7V91ynM5efbX/YjW3NGYMILlvGwag3j+WBcP6HANh0I0BNe3NjJBye9ULqfluyk1F4ZyTeedH0/3mASAkNXCCxGI6X5sx+pSQOekPwe+3Ew+tfSBf/X81T4iDcoJNznkiksZToLh3Ra0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536242; c=relaxed/simple;
	bh=ijmU0npkFWkOhFlJZmS1k2UfSaOwsdS9IBPLWBwjzwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQdJJ57+q+lrPhwxCjk9RUAxRw4tztqGMEnsFRreldY1dlmVyg6gpQpdUGDpOu4aFqZdpxydVBiKPw1S6J6TV0+Hy7F/WhgwUBwQNc5GFu9MKY5WmMl4cboXY8QjVvS0aX49KoiTiHoY8B4faC80ustdADwARJ+DohUIMJNLBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZsJMM0fXwzKHMq3;
	Tue,  6 May 2025 20:57:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DA6951A18C2;
	Tue,  6 May 2025 20:57:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl8pBxpoilNvLg--.37994S8;
	Tue, 06 May 2025 20:57:17 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	song@kernel.org,
	hch@lst.de,
	john.g.garry@oracle.com,
	hare@suse.de,
	xni@redhat.com,
	pmenzel@molgen.mpg.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 4/9] block: cleanup blk_mq_in_flight_rw()
Date: Tue,  6 May 2025 20:48:58 +0800
Message-Id: <20250506124903.2540268-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250506124903.2540268-1-yukuai1@huaweicloud.com>
References: <20250506124658.2537886-1-yukuai1@huaweicloud.com>
 <20250506124903.2540268-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl8pBxpoilNvLg--.37994S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF15Jw1xtw45KF47Ar43ZFb_yoWrZF45pr
	45Ka98trW5Wr1fur1xtan7XF1fKw48KryIvwnxAr1ayr18Kr98ZFy8Gw1kAr1SvrykCFW3
	C3WYyFy7GF1UC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Also add comment for part_inflight_show() for the difference between
bio-based and rq-based device.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 12 ++++++------
 block/blk-mq.h |  3 +--
 block/genhd.c  | 43 +++++++++++++++++++++++++------------------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 301dbd3e1743..0067e8226e05 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -89,7 +89,7 @@ struct mq_inflight {
 	unsigned int inflight[2];
 };
 
-static bool blk_mq_check_inflight(struct request *rq, void *priv)
+static bool blk_mq_check_in_driver(struct request *rq, void *priv)
 {
 	struct mq_inflight *mi = priv;
 
@@ -101,14 +101,14 @@ static bool blk_mq_check_inflight(struct request *rq, void *priv)
 	return true;
 }
 
-void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
-		unsigned int inflight[2])
+void blk_mq_in_driver_rw(struct block_device *part, unsigned int inflight[2])
 {
 	struct mq_inflight mi = { .part = part };
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
-	inflight[0] = mi.inflight[0];
-	inflight[1] = mi.inflight[1];
+	blk_mq_queue_tag_busy_iter(bdev_get_queue(part), blk_mq_check_in_driver,
+				   &mi);
+	inflight[READ] = mi.inflight[READ];
+	inflight[WRITE] = mi.inflight[WRITE];
 }
 
 #ifdef CONFIG_LOCKDEP
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a23d5812d08f..4205da1a4836 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -246,8 +246,7 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
-		unsigned int inflight[2]);
+void blk_mq_in_driver_rw(struct block_device *part, unsigned int inflight[2]);
 
 static inline void blk_mq_put_dispatch_budget(struct request_queue *q,
 					      int budget_token)
diff --git a/block/genhd.c b/block/genhd.c
index d158c25237b6..2470099b492b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -126,27 +126,32 @@ static void part_stat_read_all(struct block_device *part,
 }
 
 static void part_in_flight_rw(struct block_device *part,
-		unsigned int inflight[2])
+		unsigned int inflight[2], bool mq_driver)
 {
 	int cpu;
 
-	inflight[0] = 0;
-	inflight[1] = 0;
-	for_each_possible_cpu(cpu) {
-		inflight[0] += part_stat_local_read_cpu(part, in_flight[0], cpu);
-		inflight[1] += part_stat_local_read_cpu(part, in_flight[1], cpu);
+	if (mq_driver) {
+		blk_mq_in_driver_rw(part, inflight);
+	} else {
+		for_each_possible_cpu(cpu) {
+			inflight[READ] += part_stat_local_read_cpu(
+						part, in_flight[READ], cpu);
+			inflight[WRITE] += part_stat_local_read_cpu(
+						part, in_flight[WRITE], cpu);
+		}
 	}
-	if (WARN_ON_ONCE((int)inflight[0] < 0))
-		inflight[0] = 0;
-	if (WARN_ON_ONCE((int)inflight[1] < 0))
-		inflight[1] = 0;
+
+	if (WARN_ON_ONCE((int)inflight[READ] < 0))
+		inflight[READ] = 0;
+	if (WARN_ON_ONCE((int)inflight[WRITE] < 0))
+		inflight[WRITE] = 0;
 }
 
 unsigned int part_in_flight(struct block_device *part)
 {
-	unsigned int inflight[2];
+	unsigned int inflight[2] = {0};
 
-	part_in_flight_rw(part, inflight);
+	part_in_flight_rw(part, inflight, false);
 
 	return inflight[READ] + inflight[WRITE];
 }
@@ -1036,19 +1041,21 @@ ssize_t part_stat_show(struct device *dev,
 		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC));
 }
 
+/*
+ * Show the number of IOs issued to driver.
+ * For bio-based device, started from bdev_start_io_acct();
+ * For rq-based device, started from blk_mq_start_request();
+ */
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
 	struct request_queue *q = bdev_get_queue(bdev);
-	unsigned int inflight[2];
+	unsigned int inflight[2] = {0};
 
-	if (queue_is_mq(q))
-		blk_mq_in_flight_rw(q, bdev, inflight);
-	else
-		part_in_flight_rw(bdev, inflight);
+	part_in_flight_rw(bdev, inflight, queue_is_mq(q));
 
-	return sysfs_emit(buf, "%8u %8u\n", inflight[0], inflight[1]);
+	return sysfs_emit(buf, "%8u %8u\n", inflight[READ], inflight[WRITE]);
 }
 
 static ssize_t disk_capability_show(struct device *dev,
-- 
2.39.2


