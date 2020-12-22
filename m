Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A652E0702
	for <lists+linux-raid@lfdr.de>; Tue, 22 Dec 2020 09:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgLVIBS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Dec 2020 03:01:18 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38992 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVIBR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 22 Dec 2020 03:01:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UJQTnrZ_1608624014;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UJQTnrZ_1608624014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 16:00:35 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] md/raid10: fix: incompatible types in comparison expression (different address spaces).
Date:   Tue, 22 Dec 2020 16:00:10 +0800
Message-Id: <1608624010-69405-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Fixes the following sparse errors in drivers/md/raid10.c error:
incompatible types in comparison expression (different address spaces).

The error was because of the following line in function read_balance():

rdev = rcu_dereference(conf->mirrors[disk].replacement);
    if (rdev == NULL || test_bit(Faulty, &rdev->flags) ||
        r10_bio->devs[slot].addr + sectors > rdev->recovery_offset)
    rdev = rcu_dereference(conf->mirrors[disk].rdev);

Annotating the struct md_rdev *rdev and *replacement in
drivers/md/raid10.h with __rcu fixes the sparse error.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 drivers/md/raid10.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 79cd2b7..910bd5f 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -16,7 +16,8 @@
  */
 
 struct raid10_info {
-	struct md_rdev	*rdev, *replacement;
+	struct md_rdev	__rcu *rdev;
+	struct md_rdev	__rcu *replacement;
 	sector_t	head_position;
 	int		recovery_disabled;	/* matches
 						 * mddev->recovery_disabled
-- 
1.8.3.1

