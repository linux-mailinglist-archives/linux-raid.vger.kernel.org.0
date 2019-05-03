Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7884013370
	for <lists+linux-raid@lfdr.de>; Fri,  3 May 2019 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfECR6t (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 May 2019 13:58:49 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:55526 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfECR6s (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 3 May 2019 13:58:48 -0400
Received: from [192.168.28.40] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4F5C5B0053F
        for <linux-raid@vger.kernel.org>; Fri,  3 May 2019 19:58:43 +0200 (CEST)
From:   Julien ROBIN <julien.robin28@free.fr>
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
To:     linux-raid@vger.kernel.org
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
 <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
 <20190430092347.GA4799@metamorpher.de>
 <deffabb8-51e8-0120-8c63-ade9e5dfdf9b@free.fr>
 <20190430135152.GA20515@metamorpher.de>
 <8109d116-dd63-15be-2360-7763b9376393@free.fr>
 <5CC95C0E.7000702@youngman.org.uk>
 <c32c4ffa-cfbc-7c74-c035-6f23b91c923f@free.fr>
Message-ID: <88320b1f-645b-046a-b092-4e2558a5e1e6@free.fr>
Date:   Fri, 3 May 2019 19:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c32c4ffa-cfbc-7c74-c035-6f23b91c923f@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It seems that the problem didn't happened after upgrading to Debian 10 
(mdadm 4.1-1) - this is not a proof, but a hope that it is solved! Let's 
hope nobody will never complain for such a problem starting from this 
version.

----------------------------------------------------------------------
Given the fact RAID is a pretty fixed standard for a long time already, 
seeing every subject into the mailing list archive (unknown errors that 
nobody understands clearly, reverts, patches everywhere, deadlocks, null 
pointers, RFC...), after so much development years about mdadm, tends to 
indicates that mdadm isn't converging into something really stable. 
Unless it's really slow but progressing the right way ?

Only a precise bug tracking system would have the ability to provide 
that information in a dependable way

Also as it's about a critical feature aiming to protect valuable data as 
much as possible (even if it's not a sufficient backup in case something 
is overwritten or several disks are lost), changes that are not proved to be
  * mandatory
  * proven to solve a really existing bug or problem,
  * proven to have no chance of adding any new bug or any unnecessary 
complexity
should probably better be forbidden in such a critical functionality. In 
the other hand I also understand that freedom is an essential part of 
this kind of projects, but here this is quite critical!
----------------------------------------------------------------------

Anyway that's may be all for this case, still thanks for a work that I'm 
still happy to be able to use (yet a little more cautious than before!).

I'll probably propose some bits of new documentation and helps about 
serious failures recovery into the wiki, using some knowledge and 
observations I earned during my searches and tests (after ensuring that 
none of those bits of information could turn to be wrong, or likely to 
introduce any wrong behavior or data lost - because this can be really 
serious and distressing subject).

Best regards
Julien


On 5/1/19 6:13 PM, Julien ROBIN wrote:
> Hi folks,
> 
> tl;dr : Some more information/confirmation, and mdadm 4.1-1 test coming.
> 
> Even if I have some difficulty to reproduce the issue into another 
> computer (it happened only once in a big amount of tests), on the real 
> server, it failed exactly the same a second time during the night, so it 
> seems that this can be repeated more easily on it. This time the ext4 
> filesystem wasn't mounted.
> 
> So I'll upgrade it to Debian 10 which is using Linux 4.19 and mdadm 
> 4.1-1, and do the test again; in order to tell you if the problem is 
> still here.
> 
> By the way, doing some tests on another computer, playing --create over 
> an existing array after switching from 3.4-4 to 4.1-1, needs to specify 
> the data-offset, because it changed. If changed and not given, the array 
> filesystem isn't readable until you create it with the right data-offset 
> value.
> 
> That is, in case of same failure (is no actual data changed - but mdadm 
> cannot assemble anymore), after the upgrade, the exact sentence for 
> recovering my server's RAID will be :
> 
> mdadm --create /dev/md0 --level=5 --chunk=512K --metadata=1.2 --layout 
> left-symmetric --data-offset=262144s --raid-devices=3 /dev/sdd1 
> /dev/sde1 /dev/sdb1 --assume-clean
> 
> It also implies that /dev/sdd1 /dev/sde1 /dev/sdb1 didn't moved (I know 
> what are the associated serial numbers - so it's easy to check). If 
> wrong, the array filesystem isn't readable until you create it with the 
> right positions.
> 
> By doing some archeology on the list archive about "grow" subjects, I 
> found this guy who suffered from what looks like the same problem on 
> same Debian 9 too (his thing about inserting the disk to the VM seems 
> not to be a real difference - and he found another way to get it started 
> again).
> https://marc.info/?t=153183310600004&r=1&w=2
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=884719
> 
> I'll probably keep you informed tonight !
