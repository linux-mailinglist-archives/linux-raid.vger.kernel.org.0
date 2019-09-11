Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D585AAF461
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfIKClR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 22:41:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfIKClQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Sep 2019 22:41:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21E95AE61463103CCECA;
        Wed, 11 Sep 2019 10:41:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 10:41:06 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <yuyufen@huawei.com>
Subject: [PATCH v3 2/2] md: don't let spare disk become the fresh disk in analyze_sbs()
Date:   Wed, 11 Sep 2019 11:01:42 +0800
Message-ID: <20190911030142.49105-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190911030142.49105-1-yuyufen@huawei.com>
References: <20190911030142.49105-1-yuyufen@huawei.com>
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
 drivers/md/md.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b890678f225c..532c00ab571b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3617,14 +3617,18 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
  * Check a full RAID array for plausibility
  */
 
-static void analyze_sbs(struct mddev *mddev)
+static int analyze_sbs(struct mddev *mddev)
 {
 	int i;
 	struct md_rdev *rdev, *freshest, *tmp;
 	char b[BDEVNAME_SIZE];
 
 	freshest = NULL;
-	rdev_for_each_safe(rdev, tmp, mddev)
+	rdev_for_each_safe(rdev, tmp, mddev) {
+		/* rdev is spare, or sb invalid */
+		if (super_types[mddev->major_version].disk_is_spare(mddev, rdev))
+			continue;
+
 		switch (super_types[mddev->major_version].
 			load_super(rdev, freshest, mddev->minor_version)) {
 		case 1:
@@ -3637,7 +3641,11 @@ static void analyze_sbs(struct mddev *mddev)
 				bdevname(rdev->bdev,b));
 			md_kick_rdev_from_array(rdev);
 		}
+	}
 
+	/* Cannot find a valid disk */
+	if (!freshest)
+		return -EINVAL;
 	super_types[mddev->major_version].
 		validate_super(mddev, freshest);
 
@@ -3672,6 +3680,8 @@ static void analyze_sbs(struct mddev *mddev)
 			clear_bit(In_sync, &rdev->flags);
 		}
 	}
+
+	return 0;
 }
 
 /* Read a fixed-point number.
@@ -5556,7 +5566,9 @@ int md_run(struct mddev *mddev)
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

