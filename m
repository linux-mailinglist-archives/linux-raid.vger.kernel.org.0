Return-Path: <linux-raid+bounces-3357-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D52E9FC500
	for <lists+linux-raid@lfdr.de>; Wed, 25 Dec 2024 12:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44B61885350
	for <lists+linux-raid@lfdr.de>; Wed, 25 Dec 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A71CDFA7;
	Wed, 25 Dec 2024 11:20:02 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C2157A67;
	Wed, 25 Dec 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735125602; cv=none; b=CQLgsEKPWFRUXVJSSmVzlTXXLMRKBv4ZltNA7ZHeiaHFbqDjV2yTgXdK5orfFeRqdyiDuNdTA2ngmfY7er+Ej0TyHXz4duFovHCbW2A8ojk/axH26HoH2kD0X49TrlXt8o1IdlAgdw7qJZ0nTZWsXA/3Cyuugd2ukgH5a0U7wiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735125602; c=relaxed/simple;
	bh=jSFSd5UrNoJv5po/2epDq94cpNoZhaWBAqrrnchheHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdJvMbxtPclQnrQgVEhL3Hh0Kg82/ClGftlMIAP5rhCMPHUxRwlf07NCWfzNX9QHnLKCjHf0ma1y9lhEyIEQ//qRI0AEhi6FYO/7VDzkaUXNiHhoD55u0cZSoo+vzM93btcIxyO6hgdu1dJXSqV0/x6WSPWUmngNCgR0q41JXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJ8Rc6m9Cz4f3jqr;
	Wed, 25 Dec 2024 19:19:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8D20F1A018C;
	Wed, 25 Dec 2024 19:19:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnT4NV6mtntXlgFg--.39006S12;
	Wed, 25 Dec 2024 19:19:55 +0800 (CST)
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
Subject: [PATCH md-6.14 08/13] md/raid1: check before deferencing mddev->bitmap_ops
Date: Wed, 25 Dec 2024 19:15:41 +0800
Message-Id: <20241225111546.1833250-9-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAnT4NV6mtntXlgFg--.39006S12
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43ZF17Cw18KFWDuF45Jrb_yoW8Cw17pw
	srtFy3try5WrW3W345ZrykuF1Fy397JrZrtryfW3WxGrn7GryDZF4rXFWjqF1jka45AFy5
	Jw4DJw45CFnxXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Prepare to support building bitmap as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bb1cadfcf54b..8ca90af28b75 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2837,7 +2837,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		else /* completed sync */
 			conf->fullsync = 0;
 
-		mddev->bitmap_ops->close_sync(mddev);
+		if (md_bitmap_enabled(mddev))
+			mddev->bitmap_ops->close_sync(mddev);
 		close_sync(conf);
 
 		if (mddev_is_clustered(mddev)) {
@@ -2874,10 +2875,11 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
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
@@ -3358,15 +3360,17 @@ static int raid1_resize(struct mddev *mddev, sector_t sectors)
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


