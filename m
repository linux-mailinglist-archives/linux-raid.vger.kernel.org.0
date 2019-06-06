Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFA3761E
	for <lists+linux-raid@lfdr.de>; Thu,  6 Jun 2019 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfFFOLs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Jun 2019 10:11:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfFFOLs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 Jun 2019 10:11:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D843C13855F021F13C91
        for <linux-raid@vger.kernel.org>; Thu,  6 Jun 2019 22:11:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Jun 2019
 22:11:43 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <linux-raid@vger.kernel.org>
CC:     <liu.song.a23@gmail.com>
Subject: [PATCH 1/2] md: fix spelling typo and add necessary space
Date:   Thu, 6 Jun 2019 22:29:17 +0800
Message-ID: <20190606142918.36376-2-yuyufen@huawei.com>
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

This patch fix a spelling typo and add necessary space for code.
In addition, the patch get rid of the unnecessary 'if'.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 04f4f131f9d6..614704252da9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5639,8 +5639,7 @@ int md_run(struct mddev *mddev)
 	spin_unlock(&mddev->lock);
 	rdev_for_each(rdev, mddev)
 		if (rdev->raid_disk >= 0)
-			if (sysfs_link_rdev(mddev, rdev))
-				/* failure here is OK */;
+			sysfs_link_rdev(mddev, rdev); /* failure here is OK */
 
 	if (mddev->degraded && !mddev->ro)
 		/* This ensures that recovering status is reported immediately
@@ -8190,8 +8189,7 @@ void md_do_sync(struct md_thread *thread)
 {
 	struct mddev *mddev = thread->mddev;
 	struct mddev *mddev2;
-	unsigned int currspeed = 0,
-		 window;
+	unsigned int currspeed = 0, window;
 	sector_t max_sectors,j, io_sectors, recovery_done;
 	unsigned long mark[SYNC_MARKS];
 	unsigned long update_time;
@@ -8248,7 +8246,7 @@ void md_do_sync(struct md_thread *thread)
 	 * 0 == not engaged in resync at all
 	 * 2 == checking that there is no conflict with another sync
 	 * 1 == like 2, but have yielded to allow conflicting resync to
-	 *		commense
+	 *		commence
 	 * other == active in resync - this many blocks
 	 *
 	 * Before starting a resync we must have set curr_resync to
@@ -8379,7 +8377,7 @@ void md_do_sync(struct md_thread *thread)
 	/*
 	 * Tune reconstruction:
 	 */
-	window = 32*(PAGE_SIZE/512);
+	window = 32 * (PAGE_SIZE / 512);
 	pr_debug("md: using %dk window, over a total of %lluk.\n",
 		 window/2, (unsigned long long)max_sectors/2);
 
@@ -9192,7 +9190,6 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 				 * perform resync with the new activated disk */
 				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 				md_wakeup_thread(mddev->thread);
-
 			}
 			/* device faulty
 			 * We just want to do the minimum to mark the disk
-- 
2.17.2

