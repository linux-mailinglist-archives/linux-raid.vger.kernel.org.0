Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7642343C5
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jul 2020 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbgGaJ4G (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jul 2020 05:56:06 -0400
Received: from mail.synology.com ([211.23.38.101]:59416 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732244AbgGaJ4F (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 31 Jul 2020 05:56:05 -0400
Received: from localhost.localdomain (unknown [10.17.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 00E9ECE7831C;
        Fri, 31 Jul 2020 17:50:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1596189035; bh=nVZuyb/FmB7TOig9H4e/sXm2KFo5ZlxXWxHZkj30Hzo=;
        h=From:To:Cc:Subject:Date;
        b=p9yOLrlaP3SLfUjZe7apoTBlINr5AWubi5/uKzsUGI6tFz60+w2k1eB8i8QXXa/Fy
         JEYleBt0C1ZXdEKJF76P89F1yihoyoKfMHZi1JQcSwscWDt8dbXhLYu9r3PDWk+FJJ
         xg4D3nt1JUFzUqfNW3rntkHtaEjyMGimrE7wwkZs=
From:   allenpeng <allenpeng@synology.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, ChangSyun Peng <allenpeng@synology.com>
Subject: [PATCH 2/2] md/raid5: Allow degraded raid6 to do rmw
Date:   Fri, 31 Jul 2020 17:50:31 +0800
Message-Id: <1596189031-3082-1-git-send-email-allenpeng@synology.com>
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

Degraded raid6 always do reconstruct-write now. With raid6 xor supported,
we can do rmw in degraded raid6. This patch can reduce many read IOs to
improve performance.

If the failed disk is P, Q or the disk we want to write to, we may need to
do reconstruct-write in max degraded raid6. In this situation we can not
read enough data from handle_stripe_dirtying() so we have to set force_rcw
in handle_stripe_fill() to read all data.

Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Reviewed-by: Danny Shih <dannyshih@synology.com>
Signed-off-by: ChangSyun Peng <allenpeng@synology.com>
---
 drivers/md/raid5.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 43eedf7..02760f3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3538,6 +3538,7 @@ static int need_this_block(struct stripe_head *sh, struct stripe_head_state *s,
 	struct r5dev *fdev[2] = { &sh->dev[s->failed_num[0]],
 				  &sh->dev[s->failed_num[1]] };
 	int i;
+	bool force_rcw = (sh->raid_conf->rmw_level == PARITY_DISABLE_RMW);
 
 
 	if (test_bit(R5_LOCKED, &dev->flags) ||
@@ -3596,18 +3597,27 @@ static int need_this_block(struct stripe_head *sh, struct stripe_head_state *s,
 			 * devices must be read.
 			 */
 			return 1;
+
+		if (s->failed >= 2 &&
+		    (fdev[i]->towrite ||
+		     s->failed_num[i] == sh->pd_idx ||
+		     s->failed_num[i] == sh->qd_idx) &&
+		    !test_bit(R5_UPTODATE, &fdev[i]->flags))
+			/* In max degraded raid6, If the failed disk is P, Q,
+			 * or we want to read the failed disk, we need to do
+			 * reconstruct-write.
+			 */
+			force_rcw = true;
 	}
 
-	/* If we are forced to do a reconstruct-write, either because
-	 * the current RAID6 implementation only supports that, or
-	 * because parity cannot be trusted and we are currently
-	 * recovering it, there is extra need to be careful.
+	/* If we are forced to do a reconstruct-write, because parity
+	 * cannot be trusted and we are currently recovering it, there
+	 * is extra need to be careful.
 	 * If one of the devices that we would need to read, because
 	 * it is not being overwritten (and maybe not written at all)
 	 * is missing/faulty, then we need to read everything we can.
 	 */
-	if (sh->raid_conf->level != 6 &&
-	    sh->raid_conf->rmw_level != PARITY_DISABLE_RMW &&
+	if (!force_rcw &&
 	    sh->sector < sh->raid_conf->mddev->recovery_cp)
 		/* reconstruct-write isn't being forced */
 		return 0;
-- 
2.7.4

