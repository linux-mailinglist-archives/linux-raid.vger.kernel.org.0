Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66F1D5D1C
	for <lists+linux-raid@lfdr.de>; Sat, 16 May 2020 02:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEPAQH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 20:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgEPAQH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 15 May 2020 20:16:07 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20626206C0
        for <linux-raid@vger.kernel.org>; Sat, 16 May 2020 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589588166;
        bh=8OEhue/AmfQUDjaUq8eBbIa478Nmj2Q/lEja40kDZa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G6gNH9/uSjkWkwUydeLyVHdgBxEPqfaCrJN+mR0+rEb2lV6EOxGRdaxDX2K7lik8q
         MT95EgPKAa1AWtajaBAztoiJKgddWLABSHFesgw0ZA7ZdyCKnrX+EJxQIZZ4K53w3P
         wTWJiHQGImaXg7AWHjLtisEYLWzsFGgZZBYHrqTM=
Received: by mail-lf1-f46.google.com with SMTP id e125so2485660lfd.1
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 17:16:06 -0700 (PDT)
X-Gm-Message-State: AOAM531hRWRVMbrCT6xk6hRbBA0MRW147sAhVJ6UUHAcFT19DyKa8UMY
        lx4k4qirSDL5Qh0RvFOIyi/uruWyY5IQ2wCcbJc=
X-Google-Smtp-Source: ABdhPJxYBo9P/u3huLpDlecztOIV9C07Crt0NfPZ19VFTrcFHUpcYNTTCrtBZmFtM3k7sPVwwERvyi/M5FdAwm0Voio=
X-Received: by 2002:ac2:5628:: with SMTP id b8mr3709852lff.172.1589588164239;
 Fri, 15 May 2020 17:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl> <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
In-Reply-To: <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Fri, 15 May 2020 17:15:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
Message-ID: <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 14, 2020 at 4:07 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 5/13/20 6:17 PM, Song Liu wrote:
> >>>
> >>> Are these captured back to back? I am asking because they showed diff=
erent
> >>> "Events" number.
> >>
> >> Nah, they were captured between reboots. Back to back all event fields=
 show identical value (at 56291 now).
> >>
> >>>
> >>> Also, when mdadm -A hangs, could you please capture /proc/$(pidof mda=
dm)/stack ?
> >>>
> >>
> >> The output is empty:
> >>
> >> xs22:/=E2=98=A0 ps -eF fww | grep mdadm
> >> root     10332  9362 97   740  1884  25 12:47 pts/1    R+     6:59  | =
  \_ mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdi1 /dev/sdg1 /de=
v/sdj1 /dev/sdh1
> >> xs22:/=E2=98=A0 cd /proc/10332
> >> xs22:/proc/10332=E2=98=A0 cat stack
> >> xs22:/proc/10332=E2=98=A0
> >
> > Hmm... Could you please share the strace output of "mdadm -A" command? =
Like
> >
> > strace mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/xxx ...
> >
> > Thanks,
> > Song
>
> I did one more thing - ran cat on that stack in another terminal every
> 0.1 seconds, this is what was found:
>
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
> [<0>] submit_bio_wait+0x5b/0x80
> [<0>] r5l_recovery_read_page+0x1b6/0x200 [raid456]
> [<0>] r5l_recovery_verify_data_checksum+0x19/0x70 [raid456]
> [<0>] r5l_start+0x99e/0xe70 [raid456]
> [<0>] md_start.part.48+0x2e/0x50 [md_mod]
> [<0>] do_md_run+0x64/0x100 [md_mod]
> [<0>] md_ioctl+0xe7d/0x17d0 [md_mod]
> [<0>] blkdev_ioctl+0x4d0/0xa00
> [<0>] block_ioctl+0x39/0x40
> [<0>] do_vfs_ioctl+0xa4/0x630
> [<0>] ksys_ioctl+0x60/0x90
> [<0>] __x64_sys_ioctl+0x16/0x20
> [<0>] do_syscall_64+0x52/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> cat: /proc//stack: No such file or directory
> [<0>] submit_bio_wait+0x5b/0x80
> [<0>] r5l_recovery_read_page+0x1b6/0x200 [raid456]
> [<0>] r5l_recovery_verify_data_checksum+0x19/0x70 [raid456]
> [<0>] r5l_start+0x99e/0xe70 [raid456]
> [<0>] md_start.part.48+0x2e/0x50 [md_mod]
> [<0>] do_md_run+0x64/0x100 [md_mod]
> [<0>] md_ioctl+0xe7d/0x17d0 [md_mod]
> [<0>] blkdev_ioctl+0x4d0/0xa00
> [<0>] block_ioctl+0x39/0x40
> [<0>] do_vfs_ioctl+0xa4/0x630
> [<0>] ksys_ioctl+0x60/0x90
> [<0>] __x64_sys_ioctl+0x16/0x20
> [<0>] do_syscall_64+0x52/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
>
>
> Strace output attached.

So mdadm hangs at "ioctl(4, RUN_ARRAY", right?

Does /proc/<pid of hanging mdadm>/stack always shows the same output above?

Thanks,
Song
