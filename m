Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DCD269C8
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2019 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfEVSY3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 May 2019 14:24:29 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37163 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSY3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 May 2019 14:24:29 -0400
Received: by mail-qk1-f182.google.com with SMTP id d10so2136022qko.4
        for <linux-raid@vger.kernel.org>; Wed, 22 May 2019 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQnLl8zyVYsHdOafSnwyLC4DgoZNxcS4mBNl/rQNoLQ=;
        b=C+78s634AD6BWv9DvwvsxVHcynPJK2fUMkLyDeql+9EVK0KJitRERqYNI4jKRWYifv
         fChLUlyigf+j3UfZcGYcTbktwK02M0ApAu1cNx0M7nzycF/XVh0xa4N92BRYi7y/4o6/
         2YP6sVJRX39faYTGYozgywbhpJ1shLPeWCDnDcqlQEDxRnmezBodC4ovsL8sez8dRJRW
         TsvEbPnZMSoFAL2x+ruKQkt21YzWsL24sM/kGDN34jV9aflDdxTf+mtxwOGcPSnw/neP
         eZGe0x497WT5OmYBzGYxaoetADSCniY3WOLIKTJ4RBvdP6ZN32CyGubJu0SUjjMtAwcH
         3A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQnLl8zyVYsHdOafSnwyLC4DgoZNxcS4mBNl/rQNoLQ=;
        b=XEJ2LvJEDdLoaIkf5DK9H4zX/Af9dysucnm2+6EwhqFUpnY809rGdzL+yD7N4FYc6P
         1HqzyEqKQJFt4nESnhnaF7N2pNhKu8KRz6yINJKWhNjev8njzQczxzn70ZVt7IeDskXL
         sqt3TUk1CtQtIFY+YqmxddTxlU4flQVre8tWiXEejQmsYGzFKDIbQ5dsRl4/2lZMpmeV
         dDuaPVKYzHJh5xdyq51tc3Lvb3VLPeUEZSn4jG97XsAFofXhmS7HhY1uqThJur+Xgtk3
         NaWoMGh70Ukmpe6jyywnYS/DHD+hEGgqJD7of68b0B3eqJdyPAH3c23rjzE73dLBzUlS
         L3DQ==
X-Gm-Message-State: APjAAAXwdilh5oMT4OghLjXLqpxOU1EPeAyIXM2LiW62U/qgz8UNvo5p
        hQqBpKoMVxkpY2G5xDzBQoGBjZKo6LmEHXV3+J4=
X-Google-Smtp-Source: APXvYqzAn7MojDUuqcDADqkzNDKAvf9gL+5q4UlqHrSUl7Wp54TqoJGpJoFcelhGa5WDj3JXFX/gbYcDY10te/tXB7A=
X-Received: by 2002:a37:a456:: with SMTP id n83mr3509984qke.31.1558549468590;
 Wed, 22 May 2019 11:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <69b2ca6b-2ccb-db3b-1fde-62e5b7483293@thorsten-knabe.de> <CAPhsuW5Fvd0i-ezmsEpr977kiNfvdTKb5ZXTOi2D1oN5HdXP0w@mail.gmail.com>
In-Reply-To: <CAPhsuW5Fvd0i-ezmsEpr977kiNfvdTKb5ZXTOi2D1oN5HdXP0w@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 22 May 2019 11:24:17 -0700
Message-ID: <CAPhsuW4==2vgsmTvd070yjjLtOj38B9kxFv5b-FMpQO+_+XVKA@mail.gmail.com>
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

Hi Thorsten,

On Wed, May 22, 2019 at 9:19 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> Hi Thorsten,
>
> Thanks for the report. I will follow up with stable@ to fix them.
>
> Best regards,
> Song

Could you please confirm the follow patches fixes the issue?

commit a25d8c327bb4 ("Revert "Don't jump to compute_result state from
check_result state"")
commit b2176a1dfb51 ("md/raid: raid5 preserve the writeback action
after the parity check")

Thanks,
Song


>
> On Wed, May 22, 2019 at 5:26 AM Thorsten Knabe <linux@thorsten-knabe.de> wrote:
> >
> > Hello.
> >
> > BUG: RAID6 recovery broken by commit
> > 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3+)
> >
> > Replacing a failed disk of a MD RAID6 array causes file system
> > corruption and data loss on kernels containing commit
> > 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef.
> >
> > Affected kernels: 5.1.3, 5.1.4 possibly others.
> > Unaffected kernels: 5.1.2
> >
> > OS: Debian stretch amd64
> >
> > Steps to reproduce the BUG:
> >
> > 1. Create a new 4-disk RAID6 array, create a file system and mount it:
> >    mdadm /dev/md0 --create -l 6 -n 4 /dev/sd[bcde]
> >    mkfs.ext4 /dev/md0
> >    mount /dev/md0 /mnt
> > 2. Store some data (a few GB should be fine) on the RAID6 arrays file
> > system:
> >    cp -r whatever /mnt
> > 3. Fail a disk of the RAID6 array and remove it from the array:
> >    mdadm /dev/md0 --fail /dev/sdd
> >    mdadm /dev/md0 --remove /dev/sdd
> > 4. Drop caches:
> >    echo "3" > /proc/sys/vm/drop_caches
> > 5. Compare data copied to the RAID6 array in step 2 with its source:
> >    diff -r whatever /mnt/whatever
> >    There should be no differences and no file system errors.
> > 6. Add a new empty disk to the RAID6 array:
> >    mdadm /dev/md0 --add /dev/sdf
> > 7. RAID6 recovery should start now, wait for the RAID6 recovery to finish.
> > 8. Drop caches again:
> >    echo "3" > /proc/sys/vm/drop_caches
> > 9. Compare data copied to the RAID6 array in step 2 with its source again:
> >    diff -r whatever /mnt/whatever
> >    diff now reports a lot of differences and the kernel log gets filled
> > with file system errors. For example:
> >    EXT4-fs warning (device md0): ext4_dirent_csum_verify:355: inode
> > #918549: comm diff: No space for directory leaf checksum. Please run
> > e2fsck -D.
> >
> > Reverting commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef from kernel
> > 5.1.4 resolves the issues described above.
> >
> > Kind regards
> > Thorsten
> >
> >
> > --
> > ___
> >  |        | /                 E-Mail: linux@thorsten-knabe.de
> >  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
> >
