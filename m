Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822DB269CD
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2019 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfEVS1V (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 May 2019 14:27:21 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46183 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVS1U (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 May 2019 14:27:20 -0400
Received: by mail-qt1-f169.google.com with SMTP id z19so721393qtz.13
        for <linux-raid@vger.kernel.org>; Wed, 22 May 2019 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CssHEXvkP86hZJGdLI09k7eLPNXk+sTSo0AZ34T+JlU=;
        b=qbMqVDfORTqpM++qt+kIDrSm9NAEEzyoNVwwyBc6afKz9fOmYswEH3ZUHNfRMSEF+e
         Ke0/vvz8kRga0reQZQHwv5UfGgsrU2Fl8UCy1jwly01EmMcZavRgZirb3Mf4OaljR/Go
         xBHoSD1ZNDlbF6vh492XygA/HbiJuDcGC21fZ7LwypGBN9eOiOCTCtfdNqqyseSbPex8
         xKrFaeEzd/0+j8KLFnIgx6nSnGgy222wW7iBimns0YDHcZz8tuobs085GcUKnKtqgW8f
         aQxoeT4Qd2de1Uojdz0gfIclo9s7YR/s3LEWBvOMmBQjCM7LO/ExJ5cYxDaLGBEMhbUO
         xoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CssHEXvkP86hZJGdLI09k7eLPNXk+sTSo0AZ34T+JlU=;
        b=nhVrh+gyNl5tqBi+Qh+gKzUCKF98P916KXs7lCuFYrUowTm75wZadyXN3V6yAPs0oB
         BZsnc9Y4y3oQvzvU4D+ZYfEVt/MV4YhLGK9sOikX6Mk7OadBFBSD6jazhykOqv0sLpUt
         3/YdkwKdjORf/P6JXZd8ZQ6YLz8moiECZjWLCXU9owY+CjbbyF3CbyPujFFn5m2y1Esp
         ImFJzp7BWRrtWGIDHODlucevhUChwkBuS91Tg4fjsqLg7vmjRaF4R4tTthW1wjlhCwzA
         xqh4A8J++IliOI53TApF/4U8KnCK5SuCrEkDDLoduVeS+Vo8kKGhad3e8y7WC/5FsjV4
         cOMg==
X-Gm-Message-State: APjAAAWq8i8yrpj2VM0MoP1kGpo4KgE4IAeI0HrFgNT4/tPatoWRdSIB
        i/67NNUwqVqJdAzB6S49CoyGz2TbeNlZc8FrzD0e0A==
X-Google-Smtp-Source: APXvYqxeni2eC6C7fGLfoLvOqmvtvZCXO3Md8lFHWrpTHzaWj2emdLnjYrYzoM3XDSDZJ61LExV1i4Bmt8ULUG9uUoE=
X-Received: by 2002:ac8:16a4:: with SMTP id r33mr48997514qtj.118.1558549639494;
 Wed, 22 May 2019 11:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
In-Reply-To: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 22 May 2019 11:27:08 -0700
Message-ID: <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
Subject: Re: Few questions about (attempting to use) write journal + call traces
To:     Michal Soltys <soltys@ziu.info>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 22, 2019 at 6:18 AM Michal Soltys <soltys@ziu.info> wrote:
>
> Hi,
>
> As I started experimenting with journaled raids:
>
> 1) can another (raid1) device or lvm mirror (using md underneath) be used formally as a write journal ?
> 2) for the testing purposes, are loopback devices expected to work ?
>
> I know I can successfully create both of the above (case scenario below), but any attempt to write to such md device ends with hung tasks and D states.
>
>
> kernel 5.1.3
> mdadm 4.1
> btrfs filesystem with /var subvolume (where losetup files were created with fallocate)
>
> What I did:
>
> - six 10gb files as backings for /dev/loop[0-5]
> - /dev/loop[4-5] - raid1
> - /dev/loop[0-3] - raid5
>
> Now at this point both raids work just fine, separately. The problem starts if I create raid1 as raid5's journal (doesn't matter whether w-t or w-b). Any attempt to write to a device like that instantly ends with D and respective traces in dmesg:

Hi Michal,

Yes, the journal _should_ work with another md, lvm, or loop device.
Could you please share the commands you used in this test?

Thanks,
Song

>
> May 22 14:39:37 hakai kernel: INFO: task dd:899 blocked for more than 245 seconds.
> May 22 14:39:37 hakai kernel:       Not tainted 5.1.3-arch1-1-ARCH #1
> May 22 14:39:37 hakai kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> May 22 14:39:37 hakai kernel: dd              D    0   899    824 0x00000004
> May 22 14:39:37 hakai kernel: Call Trace:
> May 22 14:39:37 hakai kernel:  ? __schedule+0x30b/0x8b0
> May 22 14:39:37 hakai kernel:  ? raid5_unplug+0xb2/0x140 [raid456]
> May 22 14:39:37 hakai kernel:  schedule+0x32/0x80
> May 22 14:39:37 hakai kernel:  io_schedule+0x12/0x40
> May 22 14:39:37 hakai kernel:  wait_on_page_bit+0x138/0x200
> May 22 14:39:37 hakai kernel:  ? add_to_page_cache_lru+0xc0/0xc0
> May 22 14:39:37 hakai kernel:  __filemap_fdatawait_range+0xb9/0x110
> May 22 14:39:37 hakai kernel:  filemap_fdatawait_range+0xe/0x20
> May 22 14:39:37 hakai kernel:  filemap_write_and_wait+0x47/0x70
> May 22 14:39:37 hakai kernel:  __blkdev_put+0x71/0x1e0
> May 22 14:39:37 hakai kernel:  blkdev_close+0x21/0x30
> May 22 14:39:37 hakai kernel:  __fput+0xa5/0x1d0
> May 22 14:39:37 hakai kernel:  task_work_run+0x8f/0xb0
> May 22 14:39:37 hakai kernel:  exit_to_usermode_loop+0xd3/0xe0
> May 22 14:39:37 hakai kernel:  do_syscall_64+0x157/0x180
> May 22 14:39:37 hakai kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> May 22 14:39:37 hakai kernel: RIP: 0033:0x7f13c4a66348
> May 22 14:39:37 hakai kernel: Code: Bad RIP value.
> May 22 14:39:37 hakai kernel: RSP: 002b:00007ffcde214058 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> May 22 14:39:37 hakai kernel: RAX: 0000000000000000 RBX: 0000562ed16d5160 RCX: 00007f13c4a66348
> May 22 14:39:37 hakai kernel: RDX: 0000000000080000 RSI: 0000000000000000 RDI: 0000000000000001
> May 22 14:39:37 hakai kernel: RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
> May 22 14:39:37 hakai kernel: R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000001
> May 22 14:39:37 hakai kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 00007f13c4301000
>
> May 22 14:39:37 hakai kernel: INFO: task systemd-udevd:313 blocked for more than 245 seconds.
> May 22 14:39:37 hakai kernel:       Not tainted 5.1.3-arch1-1-ARCH #1
> May 22 14:39:37 hakai kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> May 22 14:39:37 hakai kernel: systemd-udevd   D    0   313      1 0x00000104
> May 22 14:39:37 hakai kernel: Call Trace:
> May 22 14:39:37 hakai kernel:  ? __schedule+0x30b/0x8b0
> May 22 14:39:37 hakai kernel:  schedule+0x32/0x80
> May 22 14:39:37 hakai kernel:  schedule_preempt_disabled+0x14/0x20
> May 22 14:39:37 hakai kernel:  __mutex_lock.isra.1+0x217/0x520
> May 22 14:39:37 hakai kernel:  ? kobj_lookup+0xf1/0x160
> May 22 14:39:37 hakai kernel:  __blkdev_get+0x83/0x540
> May 22 14:39:37 hakai kernel:  blkdev_get+0x108/0x340
> May 22 14:39:37 hakai kernel:  ? preempt_count_add+0x79/0xb0
> May 22 14:39:37 hakai kernel:  ? _raw_spin_lock+0x13/0x30
> May 22 14:39:37 hakai kernel:  ? bd_acquire+0xc0/0xc0
> May 22 14:39:37 hakai kernel:  do_dentry_open+0x13a/0x380
> May 22 14:39:37 hakai kernel:  path_openat+0x2d6/0x1500
> May 22 14:39:37 hakai kernel:  ? mntput_no_expire+0x11/0x1a0
> May 22 14:39:37 hakai kernel:  ? terminate_walk+0xeb/0x100
> May 22 14:39:37 hakai kernel:  do_filp_open+0x93/0x100
> May 22 14:39:37 hakai kernel:  ? __check_object_size+0xc1/0x175
> May 22 14:39:37 hakai kernel:  ? _raw_spin_unlock+0x16/0x30
> May 22 14:39:37 hakai kernel:  do_sys_open+0x186/0x220
> May 22 14:39:37 hakai kernel:  do_syscall_64+0x5b/0x180
> May 22 14:39:37 hakai kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> May 22 14:39:37 hakai kernel: RIP: 0033:0x7ff24fe549ff
> May 22 14:39:37 hakai kernel: Code: Bad RIP value.
> May 22 14:39:37 hakai kernel: RSP: 002b:00007ffe7b7ce060 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> May 22 14:39:37 hakai kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff24fe549ff
> May 22 14:39:37 hakai kernel: RDX: 00000000000a0800 RSI: 00005578d289be10 RDI: 00000000ffffff9c
> May 22 14:39:37 hakai kernel: RBP: 00005578d28b3ea0 R08: 00007ff24fb896d0 R09: 00005578d2891fe0
> May 22 14:39:37 hakai kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> May 22 14:39:37 hakai kernel: R13: 00007ffe7b7cf198 R14: 00007ffe7b7cf188 R15: 00005578d27e1254
