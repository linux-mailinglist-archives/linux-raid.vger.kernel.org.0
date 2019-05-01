Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749A710E30
	for <lists+linux-raid@lfdr.de>; Wed,  1 May 2019 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfEAUmz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 May 2019 16:42:55 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:37130 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEAUmz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 May 2019 16:42:55 -0400
Received: by mail-ua1-f43.google.com with SMTP id l17so33474uar.4
        for <linux-raid@vger.kernel.org>; Wed, 01 May 2019 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IGF4FDgzX704vfUVqtAl911VmtQL7WU7HRZ1S7YNrwc=;
        b=n6F6D+Hj7A0eusnNx3aasSxHvB/0kX3QbzzQHq8XEF4McC4t1RC89gtvfmdmRRDLhV
         wQ4vSxPbwROULMaeBbcRRhFWkzdW/Ym0s7RZkpZG6hPa7Kbpa136RyScXpK4W+KcCOWx
         wlBong/SzV2tdPs/XXC29kWQdPQvmswZ+TzXqCVDeq8T7E2o1Uok0k8njWKE6Qq1Xps3
         zUIs02oAEPzU0aMQzHf+jbI8b+c304IaTrvqtvZj3Aj+2A3EKPrc9MQa7xeH6q6hpMMt
         mj9/X/3HqLe1MfTqoLMJWAzoPgy1htUwZIDI7JkH6uSDGCK+fGP0Y19tSW6lGg7XPmkN
         WxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IGF4FDgzX704vfUVqtAl911VmtQL7WU7HRZ1S7YNrwc=;
        b=lq+TN+mdsL5pXIPySPwieqeJNiJOjjymKRk5xpkU9/5VcCicYfV3NEZNJtuGNc5syF
         QXJzx51v8DSHnXBBRlDaohk4PrR6hN4B4OORdLf+9h4LTxqTep0HLWo744bA6GI+jJxu
         /8l09ub6/DnHVfy3fz6NRukciEeb8XGEFIeU5nQdVXhhZTrD/4r/INqG8AYJTIWh5uxg
         xy1Ip7NyOjfhckahQu3HjSDHhL/8Rc32f7x2jCwiSxUVs1/Gm3+6EJJNb0Obrf6lcbOg
         QWz3AFKU+mtOVflFuW8gqhw2Jb78oLMZ+SN92ptqTo8d/TW92uWhyWDjksVJI+vnBZLm
         DeQA==
X-Gm-Message-State: APjAAAXNc0xo5S+8nIKaUmyRBXztcgDrk0QJwjWojY9NS64P1DCnc36I
        hMG0ELsLdUjbA9LLL5pNmBLu1+zliCrBC7o95kkNowG2
X-Google-Smtp-Source: APXvYqwNcCFSk0qnS48qA/3CZfUyKzJfqFWsuci5VkqE0QEwfttUJNd2KnvE8hh9DypgKvrBj9rF62Gqba8G4baw2zw=
X-Received: by 2002:a9f:311b:: with SMTP id m27mr128636uab.5.1556743373388;
 Wed, 01 May 2019 13:42:53 -0700 (PDT)
MIME-Version: 1.0
From:   Marc Smith <msmith626@gmail.com>
Date:   Wed, 1 May 2019 16:42:42 -0400
Message-ID: <CAH6h+heMSyHvFRNwkn5XjZJt=fzmKJwzinifP8H75k47A774Ow@mail.gmail.com>
Subject: WARNING: CPU: 13 PID: 3786 at drivers/md/raid5.c:4611 break_stripe_batch_list+0x86/0x1fb
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I'm using some MD RAID5 arrays with Linux 4.14.91. Everything has been
working great for sometime now, but this morning I noticed the
following snippet of kernel messages:
--snip--
Apr 30 23:49:09 node1 kernel: [10496.092367] stripe state: 2001
Apr 30 23:49:09 node1 kernel: [10496.092395] ------------[ cut here
]------------
Apr 30 23:49:09 node1 kernel: [10496.092408] WARNING: CPU: 13 PID:
3786 at drivers/md/raid5.c:4611 break_stripe_batch_list+0x86/0x1fb
Apr 30 23:49:09 node1 kernel: [10496.092410] Modules linked in:
scst_qla2xxx(O) fcst(O) scst_changer(O) scst_tape(O) scst_vdisk(O)
scst_disk(O) ib_srpt(O) isert_scst(O) iscsi_scst(O) scst(O) qla2xxx(O)
bonding ntb_netdev ntb_hw_switchtec(O) cls(O) mlx5_core bna ib_umad
rdma_ucm ib_uverbs ib_srp iw_nes iw_cxgb4 cxgb4 iw_cxgb3 ib_qib rdmavt
mlx4_ib ib_mthca
Apr 30 23:49:09 node1 kernel: [10496.092450] CPU: 13 PID: 3786 Comm:
md125_raid5 Tainted: G           O    4.14.91-esos.prod #1
Apr 30 23:49:09 node1 kernel: [10496.092452] Hardware name:
CELESTICA-CSS Athena/Athena-MB, BIOS COL00708 11/26/2018
Apr 30 23:49:09 node1 kernel: [10496.092455] task: ffff888f84183b40
task.stack: ffffc9000b2ec000
Apr 30 23:49:09 node1 kernel: [10496.092459] RIP:
0010:break_stripe_batch_list+0x86/0x1fb
Apr 30 23:49:09 node1 kernel: [10496.092462] RSP:
0018:ffffc9000b2efc40 EFLAGS: 00010286
Apr 30 23:49:09 node1 kernel: [10496.092465] RAX: 0000000000000012
RBX: ffff888f182aaad0 RCX: 0000000000000000
Apr 30 23:49:09 node1 kernel: [10496.092467] RDX: ffff88903fb5d001
RSI: ffff88903fb554c8 RDI: ffff88903fb554c8
Apr 30 23:49:09 node1 kernel: [10496.092469] RBP: ffff888f25222240
R08: 0000000000000001 R09: 0000000000020300
Apr 30 23:49:09 node1 kernel: [10496.092471] R10: 0000000000000000
R11: 00000000000fe6b4 R12: 0000000000000000
Apr 30 23:49:09 node1 kernel: [10496.092473] R13: ffff888f4b1e3360
R14: 0000000000001c04 R15: ffff888efcffab18
Apr 30 23:49:09 node1 kernel: [10496.092476] FS:
0000000000000000(0000) GS:ffff88903fb40000(0000)
knlGS:0000000000000000
Apr 30 23:49:09 node1 kernel: [10496.092478] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Apr 30 23:49:09 node1 kernel: [10496.092480] CR2: 00007f834dbce698
CR3: 0000000002812005 CR4: 00000000007606e0
Apr 30 23:49:09 node1 kernel: [10496.092483] DR0: 0000000000000000
DR1: 0000000000000000 DR2: 0000000000000000
Apr 30 23:49:09 node1 kernel: [10496.092485] DR3: 0000000000000000
DR6: 00000000fffe0ff0 DR7: 0000000000000400
Apr 30 23:49:09 node1 kernel: [10496.092486] PKRU: 55555554
Apr 30 23:49:09 node1 kernel: [10496.092487] Call Trace:
Apr 30 23:49:09 node1 kernel: [10496.092498]  handle_stripe+0xcdf/0x1958
Apr 30 23:49:09 node1 kernel: [10496.092507]  ? enqueue_task_fair+0x219/0x96b
Apr 30 23:49:09 node1 kernel: [10496.092513]
handle_active_stripes.isra.26+0x329/0x396
Apr 30 23:49:09 node1 kernel: [10496.092518]  raid5d+0x302/0x47f
Apr 30 23:49:09 node1 kernel: [10496.092522]  ? del_timer_sync+0x22/0x2c
Apr 30 23:49:09 node1 kernel: [10496.092530]  ? md_register_thread+0xc1/0xc1
Apr 30 23:49:09 node1 kernel: [10496.092534]  ? md_thread+0x12b/0x13d
Apr 30 23:49:09 node1 kernel: [10496.092537]  md_thread+0x12b/0x13d
Apr 30 23:49:09 node1 kernel: [10496.092544]  ? wait_woken+0x68/0x68
Apr 30 23:49:09 node1 kernel: [10496.092552]  kthread+0x117/0x11f
Apr 30 23:49:09 node1 kernel: [10496.092557]  ? kthread_create_on_node+0x3a/0x3a
Apr 30 23:49:09 node1 kernel: [10496.092564]  ret_from_fork+0x35/0x40
Apr 30 23:49:09 node1 kernel: [10496.092568] Code: 48 89 83 90 00 00
00 f7 c6 a9 c2 eb 00 74 1e 80 3d 12 74 f6 00 00 75 15 48 c7 c7 bf c8
56 82 c6 05 02 74 f6 00 01 e8 4b 6f 6b ff <0f> 0b 48 8b 75 48 f7 c6 20
00 08 00 74 1e 80 3d e7 73 f6 00 00
Apr 30 23:49:09 node1 kernel: [10496.092629] ---[ end trace
90e17afe3799d471 ]---
--snip--

I see that comes from break_stripe_batch_list() in
linux-4.14.91/drivers/md/raid5.c:
--snip--
                WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
                                          (1 << STRIPE_SYNCING) |
                                          (1 << STRIPE_REPLACED) |
                                          (1 << STRIPE_DELAYED) |
                                          (1 << STRIPE_BIT_DELAY) |
                                          (1 << STRIPE_FULL_WRITE) |
                                          (1 << STRIPE_BIOFILL_RUN) |
                                          (1 << STRIPE_COMPUTE_RUN)  |
                                          (1 << STRIPE_OPS_REQ_PENDING) |
                                          (1 << STRIPE_DISCARD) |
                                          (1 << STRIPE_BATCH_READY) |
                                          (1 << STRIPE_BATCH_ERR) |
                                          (1 << STRIPE_BITMAP_PENDING)),
                        "stripe state: %lx\n", sh->state);
--snip--

I see the "stripe state: 2001" value in the log. I can go through and
decode, but I'm still probably not going to be sure what's expected or
wrong. The MD array seems to be functioning correctly, I'm not seeing
anymore errors but I do understand the statement above is WARN_ONCE().

Is this a sign of corruption / serious issue, or transient problem?
Any additional debug steps that I can perform to collect more data? I
searched a bit on Google for this error, but didn't get any relevant
hits. Any help would be greatly appreciated.

Thanks,

Marc
