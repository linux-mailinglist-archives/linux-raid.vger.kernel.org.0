Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FDC123366
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLQRWe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 12:22:34 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:26606 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfLQRWe (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Dec 2019 12:22:34 -0500
Received: from [86.148.134.145] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ihGYI-0005p4-9E; Tue, 17 Dec 2019 17:22:31 +0000
Subject: Re: WD MyCloud PR4100 RAID Failure
To:     Patrick Pearcy <patrick.pearcy@gmail.com>,
        linux-raid@vger.kernel.org
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DF9173F.6000203@youngman.org.uk>
Date:   Tue, 17 Dec 2019 17:58:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 17/12/19 16:54, Patrick Pearcy wrote:
> Hi everyone, I am hoping that someone is able to assist me with
> recreating my 'failed' WD My Cloud PR4100 RAID.  I experienced a
> series of short power interruptions and despite having a UPS and dual
> power sources for my WD MyCloud, it reported that I had: (a) failed
> drive 1, (b) installed a new drive 1, (c) failed drive 2 and (d)
> installed a new drive 2.   ALL without my touching the system.  I have
> a little knowledge of Linux (enough to follow instructions) so I was
> able to run SMARTCTL on all 4 drives (no errors) and MDADM examine
> (see below).  When trying to force an assemble, I receive the error
> that no superblock was found on sda or sdb.  WD support referred me to
> a data recovery service that wants me to send all disks to them.  I
> believe the data is still present, I just don't know how to get the
> array back.  Any assistance or suggestions would be greatly
> appreciated.  Thanks!  Patrick
> 
> mdadm - v2.6.7.1 - 15th October 2008

Ouch! That is an OLD version of mdadm. Is that the version that comes
with the WD?

The drives themselves. Are they 2GB drives? That's tiny by today's
standards. I'd get a big 500GB or 1TB drive and image them on to the new
drive. That way you have a backup, and you can play.

Can you run a modern version of mdadm over the drives? It's now up to 4.0.

And you say you can follow instructions. Did you find the linux raid
wiki? I guess not since it asks for rather more information, including
things like mdadm --detail, and lsdrv.

https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
https://raid.wiki.kernel.org/index.php/Asking_for_help

If it has lost the superblock, I'm guessing an mdadm --create will fix
it BUT DO NOT EVEN *T*H*I*N*K* of running that over the original drives
- if you back them up on to a big drive you can run it on the backups.

I'm optimistic you can get your data back. But you might need some help
from the experts. And try and put those backups I mentioned on a
snapshot-based filesystem like lvm or btrfs, so you can snapshot it, try
various rescue tactics, and revert to the snapshot if they don't work.

Cheers,
Wol
