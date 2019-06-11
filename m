Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2519F3D3E7
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406016AbfFKRXF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 13:23:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44430 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405821AbfFKRXF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 13:23:05 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so10551670iob.11
        for <linux-raid@vger.kernel.org>; Tue, 11 Jun 2019 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ku3dYP2qLQ4OqGNJOhHu48By5FPjhdQV0tqee8zSos=;
        b=U06rj7Q36FVDu+b1hdDDb0jLuLtzrgKVmXDLtjpzoqFJGboucY1VfPh/v/bk6EGqPJ
         g4TlxN2HMVQdQaG0daakqdi5XTFL7hCJgkjgk4hM75eCl7Vcv6cJAZ93D1Qlg7A3fP7r
         J1hUhCkITBLpDMC+GI2ygMNzscnYqlLnguXWemWUPs+QBcjJ6ooOoc1JezDlHIm9IxVg
         1qfJTKtb0ad2bPaS1aw95Idzd8CPF3DXJPaWYi/NJeibZLQCvqjTnLxA8a7XK1hknIdb
         LqmJWfJAep/+yYyzqDRDXI1mYpEFsn/s3P8euJj87RURzOJKu6yd4jjDFxOYsMgC3MHn
         RgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ku3dYP2qLQ4OqGNJOhHu48By5FPjhdQV0tqee8zSos=;
        b=cgzdFbUo5IgzoVHbNgwyGiQuOp6u3SPm7GpVW31pQANPdQlDd6GTls1jtI8/Ya7n4R
         hF5xx4KTxPb17PDwpAsXx41A4Y0/EzDSV/1Gcs9oflz3CTGrhpjh9DlkViQiONPzKUCl
         ZAHfAPsjR7K8G83IPGC6oRQD8UZYGt57Zo3zO/r208qLx0maxNShZT129A0aj7gshaje
         iL60Bm+CegIxvUYeYRZRDWq4E1Eml6oD9jY6hIDNKBgf8ed0+fqb2HtTjtdFts73RrJu
         1lukaOFUuTzFxZVRyMWNFq8TaW+LcdGW9ss8pvt9TflShyN7CJnaHGEveKNpGjjxfOcg
         MR6w==
X-Gm-Message-State: APjAAAV1y7HKgFQ9bmmlbnehE+GaFQxEn1EvowbMbmzo0ZIEMWENSsB8
        OC98JuDBSdLbezawwsCNzcmS3WZUPiFTifFCXnU=
X-Google-Smtp-Source: APXvYqzskvSjjvlrH1QSooLyfjZ4R6hdpPcAQU+bkL08S2xzCM2E2Nf08KC/TyjsGnCVeM9JexEKS6NU6UgHfR1K69Q=
X-Received: by 2002:a6b:8b51:: with SMTP id n78mr51098451iod.192.1560273784133;
 Tue, 11 Jun 2019 10:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
 <20190611141621.GA16779@metamorpher.de> <CANrzNyiCF3Fhn30pJ_hWVcGyvaMrRBLAWkPD8o4+TpCDSWTkHw@mail.gmail.com>
In-Reply-To: <CANrzNyiCF3Fhn30pJ_hWVcGyvaMrRBLAWkPD8o4+TpCDSWTkHw@mail.gmail.com>
From:   Colt Boyd <coltboyd@gmail.com>
Date:   Tue, 11 Jun 2019 12:22:53 -0500
Message-ID: <CANrzNyiQQ1BFV87CRi7gE3-k=10Swg6U8cNa2qUpS3oo0ZW32w@mail.gmail.com>
Subject: Re: RAID-6 aborted reshape
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 12:15 PM Colt Boyd <coltboyd@gmail.com> wrote:
>
> On Tue, Jun 11, 2019 at 9:16 AM Andreas Klauer
> <Andreas.Klauer@metamorpher.de> wrote:
> >
> > On Sat, Jun 08, 2019 at 10:47:30AM -0500, Colt Boyd wrote:
> > > I=E2=80=99ve also since tried to reassemble it with the following cre=
ate but
> > > the XFS fs is not accessible:
> > > 'mdadm --create /dev/md0 --data-offset=3D1024 --level=3D6 --raid-devi=
ces=3D5
> > > --chunk=3D1024K --name=3DOMV:0 /dev/sdb1 /dev/sde1 /dev/sdc1 /dev/sdd=
1
> > > /dev/sdf1 --assume-clean --readonly'
> >
> > Well, all sorts of things can go wrong with a re-create.
> > You should be using overlays for such experiments.
> >
> > https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAI=
D#Making_the_harddisks_read-only_using_an_overlay_file
>
> Thanks, I am now using overlays, but was not during the first hour
> after disaster. I still have the superblock intact on the 6th device
> (raid device 5) but the superblocks were overwritten on raid devices
> 0-4 when I tried the create.
>
> > Also, which kernel version are you running?
>
> 4.19.0-0.bpo.2-amd64
>
> > I think there was a RAID6 bug recently in kernel 5.1.3 or so.
> >
> > https://www.spinics.net/lists/raid/msg62645.html
> >
> > > /dev/sdg1:
> > >           Magic : a92b4efc
> > >         Version : 1.2
> > >     Feature Map : 0x1
> > >      Array UUID : f8fdf8d4:d173da32:eaa97186:eaf88ded
> > >            Name : OMV:0
> > >   Creation Time : Mon Feb 24 18:19:36 2014
> > >      Raid Level : raid6
> > >    Raid Devices : 6
> > >
> > >  Avail Dev Size : 5858529280 (2793.56 GiB 2999.57 GB)
> > >      Array Size : 11717054464 (11174.25 GiB 11998.26 GB)
> > >   Used Dev Size : 5858527232 (2793.56 GiB 2999.57 GB)
> > >     Data Offset : 2048 sectors
> > >    Super Offset : 8 sectors
> > >    Unused Space : before=3D1960 sectors, after=3D2048 sectors
> > >           State : clean
> > >     Device UUID : 92e022c9:ee6fbc26:74da4bcc:5d0e0409
> > >
> > > Internal Bitmap : 8 sectors from superblock
> > >     Update Time : Thu Jun  6 10:24:34 2019
> > >   Bad Block Log : 512 entries available at offset 72 sectors
> > >        Checksum : 8f0d9eb9 - correct
> > >          Events : 1010399
> > >
> > >          Layout : left-symmetric
> > >      Chunk Size : 1024K
> > >
> > >    Device Role : Active device 5
> > >    Array State : AAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =
=3D=3D replacing)
> >
> > This already believes to have 6 drives, not in mid-reshape.
> > What you created has 5 drives... that's a bit odd.
> >
> > It could still be normal, metadata for drives that get kicked out
> > is no longer updated after all, and I haven't tested it myself...
> >
> > --examine of the other drives (before re-create) would be interesting.
> > If those are not available, maybe syslogs of the original assembly,
> > reshape and subsequent recreate.
>
> The other drives got their superblocks overwritten (with the exception
> of raid device 5 that was being added). Here are the applicable
> sections from the syslogs.
>
> Jun  6 10:12:25 OMV1 kernel: [    2.141772] md/raid:md0: device sde1
> operational as raid disk 1
> Jun  6 10:12:25 OMV1 kernel: [    2.141774] md/raid:md0: device sdc1
> operational as raid disk 2
> Jun  6 10:12:25 OMV1 kernel: [    2.141789] md/raid:md0: device sdd1
> operational as raid disk 3
> Jun  6 10:12:25 OMV1 kernel: [    2.141792] md/raid:md0: device sdf1
> operational as raid disk 4
> Jun  6 10:12:25 OMV1 kernel: [    2.141796] md/raid:md0: device sdb1
> operational as raid disk 0
> Jun  6 10:12:25 OMV1 kernel: [    2.142877] md/raid:md0: raid level 6
> active with 5 out of 5 devices, algorithm 2
> Jun  6 10:12:25 OMV1 kernel: [    2.196783] md0: detected capacity
> change from 0 to 8998697828352
> Jun  6 10:12:25 OMV1 kernel: [    3.885628] XFS (md0): Mounting V4 Filesy=
stem
> Jun  6 10:12:25 OMV1 kernel: [    4.213947] XFS (md0): Ending clean mount
> Jun  6 10:12:25 OMV1 kernel: [    4.220989] XFS (md0): Quotacheck
> needed: Please wait.
> Jun  6 10:12:25 OMV1 kernel: [    7.200429] XFS (md0): Quotacheck: Done.
> <snip>
> Jun  6 10:17:40 OMV1 kernel: [  321.232145] md: reshape of RAID array md0
> Jun  6 10:17:40 OMV1 systemd[1]: Created slice
> system-mdadm\x2dgrow\x2dcontinue.slice.
> Jun  6 10:17:40 OMV1 systemd[1]: Started Manage MD Reshape on /dev/md0.
> Jun  6 10:17:40 OMV1 systemd[1]: mdadm-grow-continue@md0.service: Main
> process exited, code=3Dexited, status=3D2/INVALIDARGUMENT
> Jun  6 10:17:40 OMV1 systemd[1]: mdadm-grow-continue@md0.service: Unit
> entered failed state.
> Jun  6 10:17:40 OMV1 systemd[1]: mdadm-grow-continue@md0.service:
> Failed with result 'exit-code'.
> Jun  6 10:18:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:18:32 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:19:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:19:32 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:20:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:20:32 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:21:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:21:32 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:22:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:22:32 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:23:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:23:32 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:24:02 OMV1 monit[1170]:
> 'filesystem_media_4e2b0464-e81b-49d9-a520-b574799452f8' space usage
> 88.1% matches resource limit [space usage>85.0%]
> Jun  6 10:24:28 OMV1 systemd[1]: Unmounting /export/Shared...
> Jun  6 10:24:28 OMV1 systemd[1]: Removed slice
> system-mdadm\x2dgrow\x2dcontinue.slice.
> <snip> - server shutting down
> Jun  6 10:24:28 OMV1 systemd[1]: openmediavault-engined.service:
> Killing process 1214 (omv-engined) with signal SIGKILL.

There is also these:

Jun  6 10:39:18 OMV1 kernel: [  120.022361] md0: detected capacity
change from 11998263771136 to 0
Jun  6 10:39:18 OMV1 kernel: [  120.022371] md: md0 stopped.
Jun  6 10:40:39 OMV1 kernel: [  200.948894] md: md0 stopped.
Jun  6 10:40:39 OMV1 kernel: [  201.692933] md: md0 stopped.
Jun  6 10:41:11 OMV1 kernel: [  233.338779] md: md0 stopped.
Jun  6 10:43:11 OMV1 kernel: [  353.828080] md: md0 stopped.
Jun  6 10:43:55 OMV1 kernel: [  397.202545] md: md0 stopped.
Jun  6 10:44:12 OMV1 kernel: [  414.195911] md: md0 stopped.
Jun  6 10:44:15 OMV1 kernel: [  417.271865] md: md0 stopped.
Jun  6 10:44:45 OMV1 kernel: [  447.195016] md: md0 stopped.
Jun  6 10:44:47 OMV1 kernel: [  449.499203] md: md0 stopped.
Jun  6 10:44:47 OMV1 kernel: [  449.511291] md/raid:md0: device sdb1
operational as raid disk 0
Jun  6 10:44:47 OMV1 kernel: [  449.511294] md/raid:md0: device sdf1
operational as raid disk 4
Jun  6 10:44:47 OMV1 kernel: [  449.511297] md/raid:md0: device sdd1
operational as raid disk 3
Jun  6 10:44:47 OMV1 kernel: [  449.511299] md/raid:md0: device sdc1
operational as raid disk 2
Jun  6 10:44:47 OMV1 kernel: [  449.511302] md/raid:md0: device sde1
operational as raid disk 1
Jun  6 10:44:47 OMV1 kernel: [  449.512553] md/raid:md0: raid level 6
active with 5 out of 6 devices, algorithm 2
Jun  6 10:44:47 OMV1 kernel: [  449.554738] md0: detected capacity
change from 0 to 11998263771136
Jun  6 10:44:48 OMV1 postfix/smtp[2514]: 9672F6B4: replace: header
Subject: DegradedArray event on /dev/md0:OMV1: Subject:
[OMV1.veldanet.local] DegradedArray event on /dev/md0:OMV1
Jun  6 10:46:25 OMV1 kernel: [  547.047912] XFS (md0): Mounting V4 Filesyst=
em
Jun  6 10:46:28 OMV1 kernel: [  550.226215] XFS (md0): Log
inconsistent (didn't find previous header)
Jun  6 10:46:28 OMV1 kernel: [  550.226224] XFS (md0): failed to find log h=
ead
Jun  6 10:46:28 OMV1 kernel: [  550.226227] XFS (md0): log
mount/recovery failed: error -5
Jun  6 10:46:28 OMV1 kernel: [  550.226264] XFS (md0): log mount failed
Jun  6 10:48:29 OMV1 kernel: [  671.505718] md0: detected capacity
change from 11998263771136 to 0
Jun  6 10:48:29 OMV1 kernel: [  671.505731] md: md0 stopped.
Jun  6 10:48:53 OMV1 kernel: [  695.670961] md: md0 stopped.
Jun  6 10:48:53 OMV1 kernel: [  695.682191] md/raid:md0: device sdb1
operational as raid disk 0
Jun  6 10:48:53 OMV1 kernel: [  695.682193] md/raid:md0: device sdg1
operational as raid disk 5
Jun  6 10:48:53 OMV1 kernel: [  695.682195] md/raid:md0: device sdf1
operational as raid disk 4
Jun  6 10:48:53 OMV1 kernel: [  695.682197] md/raid:md0: device sdd1
operational as raid disk 3
Jun  6 10:48:53 OMV1 kernel: [  695.682199] md/raid:md0: device sdc1
operational as raid disk 2
Jun  6 10:48:53 OMV1 kernel: [  695.682200] md/raid:md0: device sde1
operational as raid disk 1
Jun  6 10:48:53 OMV1 kernel: [  695.683023] md/raid:md0: raid level 6
active with 6 out of 6 devices, algorithm 2
Jun  6 10:48:53 OMV1 kernel: [  695.760209] md0: detected capacity
change from 0 to 11998263771136
Jun  6 10:51:24 OMV1 kernel: [  846.532095] XFS (md0): Mounting V4 Filesyst=
em
Jun  6 10:51:27 OMV1 kernel: [  849.779906] XFS (md0): Log
inconsistent (didn't find previous header)
Jun  6 10:51:27 OMV1 kernel: [  849.779924] XFS (md0): failed to find log h=
ead
Jun  6 10:51:27 OMV1 kernel: [  849.779931] XFS (md0): log
mount/recovery failed: error -5
Jun  6 10:51:27 OMV1 kernel: [  849.780000] XFS (md0): log mount failed
Jun  6 10:52:22 OMV1 systemd[1]: Starting Cleanup of Temporary Directories.=
..
Jun  6 10:52:22 OMV1 systemd[1]: Started Cleanup of Temporary Directories.
Jun  6 10:52:52 OMV1 kernel: [  934.000472] md0: detected capacity
change from 11998263771136 to 0
Jun  6 10:52:52 OMV1 kernel: [  934.000480] md: md0 stopped.

>
> > Otherwise you have to look at the raw data (or try blindly)
> > to figure out the data layout.
> >
> > Please use overlays for experiments...
> >
> > Good luck.
>
> I am now, if only I was to start with this may be easier. Anyway to
> rebuild superblocks from the remaing drive and / or the backup file?
> And if so, would that be better?
>
> Thanks,
> Colt
>
> > Regards
> > Andreas Klauer
