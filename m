Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53200130D87
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 07:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgAFG1D (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 01:27:03 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:45608 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFG1D (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 01:27:03 -0500
Received: (qmail 24902 invoked from network); 6 Jan 2020 06:27:00 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 6 Jan 2020 06:27:00 -0000
Date:   Mon, 6 Jan 2020 07:27:00 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     William Morgan <therealbrewer@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
Message-ID: <20200106062700.GA2563@metamorpher.de>
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Jan 05, 2020 at 02:06:06PM -0600, William Morgan wrote:
> bill@bill-desk:~$ echo ; for x in {c,d,e,f,j,k,l,m}; do echo
> "$x$x$x$x$x$x$x$x" ; echo ; sudo smartctl -H -i -l scterc /dev/sd$x ;
> echo ; echo ; done

Don't use smartctl -H for anything, it'll say passed for broken drives, 
which makes it completely useless for any kind of troubleshooting.

You have to check smartctl -a for any pending, offline, reallocated sectors 
and other things. You should have smartd running and also emailing you, 
with automated selftests on top.
 
> Device is:        Not in smartctl database [for details use: -P showall]

I don't have this type of drive, and some drives are simply unknown,
but see if your smartctl database is up to date anyway.

> investigation showed that the UUIDs of both arrays had changed.

Where do you see changed UUIDs?

| ARRAY /dev/md/0  metadata=1.2 UUID=06ad8de5:3a7a15ad:88116f44:fcdee150
| /dev/sdc1:
|      Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
|      Raid Level : raid5
|     Update Time : Sat Jan  4 16:58:47 2020
|   Bad Block Log : 512 entries available at offset 40 sectors - bad blocks present.
|          Events : 10080
|     Device Role : Active device 0
| /dev/sdd1:
|      Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
|      Raid Level : raid5
|     Update Time : Sat Jan  4 16:56:09 2020
|          Events : 10070
|     Device Role : Active device 1
| /dev/sde1:
|      Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
|      Raid Level : raid5
|     Update Time : Sat Jan  4 16:56:09 2020
|          Events : 10070
|     Device Role : Active device 2
| /dev/sdf1:
|      Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
|      Raid Level : raid5
|     Update Time : Sat Jan  4 16:58:47 2020
|   Bad Block Log : 512 entries available at offset 40 sectors - bad blocks present.
|          Events : 10080
|     Device Role : Active device 3

sdd & sde got kicked for some reason.
Check if you have logfiles for Sat Jan 4 16:56 2020.

For the bad blocks log, check --examine-badblocks

To get rid of it, you can use --update=force-no-bbl 
but you should double check smart before that...
You can also try reading those specific sectors with dd.

If there are no (physical) bad sectors, assemble force 
should work for this array. Otherwise ddrescue instead.

| /dev/sdj1:
|      Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
|      Raid Level : raid5
|     Update Time : Thu Nov 28 09:41:00 2019
|          Events : 5948
|     Device Role : Active device 0
| /dev/sdk1:
|      Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
|      Raid Level : raid5
| Internal Bitmap : 8 sectors from superblock
|     Update Time : Sat Jan  4 16:52:59 2020
|          Events : 38643
|     Device Role : Active device 1
| /dev/sdl1:
|      Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
|      Raid Level : raid5
|     Update Time : Sat Jan  4 16:52:59 2020
|          Events : 38643
|     Device Role : Active device 2
| /dev/sdm1:
|      Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
|      Raid Level : raid5
| Internal Bitmap : 8 sectors from superblock
|     Update Time : Sat Jan  4 16:52:59 2020
|          Events : 38643
|     Device Role : Active device 3

sdj1 got kicked ages ago (Nov 28 2019)

You absolutely must not force that into the array.
It needs a proper re-sync.

And you need proper monitoring and email notification.

Otherwise it looks like this array should still be 
up and running with 3 drives. Do you have dmesg of 
the assembly process?

If there's nothing, you can try mdadm --stop 
and assemble manually here (with out force option, 
and without sdj1 which you can --add later...

For all experiments, use overlays:

https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

But overlays also need 100% working drives so if there are 
any physical bad sectors, consider ddrescue first.

Regards
Andreas Klauer
