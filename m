Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4ED89E8
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJPHif (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 03:38:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbfJPHie (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 03:38:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6844B25D9A6BB3723D72;
        Wed, 16 Oct 2019 15:38:30 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 15:38:28 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>
Subject: [PATCH v4] md: no longer compare spare disk superblock events in super_load
Date:   Wed, 16 Oct 2019 16:00:03 +0800
Message-ID: <20191016080003.38348-1-yuyufen@huawei.com>
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

  mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
	--assume-clean --bitmap=internal
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
added to conf->mirrors[] array. In the end, raid array assemble
and run fail.

In fact, we can use the older disk sdb or sdc to assemble the array.
That means we should not choose the 'spare' disk as the fresh disk in
analyze_sbs().

To fix the problem, we do not compare superblock events when it is
a spare disk, as same as validate_super.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>

v1->v2:
  fix wrong return value in super_90_load
v2->v3:
  adjust the patch format to avoid scripts/checkpatch.pl warning
v3->v4:
  fix the bug pointed out by Song, when the spare disk is the first
  device for load_super
---
 drivers/md/md.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1be7abeb24fd..fc6ae8276a92 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1149,7 +1149,15 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 		rdev->desc_nr = sb->this_disk.number;
 
 	if (!refdev) {
-		ret = 1;
+		/*
+		 * Insist on good event counter while assembling, except
+		 * for spares (which don't need an event count)
+		 */
+		if (sb->disks[rdev->desc_nr].state & (
+			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
+			ret = 1;
+		else
+			ret = 0;
 	} else {
 		__u64 ev1, ev2;
 		mdp_super_t *refsb = page_address(refdev->sb_page);
@@ -1165,7 +1173,14 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 		}
 		ev1 = md_event(sb);
 		ev2 = md_event(refsb);
-		if (ev1 > ev2)
+
+		/*
+		 * Insist on good event counter while assembling, except
+		 * for spares (which don't need an event count)
+		 */
+		if (sb->disks[rdev->desc_nr].state & (
+			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)) &&
+			(ev1 > ev2))
 			ret = 1;
 		else
 			ret = 0;
@@ -1525,6 +1540,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	sector_t sectors;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	int bmask;
+	__u64 role;
 
 	/*
 	 * Calculate the position of the superblock in 512byte sectors.
@@ -1658,8 +1674,20 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	    sb->level != 0)
 		return -EINVAL;
 
+	role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+
 	if (!refdev) {
-		ret = 1;
+		/*
+		 * Insist of good event counter while assembling, except for
+		 * spares (which don't need an event count)
+		 */
+		if (rdev->desc_nr >= 0 &&
+		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+			(role < MD_DISK_ROLE_MAX ||
+			 role == MD_DISK_ROLE_JOURNAL))
+			ret = 1;
+		else
+			ret = 0;
 	} else {
 		__u64 ev1, ev2;
 		struct mdp_superblock_1 *refsb = page_address(refdev->sb_page);
@@ -1676,7 +1704,14 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		ev1 = le64_to_cpu(sb->events);
 		ev2 = le64_to_cpu(refsb->events);
 
-		if (ev1 > ev2)
+		/*
+		 * Insist of good event counter while assembling, except for
+		 * spares (which don't need an event count)
+		 */
+		if (rdev->desc_nr >= 0 &&
+		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+			(role < MD_DISK_ROLE_MAX ||
+			 role == MD_DISK_ROLE_JOURNAL) && ev1 > ev2)
 			ret = 1;
 		else
 			ret = 0;
@@ -3597,7 +3632,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
  * Check a full RAID array for plausibility
  */
 
-static void analyze_sbs(struct mddev *mddev)
+static int analyze_sbs(struct mddev *mddev)
 {
 	int i;
 	struct md_rdev *rdev, *freshest, *tmp;
@@ -3618,6 +3653,12 @@ static void analyze_sbs(struct mddev *mddev)
 			md_kick_rdev_from_array(rdev);
 		}
 
+	/* Cannot find a valid fresh disk */
+	if (!freshest) {
+		pr_warn("md: cannot find a valid disk\n");
+		return -EINVAL;
+	}
+
 	super_types[mddev->major_version].
 		validate_super(mddev, freshest);
 
@@ -3652,6 +3693,8 @@ static void analyze_sbs(struct mddev *mddev)
 			clear_bit(In_sync, &rdev->flags);
 		}
 	}
+
+	return 0;
 }
 
 /* Read a fixed-point number.
@@ -5570,7 +5613,9 @@ int md_run(struct mddev *mddev)
 	if (!mddev->raid_disks) {
 		if (!mddev->persistent)
 			return -EINVAL;
-		analyze_sbs(mddev);
+		err = analyze_sbs(mddev);
+		if (err)
+			return -EINVAL;
 	}
 
 	if (mddev->level != LEVEL_NONE)
-- 
2.17.2

