Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A6E99F6
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfJ3KZl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 06:25:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfJ3KZk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 06:25:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E5A5493A75C935E2A1A1;
        Wed, 30 Oct 2019 18:25:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 18:25:36 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>
Subject: [PATCH v2] md: avoid invalid memory access for array sb->dev_roles
Date:   Wed, 30 Oct 2019 18:47:02 +0800
Message-ID: <20191030104702.3640-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

we need to gurantee 'desc_nr' valid before access array
of sb->dev_roles.

In addition, we should avoid .load_super always return '0'
when level is LEVEL_MULTIPATH, which is not expected.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1487373 ("Memory - illegal accesses")
Fixes: 6a5cb53aaa4e ("md: no longer compare spare disk superblock events in super_load")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 51 +++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc6ae8276a92..5b35c5f99c00 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1098,6 +1098,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	mdp_super_t *sb;
 	int ret;
+	bool spare_disk = true;
 
 	/*
 	 * Calculate the position of the superblock (512byte sectors),
@@ -1148,13 +1149,15 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 	else
 		rdev->desc_nr = sb->this_disk.number;
 
+	/* not spare disk, or LEVEL_MULTIPATH */
+	if (sb->level == LEVEL_MULTIPATH ||
+		(rdev->desc_nr >= 0 &&
+		 sb->disks[rdev->desc_nr].state &
+		 ((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE))))
+		spare_disk = false;
+
 	if (!refdev) {
-		/*
-		 * Insist on good event counter while assembling, except
-		 * for spares (which don't need an event count)
-		 */
-		if (sb->disks[rdev->desc_nr].state & (
-			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
+		if (!spare_disk)
 			ret = 1;
 		else
 			ret = 0;
@@ -1174,13 +1177,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 		ev1 = md_event(sb);
 		ev2 = md_event(refsb);
 
-		/*
-		 * Insist on good event counter while assembling, except
-		 * for spares (which don't need an event count)
-		 */
-		if (sb->disks[rdev->desc_nr].state & (
-			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)) &&
-			(ev1 > ev2))
+		if (!spare_disk && ev1 > ev2)
 			ret = 1;
 		else
 			ret = 0;
@@ -1540,7 +1537,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	sector_t sectors;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	int bmask;
-	__u64 role;
+	bool spare_disk = true;
 
 	/*
 	 * Calculate the position of the superblock in 512byte sectors.
@@ -1674,17 +1671,16 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	    sb->level != 0)
 		return -EINVAL;
 
-	role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+	/* not spare disk, or LEVEL_MULTIPATH */
+	if (sb->level == cpu_to_le32(LEVEL_MULTIPATH) ||
+		(rdev->desc_nr >= 0 &&
+		rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+		(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+		 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL)))
+		spare_disk = false;
 
 	if (!refdev) {
-		/*
-		 * Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count)
-		 */
-		if (rdev->desc_nr >= 0 &&
-		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
-			(role < MD_DISK_ROLE_MAX ||
-			 role == MD_DISK_ROLE_JOURNAL))
+		if (!spare_disk)
 			ret = 1;
 		else
 			ret = 0;
@@ -1704,14 +1700,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		ev1 = le64_to_cpu(sb->events);
 		ev2 = le64_to_cpu(refsb->events);
 
-		/*
-		 * Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count)
-		 */
-		if (rdev->desc_nr >= 0 &&
-		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
-			(role < MD_DISK_ROLE_MAX ||
-			 role == MD_DISK_ROLE_JOURNAL) && ev1 > ev2)
+		if (!spare_disk && ev1 > ev2)
 			ret = 1;
 		else
 			ret = 0;
-- 
2.17.2

