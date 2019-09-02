Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04E8A4F64
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfIBG4B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 02:56:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729393AbfIBG4B (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 02:56:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 16899FB8CC5BBBBF3952;
        Mon,  2 Sep 2019 14:55:59 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Sep 2019
 14:55:48 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.de>, <yuyufen@huawei.com>
Subject: [PATCH] md: no longer compare spare disk superblock events in super_load
Date:   Mon, 2 Sep 2019 15:16:23 +0800
Message-ID: <20190902071623.21388-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We have a test case as follow:

  mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] --assume-clean --bitmap=internal
  mdadm -S /dev/md1
  mdadm -A /dev/md1 /dev/sd[b-c] --run --force

  mdadm --zero /dev/sda
  mdadm /dev/md1 -a /dev/sda

  echo offline > /sys/block/sdc/device/state
  echo offline > /sys/block/sdb/device/state
  sleep 5
  mdadm -S /dev/md1

  echo running > /sys/block/sdb/device/state
  echo running > /sys/block/sdc/device/state
  mdadm -A /dev/md1 /dev/sd[a-c] --run --force

When we readd /dev/sda to the array, it started to do recovery.
After offline the other two disks in md1, the recovery have
been interrupted and superblock update info cannot be written
to the offline disks. While the spare disk (/dev/sda) can continue
to update superblock info.

After stopping the array and assemble it, we found the array
run fail, with the follow kernel message:

[  172.986064] md: kicking non-fresh sdb from array!
[  173.004210] md: kicking non-fresh sdc from array!
[  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
[  173.022406] md1: failed to create bitmap (-5)
[  173.023466] md: md1 stopped.

Since both sdb and sdc have the value of 'sb->events' smaller than
that in sda, they have been kicked from the array. However, the only
remained disk sda is in 'spare' state before stop and it cannot be
added to conf->mirrors[] array. In the end, raid array assemble and run fail.

In fact, we can use the older disk sdb or sdc to assemble the array.
That means we should not choose the 'spare' disk as the fresh disk in
analyze_sbs().

To fix the problem, we do not compare superblock events when it is
a spare disk, as same as validate_super.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..350e1f152e97 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1092,7 +1092,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 {
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	mdp_super_t *sb;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Calculate the position of the superblock (512byte sectors),
@@ -1160,10 +1160,13 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 		}
 		ev1 = md_event(sb);
 		ev2 = md_event(refsb);
-		if (ev1 > ev2)
-			ret = 1;
-		else
-			ret = 0;
+
+		/* Insist on good event counter while assembling, except
+		 * for spares (which don't need an event count) */
+		if (sb->disks[rdev->desc_nr].state & (
+			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
+			if (ev1 > ev2)
+				ret = 1;
 	}
 	rdev->sectors = rdev->sb_start;
 	/* Limit to 4TB as metadata cannot record more than that.
@@ -1513,7 +1516,7 @@ static __le32 calc_sb_1_csum(struct mdp_superblock_1 *sb)
 static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_version)
 {
 	struct mdp_superblock_1 *sb;
-	int ret;
+	int ret = 0;
 	sector_t sb_start;
 	sector_t sectors;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
@@ -1665,10 +1668,14 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		ev1 = le64_to_cpu(sb->events);
 		ev2 = le64_to_cpu(refsb->events);
 
-		if (ev1 > ev2)
-			ret = 1;
-		else
-			ret = 0;
+		/* Insist of good event counter while assembling, except for
+		 * spares (which don't need an event count) */
+		if (rdev->desc_nr >= 0 &&
+		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+		    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+		     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
+			if (ev1 > ev2)
+				ret = 1;
 	}
 	if (minor_version) {
 		sectors = (i_size_read(rdev->bdev->bd_inode) >> 9);
-- 
2.17.2

