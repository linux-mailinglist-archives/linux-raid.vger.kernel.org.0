Return-Path: <linux-raid+bounces-1444-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE58C0920
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2024 03:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91798B20CEB
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2024 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993113CA9A;
	Thu,  9 May 2024 01:29:12 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A631327EB;
	Thu,  9 May 2024 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218151; cv=none; b=Dnr/o5uAZt6pEueekvV1dZUHOK0qk8W0rIZaSLsL2CkzS0ZTBJKtfVAfZZ2/hh541NfqCjGqR6o9pdsZaNg0417lyCgghIvAip2AlD42L/jpWFO6nujl+UxTEMp/+glZ75F3tjbcl4yrZu3rMAcQXh9wuWGXG7B889Bw0Y0kyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218151; c=relaxed/simple;
	bh=jFFplllxCC7E+n3SUzSZQQnTaGXi3FpX8evf3zgz7pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJtorbdxUmybHdbVK0MeqhnvtEFPBnzQEjIHPbCAhe8lyhTyEdorqPJAPCroj17BT1xxzf+P6ms6qkHzKq7vOo6wEdQNSaqmJTWVx5s6DWXyiyLheLyAgfRE9ltUoiumhL5jJc+669qo3xYMLjGOOVY3aCagV4Rlgz3P3jS3S2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZZDF30DVz4f3kKy;
	Thu,  9 May 2024 09:29:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BBD881A0572;
	Thu,  9 May 2024 09:29:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDeJjxm5MuXMA--.59814S10;
	Thu, 09 May 2024 09:29:06 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	xni@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.10 6/9] md: use new helers in md_do_sync()
Date: Thu,  9 May 2024 09:18:57 +0800
Message-Id: <20240509011900.2694291-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDeJjxm5MuXMA--.59814S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtrWDCFyUWrWfKrg_yoW8GryrpF
	WfAFnxurWkAr13GayrtFykJayFg3W7t34IyFy3ua4fX3Wagw18KayDK3WxC34DCrZ3Zr43
	Xas8G3W3ZF1Ykw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functinal changes, just to make code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index da6c94f03efb..0b609d79453a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8943,7 +8943,8 @@ void md_do_sync(struct md_thread *thread)
 	sector_t last_check;
 	int skipped = 0;
 	struct md_rdev *rdev;
-	char *desc, *action = NULL;
+	enum sync_action action;
+	char *desc;
 	struct blk_plug plug;
 	int ret;
 
@@ -8974,21 +8975,9 @@ void md_do_sync(struct md_thread *thread)
 			goto skip;
 	}
 
-	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
-		if (test_bit(MD_RECOVERY_CHECK, &mddev->recovery)) {
-			desc = "data-check";
-			action = "check";
-		} else if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
-			desc = "requested-resync";
-			action = "repair";
-		} else
-			desc = "resync";
-	} else if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
-		desc = "reshape";
-	else
-		desc = "recovery";
-
-	mddev->last_sync_action = action ?: desc;
+	action = md_sync_action(mddev);
+	desc = md_sync_action_name(action);
+	mddev->last_sync_action = desc;
 
 	/*
 	 * Before starting a resync we must have set curr_resync to
-- 
2.39.2


