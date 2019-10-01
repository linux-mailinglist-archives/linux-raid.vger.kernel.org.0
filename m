Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B52C4414
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfJAXCQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 19:02:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39672 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfJAXCP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 19:02:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so12997159qki.6
        for <linux-raid@vger.kernel.org>; Tue, 01 Oct 2019 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aZGAlu2aY7VKl0Eg2Hm4PRs7TtK3NkkAwv58VCthck=;
        b=ODhReki7oZmnFZ6uWTuA3l7702MxbAKEHG7oeH+9Uo1BS9IJrZhyI3E8rC6r67bPTo
         RcUJedcFOWrc9otTSeFaBVhnFa6dxb8vlWT5ztJzw4/cEOD8kW3y1eg2IGi7P0v5NRkn
         7DCzVtWFtboWR82nO7dI6ODl5fDFjdQyUBYQz1XUddsqWgxUcIRdscSmJRIMeFxK5amo
         xZ1xCkIt6j27LyvD/r3PFGKO+A8MdjY0zGDQW+3ZGQgdPra7zR0TLKIbrdOP+a9WXM22
         1vYqG3VxuNUKhhfsn6ORKE6B6hv8oJBhm1F7sgQ46Kf2EQjApWy+tv+nnlRnkagrn8gZ
         eVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aZGAlu2aY7VKl0Eg2Hm4PRs7TtK3NkkAwv58VCthck=;
        b=o9jSN6m4W//0jpHMsdwGDyfQ+8TtwZpx6kvJSJQ9CiqjLDzdMYcV3+omYXOK6x566c
         X+FVdXnxSt3ts8hucYNDE6RxYevgAuh2cXCkD1jWZJLojmaS+PURUFu0R2+jZM20S4WV
         B15E2X94H5zfulu5ox2YPJ237eHOdIjEvL4KS/gwzwltOkwki6psEzFFLwch4DUdGDx3
         KOqWF+oPU7DazR49IvhuTDfuLJUpuGdy3mPXVaMwb16x/lqUYCIP4KxDvtvZAoAv4JJg
         LghrMFOpcoo7jNGyWkBOL9yLFwE35bG4hUuJzO1NzhvNkLcge6Ey6BbasurHzPfoe+No
         TEXw==
X-Gm-Message-State: APjAAAViEMWB7nH+wQ+bRVcp7TcdM+Cms2SY1C4uaZl0SsTFbrN1nQcN
        SJXx1VabZ65uw2QJev9Su6+ucXZPKfjRs3hpGzQ=
X-Google-Smtp-Source: APXvYqwOr3GVWMFcHSJFabjBgbZA092l9kSYsyHRlzoXGjKHN2mEqQPlmkEBRiOjB/62U8guwt8GEBrQR6h0GcvSd/A=
X-Received: by 2002:a05:620a:49b:: with SMTP id 27mr627712qkr.89.1569970934895;
 Tue, 01 Oct 2019 16:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115350.7111-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190926115350.7111-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 1 Oct 2019 16:02:04 -0700
Message-ID: <CAPhsuW5-NFRh4_NNgG1FfFazBuSNyfK+vrxxjB47jfk6gpzJLA@mail.gmail.com>
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

nit: this ---  above will trim the rest of the commit log. So I
updated it before applying.

Also, checkpatch.pl complains

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)

for multiple lines. I fixed them before applying.

In the future, please check the patch before sending.

Thanks,
Song
