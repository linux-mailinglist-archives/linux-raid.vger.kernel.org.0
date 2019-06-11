Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0503D3B9
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405842AbfFKRPT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 13:15:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405226AbfFKRPT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 13:15:19 -0400
Received: by mail-io1-f68.google.com with SMTP id k13so10535265iop.5
        for <linux-raid@vger.kernel.org>; Tue, 11 Jun 2019 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ubm2XUqO7S6GHpM6cizUJxC0kd4hZfvbsa3z73Uwcn0=;
        b=VIHkknZ9HJQcYEqdojTejVqEJ2jv6GImw8ZD15fhTd2FTzOWILcFXdJVXRDLWDHqdw
         4PabL+JS5NbG+cgsInK67D3TRKLhWa/kjK1S6VGfJs6+ItSH1aD858ttbTYMGW1jeOwC
         zQAOaxPJDvsBi6r3Jat1V2SSpznHqdkcvHbCHLOO1xlDwKKB6LiA7czNbd4QGDbtqp5y
         QKEzBEXXWitMaAG1/WmkJdQRBua6pG/EZqutAKU5cJFOlYp4gS8enE45PWH6gIchYwJW
         f9mf8a+KUmfxXMg9rr8DCJRUyOLvklnUG6Jfx04yufF1EqH6PZAQIsvan/cxsiyZP+h6
         lo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ubm2XUqO7S6GHpM6cizUJxC0kd4hZfvbsa3z73Uwcn0=;
        b=M2IhvnYLdrBbnrcSYJTmzpv+ikXS67q4M6DIAaUB1p8nsfDttjJFdB2jFmsBp2lZKV
         Ae/hLDEZWAtyRrRjHSEVFHOrBTckKLdBoJlsrxgvVWnHg/pfI6dUwiOEnWirEs0XpoIR
         gpfBNKQfPvtNDBJUgc25b2sW1MCjgfm4Udye6y0IG2+UIIa65BkNUfqG6oAD47PEWRuI
         Iz2DCpFbMJ59TZMMdV4PxuOUMFXwdsz9XWI/lhOHQ6UrfDKuat2ewZza7mNOha4/RJPz
         Lufq857k8zORrQZlIqm/wIDXnsQl+mTN7MIFTM9NwBrsYTChe3nfTYFi3H/17Sgkxp9d
         ttiQ==
X-Gm-Message-State: APjAAAUFTJFp7vE8C4UwrYYDrWoa/YalZBPqz1qCSXQ+mYxR+T7PX8jh
        RgY/8+RB18srMB8VQwn2QJfgS8LkUb6FW9ZA0h58Wx9p
X-Google-Smtp-Source: APXvYqxvNi069/CsDsjnojETqNi3sMKbZgRedYItpxCvzK4inM0j/l/y1bULy5aJ3afxUiLAv8Fu7RoldvdefFBKVIg=
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr4602581iol.269.1560273318172;
 Tue, 11 Jun 2019 10:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
 <20190611141621.GA16779@metamorpher.de>
In-Reply-To: <20190611141621.GA16779@metamorpher.de>
From:   Colt Boyd <coltboyd@gmail.com>
Date:   Tue, 11 Jun 2019 12:15:06 -0500
Message-ID: <CANrzNyiCF3Fhn30pJ_hWVcGyvaMrRBLAWkPD8o4+TpCDSWTkHw@mail.gmail.com>
Subject: Re: RAID-6 aborted reshape
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 9:16 AM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Sat, Jun 08, 2019 at 10:47:30AM -0500, Colt Boyd wrote:
> > I=E2=80=99ve also since tried to reassemble it with the following creat=
e but
> > the XFS fs is not accessible:
> > 'mdadm --create /dev/md0 --data-offset=3D1024 --level=3D6 --raid-device=
s=3D5
> > --chunk=3D1024K --name=3DOMV:0 /dev/sdb1 /dev/sde1 /dev/sdc1 /dev/sdd1
> > /dev/sdf1 --assume-clean --readonly'
>
> Well, all sorts of things can go wrong with a re-create.
> You should be using overlays for such experiments.
>
> https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#=
Making_the_harddisks_read-only_using_an_overlay_file

Thanks, I am now using overlays, but was not during the first hour
after disaster. I still have the superblock intact on the 6th device
(raid device 5) but the superblocks were overwritten on raid devices
0-4 when I tried the create.

> Also, which kernel version are you running?

4.19.0-0.bpo.2-amd64

> I think there was a RAID6 bug recently in kernel 5.1.3 or so.
>
> https://www.spinics.net/lists/raid/msg62645.html
>
> > /dev/sdg1:
> >           Magic : a92b4efc
> >         Version : 1.2
> >     Feature Map : 0x1
> >      Array UUID : f8fdf8d4:d173da32:eaa97186:eaf88ded
> >            Name : OMV:0
> >   Creation Time : Mon Feb 24 18:19:36 2014
> >      Raid Level : raid6
> >    Raid Devices : 6
> >
> >  Avail Dev Size : 5858529280 (2793.56 GiB 2999.57 GB)
> >      Array Size : 11717054464 (11174.25 GiB 11998.26 GB)
> >   Used Dev Size : 5858527232 (2793.56 GiB 2999.57 GB)
> >     Data Offset : 2048 sectors
> >    Super Offset : 8 sectors
> >    Unused Space : before=3D1960 sectors, after=3D2048 sectors
> >           State : clean
> >     Device UUID : 92e022c9:ee6fbc26:74da4bcc:5d0e0409
> >
> > Internal Bitmap : 8 sectors from superblock
> >     Update Time : Thu Jun  6 10:24:34 2019
> >   Bad Block Log : 512 entries available at offset 72 sectors
> >        Checksum : 8f0d9eb9 - correct
> >          Events : 1010399
> >
> >          Layout : left-symmetric
> >      Chunk Size : 1024K
> >
> >    Device Role : Active device 5
> >    Array State : AAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)
>
> This already believes to have 6 drives, not in mid-reshape.
> What you created has 5 drives... that's a bit odd.
>
> It could still be normal, metadata for drives that get kicked out
> is no longer updated after all, and I haven't tested it myself...
>
> --examine of the other drives (before re-create) would be interesting.
> If those are not available, maybe syslogs of the original assembly,
> reshape and subsequent recreate.

The other drives got their superblocks overwritten (with the exception
of raid device 5 that was being added). Here are the applicable
sections from the syslogs.

Jun  6 10:12:25 OMV1 kernel: [    2.141772] md/raid:md0: device sde1
operational as raid disk 1
Jun  6 10:12:25 OMV1 kernel: [    2.141774] md/raid:md0: device sdc1
operational as raid disk 2
Jun  6 10:12:25 OMV1 kernel: [    2.141789] md/raid:md0: device sdd1
operational as raid disk 3
Jun  6 10:12:25 OMV1 kernel: [    2.141792] md/raid:md0: device sdf1
operational as raid disk 4
Jun  6 10:12:25 OMV1 kernel: [    2.141796] md/raid:md0: device sdb1
operational as raid disk 0
Jun  6 10:12:25 OMV1 kernel: [    2.142877] md/raid:md0: raid level 6
active with 5 out of 5 devices, algorithm 2
Jun  6 10:12:25 OMV1 kernel: [    2.196783] md0: detected capacity
change from 0 to 8998697828352
Jun  6 10:12:25 OMV1 kernel: [    3.885628] XFS (md0): Mounting V4 Filesyst=
em
Jun  6 10:12:25 OMV1 kernel: [    4.213947] XFS (md0): Ending clean mount
Jun  6 10:12:25 OMV1 kernel: [    4.220989] XFS (md0): Quotacheck
needed: Please wait.
Jun  6 10:12:25 OMV1 kernel: [    7.200429] XFS (md0): Quotacheck: Done.
<snip>
Jun  6 10:17:40 OMV1 kernel: [  321.232145] md: reshape of RAID array md0
Jun  6 10:17:40 OMV1 systemd[1]: Created slice
system-mdadm\x2dgrow\x2dcontinue.slice.
Jun  6 10:17:40 OMV1 systemd[1]: Started Manage MD Reshape on /dev/md0.
Jun  6 10:17:40 OMV1 systemd[1]: mdadm-grow-continue@md0.service: Main
process exited, code=3Dexited, status=3D2/INVALIDARGUMENT
Jun  6 10:17:40 OMV1 systemd[1]: mdadm-grow-continue@md0.service: Unit
entered failed state.
Jun  6 10:17:40 OMV1 systemd[1]: mdadm-grow-continue@md0.service:
Failed with result 'exit-code'.
Jun  6 10:18:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:18:32 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:19:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:19:32 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:20:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:20:32 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:21:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:21:32 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:22:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:22:32 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:23:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:23:32 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:24:02 OMV1 monit[1170]:
'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
88.1% matches resource limit [space usage>85.0%]
Jun  6 10:24:28 OMV1 systemd[1]: Unmounting /export/Shared...
Jun  6 10:24:28 OMV1 systemd[1]: Removed slice
system-mdadm\x2dgrow\x2dcontinue.slice.
<snip> - server shutting down
Jun  6 10:24:28 OMV1 systemd[1]: openmediavault-engined.service:
Killing process 1214 (omv-engined) with signal SIGKILL.


> Otherwise you have to look at the raw data (or try blindly)
> to figure out the data layout.
>
> Please use overlays for experiments...
>
> Good luck.

I am now, if only I was to start with this may be easier. Anyway to
rebuild superblocks from the remaing drive and / or the backup file?
And if so, would that be better?

Thanks,
Colt

> Regards
> Andreas Klauer
