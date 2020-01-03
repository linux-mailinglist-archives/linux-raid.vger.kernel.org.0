Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1612F8FB
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgACN4s (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 08:56:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACN4s (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 08:56:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so42497112wro.2
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9hvBB6Gtq/IYyH6Hieh+oRrm10PhTEuHXpJq9Et1044=;
        b=daTl/FXLNM5inYYSkNVOX6M3OU/+mapUe9ko1PJ550QyPvgYwk113dus8jkOzgxULC
         d9vYcVLYVDG4h1048U0+Np4ZdX290VZpCmfoqImLzavbyNCdhY4UG/XqvdjpZKMuJ5+s
         LxBwVzmBZylZYdOmiw7GvI0CrHiJCqLMpagU+rmmgr5zsf3Hmk1TVRaMGMUXFezAxpKA
         ngF9YAmlD1YeYCBCl5vVia3wr1Z8S2SqaMUPL9HFHof1WidnYD+5uBZtpEq7l0w2nH+M
         +tp9oxZwUnGSqPRL8iYyVv0vxMsGWT5XM6IqrIFtGs+GqUWrOX+x22sRoq/LufDVmKMd
         50qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9hvBB6Gtq/IYyH6Hieh+oRrm10PhTEuHXpJq9Et1044=;
        b=cTuopwe2WCc3+z/wjZP0HEliK3xU0DW85GeVSEheUhOQoxnO4K8NL8MA1ZS2dvX2pX
         HdA/8E2MU32o5V4VKAf1GR4HU9QLVefqds02tuunGzhK0MAX35r5foJtJc4n1xCkN4bh
         CPEJSub4i7/x3VEUFC0AmplsRnOnjX1hd8uxdgE3OUpdHD/zRLDQVObELm8yZOpY5PV/
         gLiP/m3AvW6vuNX6aULmaAln5ZyniGX5dVkgPNWlwCAWnBpYkDp+52jJhjOphwx4++2Z
         66sqhSF4/8u98twKF4SM3fM6AZpb8G4y7rhIrAqZX0rqpT4BEByPrV1aCH2tvY7FvaRM
         7anA==
X-Gm-Message-State: APjAAAUraDCMHAK6Dq6CGP/ckDtx+dorPAAgeK2/tCpz9IchqXeUKtFK
        K2JoySG2SuAl3nzZduGSeTM=
X-Google-Smtp-Source: APXvYqyvRJ3TLLOYkVciOCSQawYQf1aW8SSpvsS4hSgrLO8xL5/HCZkR2l8ryaiyxfMqWXCj4Qb3Cw==
X-Received: by 2002:adf:a285:: with SMTP id s5mr1726633wra.118.1578059807113;
        Fri, 03 Jan 2020 05:56:47 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:51b:bcb9:ca0e:d784])
        by smtp.gmail.com with ESMTPSA id m3sm59710991wrs.53.2020.01.03.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 05:56:46 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RESEND] raid5: add more checks before add sh->lru to plug cb list
Date:   Fri,  3 Jan 2020 14:56:28 +0100
Message-Id: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
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
happens.

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

[1]. https://marc.info/?l=linux-raid&m=150348807422853&w=2
[2]. https://marc.info/?l=linux-raid&m=146883211430999&w=2
[3]. https://marc.info/?l=linux-raid&m=157434565331673&w=2

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

