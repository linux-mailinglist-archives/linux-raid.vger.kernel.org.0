Return-Path: <linux-raid+bounces-3353-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACE9FC4F3
	for <lists+linux-raid@lfdr.de>; Wed, 25 Dec 2024 12:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1391643B0
	for <lists+linux-raid@lfdr.de>; Wed, 25 Dec 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5B1BC069;
	Wed, 25 Dec 2024 11:19:59 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2E18FC86;
	Wed, 25 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735125599; cv=none; b=UGkkL9KoTqbjjW4nrrL2Kl5lBbGP389w/Jit7UXruzovGDksEmIjcQRfKYq91mzVdj1Lf3hBQrcKgPrKIqRCL4N/CxQG0TFvLVyQ6KP0J/8jZKSWXWZ8jKtn+z2Ez1gr63+3D5ki+t+36gVGaz4ePrUZd/RhRtR/OarVb7wS82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735125599; c=relaxed/simple;
	bh=Y7xPG6kcT/0YPjguTLakMkGlV5w+mqkDFPwmeBeJvXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMVnDDZlnoYCVc+K4LaO7I/qfo7N44XH7ChrtrtJdKuCsKdUXMTI60yD2InM5bCl0mQKHaAh6h4jB2Nr6kjD+K3CSx4nBFeYlSvSvVUd2FV5j68jAaFjYvKF1yuthFZwK5frNzXIT0eXkS/1PCoDSoYMIg1TOVeLauULYVw/sYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJ8RT1Rpcz4f3kvs;
	Wed, 25 Dec 2024 19:19:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 03F641A018C;
	Wed, 25 Dec 2024 19:19:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnT4NV6mtntXlgFg--.39006S9;
	Wed, 25 Dec 2024 19:19:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.14 05/13] md/md-bitmap: handle the case bitmap is not enabled before end_sync()
Date: Wed, 25 Dec 2024 19:15:38 +0800
Message-Id: <20241225111546.1833250-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241225111546.1833250-1-yukuai1@huaweicloud.com>
References: <20241225111546.1833250-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnT4NV6mtntXlgFg--.39006S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDJF4fZr1fJry5tr4fXwb_yoWrGw4xp3
	9rJFy3Ww4UWFW5X3WUZrykuFyFv3srtrZFyFyxWas3uFyrXF9rJF4rWFyjqw1qka4SyFZ8
	X345CrW5CF1UWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

Prepare to build bitmap as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  4 ----
 drivers/md/md-bitmap.h | 11 +++++++++++
 drivers/md/raid1.c     |  6 +++---
 drivers/md/raid10.c    |  8 +++-----
 drivers/md/raid5.c     |  4 ++--
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index a4e390e93f8b..f87236225826 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1820,10 +1820,6 @@ static void __bitmap_end_sync(struct bitmap *bitmap, sector_t offset,
 	bitmap_counter_t *bmc;
 	unsigned long flags;
 
-	if (bitmap == NULL) {
-		*blocks = 1024;
-		return;
-	}
 	spin_lock_irqsave(&bitmap->counts.lock, flags);
 	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0);
 	if (bmc == NULL)
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 6a5806ebb11a..fefa00bc438e 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -145,4 +145,15 @@ static inline bool md_bitmap_start_sync(struct mddev *mddev, sector_t offset,
 	return mddev->bitmap_ops->start_sync(mddev, offset, blocks, degraded);
 }
 
+static inline void md_bitmap_end_sync(struct mddev *mddev, sector_t offset,
+				      sector_t *blocks)
+{
+	if (!md_bitmap_enabled(mddev)) {
+		*blocks = 1024;
+		return;
+	}
+
+	mddev->bitmap_ops->end_sync(mddev, offset, blocks);
+}
+
 #endif
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 967a8f048a8f..a931e52bdfe3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2075,7 +2075,7 @@ static void abort_sync_write(struct mddev *mddev, struct r1bio *r1_bio)
 
 	/* make sure these bits don't get cleared. */
 	do {
-		mddev->bitmap_ops->end_sync(mddev, s, &sync_blocks);
+		md_bitmap_end_sync(mddev, s, &sync_blocks);
 		s += sync_blocks;
 		sectors_to_go -= sync_blocks;
 	} while (sectors_to_go > 0);
@@ -2821,8 +2821,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		 * We can find the current addess in mddev->curr_resync
 		 */
 		if (mddev->curr_resync < max_sector) /* aborted */
-			mddev->bitmap_ops->end_sync(mddev, mddev->curr_resync,
-						    &sync_blocks);
+			md_bitmap_end_sync(mddev, mddev->curr_resync,
+					   &sync_blocks);
 		else /* completed sync */
 			conf->fullsync = 0;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ae30860490c5..96d610116a25 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3244,15 +3244,13 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 
 		if (mddev->curr_resync < max_sector) { /* aborted */
 			if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery))
-				mddev->bitmap_ops->end_sync(mddev,
-							    mddev->curr_resync,
-							    &sync_blocks);
+				md_bitmap_end_sync(mddev, mddev->curr_resync,
+						   &sync_blocks);
 			else for (i = 0; i < conf->geo.raid_disks; i++) {
 				sector_t sect =
 					raid10_find_virt(conf, mddev->curr_resync, i);
 
-				mddev->bitmap_ops->end_sync(mddev, sect,
-							    &sync_blocks);
+				md_bitmap_end_sync(mddev, sect, &sync_blocks);
 			}
 		} else {
 			/* completed sync */
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 38856d6c2eb0..e56766733418 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6492,8 +6492,8 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 		}
 
 		if (mddev->curr_resync < max_sector) /* aborted */
-			mddev->bitmap_ops->end_sync(mddev, mddev->curr_resync,
-						    &sync_blocks);
+			md_bitmap_end_sync(mddev, mddev->curr_resync,
+					   &sync_blocks);
 		else /* completed sync */
 			conf->fullsync = 0;
 		mddev->bitmap_ops->close_sync(mddev);
-- 
2.39.2


