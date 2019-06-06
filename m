Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891F837620
	for <lists+linux-raid@lfdr.de>; Thu,  6 Jun 2019 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfFFOLw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Jun 2019 10:11:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfFFOLw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 Jun 2019 10:11:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D08B3C49ACED63F18956
        for <linux-raid@vger.kernel.org>; Thu,  6 Jun 2019 22:11:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Jun 2019
 22:11:43 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <linux-raid@vger.kernel.org>
CC:     <liu.song.a23@gmail.com>
Subject: [PATCH 2/2] md/raid1: get rid of extra blank line and space
Date:   Thu, 6 Jun 2019 22:29:18 +0800
Message-ID: <20190606142918.36376-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190606142918.36376-1-yuyufen@huawei.com>
References: <20190606142918.36376-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This patch get rid of extra blank line and space, and
add necessary space for code.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid1.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2aa36e570e04..9532408c1f7a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1449,7 +1449,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		if (!r1_bio->bios[i])
 			continue;
 
-
 		if (first_clone) {
 			/* do behind I/O ?
 			 * Not if there are too many, or cannot
@@ -1729,9 +1728,8 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		first = last = rdev->saved_raid_disk;
 
 	for (mirror = first; mirror <= last; mirror++) {
-		p = conf->mirrors+mirror;
+		p = conf->mirrors + mirror;
 		if (!p->rdev) {
-
 			if (mddev->gendisk)
 				disk_stack_limits(mddev->gendisk, rdev->bdev,
 						  rdev->data_offset << 9);
@@ -2888,7 +2886,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (read_targets == 1)
 			bio->bi_opf &= ~MD_FAILFAST;
 		generic_make_request(bio);
-
 	}
 	return nr_sectors;
 }
@@ -3089,7 +3086,7 @@ static int raid1_run(struct mddev *mddev)
 	}
 
 	mddev->degraded = 0;
-	for (i=0; i < conf->raid_disks; i++)
+	for (i = 0; i < conf->raid_disks; i++)
 		if (conf->mirrors[i].rdev == NULL ||
 		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
 		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
@@ -3124,7 +3121,7 @@ static int raid1_run(struct mddev *mddev)
 						  mddev->queue);
 	}
 
-	ret =  md_integrity_register(mddev);
+	ret = md_integrity_register(mddev);
 	if (ret) {
 		md_unregister_thread(&mddev->thread);
 		raid1_free(mddev, conf);
-- 
2.17.2

