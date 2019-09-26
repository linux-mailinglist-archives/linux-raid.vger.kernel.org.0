Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A71BF22B
	for <lists+linux-raid@lfdr.de>; Thu, 26 Sep 2019 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfIZLyA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 Sep 2019 07:54:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37094 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIZLyA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 26 Sep 2019 07:54:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4so1710088edy.4
        for <linux-raid@vger.kernel.org>; Thu, 26 Sep 2019 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J2koq/vm/+2FV6K6lFBX6oOWMkFOcG++GQR/oEHQk3M=;
        b=FbkF+mQuOmkaOJnroSOVAUjlE4ZgriWM+Z++ZxQgu3jbrkBJLk7pqnt1HKYVWapI5G
         J8+l+GadKKwOpgJrjQ7Xlw0DgwQH7zbpxlfA1Bl+766Vxz2Q7UiyvTpPQtegOSHe+Tv6
         VP14SyqvzvsEouF1IGVYZyPblXT3npbYIE27tUS8rOHzrOm5DqF23WA93cnW5JOxi2Yt
         2oArqvsNPpdCGlB8Dqe59/W9zHHjadWKLBLAwAbuiOwOke5oQBLdLX4BtD+YZMmQyd+z
         RlLLddikyeb3D39wNpiXHQHmfanC8dC6HjxtrmCJQhRsiQq1vtskuJgqfqN1Cb9TUiKi
         Xbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J2koq/vm/+2FV6K6lFBX6oOWMkFOcG++GQR/oEHQk3M=;
        b=Q88qBkaM/JyV/9H3V5sISYy36pOhWv5xvJ2fFXnvlJImbiPsp6IpJYAkEUx/qloF1a
         tIFYST5wUmdRuEVq+vpsyNfxJEFzoPGkR1u2a4ZZ3i7nd2vNc5EQQN07G1JLSvLItE3v
         1csCQZg+Ju8s0eEtQExX+BIWcE/O/x0McWEQDOMW7ykXKVlA+w6Tdd5MG2FkNieE775X
         f72OfN0Rwin9YtswWEftt3uMhqvrTop5WXAl1iht6spNf+1ieStgmkeYSdhJ3ZDY7R/7
         PcfRFwZJRanBlg0n9U2ldrj2SvPODAl76l/G9+vLVP5EzVgQlfGe4gyDdX/cQ5TvHWKS
         nReQ==
X-Gm-Message-State: APjAAAVOhqcJClndGA87dq+oSx0V0cQ0LFF5m1+r+GV5G2rMbI5le5tA
        afa1mh60gxDTLtVpXxD0cmOnFcGu
X-Google-Smtp-Source: APXvYqybr6+YGi6o+5NH4pgkBB+Qlnq36Alt8SIrx3JkkT6NQvt9Pv02FJbaf9AgJ+8yyjwNpFNLbg==
X-Received: by 2002:a17:906:828c:: with SMTP id h12mr2667918ejx.155.1569498836408;
        Thu, 26 Sep 2019 04:53:56 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:2141:7472:3ae9:5a75])
        by smtp.gmail.com with ESMTPSA id ay13sm212441ejb.81.2019.09.26.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 04:53:55 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     linux-raid@vger.kernel.org
Cc:     songliubraving@fb.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        NeilBrown <neilb@suse.com>
Subject: [PATCH] md/bitmap: avoid race window between md_bitmap_resize and bitmap_file_clear_bit
Date:   Thu, 26 Sep 2019 13:53:50 +0200
Message-Id: <20190926115350.7111-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

We need to move "spin_lock_irq(&bitmap->counts.lock)" before unmap the previous
storage, otherwise panic like belows could happen as follows.

[  902.353802] sdl: detected capacity change from 1077936128 to 3221225472
[  902.616948] general protection fault: 0000 [#1] SMP
[snip]
[  902.618588] CPU: 12 PID: 33698 Comm: md0_raid1 Tainted: G           O    4.14.144-1-pserver #4.14.144-1.1~deb10
[  902.618870] Hardware name: Supermicro SBA-7142G-T4/BHQGE, BIOS 3.00       10/24/2012
[  902.619120] task: ffff9ae1860fc600 task.stack: ffffb52e4c704000
[  902.619301] RIP: 0010:bitmap_file_clear_bit+0x90/0xd0 [md_mod]
[  902.619464] RSP: 0018:ffffb52e4c707d28 EFLAGS: 00010087
[  902.619626] RAX: ffe8008b0d061000 RBX: ffff9ad078c87300 RCX: 0000000000000000
[  902.619792] RDX: ffff9ad986341868 RSI: 0000000000000803 RDI: ffff9ad078c87300
[  902.619986] RBP: ffff9ad0ed7a8000 R08: 0000000000000000 R09: 0000000000000000
[  902.620154] R10: ffffb52e4c707ec0 R11: ffff9ad987d1ed44 R12: ffff9ad0ed7a8360
[  902.620320] R13: 0000000000000003 R14: 0000000000060000 R15: 0000000000000800
[  902.620487] FS:  0000000000000000(0000) GS:ffff9ad987d00000(0000) knlGS:0000000000000000
[  902.620738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  902.620901] CR2: 000055ff12aecec0 CR3: 0000001005207000 CR4: 00000000000406e0
[  902.621068] Call Trace:
[  902.621256]  bitmap_daemon_work+0x2dd/0x360 [md_mod]
[  902.621429]  ? find_pers+0x70/0x70 [md_mod]
[  902.621597]  md_check_recovery+0x51/0x540 [md_mod]
[  902.621762]  raid1d+0x5c/0xeb0 [raid1]
[  902.621939]  ? try_to_del_timer_sync+0x4d/0x80
[  902.622102]  ? del_timer_sync+0x35/0x40
[  902.622265]  ? schedule_timeout+0x177/0x360
[  902.622453]  ? call_timer_fn+0x130/0x130
[  902.622623]  ? find_pers+0x70/0x70 [md_mod]
[  902.622794]  ? md_thread+0x94/0x150 [md_mod]
[  902.622959]  md_thread+0x94/0x150 [md_mod]
[  902.623121]  ? wait_woken+0x80/0x80
[  902.623280]  kthread+0x119/0x130
[  902.623437]  ? kthread_create_on_node+0x60/0x60
[  902.623600]  ret_from_fork+0x22/0x40
[  902.624225] RIP: bitmap_file_clear_bit+0x90/0xd0 [md_mod] RSP: ffffb52e4c707d28

Because mdadm was running on another cpu to do resize, so bitmap_resize was
called to replace bitmap as below shows.

PID: 38801  TASK: ffff9ad074a90e00  CPU: 0   COMMAND: "mdadm"
   [exception RIP: queued_spin_lock_slowpath+56]
   [snip]
--- <NMI exception stack> ---
 #5 [ffffb52e60f17c58] queued_spin_lock_slowpath at ffffffff9c0b27b8
 #6 [ffffb52e60f17c58] bitmap_resize at ffffffffc0399877 [md_mod]
 #7 [ffffb52e60f17d30] raid1_resize at ffffffffc0285bf9 [raid1]
 #8 [ffffb52e60f17d50] update_size at ffffffffc038a31a [md_mod]
 #9 [ffffb52e60f17d70] md_ioctl at ffffffffc0395ca4 [md_mod]

And the procedure to keep resize bitmap safe is allocate new storage space,
then quiesce, copy bits, replace bitmap, and re-start.

However the daemon (bitmap_daemon_work) could happen even the array is quiesced,
which means when bitmap_file_clear_bit is triggered by raid1d, then it thinks it
should be fine to access store->filemap since counts->lock is held, but resize
could change the storage without the protection of the lock.

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
This is labeled as RFC since I am not verify the patch well since the race
window is really short, so it is better to get enough eyeball before make
the change.

 drivers/md/md-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b3c887fbec7f..2d2a6f1e2fab 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2142,6 +2142,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		memcpy(page_address(store.sb_page),
 		       page_address(bitmap->storage.sb_page),
 		       sizeof(bitmap_super_t));
+	spin_lock_irq(&bitmap->counts.lock);
 	md_bitmap_file_unmap(&bitmap->storage);
 	bitmap->storage = store;
 
@@ -2157,7 +2158,6 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 	blocks = min(old_counts.chunks << old_counts.chunkshift,
 		     chunks << chunkshift);
 
-	spin_lock_irq(&bitmap->counts.lock);
 	/* For cluster raid, need to pre-allocate bitmap */
 	if (mddev_is_clustered(bitmap->mddev)) {
 		unsigned long page;
-- 
2.17.1

