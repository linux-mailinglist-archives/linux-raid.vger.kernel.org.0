Return-Path: <linux-raid+bounces-1836-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8079903D25
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2024 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483031F24723
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2024 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67817D35B;
	Tue, 11 Jun 2024 13:23:25 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D217D36F;
	Tue, 11 Jun 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112204; cv=none; b=XO+50XzlpRkQkrXnXKM7+wcVORZPP8heDyAZ6oHE+cpF4EBhp0lMLiQSSBi98qm3IsTH1EMckiHc6byO6U8qpZJLt3LfBffJBPGkOMNCeSXRFNKn0houjddTAc2/9jpr552RZvX6ESts7sKHgmIcCmUGgxZji6SUGB+xSPBCiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112204; c=relaxed/simple;
	bh=dKyW4mu84ufoCzAnfbXf57DTFOP8NWYdKfs1/ZMl2CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJk98J1ps5W4a4j5LRDhm47b4YdhMLlXe5U3+OAbzqWBgPwHORCXE+Jncdi+IzQ+QvdND7S5g6SU8AWWJGnj8MOyb63y5AIShs90BJn1ku8Wl2sJsBek4llCRKQOW0MhOUf1Cnc8sb83hgK0MQ52GbeqlYiyFigIt+tIoUWyJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vz8W52XKRz4f3jjr;
	Tue, 11 Jun 2024 21:23:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DDD0F1A0EE3;
	Tue, 11 Jun 2024 21:23:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDBT2hmsVPEPA--.1557S12;
	Tue, 11 Jun 2024 21:23:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	xni@redhat.com,
	mariusz.tkaczyk@linux.intel.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 md-6.11 08/12] md: use new helers in md_do_sync()
Date: Tue, 11 Jun 2024 21:22:47 +0800
Message-Id: <20240611132251.1967786-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611132251.1967786-1-yukuai1@huaweicloud.com>
References: <20240611132251.1967786-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDBT2hmsVPEPA--.1557S12
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7ZF13GFWfXw43JF43Wrg_yoW8Zw4fpF
	WfJa43ZrWUAr47J3y8ta4kZFWFg3WayFySkFW3u34xX3W3Kw1UAF4DKFnrC34DurZ5ArW3
	Xas8Wa43ZF4FkaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Make code cleaner. and also use the action_name directly in kernel log:
 - "check" instead of "data-check"
 - "repair" instead of "requested-resync"

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 21 +++++----------------
 drivers/md/md.h |  2 +-
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 86abd0fe0681..5fa7b5f4bc6d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8929,7 +8929,8 @@ void md_do_sync(struct md_thread *thread)
 	sector_t last_check;
 	int skipped = 0;
 	struct md_rdev *rdev;
-	char *desc, *action = NULL;
+	enum sync_action action;
+	const char *desc;
 	struct blk_plug plug;
 	int ret;
 
@@ -8960,21 +8961,9 @@ void md_do_sync(struct md_thread *thread)
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
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 732053b905b2..ee06cb076f8c 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -432,7 +432,7 @@ struct mddev {
 	 * when the sync thread is "frozen" (interrupted) or "idle" (stopped
 	 * or finished).  It is overwritten when a new sync operation is begun.
 	 */
-	char				*last_sync_action;
+	const char			*last_sync_action;
 	sector_t			curr_resync;	/* last block scheduled */
 	/* As resync requests can complete out of order, we cannot easily track
 	 * how much resync has been completed.  So we occasionally pause until
-- 
2.39.2


