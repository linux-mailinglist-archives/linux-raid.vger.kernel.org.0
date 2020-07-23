Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42422A606
	for <lists+linux-raid@lfdr.de>; Thu, 23 Jul 2020 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgGWD2R (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 23:28:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733229AbgGWD2Q (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 23:28:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D5A85CC514D8259983B0;
        Thu, 23 Jul 2020 11:28:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 11:28:10 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>
Subject: [PATCH] md/raid5: use do_div() for 64 bit divisions
Date:   Wed, 22 Jul 2020 23:29:05 -0400
Message-ID: <20200723032905.864569-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 32-bit architectures (e.g. m68k):

  ERROR: modpost: "__udivdi3" [drivers/md/raid456.ko] undefined!

Since 'sync_blocks' is defined as 64bit, we should use do_div() to
fix this error.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 40961dd1777b..a6ff6e1e039b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6104,7 +6104,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	    !md_bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
 	    sync_blocks >= RAID5_STRIPE_SECTORS(conf)) {
 		/* we can skip this block, and probably more */
-		sync_blocks /= RAID5_STRIPE_SECTORS(conf);
+		do_div(sync_blocks, RAID5_STRIPE_SECTORS(conf));
 		*skipped = 1;
 		/* keep things rounded to whole stripes */
 		return sync_blocks * RAID5_STRIPE_SECTORS(conf);
-- 
2.25.4

