Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69117051E
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2019 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfGVQMJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 12:12:09 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:56088 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfGVQMJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 12:12:09 -0400
Received: (qmail 25231 invoked from network); 22 Jul 2019 16:12:06 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 22 Jul 2019 16:12:06 -0000
Date:   Mon, 22 Jul 2019 18:12:06 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: slow BLKDISCARD on RAID10 md block devices
Message-ID: <20190722161206.GA4560@metamorpher.de>
References: <20190717090200.GD2080@wantstofly.org>
 <20190717113352.GA13079@metamorpher.de>
 <20190722130127.GH2080@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722130127.GH2080@wantstofly.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jul 22, 2019 at 04:01:27PM +0300, Lennert Buytenhek wrote:
> I tried something like this, and indeed, as you say, xfs seems to trim
> more than you ask it to.  From looking at the code, it seems benign --
> it just seems to trim allocation groups (AGs) that overlap with your
> range, and so it can end up trimming a larger range than intended.
> Unfortunately, my allocation groups are sized such that trimming the
> minimum range at a time still produces long stalls. :-/

Crazy Idea #1:

fallocate a file using most of free space,
filefrag / fiemap its physical address block ranges, 
translate those to physical address ranges on the member devices,
then blkdiscard -o offset -l length the member devices directly,
bypassing the RAID layer entirely.

That would be blazing fast (depending on free space fragmentation).

However.

To pull this off you need to be super confident in your understanding 
of mdadm's RAID layout. And perhaps even then actually write some 
boundary markers to the file and verify it ends up where you expect.
Otherwise it's a fast lane ticket to the data loss department...

Crazy Idea #2:

While on the topic of fallocate, I notice with XFS it blocks TRIM, 
even though that may be a bug as well. Not much reason to not trim 
unwritten extents. Guess they're used too rarely to matter much...

So you can perhaps use this indirectly, do a fallocate-fstrim dance 
for more finegrained control:

  # df -B 1G .
  Filesystem     1G-blocks  Used Available Use% Mounted on
  /dev/loop0          1024     2      1023   1% /mnt/tmp
  # fallocate --length 1010G trim.todo
  # df -B 1G .
  Filesystem     1G-blocks  Used Available Use% Mounted on
  /dev/loop0          1024  1012        13  99% /mnt/tmp
  # fstrim -v .
  .: 13.5 GiB (14495330304 bytes) trimmed

  # fallocate --length 10G trim.done
  # truncate -s 1000G trim.todo
  # fstrim -v .
  .: 13.5 GiB (14495330304 bytes) trimmed

  # fallocate --length 20G trim.done
  # truncate -s 990G trim.todo
  # fstrim -v .
  .: 13.5 GiB (14495330304 bytes) trimmed

... well, something like that, maybe ...

You grow trim.done in every step and shrink trim.todo in every step, 
so the window that will be trimmed moves along until you covered all 
the free space.

At the end you have a very large trim.todo file of which you're sure 
the space inside has already been trimmed.

And if you keep this file around (monitor free space, shrink or grow 
as needed), you can effectively implement your very own "don't re-trim 
previously trimmed space" logic in XFS.

And unlike ext4's it would survive reboots.

So much for crazy ideas, still hope it can be improved in kernel somehow.

Regards
Andreas Klauer
