Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA47D9FBC1
	for <lists+linux-raid@lfdr.de>; Wed, 28 Aug 2019 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfH1HaP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 28 Aug 2019 03:30:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36051 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfH1HaP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 28 Aug 2019 03:30:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so1868351edu.3
        for <linux-raid@vger.kernel.org>; Wed, 28 Aug 2019 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uW1Eqy55odGxidRpoU4aOaneIkj3hUr55sAFiBDr43Q=;
        b=BNgdkKAgqrPe9uz5/6k/2uelmfgyNHcdGGid+/RsVQ7GwiKRRczTvRUhd/OYvS7xM+
         j8CwEeGNP/JukB/dWnqrbiGKK7ifKgOI7xNdsW8Wfxtw4Of/fU01nx4gMmZDk0Z+fpy1
         eAET4jj3eSXJCF63Uqlmurq8en6dDL66WVupYLkR0hvW9yS+IMtROMbaxLFwKZ5Dshva
         oTwnI3jLWYAkX52vWtEH1ELMY8Bb9IpJc8ECp1blVHwgc0zZQsKCy/8qbMhDRjeQexH9
         0qSRwnv/g1cQZZFIC0VzNE/dyC1O62mCHpKFlr79lZihSRS6KRefhyttdK3bhv1YseqC
         yQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uW1Eqy55odGxidRpoU4aOaneIkj3hUr55sAFiBDr43Q=;
        b=InwqDZUFGSICb00ToCClXstqxVLJN95mWDJel+DXpGiBd1cKsWXqAa0fJ3+WoyMhWd
         OCNgxBJTM2UDjjegEXTAsqWQotzqi46RvxAen1Ch7L0KODIc7RGe/lPFmcdGceCG0SQv
         bRgXVz/e70pDWO1rgeqENDuyjYEk9xz5CLDaQoZ0mq2EZFQG4Xj9q6empbc45dQfLvAS
         7P5RL83LRqNpZ4Cpts+ahOOAZgMGKLYkV/E8mEGTxdeyKsQmznwKjyZ0N0pDQS9bGNbt
         918pcKosw8rcpGAVwekHLuEjauy8sih8ezLBllzogmwte4P9sXPBKzanxHIqt3eGLCWY
         rMpQ==
X-Gm-Message-State: APjAAAWgi1VjBEq+lktOJleUhM3AUB9qYlkoUUcZLJ2ItbtIUEdwAyZR
        KhTAyOdu4XvNEX1kU9uIdMo=
X-Google-Smtp-Source: APXvYqwFI6PJiWyVr7fsmgk3BwM3Kh+9IlE4uLZzdLY2JN4758Tgao9emni0mX8AvKLVnFyDviDfYA==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr1788938ejr.310.1566977414064;
        Wed, 28 Aug 2019 00:30:14 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4572:6688:9441:afde])
        by smtp.gmail.com with ESMTPSA id y25sm286770edt.29.2019.08.28.00.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:30:13 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in break_stripe_batch_list
Date:   Wed, 28 Aug 2019 09:29:56 +0200
Message-Id: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The break_stripe_batch_list function is called by handle_stripe and
handle_stripe_clean_event (it is also called by handle_stripe), so
the original caller of break_stripe_batch_list is handle_stripe.

Since handle_stripe set STRIPE_ACTIVE flag at the beginning, and it is
cleared at the end of handle_stripe, which means break_stripe_batch_list
always triggers the below warning if it is called.

[7028915.431770] stripe state: 2001
[7028915.431815] ------------[ cut here ]------------
[7028915.431828] WARNING: CPU: 18 PID: 29089 at drivers/md/raid5.c:4614 break_stripe_batch_list+0x203/0x240 [raid456]
[...]
[7028915.431879] CPU: 18 PID: 29089 Comm: kworker/u82:5 Tainted: G           O    4.14.86-1-storage #4.14.86-1.2~deb9
[7028915.431881] Hardware name: Supermicro SSG-2028R-ACR24L/X10DRH-iT, BIOS 3.1 06/18/2018
[7028915.431888] Workqueue: raid5wq raid5_do_work [raid456]
[7028915.431890] task: ffff9ab0ef36d7c0 task.stack: ffffb72926f84000
[7028915.431896] RIP: 0010:break_stripe_batch_list+0x203/0x240 [raid456]
[7028915.431898] RSP: 0018:ffffb72926f87ba8 EFLAGS: 00010286
[7028915.431900] RAX: 0000000000000012 RBX: ffff9aaa84a98000 RCX: 0000000000000000
[7028915.431901] RDX: 0000000000000000 RSI: ffff9ab2bfa15458 RDI: ffff9ab2bfa15458
[7028915.431902] RBP: ffff9aaa8fb4e900 R08: 0000000000000001 R09: 0000000000002eb4
[7028915.431903] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff9ab1736f1b00
[7028915.431904] R13: 0000000000000000 R14: ffff9aaa8fb4e900 R15: 0000000000000001
[7028915.431906] FS:  0000000000000000(0000) GS:ffff9ab2bfa00000(0000) knlGS:0000000000000000
[7028915.431907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[7028915.431908] CR2: 00007ff953b9f5d8 CR3: 0000000bf4009002 CR4: 00000000003606e0
[7028915.431909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[7028915.431910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[7028915.431910] Call Trace:
[7028915.431923]  handle_stripe+0x8e7/0x2020 [raid456]
[7028915.431930]  ? __wake_up_common_lock+0x89/0xc0
[7028915.431935]  handle_active_stripes.isra.58+0x35f/0x560 [raid456]
[7028915.431939]  raid5_do_work+0xc6/0x1f0 [raid456]

But break_stripe_batch_list is called under conditions: too many failed
devices, write error happened or failure of pdisk/qdisk etc, which means
the warning is happened rarely. Though I still found the same issue was
reported in list [1].

So let's remove the checking of STRIPE_ACTIVE inside WARN_ONCE.

[1]. https://www.spinics.net/lists/raid/msg62552.html

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 88e56ee98976..e3dced8ad1b5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4612,8 +4612,7 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 
 		list_del_init(&sh->batch_list);
 
-		WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
-					  (1 << STRIPE_SYNCING) |
+		WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
 					  (1 << STRIPE_REPLACED) |
 					  (1 << STRIPE_DELAYED) |
 					  (1 << STRIPE_BIT_DELAY) |
-- 
2.17.1

