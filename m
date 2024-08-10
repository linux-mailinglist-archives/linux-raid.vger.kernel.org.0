Return-Path: <linux-raid+bounces-2369-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE594DA16
	for <lists+linux-raid@lfdr.de>; Sat, 10 Aug 2024 04:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553981C23166
	for <lists+linux-raid@lfdr.de>; Sat, 10 Aug 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04201581FB;
	Sat, 10 Aug 2024 02:13:08 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7914B942;
	Sat, 10 Aug 2024 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723255988; cv=none; b=Xx8PaEBBaDSjTlRtW/hTIGti+Rb11Q2Y/H/G/4IJ54X+KqYBgm++RzmUZYHuXxIEvu9EEUzGztfZa3DfVu/J56TwizTLwqv0LDXqyUTlo5BrbShChatv7ujRTOwZUDu1PyETmM+Yik3tlHrGV2VTAQbYyGzVu0X1mEDhuHVtUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723255988; c=relaxed/simple;
	bh=XmTlWSY9JEvzY71VPDRjCfrFkCWCvam1DQ0Vrwpazu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uV7zLVJ+Wn2rcAEV7EWr0YVgjd6b7vg342WUtW0GPS7wnAFRcvXCZefqTM7ZJ8oysBP9j5Wzv5X3iwip6He3rb8KOFNy7SXb6BPBfkZospURX2utSDICejoyyPn1PQx3qfqJW927lOOF4xJfdSfEBoimigfST/q2N/QbveIiC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wgknn41BRz4f3jJ4;
	Sat, 10 Aug 2024 10:12:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1399D1A0359;
	Sat, 10 Aug 2024 10:12:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WizLZmErwLBQ--.1937S23;
	Sat, 10 Aug 2024 10:12:58 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next 19/26] md/md-bitmap: merge md_bitmap_resize() into bitmap_operations
Date: Sat, 10 Aug 2024 10:08:47 +0800
Message-Id: <20240810020854.797814-20-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240810020854.797814-1-yukuai1@huaweicloud.com>
References: <20240810020854.797814-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4WizLZmErwLBQ--.1937S23
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1xKr43Gr1fXr4DCFyUJrb_yoWxKry5pa
	yUtF9xC345GFW3Wa1UZFykuF1Fv34ktr9rtryxC34ruFy7XFnxCF4rWFyjq3WUKa45JFs8
	Xan8JrW5CF1kXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPU
	UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that the implementation won't be exposed, and it'll be possible
to invent a new bitmap by replacing bitmap_operations.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c    |  2 +-
 drivers/md/md-bitmap.c  | 11 +++++++----
 drivers/md/md-bitmap.h  | 13 +++++++++++--
 drivers/md/md-cluster.c |  4 ++--
 drivers/md/raid1.c      |  2 +-
 drivers/md/raid10.c     |  8 ++++----
 drivers/md/raid5.c      |  2 +-
 7 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 0c3323e0adb2..6342775c79dd 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4066,7 +4066,7 @@ static int raid_preresume(struct dm_target *ti)
 	       mddev->bitmap_info.chunksize != to_bytes(rs->requested_bitmap_chunk_sectors)))) {
 		int chunksize = to_bytes(rs->requested_bitmap_chunk_sectors) ?: mddev->bitmap_info.chunksize;
 
-		r = md_bitmap_resize(mddev->bitmap, mddev->dev_sectors, chunksize, 0);
+		r = md_bitmap_resize(mddev, mddev->dev_sectors, chunksize, 0);
 		if (r)
 			DMERR("Failed to resize bitmap");
 	}
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 8828175ad442..ed43139b52f4 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -32,6 +32,9 @@
 #include "md.h"
 #include "md-bitmap.h"
 
+static int bitmap_resize(struct bitmap *bitmap, sector_t blocks,
+			 int chunksize, int init);
+
 static inline char *bmname(struct bitmap *bitmap)
 {
 	return bitmap->mddev ? mdname(bitmap->mddev) : "mdX";
@@ -1936,7 +1939,7 @@ static struct bitmap *bitmap_create(struct mddev *mddev, int slot)
 		goto error;
 
 	bitmap->daemon_lastrun = jiffies;
-	err = md_bitmap_resize(bitmap, blocks, mddev->bitmap_info.chunksize, 1);
+	err = bitmap_resize(bitmap, blocks, mddev->bitmap_info.chunksize, 1);
 	if (err)
 		goto error;
 
@@ -2108,8 +2111,8 @@ static void bitmap_status(struct seq_file *seq, struct bitmap *bitmap)
 	seq_printf(seq, "\n");
 }
 
-int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
-		  int chunksize, int init)
+static int bitmap_resize(struct bitmap *bitmap, sector_t blocks,
+			 int chunksize, int init)
 {
 	/* If chunk_size is 0, choose an appropriate chunk size.
 	 * Then possibly allocate new storage space.
@@ -2314,7 +2317,6 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 err:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(md_bitmap_resize);
 
 static ssize_t
 location_show(struct mddev *mddev, char *page)
@@ -2712,6 +2714,7 @@ static struct bitmap_operations bitmap_ops = {
 	.cond_end_sync		= bitmap_cond_end_sync,
 
 	.update_sb		= bitmap_update_sb,
+	.resize			= bitmap_resize,
 	.sync_with_cluster	= bitmap_sync_with_cluster,
 };
 
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 5a77b6d8358b..37edf8626a60 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -255,6 +255,8 @@ struct bitmap_operations {
 	void (*cond_end_sync)(struct bitmap *bitmap, sector_t sector, bool force);
 
 	void (*update_sb)(struct bitmap *bitmap);
+	int (*resize)(struct bitmap *bitmap, sector_t blocks, int chunksize,
+		      int init);
 	void (*sync_with_cluster)(struct bitmap *bitmap,
 				  sector_t old_lo, sector_t old_hi,
 				  sector_t new_lo, sector_t new_hi);
@@ -389,6 +391,15 @@ static inline void md_bitmap_cond_end_sync(struct mddev *mddev, sector_t sector,
 	mddev->bitmap_ops->cond_end_sync(mddev->bitmap, sector, force);
 }
 
+static inline int md_bitmap_resize(struct mddev *mddev, sector_t blocks,
+				   int chunksize, int init)
+{
+	if (!mddev->bitmap || !mddev->bitmap_ops->resize)
+		return -EOPNOTSUPP;
+
+	return mddev->bitmap_ops->resize(mddev->bitmap, blocks, chunksize, init);
+}
+
 static inline void md_bitmap_sync_with_cluster(struct mddev *mddev,
 					       sector_t old_lo, sector_t old_hi,
 					       sector_t new_lo, sector_t new_hi)
@@ -404,8 +415,6 @@ void md_bitmap_unplug(struct bitmap *bitmap);
 void md_bitmap_unplug_async(struct bitmap *bitmap);
 void md_bitmap_daemon_work(struct mddev *mddev);
 
-int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
-		     int chunksize, int init);
 struct bitmap *get_bitmap_from_slot(struct mddev *mddev, int slot);
 int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
 			     sector_t *lo, sector_t *hi, bool clear_bits);
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 79e67393fee0..d843ea190e7b 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -628,8 +628,8 @@ static int process_recvd_msg(struct mddev *mddev, struct cluster_msg *msg)
 		break;
 	case BITMAP_RESIZE:
 		if (le64_to_cpu(msg->high) != mddev->pers->size(mddev, 0, 0))
-			ret = md_bitmap_resize(mddev->bitmap,
-					    le64_to_cpu(msg->high), 0, 0);
+			ret = md_bitmap_resize(mddev, le64_to_cpu(msg->high), 0,
+					       0);
 		break;
 	default:
 		ret = -1;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c8cd6036441b..fef69fce586c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3311,7 +3311,7 @@ static int raid1_resize(struct mddev *mddev, sector_t sectors)
 	    mddev->array_sectors > newsize)
 		return -EINVAL;
 	if (mddev->bitmap) {
-		int ret = md_bitmap_resize(mddev->bitmap, newsize, 0, 0);
+		int ret = md_bitmap_resize(mddev, newsize, 0, 0);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 1ea9b4117b08..a8a14cda8446 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4201,7 +4201,7 @@ static int raid10_resize(struct mddev *mddev, sector_t sectors)
 	    mddev->array_sectors > size)
 		return -EINVAL;
 	if (mddev->bitmap) {
-		int ret = md_bitmap_resize(mddev->bitmap, size, 0, 0);
+		int ret = md_bitmap_resize(mddev, size, 0, 0);
 		if (ret)
 			return ret;
 	}
@@ -4470,7 +4470,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 		newsize = raid10_size(mddev, 0, conf->geo.raid_disks);
 
 		if (!mddev_is_clustered(mddev)) {
-			ret = md_bitmap_resize(mddev->bitmap, newsize, 0, 0);
+			ret = md_bitmap_resize(mddev, newsize, 0, 0);
 			if (ret)
 				goto abort;
 			else
@@ -4492,13 +4492,13 @@ static int raid10_start_reshape(struct mddev *mddev)
 			    MD_FEATURE_RESHAPE_ACTIVE)) || (oldsize == newsize))
 			goto out;
 
-		ret = md_bitmap_resize(mddev->bitmap, newsize, 0, 0);
+		ret = md_bitmap_resize(mddev, newsize, 0, 0);
 		if (ret)
 			goto abort;
 
 		ret = md_cluster_ops->resize_bitmaps(mddev, newsize, oldsize);
 		if (ret) {
-			md_bitmap_resize(mddev->bitmap, oldsize, 0, 0);
+			md_bitmap_resize(mddev, oldsize, 0, 0);
 			goto abort;
 		}
 	}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8f0de56c0b23..8b1e2157a798 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8320,7 +8320,7 @@ static int raid5_resize(struct mddev *mddev, sector_t sectors)
 	    mddev->array_sectors > newsize)
 		return -EINVAL;
 	if (mddev->bitmap) {
-		int ret = md_bitmap_resize(mddev->bitmap, sectors, 0, 0);
+		int ret = md_bitmap_resize(mddev, sectors, 0, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.39.2


