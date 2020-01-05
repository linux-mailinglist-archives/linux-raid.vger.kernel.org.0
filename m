Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893A7130A3F
	for <lists+linux-raid@lfdr.de>; Sun,  5 Jan 2020 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgAEW0t (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 Jan 2020 17:26:49 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:19180 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgAEW0t (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 5 Jan 2020 17:26:49 -0500
Received: from [86.147.199.110] (helo=[192.168.1.162])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ioE0i-000406-5Z; Sun, 05 Jan 2020 22:04:37 +0000
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     William Morgan <therealbrewer@gmail.com>,
        linux-raid@vger.kernel.org
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk>
Date:   Sun, 5 Jan 2020 22:04:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/01/2020 20:06, William Morgan wrote:
> Hello,
> 
> I'm new here and likely don't understand the etiquette. Please be
> patient with me.

You're fine :-) Beautiful problem report, I have to say ...
> 
> I have two raid 5 arrays connected through an LSI 9601-16e (SAS2116)
> card. I also have a few other single drives connected to the SAS card.
> I was mounting both arrays through fstab using the original UUIDs of
> the arrays. The system had been working great, remounting both arrays
> on boot, etc. until yesterday when I shut the system off to remove one
> of the single drives.
> I didn't touch the raid array drives at all, but when I rebooted the
> system, neither raid array mounted successfully. When I checked their
> status, I noticed both arrays had changed to "inactive", and further
> investigation showed that the UUIDs of both arrays had changed.
> I started investigating using the troubleshooting page of the Linux
> raid wiki. I tried to reassemble (no --force however) but it wasn't
> successful. Here is a summary of what I noticed:
> 
> Smart data seems OK for all drives.I found some reports of bad blocks,
> non-identical event counts, and some missing array members.

One array looks pretty good, the other one less so ...
> 
> md0 consists of 4x 8TB drives:
> 
> role drive events state
>   0    sdc   10080  A.AA (bad blocks reported on this drive)
>   1    sdd   10070  AAAA
>   2    sde   10070  AAAA
>   3    sdf   10080  A.AA (bad blocks reported on this drive)
> 
This array looks good. I'm wondering whether the new UUID is something 
to do with the fact that it thinks it's a raid0. I'm sure I've seen this 
before, and it's not anything to worry about. Plus all your event counts 
are very close. My main concern is that two drives have one event count, 
and two have the other, which means that a little data loss is a 
distinct possibility.

Look at the page on overlays, if you've got a spare disk you can put 
overlay files on, then do a force-assemble, and everything will probably 
be (almost) fine. Do a couple of fscks until it's clean, check 
everything's okay, and if it is you can do a force-assemble on the array 
directly. So this array is pretty good.
> 
> md1 consists of 4x 4TB drives:
> 
> role drive events state
>   0    sdj    5948  AAAA
>   1    sdk   38643  .AAA
>   2    sdl   38643  .AAA
>   3    sdm   38643  .AAA

This array *should* be easy to recover. Again, use overlays, and 
force-assemble sdk, sdl, and sdm. DO NOT include sdj - this was ejected 
from the array a long time ago, and including it will seriously mess up 
your array. This means you've actually been running a 3-disk raid-0 for 
quite a while, so provided nothing more goes wrong, you'll have a 
perfect recovery, but any trouble and your data is toast. Is there any 
way you can ddrescue these three drives before attempting a recovery?

If it does assemble fine with overlays, then assemble the array with 
those three drives, then re-add sdj. This is where the danger lies - sdj 
will have to be rebuilt and that will place the other three drives in 
danger.
> 
> These are the things that stand out to me, but there may be other
> issues I've overlooked. I have included the full output of the
> troubleshooting commands below. I don't understand why the UUIDs would
> have changed, but even after mkconf created a new mdadm.conf file, the
> arrays would not assemble or mount. And I don't know how to fix the
> situation without losing data. Please let me know how to proceed.
> 
> Thanks,
> Bill
> 
Hopefully some more experienced posters will chime in and add more info, 
but if you're happy using overlays, then you can check out my advice 
safely and if it works recover your arrays.

Cheers,
Wol
