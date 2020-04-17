Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5301AE89B
	for <lists+linux-raid@lfdr.de>; Sat, 18 Apr 2020 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgDQXY5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Apr 2020 19:24:57 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:60302 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgDQXY5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 17 Apr 2020 19:24:57 -0400
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 19:24:57 EDT
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 03HNOquo003412;
        Sat, 18 Apr 2020 00:24:52 +0100
From:   Nix <nix@esperi.org.uk>
To:     antlists <antlists@youngman.org.uk>
Cc:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
        <875ze23pfm.fsf@vps.thesusis.net>
        <f415cfb3-9612-d29d-17c1-d34405233519@peter-speer.de>
        <13d82398-337f-6dae-cfe8-5f23ae413c23@youngman.org.uk>
Emacs:  where editing text is like playing Paganini on a glass harmonica.
Date:   Sat, 18 Apr 2020 00:24:52 +0100
In-Reply-To: <13d82398-337f-6dae-cfe8-5f23ae413c23@youngman.org.uk>
        (antlists@youngman.org.uk's message of "Tue, 14 Apr 2020 21:05:25
        +0100")
Message-ID: <87d085elvf.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=3 Fuz1=3 Fuz2=3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14 Apr 2020, antlists@youngman.org.uk stated:

> The CPU starts, jumps into the mobo rom, and then looks for an EFI
> partition on the disk. Because it understands VFAT, it then reads the

Side note: technically it doesn't understand VFAT, exactly, and some
vendors (e.g. Apple) provide entirely separate drivers to read the ESP.
However, the fs is *very close* to VFAT (actually FAT32), and in
practice Linux's vfat driver works fine.

See s13.3 "File System Format" in
<https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf>
(and similarly-named sections in earlier spec versions).

> I don't quite get this myself, but this is where it gets confusing.
> EFI I think offers you a choice of bootloaders, which CAN include
> grub, which then offers you a choice of operating systems. But EFI can
> offer you a list of operating systems, too, which is why I said why
> did you want to use grub?

... which is why I don't. In my experience grub(2) is just another thing
to go horribly wrong on an EFI system, with yet *another* set of driver
reimplementations, some of which are downright dangerous. (The XFS one,
for instance, which at one point assumed it could just access the fs as
it was on the disk, when you can't do any such thing without replaying
the journal first: XFS explicitly does not flush the journal on shutdown
because it's a waste of time, given that the journal must always be
present to access the fs anyway: but this means that accessing the fs
without going through the journal can omit any number of transactions,
quite possibly including the transactions that wrote out the kernel you
expected to be booting. Thankfully XFS has since evolved to the point
where grub simply can't read the fs at all -- sparse inode allocation
and CRC'd metadata both break it -- so the temptation to try to use it
on such filesystems is removed.)
