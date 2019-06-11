Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031923D2D5
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390339AbfFKQnX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 12:43:23 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:40662 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389710AbfFKQnX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 12:43:23 -0400
Received: by mail-it1-f173.google.com with SMTP id q14so5825163itc.5
        for <linux-raid@vger.kernel.org>; Tue, 11 Jun 2019 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UjODBBNSPMxvrYD2EXTxtKnJkl6p/NpY58JjRhxSuZw=;
        b=B3jq2eQ5z4QkmRcV8ILu/h5dAhJV25grpXj4bPZ6UNiGXnR/YSbX8oq7q+A4eGUewW
         QRbsf2zye3HUBznlF/38XgAyh/M4lvL1yQo3Xl1IzRChGrzc0hLM9JEPluTRRLaX1m57
         6wDJxMG35h9V1VJg2b5V5xusCmp+2IqgPMa5DUOib8Q1LUkM/U1QbMOMqNKMQ5NTjL56
         e/yFU6qiy5oM04kQwZzreFOVSrV2bSzqgkfq57xctfJcjXqSTDAC3nqh150TjP/1d3YJ
         VbT+bfzKFW6pF6xk4yb4e3Cr7z58tFg0Jab3mOabXrSJNG3iPZtwOgA8UczbVr2j7xeH
         SQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UjODBBNSPMxvrYD2EXTxtKnJkl6p/NpY58JjRhxSuZw=;
        b=kLHoccZ7+tWLvKdjtpOCpqJxYiOapcT0wMIdN0l5xHUOlZt1eZaMLB9lErzejPUQgi
         lxzqf5QF+xes8upMbL/f/b+2mG46NloJNcSJZhCGcbYiw4Vhge1beJ0H2s6XMSL6s0zp
         6HHo8lcxoewy8HhJkQNDJrPpzPba1Bse8eDSyu45p/sg3bpMT+ATRb2SnhPSLmwJo/TN
         z6zpUTi1XAiHAxxULYdRvX3T13p2hEvQkpCBlyvwYIvGr4+hfcoze067LqCi6E/+rjVt
         nQr2zv/4MHagNtHWAy9fJr5a4HnY/50nQJGTa/qK3QVN9a6IRTUZbmrzr2eHVUMsiCp4
         2P6g==
X-Gm-Message-State: APjAAAUa++FS00XjuuzpzFRVGkWPS8+OGnpRIQ6TDAouUnxhAslMSX+K
        MwlYFS6JHVvkBM9xdkMO9TOSKmwTLeHD7pRZK7I=
X-Google-Smtp-Source: APXvYqwagFILHyLWCUyqCf8ZghgrzU5hEaKwt5DbRshQy3TD9gMIFjxsaBfSMohIxt6s6RntYwotYYkGsotYzfNfekU=
X-Received: by 2002:a24:2550:: with SMTP id g77mr16815464itg.95.1560271401729;
 Tue, 11 Jun 2019 09:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
 <008b01d52000$d1628040$742780c0$@Gmail.com> <039a6e10-b3f7-a803-2895-98068ea9de06@redhat.com>
In-Reply-To: <039a6e10-b3f7-a803-2895-98068ea9de06@redhat.com>
From:   Colt Boyd <coltboyd@gmail.com>
Date:   Tue, 11 Jun 2019 11:43:10 -0500
Message-ID: <CANrzNyjz09KDZitwgTKtb1CZ2fUS0nwyRF4_Xc9hXO92nJLJfQ@mail.gmail.com>
Subject: Re: RAID-6 aborted reshape
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 5:21 AM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 06/11/2019 10:53 AM, Colt Boyd wrote:
> > Is there anything that can be done?
> >
> > -----Original Message-----
> > From: Colt Boyd <coltboyd@gmail.com>
> > Sent: Saturday, June 8, 2019 10:48 AM
> > To: linux-raid@vger.kernel.org
> > Subject: RAID-6 aborted reshape
> >
> > I was resizing a raid6 array with a internal write intent bitmap from
> > 5 3TB drives (in RAID6) to 6 drives. It was aborted very early in resha=
pe via reboot and then reassembled with:
> > 'mdadm -A /dev/md0 --force --verbose --update=3Drevert-reshape --invali=
d-backup /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1'
>
> Does this command finish? I tried this myself with this command. The
> filesystem is good after this command.
> I interrupt the reshape by `mdadm -S /dev/md0` before assembling it.

It did finish, but did not leave a mountable XFS file system.

>
> Then I did another test. I interrupted the reshape by `echo b >
> /proc/sysrq-trigger`. Then tried to assemble the raid
> by your command. It gave the error message:
>
> [root@dell-per720-08 home]# mdadm -A /dev/md0 --force --verbose
> --update=3Drevert-reshape --invalid-backup /dev/loop[0-4]
> mdadm: looking for devices for /dev/md0
> mdadm: Reshape position is not suitably aligned.
> mdadm: Try normal assembly and stop again
>
>
> Then I used this command to try to assemble it:
> mdadm -A /dev/md0  --verbose  --invalid-backup /dev/loop[0-4]
>
> The filesystem is good too.
>
> By the way I used the latest upstream version.
I was using:
root@OMV1:/tmp# mdadm --version
mdadm - v3.4 - 28th January 2016
root@OMV1:/tmp# uname -r
4.19.0-0.bpo.2-amd64

I can try the upstream version.

I was not using overlay devices at first and initially tried the above
create on the actual raid devices. I still have the superblock intact
on the 6th device. Is there a way to reconstruct the super blocks on
devices 1-5 (raid devices 0-4) based on the superblock on the 6th
device and/or the backup file?

Thanks,
Colt

>
> Regards
> Xiao
> >
> > When I reassembled it this way I incorrectly thought the backup file wa=
s zero bytes. It wasn't. I still have the intact backup file.
> >
> > I=E2=80=99ve also since tried to reassemble it with the following creat=
e but the XFS fs is not accessible:
> > 'mdadm --create /dev/md0 --data-offset=3D1024 --level=3D6 --raid-device=
s=3D5 --chunk=3D1024K --name=3DOMV:0 /dev/sdb1 /dev/sde1 /dev/sdc1 /dev/sdd=
1
> > /dev/sdf1 --assume-clean --readonly'
> >
> > I can see the XFS FS on the drives, example:
> > root@OMV1:~# dd if=3D/dev/sde1 bs=3D512k count=3D5 | hexdump -C <snip>
> > 00200000  58 46 53 42 00 00 10 00  00 00 00 00 82 f2 c3 00  |XFSB......=
......|
> > 00200010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..........=
......|
> > 00200020  4e 2b 04 64 e8 1b 49 d9  a5 20 b5 74 79 94 52 f8  |N+.d..I.. =
.ty.R.| <snip>
> >
> > This is what it looked like immediately following the aborted reshape a=
nd before attempting to recreate it. This is from the drive that was being =
added at the time.
> >
> > /dev/sdg1:
> >            Magic : a92b4efc
> >          Version : 1.2
> >      Feature Map : 0x1
> >       Array UUID : f8fdf8d4:d173da32:eaa97186:eaf88ded
> >             Name : OMV:0
> >    Creation Time : Mon Feb 24 18:19:36 2014
> >       Raid Level : raid6
> >     Raid Devices : 6
> >
> >   Avail Dev Size : 5858529280 (2793.56 GiB 2999.57 GB)
> >       Array Size : 11717054464 (11174.25 GiB 11998.26 GB)
> >    Used Dev Size : 5858527232 (2793.56 GiB 2999.57 GB)
> >      Data Offset : 2048 sectors
> >     Super Offset : 8 sectors
> >     Unused Space : before=3D1960 sectors, after=3D2048 sectors
> >            State : clean
> >      Device UUID : 92e022c9:ee6fbc26:74da4bcc:5d0e0409
> >
> > Internal Bitmap : 8 sectors from superblock
> >      Update Time : Thu Jun  6 10:24:34 2019
> >    Bad Block Log : 512 entries available at offset 72 sectors
> >         Checksum : 8f0d9eb9 - correct
> >           Events : 1010399
> >
> >           Layout : left-symmetric
> >       Chunk Size : 1024K
> >
> >     Device Role : Active device 5
> >     Array State : AAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =
=3D=3D replacing)
> >
> > Where can I go from here to get this back?
> >
>
