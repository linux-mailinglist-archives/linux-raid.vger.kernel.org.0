Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469C92343C4
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jul 2020 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbgGaJ4E (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jul 2020 05:56:04 -0400
Received: from mail.synology.com ([211.23.38.101]:59388 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732185AbgGaJ4E (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 31 Jul 2020 05:56:04 -0400
Received: from localhost.localdomain (unknown [10.17.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id F306ECE7831A;
        Fri, 31 Jul 2020 17:50:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1596189023; bh=/P+ek8KG/hRYsF9WvtqVlv8RGCsC0FUQ4wqcnFSSzSI=;
        h=From:To:Cc:Subject:Date;
        b=Rn32ALaG0sEyGIreXD28K+zL8FKlesRxPPopRFerr3Fuj/qXqtSpw3xfn2GiqKPlT
         Noh1kjzZ8YqCPHifaSRWRAthm6VkidTwB6BCRIcWA80k86M20YI+bY8ldruLPOwqCy
         /ffUtn2zS4ThhyLLA76yLoFPci/neoZCUO2U1qaA=
From:   allenpeng <allenpeng@synology.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, ChangSyun Peng <allenpeng@synology.com>
Subject: [PATCH 1/2] md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
Date:   Fri, 31 Jul 2020 17:50:17 +0800
Message-Id: <1596189017-3038-1-git-send-email-allenpeng@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: ChangSyun Peng <allenpeng@synology.com>

In degraded raid5, we need to read parity to do reconstruct-write when
data disks fail. However, we can not read parity from
handle_stripe_dirtying() in force reconstruct-write mode.

Reproducible Steps:

1. Create degraded raid5
mdadm -C /dev/md2 --assume-clean -l5 -n3 /dev/sda2 /dev/sdb2 missing
2. Set rmw_level to 0
echo 0 > /sys/block/md2/md/rmw_level
3. IO to raid5

Now some io may be stuck in raid5. We can use handle_stripe_fill() to read
the parity in this situation.

Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Reviewed-by: Danny Shih <dannyshih@synology.com>
Signed-off-by: ChangSyun Peng <allenpeng@synology.com>
---
 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ab8067f..43eedf7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3607,6 +3607,7 @@ static int need_this_block(struct stripe_head *sh, struct stripe_head_state *s,
 	 * is missing/faulty, then we need to read everything we can.
 	 */
 	if (sh->raid_conf->level != 6 &&
+	    sh->raid_conf->rmw_level != PARITY_DISABLE_RMW &&
 	    sh->sector < sh->raid_conf->mddev->recovery_cp)
 		/* reconstruct-write isn't being forced */
 		return 0;
@@ -4842,7 +4843,7 @@ static void handle_stripe(struct stripe_head *sh)
 	 * or to load a block that is being partially written.
 	 */
 	if (s.to_read || s.non_overwrite
-	    || (conf->level == 6 && s.to_write && s.failed)
+	    || (s.to_write && s.failed)
 	    || (s.syncing && (s.uptodate + s.compute < disks))
 	    || s.replacing
 	    || s.expanding)
-- 
2.7.4

