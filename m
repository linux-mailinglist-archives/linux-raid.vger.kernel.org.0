Return-Path: <linux-raid+bounces-5339-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D43B7CDD4
	for <lists+linux-raid@lfdr.de>; Wed, 17 Sep 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9139532860D
	for <lists+linux-raid@lfdr.de>; Wed, 17 Sep 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280834F481;
	Wed, 17 Sep 2025 09:45:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5C249F9;
	Wed, 17 Sep 2025 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102306; cv=none; b=UaidwNl9Xwasb9qFjgZLt25Qlhk3BJ9h21VriUQBtVQesuF8nlXfM7W/OIZ/z+zW8YkNemIEScSgd5xBKHFxHMHHGfyA2qO0PjLQH9+DfEYFAo6+8gQGWO5/kPpQbAc4e19hXAnV8vl7AfQHKR0RgTDhFFnxOP7sMz0Z1mpnKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102306; c=relaxed/simple;
	bh=E90MUkLZkKWSHT+mqqBu2fQvEPQtVRKhlX5im6cjJqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Owjgd+pH7XnP1oQigIzQ4h5sTqPQxfjMMnhzI37+z3yJ9tYuNDIcQcrjxHrxj5RzXsTcszJOhwXlil0ymdWcik/s3Xc0Blsg2Z+rlwwZCsNFRf6P0od3FhR9xNK9UYaXqh3to6c0d1CghpzPO27aglenNBCAiza3/dSUNl4cpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRYlh0XbTzYQvLl;
	Wed, 17 Sep 2025 17:45:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A6E521A260F;
	Wed, 17 Sep 2025 17:45:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0Zg8poSuc1Cw--.51298S11;
	Wed, 17 Sep 2025 17:45:02 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	yukuai3@huawei.com,
	neil@brown.name,
	namhyung@gmail.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: [PATCH 7/7] md: remove recovery_disabled
Date: Wed, 17 Sep 2025 17:35:08 +0800
Message-Id: <20250917093508.456790-8-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250917093508.456790-1-linan666@huaweicloud.com>
References: <20250917093508.456790-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0Zg8poSuc1Cw--.51298S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1fZF4fXFy5Jr4xtF48Crg_yoWfCFW3pa
	9xJF9a9rWjqayFyF1DJFWDWFyrt3yUKa97tFyxW3y8Za45trWkXa95XFyUXFyDJFWFva12
	q3Z5GrW5GF1IgaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkR67UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

'recovery_disabled' logic is complex and confusing, originally intended to
preserve raid in extreme scenarios. It was used in following cases:
- When sync fails and setting badblocks also fails, kick out non-In_sync
  rdev and block spare rdev from joining to preserve raid [1]
- When last backup is unavailable, prevent repeated add-remove of spares
  triggering recovery [2]

The original issues are now resolved:
- Error handlers in all raid types prevent last rdev from being kicked out
- Disks with failed recovery are marked Faulty and can't re-join

Therefore, remove 'recovery_disabled' as it's no longer needed.

[1] 5389042ffa36 ("md: change managed of recovery_disabled.")
[2] 4044ba58dd15 ("md: don't retry recovery of raid1 that fails due to error on source drive.")

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.h     |  6 ------
 drivers/md/raid1.h  |  5 -----
 drivers/md/raid10.h |  5 -----
 drivers/md/raid5.h  |  1 -
 drivers/md/md.c     |  3 ---
 drivers/md/raid1.c  | 17 +++--------------
 drivers/md/raid10.c |  8 --------
 drivers/md/raid5.c  | 10 +---------
 8 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 07a22f3772d8..5fc9acb57447 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -493,12 +493,6 @@ struct mddev {
 	int				ok_start_degraded;
 
 	unsigned long			recovery;
-	/* If a RAID personality determines that recovery (of a particular
-	 * device) will fail due to a read error on the source device, it
-	 * takes a copy of this number and does not attempt recovery again
-	 * until this number changes.
-	 */
-	int				recovery_disabled;
 
 	int				in_sync;	/* know to not need resync */
 	/* 'open_mutex' avoids races between 'md_open' and 'do_md_stop', so
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index d236ef179cfb..dfd996f2886f 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -93,11 +93,6 @@ struct r1conf {
 	 */
 	int			fullsync;
 
-	/* When the same as mddev->recovery_disabled we don't allow
-	 * recovery to be attempted as we expect a read error.
-	 */
-	int			recovery_disabled;
-
 	mempool_t		*r1bio_pool;
 	mempool_t		r1buf_pool;
 
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 3f16ad6904a9..78b7a11cddf7 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -18,11 +18,6 @@
 struct raid10_info {
 	struct md_rdev	*rdev, *replacement;
 	sector_t	head_position;
-	int		recovery_disabled;	/* matches
-						 * mddev->recovery_disabled
-						 * when we shouldn't try
-						 * recovering this device.
-						 */
 };
 
 struct r10conf {
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index eafc6e9ed6ee..eff2bba9d76f 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -640,7 +640,6 @@ struct r5conf {
 					    * (fresh device added).
 					    * Cleared when a sync completes.
 					    */
-	int			recovery_disabled;
 	/* per cpu variables */
 	struct raid5_percpu __percpu *percpu;
 	int scribble_disks;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f4f80d32db98..75d30dc40848 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2577,9 +2577,6 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	list_add_rcu(&rdev->same_set, &mddev->disks);
 	bd_link_disk_holder(rdev->bdev, mddev->gendisk);
 
-	/* May as well allow recovery to be retried once */
-	mddev->recovery_disabled++;
-
 	return 0;
 
  fail:
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f7238e9f35e5..f1d4a495520c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1772,7 +1772,6 @@ static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
 		set_bit(MD_BROKEN, &mddev->flags);
 
 		if (!mddev->fail_last_dev) {
-			conf->recovery_disabled = mddev->recovery_disabled;
 			spin_unlock_irqrestore(&conf->device_lock, flags);
 			return;
 		}
@@ -1916,7 +1915,6 @@ static bool raid1_remove_conf(struct r1conf *conf, int disk)
 
 	/* Only remove non-faulty devices if recovery is not possible. */
 	if (!test_bit(Faulty, &rdev->flags) &&
-	    rdev->mddev->recovery_disabled != conf->recovery_disabled &&
 	    rdev->mddev->degraded < conf->raid_disks)
 		return false;
 
@@ -1936,9 +1934,6 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int first = 0;
 	int last = conf->raid_disks - 1;
 
-	if (mddev->recovery_disabled == conf->recovery_disabled)
-		return -EBUSY;
-
 	if (rdev->raid_disk >= 0)
 		first = last = rdev->raid_disk;
 
@@ -2358,7 +2353,6 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 		 */
 		if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) ||
 		    !fix_sync_read_error(r1_bio)) {
-			conf->recovery_disabled = mddev->recovery_disabled;
 			md_done_sync(mddev, r1_bio->sectors);
 			md_sync_error(mddev);
 			put_buf(r1_bio);
@@ -2961,16 +2955,12 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		*skipped = 1;
 		put_buf(r1_bio);
 
-		if (!ok) {
-			/* Cannot record the badblocks, so need to
+		if (!ok)
+			/* Cannot record the badblocks, md_error has set INTR,
 			 * abort the resync.
-			 * If there are multiple read targets, could just
-			 * fail the really bad ones ???
 			 */
-			conf->recovery_disabled = mddev->recovery_disabled;
-			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 			return 0;
-		} else
+		else
 			return min_bad;
 
 	}
@@ -3157,7 +3147,6 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 	init_waitqueue_head(&conf->wait_barrier);
 
 	bio_list_init(&conf->pending_bio_list);
-	conf->recovery_disabled = mddev->recovery_disabled - 1;
 
 	err = -EIO;
 	for (i = 0; i < conf->raid_disks * 2; i++) {
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0cd542b77842..2ef2f640a6f0 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2136,8 +2136,6 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		mirror = first;
 	for ( ; mirror <= last ; mirror++) {
 		p = &conf->mirrors[mirror];
-		if (p->recovery_disabled == mddev->recovery_disabled)
-			continue;
 		if (p->rdev) {
 			if (test_bit(WantReplacement, &p->rdev->flags) &&
 			    p->replacement == NULL && repl_slot < 0)
@@ -2149,7 +2147,6 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		if (err)
 			return err;
 		p->head_position = 0;
-		p->recovery_disabled = mddev->recovery_disabled - 1;
 		rdev->raid_disk = mirror;
 		err = 0;
 		if (rdev->saved_raid_disk != mirror)
@@ -2202,7 +2199,6 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	 * is not possible.
 	 */
 	if (!test_bit(Faulty, &rdev->flags) &&
-	    mddev->recovery_disabled != p->recovery_disabled &&
 	    (!p->replacement || p->replacement == rdev) &&
 	    number < conf->geo.raid_disks &&
 	    enough(conf, -1)) {
@@ -2541,8 +2537,6 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 					pr_notice("md/raid10:%s: recovery aborted due to read error\n",
 						  mdname(mddev));
 
-					conf->mirrors[dw].recovery_disabled
-						= mddev->recovery_disabled;
 					set_bit(MD_RECOVERY_INTR,
 						&mddev->recovery);
 					break;
@@ -4079,8 +4073,6 @@ static int raid10_run(struct mddev *mddev)
 		    disk->replacement->saved_raid_disk < 0) {
 			conf->fullsync = 1;
 		}
-
-		disk->recovery_disabled = mddev->recovery_disabled - 1;
 	}
 
 	if (mddev->resync_offset != MaxSector)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 70106abf2110..8b85e0e319a6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2918,7 +2918,6 @@ static void raid5_error(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (has_failed(conf)) {
 		set_bit(MD_BROKEN, &conf->mddev->flags);
-		conf->recovery_disabled = mddev->recovery_disabled;
 
 		pr_crit("md/raid:%s: Cannot continue operation (%d/%d failed).\n",
 			mdname(mddev), mddev->degraded, conf->raid_disks);
@@ -3723,10 +3722,8 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
 	}
 	md_done_sync(conf->mddev, RAID5_STRIPE_SECTORS(conf));
 
-	if (abort) {
-		conf->recovery_disabled = conf->mddev->recovery_disabled;
+	if (abort)
 		md_sync_error(conf->mddev);
-	}
 }
 
 static int want_replace(struct stripe_head *sh, int disk_idx)
@@ -7530,8 +7527,6 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	}
 
 	conf->bypass_threshold = BYPASS_THRESHOLD;
-	conf->recovery_disabled = mddev->recovery_disabled - 1;
-
 	conf->raid_disks = mddev->raid_disks;
 	if (mddev->reshape_position == MaxSector)
 		conf->previous_raid_disks = mddev->raid_disks;
@@ -8203,7 +8198,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	 * isn't possible.
 	 */
 	if (!test_bit(Faulty, &rdev->flags) &&
-	    mddev->recovery_disabled != conf->recovery_disabled &&
 	    !has_failed(conf) &&
 	    (!p->replacement || p->replacement == rdev) &&
 	    number < conf->raid_disks) {
@@ -8264,8 +8258,6 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 		return 0;
 	}
-	if (mddev->recovery_disabled == conf->recovery_disabled)
-		return -EBUSY;
 
 	if (rdev->saved_raid_disk < 0 && has_failed(conf))
 		/* no point adding a device */
-- 
2.39.2


