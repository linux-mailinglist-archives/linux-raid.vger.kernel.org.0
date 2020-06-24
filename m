Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF0206914
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jun 2020 02:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgFXAeU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 20:34:20 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:41864 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbgFXAeU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 20:34:20 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 13CE825DC2;
        Tue, 23 Jun 2020 20:34:19 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 89349A64B4; Tue, 23 Jun 2020 20:34:18 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24306.40842.482838.682896@quad.stoffel.home>
Date:   Tue, 23 Jun 2020 20:34:18 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     John Stoffel <john@stoffel.org>, linux-raid@vger.kernel.org
Subject: Re: RAID types & chunks sizes for new NAS drives
In-Reply-To: <40bf8a08-61a6-2b50-b9c6-240e384de80d@gmail.com>
References: <rco1i8$1l34$1@ciao.gmane.io>
        <24305.24232.459249.386799@quad.stoffel.home>
        <1ba7c1be-4cb1-29a5-d49c-bb26380ceb90@gmail.com>
        <24306.29793.40893.422618@quad.stoffel.home>
        <40bf8a08-61a6-2b50-b9c6-240e384de80d@gmail.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Ian" == Ian Pilcher <arequipeno@gmail.com> writes:

Ian> On 6/23/20 4:30 PM, John Stoffel wrote:
>> Well, as you add LVM volumes to a VG, I don't honestly know offhand if
>> the areas are pre-allocated, or not, I think they are pre-allocated,
>> but if you add/remove/resize LVs, you can start to get fragmentation,
>> which will hurt performance.

Ian> LVs are pre-allocated, and they definitely can become fragmented.
Ian> That's orthogonal to whether the VG is on a single RAID device or a
Ian> set of smaller adjacent RAID devices.

>> No, you still do not want the partitioned setup, becuase if you lose a
>> disk, you want to rebuild it entirely, all at once.  Personally, 5 x
>> 8Tb disks setup in RAID10 with a hot spare sounds just fine to me.
>> You can survive a two disk failure if it doesn't hit both halves of
>> the mirror.  But the hot spare should help protect you.

Ian> It depends on what sort of failure you're trying to protect against.  If
Ian> you lose the entire disk (because of an electronic/mechanical failure,
Ian> for example) your doing either an 8TB rebuild/resync or (for example)
Ian> 16x 512GB rebuild/resyncs, which is effectively the same thing.

Ian> OTOH, if you have a patch of sectors go bad in the partitioned case,
Ian> the RAID layer is only going to automatically rebuild/resync one of the
Ian> partition-based RAID devices.  To my thinking, this will reduce the
Ian> chance of a double-failure.

Once a disk starts throwing errors like this, it's toast.  Get rid of
it now.  

Ian> I think it's important to state that this NAS is pretty actively
Ian> monitored/managed.  So if such a failure were to occur, I would
Ian> absolutely be taking steps to retire the drive with the failed sectors.
Ian> But that's something that I'd rather do manually, rather than kicking
Ian> off (for example) and 8TB rebuild with a hot-spare.

Sure, if you think that's going to happen when you're on vacation and
out of town and the disk starts flaking out... :-)

>> One thing I really like to do is mix vendors in my array, just so I
>> dont' get caught by a bad batch.  And the RAID10 performance advantage
>> over RAID6 is big.  You'd only get 8Tb (only! :-) more space, but much
>> worse interactive response.

Ian> Mixing vendors (or at least channels) is one of those things that I
Ian> know that I should do, but I always get impatient.

Ian> But do I need the better performance.  Choices, choices ...  :-)

>> Physics sucks, don't it?  :-)

Ian> LOL!  Indeed it does!

>> What I do is have a pair of mirrored SSDs setup to cache my RAID1
>> arrays, to give me more performance.  Not really sure if it's helping
>> or hurting really.  dm-cache isn't really great at reporting stats,
>> and I never bothered to test it hard.

Ian> I've played with both bcache and dm-cache, although it's been a few
Ian> years.  Neither one really did much for me, but that's probably because
Ian> I was using write-through caching, as I didn't trust "newfangled" SSDs
Ian> at the time.

Sure, I understand that.  It makes a difference for me when doing
kernel builds... not that I regularly upgrade.  

>> My main box is an old AMD Phenom(tm) II X4 945 Processor, which is now
>> something like 10 years old.  It's fast enough for what I do.  I'm
>> more concerned with data loss than I am performance.

Ian> Same here.  I mainly want to feel comfortable that I haven't crippled my
Ian> performance by doing something stupid, but as long as the NAS can stream
Ian> a movie to media room it's good enough.

Ian> My NAS has an Atom D2550, so it's almost certainly slower than your
Ian> Phenom.

Yeah, so that's another strike (possibly) against RAID6, since it will
be more CPU overhead, esp if you're running VMs at the same time on
there.

