Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527CE6064B
	for <lists+linux-raid@lfdr.de>; Fri,  5 Jul 2019 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfGENC3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Jul 2019 09:02:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfGENC3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 5 Jul 2019 09:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81A1F30C1CA9;
        Fri,  5 Jul 2019 13:02:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7105C225;
        Fri,  5 Jul 2019 13:02:25 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     heinzm@redhat.com, ncroxon@redhat.com, liu.song.a23@gmail.com
Subject: [PATCH] Set R5_ReadError when there is read failure on parity disk of raid6
Date:   Fri,  5 Jul 2019 21:02:20 +0800
Message-Id: <1562331740-6163-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 05 Jul 2019 13:02:29 +0000 (UTC)
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

Fixes: 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.)
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid5.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9c4f765..6cdd37f 100644
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
@@ -6128,7 +6130,10 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio,
 			return handled;
 		}
 
-		set_bit(R5_ReadNoMerge, &sh->dev[dd_idx].flags);
+		if (sh->qd_idx >= 0 && sh->pd_idx == i)
+			set_bit(R5_ReadError, &sh->dev[i].flags);
+		else
+			set_bit(R5_ReadNoMerge, &sh->dev[dd_idx].flags);
 		handle_stripe(sh);
 		raid5_release_stripe(sh);
 		handled++;
-- 
2.7.5

