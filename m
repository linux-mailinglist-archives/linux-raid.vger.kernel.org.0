Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD42241E33
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgHKQZm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgHKQZm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 12:25:42 -0400
X-Greylist: delayed 151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Aug 2020 09:25:41 PDT
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC608C06174A
        for <linux-raid@vger.kernel.org>; Tue, 11 Aug 2020 09:25:41 -0700 (PDT)
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 2034C432;
        Tue, 11 Aug 2020 16:23:06 +0000 (UTC)
Date:   Tue, 11 Aug 2020 21:23:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     George Rapp <george.rapp@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: Recommended filesystem for RAID 6
Message-ID: <20200811212305.02fec65a@natsu>
In-Reply-To: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 11 Aug 2020 00:42:33 -0400
George Rapp <george.rapp@gmail.com> wrote:

> Use case is long-term storage of many small files and a few large ones
> (family photos and videos, backups of other systems, working copies of
> photo, audio, and video edits, etc.)? Current usable space is about
> 10TB but my end state vision is probably upwards of 20TB. I'll
> probably consign the slowest working disks in the server to an archive
> filesystem, either RAID 1 or RAID 5, for stuff I care less about and
> backups; the archive part can be ignored for the purposes of this
> exercise.
> 
> My question is: what filesystem type would be best practice for my use
> case and size requirements on the big array? (I have reviewed
> https://raid.wiki.kernel.org/index.php/RAID_and_filesystems, but am
> looking for practitioners' recommendations.)  I've run ext4
> exclusively on my arrays to date, but have been reading up on xfs; is
> there another filesystem type I should consider? Finally, are there
> any pitfalls I should know about in my high-level design?

Whichever filesystem you choose, you will end up with a huge single point of
failure, and any trouble with that FS or the underlying array put all your
data instantly at risk. "But RAID6" -- what about a SATA controller failure,
or a flaky cabling/PSU/backplane, which disconnects, say, 4 disks at once "on
the fly". What about a sudden power loss amidst heavy write load. And so on.

First of all, ask yourself -- is all of this backed up? If no, then go and buy
more drives until the answer is yes. With current drive prices, or as you say,
with having lots of spare old drives lying around, there's no excuse to leave
anything non-trivial not backed up.

Secondly -- if all of this... is BACKED UP ANYWAY, why even run RAID? And with
RAID6, even waste 2 more drives for redundancy. Do you need 24x7 uptime of your
home NAS, do you have hotswap cages, do you require that the server absolutely
stays online while a disk is being replaced.

Most likely you do not. And the RAID's main purpose in that case is to just
have a unified storage pool, for the convenience of not having to manage free
space across so many drives. But given the above, I would suggest leaving the
drives with their individual FSes, and just running MergerFS on top: 
https://www.teknophiles.com/2018/02/19/disk-pooling-in-linux-with-mergerfs/

Massively simpler and more resilient, no longer a huge array which also needs
to be painstakingly reshaped up and down when you add/remove space. Just add an
extra disk and done. Of course no redundancy, hence the backups part. If a
drive fails, everything that was on that drive is gone. But the best part is,
ONLY what was on that drive. Plug a new one, restore the lost files from
backup, done. One caveat, need to keep a record of what's on each drive, I do
that with a command like "find /mnt/* > /somewhere/list-$date.txt", kept
periodically updated. Yes I use such solution myself now, having migrated from
a Btrfs on top of MD RAID, after a "flaky cabling"-induced complete failure of
the array-wide FS.

For the FS considerations, the dealbreaker of XFS for me is its inability to
be shrunk. The ivory tower people do not think that is important enough, but
for me that limits the FS applicability severely. Also it loved truncating
currently-open files to zero bytes on power loss (dunno if that's been
improved). IIRC JFS can't be shrunk either, but it seems like that one can be
considered legacy at this point. The remaining filesystems that can be freely
resized are Ext4 and Btrfs. In any case, do not go with Btrfs' built in RAID
yet:
https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

-- 
With respect,
Roman


