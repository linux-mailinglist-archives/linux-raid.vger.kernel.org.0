Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333A813855F
	for <lists+linux-raid@lfdr.de>; Sun, 12 Jan 2020 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgALHrE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jan 2020 02:47:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39341 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbgALHrD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Jan 2020 02:47:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so4610401lfb.6
        for <linux-raid@vger.kernel.org>; Sat, 11 Jan 2020 23:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMvwbbhDMLXPJcLx4ix6M21d2hkYUP1GACJZYqvTnTA=;
        b=kHC5Ns4qZJkb4vqQ5ppMXhT8PpHn4rars4knj8gciIlTrgGinwSlDAQp6lKbn1Ehnt
         1U+/Ks5VvR/DP7Wd5iUAIPcesSyvlX5j4JTYIZap09GnNEMhM2/FGB0C6hpeLTR0Y/R4
         2JzZWASbMYsoX1g23+23/DoLo7vGW/EQoPlBZVvk/ItBC+fTrUR+9Qk1pSngh2u+MrAO
         N1dFCViGo0+P7AP01XCmSZlcQTDcFjNEwPpprjkFJ/KEw9p478xfFYd7nN+NX2EVg4bO
         ISXAE/uy73d4pCAx3QXL7wIhiMJtUzttTDzgxfF/3KNcWXsW/YuiaQbeNCzNGYkv0kMR
         aEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMvwbbhDMLXPJcLx4ix6M21d2hkYUP1GACJZYqvTnTA=;
        b=Bo8K9ofP1TZ5F9AV2f8GHMkDWR6tGhliu8O1614FKMy5XjMLjzxTpyh5055giaTztV
         mRsOMzBFR+7uEfr4nlvgtHlwyVlfIxXlRz/JUQ9tT5KslkEGgfzN7nzmQKXwbYk/ekaq
         qbb+F6AT63JCZQ1IoG+s1LF/0qAe9ixFWMvg+K1pITQUtxTib0VYdYyGvSyDmXDhGUEs
         bJYCZI86+fSTbEfhh84ndS+/E68ffBFkCMBfLBFJJ2UNobvhtHxJKbhpbupx+mhidsV4
         0yfrG8xKr4LzdxPwkbPMtOYKkLGJFPcjeOXfXYFOpYBKjWAu3qCcQHQMrpafblQGDSR3
         Mdqw==
X-Gm-Message-State: APjAAAWcgN9ntjqmqHvhjjK4lt2o5Jshth8ZE9xQ0N2XBXT6K0UQx1sy
        wxxOY1mULLpeR+sKnbHr45QnfZ4K6xxay/+GpL4wjB3D
X-Google-Smtp-Source: APXvYqwMdtCUYisI7Ao3Ju+RgC0O5Hf/Bx6dDtgQQQTgC70heZjuQTXpiKjTCAUIPXdbnfhMQEkrX8GtNPdG2qKKH8g=
X-Received: by 2002:a19:7401:: with SMTP id v1mr6920497lfe.129.1578815221443;
 Sat, 11 Jan 2020 23:47:01 -0800 (PST)
MIME-Version: 1.0
References: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
 <09e8a682-3f91-6b34-58a0-235dbb130901@cloud.ionos.com> <CAGRgLy4netkysnF6CS2MkVBp17ipZr5D4Z4wQ6B0w2XXg51OkQ@mail.gmail.com>
In-Reply-To: <CAGRgLy4netkysnF6CS2MkVBp17ipZr5D4Z4wQ6B0w2XXg51OkQ@mail.gmail.com>
From:   Alexander Lyakas <alex.bolshoy@gmail.com>
Date:   Sun, 12 Jan 2020 09:46:49 +0200
Message-ID: <CAGRgLy6xx5dT0StoiUNLThVknLvNUR5Emc0mEg_dnJmWth3=9A@mail.gmail.com>
Subject: Re: hung-task panic in raid5_make_request
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, liu.song.a23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Guoqing,

We have tried the proposed patch, but still hit the hung-task panic in
the same place[1]. How can we debug this further?

Thanks,
Alex.

[1]
Jan 12 00:16:11.183134 vsa-00000014-vc-1 kernel: [387258.853460] INFO:
task kworker/u8:4:9259 blocked for more than 600 seconds.
Jan 12 00:16:11.183159 vsa-00000014-vc-1 kernel: [387258.854200]
Tainted: G           OE   4.14.99-zadara02 #1
Jan 12 00:16:11.183162 vsa-00000014-vc-1 kernel: [387258.854802] "echo
0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan 12 00:16:11.183978 vsa-00000014-vc-1 kernel: [387258.855654]
kworker/u8:4    D    0  9259      2 0x80000000
Jan 12 00:16:11.185698 vsa-00000014-vc-1 kernel: [387258.856953] Call Trace:
Jan 12 00:16:11.185700 vsa-00000014-vc-1 kernel: [387258.857368]  ?
__schedule+0x290/0x8a0
Jan 12 00:16:11.186907 vsa-00000014-vc-1 kernel: [387258.857805]  ?
blk_flush_plug_list+0xc1/0x250
Jan 12 00:16:11.186917 vsa-00000014-vc-1 kernel: [387258.858240]
schedule+0x2f/0x90
Jan 12 00:16:11.186919 vsa-00000014-vc-1 kernel: [387258.858584]
raid5_make_request+0x1b7/0xb10 [raid456]
Jan 12 00:16:11.187833 vsa-00000014-vc-1 kernel: [387258.859145]  ?
wait_woken+0x80/0x80
Jan 12 00:16:11.187842 vsa-00000014-vc-1 kernel: [387258.859506]  ?
wait_woken+0x80/0x80
Jan 12 00:16:11.188731 vsa-00000014-vc-1 kernel: [387258.859907]
md_handle_request+0x131/0x1a0 [md_mod]
Jan 12 00:16:11.188739 vsa-00000014-vc-1 kernel: [387258.860410]
md_make_request+0x65/0x170 [md_mod]
Jan 12 00:16:11.189658 vsa-00000014-vc-1 kernel: [387258.860902]
generic_make_request+0x123/0x320
Jan 12 00:16:11.190785 vsa-00000014-vc-1 kernel: [387258.861367]  ?
submit_bio+0x6c/0x140
Jan 12 00:16:11.190794 vsa-00000014-vc-1 kernel: [387258.861744]
submit_bio+0x6c/0x140
Jan 12 00:16:11.190796 vsa-00000014-vc-1 kernel: [387258.862066]  ?
kvm_clock_read+0x21/0x40
Jan 12 00:16:11.190797 vsa-00000014-vc-1 kernel: [387258.862463]  ?
ktime_get+0x3e/0xa0
...

(gdb) l *raid5_make_request+0x1b7
0xa6a7 is in raid5_make_request (./include/linux/compiler.h:183).
178     })
179
180     static __always_inline
181     void __read_once_size(const volatile void *p, void *res, int size)
182     {
183             __READ_ONCE_SIZE;
184     }
185
186     #ifdef CONFIG_KASAN
187     /*


On Sun, Jan 5, 2020 at 10:16 AM Alexander Lyakas <alex.bolshoy@gmail.com> wrote:
>
> Hi Guoqing,
>
> Thank you for your response. We will try this patch and let you know.
>
> Thanks,
> Alex.
>
>
> On Mon, Dec 30, 2019 at 12:20 PM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
> >
> >
> >
> > On 12/24/19 9:18 PM, Alexander Lyakas wrote:
> > > Greetings,
> > >
> > > We are hitting the following hung-task panic[1] with raid5 in kernel
> > > 4.14.99. It is happening every couple of days.
> > >
> > > The raid5 in question contains three devices and has been created with command:
> > > mdadm --create /dev/md5 --force  --raid-devices=3 --size=1522566M
> > > --chunk=64 --level=raid5 --bitmap=internal --name=5
> > > --uuid=47952090192D4408BDABC9628E16FD06 --run --auto=md --metadata=1.2
> > > --homehost=zadara_vc --verbose --verbose /dev/dm-13 /dev/dm-14
> > > /dev/dm-15
> > >
> > > The array is not undergoing any kind of rebuild or reshape.
> > >
> > > Similar issue for kernel 4.14.37 was reported in
> > > https://bugzilla.kernel.org/show_bug.cgi?id=199539.
> > >
> > > We recently moved to kernel 4.14 (long term kernel) from kernel 3.18.
> > > With kernel 3.18 we haven't seen this issue.
> > >
> > > Looking at the code, raid5_make_request seems to be stuck waiting for
> > > a free stripe via raid5_make_request => raid5_get_active_stripe =>
> > > wait_event_lock_irq().
> > > Looking with gdb:
> > >
> > > (gdb) l *raid5_make_request+0x1b7
> > > 0xa697 is in raid5_make_request (./include/linux/compiler.h:183).
> > > 178     })
> > > 179
> > > 180     static __always_inline
> > > 181     void __read_once_size(const volatile void *p, void *res, int size)
> > > 182     {
> > > 183             __READ_ONCE_SIZE;
> > > 184     }
> > > 185
> > > 186     #ifdef CONFIG_KASAN
> > > 187     /*
> > >
> > > The READ_ONCE call seems to be used by list_empty, which is called
> > > from wait_event_lock_irq [2]
> > >
> > > How can this be debugged further?
> > >
> > > Thanks,
> > > Alex.
> > >
> > > [1]
> > > [155653.946408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [155653.947333] kworker/u4:94   D    0  6178      2 0x80000000
> > > [155653.949159] Call Trace:
> > > [155653.949576]  ? __schedule+0x290/0x8a0
> > > [155653.950052]  ? blk_flush_plug_list+0xc1/0x250
> > > [155653.950688]  schedule+0x2f/0x90
> > > [155653.951173]  raid5_make_request+0x1b7/0xb10 [raid456]
> > > [155653.951765]  ? wait_woken+0x80/0x80
> > > [155653.952216]  ? wait_woken+0x80/0x80
> > > [155653.952673]  md_handle_request+0x131/0x1a0 [md_mod]
> > > [155653.953310]  md_make_request+0x65/0x170 [md_mod]
> > > [155653.953963]  generic_make_request+0x123/0x320
> > > [155653.954473]  ? submit_bio+0x6c/0x140
> > > [155653.954981]  submit_bio+0x6c/0x140
> > >
> > > [2]
> > >
> > > if (!sh) {
> > > set_bit(R5_INACTIVE_BLOCKED,
> > > &conf->cache_state);
> > > r5l_wake_reclaim(conf->log, 0);
> > > wait_event_lock_irq(
> > > conf->wait_for_stripe,
> > > !list_empty(conf->inactive_list + hash) &&
> > > (atomic_read(&conf->active_stripes)
> > > < (conf->max_nr_stripes * 3 / 4)
> > > || !test_bit(R5_INACTIVE_BLOCKED,
> > >       &conf->cache_state)),
> > > *(conf->hash_locks + hash));
> >
> > Assuming the hung is due to empty inactive_list,  can you try the change?
> >
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index f0fc538bfe59..897dd167b8d4 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -655,6 +655,7 @@ raid5_get_active_stripe(struct r5conf *conf,
> > sector_t sector,
> >                                  set_bit(R5_INACTIVE_BLOCKED,
> >                                          &conf->cache_state);
> >                                  r5l_wake_reclaim(conf->log, 0);
> > + md_wakeup_thread(conf->mddev->thread);
> >                                  wait_event_lock_irq(
> >                                          conf->wait_for_stripe,
> > !list_empty(conf->inactive_list + hash) &&
> >
> >
> > Thanks,
> > Guoqing
