Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734C81306C3
	for <lists+linux-raid@lfdr.de>; Sun,  5 Jan 2020 09:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgAEIQp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 Jan 2020 03:16:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37551 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgAEIQp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 Jan 2020 03:16:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so34481283lfc.4
        for <linux-raid@vger.kernel.org>; Sun, 05 Jan 2020 00:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9STrj7eVLPOwb8pX1+0eSrD8b7RqZo0HEqKqGu36TPQ=;
        b=FN3XsKjB+TQVoDBBdMUdkx9y7S+QdcT1iU2Occt3n4WqY5nUO4HDXpVxYF2W4xG8wL
         qntVfTLv4vUfLeUsQBHXELts3rn9GghVUx9wAzKKKXsVL1yQyLvoO5JVSjoTVyl0xh/O
         Vnc40psKE+5yHaqy83BaAXpFPUxPq9W5HQ7j7BR8K1xUnSPIRIlGMsox/JHxI01B4fvd
         mNgy3vv9tp7NBlilO4j2UM2cnFbixQFVLHLtptM06GtUEUCjCpwIhngk232eenQ0aYq5
         Z1IDkDVn7LmqBfUr/FcKAefoH46JtAtNM+J7YTkDo/TUREp86yxprDgbSvp6gE3ImYGr
         J1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9STrj7eVLPOwb8pX1+0eSrD8b7RqZo0HEqKqGu36TPQ=;
        b=AK/DTVIfyLwxi0JKe8eSOhakN5fEgSbyYItJ8nfpKZh55iUVUlZUR0BPQp8BLJ7szU
         Tm0ZNV1mZ5J/3ammMoBiL9XxwwnMcnggcIZPixYesoy8BghKM9SGUNVWzM6OpOfLEI3E
         tUBYvxDlmao3i8HA6sjbJk4b95yxvdpZwUaB4Yxal4gGRZkHeyDgon3M6uXpyI3uq2dL
         +FiwJEizjM3UFfQIPjPASLAMQZJLTdf9zVRfnvEZ4hDnxlQkVGH9fmQtRJDnVSZ5oiRs
         1oWe9i5eBs0ED3pn3RrQvp2TUt/DBfBUVEiK6ULuR3pHX7RQdfOrPDwI+nFOAzgzfwXK
         vaaQ==
X-Gm-Message-State: APjAAAVbs9iqg2NU+uA0lhbLQk4qUnPANTAgTCs08zynZl3ROHltEjqd
        lWXx96NSZ/RmUobg+IfTKtou/34DT8hxFqs1gug=
X-Google-Smtp-Source: APXvYqwbMNeE7gx6XWJ1EwKwDnMHdTaRzXXRi+I5cORUJmXwFwsygC3LnZ1nB1rNrefxEtfWVGQDVAe45wGbM3B/zDo=
X-Received: by 2002:ac2:4476:: with SMTP id y22mr54308732lfl.169.1578212203604;
 Sun, 05 Jan 2020 00:16:43 -0800 (PST)
MIME-Version: 1.0
References: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
 <09e8a682-3f91-6b34-58a0-235dbb130901@cloud.ionos.com>
In-Reply-To: <09e8a682-3f91-6b34-58a0-235dbb130901@cloud.ionos.com>
From:   Alexander Lyakas <alex.bolshoy@gmail.com>
Date:   Sun, 5 Jan 2020 10:16:31 +0200
Message-ID: <CAGRgLy4netkysnF6CS2MkVBp17ipZr5D4Z4wQ6B0w2XXg51OkQ@mail.gmail.com>
Subject: Re: hung-task panic in raid5_make_request
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, liu.song.a23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Guoqing,

Thank you for your response. We will try this patch and let you know.

Thanks,
Alex.


On Mon, Dec 30, 2019 at 12:20 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 12/24/19 9:18 PM, Alexander Lyakas wrote:
> > Greetings,
> >
> > We are hitting the following hung-task panic[1] with raid5 in kernel
> > 4.14.99. It is happening every couple of days.
> >
> > The raid5 in question contains three devices and has been created with command:
> > mdadm --create /dev/md5 --force  --raid-devices=3 --size=1522566M
> > --chunk=64 --level=raid5 --bitmap=internal --name=5
> > --uuid=47952090192D4408BDABC9628E16FD06 --run --auto=md --metadata=1.2
> > --homehost=zadara_vc --verbose --verbose /dev/dm-13 /dev/dm-14
> > /dev/dm-15
> >
> > The array is not undergoing any kind of rebuild or reshape.
> >
> > Similar issue for kernel 4.14.37 was reported in
> > https://bugzilla.kernel.org/show_bug.cgi?id=199539.
> >
> > We recently moved to kernel 4.14 (long term kernel) from kernel 3.18.
> > With kernel 3.18 we haven't seen this issue.
> >
> > Looking at the code, raid5_make_request seems to be stuck waiting for
> > a free stripe via raid5_make_request => raid5_get_active_stripe =>
> > wait_event_lock_irq().
> > Looking with gdb:
> >
> > (gdb) l *raid5_make_request+0x1b7
> > 0xa697 is in raid5_make_request (./include/linux/compiler.h:183).
> > 178     })
> > 179
> > 180     static __always_inline
> > 181     void __read_once_size(const volatile void *p, void *res, int size)
> > 182     {
> > 183             __READ_ONCE_SIZE;
> > 184     }
> > 185
> > 186     #ifdef CONFIG_KASAN
> > 187     /*
> >
> > The READ_ONCE call seems to be used by list_empty, which is called
> > from wait_event_lock_irq [2]
> >
> > How can this be debugged further?
> >
> > Thanks,
> > Alex.
> >
> > [1]
> > [155653.946408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [155653.947333] kworker/u4:94   D    0  6178      2 0x80000000
> > [155653.949159] Call Trace:
> > [155653.949576]  ? __schedule+0x290/0x8a0
> > [155653.950052]  ? blk_flush_plug_list+0xc1/0x250
> > [155653.950688]  schedule+0x2f/0x90
> > [155653.951173]  raid5_make_request+0x1b7/0xb10 [raid456]
> > [155653.951765]  ? wait_woken+0x80/0x80
> > [155653.952216]  ? wait_woken+0x80/0x80
> > [155653.952673]  md_handle_request+0x131/0x1a0 [md_mod]
> > [155653.953310]  md_make_request+0x65/0x170 [md_mod]
> > [155653.953963]  generic_make_request+0x123/0x320
> > [155653.954473]  ? submit_bio+0x6c/0x140
> > [155653.954981]  submit_bio+0x6c/0x140
> >
> > [2]
> >
> > if (!sh) {
> > set_bit(R5_INACTIVE_BLOCKED,
> > &conf->cache_state);
> > r5l_wake_reclaim(conf->log, 0);
> > wait_event_lock_irq(
> > conf->wait_for_stripe,
> > !list_empty(conf->inactive_list + hash) &&
> > (atomic_read(&conf->active_stripes)
> > < (conf->max_nr_stripes * 3 / 4)
> > || !test_bit(R5_INACTIVE_BLOCKED,
> >       &conf->cache_state)),
> > *(conf->hash_locks + hash));
>
> Assuming the hung is due to empty inactive_list,  can you try the change?
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index f0fc538bfe59..897dd167b8d4 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -655,6 +655,7 @@ raid5_get_active_stripe(struct r5conf *conf,
> sector_t sector,
>                                  set_bit(R5_INACTIVE_BLOCKED,
>                                          &conf->cache_state);
>                                  r5l_wake_reclaim(conf->log, 0);
> + md_wakeup_thread(conf->mddev->thread);
>                                  wait_event_lock_irq(
>                                          conf->wait_for_stripe,
> !list_empty(conf->inactive_list + hash) &&
>
>
> Thanks,
> Guoqing
