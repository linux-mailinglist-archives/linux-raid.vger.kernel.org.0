Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1F241D15
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgHKPWF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 11:22:05 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12480 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgHKPWE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Aug 2020 11:22:04 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1k5W6D-000760-7P; Tue, 11 Aug 2020 16:22:01 +0100
Subject: Re: Recommended filesystem for RAID 6
To:     George Rapp <george.rapp@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <dfa188d3-e217-5a67-a351-d361dea93086@youngman.org.uk>
Date:   Tue, 11 Aug 2020 16:22:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/08/2020 05:42, George Rapp wrote:
> Hello Linux RAID community -
> 
> I've been running an assortment of software RAID arrays for a while
> now (my oldest Creation Time according to 'mdadm --detail' is April
> 2011) but have been meaning to consolidate my five active arrays into
> something easier to manage. This weekend, I finally found enough cheap
> 2TB disks to get started. I'm planning on creating a RAID 6 array due
> to the age and consumer-grade quality of my 16 2TB disks.

SCT/ERC ???
> 
> Use case is long-term storage of many small files and a few large ones
> (family photos and videos, backups of other systems, working copies of
> photo, audio, and video edits, etc.)? Current usable space is about
> 10TB but my end state vision is probably upwards of 20TB. I'll
> probably consign the slowest working disks in the server to an archive
> filesystem, either RAID 1 or RAID 5, for stuff I care less about and
> backups; the archive part can be ignored for the purposes of this
> exercise.

If you haven't got ERC, I'd be more inclined to raid-10 than raid 6. 
Your 16 disks would give you 10TB if you used a 3-way mirror, or 15TB if 
it's a 2-way.
> 
> My question is: what filesystem type would be best practice for my use
> case and size requirements on the big array? (I have reviewed
> https://raid.wiki.kernel.org/index.php/RAID_and_filesystems, but am
> looking for practitioners' recommendations.)  I've run ext4
> exclusively on my arrays to date, but have been reading up on xfs; is
> there another filesystem type I should consider? Finally, are there
> any pitfalls I should know about in my high-level design?

Think about dm-integrity and LVM. Take a look at 
https://raid.wiki.kernel.org/index.php/System2020

I'm working my way through with that system, so that page is an 
incomplete mess of musings at the moment but it might give you ideas.

File systems? Ext4 is a good choice. Remember that filesystems like 
btrfs and zfs are trying to replace raid, lvm etc and subsume it all 
into the filesystem. Do you want a layered KISS setup, or an 
all-things-to-all-men filesystem.

And look at slowly upgrading your disks to decent raid-happy 4TB drives 
or so ... Ironwolves aren't that expensive ...
> 
> Details:
> # uname -a
> Linux backend5 5.7.11-200.fc32.x86_64 #1 SMP Wed Jul 29 17:15:52 UTC
> 2020 x86_64 x86_64 x86_64 GNU/Linux
> # mdadm --version
> mdadm - v4.1 - 2018-10-01
> 
> Finally, and this is inadequate given the value I've received from the
> efforts of this group, but thanks for many years of supporting mdadm
> and helping with software RAID issues, including the recovery
> procedures you have written up and guided me through. This group's
> efforts have saved my data, my bacon, and my sanity on more than one
> occasion.

Thanks very much :-)

Cheers,
Wol
