Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15E119A4
	for <lists+linux-raid@lfdr.de>; Thu,  2 May 2019 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBNBc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 May 2019 09:01:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35506 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBNBc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 May 2019 09:01:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id e5so2315025qtq.2
        for <linux-raid@vger.kernel.org>; Thu, 02 May 2019 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjSNwc3DJ0Ki3ZxmNccjIkvn3kxoImDtmrH9VIPFQls=;
        b=sUavbyEpK9eINms7GIrfmHBKhlbtWLSu3rfvKEzAFr8zxKxe0SrSuF3HpoAzM5T+GF
         7guyXA8JW+eokEI7QNI5CD76IZzkvQgGr3mLt3cgFtwbouj2iKmYKYs5+oBFhlBQ/JNx
         kLRLRpQyqBZ//3hrBdRZpQLWg9KGvpfhRrwWaGY56xEJmBJWnVJ3vR1AA0ks7QlYI4FN
         XlopJFWu5CxoRqoyKxUN8ODX4pG/L2cYRW20H7GSNPGItFwVqHCeDrxTuy8QbUX24Ac0
         KdLWikVA+zjBNoRj8CT0cqPvUj7L632/MC7BWh6KIUs6onLxyKewKS+y4eJdoXhlK/Gr
         rmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjSNwc3DJ0Ki3ZxmNccjIkvn3kxoImDtmrH9VIPFQls=;
        b=PcSf/AhcFhEP8eP4NMvxOPaJ71dH91VQYhIGT5cfJsabAX4orpug7jQe7JDKInTyGq
         TqXsHloaHjrqajfJ8kWJLP/03831vfD7WolFSnrWojmqbseC5Hw7m0mmZNtSUMRoUMiY
         IMxaqkVETkMv6UvLRkF3l7h5KFLf3QBAzLHbc6zQTABo2eQJP0t8ouzbKWtsWKdhVqTI
         WYtljHlQaneAxijuQ0eRFbwXLSodaLgjGY8lYqb35tT5IqyyEwTVIUFF7INE2Bv+Off8
         LQ+YbYk6MwfkKX7g/i+QytCwRq6/BFPmggcWTzsGQZw6k9xn2bAv35lIIgVMMoUQ9/3f
         xeqA==
X-Gm-Message-State: APjAAAWqTVG4naaSaf7r1GHOIFYaLmODnJ5BBcjnQdetdcyzNemNtVOh
        ce8e+Rp7lGc2R9ufGP+dCTH/7M7Mr81GdzrjpuM=
X-Google-Smtp-Source: APXvYqwxIZ8Wg/h0X202jB2VzvT9Ocz9b9KwuwU/6ELhSw0nAdni6nllmbWgxEkcctYm/FcjgpyXMbxebc8Z9qlXWFc=
X-Received: by 2002:a0c:994a:: with SMTP id i10mr1528707qvd.48.1556802091024;
 Thu, 02 May 2019 06:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAH6h+heMSyHvFRNwkn5XjZJt=fzmKJwzinifP8H75k47A774Ow@mail.gmail.com>
In-Reply-To: <CAH6h+heMSyHvFRNwkn5XjZJt=fzmKJwzinifP8H75k47A774Ow@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 2 May 2019 06:01:19 -0700
Message-ID: <CAPhsuW5eO3v3bWjz5KtzX+0p5qtyaRHEENGOY+kgt=nDtHUVYA@mail.gmail.com>
Subject: Re: WARNING: CPU: 13 PID: 3786 at drivers/md/raid5.c:4611 break_stripe_batch_list+0x86/0x1fb
To:     Marc Smith <msmith626@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 1, 2019 at 1:43 PM Marc Smith <msmith626@gmail.com> wrote:
>
> Hi,
>
> I'm using some MD RAID5 arrays with Linux 4.14.91. Everything has been
> working great for sometime now, but this morning I noticed the
> following snippet of kernel messages:
> --snip--
> Apr 30 23:49:09 node1 kernel: [10496.092367] stripe state: 2001
> Apr 30 23:49:09 node1 kernel: [10496.092395] ------------[ cut here
> ]------------
> Apr 30 23:49:09 node1 kernel: [10496.092408] WARNING: CPU: 13 PID:
> 3786 at drivers/md/raid5.c:4611 break_stripe_batch_list+0x86/0x1fb
> Apr 30 23:49:09 node1 kernel: [10496.092410] Modules linked in:
> scst_qla2xxx(O) fcst(O) scst_changer(O) scst_tape(O) scst_vdisk(O)
> scst_disk(O) ib_srpt(O) isert_scst(O) iscsi_scst(O) scst(O) qla2xxx(O)
> bonding ntb_netdev ntb_hw_switchtec(O) cls(O) mlx5_core bna ib_umad
> rdma_ucm ib_uverbs ib_srp iw_nes iw_cxgb4 cxgb4 iw_cxgb3 ib_qib rdmavt
> mlx4_ib ib_mthca
> Apr 30 23:49:09 node1 kernel: [10496.092450] CPU: 13 PID: 3786 Comm:
> md125_raid5 Tainted: G           O    4.14.91-esos.prod #1
> Apr 30 23:49:09 node1 kernel: [10496.092452] Hardware name:
> CELESTICA-CSS Athena/Athena-MB, BIOS COL00708 11/26/2018
> Apr 30 23:49:09 node1 kernel: [10496.092455] task: ffff888f84183b40
> task.stack: ffffc9000b2ec000
> Apr 30 23:49:09 node1 kernel: [10496.092459] RIP:
> 0010:break_stripe_batch_list+0x86/0x1fb
> Apr 30 23:49:09 node1 kernel: [10496.092462] RSP:
> 0018:ffffc9000b2efc40 EFLAGS: 00010286
> Apr 30 23:49:09 node1 kernel: [10496.092465] RAX: 0000000000000012
> RBX: ffff888f182aaad0 RCX: 0000000000000000
> Apr 30 23:49:09 node1 kernel: [10496.092467] RDX: ffff88903fb5d001
> RSI: ffff88903fb554c8 RDI: ffff88903fb554c8
> Apr 30 23:49:09 node1 kernel: [10496.092469] RBP: ffff888f25222240
> R08: 0000000000000001 R09: 0000000000020300
> Apr 30 23:49:09 node1 kernel: [10496.092471] R10: 0000000000000000
> R11: 00000000000fe6b4 R12: 0000000000000000
> Apr 30 23:49:09 node1 kernel: [10496.092473] R13: ffff888f4b1e3360
> R14: 0000000000001c04 R15: ffff888efcffab18
> Apr 30 23:49:09 node1 kernel: [10496.092476] FS:
> 0000000000000000(0000) GS:ffff88903fb40000(0000)
> knlGS:0000000000000000
> Apr 30 23:49:09 node1 kernel: [10496.092478] CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Apr 30 23:49:09 node1 kernel: [10496.092480] CR2: 00007f834dbce698
> CR3: 0000000002812005 CR4: 00000000007606e0
> Apr 30 23:49:09 node1 kernel: [10496.092483] DR0: 0000000000000000
> DR1: 0000000000000000 DR2: 0000000000000000
> Apr 30 23:49:09 node1 kernel: [10496.092485] DR3: 0000000000000000
> DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Apr 30 23:49:09 node1 kernel: [10496.092486] PKRU: 55555554
> Apr 30 23:49:09 node1 kernel: [10496.092487] Call Trace:
> Apr 30 23:49:09 node1 kernel: [10496.092498]  handle_stripe+0xcdf/0x1958
> Apr 30 23:49:09 node1 kernel: [10496.092507]  ? enqueue_task_fair+0x219/0x96b
> Apr 30 23:49:09 node1 kernel: [10496.092513]
> handle_active_stripes.isra.26+0x329/0x396
> Apr 30 23:49:09 node1 kernel: [10496.092518]  raid5d+0x302/0x47f
> Apr 30 23:49:09 node1 kernel: [10496.092522]  ? del_timer_sync+0x22/0x2c
> Apr 30 23:49:09 node1 kernel: [10496.092530]  ? md_register_thread+0xc1/0xc1
> Apr 30 23:49:09 node1 kernel: [10496.092534]  ? md_thread+0x12b/0x13d
> Apr 30 23:49:09 node1 kernel: [10496.092537]  md_thread+0x12b/0x13d
> Apr 30 23:49:09 node1 kernel: [10496.092544]  ? wait_woken+0x68/0x68
> Apr 30 23:49:09 node1 kernel: [10496.092552]  kthread+0x117/0x11f
> Apr 30 23:49:09 node1 kernel: [10496.092557]  ? kthread_create_on_node+0x3a/0x3a
> Apr 30 23:49:09 node1 kernel: [10496.092564]  ret_from_fork+0x35/0x40
> Apr 30 23:49:09 node1 kernel: [10496.092568] Code: 48 89 83 90 00 00
> 00 f7 c6 a9 c2 eb 00 74 1e 80 3d 12 74 f6 00 00 75 15 48 c7 c7 bf c8
> 56 82 c6 05 02 74 f6 00 01 e8 4b 6f 6b ff <0f> 0b 48 8b 75 48 f7 c6 20
> 00 08 00 74 1e 80 3d e7 73 f6 00 00
> Apr 30 23:49:09 node1 kernel: [10496.092629] ---[ end trace
> 90e17afe3799d471 ]---
> --snip--
>
> I see that comes from break_stripe_batch_list() in
> linux-4.14.91/drivers/md/raid5.c:
> --snip--
>                 WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>                                           (1 << STRIPE_SYNCING) |
>                                           (1 << STRIPE_REPLACED) |
>                                           (1 << STRIPE_DELAYED) |
>                                           (1 << STRIPE_BIT_DELAY) |
>                                           (1 << STRIPE_FULL_WRITE) |
>                                           (1 << STRIPE_BIOFILL_RUN) |
>                                           (1 << STRIPE_COMPUTE_RUN)  |
>                                           (1 << STRIPE_OPS_REQ_PENDING) |
>                                           (1 << STRIPE_DISCARD) |
>                                           (1 << STRIPE_BATCH_READY) |
>                                           (1 << STRIPE_BATCH_ERR) |
>                                           (1 << STRIPE_BITMAP_PENDING)),
>                         "stripe state: %lx\n", sh->state);
> --snip--
>
> I see the "stripe state: 2001" value in the log. I can go through and
> decode, but I'm still probably not going to be sure what's expected or
> wrong. The MD array seems to be functioning correctly, I'm not seeing
> anymore errors but I do understand the statement above is WARN_ONCE().

So for 0x2001, it is just the STRIPE_ACTIVE bit.

>
> Is this a sign of corruption / serious issue, or transient problem?
> Any additional debug steps that I can perform to collect more data? I
> searched a bit on Google for this error, but didn't get any relevant
> hits. Any help would be greatly appreciated.

This one looks like race condition in head_sh and sh in the list, so it
doesn't seem too bad.

Could you try reboot the system and see whether this happen again?

Thanks,
Song

>
> Thanks,
>
> Marc
