Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD51062F
	for <lists+linux-raid@lfdr.de>; Wed,  1 May 2019 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEAInA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 May 2019 04:43:00 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42180 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfEAInA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 May 2019 04:43:00 -0400
Received: from [81.156.88.27] (helo=[192.168.1.82])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hLkpL-0007xE-7G; Wed, 01 May 2019 09:42:55 +0100
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
To:     Julien ROBIN <julien.robin28@free.fr>, linux-raid@vger.kernel.org
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
 <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
 <20190430092347.GA4799@metamorpher.de>
 <deffabb8-51e8-0120-8c63-ade9e5dfdf9b@free.fr>
 <20190430135152.GA20515@metamorpher.de>
 <8109d116-dd63-15be-2360-7763b9376393@free.fr>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5CC95C0E.7000702@youngman.org.uk>
Date:   Wed, 1 May 2019 09:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <8109d116-dd63-15be-2360-7763b9376393@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 01/05/19 02:49, Julien ROBIN wrote:
> Sorry for the delay
> 

> On 5/1/19 1:39 AM, Wols Lists wrote:> On 30/04/19 09:25, Julien ROBIN
> wrote:
>>> I'm about to play the following command :
>>>
>>> mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdd1 /dev/sde1
>>> /dev/sdb1 --assume-clean
>>>
>>> Is it fine ?
>>
>> You clearly haven't read the raid wiki
>> https://raid.wiki.kernel.org/index.php/Linux_Raid
>>
>> It states NEVER EVER use mdadm --create on an existing array unless you
>> (or the person helping you) really knows what they are doing.
> 
> 
> 
> That's not exact, when I finally decided to pressed "enter" I was way
> more sure than the wiki about what I was doing ;)
> 
> mdadm failed despite the fact I entirely read (and respected) the wiki
> several times, longs times before, and last night too. I finally got the
> information about :
>  * how to determine the correct parameters when you use --create
>  * what are the exact conditions that should be met to use --create to
> reconfigure an access to an existing array (when mdadm or something else
> blocked/misconfigured the array but data are still available in a
> predictable way). Some others case aren't recoverable with --create.
> 
> I found most of those informations elsewhere on the Internet and by
> doing my own tests - there is a lot of things that can be understood and
> explained which would be useful into the wiki. Most interesting parts
> are the cases in which --create can badly rewrite some data on a disk
> (game over), and on which disk (so that in some of those cases, others
> untouched disks may even be used to reconstruct the destroyed one using
> --create with correct parameters - so that the game wasn't really over).
> 
> But unfortunately, all of those things aren't into the wiki.
> Well, just to say that I knew what I was doing, as the wiki asked.
> 
Understandably, I'm a little wary of including stuff on the wiki I don't
understand myself. If there's a case study happens on the list I try and
write it up, but so far I've never had to recover a raid myself, and
with an unrelated full-time job and family, spare time to play is hard
to come by :-)

But really, --create should never be necessary. Like in this case, a
"revert reshape" should have worked.
> 
>> Another thing it says is always update to the latest mdadm. I don't
>> remember you telling us what version you're using, and the problem you
>> describe sounds very much like something I suspect has been fixed in the
>> latest versions.
> 
> Yes sorry for the delay, I forgot to say it into my previous posts - It
> is running Debian 9 (last apt update/upgrade : mdadm 3.4-4+b1 and linux
> 4.9.0-9-amd64)
> 
> I guess that if it was a known bug, corrected some time ago, Debian
> would have included the patch into Debian 9? If I'm true, it means that
> the problem may still exist upstream. If I'm wrong, and Debian "mdadm"
> version is unstable, I won't feel really comfortable using "master / sid
> / experimental" branches for "safety and stability" (that would be
> really uncommon).
> 
Unfortunately, like so many things, I think it's more like "this problem
has gone away", rather than "this problem has been found and fixed".
There've been quite a few fixes recently where deadlocks, incorrect
states, and similar have been fixed and this problem is almost certainly
one of those. So it might have been fixed as a side effect of something
else.

So there's quite a good chance debian mdadm has not had the fix
back-ported. I understand why they don't want to upgrade the version,
but really for a program like this they should. It's simple, and
linux-specific, and backwards-compatible, so it shouldn't cause any
problems.
> 
> By the way, many thanks for your answers. Would be glad if my case
> helped you to find something to improve into mdadm - sorry if not!
> 
Thanks. Hopefully, we'll improve things so we don't get any cases like
this :-) When pigs fly :-)

Cheers,
Wol

