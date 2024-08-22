Return-Path: <linux-raid+bounces-2536-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7A95AB70
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 04:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421112849E0
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 02:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011BF18454F;
	Thu, 22 Aug 2024 02:52:19 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346B50288;
	Thu, 22 Aug 2024 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295138; cv=none; b=POQZ9a3/i9yBa1I/AYOs5N2xMHPwaS8oxUsfmxf0x00s98dujJw6f+sp/c3ND8H3i0Tks+DqB3fTw8DssaPj7AKXukNiBrb3UFykDMZ/4e5XDhtZlqKS8tND1wPpvFsX/+fxqfPDGBgTi/CaVf8oFgIV9HRwDS8oMgxikfKmnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295138; c=relaxed/simple;
	bh=1PPeO2UDf5X5xK7PGUk7QedpS97sAZOqrja7N/GvlOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeWxrNeiySlyZuOoEzAxuCx/LhU7H2xvH/j3lHItaR0KMey3U6YXpKxw+omcV4Lq50cO94Jmgvzo+S0mqxhywIfQDhvQaVBI2NdvcBPx1j1uiuajc4PPSQ2b6fea4cV83YYUL6MbPo8ULTfZCYCaxD+XwDLnPkaxUZnlTLmd/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq75b03TQz4f3kp5;
	Thu, 22 Aug 2024 10:52:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ACE031A0359;
	Thu, 22 Aug 2024 10:52:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTNp8ZmyXl2CQ--.42363S32;
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
Subject: [PATCH md-6.12 28/41] md/md-bitmap: mrege md_bitmap_cond_end_sync() into bitmap_operations
Date: Thu, 22 Aug 2024 10:47:05 +0800
Message-Id: <20240822024718.2158259-29-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXPoTNp8ZmyXl2CQ--.42363S32
X-Coremail-Antispam: 1UD129KBjvJXoWxXFykAFyDAw1xKFW8uFWDCFg_yoWrZw1Dpa
	1DtFy3C345WFW5Xa4UA3yDuFyFyas7trZrKryxu34fuFyqgrnrGF4rGFyjq3WDKF13JFZ0
	qwn8Kr45Crn8Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 drivers/md/md-bitmap.c | 6 ++++--
 drivers/md/md-bitmap.h | 2 +-
 drivers/md/raid1.c     | 6 +++---
 drivers/md/raid10.c    | 2 +-
 drivers/md/raid5.c     | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b1f74bea8389..729cc7e2bb59 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1690,10 +1690,12 @@ static void bitmap_close_sync(struct mddev *mddev)
 	}
 }
 
-void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force)
+static void bitmap_cond_end_sync(struct mddev *mddev, sector_t sector,
+				 bool force)
 {
 	sector_t s = 0;
 	sector_t blocks;
+	struct bitmap *bitmap = mddev->bitmap;
 
 	if (!bitmap)
 		return;
@@ -1718,7 +1720,6 @@ void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force)
 	bitmap->last_end_sync = jiffies;
 	sysfs_notify_dirent_safe(bitmap->mddev->sysfs_completed);
 }
-EXPORT_SYMBOL(md_bitmap_cond_end_sync);
 
 void md_bitmap_sync_with_cluster(struct mddev *mddev,
 			      sector_t old_lo, sector_t old_hi,
@@ -2747,6 +2748,7 @@ static struct bitmap_operations bitmap_ops = {
 	.endwrite		= bitmap_endwrite,
 	.start_sync		= bitmap_start_sync,
 	.end_sync		= bitmap_end_sync,
+	.cond_end_sync		= bitmap_cond_end_sync,
 	.close_sync		= bitmap_close_sync,
 
 	.update_sb		= bitmap_update_sb,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 5d919b530317..027de097f96a 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -262,6 +262,7 @@ struct bitmap_operations {
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
+	void (*cond_end_sync)(struct mddev *mddev, sector_t sector, bool force);
 	void (*close_sync)(struct mddev *mddev);
 
 	void (*update_sb)(struct bitmap *bitmap);
@@ -272,7 +273,6 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are exported */
-void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force);
 void md_bitmap_sync_with_cluster(struct mddev *mddev,
 				 sector_t old_lo, sector_t old_hi,
 				 sector_t new_lo, sector_t new_hi);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 52ca5619d9b4..00174cacb1f4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2828,9 +2828,9 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 	 * sector_nr + two times RESYNC_SECTORS
 	 */
 
-	md_bitmap_cond_end_sync(mddev->bitmap, sector_nr,
-		mddev_is_clustered(mddev) && (sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
-
+	mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
+		mddev_is_clustered(mddev) &&
+		(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
 
 	if (raise_barrier(conf, sector_nr))
 		return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5b1c86c368b1..5a7b19f48c45 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3543,7 +3543,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		 * safety reason, which ensures curr_resync_completed is
 		 * updated in bitmap_cond_end_sync.
 		 */
-		md_bitmap_cond_end_sync(mddev->bitmap, sector_nr,
+		mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
 					mddev_is_clustered(mddev) &&
 					(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d2b8d2517abf..87b8d19ab601 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6540,7 +6540,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 		return sync_blocks * RAID5_STRIPE_SECTORS(conf);
 	}
 
-	md_bitmap_cond_end_sync(mddev->bitmap, sector_nr, false);
+	mddev->bitmap_ops->cond_end_sync(mddev, sector_nr, false);
 
 	sh = raid5_get_active_stripe(conf, NULL, sector_nr,
 				     R5_GAS_NOBLOCK);
-- 
2.39.2


