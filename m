Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5C134188
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jan 2020 13:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgAHMVh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jan 2020 07:21:37 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:53398 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHMVg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jan 2020 07:21:36 -0500
Received: (qmail 5548 invoked from network); 8 Jan 2020 12:21:32 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 8 Jan 2020 12:21:32 -0000
Date:   Wed, 8 Jan 2020 13:21:32 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Marco Heiming <myx00r@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Raid 5 cannot be re-assembled after disk was removed
Message-ID: <20200108122132.GA16146@metamorpher.de>
References: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
 <20200108100327.GA15483@metamorpher.de>
 <CAEWf3EAD72E7McA-=WnBSquvKhJKh9jsEExJ2Sus9hfSH=HSpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEWf3EAD72E7McA-=WnBSquvKhJKh9jsEExJ2Sus9hfSH=HSpA@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jan 08, 2020 at 11:28:32AM +0100, Marco Heiming wrote:
> Can't i assemble the array with the (hopefully) fine 2 disks first

The disks may be fine, (one can only hope), but if the data on those 
disks has been reshaped to match the layout of a 4-disk raid 5 array, 
then you must have (at minimum) three disks to get data whole instead 
of fragmented junk.

To illustrate (simplified),

Old layout:

1 2 3
A B X
C X D
X E F
G H X
I X J
X K L

New layout:

1 2 3 4
A B C X
D E X F
G X H I
X J K L

Disks = 1 2 3 ...
Data chunks = A B C D E F ...
Parity = X

If you only have disk 1 and 2 you have data A B D E G J
without disk 3/4 you missing data C F H I K L
so every other data block is gone, leaving you with 
something that resembles swiss cheese, it's full of holes.

You still have parity X but it's useless without (n-1) total disks.
RAID 5 parity is a puzzle that can't have more than one missing piece.
G X H = I but G X = neither H nor I, impossible to recover valid data.

> (without redudancy) and then add the 3rd disk to build up redudancy
> and resync to it?

You simply cannot rebuild with two missing disks in a RAID 5.
It only allows for one missing disk.

> Or recreate with --assume-clean with 3 disks?

If the data has been reshaped to 4 disk layout, 
there is no 3 disk raid to recover anymore.
If you recreate, it'd have to be with 4 disks (3 disks + 1 missing)

If you re-create a 3 disk array (2 disks + 1 missing), 
at most you'll recover parts of data that may have 
been untouched from the reshape at end of the disks 
(the additional capacity area) - that's if you're lucky.

> I could also try to reconnect the defective disk - it is still working
> but has some read errors - and add it back to the array if this helps.

If the defective drive was removed *before* the reshape it will 
not help much in the recovery. It might give you a few more 
puzzle pieces to play with but not restore the whole picture.

It's difficult for me to follow which drive is which in your case
(or why metadata seems to be missing from your drives)
You need to identify the drive that the data was reshaped to.
This is the central key that makes or breaks your recovery.

In any case you should not write anything to any drive anymore, 
use overlays for everything at this point.

https://raid.wiki.kernel.org/index.php/Recovering_a_damaged_RAID#Making_the_harddisks_read-only_using_an_overlay_file

Regards
Andreas Klauer
