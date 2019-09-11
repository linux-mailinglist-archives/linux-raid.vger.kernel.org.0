Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C3AF76B
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfIKIGl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 04:06:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44093 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKIGl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Sep 2019 04:06:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id p2so18581238edx.11
        for <linux-raid@vger.kernel.org>; Wed, 11 Sep 2019 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nIgzNLO9fNEMkHlXQXUzUVJ8J+ov808vFJZQ8wAg+hI=;
        b=U5s5S+j0d24QfDalRlY6xQuAjbcWHdMiFF3rPsycx6ukCW3Z32KYGyX47DMK2hbz8l
         cLy4cEbr3VmCWmzCkoHZcoeHMirWCjFPaOqaVO/MeewO/N+MwOO3tUQO2FfNhIvLPVcM
         We+ENTTCcX9FLMZ4zBz2x7k/3gcEkOoKtbMJWnY8/BuSO9df1n3gu/9d8uB9K1w8W0ZF
         pLlu+J8Yer8uSaZvWWNXqLqukawlFPSeKQr61RDtigOMo46GNMDGu56GSii6FXJvpDrj
         +OJEc6zOFeyasYEXEbsyKs2673HgM67Oo/8/oYRjaaJxXFDdHiMsChz/zfyQ509DJUOG
         eEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nIgzNLO9fNEMkHlXQXUzUVJ8J+ov808vFJZQ8wAg+hI=;
        b=bcWZ2Isi6ls8Or5K0w3RFEIaHDrpjua478jCZZ6gAbszF0EzRrQIgdLCPaA1yRA8P2
         RX8/glXiMk8U6BIMcbVmME+nphX2ht5kwJjiFSvDP0laIZYk1yEPdPtvTlcD60i/mxPw
         wlmD2br1OSk+Vqf7EHfoo/2O5EoM/Rqa71wDsewbBF5L4u52JNsxVjB1DWawIWdbu3gl
         PoPOGGlW5NPqKKjlKfSR27Jr5/mcNNTJXsFE1T7NoctjJpqPJ3sHqQglyCsl3Dse/6KW
         5ELp91BQCuzcbFFS3/Ed59k4W0O5UcAA8mF6RDGifczJywW+7eRX1EHe8YuzooP2BpHe
         mlZQ==
X-Gm-Message-State: APjAAAXzHfCYdb+18AY8ZyY2v2crrE+o0a+a57ZgWnZBQixGaSGZkxbE
        cZLVHvOEEOvRqd2KVlb8jRw=
X-Google-Smtp-Source: APXvYqwuYwU0atYxKLbum9Zp6IzZSOMMEuIsW24vd8O7HNmshwfHe+lgpr3BDYTHEcT/6oJSoF25xQ==
X-Received: by 2002:a17:906:e0d9:: with SMTP id gl25mr28873451ejb.101.1568189199565;
        Wed, 11 Sep 2019 01:06:39 -0700 (PDT)
Received: from nb01257.pb.local ([2001:1438:4010:2540:70ef:99b1:3a5:1e44])
        by smtp.gmail.com with ESMTPSA id n16sm2357882ejy.8.2019.09.11.01.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 01:06:38 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: don't set STRIPE_HANDLE to stripe which is in batch list
Date:   Wed, 11 Sep 2019 10:06:29 +0200
Message-Id: <20190911080629.5180-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

If stripe in batch list is set with STRIPE_HANDLE flag, then the stripe
could be set with STRIPE_ACTIVE by the handle_stripe function. And if
error happens to the batch_head at the same time, break_stripe_batch_list
is called, then below warning could happen (the same report in [1]), it
means a member of batch list was set with STRIPE_ACTIVE.

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

Also commit 59fc630b8b5f9f ("RAID5: batch adjacent full stripe write")
said "If a stripe is added to batch list, then only the first stripe
of the list should be put to handle_list and run handle_stripe."

So don't set STRIPE_HANDLE to stripe which is already in batch list,
otherwise the stripe could be put to handle_list and run handle_stripe,
then the above warning could be triggered.

[1]. https://www.spinics.net/lists/raid/msg62552.html

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8ea8443e09d5..9fc6737e9713 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5727,7 +5727,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				do_flush = false;
 			}
 
-			set_bit(STRIPE_HANDLE, &sh->state);
+			if (!sh->batch_head)
+				set_bit(STRIPE_HANDLE, &sh->state);
 			clear_bit(STRIPE_DELAYED, &sh->state);
 			if ((!sh->batch_head || sh == sh->batch_head) &&
 			    (bi->bi_opf & REQ_SYNC) &&
-- 
2.17.1

