Return-Path: <linux-raid+bounces-2396-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C12951530
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634741F227A8
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08619149C63;
	Wed, 14 Aug 2024 07:15:36 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59851140E5F;
	Wed, 14 Aug 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619735; cv=none; b=pkLsbMxAMP3oM52Z1P6KzYPmJIHomVMCwswuKmA5QrwK9/FQ5R7VAkVg2vqvZJapJ0H7j++ASAoSaNVmTLY15wlPa3lorkkFl6ZjNo+TDnBo41m7s0I67uBN3Wqt61SmT6kgZXvtYZ4sNv+j0cSHRVvydEr8UhAPsUbP5GiiFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619735; c=relaxed/simple;
	bh=AnENahYkPmG6i5Ytg6ZECeiOzlq1H2+LKCBueTKpQ88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpSU/KCLVuvjQgHIqYGk2kID0IcrjcjVS3UMqa7FSECJY3t7/Xr50i7LhM9xyYnKbqznuUHJkNy5mQBEgI6A/bAK6W7LNSULRh1oI5I5zaWW8eRU1/OQjvVwMKhfYSYzcLR50spCH6s2nwziJXB6q8/s6Vz3s+8+N9KKsMlVJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkKJz5F8rz4f3kvs;
	Wed, 14 Aug 2024 15:15:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1A61A06DA;
	Wed, 14 Aug 2024 15:15:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHboSLWbxmIxKbBg--.47745S15;
	Wed, 14 Aug 2024 15:15:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mariusz.tkaczyk@linux.intel.com,
	hch@infradead.org,
	song@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next v2 11/41] md/md-bitmap: simplify md_bitmap_create() + md_bitmap_load()
Date: Wed, 14 Aug 2024 15:10:43 +0800
Message-Id: <20240814071113.346781-12-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814071113.346781-1-yukuai1@huaweicloud.com>
References: <20240814071113.346781-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboSLWbxmIxKbBg--.47745S15
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWkCF45Zr4xCry7ZryDAwb_yoWrKw4fpw
	s7t3Z8GrW3JrW3Wr17ZFyq93WYqr1vgr9rtryxGw1ruF13AFnxuF4rWF10y34jkFyrJFsx
	Xw45Kr1UCF47Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQFxUU
	UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Other than internal api get_bitmap_from_slot(), all other places will
set returned bitmap to mddev->bitmap. So move the setting of
mddev->bitmap into md_bitmap_create() to simplify code.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 23 +++++++++++++++--------
 drivers/md/md-bitmap.h |  2 +-
 drivers/md/md.c        | 30 +++++++++---------------------
 3 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index eed3b930ade4..75e58da9a1a5 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1879,7 +1879,7 @@ void md_bitmap_destroy(struct mddev *mddev)
  * if this returns an error, bitmap_destroy must be called to do clean up
  * once mddev->bitmap is set
  */
-struct bitmap *md_bitmap_create(struct mddev *mddev, int slot)
+static struct bitmap *bitmap_create(struct mddev *mddev, int slot)
 {
 	struct bitmap *bitmap;
 	sector_t blocks = mddev->resync_max_sectors;
@@ -1966,6 +1966,17 @@ struct bitmap *md_bitmap_create(struct mddev *mddev, int slot)
 	return ERR_PTR(err);
 }
 
+int md_bitmap_create(struct mddev *mddev, int slot)
+{
+	struct bitmap *bitmap = bitmap_create(mddev, slot);
+
+	if (IS_ERR(bitmap))
+		return PTR_ERR(bitmap);
+
+	mddev->bitmap = bitmap;
+	return 0;
+}
+
 int md_bitmap_load(struct mddev *mddev)
 {
 	int err = 0;
@@ -2030,7 +2041,7 @@ struct bitmap *get_bitmap_from_slot(struct mddev *mddev, int slot)
 	int rv = 0;
 	struct bitmap *bitmap;
 
-	bitmap = md_bitmap_create(mddev, slot);
+	bitmap = bitmap_create(mddev, slot);
 	if (IS_ERR(bitmap)) {
 		rv = PTR_ERR(bitmap);
 		return ERR_PTR(rv);
@@ -2381,7 +2392,6 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 	} else {
 		/* No bitmap, OK to set a location */
 		long long offset;
-		struct bitmap *bitmap;
 
 		if (strncmp(buf, "none", 4) == 0)
 			/* nothing to be done */;
@@ -2408,13 +2418,10 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			}
 
 			mddev->bitmap_info.offset = offset;
-			bitmap = md_bitmap_create(mddev, -1);
-			if (IS_ERR(bitmap)) {
-				rv = PTR_ERR(bitmap);
+			rv = md_bitmap_create(mddev, -1);
+			if (rv)
 				goto out;
-			}
 
-			mddev->bitmap = bitmap;
 			rv = md_bitmap_load(mddev);
 			if (rv) {
 				mddev->bitmap_info.offset = 0;
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index a8a5d4804174..e187f9099f2e 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -252,7 +252,7 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are used only by md/bitmap */
-struct bitmap *md_bitmap_create(struct mddev *mddev, int slot);
+int md_bitmap_create(struct mddev *mddev, int slot);
 int md_bitmap_load(struct mddev *mddev);
 void md_bitmap_flush(struct mddev *mddev);
 void md_bitmap_destroy(struct mddev *mddev);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f67f2540fd6c..6e130f6c2abd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6211,16 +6211,10 @@ int md_run(struct mddev *mddev)
 	}
 	if (err == 0 && pers->sync_request &&
 	    (mddev->bitmap_info.file || mddev->bitmap_info.offset)) {
-		struct bitmap *bitmap;
-
-		bitmap = md_bitmap_create(mddev, -1);
-		if (IS_ERR(bitmap)) {
-			err = PTR_ERR(bitmap);
+		err = md_bitmap_create(mddev, -1);
+		if (err)
 			pr_warn("%s: failed to create bitmap (%d)\n",
 				mdname(mddev), err);
-		} else
-			mddev->bitmap = bitmap;
-
 	}
 	if (err)
 		goto bitmap_abort;
@@ -7275,14 +7269,10 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 	err = 0;
 	if (mddev->pers) {
 		if (fd >= 0) {
-			struct bitmap *bitmap;
-
-			bitmap = md_bitmap_create(mddev, -1);
-			if (!IS_ERR(bitmap)) {
-				mddev->bitmap = bitmap;
+			err = md_bitmap_create(mddev, -1);
+			if (!err)
 				err = md_bitmap_load(mddev);
-			} else
-				err = PTR_ERR(bitmap);
+
 			if (err) {
 				md_bitmap_destroy(mddev);
 				fd = -1;
@@ -7291,6 +7281,7 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 			md_bitmap_destroy(mddev);
 		}
 	}
+
 	if (fd < 0) {
 		struct file *f = mddev->bitmap_info.file;
 		if (f) {
@@ -7559,7 +7550,6 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 			goto err;
 		}
 		if (info->state & (1<<MD_SB_BITMAP_PRESENT)) {
-			struct bitmap *bitmap;
 			/* add the bitmap */
 			if (mddev->bitmap) {
 				rv = -EEXIST;
@@ -7573,12 +7563,10 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				mddev->bitmap_info.default_offset;
 			mddev->bitmap_info.space =
 				mddev->bitmap_info.default_space;
-			bitmap = md_bitmap_create(mddev, -1);
-			if (!IS_ERR(bitmap)) {
-				mddev->bitmap = bitmap;
+			rv = md_bitmap_create(mddev, -1);
+			if (!rv)
 				rv = md_bitmap_load(mddev);
-			} else
-				rv = PTR_ERR(bitmap);
+
 			if (rv)
 				md_bitmap_destroy(mddev);
 		} else {
-- 
2.39.2


