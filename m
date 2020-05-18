Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E467E1D8BEA
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgERXzj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 19:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgERXzj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 18 May 2020 19:55:39 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF32A2067D
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 23:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589846138;
        bh=uDk0pIOuuilxs7TNpybpbl/7WLzG26FUWteCVYXF3ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j4dh+KMcrW1VUbWNS3RPrIERGRSncKjQMRdMFAl7xcrCN0OSZbIgoUGzT4tS3visy
         jJeEIhC8wn5DSGD31aj1rt74ezMv/xVOQF5uxUoecWZQYv+cGYqdW0fBZQt2lbnWef
         ycKVI+VHb1CDGpBG9AsB04qC5x+qustYqbxBqHe8=
Received: by mail-lf1-f44.google.com with SMTP id h188so9653155lfd.7
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 16:55:37 -0700 (PDT)
X-Gm-Message-State: AOAM531K96f3wCFJhQHbX0qdnfxpknQnQMQRZazf6vG/dNZVLDxwQ0EP
        AhY7q6oMAdrgO4FKjSbW9IuPQS8HFkLZzfTFzw4=
X-Google-Smtp-Source: ABdhPJzw3pEodU8FVtvrEiC0Q0nY61ARccjAWGFBBk9TXiNe0/vV3wrjbQtwr9QgBYFmvs0zHP6oDhPeh+y9ri3GPPQ=
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr5352856lfg.33.1589846136061;
 Mon, 18 May 2020 16:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl> <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl> <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl>
In-Reply-To: <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Mon, 18 May 2020 16:55:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
Message-ID: <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 18, 2020 at 4:43 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 5/16/20 2:15 AM, Song Liu wrote:
> > On Thu, May 14, 2020 at 4:07 AM Michal Soltys <msoltyspl@yandex.pl> wro=
te:
> >>
> >> On 5/13/20 6:17 PM, Song Liu wrote:
> >>>>>
> >>>>> Are these captured back to back? I am asking because they showed di=
fferent
> >>>>> "Events" number.
> >>>>
> >>>> Nah, they were captured between reboots. Back to back all event fiel=
ds show identical value (at 56291 now).
> >>>>
> >>>>>
> >>>>> Also, when mdadm -A hangs, could you please capture /proc/$(pidof m=
dadm)/stack ?
> >>>>>
> >>>>
> >>>> The output is empty:
> >>>>
> >>>> xs22:/=E2=98=A0 ps -eF fww | grep mdadm
> >>>> root     10332  9362 97   740  1884  25 12:47 pts/1    R+     6:59  =
|   \_ mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdi1 /dev/sdg1 /=
dev/sdj1 /dev/sdh1
> >>>> xs22:/=E2=98=A0 cd /proc/10332
> >>>> xs22:/proc/10332=E2=98=A0 cat stack
> >>>> xs22:/proc/10332=E2=98=A0
> >>>
> >>> Hmm... Could you please share the strace output of "mdadm -A" command=
? Like
> >>>
> >>> strace mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/xxx ...
> >>>
> >>> Thanks,
> >>> Song
> >>
> >> I did one more thing - ran cat on that stack in another terminal every
> >> 0.1 seconds, this is what was found:
> >>
> >> cat: /proc//stack: No such file or directory
> >> cat: /proc//stack: No such file or directory
> >> cat: /proc//stack: No such file or directory
> >> [<0>] submit_bio_wait+0x5b/0x80
> >> [<0>] r5l_recovery_read_page+0x1b6/0x200 [raid456]
> >> [<0>] r5l_recovery_verify_data_checksum+0x19/0x70 [raid456]
> >> [<0>] r5l_start+0x99e/0xe70 [raid456]
> >> [<0>] md_start.part.48+0x2e/0x50 [md_mod]
> >> [<0>] do_md_run+0x64/0x100 [md_mod]
> >> [<0>] md_ioctl+0xe7d/0x17d0 [md_mod]
> >> [<0>] blkdev_ioctl+0x4d0/0xa00
> >> [<0>] block_ioctl+0x39/0x40
> >> [<0>] do_vfs_ioctl+0xa4/0x630
> >> [<0>] ksys_ioctl+0x60/0x90
> >> [<0>] __x64_sys_ioctl+0x16/0x20
> >> [<0>] do_syscall_64+0x52/0x160
> >> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> cat: /proc//stack: No such file or directory
> >> [<0>] submit_bio_wait+0x5b/0x80
> >> [<0>] r5l_recovery_read_page+0x1b6/0x200 [raid456]
> >> [<0>] r5l_recovery_verify_data_checksum+0x19/0x70 [raid456]
> >> [<0>] r5l_start+0x99e/0xe70 [raid456]
> >> [<0>] md_start.part.48+0x2e/0x50 [md_mod]
> >> [<0>] do_md_run+0x64/0x100 [md_mod]
> >> [<0>] md_ioctl+0xe7d/0x17d0 [md_mod]
> >> [<0>] blkdev_ioctl+0x4d0/0xa00
> >> [<0>] block_ioctl+0x39/0x40
> >> [<0>] do_vfs_ioctl+0xa4/0x630
> >> [<0>] ksys_ioctl+0x60/0x90
> >> [<0>] __x64_sys_ioctl+0x16/0x20
> >> [<0>] do_syscall_64+0x52/0x160
> >> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> cat: /proc//stack: No such file or directory
> >> cat: /proc//stack: No such file or directory
> >> cat: /proc//stack: No such file or directory
> >> cat: /proc//stack: No such file or directory
> >>
> >>
> >> Strace output attached.
> >
> > So mdadm hangs at "ioctl(4, RUN_ARRAY", right?
> >
>
> Yes, it's consistent across attempts.
>
> > Does /proc/<pid of hanging mdadm>/stack always shows the same output ab=
ove?
>
> Having peeked closer - it actually tries to do something somehow -
> attached the stack file dumped every ~0.01 seconds.
>
> After a while I can hit non-empty cat /proc/<pid>/stack every 5-15
> seconds this way.
>
> At one point "hanged" mdadm has been running this way for 24hr+ without
> any practical effect in the end.
>

Thanks for these information.

It looks like the kernel had some issue in recovery. Could you please
try the following:

1. check dmesg, we should see one of the following at some point:
    pr_info("md/raid:%s: starting from clean shutdown\n",
or
    pr_info("md/raid:%s: recovering %d data-only stripes and %d
data-parity stripes\n",

2. try use bcc/bpftrace to trace r5l_recovery_read_page(),
specifically, the 4th argument.
With bcc, it is something like:

    trace.py -M 100 'r5l_recovery_read_page() "%llx", arg4'

-M above limits the number of outputs to 100 lines. We may need to
increase the limit or
remove the constraint. If the system doesn't have bcc/bpftrace. You
can also try with
kprobe.

Thanks,
Song
