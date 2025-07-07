Return-Path: <linux-raid+bounces-4551-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A956AFA904
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 03:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699E5178D46
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5721C19A;
	Mon,  7 Jul 2025 01:32:49 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34E20FAAB;
	Mon,  7 Jul 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851968; cv=none; b=aCqb24Q8M5n0oHenlHDhr/Vhhpt1dy6OYeMHweWil070ACdXxIinHo8ShXj5dUUGSrI0/SveWuF9e3Kr5fam1mn8YhNUGZKFOruXTC/1h0/Ga7l6mEcHUVn0kvqslDI6AfXsNGFOapK9B9nnpls/AVtYhO6Auytnzjum56bTfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851968; c=relaxed/simple;
	bh=sCFJwX+L8hE6qow8qcXmKz4PdYwVNYDG4IGLshNX0us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F3GEGHGJxEgzOtwhUsFz9A0+eZ+BuM/ASk48GBj/bVAbowHoExmk/iyBfvWfQoemrgT9csH0qf22dGiz5LTe+gdroZcGrI+vzZl606CEAQkfXrCgBkpiWGlOA2wPitzyOMmGB9VbjRPUPoNFJGvtQse3HrAdkZ8xDcf0bI3cPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bb6Ds2Tt6zYQtsQ;
	Mon,  7 Jul 2025 09:32:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2AB411A0FED;
	Mon,  7 Jul 2025 09:32:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCazI2to_nSRAw--.35890S16;
	Mon, 07 Jul 2025 09:32:43 +0800 (CST)
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
Subject: [PATCH v5 12/15] md/raid5: check before referencing mddev->bitmap_ops
Date: Mon,  7 Jul 2025 09:27:08 +0800
Message-Id: <20250707012711.376844-13-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDnSCazI2to_nSRAw--.35890S16
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4DJF15uFy7AFW5KrykXwb_yoW8tFWfp3
	9rtFyaqry5ZrZagw4DJFykuF1Fvasrtr9rtryfWwn3Wwn7Gr9rWF4rWFyjqF1jya4rZFWr
	Jay5AF15CF13WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Prepare to introduce CONFIG_MD_BITMAP.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 156504ed0dd4..519bbfb67dcb 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6496,7 +6496,8 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 					   &sync_blocks);
 		else /* completed sync */
 			conf->fullsync = 0;
-		mddev->bitmap_ops->close_sync(mddev);
+		if (md_bitmap_enabled(mddev, false))
+			mddev->bitmap_ops->close_sync(mddev);
 
 		return 0;
 	}
@@ -6534,7 +6535,8 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 		return sync_blocks * RAID5_STRIPE_SECTORS(conf);
 	}
 
-	mddev->bitmap_ops->cond_end_sync(mddev, sector_nr, false);
+	if (md_bitmap_enabled(mddev, false))
+		mddev->bitmap_ops->cond_end_sync(mddev, sector_nr, false);
 
 	sh = raid5_get_active_stripe(conf, NULL, sector_nr,
 				     R5_GAS_NOBLOCK);
@@ -6760,7 +6762,8 @@ static void raid5d(struct md_thread *thread)
 			/* Now is a good time to flush some bitmap updates */
 			conf->seq_flush++;
 			spin_unlock_irq(&conf->device_lock);
-			mddev->bitmap_ops->unplug(mddev, true);
+			if (md_bitmap_enabled(mddev, true))
+				mddev->bitmap_ops->unplug(mddev, true);
 			spin_lock_irq(&conf->device_lock);
 			conf->seq_write = conf->seq_flush;
 			activate_bit_delay(conf, conf->temp_inactive_list);
@@ -8309,7 +8312,6 @@ static int raid5_resize(struct mddev *mddev, sector_t sectors)
 	 */
 	sector_t newsize;
 	struct r5conf *conf = mddev->private;
-	int ret;
 
 	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return -EINVAL;
@@ -8319,9 +8321,12 @@ static int raid5_resize(struct mddev *mddev, sector_t sectors)
 	    mddev->array_sectors > newsize)
 		return -EINVAL;
 
-	ret = mddev->bitmap_ops->resize(mddev, sectors, 0);
-	if (ret)
-		return ret;
+	if (md_bitmap_enabled(mddev, false)) {
+		int ret = mddev->bitmap_ops->resize(mddev, sectors, 0);
+
+		if (ret)
+			return ret;
+	}
 
 	md_set_array_sectors(mddev, newsize);
 	if (sectors > mddev->dev_sectors &&
-- 
2.39.2


