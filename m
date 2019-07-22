Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210FC70050
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2019 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfGVM5J (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 08:57:09 -0400
Received: from hmm.wantstofly.org ([138.201.34.84]:33672 "EHLO
        mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVM5I (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 08:57:08 -0400
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id 1D80F7F322; Mon, 22 Jul 2019 15:57:04 +0300 (EEST)
Date:   Mon, 22 Jul 2019 15:57:04 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org, Shaohua Li <shli@kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
Message-ID: <20190722125704.GG2080@wantstofly.org>
References: <20190717090200.GD2080@wantstofly.org>
 <ba5f3065-2659-866e-d431-73d9bb7b7295@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5f3065-2659-866e-d431-73d9bb7b7295@cloud.ionos.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 17, 2019 at 05:04:27PM +0200, Guoqing Jiang wrote:

> > I've been running into an issue with background fstrim on large xfs
> > filesystems on RAID10d SSDs taking a lot of time to complete and
> > starving out other I/O to the filesystem.  There seem to be a few
> > different issues involved here, but the main one appears to be that
> > BLKDISCARD on a RAID10 md block device sends many small discard
> > requests down to the underlying component devices (while this doesn't
> > seem to be an issue for RAID0 or for RAID1).
> > 
> > It's quite easy to reproduce this with just using in-memory loop
> > devices, for example by doing:
> > 
> >          cd /dev/shm
> >          touch loop0
> >          touch loop1
> >          touch loop2
> >          touch loop3
> >          truncate -s 7681501126656 loop0
> >          truncate -s 7681501126656 loop1
> >          truncate -s 7681501126656 loop2
> >          truncate -s 7681501126656 loop3
> >          losetup /dev/loop0 loop0
> >          losetup /dev/loop1 loop1
> >          losetup /dev/loop2 loop2
> >          losetup /dev/loop3 loop3
> > 
> >          mdadm --create -n 4 -c 512 -l 0 --assume-clean /dev/md0 /dev/loop[0123]
> >          time blkdiscard /dev/md0
> > 
> >          mdadm --stop /dev/md0
> > 
> >          mdadm --create -n 4 -c 512 -l 1 --assume-clean /dev/md0 /dev/loop[0123]
> >          time blkdiscard /dev/md0
> > 
> >          mdadm --stop /dev/md0
> > 
> >          mdadm --create -n 4 -c 512 -l 10 --assume-clean /dev/md0 /dev/loop[0123]
> >          time blkdiscard /dev/md0
> > 
> > This simulates trimming RAID0/1/10 arrays with 4x7.68TB component
> > devices, and the blkdiscard completion times are as follows:
> > 
> >          RAID0   0m0.213s
> >          RAID1   0m2.667s
> >          RAID10  10m44.814s
> 
> IIUC, there is no dedicated function for discard request for raid10
> and raid1, raid1 has better performance than raid10 because of the new
> barrier mechanism or it doesn't need to translate the address from
> virtual to physical.

Thank you for the reply and the helpful pointer!

I had another look at this, and I noticed something odd.

When I build a RAID10 array as above, and I blkdiscard the whole
array, and use blktrace to look at the IOs being sent down to one of
the individual component devices during this process, it starts off
looking fairly normal, discarding in 512 KiB chunks:

  7,0    1       89     3.740837190   846  A   D 264192 + 1024 <- (9,0) 0
  7,0    1       90     3.740848185   846  A   D 265216 + 1024 <- (9,0) 2048
  7,0    1       91     3.740854505   846  A   D 266240 + 1024 <- (9,0) 4096
  7,0    1       92     3.740860124   846  A   D 267264 + 1024 <- (9,0) 6144
  7,0    1       93     3.740871191   846  A   D 268288 + 1024 <- (9,0) 8192
[...]
  7,0    1     4182     3.752027147   846  A   D 4455424 + 1024 <- (9,0) 8382464
  7,0    1     4183     3.752028736   846  A   D 4456448 + 1024 <- (9,0) 8384512
  7,0    1     4184     3.752030923   846  A   D 4457472 + 1024 <- (9,0) 8386560

But then it starts discarding only the first 4 KiB sector of every
subsequent 512 KiB chunk, skipping holes of 508 KiB at a time:

  7,0    1     4185     3.752034845   846  A   D 4459512 + 8 <- (9,0) 8389624
  7,0    1     4186     3.752037523   846  A   D 4460536 + 8 <- (9,0) 8391672
  7,0    1     4187     3.752039573   846  A   D 4461560 + 8 <- (9,0) 8393720
  7,0    1     4188     3.752042164   846  A   D 4462584 + 8 <- (9,0) 8395768
[...]
  7,0    1     8278     3.765219445   846  A   D 8650744 + 8 <- (9,0) 16772088
  7,0    1     8279     3.765221463   846  A   D 8651768 + 8 <- (9,0) 16774136
  7,0    1     8280     3.765224025   846  A   D 8652792 + 8 <- (9,0) 16776184

It eventually does get around to discarding the 508 KiB holes it left
behind... but... it discards those in reverse (downwards) block order:

  7,0    1     8281     3.765225941   846  A   D 8651776 + 1016 <- (9,0) 16775168
  7,0    1     8282     3.765227699   846  A   D 8650752 + 1016 <- (9,0) 16773120
  7,0    1     8283     3.765228878   846  A   D 8649728 + 1016 <- (9,0) 16771072
  7,0    1     8284     3.765230104   846  A   D 8648704 + 1016 <- (9,0) 16769024
  7,0    1     8285     3.765231271   846  A   D 8647680 + 1016 <- (9,0) 16766976
  7,0    1     8286     3.765233010   846  A   D 8646656 + 1016 <- (9,0) 16764928
[...]
  7,0    1    12374     3.771357037   846  A   D 4460544 + 1016 <- (9,0) 8392704
  7,0    1    12375     3.771358244   846  A   D 4459520 + 1016 <- (9,0) 8390656
  7,0    1    12376     3.771359690   846  A   D 4458496 + 1016 <- (9,0) 8388608

This dance seems to continue for the rest of the discard process:
discard 4 KiB out of every 512 KiB block in forward block order, and
then discard the last 508 KiB of every 512 KiB block in backward
block order.

(I'm seeing the same behavior on "real" hardware.)

Most of my kernel experience and contributions are related to arch/arm/
and net/, and I can't say I know much about storage at all, but I think
I'll get to the bottom of this issue eventually. :-)
