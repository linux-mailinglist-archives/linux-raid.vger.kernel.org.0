Return-Path: <linux-raid+bounces-4548-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF6AFA8FF
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 03:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17771789F9
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96521ABA4;
	Mon,  7 Jul 2025 01:32:48 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D7202F7C;
	Mon,  7 Jul 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851967; cv=none; b=JlcOPHb6ahG0dATiqPWMi/WP6xun+MPKwGN3Dv4qZaFUtfn0m6TGPdgsVKt3yksD68BxEU004sZjUhqYq478y7GCfEcWhUqCrx9P0V+vzbH1mU0jnv2g5nNld2lj+zMdFHKRokxr+175eUzvJ2wDMVG01Mqf0R51Aa4lQCVhb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851967; c=relaxed/simple;
	bh=S9x3hdeJifMfFlIZ+FR8vfWKzFr5RTKZ2A60y4AiK/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JN03A9Kyk5Yo24s2M4jRQ+1MVgl2OPJkKL6edrTMtjUAi6ztNvh40g989tfARs4rKAOfZ8nJ/EeVmPdzLci8urYn3oR+zpJB/+oAFtkpr/wHEKC9O1yX1a5bNgkcRivXSBGz02rTswI1ryuVv09K6dbIbMnp0f9fWmvkx5gEbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bb6Dr5NgmzYQv3h;
	Mon,  7 Jul 2025 09:32:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9288C1A018C;
	Mon,  7 Jul 2025 09:32:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCazI2to_nSRAw--.35890S15;
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
Subject: [PATCH v5 11/15] md/raid10: check before referencing mddev->bitmap_ops
Date: Mon,  7 Jul 2025 09:27:07 +0800
Message-Id: <20250707012711.376844-12-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDnSCazI2to_nSRAw--.35890S15
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4furyDXw1DGr15tF15twb_yoW5JFyrp3
	9rtFy3tryUA3yaga15AFyku3WFv3s7tr9rtFyxWw1xGrn7GrnrJF4rWFWjqF1jva45ZF15
	X3yDJr45CF1fWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 drivers/md/raid10.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c0aa19935881..5397b7e20399 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3242,7 +3242,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			}
 			conf->fullsync = 0;
 		}
-		mddev->bitmap_ops->close_sync(mddev);
+		if (md_bitmap_enabled(mddev, false))
+			mddev->bitmap_ops->close_sync(mddev);
 		close_sync(conf);
 		*skipped = 1;
 		return sectors_skipped;
@@ -3561,7 +3562,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		 * safety reason, which ensures curr_resync_completed is
 		 * updated in bitmap_cond_end_sync.
 		 */
-		mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
+		if (md_bitmap_enabled(mddev, false))
+			mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
 					mddev_is_clustered(mddev) &&
 					(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
 
@@ -4214,7 +4216,6 @@ static int raid10_resize(struct mddev *mddev, sector_t sectors)
 	 */
 	struct r10conf *conf = mddev->private;
 	sector_t oldsize, size;
-	int ret;
 
 	if (mddev->reshape_position != MaxSector)
 		return -EBUSY;
@@ -4228,9 +4229,12 @@ static int raid10_resize(struct mddev *mddev, sector_t sectors)
 	    mddev->array_sectors > size)
 		return -EINVAL;
 
-	ret = mddev->bitmap_ops->resize(mddev, size, 0);
-	if (ret)
-		return ret;
+	if (md_bitmap_enabled(mddev, false)) {
+		int ret = mddev->bitmap_ops->resize(mddev, size, 0);
+
+		if (ret)
+			return ret;
+	}
 
 	md_set_array_sectors(mddev, size);
 	if (sectors > mddev->dev_sectors &&
@@ -4496,7 +4500,8 @@ static int raid10_start_reshape(struct mddev *mddev)
 		oldsize = raid10_size(mddev, 0, 0);
 		newsize = raid10_size(mddev, 0, conf->geo.raid_disks);
 
-		if (!mddev_is_clustered(mddev)) {
+		if (!mddev_is_clustered(mddev) &&
+		    md_bitmap_enabled(mddev, false)) {
 			ret = mddev->bitmap_ops->resize(mddev, newsize, 0);
 			if (ret)
 				goto abort;
@@ -4519,6 +4524,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 			    MD_FEATURE_RESHAPE_ACTIVE)) || (oldsize == newsize))
 			goto out;
 
+		/* cluster can't be setup without bitmap */
 		ret = mddev->bitmap_ops->resize(mddev, newsize, 0);
 		if (ret)
 			goto abort;
-- 
2.39.2


