Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B219198908
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 02:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgCaAwO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 20:52:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39678 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgCaAwN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 20:52:13 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so5508350iod.6
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 17:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4JpY6HeMcNiS4Q2ojE5EnoYKC4FiJkOLYpRT7pgyO+E=;
        b=zH0bEMDBmPw7rFsOMk/1aFR23lY427NXTF8JgJaaREChXmOPrby64VWLkhYgNnaTFQ
         9z1BmRvUNa8Yaf+y1VEWt68E43X4KWEFGSrxxt3TpzQP7uUo6oT2QimKDoi8u2+K7wqc
         ZFntmtAVtKCWzrKRF7m33LVeyLwWilAvBpeRMuuA8fXcea0wx+bq5NuSJ/z7ihUJOOuj
         /glvA+N9la1Z8aQIzo6xZXZN/9VeSiooLBUscPjDvOaSiU1Q8FrFGNGktyAnOY3gNhxL
         3/hl5xisqfNYtek/GNa9zWQS1jNSYhh0cb9qpVd6ocgvQGnRki9yqWniQdBRPt1q/1bb
         dypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4JpY6HeMcNiS4Q2ojE5EnoYKC4FiJkOLYpRT7pgyO+E=;
        b=RZ9EZPlBQS8cWMNmqTKzBWjg/ponYHqE1ySXzpcwVC0hTmPmyDndLB75cSadBvRDV3
         WSUJ0E3667LL3PDXPMG5UKK/E1lIkcGqxdxRL78w4yMU2GL9jbFj0s4YzbmjCwD6VFxK
         0PO295lstLwAD9n3dkOeeG0SCfhpJmouaenXYR7CvenDAf91nUwK93j4xbqRHOsZ59Ll
         ZszCKKdiM7FdjQ1xskcV/1K9PbxE/yCNRd9b/t+2s7GBsHjMyP5bPerDOSCHAITwnKf4
         UHI95mUEFTn9abkgIT7HJJ/K/h+a1qBhFhAKEeA83QmZ9XlOPlAyfRLaWxBfbWkNjSUZ
         Uq5A==
X-Gm-Message-State: ANhLgQ2lJEn9rgWqskb5rDTDTKoid4OWOJQZJThvznP2TY5+fbxy0zGr
        kz9k4IJsBObRI/kPPCeApDlGCYeJGoCxSNNLIQifLHnjB1I=
X-Google-Smtp-Source: ADFU+vvo+Whhw79NXLwCcRun+KkeW+UGvvdCG7t2PBO9HzI3vZQTVwKtf7cfjrFCaIlbT8OXfxPH4WRchkHULv48kpI=
X-Received: by 2002:a6b:c408:: with SMTP id y8mr13052108ioa.12.1585615931164;
 Mon, 30 Mar 2020 17:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
In-Reply-To: <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
From:   Daniel Jones <dj@iowni.com>
Date:   Mon, 30 Mar 2020 18:51:59 -0600
Message-ID: <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     antlists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings Wol,

> Don't even THINK of --create until the experts have chimed in !!!

Yes, I have had impure thoughts, but fortunately (?) I've done nothing
yet to intentionally write to the drives.

> If your drives are 1TB, I would *seriously* consider getting hold of a 4T=
B drive - they're not expensive - to make a backup. And read up on overlays=
.

The array drives are 10TB each.  Understand the concept of overlays in
general (have used them in a container context) and have skimmed the
wiki, but not yet acted.

> The lsdrv information is crucial - that recovers pretty much all the conf=
ig information that is available

Attached.

$ ./lsdrv
PCI [pata_marvell] 02:00.0 IDE interface: Marvell Technology Group
Ltd. 88SE6101/6102 single-port PATA133 interface (rev b2)
=E2=94=94scsi 0:x:x:x [Empty]
PCI [ahci] 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10
Family) SATA AHCI Controller
=E2=94=9Cscsi 2:0:0:0 ATA      M4-CT256M4SSD2   {0000000012050904283E}
=E2=94=82=E2=94=94sda 238.47g [8:0] Partitioned (dos)
=E2=94=82 =E2=94=9Csda1 500.00m [8:1] xfs {8ed274ce-4cf6-4804-88f8-0213c002=
a716}
=E2=94=82 =E2=94=82=E2=94=94Mounted as /dev/sda1 @ /boot
=E2=94=82 =E2=94=94sda2 237.99g [8:2] PV LVM2_member 237.92g used, 64.00m f=
ree
{kn8lMS-0Cy8-xpsR-QRTk-CTRG-Eh1J-lmtfws}
=E2=94=82  =E2=94=94VG centos_hulk 237.98g 64.00m free {P5MVrD-UMGG-0IO9-zF=
Nq-8zd2-lycX-oYqe5L}
=E2=94=82   =E2=94=9Cdm-2 185.92g [253:2] LV home xfs {39075ece-de0a-4ace-b=
291-cc22aff5a4b2}
=E2=94=82   =E2=94=82=E2=94=94Mounted as /dev/mapper/centos_hulk-home @ /ho=
me
=E2=94=82   =E2=94=9Cdm-0 50.00g [253:0] LV root xfs {68ffae87-7b51-4392-b3=
b8-59a7aa13ea68}
=E2=94=82   =E2=94=82=E2=94=94Mounted as /dev/mapper/centos_hulk-root @ /
=E2=94=82   =E2=94=94dm-1 2.00g [253:1] LV swap swap {f2da9893-93f0-42a1-ba=
86-5f3b3a72cc9b}
=E2=94=9Cscsi 3:0:0:0 ATA      WDC WD100EMAZ-00 {1DGVH01Z}
=E2=94=82=E2=94=94sdb 9.10t [8:16] Partitioned (gpt)
=E2=94=9Cscsi 4:0:0:0 ATA      WDC WD100EMAZ-00 {2YJ2XMPD}
=E2=94=82=E2=94=94sdc 9.10t [8:32] MD raid5 (4) inactive 'hulk:0'
{423d9a8e-636a-5f08-56ec-bd90282e478b}
=E2=94=9Cscsi 5:0:0:0 ATA      WDC WD100EMAZ-00 {2YJDR8LD}
=E2=94=82=E2=94=94sdd 9.10t [8:48] Partitioned (gpt)
=E2=94=94scsi 6:0:0:0 ATA      WDC WD100EMAZ-00 {JEHRKH2Z}
 =E2=94=94sde 9.10t [8:64] Partitioned (gpt)

Cheers,
DJ

On Mon, Mar 30, 2020 at 6:24 PM antlists <antlists@youngman.org.uk> wrote:
>
> On 31/03/2020 01:04, Daniel Jones wrote:
> > I am genuinely over my head at this point and unsure how to proceed.
> > My logic tells me the best choice is to attempt a --create to try to
> > rebuild the missing superblocks, but I'm not clear if I should try
> > devices=3D4 (the true size of the array) or devices=3D3 (the size it wa=
s
> > last operating in).  I'm also not sure of what device order to use
> > since I have likely scrambled /dev/sd[bcde] and am concerned about
> > what happens when I bring the previously disable drive back into the
> > array.
>
> Don't even THINK of --create until the experts have chimed in !!!
>
> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>
> The lsdrv information is crucial - that recovers pretty much all the
> config information that is available, and massively increases the
> chances of a successful --create, if you do have to go down that route...
>
> If your drives are 1TB, I would *seriously* consider getting hold of a
> 4TB drive - they're not expensive - to make a backup. And read up on
> overlays.
>
> Hopefully we can recover your data without too much grief, but this will
> all help.
>
> Cheers,
> Wol
