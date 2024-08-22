Return-Path: <linux-raid+bounces-2528-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C895AB5C
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 04:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028AD1C24955
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872F481B4;
	Thu, 22 Aug 2024 02:52:14 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8B43165;
	Thu, 22 Aug 2024 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295134; cv=none; b=I5c73BGXrO/KlKqEtEwGBZ7XY1T8Nvj0XJxaL0/0tvP5ziIjjrlLShjyaVp0GicCewDYgo+PVHNnRErzjuKJZE+b/GqQK2yro3NMJzMbwzD4KiU/D+/esMHkM0k5BTp71B8Ue8dltrzh8+8wnOEuMtGnJOftbKIrXrCyCAQ4Z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295134; c=relaxed/simple;
	bh=QKgPFVW7ZTqkL+X5zdYjEd1FWsWP7acHPvSBRynfRDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZKsSrnCVOntS5a0z6ETl4kNX18rzZQlTEK5VtRl3Oku9IyORxNlBKChEmoF38jr65GLOlyaTj+1k34/r5EK+kRrTDRfFIYZhiZBmfszkkieqL8BaCzlbWmx2sxhv2UclMNeOeNqjiUYoctGFkR0XtUldE1YfpthlvGCmnTA4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq75W2vLRz4f3kp6;
	Thu, 22 Aug 2024 10:51:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1A46F1A0359;
	Thu, 22 Aug 2024 10:52:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTNp8ZmyXl2CQ--.42363S24;
	Thu, 22 Aug 2024 10:52:08 +0800 (CST)
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
Subject: [PATCH md-6.12 20/41] md/md-bitmap: merge bitmap_write_all() into bitmap_operations
Date: Thu, 22 Aug 2024 10:46:57 +0800
Message-Id: <20240822024718.2158259-21-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXPoTNp8ZmyXl2CQ--.42363S24
X-Coremail-Antispam: 1UD129KBjvJXoWxXFykAFyDAF4fuF1ktr1rCrg_yoW5AFyrpF
	W7Ka45ur45Jay3X3WUuFyDAFyY9w1ktrZrKrWfC3yruFyUAFnxGF1rWFWjywn5WFy3XFsx
	Zw45tryUWr18XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 drivers/md/md-bitmap.c | 14 +++++++-------
 drivers/md/md-bitmap.h |  3 +--
 drivers/md/md.c        |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e1ae50c7a551..f5ef058dcdce 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1224,22 +1224,21 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 	return ret;
 }
 
-void md_bitmap_write_all(struct bitmap *bitmap)
+/* just flag bitmap pages as needing to be written. */
+static void bitmap_write_all(struct mddev *mddev)
 {
-	/* We don't actually write all bitmap blocks here,
-	 * just flag them as needing to be written
-	 */
 	int i;
+	struct bitmap *bitmap = mddev->bitmap;
 
 	if (!bitmap || !bitmap->storage.filemap)
 		return;
+
+	/* Only one copy, so nothing needed */
 	if (bitmap->storage.file)
-		/* Only one copy, so nothing needed */
 		return;
 
 	for (i = 0; i < bitmap->storage.file_pages; i++)
-		set_page_attr(bitmap, i,
-			      BITMAP_PAGE_NEEDWRITE);
+		set_page_attr(bitmap, i, BITMAP_PAGE_NEEDWRITE);
 	bitmap->allclean = 0;
 }
 
@@ -2720,6 +2719,7 @@ static struct bitmap_operations bitmap_ops = {
 	.load			= bitmap_load,
 	.destroy		= bitmap_destroy,
 	.flush			= bitmap_flush,
+	.write_all		= bitmap_write_all,
 
 	.update_sb		= bitmap_update_sb,
 	.get_stats		= bitmap_get_stats,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 0bf16f0143ad..89cd60a7bb07 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -251,6 +251,7 @@ struct bitmap_operations {
 	int (*load)(struct mddev *mddev);
 	void (*destroy)(struct mddev *mddev);
 	void (*flush)(struct mddev *mddev);
+	void (*write_all)(struct mddev *mddev);
 
 	void (*update_sb)(struct bitmap *bitmap);
 	int (*get_stats)(struct bitmap *bitmap, struct md_bitmap_stats *stats);
@@ -261,8 +262,6 @@ void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are used only by md/bitmap */
 
-void md_bitmap_write_all(struct bitmap *bitmap);
-
 void md_bitmap_dirty_bits(struct bitmap *bitmap, unsigned long s, unsigned long e);
 
 /* these are exported */
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3a612094bc2d..17350adb675f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9545,7 +9545,7 @@ static void md_start_sync(struct work_struct *ws)
 	 * stored on all devices. So make sure all bitmap pages get written.
 	 */
 	if (spares)
-		md_bitmap_write_all(mddev->bitmap);
+		mddev->bitmap_ops->write_all(mddev);
 
 	name = test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) ?
 			"reshape" : "resync";
-- 
2.39.2


