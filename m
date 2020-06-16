Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B911FAC51
	for <lists+linux-raid@lfdr.de>; Tue, 16 Jun 2020 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPJZ6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Jun 2020 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPJZ6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 16 Jun 2020 05:25:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE2C05BD43
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 02:25:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so20683774ejd.13
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rVPhQ0e5W5NkdaIhgrB7+B4rzxvdoAfAX6y/KdCvN+k=;
        b=KApawe4xwKWpFjWbRew9kt4ngUouhi59pcdd2zqQhn9dr6rAs3HGrFkKdHdm6XtLSw
         7d6zNlFC94xp/sXeEBQUn6vYCd67ttw+LWTUAzp18VwCaRaH9bUswoOpHie7Iw6Ui+/a
         dv/wjJ9KVUV9yqvKD+A6XcJUO1TEMBTKTSSK8/tGF6jxi+AXOvxkIUvv4fQ0+lohzTxk
         eW6lWvm5bsX+/ZyBL4TjhiBwUuLvdUsckM3MPHTxgQ1ygK4t+k2BL/1Ql+aFg3ksJqPt
         urgPyTaiZrY6FDOREVOBggGevYPkrpDP6J0IpIGgnEeGR5Iu9Sb6uO4B5r37Cfv/3QYZ
         T7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rVPhQ0e5W5NkdaIhgrB7+B4rzxvdoAfAX6y/KdCvN+k=;
        b=hnnajz2Dxfg5pnmxn203PMBaSh6lE/TsadE+cx2npkysAQqDE29SJLn9AJURvRJ5sG
         Hxj5tuPgqv8pQjVezCpxwo+r8DO9rFLYRRR/Xbce8pX7ScesoE2D41c63NSXvX+rWhCW
         6bcqAbsyuiCTYOn6AcGJ83uBm9zYCaf/yBZ4J3rUU+TTBqVi2xHlx7p5Dba6PbukFn55
         QN5viblgJ/5qveJyBDO14rmuwMfOU8zo0BJNapYK3jsHTjBuWeG8xCeRmrDDU2j6UPyn
         VSngksvBPojrw632LJy3W1jo69HDSapwPuS+Lyl+b997BW104DCWYFLl+RKD15zQNna8
         SH7A==
X-Gm-Message-State: AOAM531si+ZL+3ArLbgQgbCnhTApatXxWaiEB9Ph3g1AKY17vWq8lqWL
        XGSTON2Wl/uVukF8Dp8Ho8xeiK8+c6choQ==
X-Google-Smtp-Source: ABdhPJz9OHzu/t+gOuv5yFMuL+1aYn9rdMm6FEXFAaGQe2/K1ooZJFAkbmhyKHyeJL9nH/epWzba5A==
X-Received: by 2002:a17:906:c455:: with SMTP id ck21mr1840109ejb.342.1592299556165;
        Tue, 16 Jun 2020 02:25:56 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48b1:7500:b0c1:1cd:44ba:a39f])
        by smtp.gmail.com with ESMTPSA id o4sm9801521edt.15.2020.06.16.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:25:55 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/3] raid5: call clear_batch_ready before set STRIPE_ACTIVE
Date:   Tue, 16 Jun 2020 11:25:50 +0200
Message-Id: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We tried to only put the head sh of batch list to handle_list, then the
handle_stripe doesn't handle other members in the batch list. However,
we still got the calltrace in break_stripe_batch_list.

[593764.644269] stripe state: 2003
kernel: [593764.644299] ------------[ cut here ]------------
kernel: [593764.644308] WARNING: CPU: 12 PID: 856 at drivers/md/raid5.c:4625 break_stripe_batch_list+0x203/0x240 [raid456]
[...]
kernel: [593764.644363] Call Trace:
kernel: [593764.644370]  handle_stripe+0x907/0x20c0 [raid456]
kernel: [593764.644376]  ? __wake_up_common_lock+0x89/0xc0
kernel: [593764.644379]  handle_active_stripes.isra.57+0x35f/0x570 [raid456]
kernel: [593764.644382]  ? raid5_wakeup_stripe_thread+0x96/0x1f0 [raid456]
kernel: [593764.644385]  raid5d+0x480/0x6a0 [raid456]
kernel: [593764.644390]  ? md_thread+0x11f/0x160
kernel: [593764.644392]  md_thread+0x11f/0x160
kernel: [593764.644394]  ? wait_woken+0x80/0x80
kernel: [593764.644396]  kthread+0xfc/0x130
kernel: [593764.644398]  ? find_pers+0x70/0x70
kernel: [593764.644399]  ? kthread_create_on_node+0x70/0x70
kernel: [593764.644401]  ret_from_fork+0x1f/0x30

As we can see, the stripe was set with STRIPE_ACTIVE and STRIPE_HANDLE,
and only handle_stripe could set those flags then return. And since the
stipe was already in the batch list, we need to return earlier before
set the two flags.

And after dig a little about git history especially commit 3664847d95e6
("md/raid5: fix a race condition in stripe batch"), it seems the batched
stipe still could be handled by handle_stipe, then handle_stipe needs to
return earlier if clear_batch_ready to return true.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
Another alternative would be just not warn if STRIPE_ACTIVE is valid for 
the batched list.

What do you think?

Thanks,
Guoqing

 drivers/md/raid5.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ab8067f9ce8c..a35332364f07 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4682,6 +4682,16 @@ static void handle_stripe(struct stripe_head *sh)
 	struct r5dev *pdev, *qdev;
 
 	clear_bit(STRIPE_HANDLE, &sh->state);
+
+	/*
+	 * handle_stripe should not continue handle the batched stripe, only
+	 * the head of batch list or lone stripe can continue. Otherwise we
+	 * could see break_stripe_batch_list warns about the STRIPE_ACTIVE
+	 * is set for the batched stripe.
+	 */
+	if (clear_batch_ready(sh))
+		return;
+
 	if (test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)) {
 		/* already being handled, ensure it gets handled
 		 * again when current action finishes */
@@ -4689,11 +4699,6 @@ static void handle_stripe(struct stripe_head *sh)
 		return;
 	}
 
-	if (clear_batch_ready(sh) ) {
-		clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
-		return;
-	}
-
 	if (test_and_clear_bit(STRIPE_BATCH_ERR, &sh->state))
 		break_stripe_batch_list(sh, 0);
 
-- 
2.17.1

