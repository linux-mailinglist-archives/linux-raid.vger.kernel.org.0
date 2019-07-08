Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB61E6193F
	for <lists+linux-raid@lfdr.de>; Mon,  8 Jul 2019 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGHCOl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 7 Jul 2019 22:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGHCOl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 7 Jul 2019 22:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07B8C3086262;
        Mon,  8 Jul 2019 02:14:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 924972B9D5;
        Mon,  8 Jul 2019 02:14:38 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     heinzm@redhat.com, ncroxon@redhat.com, liu.song.a23@gmail.com
Subject: [V2 PATCH] Set R5_ReadError when there is read failure on parity disk of raid6
Date:   Mon,  8 Jul 2019 10:14:32 +0800
Message-Id: <1562552072-5098-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 08 Jul 2019 02:14:41 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.) It avoids to re-read P
when it can be computed from other members. But it misses the chance to re-write the right data
to P. Now it sets R5_ReadError if the re-read fails. Because it avoids the re-read, so it misses
the chance to set R5_ReadError. The re-write is submitted in state machine when r5dev has flag
R5_ReadError. So it doesn't re-write the right data to disk. We need to do this to keep the raid
having right data.

Because it don't send re-read, so it also misses the chance to reset rdev->read_erros to 0. It can
fail the disk when there are many read errors on P member disk(other disks don't have read error)

V2: upper layer read request don't read parity/Q data. So there is no need to consider such situation.
This is Reported-by: kbuild test robot <lkp@intel.com>

Fixes: 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.)
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9c4f765..7d2b2d9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2561,7 +2561,9 @@ static void raid5_end_read_request(struct bio * bi)
 		    && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
 			retry = 1;
 		if (retry)
-			if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
+			if (sh->qd_idx >= 0 && sh->pd_idx == i)
+				set_bit(R5_ReadError, &sh->dev[i].flags);
+			else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
 				set_bit(R5_ReadError, &sh->dev[i].flags);
 				clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
 			} else
-- 
2.7.5

