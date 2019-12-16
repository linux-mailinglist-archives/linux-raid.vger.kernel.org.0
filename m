Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D181207C8
	for <lists+linux-raid@lfdr.de>; Mon, 16 Dec 2019 15:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfLPN73 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Dec 2019 08:59:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46735 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfLPN72 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 16 Dec 2019 08:59:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so5063957edi.13
        for <linux-raid@vger.kernel.org>; Mon, 16 Dec 2019 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YMh5iUkY6K6Bvq1I044G9/EvAVvls1a4agNOmvjKaWg=;
        b=gbn3HClSU4i6SMf/x722G9wbPS/NJRvjjuybA9iRCLTC4g00V7WJNYSwkNPXyYxTx7
         iPd29A4jy9yj5di1TKQUva4WmdLXzv7erFoXf9I1X6zbPcYaw4Wu/xojW9dX+Dvz/aem
         /oRjePF/oAyPSIbGoJGEm+vQNI7/dbzqEAdly1E5DcDfC2ephKg9MwKks+jnPb2MctVq
         icNbcYy01Gnx4RMl7nTgRMvNjTSPtO4B1IsmqeYqYh1YfiP7PbkiYaFR8+b2KaeiVtyl
         /u8RvgKHDVUIQKB06Sy9RE5mk2cwbM6kClxdaxYHTnyYrgP2LqUSe7oYd42/FTneLHXr
         1mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YMh5iUkY6K6Bvq1I044G9/EvAVvls1a4agNOmvjKaWg=;
        b=JYsvsCLUsvCGUJCtLhugzDfD0d4KJVI3FG7+ObpA9f5iakKiMFmvYVaOt3rHm3q7b8
         eB3EIQt51HsYCiaseThHt19Ftb5BlM21O3sEEroViKaNmbQeP3K523zy2ipiYyKUSazG
         kL/xl2N+8mLS+o8jMt+/NUokIMQt1upUwyK5FqiI3XqOi9BvyScJj3B2cRHeazIvX051
         2VJ5AgGbsuilCwy0NB7a/lqJHPl0+UyGeCd65YjPjjlFFTdovVL4P34H0fVSk3I1XERV
         KiLKb+1kU80ySaYFAM3UxmqO+hN4qqItVY2HWXGVPRXCv5c62oYQrKi5LXG+GPm+hNV1
         0qlQ==
X-Gm-Message-State: APjAAAVJws80uZFAkC4e5U1mFPuSt9hsaPm7jSXrt+S5Qh81mxk91DLq
        8JcKReroWUFpnyotMHiVwwBw1pSs
X-Google-Smtp-Source: APXvYqxLsthkR6OJAGscA4liRghFwIre+TAKWmBTZVILgEnFp6BGIj1QgGphWWYgktqUdfQcCruoLw==
X-Received: by 2002:a05:6402:55a:: with SMTP id i26mr6803281edx.16.1576504766680;
        Mon, 16 Dec 2019 05:59:26 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4c47:b6f1:9ffc:1fb])
        by smtp.gmail.com with ESMTPSA id u21sm117451edv.43.2019.12.16.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 05:59:25 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     linux-raid@vger.kernel.org
Cc:     liu.song.a23@gmail.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: add more checks before add sh->lru to plug cb list
Date:   Mon, 16 Dec 2019 14:58:40 +0100
Message-Id: <20191216135840.10898-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

release_stripe_plug adds lru to unplug list, then raid5_unplug
iterates unplug list and release the stripe in the list. But
sh->lru could exist in another list as well since there is no
protection of the race since release_stripe_plug is lock free.

For example, the same sh could be handled by raid5_release_stripe
which is lock free too, it does two things in case "sh->count == 1".

1. add sh to released_stripes.
Or
2. go to slow path if sh is already set with ON_RELEASE_LIST.

Either 1 or 2 could trigger do_release_stripe finally, and this
function mainly move sh->lru to different lists such as delayed_list,
handle_list or temp_inactive_list etc.

Then the same node could be in different lists, which causes
raid5_unplug sticks with "while (!list_empty(&cb->list))", and
since spin_lock_irq(&conf->device_lock) is called before, it
causes:

1. hard lock up in [1], [2] and [3] since irq is disabled.
2. raid5_get_active_stripe can't get device_lock and calltrace
happens as follows.
[<ffffffff81598060>] _raw_spin_lock+0x20/0x30
[<ffffffffa0230b0a>] raid5_get_active_stripe+0x1da/0x5250 [raid456]
[<ffffffff8112d165>] ? mempool_alloc_slab+0x15/0x20
[<ffffffffa0231174>] raid5_get_active_stripe+0x844/0x5250 [raid456]
[<ffffffff812d5574>] ? generic_make_request+0x24/0x2b0
[<ffffffff810938b0>] ? wait_woken+0x90/0x90
[<ffffffff814a2adc>] md_make_request+0xfc/0x250
[<ffffffff812d5867>] submit_bio+0x67/0x150

So add two more checkings before add sh->lru to cb->list to avoid
potential list corruption.

1. the sh should not be handling by do_release_stripe.
2. ensure the sh is not release list.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d4d3b67ffbba..70ef2367fa64 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5481,7 +5481,9 @@ static void release_stripe_plug(struct mddev *mddev,
 			INIT_LIST_HEAD(cb->temp_inactive_list + i);
 	}
 
-	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
+	if (!atomic_read(&sh->count) == 0 &&
+	    !test_bit(STRIPE_ON_RELEASE_LIST, &sh->state) &&
+	    !test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
 		list_add_tail(&sh->lru, &cb->list);
 	else
 		raid5_release_stripe(sh);
-- 
2.17.1

