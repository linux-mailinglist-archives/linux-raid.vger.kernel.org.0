Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1E1118101
	for <lists+linux-raid@lfdr.de>; Tue, 10 Dec 2019 08:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLJHCN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Dec 2019 02:02:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfLJHCN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Dec 2019 02:02:13 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E5818BCB630BD0D3C4FA;
        Tue, 10 Dec 2019 15:02:10 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Dec 2019
 15:02:03 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH] md: make sure desc_nr less than MD_SB_DISKS
Date:   Tue, 10 Dec 2019 15:01:29 +0800
Message-ID: <20191210070129.2704-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For super_90_load, we need to make sure 'desc_nr' less
than MD_SB_DISKS, avoiding invalid memory access of 'sb->disks'.

Fixes: 228fc7d76db6 ("md: avoid invalid memory access for array sb->dev_roles")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 805b33e27496..4e7c9f398bc6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1159,6 +1159,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 	/* not spare disk, or LEVEL_MULTIPATH */
 	if (sb->level == LEVEL_MULTIPATH ||
 		(rdev->desc_nr >= 0 &&
+		 rdev->desc_nr < MD_SB_DISKS &&
 		 sb->disks[rdev->desc_nr].state &
 		 ((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE))))
 		spare_disk = false;
-- 
2.17.2

