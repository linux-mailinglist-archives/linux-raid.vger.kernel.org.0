Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089FF1745D5
	for <lists+linux-raid@lfdr.de>; Sat, 29 Feb 2020 10:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB2JSf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 29 Feb 2020 04:18:35 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:47706 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgB2JSf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 29 Feb 2020 04:18:35 -0500
Received: from [86.155.171.124] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1j7yGU-0003dJ-53; Sat, 29 Feb 2020 09:18:31 +0000
Subject: Re: Choosing a SATA HD for RAID1
To:     Hans Malissa <hmalissa76@gmail.com>, linux-raid@vger.kernel.org
References: <CAG6BYRzw4i6mtTfEVnMpwGAVW0r=BwODiN+0o-UggiaEyo4VSw@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E5A2C65.3090006@youngman.org.uk>
Date:   Sat, 29 Feb 2020 09:18:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAG6BYRzw4i6mtTfEVnMpwGAVW0r=BwODiN+0o-UggiaEyo4VSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/02/20 02:47, Hans Malissa wrote:
> I'm trying to select suitable SATA HD for RAID1 via mdadm. I've been
> reading through
> https://raid.wiki.kernel.org/index.php/Choosing_your_hardware,_and_what_is_a_device%3Fand
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch but I'm still
> confused. I understand that I can use smartctl in order to determine
> whether a drive is suitable, but what can I do to figure this out
> before I purchase the drives? I've looked at
> https://raid.wiki.kernel.org/index.php/Drive_Data_Sheets but I'm not
> sure which information I'm looking for.

Basically, any drive in an X.1 section that says "Raid drives" is suitable.

> My planned mdadm RAID1 should serve to accommodate the /home
> directory, so I will not need to boot from the array, and the workload
> is going to be moderate. I just need to keep the data in /home secure
> - I'm doing regular backups anyway, but I want to make sure that the
> /home directory remains useable at all times.

> The drives will be used on an openSUSE 12.3 x86_64 system with kernel
> version 3.7.10 and mdadm version 3.2.6 on an Intel Desktop Board
> DH67BL with SATA 6.0 Gb/s or 3.0 Gb/s. I am aware that these are
> somewhat dated, but I have some specialized hardware and software
> installed, and I'm therefore hesitant to update the system with newer
> versions of the OS.

JUST MAKE SURE YOU UPDATE MDADM TO THE LATEST VERSION !!! As a pure
linux program, downloading and installing it from the official sources
is dead easy. You're unlikely to hit problems with the old version but
there have been a LOT of bugs fixed since then that regularly give grief
on the mailing list.

> I'm considering Western Digital WD Gold, either 2TB (WD2005FBYZ) or
> 4TB (WD4003FRYZ). It says 'Enterprise Class', but I cannot find a
> definitive confirmation that the drive does not suffer from the TLER
> or SCT/ERC issue. Is it known whether these drives are suitable for
> mdadm RAID1? Are there drives that are more suitable for my
> application?

I notice that the WD RE4 drive is listed with almost exactly the same
model number you give. It also looks like these drives are known as WD
Gold, so it's extremely likely the drives you are looking at are okay.

Are you in the EU? Certainly in the UK, if I was ordering these drives,
I would do so "in person" and say that they MUST support SCT/ERC. If
they don't, that would give me the right to return them as unsuitable.
And if you buy them mail order, you should also have the right to return
them as unsuitable (especially if they're described as "enterprise").

> Thanks a lot,
> 
I notice you say they are for a raid-1. SCT/ERC isn't that important for
data integrity with a raid 1 because each drive can stand on its own.
Once the data is scattered across multiple drives, that's when you
really need it - if you want to go raid 5 or 6 at some point that's when
you'll wish you'd bought drives that support it.

And on a personal note I'd go for the 4GB drives. I doubt they're much
more expensive, and you won't have to worry about expansion for a lot
longer. I'm outgrowing my 3GB Barracudas (yes I made the mistake of
buying non-SCT/ERC drives), and switching to 4GB Ironwolves.

And if you do upgrade your kernel I would look at throwing dm-integrity
into the mix. It's been around a while but I would be very hesitant at
suggesting it for your ancient setup.

Cheers,
Wol

