Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937AB128DFF
	for <lists+linux-raid@lfdr.de>; Sun, 22 Dec 2019 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfLVNE4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 22 Dec 2019 08:04:56 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:48040 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLVNEz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 22 Dec 2019 08:04:55 -0500
Received: (qmail 22642 invoked from network); 22 Dec 2019 13:04:53 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 22 Dec 2019 13:04:53 -0000
Date:   Sun, 22 Dec 2019 14:04:52 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Patrick Pearcy <patrick.pearcy@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: WD MyCloud PR4100 RAID Failure
Message-ID: <20191222130452.GA2580@metamorpher.de>
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
 <20191217182509.GA16121@metamorpher.de>
 <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Dec 21, 2019 at 12:42:35PM -0500, Patrick Pearcy wrote:
> Andreas,
> 
> Sorry for late reply (e-mail was in SPAM folder).   Here is the
> results of MDADM on partition #2.   Thanks for your assistance!!!
> 
> - Best Regards Patrick.

OK, so you have two failed drives (/dev/sda2 and /dev/sdb2) in a RAID 5.

They got kicked from the array for some reason and thus it stopped working.
Unless there are logfiles, it's probably impossible to determine the cause.
The "failed, failed, failed..." should be harmless attempts to re-assemble.

Event Count and Update Time is identical for all drives, so it's unclear
which order this happened in and which drive has better data for recovery.
Sometimes this doesn't matter and sometimes it matters a lot...

So you can only try both possibilities, attempt recovery using
either /dev/sd{a,c,d}2 or /dev/sd{b,c,d}2.

Now, you could do that with an up-to-date Linux/mdadm environment,
keep drives read-only and experiment with copy-on-write overlays:

- https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file
- https://unix.stackexchange.com/a/131927/30851

But it might result in an array that won't run in your NAS
that uses old Linux/mdadm enviornment. You might have to
get rid of new features like bad block log etc., anything 
the older system won't understand and might take offense to.

So in terms of compatibility, it might be better to attempt recovery
directly on the NAS itself, but it probably won't support failsafes
like overlays and old mdadm will behave different from guidance
you find online, so it's riskier.

Personally what I would probably do here is screw it all and just
edit the metadata directly (dd and hexedit). For my arrays I actually
do keep backups of "healthy" metadata just in case it falls apart
for no reason and I'm too lazy to do a more involved recovery.

But of course, there's tons of things that can go wrong here, too :-)

For a quick survey, provided you do have SSH access to the NAS, 
you could create a bunch of virtual drives on a Linux PC:

   for disk in sda2 sdb2 sdc2 sdd2
   do
       # grab a data sample (128M or any size you like)
       ssh root@nas dd if=/dev/"$disk" bs=1M count=128  > "$disk".start
       # grab md 1.0 end-of-disk metadata (by used dev size / super offset)
       ssh root@nas dd if=/dev/"$disk" skip=15619661440 > "$disk".end
       # create a sparse image file [must be on a linux filesystem]
       cp "$disk".start "$disk".img
       truncate -s $((15619661440)) "$disk".img
       cat "$disk".end >> "$disk".img
       losetup --find --show "$disk".img
   done

That should give you 4 readonly loop devices to play with and 
get a better grasp of the situation. The filesystem won't really 
work as most of the data is zeroes, but you could determine what 
(up-to-date) mdadm makes of the metadata.

Another way to do this would be to have the NAS export the drives 
using Network Block Device or similar method. Just make sure to 
keep it read only on the NAS side of things. Don't write until 
you're very sure it won't do any harm.

(If you had plenty of spare drives you could do full copies...)

Regards
Andreas Klauer
