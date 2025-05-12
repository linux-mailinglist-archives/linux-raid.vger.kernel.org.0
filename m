Return-Path: <linux-raid+bounces-4143-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4BAB2CCB
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 03:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171273B6991
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB41E47B7;
	Mon, 12 May 2025 01:28:09 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41501E25F8;
	Mon, 12 May 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013288; cv=none; b=fBk0Zn9S0EEMSOFGKTZ12v1uJ3XQQoezn/gH35dXTODRqolZkrINhvHwbuuhrA1Qq7cz2LV6Z5M4qiv4dw9FAiD4qukNoyev1tCmq4eYZ0epRQdZ6SjfaButVaUW4YLoECbDJSBiG5wHqmVEHPSUMp0uMzYFML8c19WDqvnhUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013288; c=relaxed/simple;
	bh=JibtT05TCheH4YuVehMkAmbTROjLiDkuWNcWwRILQfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qq20JheNbPXogeQIgvZLFRiycJcY9VzNsw62tVVs7JhVAI8+mj6gr/FMdj9Pk23zJitJw1k5EA5TTb/jxo1ufpIry8ZAaouvJbOErZDHOcDuSZz8YjDbp9WCCzm3ZqPRXB7FMcz/pGK735+/Lk8BXvfc3dqFGQygbA8odS+OTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zwhmp47mSz4f3jXd;
	Mon, 12 May 2025 09:27:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 456ED1A1A98;
	Mon, 12 May 2025 09:28:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CdTiFoNFCWMA--.55093S6;
	Mon, 12 May 2025 09:28:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	xni@redhat.com,
	colyli@kernel.org,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC md-6.16 v3 02/19] md: support discard for bitmap ops
Date: Mon, 12 May 2025 09:19:10 +0800
Message-Id: <20250512011927.2809400-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2CdTiFoNFCWMA--.55093S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWxGr1kGFyxtw43Jr1xGrg_yoW8KrW8pF
	4IvFyrJFW3XrZY9ay7Za4v9F1Fqw1DGrZ8tFy7Ww45WF18Gr9xAF4fWa4vvr15CFy3uF1a
	va1FkF13Wr18XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

If {start, end}_discard is implemented from bitmap_operations, then they
will be used to handle discard IO. Currently md-bitmap handle discard
the same as normal write, prepare to support discard for new md bitmap.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 19 +++++++++++++++----
 drivers/md/md.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 32b997dfe6f4..c72c13ed4253 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8849,14 +8849,24 @@ static void md_bitmap_start(struct mddev *mddev,
 		mddev->pers->bitmap_sector(mddev, &md_io_clone->offset,
 					   &md_io_clone->sectors);
 
-	mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
-				      md_io_clone->sectors);
+	if (unlikely(md_io_clone->rw == STAT_DISCARD) &&
+	    mddev->bitmap_ops->start_discard)
+		mddev->bitmap_ops->start_discard(mddev, md_io_clone->offset,
+						 md_io_clone->sectors);
+	else
+		mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
+					      md_io_clone->sectors);
 }
 
 static void md_bitmap_end(struct mddev *mddev, struct md_io_clone *md_io_clone)
 {
-	mddev->bitmap_ops->endwrite(mddev, md_io_clone->offset,
-				    md_io_clone->sectors);
+	if (unlikely(md_io_clone->rw == STAT_DISCARD) &&
+	    mddev->bitmap_ops->end_discard)
+		mddev->bitmap_ops->end_discard(mddev, md_io_clone->offset,
+					       md_io_clone->sectors);
+	else
+		mddev->bitmap_ops->endwrite(mddev, md_io_clone->offset,
+					    md_io_clone->sectors);
 }
 
 static void md_end_clone_io(struct bio *bio)
@@ -8895,6 +8905,7 @@ static void md_clone_bio(struct mddev *mddev, struct bio **bio)
 	if (bio_data_dir(*bio) == WRITE && md_bitmap_enabled(mddev)) {
 		md_io_clone->offset = (*bio)->bi_iter.bi_sector;
 		md_io_clone->sectors = bio_sectors(*bio);
+		md_io_clone->rw = op_stat_group(bio_op(*bio));
 		md_bitmap_start(mddev, md_io_clone);
 	}
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 6eb5dfdf2f55..c474bf74c345 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -850,6 +850,7 @@ struct md_io_clone {
 	unsigned long	start_time;
 	sector_t	offset;
 	unsigned long	sectors;
+	enum stat_group	rw;
 	struct bio	bio_clone;
 };
 
-- 
2.39.2


