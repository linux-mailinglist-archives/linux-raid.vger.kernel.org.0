Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114BFE7ED2
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 04:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfJ2DU1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Oct 2019 23:20:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfJ2DU1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 28 Oct 2019 23:20:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEC5B6DF7BE9D355DD00;
        Tue, 29 Oct 2019 11:20:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 11:20:22 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>
Subject: [PATCH] md: avoid invalid memory access for array sb->dev_roles
Date:   Tue, 29 Oct 2019 11:41:43 +0800
Message-ID: <20191029034143.47039-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

we need to gurantee 'desc_nr' valid before access array of sb->dev_roles.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1487373 ("Memory - illegal accesses")
Fixes: 6a5cb53aaa4e ("md: no longer compare spare disk superblock events in super_load")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc6ae8276a92..8832ab70e34d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1153,7 +1153,8 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 		 * Insist on good event counter while assembling, except
 		 * for spares (which don't need an event count)
 		 */
-		if (sb->disks[rdev->desc_nr].state & (
+		if (rdev->desc_nr >= 0 &&
+			sb->disks[rdev->desc_nr].state & (
 			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
 			ret = 1;
 		else
@@ -1178,7 +1179,8 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 		 * Insist on good event counter while assembling, except
 		 * for spares (which don't need an event count)
 		 */
-		if (sb->disks[rdev->desc_nr].state & (
+		if (rdev->desc_nr >= 0 &&
+			sb->disks[rdev->desc_nr].state & (
 			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)) &&
 			(ev1 > ev2))
 			ret = 1;
@@ -1540,7 +1542,6 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	sector_t sectors;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	int bmask;
-	__u64 role;
 
 	/*
 	 * Calculate the position of the superblock in 512byte sectors.
@@ -1674,8 +1675,6 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	    sb->level != 0)
 		return -EINVAL;
 
-	role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
-
 	if (!refdev) {
 		/*
 		 * Insist of good event counter while assembling, except for
@@ -1683,8 +1682,8 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
-			(role < MD_DISK_ROLE_MAX ||
-			 role == MD_DISK_ROLE_JOURNAL))
+			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+			 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
 			ret = 1;
 		else
 			ret = 0;
@@ -1710,8 +1709,9 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
-			(role < MD_DISK_ROLE_MAX ||
-			 role == MD_DISK_ROLE_JOURNAL) && ev1 > ev2)
+			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+			 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL)
+			 && ev1 > ev2)
 			ret = 1;
 		else
 			ret = 0;
-- 
2.17.2

