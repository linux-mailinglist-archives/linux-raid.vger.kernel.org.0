Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24551A4F72
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfIBHEJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 03:04:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfIBHEJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 03:04:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60714AC757CC1C55FED5;
        Mon,  2 Sep 2019 15:04:05 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Sep 2019
 15:03:57 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.de>, <yuyufen@huawei.com>
Subject: [PATCH] md/raid1: fail run raid1 array when active disk less than one
Date:   Mon, 2 Sep 2019 15:24:36 +0800
Message-ID: <20190902072436.23225-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When active disk in raid1 array less than one, we need to return
fail to run.

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

