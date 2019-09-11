Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890C3AF460
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfIKClQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 22:41:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfIKClQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Sep 2019 22:41:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53A94973B3DF4A27A055;
        Wed, 11 Sep 2019 10:41:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 10:41:05 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <yuyufen@huawei.com>
Subject: [PATCH v3 1/2] md: add a new entry .disk_is_spare in super_types
Date:   Wed, 11 Sep 2019 11:01:41 +0800
Message-ID: <20190911030142.49105-2-yuyufen@huawei.com>
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

.disk_is_spare would read superblock info and check disk state.
If the disk is in 'spare', return 1. Otherwise, return 0.
If superblock read fail or sb info is invalid , return error code.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..b890678f225c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1065,6 +1065,8 @@ struct super_type  {
 						sector_t num_sectors);
 	int		    (*allow_new_offset)(struct md_rdev *rdev,
 						unsigned long long new_offset);
+	int			(*disk_is_spare) (struct mddev *mddev,
+						struct md_rdev *rdev);
 };
 
 /*
@@ -1484,6 +1486,24 @@ super_90_allow_new_offset(struct md_rdev *rdev, unsigned long long new_offset)
 	return new_offset == 0;
 }
 
+static int super_90_disk_is_spare(struct mddev *mddev, struct md_rdev *rdev)
+{
+	int ret;
+	mdp_super_t *sb;
+
+	ret = super_90_load(rdev, NULL, mddev->minor_version);
+	if (ret < 0)
+		return ret;
+
+	sb = page_address(rdev->sb_page);
+
+	if (sb->disks[rdev->desc_nr].state &
+		((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
+		return 0;
+
+	return 1;
+}
+
 /*
  * version 1 superblock
  */
@@ -2084,6 +2104,26 @@ super_1_allow_new_offset(struct md_rdev *rdev,
 	return 1;
 }
 
+static int super_1_disk_is_spare(struct mddev *mddev, struct md_rdev *rdev)
+{
+	int ret;
+	struct mdp_superblock_1 *sb;
+
+	ret = super_1_load(rdev, NULL, mddev->minor_version);
+	if (ret < 0)
+		return ret;
+
+	sb = page_address(rdev->sb_page);
+
+	if (rdev->desc_nr >= 0 &&
+		rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+		(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+		le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
+		return 0;
+
+	return 1;
+}
+
 static struct super_type super_types[] = {
 	[0] = {
 		.name	= "0.90.0",
@@ -2093,6 +2133,7 @@ static struct super_type super_types[] = {
 		.sync_super	    = super_90_sync,
 		.rdev_size_change   = super_90_rdev_size_change,
 		.allow_new_offset   = super_90_allow_new_offset,
+		.disk_is_spare		= super_90_disk_is_spare,
 	},
 	[1] = {
 		.name	= "md-1",
@@ -2102,6 +2143,7 @@ static struct super_type super_types[] = {
 		.sync_super	    = super_1_sync,
 		.rdev_size_change   = super_1_rdev_size_change,
 		.allow_new_offset   = super_1_allow_new_offset,
+		.disk_is_spare		= super_1_disk_is_spare,
 	},
 };
 
-- 
2.17.2

