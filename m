Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E070AE92C
	for <lists+linux-raid@lfdr.de>; Tue, 10 Sep 2019 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfIJLbK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 07:31:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729171AbfIJLbK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Sep 2019 07:31:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE7192C3BF28D02F79D9;
        Tue, 10 Sep 2019 19:31:08 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 19:31:00 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.de>, <yuyufen@huawei.com>
Subject: [PATCH v2] md: don't let spare disk become the fresh disk in analyze_sbs()
Date:   Tue, 10 Sep 2019 19:51:34 +0800
Message-ID: <20190910115134.12328-1-yuyufen@huawei.com>
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

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..5a566750afc1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3571,18 +3571,56 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return ERR_PTR(err);
 }
 
+static int disk_is_spare(struct mddev *mddev, struct md_rdev *rdev)
+{
+	int err;
+
+	err = super_types[mddev->major_version].
+			load_super(rdev, NULL, mddev->minor_version);
+	if (err < 0)
+		return err;
+
+	if (mddev->major_version == 0) {
+		mdp_super_t *sb;
+		sb = page_address(rdev->sb_page);
+
+		if (sb->disks[rdev->desc_nr].state &
+			((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
+			return 0;
+
+	} else if (mddev->major_version == 1){
+		struct mdp_superblock_1 *sb;
+		sb = page_address(rdev->sb_page);
+
+		if (rdev->desc_nr >= 0 &&
+			rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+			le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
+			return 0;
+	}
+
+	return 1;
+}
+
 /*
  * Check a full RAID array for plausibility
  */
 
-static void analyze_sbs(struct mddev *mddev)
+static int analyze_sbs(struct mddev *mddev)
 {
 	int i;
 	struct md_rdev *rdev, *freshest, *tmp;
 	char b[BDEVNAME_SIZE];
+	int ret = 0;
 
 	freshest = NULL;
-	rdev_for_each_safe(rdev, tmp, mddev)
+	rdev_for_each_safe(rdev, tmp, mddev) {
+		/*
+		 * we skip spare disk as fresh disk.
+		 */
+		if (disk_is_spare(mddev, rdev))
+			continue;
+
 		switch (super_types[mddev->major_version].
 			load_super(rdev, freshest, mddev->minor_version)) {
 		case 1:
@@ -3595,6 +3633,10 @@ static void analyze_sbs(struct mddev *mddev)
 				bdevname(rdev->bdev,b));
 			md_kick_rdev_from_array(rdev);
 		}
+	}
+
+	if (!freshest)
+		return -EINVAL;
 
 	super_types[mddev->major_version].
 		validate_super(mddev, freshest);
@@ -3630,6 +3672,7 @@ static void analyze_sbs(struct mddev *mddev)
 			clear_bit(In_sync, &rdev->flags);
 		}
 	}
+	return ret;
 }
 
 /* Read a fixed-point number.
@@ -5514,7 +5557,9 @@ int md_run(struct mddev *mddev)
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

