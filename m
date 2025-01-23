Return-Path: <linux-raid+bounces-3507-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D64A19CE9
	for <lists+linux-raid@lfdr.de>; Thu, 23 Jan 2025 03:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1E63AF261
	for <lists+linux-raid@lfdr.de>; Thu, 23 Jan 2025 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9FD335C0;
	Thu, 23 Jan 2025 02:13:38 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFE1885BF;
	Thu, 23 Jan 2025 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737598418; cv=none; b=ut9rTXoIU6YexJo6P4aOkr9ApyDNn+Jah6OAR/ZN8dBkfYd8XtiHpvfNVxmp1y3sEL2ynRlte1XjlbXPxTIvySBrz0FAC270XouTlO+MnuYdzaC0DAAhit3S3Dx6aG7Xgtkr9QgeMheSUPTTPAJ1/TyELfnyDEtU1ivVhP5elAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737598418; c=relaxed/simple;
	bh=iIHJrSAQpfDoT3aVCPy6kQTQFGsIhEJcWZEHKeHC+us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmswoya1jFP5e0VUpM/JNsOs0TpE/T3uAiAeEN2Pk7P3Ti9bcqHFtvAM1z+OFYkKUWMtai9eIh2kNb7Hxq+ay6w5PKnyYomKs8ckr1TC9ojuVolsPcvZfEh/26FuLOi5xZlIPMcUlugG42jGIuJm/zgJXsNy8EW8ESbfRu0XPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdkxR5xfbz4f3khl;
	Thu, 23 Jan 2025 10:12:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 78D2A1A0F87;
	Thu, 23 Jan 2025 10:13:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+7pZFno+znBg--.59488S11;
	Thu, 23 Jan 2025 10:13:20 +0800 (CST)
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
Subject: [PATCH v3 md-6.15 07/11] md/raid1: check before deferencing mddev->bitmap_ops
Date: Thu, 23 Jan 2025 10:07:26 +0800
Message-Id: <20250123020730.2003602-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250123020730.2003602-1-yukuai1@huaweicloud.com>
References: <20250123020730.2003602-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m1+7pZFno+znBg--.59488S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43WF45Ww4xWF4rZr1xGrg_yoW8CFW7pw
	srtFy3try5GrWag345ArykuF1Fy3yxJr9rtryxW3WxGrn7GryDAFWrWFWjqF1jya45ZFy5
	t3yDJr45CF15JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Prepare to introduce CONFIG_MD_BITMAP.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 95dbf4aa5f64..cf55fa816cf7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2818,7 +2818,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		else /* completed sync */
 			conf->fullsync = 0;
 
-		mddev->bitmap_ops->close_sync(mddev);
+		if (md_bitmap_enabled(mddev))
+			mddev->bitmap_ops->close_sync(mddev);
 		close_sync(conf);
 
 		if (mddev_is_clustered(mddev)) {
@@ -2855,10 +2856,11 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 	/* we are incrementing sector_nr below. To be safe, we check against
 	 * sector_nr + two times RESYNC_SECTORS
 	 */
-
-	mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
-		mddev_is_clustered(mddev) &&
-		(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
+	if (md_bitmap_enabled(mddev))
+		mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
+			mddev_is_clustered(mddev) &&
+			(sector_nr + 2 * RESYNC_SECTORS >
+			 conf->cluster_sync_high));
 
 	if (raise_barrier(conf, sector_nr))
 		return 0;
@@ -3339,15 +3341,17 @@ static int raid1_resize(struct mddev *mddev, sector_t sectors)
 	 * worth it.
 	 */
 	sector_t newsize = raid1_size(mddev, sectors, 0);
-	int ret;
 
 	if (mddev->external_size &&
 	    mddev->array_sectors > newsize)
 		return -EINVAL;
 
-	ret = mddev->bitmap_ops->resize(mddev, newsize, 0);
-	if (ret)
-		return ret;
+	if (md_bitmap_enabled(mddev)) {
+		int ret = mddev->bitmap_ops->resize(mddev, newsize, 0);
+
+		if (ret)
+			return ret;
+	}
 
 	md_set_array_sectors(mddev, newsize);
 	if (sectors > mddev->dev_sectors &&
-- 
2.39.2


