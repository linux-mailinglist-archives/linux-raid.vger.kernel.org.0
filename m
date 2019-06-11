Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F272A3CE93
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfFKOXF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 10:23:05 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:55564 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbfFKOXF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 10:23:05 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 10:23:05 EDT
Received: (qmail 23080 invoked from network); 11 Jun 2019 14:16:21 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 11 Jun 2019 14:16:21 -0000
Date:   Tue, 11 Jun 2019 16:16:21 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Colt Boyd <coltboyd@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-6 aborted reshape
Message-ID: <20190611141621.GA16779@metamorpher.de>
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Jun 08, 2019 at 10:47:30AM -0500, Colt Boyd wrote:
> I’ve also since tried to reassemble it with the following create but
> the XFS fs is not accessible:
> 'mdadm --create /dev/md0 --data-offset=1024 --level=6 --raid-devices=5
> --chunk=1024K --name=OMV:0 /dev/sdb1 /dev/sde1 /dev/sdc1 /dev/sdd1
> /dev/sdf1 --assume-clean --readonly'

Well, all sorts of things can go wrong with a re-create.
You should be using overlays for such experiments.

https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

Also, which kernel version are you running?

I think there was a RAID6 bug recently in kernel 5.1.3 or so.

https://www.spinics.net/lists/raid/msg62645.html

> /dev/sdg1:
>           Magic : a92b4efc
>         Version : 1.2
>     Feature Map : 0x1
>      Array UUID : f8fdf8d4:d173da32:eaa97186:eaf88ded
>            Name : OMV:0
>   Creation Time : Mon Feb 24 18:19:36 2014
>      Raid Level : raid6
>    Raid Devices : 6
> 
>  Avail Dev Size : 5858529280 (2793.56 GiB 2999.57 GB)
>      Array Size : 11717054464 (11174.25 GiB 11998.26 GB)
>   Used Dev Size : 5858527232 (2793.56 GiB 2999.57 GB)
>     Data Offset : 2048 sectors
>    Super Offset : 8 sectors
>    Unused Space : before=1960 sectors, after=2048 sectors
>           State : clean
>     Device UUID : 92e022c9:ee6fbc26:74da4bcc:5d0e0409
> 
> Internal Bitmap : 8 sectors from superblock
>     Update Time : Thu Jun  6 10:24:34 2019
>   Bad Block Log : 512 entries available at offset 72 sectors
>        Checksum : 8f0d9eb9 - correct
>          Events : 1010399
> 
>          Layout : left-symmetric
>      Chunk Size : 1024K
> 
>    Device Role : Active device 5
>    Array State : AAAAAA ('A' == active, '.' == missing, 'R' == replacing)

This already believes to have 6 drives, not in mid-reshape.
What you created has 5 drives... that's a bit odd.

It could still be normal, metadata for drives that get kicked out 
is no longer updated after all, and I haven't tested it myself...

--examine of the other drives (before re-create) would be interesting.
If those are not available, maybe syslogs of the original assembly, 
reshape and subsequent recreate.

Otherwise you have to look at the raw data (or try blindly) 
to figure out the data layout.

Please use overlays for experiments...

Good luck.

Regards
Andreas Klauer
