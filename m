Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF029D89
	for <lists+linux-raid@lfdr.de>; Fri, 24 May 2019 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfEXRxP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 May 2019 13:53:15 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:36039 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEXRxP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 May 2019 13:53:15 -0400
Received: by mail-qk1-f182.google.com with SMTP id o2so8458346qkb.3
        for <linux-raid@vger.kernel.org>; Fri, 24 May 2019 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud9kniMWGSThwyhq5HZheWjPQg1uQUGIQN/DUVgfYOw=;
        b=q7yEPo3voGla4qyxI8sHH8OmKStUQUyxt358BaL9etW3fVxJXphRwVoAce5A8W+Q8o
         tvQuE6kv9UKKsJ4KpNQB3gwU4a8DfZi3+iWvICvdaiNTHH92TodrGXCN9z3a7ALhkPlm
         78PII4ZqjGm7ndEvNkKu13gR2JxWELfpo9LrByywO1bL+PjGxJTeS53nCUYt3r4sAfOh
         vtaEqQFdR82Fylbh/dka+7qmiX6dBJZqMbdO0GAKnHy7oFudQjFTynpJpzLMKCplh7ca
         hDaWm2Wl8XrUCZCqXISOZbehU77H3K+kp0MzyIettSmisLCR41QxWUerwX3eL+XgOLXF
         tfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud9kniMWGSThwyhq5HZheWjPQg1uQUGIQN/DUVgfYOw=;
        b=Uf9nM4UUcXdvR9p1AilrzlEmpNmSWGcVOrVQKfBgSvQ9WVOt8nXkDrHw4Q3H6ODG6o
         wCYGDxQbZSdaGEsXwEQD7V4aaj1ao70/WQf+zg/4rrTmLnRlB9xVPnbHcFEIXBIu1NQp
         8Ra3aDR/Kgiae+/8xTRcdOTTipBHM2sNuXz3kYDM16H4mgkv9INH4WgMLi8IOeElMR1V
         jBvOy5bSxoEEW5UkCzwuM/GinA96KPBakUs1RpVUVevDkK4mIsz7VawjSANvSvrEnM6K
         qaeNfLB5ms0ZAHMib0qzgPe5io3dgc6ULWMK0W5E85fh37Al25V7QSBjBjg1xXmM69Qw
         B9RA==
X-Gm-Message-State: APjAAAWajds50VIo7MxZ8fMkSDxI1xxmJJj3sePn9zGAi6YHJJUGNnP3
        1SEUiYgwdx+9a6c5z1K/kxWI7tqTfYT1BkxLQcunWA==
X-Google-Smtp-Source: APXvYqxNH0kQI6lLsZgCo6FNz/gkeg6Ql6kXMT9lFB3VhlbV9vJJdqkA4ENRpHtK9a1smUaaHZPe4zinpoi/48K5Ikc=
X-Received: by 2002:ae9:f819:: with SMTP id x25mr3307308qkh.202.1558720394334;
 Fri, 24 May 2019 10:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <69b2ca6b-2ccb-db3b-1fde-62e5b7483293@thorsten-knabe.de>
 <CAPhsuW5Fvd0i-ezmsEpr977kiNfvdTKb5ZXTOi2D1oN5HdXP0w@mail.gmail.com>
 <CAPhsuW4==2vgsmTvd070yjjLtOj38B9kxFv5b-FMpQO+_+XVKA@mail.gmail.com> <9b77d8ac-28d2-8822-5662-f626f71223a4@thorsten-knabe.de>
In-Reply-To: <9b77d8ac-28d2-8822-5662-f626f71223a4@thorsten-knabe.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 24 May 2019 10:53:03 -0700
Message-ID: <CAPhsuW5BA959k9EpvA9Cv6C_A5HQFN7HT2P-BWQcfKssMWFtPQ@mail.gmail.com>
Subject: Re: BUG: RAID6 recovery broken by commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef
 (Linux 5.1.3)
To:     Thorsten Knabe <linux@thorsten-knabe.de>
Cc:     Shaohua Li <shli@kernel.org>, Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, May 24, 2019 at 1:11 AM Thorsten Knabe <linux@thorsten-knabe.de> wrote:
>
> On 5/22/19 8:24 PM, Song Liu wrote:
> > Hi Thorsten,
> >
> > On Wed, May 22, 2019 at 9:19 AM Song Liu <liu.song.a23@gmail.com> wrote:
> >>
> >> Hi Thorsten,
> >>
> >> Thanks for the report. I will follow up with stable@ to fix them.
> >>
> >> Best regards,
> >> Song
> >
> > Could you please confirm the follow patches fixes the issue?
> >
> > commit a25d8c327bb4 ("Revert "Don't jump to compute_result state from
> > check_result state"")
> > commit b2176a1dfb51 ("md/raid: raid5 preserve the writeback action
> > after the parity check")
>
> Hello Song.
>
> With the two patches applied to Linux 5.1.4 I was not able to reproduce
> the previously observed file system and data corruptions by replacing a
> disk of a RAID6 array.
>
> Thorsten

Thanks for testing the fix!

Song

>
> >
> > Thanks,
> > Song
> >
> >
> >>
> >> On Wed, May 22, 2019 at 5:26 AM Thorsten Knabe <linux@thorsten-knabe.de> wrote:
> >>>
> >>> Hello.
> >>>
> >>> BUG: RAID6 recovery broken by commit
> >>> 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3+)
> >>>
> >>> Replacing a failed disk of a MD RAID6 array causes file system
> >>> corruption and data loss on kernels containing commit
> >>> 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef.
> >>>
> >>> Affected kernels: 5.1.3, 5.1.4 possibly others.
> >>> Unaffected kernels: 5.1.2
> >>>
> >>> OS: Debian stretch amd64
> >>>
> >>> Steps to reproduce the BUG:
> >>>
> >>> 1. Create a new 4-disk RAID6 array, create a file system and mount it:
> >>>    mdadm /dev/md0 --create -l 6 -n 4 /dev/sd[bcde]
> >>>    mkfs.ext4 /dev/md0
> >>>    mount /dev/md0 /mnt
> >>> 2. Store some data (a few GB should be fine) on the RAID6 arrays file
> >>> system:
> >>>    cp -r whatever /mnt
> >>> 3. Fail a disk of the RAID6 array and remove it from the array:
> >>>    mdadm /dev/md0 --fail /dev/sdd
> >>>    mdadm /dev/md0 --remove /dev/sdd
> >>> 4. Drop caches:
> >>>    echo "3" > /proc/sys/vm/drop_caches
> >>> 5. Compare data copied to the RAID6 array in step 2 with its source:
> >>>    diff -r whatever /mnt/whatever
> >>>    There should be no differences and no file system errors.
> >>> 6. Add a new empty disk to the RAID6 array:
> >>>    mdadm /dev/md0 --add /dev/sdf
> >>> 7. RAID6 recovery should start now, wait for the RAID6 recovery to finish.
> >>> 8. Drop caches again:
> >>>    echo "3" > /proc/sys/vm/drop_caches
> >>> 9. Compare data copied to the RAID6 array in step 2 with its source again:
> >>>    diff -r whatever /mnt/whatever
> >>>    diff now reports a lot of differences and the kernel log gets filled
> >>> with file system errors. For example:
> >>>    EXT4-fs warning (device md0): ext4_dirent_csum_verify:355: inode
> >>> #918549: comm diff: No space for directory leaf checksum. Please run
> >>> e2fsck -D.
> >>>
> >>> Reverting commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef from kernel
> >>> 5.1.4 resolves the issues described above.
> >>>
> >>> Kind regards
> >>> Thorsten
> >>>
> >>>
> >>> --
> >>> ___
> >>>  |        | /                 E-Mail: linux@thorsten-knabe.de
> >>>  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
> >>>
>
>
> --
> ___
>  |        | /                 E-Mail: linux@thorsten-knabe.de
>  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
