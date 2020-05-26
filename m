Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08361C9FD7
	for <lists+linux-raid@lfdr.de>; Fri,  8 May 2020 02:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEHAyK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 20:54:10 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:57278 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgEHAyK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 May 2020 20:54:10 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 2A6C724F1F;
        Thu,  7 May 2020 20:54:08 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 3CD08A62A5; Thu,  7 May 2020 20:54:06 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24244.44462.151185.626440@quad.stoffel.home>
Date:   Thu, 7 May 2020 20:54:06 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     John Stoffel <john@stoffel.org>,
        Roger Heflin <rogerheflin@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: [general question] rare silent data corruption when writing data
In-Reply-To: <adccabc0-529f-e0a9-538f-1e5b784269e4@yandex.pl>
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
        <CAAMCDef6hKJsPw3738KJ0vEEwnVKB-QpTMJ6aSeybse-4h+y6Q@mail.gmail.com>
        <24244.30530.155404.154787@quad.stoffel.home>
        <adccabc0-529f-e0a9-538f-1e5b784269e4@yandex.pl>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Michal" == Michal Soltys <msoltyspl@yandex.pl> writes:

Michal> On 20/05/07 23:01, John Stoffel wrote:
>>>>>>> "Roger" == Roger Heflin <rogerheflin@gmail.com> writes:
>> 
Roger> Have you tried the same file 2x and verified the corruption is in the
Roger> same places and looks the same?
>> 
>> Are these 1tb files VMDK or COW images of VMs?  How are these files
>> made.  And does it ever happen with *smaller* files?  What about if
>> you just use a sparse 2tb file and write blocks out past 1tb to see if
>> there's a problem?

Michal> The VMs are always directly on lvm volumes. (e.g. 
Michal> /dev/mapper/vg0-gitlab). The guest (btrfs inside the guest) detected the 
Michal> errors after we ran scrub on the filesystem.

Michal> Yes, the errors were also found on small files.

Those errors are in small files inside the VM, which is running btrfs
ontop of block storage provided by your thin-lv, right?



disks -> md raid5 -> pv -> vg -> lv-thin -> guest QCOW/LUN ->
filesystem -> corruption


Michal> Since then we recreated the issue directly on the host, just
Michal> by making ext4 filesystem on some LV, then doing write with
Michal> checksum, sync, drop_caches, read and check checksum. The
Michal> errors are, as I mentioned - always a full 4KiB chunks (always
Michal> same content, always same position).

What position?  Is it a 4k, 1.5m or some other consistent offset?  And
how far into the file?  And this LV is a plain LV or a thin-lv?   I'm
running a debian box at home with RAID1 and I haven't seen this, but
I'm not nearly as careful as you.  Can you provide the output of:

   /sbin/lvs --version

too?  

Can you post your:

   /sbin/dmsetup status

output too?  There's a better command to use here, but I'm not an
export.  You might really want to copy this over to the
linux-lvm@redhat.com mailing list as well.

>> Are the LVs split across RAID5 PVs by any chance?

Michal> raid5s are used as PVs, but a single logical volume always uses one only 
Michal> one physical volume underneath (if that's what you meant by split across).

Ok, that's what I was asking about.  It shouldn't matter... but just
trying to chase down the details.


>> It's not clear if you can replicate the problem without using
>> lvm-thin, but that's what I suspect you might be having problems with.

Michal> I'll be trying to do that, though the heavier tests will have to wait 
Michal> until I move all VMs to other hosts (as that is/was our production machnie).

Sure, makes sense.

>> Can you give us the versions of the your tools, and exactly how you
>> setup your test cases?  How long does it take to find the problem?

Michal> Will get all the details tommorow (the host is on up to date debian 
Michal> buster, the VMs are mix of archlinuxes and debians (and the issue 
Michal> happened on both)).

Michal> As for how long, it's a hit and miss. Sometimes writing and reading back 
Michal> ~16gb file fails (the cheksum read back differs from what was written) 
Michal> after 2-3 tries. That's on the host.

Michal> On the guest, it's been (so far) a guaranteed thing when we were 
Michal> creating very large tar file (900gb+). As for past two weeks we were 
Michal> unable to create that file without errors even once.

Ouch!  That's not good.  Just to confirm, these corruptions are all in
a thin-lv based filesystem, right?   I'd be interested to know if you
can create another plain LV and cause the same error.  Trying to
simplify the potential problems.  


>> Can you compile the newst kernel and newest thin tools and try them
>> out?

Michal> I can, but a bit later (once we move VMs out of the host).

>> 
>> How long does it take to replicate the corruption?
>> 

Michal> When it happens, it's usually few tries tries of writing a 16gb file 
Michal> with random patterns and reading it back (directly on host). The 
Michal> irritating thing is that it can be somewhat hard to reproduce (e.g. 
Michal> after machine's reboot).

>> Sorry for all the questions, but until there's a test case which is
>> repeatable, it's going to be hard to chase this down.
>> 
>> I wonder if running 'fio' tests would be something to try?
>> 
>> And also changing your RAID5 setup to use the default stride and
>> stripe widths, instead of the large values you're using.

Michal> The raid5 is using mdadm's defaults (which is 512 KiB these days for a 
Michal> chunk). LVM on top is using much longer extents (as we don't really need 
Michal> 4mb granularity) and the lvm-thin chunks were set to match (and align) 
Michal> to raid's stripe.

>> 
>> Good luck!
>> 
Roger> I have not as of yet seen write corruption (except when a vendors disk
Roger> was resetting and it was lying about having written the data prior to
Roger> the crash, these were ssds, if your disk write cache is on and you
Roger> have a disk reset this can also happen), but have not seen "lost
Roger> writes" otherwise, but would expect the 2 read corruption I have seen
Roger> to also be able to cause write issues.  So for that look for scsi
Roger> notifications for disk resets that should not happen.
>> 
Roger> I have had a "bad" controller cause read corruptions, those
Roger> corruptions would move around, replacing the controller resolved it,
Roger> so there may be lack of error checking "inside" some paths in the
Roger> card.  Lucky I had a number of these controllers and had cold spares
Roger> for them.  The give away here was 2 separate buses with almost
Roger> identical load with 6 separate disks each and all12 disks on 2 buses
Roger> had between 47-52 scsi errors, which points to the only component
Roger> shared (the controller).
>> 
Roger> The backplane and cables are unlikely in general cause this, there is
Roger> too much error checking between the controller and the disk from what
Roger> I know.
>> 
Roger> I have had pre-pcie bus (PCI-X bus, 2 slots shared, both set to 133
Roger> cause random read corruptions, lowering speed to 100 fixed it), this
Roger> one was duplicated on multiple identical pieces of hw with all
Roger> different parts on the duplication machine.
>> 
Roger> I have also seen lost writes (from software) because someone did a
Roger> seek without doing a flush which in some versions of the libs loses
Roger> the unfilled block when the seek happens (this is noted in the man
Roger> page, and I saw it 20years ago, it is still noted in the man page, so
Roger> no idea if it was ever fixed).  So has more than one application been
Roger> noted to see the corruption?
>> 
Roger> So one question, have you seen the corruption in a path that would
Roger> rely on one controller, or all corruptions you have seen involving
Roger> more than one controller?  Isolate and test each controller if you
Roger> can, or if you can afford to replace it and see if it continues.
>> 
>> 
Roger> On Thu, May 7, 2020 at 12:33 PM Michal Soltys <msoltyspl@yandex.pl> wrote:
>>>> 
>>>> Note: this is just general question - if anyone experienced something similar or could suggest how to pinpoint / verify the actual cause.
>>>> 
>>>> Thanks to btrfs's checksumming we discovered somewhat (even if quite rare) nasty silent corruption going on on one of our hosts. Or perhaps "corruption" is not the correct word - the files simply have precise 4kb (1 page) of incorrect data. The incorrect pieces of data look on their own fine - as something that was previously in the place, or written from wrong source.
>>>> 
>>>> The hardware is (can provide more detailed info of course):
>>>> 
>>>> - Supermicro X9DR7-LN4F
>>>> - onboard LSI SAS2308 controller (2 sff-8087 connectors, 1 connected to backplane)
>>>> - 96 gb ram (ecc)
>>>> - 24 disk backplane
>>>> 
>>>> - 1 array connected directly to lsi controller (4 disks, mdraid5, internal bitmap, 512kb chunk)
>>>> - 1 array on the backplane (4 disks, mdraid5, journaled)
>>>> - journal for the above array is: mdraid1, 2 ssd disks (micron 5300 pro disks)
>>>> - 1 btrfs raid1 boot array on motherboard's sata ports (older but still fine intel ssds from DC 3500 series)
>>>> 
>>>> Raid 5 arrays are in lvm volume group, and the logical volumes are used by VMs. Some of the volumes are linear, some are using thin-pools (with metadata on the aforementioned intel ssds, in mirrored config). LVM
>>>> uses large extent sizes (120m) and the chunk-size of thin-pools is set to 1.5m to match underlying raid stripe. Everything is cleanly aligned as well.
>>>> 
>>>> With a doze of testing we managed to roughly rule out the following elements as being the cause:
>>>> 
>>>> - qemu/kvm (issue occured directly on host)
>>>> - backplane (issue occured on disks directly connected via LSI's 2nd connector)
>>>> - cable (as a above, two different cables)
>>>> - memory (unlikely - ECC for once, thoroughly tested, no errors ever reported via edac-util or memtest)
>>>> - mdadm journaling (issue occured on plain mdraid configuration as well)
>>>> - disks themselves (issue occured on two separate mdadm arrays)
>>>> - filesystem (issue occured on both btrfs and ext4 (checksumed manually) )
>>>> 
>>>> We did not manage to rule out (though somewhat _highly_ unlikely):
>>>> 
>>>> - lvm thin (issue always - so far - occured on lvm thin pools)
>>>> - mdraid (issue always - so far - on mdraid managed arrays)
>>>> - kernel (tested with - in this case - debian's 5.2 and 5.4 kernels, happened with both - so it would imply rather already longstanding bug somewhere)
>>>> 
>>>> And finally - so far - the issue never occured:
>>>> 
>>>> - directly on a disk
>>>> - directly on mdraid
>>>> - on linear lvm volume on top of mdraid
>>>> 
>>>> As far as the issue goes it's:
>>>> 
>>>> - always a 4kb chunk that is incorrect - in a ~1 tb file it can be from a few to few dozens of such chunks
>>>> - we also found (or rather btrfs scrub did) a few small damaged files as well
>>>> - the chunks look like a correct piece of different or previous data
>>>> 
>>>> The 4kb is well, weird ? Doesn't really matter any chunk/stripes sizes anywhere across the stack (lvm - 120m extents, 1.5m chunks on thin pools; mdraid - default 512kb chunks). It does nicely fit a page though ...
>>>> 
>>>> Anyway, if anyone has any ideas or suggestions what could be happening (perhaps with this particular motherboard or vendor) or how to pinpoint the cause - I'll be grateful for any.
>> 

