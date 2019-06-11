Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9B417E3
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2019 00:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407857AbfFKWGD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 18:06:03 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:34070 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405693AbfFKWGD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 18:06:03 -0400
Received: (qmail 22724 invoked from network); 11 Jun 2019 22:05:57 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 11 Jun 2019 22:05:57 -0000
Date:   Wed, 12 Jun 2019 00:05:53 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Colt Boyd <coltboyd@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-6 aborted reshape
Message-ID: <20190611220553.GA23970@metamorpher.de>
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
 <20190611141621.GA16779@metamorpher.de>
 <CANrzNyiCF3Fhn30pJ_hWVcGyvaMrRBLAWkPD8o4+TpCDSWTkHw@mail.gmail.com>
 <CANrzNyiQQ1BFV87CRi7gE3-k=10Swg6U8cNa2qUpS3oo0ZW32w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrzNyiQQ1BFV87CRi7gE3-k=10Swg6U8cNa2qUpS3oo0ZW32w@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 12:22:53PM -0500, Colt Boyd wrote:
> > Jun  6 10:12:25 OMV1 kernel: [    2.142877] md/raid:md0: raid level 6
> > active with 5 out of 5 devices, algorithm 2
> > Jun  6 10:12:25 OMV1 kernel: [    2.196783] md0: detected capacity
> > change from 0 to 8998697828352
> > Jun  6 10:12:25 OMV1 kernel: [    3.885628] XFS (md0): Mounting V4 Filesystem
> > Jun  6 10:12:25 OMV1 kernel: [    4.213947] XFS (md0): Ending clean mount
> 
> There is also these:
> 
> Jun  6 10:44:47 OMV1 kernel: [  449.554738] md0: detected capacity
> change from 0 to 11998263771136
> Jun  6 10:44:48 OMV1 postfix/smtp[2514]: 9672F6B4: replace: header
> Subject: DegradedArray event on /dev/md0:OMV1: Subject:
> [OMV1.veldanet.local] DegradedArray event on /dev/md0:OMV1
> Jun  6 10:46:25 OMV1 kernel: [  547.047912] XFS (md0): Mounting V4 Filesystem
> Jun  6 10:46:28 OMV1 kernel: [  550.226215] XFS (md0): Log
> inconsistent (didn't find previous header)
> Jun  6 10:46:28 OMV1 kernel: [  550.226224] XFS (md0): failed to find log head

See, this is very odd.

You had a md0 device with 8998697828352 capacity.

In a 5 disk RAID-6 that would come down to 2999565942784 per disk.

But then (halfhour later) you have a RAID-6 with 11998263771136 capacity.

Went up by 2999565942784... one disk worth.

Now, the way growing RAID works, you only get to use the added capacity 
once the rebuild is finished. Cause otherwise you still have old data 
sitting in the place new data has to go to and it would overwrite 
each other. So you can't use extra capacity before finishing rebuild.

So for some reason, your RAID believed the rebuild to be completed, 
whether or not that was actually the case - the mount failure suggests 
it went very wrong somehow.

So it didn't work as 6-drive, and neither when re-creating as 5-drive, 
guess you have to look at raw data to figure out if it makes any sense 
at all (find an offset that has non-zero non-identical data across 
all drives, see if the parity looks like a 5-disk or 6-disk array).

If it's both (6 drive for lower and 5 drive for higher offsets) 
then it would still be stuck in mid-reshape after all and you'd 
have to create both (two sets of overlays), find the reshape position 
and stitch it together with dm-linear

Or some such method... that's all assuming it wasn't mounted, 
didn't corrupt in other ways while it was in a bad state, 
had no bugs in the kernel itself and all that.

Good luck

Andreas Klauer
