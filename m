Return-Path: <linux-raid+bounces-4547-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89522AFA8F8
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 03:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3037177DF6
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 01:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE8820F09C;
	Mon,  7 Jul 2025 01:32:46 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7721F0995;
	Mon,  7 Jul 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851965; cv=none; b=eUrXJSpdWqExSN6EbOIZq1yrb5BhVaF5n906do2oH/YAHD6Lsjz11sXKfY9v/0sPtDaDEI2N/RjNo0zsi1hd5MoYCsogU2Wxr8S0x22vnGnkc+HW8Qy6xHv4FS+O5Vh1y6RY2Y0tP0zy3uXC4lonq0SfxLDCbxBE8RA/bgnjxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851965; c=relaxed/simple;
	bh=8CoZqNCRRTYz17njgyShz0XMTQ4HEpGLAhEoWfpWatk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p61j9iRZBUvVbECqICBCG0i0EHkMXrFJdZBvJpv/RWcKWN9fCOJtZM647AyshSbM/fEssLan9eyRJpYJzcLTowUEjHaGJ2UiYMyQZK96DmexKD7e+EdkZYkvwiVa34YRl/0Us2gVK4VCU5qBru1Dtkm524/VEvDdLpwX/Dpgz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bb6Dp493gzYQtvs;
	Mon,  7 Jul 2025 09:32:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 668EA1A13E5;
	Mon,  7 Jul 2025 09:32:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCazI2to_nSRAw--.35890S11;
	Mon, 07 Jul 2025 09:32:41 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v5 07/15] md/md-bitmap: handle the case bitmap is not enabled before start_sync()
Date: Mon,  7 Jul 2025 09:27:03 +0800
Message-Id: <20250707012711.376844-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250707012711.376844-1-yukuai1@huaweicloud.com>
References: <20250707012711.376844-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnSCazI2to_nSRAw--.35890S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr18JFyrAFW8tr4rGr4fAFb_yoW7AF4xpw
	s7JFy3Kw15WFW5X3W7CFyDuFyFywnrtFZrtr1fWw1fWFykGFykZF48WFyjqFyqgFyYyF98
	Xwn8CF45CryaqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This case can be handled without knowing internal implementation.

Prepare to introduce CONFIG_MD_BITMAP.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  8 +-------
 drivers/md/md-bitmap.h | 12 ++++++++++++
 drivers/md/raid1.c     |  6 +++---
 drivers/md/raid10.c    | 15 ++++++---------
 drivers/md/raid5.c     |  7 ++-----
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index da2dcb3d2122..ee676d4670ea 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1787,15 +1787,9 @@ static bool __bitmap_start_sync(struct bitmap *bitmap, sector_t offset,
 				sector_t *blocks, bool degraded)
 {
 	bitmap_counter_t *bmc;
-	bool rv;
+	bool rv = false;
 
-	if (bitmap == NULL) {/* FIXME or bitmap set as 'failed' */
-		*blocks = 1024;
-		return true; /* always resync if no bitmap */
-	}
 	spin_lock_irq(&bitmap->counts.lock);
-
-	rv = false;
 	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0);
 	if (bmc) {
 		/* locked */
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index a36ed32ec0d5..7a16de62ee35 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -124,4 +124,16 @@ static inline bool md_bitmap_enabled(struct mddev *mddev, bool flush)
 	return mddev->bitmap_ops->enabled(mddev->bitmap, flush);
 }
 
+static inline bool md_bitmap_start_sync(struct mddev *mddev, sector_t offset,
+					sector_t *blocks, bool degraded)
+{
+	/* always resync if no bitmap */
+	if (!md_bitmap_enabled(mddev, false)) {
+		*blocks = 1024;
+		return true;
+	}
+
+	return mddev->bitmap_ops->start_sync(mddev, offset, blocks, degraded);
+}
+
 #endif
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 39ebe0fadacd..1f3f2046afe0 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2828,7 +2828,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 	/* before building a request, check if we can skip these blocks..
 	 * This call the bitmap_start_sync doesn't actually record anything
 	 */
-	if (!mddev->bitmap_ops->start_sync(mddev, sector_nr, &sync_blocks, true) &&
+	if (!md_bitmap_start_sync(mddev, sector_nr, &sync_blocks, true) &&
 	    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
 		/* We can skip this block, and probably several more */
 		*skipped = 1;
@@ -3003,8 +3003,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (len == 0)
 			break;
 		if (sync_blocks == 0) {
-			if (!mddev->bitmap_ops->start_sync(mddev, sector_nr,
-						&sync_blocks, still_degraded) &&
+			if (!md_bitmap_start_sync(mddev, sector_nr,
+						  &sync_blocks, still_degraded) &&
 			    !conf->fullsync &&
 			    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 				break;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d2ef96be0150..764a8d99c45e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3346,9 +3346,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			 * we only need to recover the block if it is set in
 			 * the bitmap
 			 */
-			must_sync = mddev->bitmap_ops->start_sync(mddev, sect,
-								  &sync_blocks,
-								  true);
+			must_sync = md_bitmap_start_sync(mddev, sect,
+							 &sync_blocks, true);
 			if (sync_blocks < max_sync)
 				max_sync = sync_blocks;
 			if (!must_sync &&
@@ -3391,9 +3390,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				}
 			}
 
-			must_sync = mddev->bitmap_ops->start_sync(mddev, sect,
-						&sync_blocks, still_degraded);
-
+			md_bitmap_start_sync(mddev, sect, &sync_blocks,
+					     still_degraded);
 			any_working = 0;
 			for (j=0; j<conf->copies;j++) {
 				int k;
@@ -3569,9 +3567,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 					mddev_is_clustered(mddev) &&
 					(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
 
-		if (!mddev->bitmap_ops->start_sync(mddev, sector_nr,
-						   &sync_blocks,
-						   mddev->degraded) &&
+		if (!md_bitmap_start_sync(mddev, sector_nr, &sync_blocks,
+					  mddev->degraded) &&
 		    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED,
 						 &mddev->recovery)) {
 			/* We can skip this block */
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 999752ec636e..8168acf7d3e7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6525,8 +6525,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	}
 	if (!test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    !conf->fullsync &&
-	    !mddev->bitmap_ops->start_sync(mddev, sector_nr, &sync_blocks,
-					   true) &&
+	    !md_bitmap_start_sync(mddev, sector_nr, &sync_blocks, true) &&
 	    sync_blocks >= RAID5_STRIPE_SECTORS(conf)) {
 		/* we can skip this block, and probably more */
 		do_div(sync_blocks, RAID5_STRIPE_SECTORS(conf));
@@ -6557,9 +6556,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 			still_degraded = true;
 	}
 
-	mddev->bitmap_ops->start_sync(mddev, sector_nr, &sync_blocks,
-				      still_degraded);
-
+	md_bitmap_start_sync(mddev, sector_nr, &sync_blocks, still_degraded);
 	set_bit(STRIPE_SYNC_REQUESTED, &sh->state);
 	set_bit(STRIPE_HANDLE, &sh->state);
 
-- 
2.39.2


