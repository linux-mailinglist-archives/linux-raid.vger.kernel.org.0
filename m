Return-Path: <linux-raid+bounces-3259-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1259D0FFA
	for <lists+linux-raid@lfdr.de>; Mon, 18 Nov 2024 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4908CB277A0
	for <lists+linux-raid@lfdr.de>; Mon, 18 Nov 2024 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08701993B9;
	Mon, 18 Nov 2024 11:44:19 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939761990AD;
	Mon, 18 Nov 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930259; cv=none; b=cq4t741WCFhaIR86P8yjYQ2Z4v3NReimckQrrWGGnMK/3KH/kPsRLy2eA1b5Cj9Bms4IlY0FIA988/i6Kx/oTScbpeX6EziuKZSC9J7eT8/EiabSV7zBe8ppTGLkHmaD8Ew47KXB0i9Z4v/ZKIDB12rW8vEuOph3jXaYp/byaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930259; c=relaxed/simple;
	bh=NwCq8TbmnYfwl7+4SLzg4wkpQh6xud+/8n/v944Hmv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JO7U89JBAPDSIXxaRrRwlQy4OF9FFN5FwzOz9aHPGPUw+djxEAQrZJIu2MNWkdLBkSseW0Lt0BK6br25TEd+f255FPM0z3vYeiLMbs/JL0fFC0WFLobjaSjXKOjVQxZ9ZhlBeq/CzYdhYzWOOyY2IzqeyGFeHQZcFFeCokViXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsQkn19C5z4f3kKt;
	Mon, 18 Nov 2024 19:44:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 837641A058E;
	Mon, 18 Nov 2024 19:44:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4eKKDtn_9+KCA--.2699S8;
	Mon, 18 Nov 2024 19:44:14 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	xni@redhat.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.13 4/5] md/raid5: implement pers->bitmap_sector()
Date: Mon, 18 Nov 2024 19:41:56 +0800
Message-Id: <20241118114157.355749-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118114157.355749-1-yukuai1@huaweicloud.com>
References: <20241118114157.355749-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4eKKDtn_9+KCA--.2699S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AFykGFyUArWDCFykXw45trb_yoW5Jr4xpa
	nF9r4a9rW3Zw13uwn8J34kuF4FyasxCwsrtFW3Gws3G3W3Gr97Za18K3W5uF15CFyrAr4j
	yw45KrZ7CF4DKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Bitmap is used for the whole array for raid1/raid10, hence IO for the
array can be used directly for bitmap. However, bitmap is used for
underlying disks for raid5, hence IO for the array can't be used
directly for bitmap.

Implement pers->bitmap_sector() for raid5 to convert IO ranges from the
array to the underlying disks.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2f10cca4b7b1..95caed41654c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2950,6 +2950,23 @@ static void raid5_error(struct mddev *mddev, struct md_rdev *rdev)
 	r5c_update_on_rdev_error(mddev, rdev);
 }
 
+static void raid5_bitmap_sector(struct mddev *mddev, sector_t *offset,
+				unsigned long *sectors)
+{
+	struct r5conf *conf = mddev->private;
+	int sectors_per_chunk = conf->chunk_sectors * (conf->raid_disks -
+						       conf->max_degraded);
+	sector_t start = *offset;
+	sector_t end = start + *sectors;
+	int dd_idx;
+
+	start = round_down(start, sectors_per_chunk);
+	end = round_up(end, sectors_per_chunk);
+
+	*offset = raid5_compute_sector(conf, start, 0, &dd_idx, NULL);
+	*sectors = raid5_compute_sector(conf, end, 0, &dd_idx, NULL) - *offset;
+}
+
 /*
  * Input: a 'big' sector number,
  * Output: index of the data and parity disk, and the sector # in them.
@@ -8968,6 +8985,7 @@ static struct md_personality raid6_personality =
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
 	.prepare_suspend = raid5_prepare_suspend,
+	.bitmap_sector	= raid5_bitmap_sector,
 };
 static struct md_personality raid5_personality =
 {
@@ -8993,6 +9011,7 @@ static struct md_personality raid5_personality =
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
 	.prepare_suspend = raid5_prepare_suspend,
+	.bitmap_sector	= raid5_bitmap_sector,
 };
 
 static struct md_personality raid4_personality =
@@ -9019,6 +9038,7 @@ static struct md_personality raid4_personality =
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
 	.prepare_suspend = raid5_prepare_suspend,
+	.bitmap_sector	= raid5_bitmap_sector,
 };
 
 static int __init raid5_init(void)
-- 
2.39.2


