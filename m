Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE664D8FD
	for <lists+linux-raid@lfdr.de>; Thu, 20 Jun 2019 20:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfFTSap (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Jun 2019 14:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfFTSAh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 20 Jun 2019 14:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45AD8356C4;
        Thu, 20 Jun 2019 18:00:36 +0000 (UTC)
Received: from [10.10.124.219] (ovpn-124-219.rdu2.redhat.com [10.10.124.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADEBA61998;
        Thu, 20 Jun 2019 18:00:34 +0000 (UTC)
Subject: Re: WARNING: CPU: 13 PID: 3786 at drivers/md/raid5.c:4611
 break_stripe_batch_list+0x86/0x1fb
To:     Marc Smith <msmith626@gmail.com>, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <CAH6h+heMSyHvFRNwkn5XjZJt=fzmKJwzinifP8H75k47A774Ow@mail.gmail.com>
 <CAPhsuW5eO3v3bWjz5KtzX+0p5qtyaRHEENGOY+kgt=nDtHUVYA@mail.gmail.com>
 <CAH6h+heG9613kaMM5zR7CyzFUZGM4x7_eoqrpmvL_xW6AHHPqw@mail.gmail.com>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <1bc5b114-ad8d-772e-d3a1-74e590dd5329@redhat.com>
Date:   Thu, 20 Jun 2019 14:00:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAH6h+heG9613kaMM5zR7CyzFUZGM4x7_eoqrpmvL_xW6AHHPqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Jun 2019 18:00:36 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 6/13/19 5:18 PM, Marc Smith wrote:
> On Thu, May 2, 2019 at 9:01 AM Song Liu <liu.song.a23@gmail.com> wrote:
>> On Wed, May 1, 2019 at 1:43 PM Marc Smith <msmith626@gmail.com> wrote:
>>> Hi,
>>>
>>> I'm using some MD RAID5 arrays with Linux 4.14.91. Everything has been
>>> working great for sometime now, but this morning I noticed the
>>> following snippet of kernel messages:
>>> --snip--
>>> Apr 30 23:49:09 node1 kernel: [10496.092367] stripe state: 2001
>>> Apr 30 23:49:09 node1 kernel: [10496.092395] ------------[ cut here
>>> ]------------
>>> Apr 30 23:49:09 node1 kernel: [10496.092408] WARNING: CPU: 13 PID:
>>> 3786 at drivers/md/raid5.c:4611 break_stripe_batch_list+0x86/0x1fb
>>> Apr 30 23:49:09 node1 kernel: [10496.092410] Modules linked in:
>>> scst_qla2xxx(O) fcst(O) scst_changer(O) scst_tape(O) scst_vdisk(O)
>>> scst_disk(O) ib_srpt(O) isert_scst(O) iscsi_scst(O) scst(O) qla2xxx(O)
>>> bonding ntb_netdev ntb_hw_switchtec(O) cls(O) mlx5_core bna ib_umad
>>> rdma_ucm ib_uverbs ib_srp iw_nes iw_cxgb4 cxgb4 iw_cxgb3 ib_qib rdmavt
>>> mlx4_ib ib_mthca
>>> Apr 30 23:49:09 node1 kernel: [10496.092450] CPU: 13 PID: 3786 Comm:
>>> md125_raid5 Tainted: G           O    4.14.91-esos.prod #1
>>> Apr 30 23:49:09 node1 kernel: [10496.092452] Hardware name:
>>> CELESTICA-CSS Athena/Athena-MB, BIOS COL00708 11/26/2018
>>> Apr 30 23:49:09 node1 kernel: [10496.092455] task: ffff888f84183b40
>>> task.stack: ffffc9000b2ec000
>>> Apr 30 23:49:09 node1 kernel: [10496.092459] RIP:
>>> 0010:break_stripe_batch_list+0x86/0x1fb
>>> Apr 30 23:49:09 node1 kernel: [10496.092462] RSP:
>>> 0018:ffffc9000b2efc40 EFLAGS: 00010286
>>> Apr 30 23:49:09 node1 kernel: [10496.092465] RAX: 0000000000000012
>>> RBX: ffff888f182aaad0 RCX: 0000000000000000
>>> Apr 30 23:49:09 node1 kernel: [10496.092467] RDX: ffff88903fb5d001
>>> RSI: ffff88903fb554c8 RDI: ffff88903fb554c8
>>> Apr 30 23:49:09 node1 kernel: [10496.092469] RBP: ffff888f25222240
>>> R08: 0000000000000001 R09: 0000000000020300
>>> Apr 30 23:49:09 node1 kernel: [10496.092471] R10: 0000000000000000
>>> R11: 00000000000fe6b4 R12: 0000000000000000
>>> Apr 30 23:49:09 node1 kernel: [10496.092473] R13: ffff888f4b1e3360
>>> R14: 0000000000001c04 R15: ffff888efcffab18
>>> Apr 30 23:49:09 node1 kernel: [10496.092476] FS:
>>> 0000000000000000(0000) GS:ffff88903fb40000(0000)
>>> knlGS:0000000000000000
>>> Apr 30 23:49:09 node1 kernel: [10496.092478] CS:  0010 DS: 0000 ES:
>>> 0000 CR0: 0000000080050033
>>> Apr 30 23:49:09 node1 kernel: [10496.092480] CR2: 00007f834dbce698
>>> CR3: 0000000002812005 CR4: 00000000007606e0
>>> Apr 30 23:49:09 node1 kernel: [10496.092483] DR0: 0000000000000000
>>> DR1: 0000000000000000 DR2: 0000000000000000
>>> Apr 30 23:49:09 node1 kernel: [10496.092485] DR3: 0000000000000000
>>> DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Apr 30 23:49:09 node1 kernel: [10496.092486] PKRU: 55555554
>>> Apr 30 23:49:09 node1 kernel: [10496.092487] Call Trace:
>>> Apr 30 23:49:09 node1 kernel: [10496.092498]  handle_stripe+0xcdf/0x1958
>>> Apr 30 23:49:09 node1 kernel: [10496.092507]  ? enqueue_task_fair+0x219/0x96b
>>> Apr 30 23:49:09 node1 kernel: [10496.092513]
>>> handle_active_stripes.isra.26+0x329/0x396
>>> Apr 30 23:49:09 node1 kernel: [10496.092518]  raid5d+0x302/0x47f
>>> Apr 30 23:49:09 node1 kernel: [10496.092522]  ? del_timer_sync+0x22/0x2c
>>> Apr 30 23:49:09 node1 kernel: [10496.092530]  ? md_register_thread+0xc1/0xc1
>>> Apr 30 23:49:09 node1 kernel: [10496.092534]  ? md_thread+0x12b/0x13d
>>> Apr 30 23:49:09 node1 kernel: [10496.092537]  md_thread+0x12b/0x13d
>>> Apr 30 23:49:09 node1 kernel: [10496.092544]  ? wait_woken+0x68/0x68
>>> Apr 30 23:49:09 node1 kernel: [10496.092552]  kthread+0x117/0x11f
>>> Apr 30 23:49:09 node1 kernel: [10496.092557]  ? kthread_create_on_node+0x3a/0x3a
>>> Apr 30 23:49:09 node1 kernel: [10496.092564]  ret_from_fork+0x35/0x40
>>> Apr 30 23:49:09 node1 kernel: [10496.092568] Code: 48 89 83 90 00 00
>>> 00 f7 c6 a9 c2 eb 00 74 1e 80 3d 12 74 f6 00 00 75 15 48 c7 c7 bf c8
>>> 56 82 c6 05 02 74 f6 00 01 e8 4b 6f 6b ff <0f> 0b 48 8b 75 48 f7 c6 20
>>> 00 08 00 74 1e 80 3d e7 73 f6 00 00
>>> Apr 30 23:49:09 node1 kernel: [10496.092629] ---[ end trace
>>> 90e17afe3799d471 ]---
>>> --snip--
>>>
>>> I see that comes from break_stripe_batch_list() in
>>> linux-4.14.91/drivers/md/raid5.c:
>>> --snip--
>>>                  WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>>>                                            (1 << STRIPE_SYNCING) |
>>>                                            (1 << STRIPE_REPLACED) |
>>>                                            (1 << STRIPE_DELAYED) |
>>>                                            (1 << STRIPE_BIT_DELAY) |
>>>                                            (1 << STRIPE_FULL_WRITE) |
>>>                                            (1 << STRIPE_BIOFILL_RUN) |
>>>                                            (1 << STRIPE_COMPUTE_RUN)  |
>>>                                            (1 << STRIPE_OPS_REQ_PENDING) |
>>>                                            (1 << STRIPE_DISCARD) |
>>>                                            (1 << STRIPE_BATCH_READY) |
>>>                                            (1 << STRIPE_BATCH_ERR) |
>>>                                            (1 << STRIPE_BITMAP_PENDING)),
>>>                          "stripe state: %lx\n", sh->state);
>>> --snip--
>>>
>>> I see the "stripe state: 2001" value in the log. I can go through and
>>> decode, but I'm still probably not going to be sure what's expected or
>>> wrong. The MD array seems to be functioning correctly, I'm not seeing
>>> anymore errors but I do understand the statement above is WARN_ONCE().
>> So for 0x2001, it is just the STRIPE_ACTIVE bit.
>>
>>> Is this a sign of corruption / serious issue, or transient problem?
>>> Any additional debug steps that I can perform to collect more data? I
>>> searched a bit on Google for this error, but didn't get any relevant
>>> hits. Any help would be greatly appreciated.
>> This one looks like race condition in head_sh and sh in the list, so it
>> doesn't seem too bad.
>>
>> Could you try reboot the system and see whether this happen again?
> Song, thanks for the quick response. I rebooted the system and have
> been testing this same system (and another identical machine) for the
> past month and have not seen this again since then.
>
> --Marc
>
>> Thanks,
>> Song
>>
>>> Thanks,
>>>
>>> Marc

Problem did not exist at 3.10.0-229

I'm thinking it got introduce in 3.10.0-327.


