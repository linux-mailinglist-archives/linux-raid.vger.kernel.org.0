Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BDA1305
	for <lists+linux-raid@lfdr.de>; Thu, 29 Aug 2019 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfH2Hyl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Aug 2019 03:54:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfH2Hyl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 29 Aug 2019 03:54:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5FC47ABCBB3978BDD742;
        Thu, 29 Aug 2019 15:54:38 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 15:54:36 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>, <linux-raid@vger.kernel.org>
CC:     <neilb@suse.com>, <xni@redhat.com>
Subject: [RFC PATCH] md/raid5: set STRIPE_SIZE as a configurable value
Date:   Thu, 29 Aug 2019 16:15:14 +0800
Message-ID: <20190829081514.29660-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In RAID5, if issued bio has sectors more than STRIPE_SIZE,
it will be split in unit of STRIPE_SIZE. For bio sectors
less then STRIPE_SIZE, raid5 issue bio to disk in the size
of STRIPE_SIZE.

For now, STRIPE_SIZE is equal to the value of PAGE_SIZE.
That means, RAID5 will issus echo bio to disk at least 64KB
when use 64KB page size in arm64.

However, filesystem usually issue bio in the unit of 4KB.
Then, RAID5 will waste resource of disk bandwidth and compute xor.

To avoding the waste, we can add a CONFIG option to set
the default STRIPE_SIZE as 4096. User can also set the value
bigger than 4KB for some special requirements, such as we know
the issued io size is more than 4KB.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/Kconfig | 9 +++++++++
 drivers/md/raid5.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 3834332f4963..4263a655dbbb 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -157,6 +157,15 @@ config MD_RAID456
 
 	  If unsure, say Y.
 
+config MD_RAID456_STRIPE_SIZE
+	int "RAID4/RAID5/RAID6 stripe size"
+	default "4096"
+	depends on MD_RAID456
+	help
+	  The default value is 4096. Only change this if you know
+	  what you are doing.
+
+
 config MD_MULTIPATH
 	tristate "Multipath I/O support"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index cf991f13403e..2fcf5853b719 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -473,7 +473,7 @@ struct disk_info {
  */
 
 #define NR_STRIPES		256
-#define STRIPE_SIZE		PAGE_SIZE
+#define STRIPE_SIZE		CONFIG_MD_RAID456_STRIPE_SIZE
 #define STRIPE_SHIFT		(PAGE_SHIFT - 9)
 #define STRIPE_SECTORS		(STRIPE_SIZE>>9)
 #define	IO_THRESHOLD		1
-- 
2.17.2

