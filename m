Return-Path: <linux-raid+bounces-3424-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8917A06AA1
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2025 03:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD673A8256
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2025 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A618732B;
	Thu,  9 Jan 2025 02:02:08 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E513633F;
	Thu,  9 Jan 2025 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388128; cv=none; b=BcOA7ZsqZq9uZKwgFCujFRxp4bKvmyprfivV5TQkvzYXmhQY2nN+xRK0Aq4knuin8NswRaak/PRhBtSBZIySvjNJBj3KqVpP3SnERnEbXd9A78t3nM3oKwBJr4u2hZmcefU/o8NKZsIzBwuCaEOYefm90wBrd70PnGmISv3mLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388128; c=relaxed/simple;
	bh=i5JHSVK3rMSjzjSSUNxL3y/t8Wi5BIJdDSUOueCrSMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKNjxFiFgpZwsxBGjppbcz1gKBVAQ9bP3RRXkBC/Bz4HyC+XBtIbLPAS4mK0SAnfUCWvmiB+q3on0C84rh0eBrPDsfKe9B3nWuOrAM4X1agqMXT4xoJ7y+gm+RGV1i66NFzEqj4Lg+yx/MTO8FyAsmAavM60S/twLtV2q/8jRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YT7M03qY1z4f3jqw;
	Thu,  9 Jan 2025 10:01:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8BF8B1A157D;
	Thu,  9 Jan 2025 10:02:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8XLn9nqDrAAQ--.985S11;
	Thu, 09 Jan 2025 10:02:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 md-6.14 07/12] md/raid1: check bitmap before behind write
Date: Thu,  9 Jan 2025 09:56:59 +0800
Message-Id: <20250109015704.216128-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250109015704.216128-1-yukuai1@huaweicloud.com>
References: <20250109015704.216128-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8XLn9nqDrAAQ--.985S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUuF17Xr47ZFWfGF1rJFb_yoWrJF1kpa
	9FqFn0krW5trW3XrnxAFykuFyrXw4ktr9rtrWfW34FgF12ywn0gF4FgFyrCrnxA3s3CF45
	Zw4Yyr1UWrWSqFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

behind write rely on bitmap, because the number of IO are recoreded in
bitmap->behind_writes, and callers rely on bitmap_wait_behind_writes()
to wait for IO to be done.

Hence if behind write start without bitmap, readers will not wait for
the IO to be done because bitmap_wait_behind_writes() do nothing,
and old data can be read.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  6 ------
 drivers/md/raid1.c     | 45 ++++++++++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index f87236225826..72cbbe0d3408 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2031,9 +2031,6 @@ static void bitmap_start_behind_write(struct mddev *mddev)
 	struct bitmap *bitmap = mddev->bitmap;
 	int bw;
 
-	if (!bitmap)
-		return;
-
 	atomic_inc(&bitmap->behind_writes);
 	bw = atomic_read(&bitmap->behind_writes);
 	if (bw > bitmap->behind_writes_used)
@@ -2047,9 +2044,6 @@ static void bitmap_end_behind_write(struct mddev *mddev)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
-	if (!bitmap)
-		return;
-
 	if (atomic_dec_and_test(&bitmap->behind_writes))
 		wake_up(&bitmap->behind_wait);
 	pr_debug("dec write-behind count %d/%lu\n",
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a94f71e79783..95dbf4aa5f64 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1367,7 +1367,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 				    (unsigned long long)r1_bio->sector,
 				    mirror->rdev->bdev);
 
-	if (test_bit(WriteMostly, &mirror->rdev->flags)) {
+	if (test_bit(WriteMostly, &mirror->rdev->flags) &&
+	    md_bitmap_enabled(mddev)) {
 		/*
 		 * Reading from a write-mostly device must take care not to
 		 * over-take any writes that are 'behind'
@@ -1454,6 +1455,30 @@ static bool wait_blocked_rdev(struct mddev *mddev, struct bio *bio)
 	return true;
 }
 
+static void raid1_start_write_behind(struct mddev *mddev, struct r1bio *r1_bio,
+				     struct bio *bio)
+{
+	unsigned long max_write_behind = mddev->bitmap_info.max_write_behind;
+	struct md_bitmap_stats stats;
+	int err;
+
+	/* behind write rely on bitmap, see bitmap_operations */
+	if (!md_bitmap_enabled(mddev))
+		return;
+
+	err = mddev->bitmap_ops->get_stats(mddev->bitmap, &stats);
+	if (err)
+		return;
+
+	/* Don't do behind IO if reader is waiting, or there are too many. */
+	if (!stats.behind_wait && stats.behind_writes < max_write_behind)
+		alloc_behind_master_bio(r1_bio, bio);
+
+	if (test_bit(R1BIO_BehindIO, &r1_bio->state))
+		mddev->bitmap_ops->start_behind_write(mddev);
+
+}
+
 static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				int max_write_sectors)
 {
@@ -1614,22 +1639,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			continue;
 
 		if (first_clone) {
-			unsigned long max_write_behind =
-				mddev->bitmap_info.max_write_behind;
-			struct md_bitmap_stats stats;
-			int err;
-
-			/* do behind I/O ?
-			 * Not if there are too many, or cannot
-			 * allocate memory, or a reader on WriteMostly
-			 * is waiting for behind writes to flush */
-			err = mddev->bitmap_ops->get_stats(mddev->bitmap, &stats);
-			if (!err && write_behind && !stats.behind_wait &&
-			    stats.behind_writes < max_write_behind)
-				alloc_behind_master_bio(r1_bio, bio);
-
-			if (test_bit(R1BIO_BehindIO, &r1_bio->state))
-				mddev->bitmap_ops->start_behind_write(mddev);
+			if (write_behind)
+				raid1_start_write_behind(mddev, r1_bio, bio);
 			first_clone = 0;
 		}
 
-- 
2.39.2


