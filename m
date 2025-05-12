Return-Path: <linux-raid+bounces-4151-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D8AB2CE7
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 03:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34720178E60
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 01:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C771E2602;
	Mon, 12 May 2025 01:28:14 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF171E3DEF;
	Mon, 12 May 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013293; cv=none; b=Edx/3zOHU18sUjP0/2oyA5ZZmRBaB6weFXF3L2FOTu0rwFYEG7S0M4ASazilxicFzAVUyzgJxUlAKD33Od5hFTu4BRN2dSgBCbk0wxIFd8GG9WVQSLNPboM5r+FYYXjshfCW1OK2ERn3IoWeNarBPpI9oDGer8EuqdmQu6f0sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013293; c=relaxed/simple;
	bh=5u/VTQgT10rVteQE3bLcRKRug+hOln5hZySpZiNE76o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttt00ZmYagClmNZ37pfhOd4XyftQ7SuGcDU1JHLoGGfGW0t7+ecJmfc59ZiRKhDYoW2c3zwj2iR03Ts0pvN5NN3r22wA+XOL5EKKpERhmp/O1036A/Ud0YDEGfxgcpWPGt+KzijpsSN5YiUMrML+3IpRDykI1EUPgdO3lYv+d0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zwhmz699cz4f3jt8;
	Mon, 12 May 2025 09:27:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 547DB1A0359;
	Mon, 12 May 2025 09:28:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CdTiFoNFCWMA--.55093S13;
	Mon, 12 May 2025 09:28:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	xni@redhat.com,
	colyli@kernel.org,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC md-6.16 v3 09/19] md: add a new recovery_flag MD_RECOVERY_LAZY_RECOVER
Date: Mon, 12 May 2025 09:19:17 +0800
Message-Id: <20250512011927.2809400-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2CdTiFoNFCWMA--.55093S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5JF1rWF1xAFyDCF17Jrb_yoW5Gr1kpa
	yxAF93CrWUAFWfZ3yUt3WDWFW5Zw10qryqyFy3uas5JF90kFn3ZF1UW3W7JrWDJa9aqa12
	qw1DJFsrZF1F9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This flag is used by llbitmap in later patches to skip raid456 initial
recover and delay building initial xor data to first write.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 12 +++++++++++-
 drivers/md/md.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index c23ee9c19cf9..a5dd7a403ea5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9133,6 +9133,14 @@ static sector_t md_sync_position(struct mddev *mddev, enum sync_action action)
 				start = rdev->recovery_offset;
 		rcu_read_unlock();
 
+		/*
+		 * If there are no spares, and raid456 lazy initial recover is
+		 * requested.
+		 */
+		if (test_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery) &&
+		    start == MaxSector)
+			start = 0;
+
 		/* If there is a bitmap, we need to make sure all
 		 * writes that started before we added a spare
 		 * complete before we start doing a recovery.
@@ -9697,6 +9705,7 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
 	if (mddev->recovery_cp < MaxSector) {
 		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		clear_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
 		return true;
 	}
 
@@ -9706,7 +9715,7 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
 	 * re-add.
 	 */
 	*spares = remove_and_add_spares(mddev, NULL);
-	if (*spares) {
+	if (*spares || test_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery)) {
 		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
@@ -10029,6 +10038,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 	clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+	clear_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
 	/*
 	 * We call mddev->cluster_ops->update_size here because sync_size could
 	 * be changed by md_update_sb, and MD_RECOVERY_RESHAPE is cleared,
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 99f6c7a92b48..0c89bf0e8e4f 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -667,6 +667,8 @@ enum recovery_flags {
 	MD_RECOVERY_RESHAPE,
 	/* remote node is running resync thread */
 	MD_RESYNCING_REMOTE,
+	/* raid456 lazy initial recover */
+	MD_RECOVERY_LAZY_RECOVER,
 };
 
 enum md_ro_state {
-- 
2.39.2


