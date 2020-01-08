Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1621347FB
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jan 2020 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgAHQae (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jan 2020 11:30:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42793 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHQad (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jan 2020 11:30:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so4028163wro.9
        for <linux-raid@vger.kernel.org>; Wed, 08 Jan 2020 08:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ydzPSrfQzXZzZPJBrQur50wGjnonCj4KjrMAAE7b2JI=;
        b=Wdfazn0DwtUTkfrHEAGWVOJT2gfS5g/tAPwU7MJ8WALfhB3KC7OGtgp02l9vxP8lsA
         5YOuuoEy+BBkj0SIKQQG1kD0VUicXy/T45xlHB915ZhaEfcy2f7LG5PLpAftQSTcxOcI
         K5tTf5R3FznaWMo1zBWrj6YVJoehEryKkIyCM2hLUKx2MOWW5jrS6FA6CZHtjj1tCx8m
         +yoADIOPZCVd+D6nESrF2G57JCekRYiD168v1VAH/fs3QSd9BVBUhnpqn4+JC9Esprv9
         /ppNqb0vdXFuW0kywaH0hMnMhfYINso8mW2t9wFYQFhR8tZ4hoozlQFL6+OfMyQ05XY/
         Rykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ydzPSrfQzXZzZPJBrQur50wGjnonCj4KjrMAAE7b2JI=;
        b=qxLr1jdtcthRstd7ww+ImLhZ2KhgQv6dm0tdd5P+ldUhd/MEZr4SsQypPI89JIQK26
         QF+CqrSKjjKOW/va19sfljdDH+5m30LFG8CMjKOjIxbIO/VY3n46oCzpMg4Zw7QPRAin
         XhLVlgPyO72XoVVl2TaroO7OeJjLuAuBzqRbIHM/BqQYU08ldlft4qAsPgeuon1WwXtX
         k0aaJR+mfh3KjrQlLtxbh8SGyquTlKOoq9/dxTq0Xv+KjWWzIBfQ2k7tK6PESnV+9sAr
         S7wuWBNGRfrcGIaKOR3i/mWn/UUy8rM7ViIc4POTwQpJBCT+Bd90Rs4P+Igg4wQg9xS3
         gi8g==
X-Gm-Message-State: APjAAAW/EAz+IgscMm1J4UtAKq81891+VHwhNhy5VDHIxsgdLeLYQY8R
        /o0/hXkXVOru4L6rnwgrY+U=
X-Google-Smtp-Source: APXvYqzWpo9QQiTzaySyfzk4tBgyxZ3Ry3jQYqZQuVSbYxmapQWpNc3jhbkRIqKNPbwX8s06tPv6xQ==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr5773051wrq.72.1578501031322;
        Wed, 08 Jan 2020 08:30:31 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:3132:ace5:784f:a2c3])
        by smtp.gmail.com with ESMTPSA id z21sm4160253wml.5.2020.01.08.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:30:30 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: avoid add sh->lru to different list
Date:   Wed,  8 Jan 2020 17:30:23 +0100
Message-Id: <20200108163023.9301-1-guoqing.jiang@cloud.ionos.com>
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

So, this commit tries to avoid the issue by makes below change:

1. firstly we can't add sh->lru to cb->list if sh->count == 0.

2. check STRIPE_ON_UNPLUG_LIST too in do_release_stripe to avoid
list corruption, and the lock version of test_and_set_bit/clear_bit
are used (though it should not effective on x86).

[1]. https://marc.info/?l=linux-raid&m=150348807422853&w=2
[2]. https://marc.info/?l=linux-raid&m=146883211430999&w=2
[3]. https://marc.info/?l=linux-raid&m=157434565331673&w=2

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
As you can see, this version is different from previous one.

The previous verison is made because I thought that ON_UNPLUG_LIST
and ON_RELEASE_LIST are kind of exclusive, the sh should be
only set with  either of the flag but not both, but perhaps
it is not true ...

Instead, since the goal is to avoid put the same sh->lru in
different list, or we can fix it from other side. Before
do_release_stripe move sh->lru to another list (not cb->list),
check if the sh is on unplug list yet, if it is true then wake
up mddev->thread to trigger the plug path:

  raid5d -> blk_finish_plug -> raid5_unplug ->
  __release_stripe -> do_release_stripe

Then raid5_unplug remove sh from cb->list one by one, clear
ON_UNPLUG_LIST flag and release stripe. So we ensure sh on
unplug list is actually handled by plug mechanism instead
of other paths.

Comments and tests are welcomed.

The new changes are tested with "./test --raidtype=raid456",
seems good.

Thanks,
Guoqing

 drivers/md/raid5.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 223e97ab27e6..808b0bd18c8c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -218,6 +218,25 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 	BUG_ON(!list_empty(&sh->lru));
 	BUG_ON(atomic_read(&conf->active_stripes)==0);
 
+	/*
+	 * If stripe is on unplug list then original caller of __release_stripe
+	 * is not raid5_unplug, so sh->lru is still in cb->list, don't risk to
+	 * add lru to another list in do_release_stripe.
+	 */
+	if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state))
+		clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
+	else {
+		/*
+		 * The sh is on unplug list, so increase count (because count
+		 * is decrease before enter do_release_stripe), then trigger
+		 * raid5d -> plug -> raid5_unplug -> __release_stripe to handle
+		 * this stripe.
+		 */
+		atomic_inc(&sh->count);
+		md_wakeup_thread(conf->mddev->thread);
+		return;
+	}
+
 	if (r5c_is_writeback(conf->log))
 		for (i = sh->disks; i--; )
 			if (test_bit(R5_InJournal, &sh->dev[i].flags))
@@ -5441,7 +5460,7 @@ static void raid5_unplug(struct blk_plug_cb *blk_cb, bool from_schedule)
 			 * is still in our list
 			 */
 			smp_mb__before_atomic();
-			clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
+			clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
 			/*
 			 * STRIPE_ON_RELEASE_LIST could be set here. In that
 			 * case, the count is always > 1 here
@@ -5481,7 +5500,8 @@ static void release_stripe_plug(struct mddev *mddev,
 			INIT_LIST_HEAD(cb->temp_inactive_list + i);
 	}
 
-	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
+	if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state) &&
+	    (atomic_read(&sh->count) != 0))
 		list_add_tail(&sh->lru, &cb->list);
 	else
 		raid5_release_stripe(sh);
-- 
2.17.1

