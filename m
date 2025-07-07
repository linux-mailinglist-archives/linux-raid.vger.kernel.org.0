Return-Path: <linux-raid+bounces-4557-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF2AFA921
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 03:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD65189D4A4
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988122756A;
	Mon,  7 Jul 2025 01:32:53 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF182206AC;
	Mon,  7 Jul 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851973; cv=none; b=F3+KbvkuIbk+RUUib1HX+Q7ARzTxgSrwZ5+ZlFi1P9+1HnSkfbm4dWRcnS+o46mq2Y+DQaDmsmT23jURB6CLIFO+O32i+stDJKxmZd9fkg3cObMZ7IXweSp9R9/HwGzyGdi77tHdMf2DpXsSvgZr99BKTYiotZo6K/Y/CXpYsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851973; c=relaxed/simple;
	bh=6/AqTqaVEz9w3QYQQN662MoIHqTyx2Xb7blxEX+PTpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yhu+gJ/VbB8/sJZnlrCU936WhQMhARCxd/hidC6PziT5bmyx9yxJ5tHfWbXNgsKEI0MPovscFZHB9r/uNb6Ip/oLjakVdZwjWGR5MiKGVkawoHpkbUDIrqUvG/cscedp6HoPleBwYSByVEs0SKlptfpwI3JPZjmfTG3PKGBJTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bb6Dr48F0zKHMkR;
	Mon,  7 Jul 2025 09:32:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0B5031A13FB;
	Mon,  7 Jul 2025 09:32:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCazI2to_nSRAw--.35890S14;
	Mon, 07 Jul 2025 09:32:42 +0800 (CST)
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
Subject: [PATCH v5 10/15] md/raid1: check before referencing mddev->bitmap_ops
Date: Mon,  7 Jul 2025 09:27:06 +0800
Message-Id: <20250707012711.376844-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDnSCazI2to_nSRAw--.35890S14
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43WF4rCw18urWDZw1DJrb_yoW8Cw45pw
	srtFy3try5GrWag345Aa4kuF1Fy3yxtrZrtryfW3WxWrn7GryDZF4rWFWjqF1jya45ZFy5
	JayDJr45CF13WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 drivers/md/raid1.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 015eabb502ec..ea6a134be9d5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2819,7 +2819,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		else /* completed sync */
 			conf->fullsync = 0;
 
-		mddev->bitmap_ops->close_sync(mddev);
+		if (md_bitmap_enabled(mddev, false))
+			mddev->bitmap_ops->close_sync(mddev);
 		close_sync(conf);
 
 		if (mddev_is_clustered(mddev)) {
@@ -2856,10 +2857,11 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 	/* we are incrementing sector_nr below. To be safe, we check against
 	 * sector_nr + two times RESYNC_SECTORS
 	 */
-
-	mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
-		mddev_is_clustered(mddev) &&
-		(sector_nr + 2 * RESYNC_SECTORS > conf->cluster_sync_high));
+	if (md_bitmap_enabled(mddev, false))
+		mddev->bitmap_ops->cond_end_sync(mddev, sector_nr,
+			mddev_is_clustered(mddev) &&
+			(sector_nr + 2 * RESYNC_SECTORS >
+			 conf->cluster_sync_high));
 
 	if (raise_barrier(conf, sector_nr))
 		return 0;
@@ -3334,15 +3336,17 @@ static int raid1_resize(struct mddev *mddev, sector_t sectors)
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
+	if (md_bitmap_enabled(mddev, false)) {
+		int ret = mddev->bitmap_ops->resize(mddev, newsize, 0);
+
+		if (ret)
+			return ret;
+	}
 
 	md_set_array_sectors(mddev, newsize);
 	if (sectors > mddev->dev_sectors &&
-- 
2.39.2


