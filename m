Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12EE1DC17D
	for <lists+linux-raid@lfdr.de>; Wed, 20 May 2020 23:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgETVk7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 May 2020 17:40:59 -0400
Received: from forward104p.mail.yandex.net ([77.88.28.107]:40741 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728019AbgETVk7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 20 May 2020 17:40:59 -0400
X-Greylist: delayed 4266 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 17:40:56 EDT
Received: from mxback9g.mail.yandex.net (mxback9g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:170])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id D694C4B0067F;
        Thu, 21 May 2020 00:40:54 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
        by mxback9g.mail.yandex.net (mxback/Yandex) with ESMTP id tVyaJUKkzJ-esZmMwFG;
        Thu, 21 May 2020 00:40:54 +0300
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id q6qB2FTHLX-erKm4Um8;
        Thu, 21 May 2020 00:40:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [general question] rare silent data corruption when writing data
To:     Chris Murphy <lists@colorremedies.com>
Cc:     John Stoffel <john@stoffel.org>,
        Roger Heflin <rogerheflin@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
 <CAAMCDef6hKJsPw3738KJ0vEEwnVKB-QpTMJ6aSeybse-4h+y6Q@mail.gmail.com>
 <24244.30530.155404.154787@quad.stoffel.home>
 <adccabc0-529f-e0a9-538f-1e5b784269e4@yandex.pl>
 <CAJCQCtRWvsKwwoZejERq=_OLXEa3JQd5RJ65tCz=X=Sp1xtRMQ@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <73d7db88-4fd9-214d-6320-4b5d4f6448b9@yandex.pl>
Date:   Wed, 20 May 2020 23:40:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRWvsKwwoZejERq=_OLXEa3JQd5RJ65tCz=X=Sp1xtRMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Sorry for delayed reply, have had rather busy weeks.

On 20/05/08 05:44, Chris Murphy wrote:
> 
> The 4KiB chunk. What are the contents? Is it definitely guest VM data?
> Or is it sometimes file system metadata? How many corruptions have
> happened? The file system metadata is quite small compared to data.

I haven't looked that precisely (and it would be hard to tell in quite a 
few cases) - but I'll keep that in mind when I resume chasing this bug.

> But if there have been many errors, we'd expect if it's caused on the
> host, that eventually file system metadata is corrupted. If it's
> definitely only data, that's curious and maybe implicates something
> going on in the guest.

As far as metadata goes, so far I haven't seen those - as far as e2fsck 
on ext4 and btrfs-scrub on ext4 could tell. Though in ext4 case I 
haven't ran it that many times - so good point, I'll include fsck after 
each round.

> 
> Btrfs, whether normal reads or scrubs, will report the path to the
> affected file, for data corruption. Metadata corruption errors
> sometimes have inode references, but not a path to a file.
> 

Btrfs pointed to file contents only, so far.

> 
>> >
>> > Are the LVs split across RAID5 PVs by any chance?
>>
>> raid5s are used as PVs, but a single logical volume always uses one only
>> one physical volume underneath (if that's what you meant by split across).
> 
> It might be a bit suboptimal. A single 4KiB block write in the guest,
> turns into a 4KiB block write in the host's LV. That in turn trickles
> down to md, which has a 512KiB x 4 drive stripe. So a single 4KiB
> write translates into a 2M stripe write. There is an optimization for
> raid5 in the RMW case, where it should be true only 4KiB data plus
> 4KiB parity is written (partial strip/chunk write); I'm not sure about
> reads.

Well, I didn't play with current defaults too much - aside large 
stripe_cache_size + the raid running under 2x ssd write-back journal 
(which unfortunately became another issue - there is another thread 
where I'm chasing that bug).

> 
>> > It's not clear if you can replicate the problem without using
>> > lvm-thin, but that's what I suspect you might be having problems with.
>> >
>>
>> I'll be trying to do that, though the heavier tests will have to wait
>> until I move all VMs to other hosts (as that is/was our production machnie).
> 
> Btrfs default Btrfs uses 16KiB block size for leaves and nodes. It's
> still a tiny foot print compared to data writes, but if LVM thin is a
> suspect, it really should just be a matter of time before file system
> corruption happens. If it doesn't, that's useful information. It
> probably means it's not LVM thin. But then what?
> 
>> As for how long, it's a hit and miss. Sometimes writing and reading back
>> ~16gb file fails (the cheksum read back differs from what was written)
>> after 2-3 tries. That's on the host.
>>
>> On the guest, it's been (so far) a guaranteed thing when we were
>> creating very large tar file (900gb+). As for past two weeks we were
>> unable to create that file without errors even once.
> 
> It's very useful to have a consistent reproducer. You can do metadata
> only writes on Btrfs by doing multiple back to back metadata only
> balance. If the problem really is in the write path somewhere, this
> would eventually corrupt the metadata - it would be detected during
> any subsequent balance or scrub. 'btrfs balance start -musage=100
> /mountpoint' will do it.

Will do that too.

> 
> This reproducer. It only reproduces in the guest VM? If you do it in
> the host, otherwise exactly the same way with all the exact same
> versions of everything, and it does not reproduce?
> 

I did reproduce the issue on the host (both in ext4 and btrfs). The host 
has slightly different versions of kernel and tools, but otherwise same 
stuff as one of the guests in which I was testing it.

>>
>> >
>> > Can you compile the newst kernel and newest thin tools and try them
>> > out?
>>
>> I can, but a bit later (once we move VMs out of the host).
>>
>> >
>> > How long does it take to replicate the corruption?
>> >
>>
>> When it happens, it's usually few tries tries of writing a 16gb file
>> with random patterns and reading it back (directly on host). The
>> irritating thing is that it can be somewhat hard to reproduce (e.g.
>> after machine's reboot).
> 
> Reading it back on the host. So you've shut down the VM, and you're
> mounting what was the guests VM's backing disk, on the host to do the
> verification. There's never a case of concurrent usage between guest
> and host?

The hosts test where on a fresh filesystems on a fresh lvm volumes (and 
I hit them on two different thin pools). The issue was also reproduced 
on hosts when all guests were turned off.

> 
> 
>>
>> > Sorry for all the questions, but until there's a test case which is
>> > repeatable, it's going to be hard to chase this down.
>> >
>> > I wonder if running 'fio' tests would be something to try?
>> >
>> > And also changing your RAID5 setup to use the default stride and
>> > stripe widths, instead of the large values you're using.
>>
>> The raid5 is using mdadm's defaults (which is 512 KiB these days for a
>> chunk). LVM on top is using much longer extents (as we don't really need
>> 4mb granularity) and the lvm-thin chunks were set to match (and align)
>> to raid's stripe.
> 
> I would change very little until you track this down, if the goal is
> to track it down and get it fixed.
> 

Yea, I'm keeping the stuff as is (and will try Sarah's suggestions with 
debug options as well).

> I'm not sure if LVM thinp is supported with LVM raid still, which if
> it's not supported yet then I can understand using mdadm raid5 instead
> of LVM raid5.
> 

It probably is, but still while direct dmsetup exposes a few knobs (e.g. 
allows to setup journal), the lvm doesn't allow much besides chunk size. 
That was the primary reason that I sticked to native mdadm.
