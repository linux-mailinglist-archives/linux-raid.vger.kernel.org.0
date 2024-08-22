Return-Path: <linux-raid+bounces-2535-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C695AB6C
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 04:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978CD1C24D5E
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 02:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5BA17C95;
	Thu, 22 Aug 2024 02:52:18 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0117B50E;
	Thu, 22 Aug 2024 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295137; cv=none; b=rlN0GRGf78Fdju5FZn4YvlGDdy5U7feK0DDwR/ryJt8uQsnlrxedH/9bxoUwk0S4u5WSdjBuFxfgUKuaJDN77JNkZwk5FhBbB9VcpW0XGdetqG4Bh4ZIJuGE6M6JHYiK/Dt68EK0NGkdyVT20a0nR0gnigDugtJ0KnPBBb606Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295137; c=relaxed/simple;
	bh=Vj5Gac9CmBefiw3VukvZfCp/6CCYt8ROz9zkwa74xpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpGbfsNybuM4iHV40+IyI/O6YKIiQTiluCtwGv5tTjbU2Qh5MKdGH+NFEJsOuSsUXMDVSdlmd6op3DKazdyUyO+QHRv2Ib5Y9/X0m3PA59vP4MV0hNgfz7r4TMXgr47LcBkFAUbKn8JSqFguBEvPhMnNKq/4WixXuTAeWm4EIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq75T0pJbz4f3nJp;
	Thu, 22 Aug 2024 10:51:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3E4AA1A18C2;
	Thu, 22 Aug 2024 10:52:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTNp8ZmyXl2CQ--.42363S31;
	Thu, 22 Aug 2024 10:52:12 +0800 (CST)
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
Subject: [PATCH md-6.12 27/41] md/md-bitmap: merge md_bitmap_close_sync() into bitmap_operations
Date: Thu, 22 Aug 2024 10:47:04 +0800
Message-Id: <20240822024718.2158259-28-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXPoTNp8ZmyXl2CQ--.42363S31
X-Coremail-Antispam: 1UD129KBjvJXoWxXFykAFyDAFW8Jr1rKFWrGrg_yoWrZF1kpa
	1DJFy3C3y5WFW3X34UA34Dua4Fyas7trZrKryfG3s3uFykXF9xGF4rGa4jq3Z0gF13AFs8
	Zwn8trW5CryUXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
bitmap outside md-bitmap.c as much as possible.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 9 ++++++---
 drivers/md/md-bitmap.h | 2 +-
 drivers/md/raid1.c     | 2 +-
 drivers/md/raid10.c    | 2 +-
 drivers/md/raid5.c     | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index c03e94416191..b1f74bea8389 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1671,7 +1671,7 @@ static void bitmap_end_sync(struct mddev *mddev, sector_t offset,
 	__bitmap_end_sync(mddev->bitmap, offset, blocks, true);
 }
 
-void md_bitmap_close_sync(struct bitmap *bitmap)
+static void bitmap_close_sync(struct mddev *mddev)
 {
 	/* Sync has finished, and any bitmap chunks that weren't synced
 	 * properly have been aborted.  It remains to us to clear the
@@ -1679,14 +1679,16 @@ void md_bitmap_close_sync(struct bitmap *bitmap)
 	 */
 	sector_t sector = 0;
 	sector_t blocks;
+	struct bitmap *bitmap = mddev->bitmap;
+
 	if (!bitmap)
 		return;
+
 	while (sector < bitmap->mddev->resync_max_sectors) {
 		__bitmap_end_sync(bitmap, sector, &blocks, false);
 		sector += blocks;
 	}
 }
-EXPORT_SYMBOL(md_bitmap_close_sync);
 
 void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force)
 {
@@ -2017,7 +2019,7 @@ static int bitmap_load(struct mddev *mddev)
 		bitmap_start_sync(mddev, sector, &blocks, false);
 		sector += blocks;
 	}
-	md_bitmap_close_sync(bitmap);
+	bitmap_close_sync(mddev);
 
 	if (mddev->degraded == 0
 	    || bitmap->events_cleared == mddev->events)
@@ -2745,6 +2747,7 @@ static struct bitmap_operations bitmap_ops = {
 	.endwrite		= bitmap_endwrite,
 	.start_sync		= bitmap_start_sync,
 	.end_sync		= bitmap_end_sync,
+	.close_sync		= bitmap_close_sync,
 
 	.update_sb		= bitmap_update_sb,
 	.get_stats		= bitmap_get_stats,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index d6f2d5979da4..5d919b530317 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -262,6 +262,7 @@ struct bitmap_operations {
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
+	void (*close_sync)(struct mddev *mddev);
 
 	void (*update_sb)(struct bitmap *bitmap);
 	int (*get_stats)(struct bitmap *bitmap, struct md_bitmap_stats *stats);
@@ -271,7 +272,6 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are exported */
-void md_bitmap_close_sync(struct bitmap *bitmap);
 void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force);
 void md_bitmap_sync_with_cluster(struct mddev *mddev,
 				 sector_t old_lo, sector_t old_hi,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e5942f0d6fd2..52ca5619d9b4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2790,7 +2790,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		else /* completed sync */
 			conf->fullsync = 0;
 
-		md_bitmap_close_sync(mddev->bitmap);
+		mddev->bitmap_ops->close_sync(mddev);
 		close_sync(conf);
 
 		if (mddev_is_clustered(mddev)) {
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 15299a7774a0..5b1c86c368b1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3222,7 +3222,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			}
 			conf->fullsync = 0;
 		}
-		md_bitmap_close_sync(mddev->bitmap);
+		mddev->bitmap_ops->close_sync(mddev);
 		close_sync(conf);
 		*skipped = 1;
 		return sectors_skipped;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 89ae149bf28e..d2b8d2517abf 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6501,7 +6501,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 						    &sync_blocks);
 		else /* completed sync */
 			conf->fullsync = 0;
-		md_bitmap_close_sync(mddev->bitmap);
+		mddev->bitmap_ops->close_sync(mddev);
 
 		return 0;
 	}
-- 
2.39.2


