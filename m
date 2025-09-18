Return-Path: <linux-raid+bounces-5048-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A308EB3B5D9
	for <lists+linux-raid@lfdr.de>; Fri, 29 Aug 2025 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B337BE3F9
	for <lists+linux-raid@lfdr.de>; Fri, 29 Aug 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F52D8779;
	Fri, 29 Aug 2025 08:13:26 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE672C21CD;
	Fri, 29 Aug 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455206; cv=none; b=Wv46CFfhHZ5zARCiAhYakJDJgJ1qeQN2iPe3jl2WfGIAf8p/ATZOlF6NbN/szJZwm2OkDTlO+IzWCnJM7s7yhlO4I+DkbcV0fMcDYGxELQmfrlOTjiYtzfRwTfNGpeNjEW6VT4RH9zyTfKklSGVY50yUJDYvSUMKbcmTZvWGXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455206; c=relaxed/simple;
	bh=b0E9QQ+KD2k/UPoJgRbRysxykR2WPDllt/B2Y0Glm1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keU6bfVAtbHOPPIyp3X4zOy/zlvreisshQFJtklrk5DsNEbKLeB6afsppt6hGaMxTpFW0sEh4ErIgBYhL/LConDoXttD9c5+l7IgCw9n1qa5et2Bq0aJq+OsK219jZ1XEfq3LKt0/bO++5PzuR/WFCTylrnUmrDDYFy4mnl18ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCrcZ4M6szYQvj2;
	Fri, 29 Aug 2025 16:13:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 20F181A16A8;
	Fri, 29 Aug 2025 16:13:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0RYbFohAO2Ag--.45648S13;
	Fri, 29 Aug 2025 16:13:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	xni@redhat.com,
	colyli@kernel.org,
	linan122@huawei.com,
	corbet@lwn.net,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com,
	hare@suse.de
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com,
	hailan@yukuai.org.cn
Subject: [PATCH v7 md-6.18 09/11] md: add a new recovery_flag MD_RECOVERY_LAZY_RECOVER
Date: Fri, 29 Aug 2025 16:04:24 +0800
Message-Id: <20250829080426.1441678-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250829080426.1441678-1-yukuai1@huaweicloud.com>
References: <20250829080426.1441678-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0RYbFohAO2Ag--.45648S13
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kXF4xGr4kGFW8tFWxtFb_yoW7Aw47pa
	yIyF98Cr4DJFWfZrZrt3WDWFWrZw18KrWqyFyfW3ykJF98trnxZF1UWFy3JrWDJa9ava12
	qw1DJFW7uF15uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This flag is used by llbitmap in later patches to skip raid456 initial
recover and delay building initial xor data to first write.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/md/md.h    |  2 ++
 drivers/md/raid5.c | 19 +++++++++++++++----
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7196e7f6b2a4..199843356449 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9199,6 +9199,39 @@ static sector_t md_sync_max_sectors(struct mddev *mddev,
 	}
 }
 
+/*
+ * If lazy recovery is requested and all rdevs are in sync, select the rdev with
+ * the higest index to perfore recovery to build initial xor data, this is the
+ * same as old bitmap.
+ */
+static bool mddev_select_lazy_recover_rdev(struct mddev *mddev)
+{
+	struct md_rdev *recover_rdev = NULL;
+	struct md_rdev *rdev;
+	bool ret = false;
+
+	rcu_read_lock();
+	rdev_for_each_rcu(rdev, mddev) {
+		if (rdev->raid_disk < 0)
+			continue;
+
+		if (test_bit(Faulty, &rdev->flags) ||
+		    !test_bit(In_sync, &rdev->flags))
+			break;
+
+		if (!recover_rdev || recover_rdev->raid_disk < rdev->raid_disk)
+			recover_rdev = rdev;
+	}
+
+	if (recover_rdev) {
+		clear_bit(In_sync, &recover_rdev->flags);
+		ret = true;
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
 static sector_t md_sync_position(struct mddev *mddev, enum sync_action action)
 {
 	sector_t start = 0;
@@ -9230,6 +9263,14 @@ static sector_t md_sync_position(struct mddev *mddev, enum sync_action action)
 				start = rdev->recovery_offset;
 		rcu_read_unlock();
 
+		/*
+		 * If there are no spares, and raid456 lazy initial recover is
+		 * requested.
+		 */
+		if (test_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery) &&
+		    start == MaxSector && mddev_select_lazy_recover_rdev(mddev))
+			start = 0;
+
 		/* If there is a bitmap, we need to make sure all
 		 * writes that started before we added a spare
 		 * complete before we start doing a recovery.
@@ -9791,6 +9832,7 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
 
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		clear_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
 		return true;
 	}
 
@@ -9799,6 +9841,7 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
 		remove_spares(mddev, NULL);
 		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		clear_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
 		return true;
 	}
 
@@ -9808,7 +9851,7 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
 	 * re-add.
 	 */
 	*spares = remove_and_add_spares(mddev, NULL);
-	if (*spares) {
+	if (*spares || test_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery)) {
 		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
@@ -10021,6 +10064,7 @@ void md_check_recovery(struct mddev *mddev)
 			}
 
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+			clear_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
 			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
 
@@ -10131,6 +10175,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 	clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+	clear_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
 	/*
 	 * We call mddev->cluster_ops->update_size here because sync_size could
 	 * be changed by md_update_sb, and MD_RECOVERY_RESHAPE is cleared,
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 4fa5a3e68a0c..7b6357879a84 100644
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
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 672ab226e43c..5112658ef5f6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4705,10 +4705,21 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 			}
 		} else if (test_bit(In_sync, &rdev->flags))
 			set_bit(R5_Insync, &dev->flags);
-		else if (sh->sector + RAID5_STRIPE_SECTORS(conf) <= rdev->recovery_offset)
-			/* in sync if before recovery_offset */
-			set_bit(R5_Insync, &dev->flags);
-		else if (test_bit(R5_UPTODATE, &dev->flags) &&
+		else if (sh->sector + RAID5_STRIPE_SECTORS(conf) <=
+			 rdev->recovery_offset) {
+			/*
+			 * in sync if:
+			 *  - normal IO, or
+			 *  - resync IO that is not lazy recovery
+			 *
+			 * For lazy recovery, we have to mark the rdev without
+			 * In_sync as failed, to build initial xor data.
+			 */
+			if (!test_bit(STRIPE_SYNCING, &sh->state) ||
+			    !test_bit(MD_RECOVERY_LAZY_RECOVER,
+				      &conf->mddev->recovery))
+				set_bit(R5_Insync, &dev->flags);
+		} else if (test_bit(R5_UPTODATE, &dev->flags) &&
 			 test_bit(R5_Expanded, &dev->flags))
 			/* If we've reshaped into here, we assume it is Insync.
 			 * We will shortly update recovery_offset to make
-- 
2.39.2


