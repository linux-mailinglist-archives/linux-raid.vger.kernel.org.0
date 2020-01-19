Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB4141F20
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jan 2020 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgASRDG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jan 2020 12:03:06 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39465 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgASRDG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 19 Jan 2020 12:03:06 -0500
Received: by mail-ua1-f68.google.com with SMTP id 73so10676131uac.6
        for <linux-raid@vger.kernel.org>; Sun, 19 Jan 2020 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KLNYLisoomRkbdVRmWar+ovSkZm2+/frpDmNFWs0SgA=;
        b=hos9jL381cCRm23ARCk+8H9lQJoPcWvYJd6QBr0ozHXJowtr5VHpXFL7RSfmRKQh1q
         UbZIi4yqF69bPfmtLePkKTHe32L1xhLjfBY77YVp67j/po9IOFrkpV2e49RA+TytnPbj
         grQwz/rBbi7AVvJ89KiTlZhupFbfHufW/iFgBMOuZgHyvlLqLVDPHYh1hzKGtfkM61rF
         veUDQH4U/eZq49ueFm1OQI4pRqJQQt2rIVkIp+njLN8Dd6W3xKfvBCp0Dksd0shBlQZX
         kHww5oHSK/UgyqoXB6IEAMOvOTUKA/yY6iVA13ingGtyCL5RtpdJky5XeRYJU7+KpuE+
         kn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KLNYLisoomRkbdVRmWar+ovSkZm2+/frpDmNFWs0SgA=;
        b=Mb0cfagMz5VWaehaww1zJKNj9QYxGrYbrkBSY38Yo5mafO8cc5VCoF6PWAF1Bryf1U
         0VS89FkpNV/0pQ0kWU3gciMy6OMxWyFEbQtBKVHfQpExLQSu11EigShXLC8TcyEMYNxi
         yVqMR70MaT3cUkOxQvZ3JENqfkhEuFBFLVlORWOnFN5zEAFvxhvRSsx4xi4/YnJaH38k
         rXosCNEEYzAmZkPtmiy60UVDTQ5swxQLR1DMAMYlfzb5JXQQX7J+GQEyVjcJZIIGiQNp
         EW/cPXd9CVs7z2qc1YmpDsNSQH8FdbV0UPhYkbGlBMYPuI2XghLI4SJSbN72INd+BJTP
         i4dQ==
X-Gm-Message-State: APjAAAUgATvr2mH7Nu1vKDDAa6IGuOK2UgQnyrLnnJtznfnOublchGTV
        3slfwbiFm6XPcC5VZsrH6r7uWDpXjk3PzcinecjhWnG4
X-Google-Smtp-Source: APXvYqxfiDl05vKr7HnmfSd/9eFseGD1f80z30NWc5R7qnxQNLpZaLigIi9EWC9iHG+J0q8jgNHkYdFZN6jI/fHYWck=
X-Received: by 2002:ab0:7118:: with SMTP id x24mr26379873uan.29.1579453385275;
 Sun, 19 Jan 2020 09:03:05 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk> <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk> <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
 <5E1DDCFC.1080105@youngman.org.uk> <CALc6PW5Y-SvUZ5HOWZLk2YcggepUwK0N===G=42uMR88pDfAVA@mail.gmail.com>
 <5E1FA3E6.2070303@youngman.org.uk>
In-Reply-To: <5E1FA3E6.2070303@youngman.org.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Sun, 19 Jan 2020 11:02:54 -0600
Message-ID: <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> Read the wiki - the section on badblocks will be - enlightening - shall
> we say.
>
> https://raid.wiki.kernel.org/index.php/The_Badblocks_controversy

Yeah, I had read that already. Seems like a strange limbo state to be
in with no clear way of fixing bad blocks....

Anyway, I think the bad blocks may be related to the problem I'm
having now. At first everything looks good:

bill@bill-desk:~$ cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4] [linear] [multipath] [raid0]
[raid1] [raid10]
md0 : active raid5 sdk1[1] sdm1[4] sdj1[0] sdl1[2]
      23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/4] [U=
UUU]
      bitmap: 0/59 pages [0KB], 65536KB chunk
unused devices: <none>

bill@bill-desk:~$ sudo fsck /dev/md0
fsck from util-linux 2.34
e2fsck 1.45.3 (14-Jul-2019)
/dev/md0: clean, 11274/366276608 files, 5285497435/5860419840 blocks

bill@bill-desk:~$ sudo lsblk -f
NAME    FSTYPE            LABEL       UUID
    FSAVAIL FSUSE% MOUNTPOINT
.
.
.
sdj
=E2=94=94=E2=94=80sdj1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  =E2=94=94=E2=94=80md0 ext4
ceef50e9-afdd-4903-899d-1ad05a0780e0
sdk
=E2=94=94=E2=94=80sdk1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  =E2=94=94=E2=94=80md0 ext4
ceef50e9-afdd-4903-899d-1ad05a0780e0
sdl
=E2=94=94=E2=94=80sdl1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  =E2=94=94=E2=94=80md0 ext4
ceef50e9-afdd-4903-899d-1ad05a0780e0
sdm
=E2=94=94=E2=94=80sdm1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  =E2=94=94=E2=94=80md0 ext4                          ceef50e9-afdd-4903-89=
9d-1ad05a0780e0

But then I get confused about the UUIDs. I'm trying to automount the
array using fstab (no unusual settings in there, just defaults), but
I'm not sure which of the two UUIDs above to use. So I look at mdadm
for help:

bill@bill-desk:~$ sudo mdadm --examine --scan
ARRAY /dev/md/0  metadata=3D1.2 UUID=3D06ad8de5:3a7a15ad:88116f44:fcdee150
name=3Dbill-desk:0

However, if I use this UUID starting with "06ad", then I get an error:

bill@bill-desk:~$ sudo mount -all
mount: /media/bill/STUFF: mount(2) system call failed: Structure needs clea=
ning.

But I don't know how to clean it if fsck says it's OK.

On the other hand, if I use the UUID above starting with "ceef", then
it mounts and everything seems OK.

Basically, I don't understand why lsblk lists two UUIDs for the array,
and why mdadm gives the wrong one in terms of mounting. This is where
I was confused before about the UUID changing. Any insight here?

Cheers,
Bill
