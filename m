Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF9C43E4
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfJAWo1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 18:44:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40659 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJAWo1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 18:44:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so12941825qkb.7
        for <linux-raid@vger.kernel.org>; Tue, 01 Oct 2019 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ygc3TIRij4f/MqWnfl8Yn7wp4XjhM1ZwFDT8uxM7XM8=;
        b=UvlNI5g8eo/69rc+hcRTeNQbenSJmCVhWmbUYxSkUXgxE/qinG8uxdSogQ1OO1qg9T
         MVEBJHLBaQagRRm/4EsMCJuJmfscHWkkM+pHmaJxE6iNxqkLlgEedRyRayd1V1qg/33L
         BvOk1jkHaTJkMC8wBdVjSpcx2sl/IgjfyG7xw/zAD/6k0e/sjzYvFe0d0Ows5/4tcKFC
         7ITY/8HiK6lShbvKoesYUtaXG3jYG9TcsUxoeteadVLGui6NwTF2OWwy0bu8DP545udy
         puUvBo1yL8FF+fu7UjHXTGr6mkMh3tzRsNPIE/jyetbpmO1JdM0CY3+5jifgsg/2q5ab
         3kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ygc3TIRij4f/MqWnfl8Yn7wp4XjhM1ZwFDT8uxM7XM8=;
        b=VKnd9eQG5yHsYssUuLkxxRKLR7bEbLupeN3a+V/bqzHNVFHVTNRGnixV23uj7nWhDD
         +ce87teesdLQlM3G+OiIpELa33xvl+KhLxCw/KdiA2eVjSiS04Jc85GB0LcgT9q9e4pP
         O5ZTbUt/ocRtfhbkzuokcHRfddttwqnk3C8rt5gzLImyja/Vc+Yp5m+CMcu9LvRXFIxj
         W04PZsBC9bwPP08j+SlSg17QANzTi58vHPR0QVbj+LE2UZyKBYSm5PA7rS8/Zp9WmRVQ
         G7FlTmw+U4fladciJOqZ17+glK+hmZ+IPx7dD40J9aajTXjQbUX0aDMZ6qY6I7n7XWct
         vkuA==
X-Gm-Message-State: APjAAAXk9/CNIegFj+7nDGqbVScYroZQ8sLw7D+pvx7H2kirUYrOcKqK
        cfsPwpgvu+/vb1Z0/HXz8+l1DC809wvLZpWggVBl9A==
X-Google-Smtp-Source: APXvYqwacnKPednpTxF0ETtBOHylmcf+B9p742iba7mkYV5v2a6AyVGImtPJQ6CNCysWLM+sW6F8aqLfS76INq2b82g=
X-Received: by 2002:a37:5f47:: with SMTP id t68mr584803qkb.497.1569969864473;
 Tue, 01 Oct 2019 15:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115350.7111-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190926115350.7111-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 1 Oct 2019 15:44:13 -0700
Message-ID: <CAPhsuW5dk944r_fQdoZodOoLoJNqyfwESMsWUvPhOMY+KQ+Uew@mail.gmail.com>
Subject: Re: [PATCH] md/bitmap: avoid race window between md_bitmap_resize and bitmap_file_clear_bit
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Sep 26, 2019 at 4:55 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> We need to move "spin_lock_irq(&bitmap->counts.lock)" before unmap the previous
> storage, otherwise panic like belows could happen as follows.
>
> [  902.353802] sdl: detected capacity change from 1077936128 to 3221225472
> [  902.616948] general protection fault: 0000 [#1] SMP
> [snip]
> [  902.618588] CPU: 12 PID: 33698 Comm: md0_raid1 Tainted: G           O    4.14.144-1-pserver #4.14.144-1.1~deb10
> [  902.618870] Hardware name: Supermicro SBA-7142G-T4/BHQGE, BIOS 3.00       10/24/2012
> [  902.619120] task: ffff9ae1860fc600 task.stack: ffffb52e4c704000
> [  902.619301] RIP: 0010:bitmap_file_clear_bit+0x90/0xd0 [md_mod]
> [  902.619464] RSP: 0018:ffffb52e4c707d28 EFLAGS: 00010087
> [  902.619626] RAX: ffe8008b0d061000 RBX: ffff9ad078c87300 RCX: 0000000000000000
> [  902.619792] RDX: ffff9ad986341868 RSI: 0000000000000803 RDI: ffff9ad078c87300
> [  902.619986] RBP: ffff9ad0ed7a8000 R08: 0000000000000000 R09: 0000000000000000
> [  902.620154] R10: ffffb52e4c707ec0 R11: ffff9ad987d1ed44 R12: ffff9ad0ed7a8360
> [  902.620320] R13: 0000000000000003 R14: 0000000000060000 R15: 0000000000000800
> [  902.620487] FS:  0000000000000000(0000) GS:ffff9ad987d00000(0000) knlGS:0000000000000000
> [  902.620738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  902.620901] CR2: 000055ff12aecec0 CR3: 0000001005207000 CR4: 00000000000406e0
> [  902.621068] Call Trace:
> [  902.621256]  bitmap_daemon_work+0x2dd/0x360 [md_mod]
> [  902.621429]  ? find_pers+0x70/0x70 [md_mod]
> [  902.621597]  md_check_recovery+0x51/0x540 [md_mod]
> [  902.621762]  raid1d+0x5c/0xeb0 [raid1]
> [  902.621939]  ? try_to_del_timer_sync+0x4d/0x80
> [  902.622102]  ? del_timer_sync+0x35/0x40
> [  902.622265]  ? schedule_timeout+0x177/0x360
> [  902.622453]  ? call_timer_fn+0x130/0x130
> [  902.622623]  ? find_pers+0x70/0x70 [md_mod]
> [  902.622794]  ? md_thread+0x94/0x150 [md_mod]
> [  902.622959]  md_thread+0x94/0x150 [md_mod]
> [  902.623121]  ? wait_woken+0x80/0x80
> [  902.623280]  kthread+0x119/0x130
> [  902.623437]  ? kthread_create_on_node+0x60/0x60
> [  902.623600]  ret_from_fork+0x22/0x40
> [  902.624225] RIP: bitmap_file_clear_bit+0x90/0xd0 [md_mod] RSP: ffffb52e4c707d28
>
> Because mdadm was running on another cpu to do resize, so bitmap_resize was
> called to replace bitmap as below shows.
>
> PID: 38801  TASK: ffff9ad074a90e00  CPU: 0   COMMAND: "mdadm"
>    [exception RIP: queued_spin_lock_slowpath+56]
>    [snip]
> --- <NMI exception stack> ---
>  #5 [ffffb52e60f17c58] queued_spin_lock_slowpath at ffffffff9c0b27b8
>  #6 [ffffb52e60f17c58] bitmap_resize at ffffffffc0399877 [md_mod]
>  #7 [ffffb52e60f17d30] raid1_resize at ffffffffc0285bf9 [raid1]
>  #8 [ffffb52e60f17d50] update_size at ffffffffc038a31a [md_mod]
>  #9 [ffffb52e60f17d70] md_ioctl at ffffffffc0395ca4 [md_mod]
>
> And the procedure to keep resize bitmap safe is allocate new storage space,
> then quiesce, copy bits, replace bitmap, and re-start.
>
> However the daemon (bitmap_daemon_work) could happen even the array is quiesced,
> which means when bitmap_file_clear_bit is triggered by raid1d, then it thinks it
> should be fine to access store->filemap since counts->lock is held, but resize
> could change the storage without the protection of the lock.
>
> Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

This looks good to me.

I will apply it to md-next.

Thanks,
Song
