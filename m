Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1F4D823E
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 23:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfJOVeQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 17:34:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60586 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbfJOVeQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Oct 2019 17:34:16 -0400
Received: from [86.132.37.73] (helo=[192.168.1.78])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iKUSJ-0002o5-AC; Tue, 15 Oct 2019 22:34:11 +0100
Subject: Re: Degraded RAID1
To:     curtis@npc-usa.com, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
Date:   Tue, 15 Oct 2019 22:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/10/2019 21:32, Curtis Vaughan wrote:
> 
> On 10/14/19 5:44 PM, Wols Lists wrote:
>> On 15/10/19 00:56, Curtis Vaughan wrote:
>>> I have reason to believe one HD in a RAID1 is dying. But I'm trying to
>>> understand what the logs and results of various commands are telling me.
>>> Searching on the Internet is very confusing. BTW, this is for and Ubuntu
>>> Server 18.04.2 LTS.
>> Ubuntu LTS ... hmmm. What does "mdadm --version" tell you?
> mdadm - v4.1-rc1 - 2018-03-22

That's good. A lot of Ubuntu installations seem to have mdadm 3.4, and 
that has known issues, shall we say.
> 
>>> It seems to me that the following information is telling me on device is
>>> missing. It would seem to me that sda is gone.
>> Have you got any diagnostics for sda? Is it still in /dev? has it been
>> kicked from the system? Or just the raid?
> It is still on the system, so I guess it's just kicked off the raid.
>>
>> Take a look at
>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>> Especially the "asking for help" page. It gives you loads of diagnostics
>> to run.
> Ok, I already went through most of those tests, but still not sure what
> they are telling me.

That's why the page tells you to post the output to this list ...

I'm particularly interested in what mdadm --examine and --detail tell me 
about sda. But given that you think the drive is dud, does that really 
matter any more?

However, there's a lot of reasons drives get kicked off, that may have 
absolutely nothing to do with them being faulty. Are your drives 
raid-friendly? Have you checked for the timeout problem? It's quite 
possible that the drive is fine, and you've just had a glitch.

>> Basically, we need to know whether sda has died, or whether it's a
>> problem with raid (especially with older mdadm, like I suspect you may
>> have, the problem could lie there).
>>> Anyhow, for example, I received an email:
>>>
>>> A DegradedArray event had been detected on md device /dev/md0.
>> Do you have a spare drive to replace sda? If you haven't, it might be an
>> idea to get one - especially if you think sda might have failed. In that
>> case, fixing the raid should be pretty easy. So long as fixing it
>> doesn't tip sdb over the edge ...
> 
> The replacement drive is coming tomorrow. I'm certain now there's a
> major issue
> 
> with the drive and will be replacing it.

What makes you think that?
> 
> My intent is to basically follow these instructions for replacing the
> drive.
> 
> sudo mdadm --remove /dev/md1 /dev/sda2
> sudo mdadm --remove /dev/md0 /dev/sda1
> 
> Remove the bad drive, install new drive
>   
> sudo mdadm --add /dev/md1 /dev/sda2
> sudo mdadm --add /dev/md1 /dev/sda1
> 
> 
> Would that be the correct approach?

Yup. Sounds good. The only thing that might make sense, especially if 
you're getting a slightly bigger drive to replace sda, look at putting 
dm-integrity between the partition and the raid. There's a good chance 
it's not available to you because it's a new feature, but the idea is 
that it checksums the writes. So if there's data corruption the raid no 
longer wonders which drive is correct, but the corruption triggers a 
read error and the raid will fix it. I can't give you any pointers 
sorry, because I haven't played with it myself, but you should be able 
to find some information here or elsewhere on it.
> 
> Finally could you tell me how to subscribe to this newsgroup through an NNTP client?
> I was using it through the gmane server, which seems to have issues of whether it's
> being continued or not. And although I can see some recent posts from last week,
> there has been nothing new. I've been searching for a NNTP server, but can't find one.
> Thanks!
> 
Dunno how to subscribe using an nntp client because this is a mailing 
list, but details are on the wiki home page. Click on the link to the 
mailing list, and you can subscribe to the list there.

Cheers,
Wol
