Return-Path: <linux-raid+bounces-3716-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD0A3EE95
	for <lists+linux-raid@lfdr.de>; Fri, 21 Feb 2025 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72AC7ACB63
	for <lists+linux-raid@lfdr.de>; Fri, 21 Feb 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5AC205AD9;
	Fri, 21 Feb 2025 08:15:08 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8D2040A6;
	Fri, 21 Feb 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125707; cv=none; b=ssp5xxyYldUnxjBdD6i/7UCxeqhNjnabdHTuJLwzzhsktyZfmKHveP1zJ3rvbiT72IIvFl987mR8CE0pImTyfWjQLT+beAUV8bS2wCLc1kA7celYpiHZrxD3IbBzYkFn6y4lQWAiitDFlM9VZluxzKYvKY+mHC64m5iFQl2RhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125707; c=relaxed/simple;
	bh=A6gnyyT5/Tb4TC6XpGOVH0o0PRn0XU0L7ShiWJqdDPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfzZQo3DsF3mEWu2vPh4a5RvJ+EGt6+CjNMiYnHTunOivwCr7b9D1vufiCD0Hix52U9iErQoGu3jlzrLFDvM9d4BBC1YGVQS7HsvLlK58lGBVs/SZNPooIfBU8jw+nqvE1u2n4h1kzIrNN6cVFpEBz/KtS6qpPmONiAq0zx9XQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YzjbM3bZcz4f3lDF;
	Fri, 21 Feb 2025 16:14:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8D0091A06D7;
	Fri, 21 Feb 2025 16:15:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl_8NbhnHF3eEQ--.3944S14;
	Fri, 21 Feb 2025 16:15:02 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: axboe@kernel.dk,
	song@kernel.org,
	colyli@kernel.org,
	yukuai3@huawei.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	dlemoal@kernel.org,
	yanjun.zhu@linux.dev,
	kch@nvidia.com,
	hare@suse.de,
	zhengqixing@huawei.com,
	john.g.garry@oracle.com,
	geliang@kernel.org,
	xni@redhat.com,
	colyli@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 10/12] badblocks: return boolen from badblocks_set() and badblocks_clear()
Date: Fri, 21 Feb 2025 16:11:07 +0800
Message-Id: <20250221081109.734170-11-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl_8NbhnHF3eEQ--.3944S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WF47uFyxZw4DtF47Jr4DCFg_yoWfGr4kpa
	9xJa4fJrWUWr18WF1UZ3Z5tr1Fg343tF4UK3y3J340kryqy3yxtF1kXryYqFyjgrW3CrnI
	qa15urW5ua4DW37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI1v3UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

Change the return type of badblocks_set() and badblocks_clear()
from int to bool, indicating success or failure. Specifically:

- _badblocks_set() and _badblocks_clear() functions now return
true for success and false for failure.
- All calls to these functions have been updated to handle the
new boolean return type.
- This change improves code clarity and ensures a more consistent
handling of success and failure states.

Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
 block/badblocks.c             | 37 +++++++++++++++++------------------
 drivers/block/null_blk/main.c | 17 ++++++++--------
 drivers/md/md.c               | 35 +++++++++++++++++----------------
 drivers/nvdimm/badrange.c     |  2 +-
 include/linux/badblocks.h     |  6 +++---
 5 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 79d91be468c4..8f057563488a 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -836,8 +836,8 @@ static bool try_adjacent_combine(struct badblocks *bb, int prev)
 }
 
 /* Do exact work to set bad block range into the bad block table */
-static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
-			  int acknowledged)
+static bool _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
+			   int acknowledged)
 {
 	int len = 0, added = 0;
 	struct badblocks_context bad;
@@ -847,11 +847,11 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 
 	if (bb->shift < 0)
 		/* badblocks are disabled */
-		return 1;
+		return false;
 
 	if (sectors == 0)
 		/* Invalid sectors number */
-		return 1;
+		return false;
 
 	if (bb->shift) {
 		/* round the start down, and the end up */
@@ -977,7 +977,7 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 
 	write_sequnlock_irqrestore(&bb->lock, flags);
 
-	return sectors;
+	return sectors == 0;
 }
 
 /*
@@ -1048,21 +1048,20 @@ static int front_splitting_clear(struct badblocks *bb, int prev,
 }
 
 /* Do the exact work to clear bad block range from the bad block table */
-static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
+static bool _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 {
 	struct badblocks_context bad;
 	int prev = -1, hint = -1;
 	int len = 0, cleared = 0;
-	int rv = 0;
 	u64 *p;
 
 	if (bb->shift < 0)
 		/* badblocks are disabled */
-		return 1;
+		return false;
 
 	if (sectors == 0)
 		/* Invalid sectors number */
-		return 1;
+		return false;
 
 	if (bb->shift) {
 		sector_t target;
@@ -1182,9 +1181,9 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 	write_sequnlock_irq(&bb->lock);
 
 	if (!cleared)
-		rv = 1;
+		return false;
 
-	return rv;
+	return true;
 }
 
 /* Do the exact work to check bad blocks range from the bad block table */
@@ -1338,11 +1337,11 @@ EXPORT_SYMBOL_GPL(badblocks_check);
  * decide how best to handle it.
  *
  * Return:
- *  0: success
- *  other: failed to set badblocks (out of space)
+ *  true: success
+ *  false: failed to set badblocks (out of space)
  */
-int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
-			int acknowledged)
+bool badblocks_set(struct badblocks *bb, sector_t s, int sectors,
+		   int acknowledged)
 {
 	return _badblocks_set(bb, s, sectors, acknowledged);
 }
@@ -1359,10 +1358,10 @@ EXPORT_SYMBOL_GPL(badblocks_set);
  * drop the remove request.
  *
  * Return:
- *  0: success
- *  1: failed to clear badblocks
+ *  true: success
+ *  false: failed to clear badblocks
  */
-int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
+bool badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 {
 	return _badblocks_clear(bb, s, sectors);
 }
@@ -1484,7 +1483,7 @@ ssize_t badblocks_store(struct badblocks *bb, const char *page, size_t len,
 		return -EINVAL;
 	}
 
-	if (badblocks_set(bb, sector, length, !unack))
+	if (!badblocks_set(bb, sector, length, !unack))
 		return -ENOSPC;
 	else
 		return len;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37480bd..623db72ad66b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -559,14 +559,15 @@ static ssize_t nullb_device_badblocks_store(struct config_item *item,
 		goto out;
 	/* enable badblocks */
 	cmpxchg(&t_dev->badblocks.shift, -1, 0);
-	if (buf[0] == '+')
-		ret = badblocks_set(&t_dev->badblocks, start,
-			end - start + 1, 1);
-	else
-		ret = badblocks_clear(&t_dev->badblocks, start,
-			end - start + 1);
-	if (ret == 0)
-		ret = count;
+	if (buf[0] == '+') {
+		if (badblocks_set(&t_dev->badblocks, start,
+				  end - start + 1, 1))
+			ret = count;
+	} else {
+		if (badblocks_clear(&t_dev->badblocks, start,
+				    end - start + 1))
+			ret = count;
+	}
 out:
 	kfree(orig);
 	return ret;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 30b3dbbce2d2..49d826e475cb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1748,7 +1748,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 			count <<= sb->bblog_shift;
 			if (bb + 1 == 0)
 				break;
-			if (badblocks_set(&rdev->badblocks, sector, count, 1))
+			if (!badblocks_set(&rdev->badblocks, sector, count, 1))
 				return -EINVAL;
 		}
 	} else if (sb->bblog_offset != 0)
@@ -9846,7 +9846,6 @@ int rdev_set_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 		       int is_new)
 {
 	struct mddev *mddev = rdev->mddev;
-	int rv;
 
 	/*
 	 * Recording new badblocks for faulty rdev will force unnecessary
@@ -9862,33 +9861,35 @@ int rdev_set_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 		s += rdev->new_data_offset;
 	else
 		s += rdev->data_offset;
-	rv = badblocks_set(&rdev->badblocks, s, sectors, 0);
-	if (rv == 0) {
-		/* Make sure they get written out promptly */
-		if (test_bit(ExternalBbl, &rdev->flags))
-			sysfs_notify_dirent_safe(rdev->sysfs_unack_badblocks);
-		sysfs_notify_dirent_safe(rdev->sysfs_state);
-		set_mask_bits(&mddev->sb_flags, 0,
-			      BIT(MD_SB_CHANGE_CLEAN) | BIT(MD_SB_CHANGE_PENDING));
-		md_wakeup_thread(rdev->mddev->thread);
-		return 1;
-	} else
+
+	if (!badblocks_set(&rdev->badblocks, s, sectors, 0))
 		return 0;
+
+	/* Make sure they get written out promptly */
+	if (test_bit(ExternalBbl, &rdev->flags))
+		sysfs_notify_dirent_safe(rdev->sysfs_unack_badblocks);
+	sysfs_notify_dirent_safe(rdev->sysfs_state);
+	set_mask_bits(&mddev->sb_flags, 0,
+		      BIT(MD_SB_CHANGE_CLEAN) | BIT(MD_SB_CHANGE_PENDING));
+	md_wakeup_thread(rdev->mddev->thread);
+	return 1;
 }
 EXPORT_SYMBOL_GPL(rdev_set_badblocks);
 
 int rdev_clear_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 			 int is_new)
 {
-	int rv;
 	if (is_new)
 		s += rdev->new_data_offset;
 	else
 		s += rdev->data_offset;
-	rv = badblocks_clear(&rdev->badblocks, s, sectors);
-	if ((rv == 0) && test_bit(ExternalBbl, &rdev->flags))
+
+	if (!badblocks_clear(&rdev->badblocks, s, sectors))
+		return 0;
+
+	if (test_bit(ExternalBbl, &rdev->flags))
 		sysfs_notify_dirent_safe(rdev->sysfs_badblocks);
-	return rv;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(rdev_clear_badblocks);
 
diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index a002ea6fdd84..ee478ccde7c6 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -167,7 +167,7 @@ static void set_badblock(struct badblocks *bb, sector_t s, int num)
 	dev_dbg(bb->dev, "Found a bad range (0x%llx, 0x%llx)\n",
 			(u64) s * 512, (u64) num * 512);
 	/* this isn't an error as the hardware will still throw an exception */
-	if (badblocks_set(bb, s, num, 1))
+	if (!badblocks_set(bb, s, num, 1))
 		dev_info_once(bb->dev, "%s: failed for sector %llx\n",
 				__func__, (u64) s);
 }
diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index 670f2dae692f..8764bed9ff16 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -50,9 +50,9 @@ struct badblocks_context {
 
 int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 		   sector_t *first_bad, int *bad_sectors);
-int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
-			int acknowledged);
-int badblocks_clear(struct badblocks *bb, sector_t s, int sectors);
+bool badblocks_set(struct badblocks *bb, sector_t s, int sectors,
+		   int acknowledged);
+bool badblocks_clear(struct badblocks *bb, sector_t s, int sectors);
 void ack_all_badblocks(struct badblocks *bb);
 ssize_t badblocks_show(struct badblocks *bb, char *page, int unack);
 ssize_t badblocks_store(struct badblocks *bb, const char *page, size_t len,
-- 
2.39.2


