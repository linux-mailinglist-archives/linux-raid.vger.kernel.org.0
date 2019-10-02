Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1EC48A5
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJBHgW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 2 Oct 2019 03:36:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51334 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfJBHgW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 2 Oct 2019 03:36:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so5977341wme.1
        for <linux-raid@vger.kernel.org>; Wed, 02 Oct 2019 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xfY5lC/UCxJ7kvtwREQQfZL7CCT9DEYJEZxz1NjiLE=;
        b=NbbP/CeJX1IJ7m5YgSeg0++/iG7oE+Eltfdv83yWp87OvY0ghV6qMDus0v8iT7eg8b
         4BUCUBYxn6aRhjWku4QtSIqLzW6F5QIbaiGqw5p7nNdFd9mfO69Lljn+YUtHtQ2TZnjT
         zQ1bebi6SGLqiQCgW/GUFNRbooYRTP2hd6y/hF4UJmSvnfT8O+SQDgK018zkbppuPBY1
         QRRSlxQEwGQRfhRGOUFLF1ebfm5oEjaSkOovqBV+AN39XFFOuqQ0THqWuhxxnMuP5bnM
         eDR8LNQZvlLWhrU1mQNv4kEkKs9EtHwKC0n19SkiEF4EWNdTT6SDB/eZUyPZKU8J7DvA
         2Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xfY5lC/UCxJ7kvtwREQQfZL7CCT9DEYJEZxz1NjiLE=;
        b=ftcFJHOoyIaOnUgZEZiOYeIP2R8Seu2Mx3k4D7cgKbkeaYi28g6bK20h9aLCW9L0G7
         YmWrMP+UecV3pVPT+XMTfQZcFkg/VdYFx9QJuSTPpw6vUVJz6/b0qcwC/ZrsL5shmQ/R
         et84aQjrysJfdN7nFeFd2Tq/QQnUZWZdsiPeRp95guLVs9eV6ssZoqcU0BTCnQZ/MpoN
         bEg12rdpTcTHWtr51diqBc/TP/yUogCPsra7aG73BB0oj5sBkD2CUeDRfancIrJh/PTN
         j2f3zVClUYAZ+Ac/Bfjg9txDplGfyvyfoD14usF6i90/nuGzQYZQuFgybIwffD2DxdiI
         DugA==
X-Gm-Message-State: APjAAAWoN4yTFUgRng2KcH+2hJ3hQlnHh4SXiDQcDJypl/qQGtHWE7tO
        +JJEUMyGPUAO92EVIvaDBrgV8hek20P9aS/u33cn6A==
X-Google-Smtp-Source: APXvYqwP7AfSZVoR04u7HrGtyx68Zu1VLriPlUcoD9ontXqJZyQ5kFniCI125ZWHy3yI6dPDAQV6DYaO0C3WZUo+HmA=
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr1543712wmm.37.1570001779982;
 Wed, 02 Oct 2019 00:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115350.7111-1-guoqing.jiang@cloud.ionos.com> <CAPhsuW5-NFRh4_NNgG1FfFazBuSNyfK+vrxxjB47jfk6gpzJLA@mail.gmail.com>
In-Reply-To: <CAPhsuW5-NFRh4_NNgG1FfFazBuSNyfK+vrxxjB47jfk6gpzJLA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 2 Oct 2019 09:36:09 +0200
Message-ID: <CAMGffE=H+xhH4orh0pES9Z3cJH3uosRBWHMNidc4sM1v+Q15dg@mail.gmail.com>
Subject: Re: [PATCH] md/bitmap: avoid race window between md_bitmap_resize and bitmap_file_clear_bit
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 2, 2019 at 1:02 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, Sep 26, 2019 at 4:55 AM <jgq516@gmail.com> wrote:
> >
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> > We need to move "spin_lock_irq(&bitmap->counts.lock)" before unmap the previous
> > storage, otherwise panic like belows could happen as follows.
> >
> > [  902.353802] sdl: detected capacity change from 1077936128 to 3221225472
> > [  902.616948] general protection fault: 0000 [#1] SMP
> > [snip]
> > [  902.618588] CPU: 12 PID: 33698 Comm: md0_raid1 Tainted: G           O    4.14.144-1-pserver #4.14.144-1.1~deb10
> > [  902.618870] Hardware name: Supermicro SBA-7142G-T4/BHQGE, BIOS 3.00       10/24/2012
> > [  902.619120] task: ffff9ae1860fc600 task.stack: ffffb52e4c704000
> > [  902.619301] RIP: 0010:bitmap_file_clear_bit+0x90/0xd0 [md_mod]
> > [  902.619464] RSP: 0018:ffffb52e4c707d28 EFLAGS: 00010087
> > [  902.619626] RAX: ffe8008b0d061000 RBX: ffff9ad078c87300 RCX: 0000000000000000
> > [  902.619792] RDX: ffff9ad986341868 RSI: 0000000000000803 RDI: ffff9ad078c87300
> > [  902.619986] RBP: ffff9ad0ed7a8000 R08: 0000000000000000 R09: 0000000000000000
> > [  902.620154] R10: ffffb52e4c707ec0 R11: ffff9ad987d1ed44 R12: ffff9ad0ed7a8360
> > [  902.620320] R13: 0000000000000003 R14: 0000000000060000 R15: 0000000000000800
> > [  902.620487] FS:  0000000000000000(0000) GS:ffff9ad987d00000(0000) knlGS:0000000000000000
> > [  902.620738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  902.620901] CR2: 000055ff12aecec0 CR3: 0000001005207000 CR4: 00000000000406e0
> > [  902.621068] Call Trace:
> > [  902.621256]  bitmap_daemon_work+0x2dd/0x360 [md_mod]
> > [  902.621429]  ? find_pers+0x70/0x70 [md_mod]
> > [  902.621597]  md_check_recovery+0x51/0x540 [md_mod]
> > [  902.621762]  raid1d+0x5c/0xeb0 [raid1]
> > [  902.621939]  ? try_to_del_timer_sync+0x4d/0x80
> > [  902.622102]  ? del_timer_sync+0x35/0x40
> > [  902.622265]  ? schedule_timeout+0x177/0x360
> > [  902.622453]  ? call_timer_fn+0x130/0x130
> > [  902.622623]  ? find_pers+0x70/0x70 [md_mod]
> > [  902.622794]  ? md_thread+0x94/0x150 [md_mod]
> > [  902.622959]  md_thread+0x94/0x150 [md_mod]
> > [  902.623121]  ? wait_woken+0x80/0x80
> > [  902.623280]  kthread+0x119/0x130
> > [  902.623437]  ? kthread_create_on_node+0x60/0x60
> > [  902.623600]  ret_from_fork+0x22/0x40
> > [  902.624225] RIP: bitmap_file_clear_bit+0x90/0xd0 [md_mod] RSP: ffffb52e4c707d28
> >
> > Because mdadm was running on another cpu to do resize, so bitmap_resize was
> > called to replace bitmap as below shows.
> >
> > PID: 38801  TASK: ffff9ad074a90e00  CPU: 0   COMMAND: "mdadm"
> >    [exception RIP: queued_spin_lock_slowpath+56]
> >    [snip]
> > --- <NMI exception stack> ---
>
> nit: this ---  above will trim the rest of the commit log. So I
> updated it before applying.
>
> Also, checkpatch.pl complains
>
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
>
> for multiple lines. I fixed them before applying.
>
> In the future, please check the patch before sending.
>
> Thanks,
> Song
I noticed this when applying to our tree, we will be more careful.
Guoqing is on vacation, so I'm replying.

Thanks,
Jinpu
