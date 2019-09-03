Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42CA68FC
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfICMwH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 08:52:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729119AbfICMwH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 3 Sep 2019 08:52:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CD98D857C5D0697D1DBA;
        Tue,  3 Sep 2019 20:52:05 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 20:51:58 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.de>, <yuyufen@huawei.com>
Subject: [PATCH v2] md/raid1: fail run raid1 array when active disk less than one
Date:   Tue, 3 Sep 2019 21:12:41 +0800
Message-ID: <20190903131241.656-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When run test case:
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

mdadm run fail with kernel message as follow:
[  172.986064] md: kicking non-fresh sdb from array!
[  173.004210] md: kicking non-fresh sdc from array!
[  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
[  173.022406] md1: failed to create bitmap (-5)

In fact, when active disk in raid1 array less than one, we
need to return fail in raid1_run().

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid1.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 34e26834ad28..2a554464d6a4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3127,6 +3127,13 @@ static int raid1_run(struct mddev *mddev)
 		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
 		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
 			mddev->degraded++;
+	/*
+	 * RAID1 needs at least one disk in active
+	 */
+	if (conf->raid_disks - mddev->degraded < 1) {
+		ret = -EINVAL;
+		goto abort;
+	}
 
 	if (conf->raid_disks - mddev->degraded == 1)
 		mddev->recovery_cp = MaxSector;
@@ -3160,8 +3167,12 @@ static int raid1_run(struct mddev *mddev)
 	ret = md_integrity_register(mddev);
 	if (ret) {
 		md_unregister_thread(&mddev->thread);
-		raid1_free(mddev, conf);
+		goto abort;
 	}
+	return 0;
+
+abort:
+	raid1_free(mddev, conf);
 	return ret;
 }
 
-- 
2.17.2

