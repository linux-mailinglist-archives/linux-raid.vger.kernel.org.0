Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0FA103BC
	for <lists+linux-raid@lfdr.de>; Wed,  1 May 2019 03:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEABtQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 21:49:16 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:62811 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEABtQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Apr 2019 21:49:16 -0400
Received: from [192.168.28.40] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 89859B00533
        for <linux-raid@vger.kernel.org>; Wed,  1 May 2019 03:49:11 +0200 (CEST)
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
Message-ID: <8109d116-dd63-15be-2360-7763b9376393@free.fr>
Date:   Wed, 1 May 2019 03:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430135152.GA20515@metamorpher.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Sorry for the delay

On 4/30/19 3:51 PM, Andreas Klauer wrote:

> Something else must have happened... either a bug (are you using
> latest mdadm / kernel versions?), or trying to store the backup
> file on the raid itself, or maybe something blocking mdadm
> (happened before with selinux/apparmor, I think)
> or otherwise something interfering with the process.
> 
> If you can reproduce the issue you could investigate in more detail...
> 

I have been able to reproduce the issue on the machine I used for 
experiments last night.

It is running Debian 9 (last apt update/upgrade : mdadm 3.4-4+b1 and 
linux 4.9.0-9-amd64 - exactly like the server) - Is debian including 
your last bug fixes to his version ? I know that this is done for others 
packages and I assume that the answer should be yes - but you probably 
know more about it than me.


But even if the same failure happens some times, it's not all the times, 
and even with big oneliners commands to test and test again, it shown 
back only once. So I guess it's some kind of instability?

     mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sde1 
/dev/sdf1 /dev/sdc1
     mdadm --grow --bitmap=internal /dev/md0
     shred -n 1 -v /dev/sdd
     gparted
     mdadm --add /dev/md0 /dev/sdd1
     mdadm --grow --raid-devices=4 --backup-file=/root/grow_md0.bak /dev/md0

And it was stuck exactly as my server last night. 3KB has been write on 
each existing disk of the array, 1.5KB on the new one. Stuck at 0% and 
unable to assemble after a stop or reboot.

Some details are maybe useless and were only to reproduce identical case 
compared to the failure I had on the server :
  -> Not sure about the importance of the drives order into the 
apparition of this fault
  -> Not sure about the importance of Intent Bitmap : Internal
  -> Not sure about the importance of the shred then creation of 
/dev/sdd1 partition before add and grow.


The only thing I'm sure about conditions is that it can happen even when 
the volume isn't mounted into any directory (so it unlikely to be some 
read/write access interfering during the procedure!)


On 5/1/19 1:39 AM, Wols Lists wrote:> On 30/04/19 09:25, Julien ROBIN wrote:
>> I'm about to play the following command :
>>
>> mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdd1 /dev/sde1
>> /dev/sdb1 --assume-clean
>>
>> Is it fine ?
>
> You clearly haven't read the raid wiki
> https://raid.wiki.kernel.org/index.php/Linux_Raid
>
> It states NEVER EVER use mdadm --create on an existing array unless you
> (or the person helping you) really knows what they are doing.



That's not exact, when I finally decided to pressed "enter" I was way 
more sure than the wiki about what I was doing ;)

mdadm failed despite the fact I entirely read (and respected) the wiki 
several times, longs times before, and last night too. I finally got the 
information about :
  * how to determine the correct parameters when you use --create
  * what are the exact conditions that should be met to use --create to 
reconfigure an access to an existing array (when mdadm or something else 
blocked/misconfigured the array but data are still available in a 
predictable way). Some others case aren't recoverable with --create.

I found most of those informations elsewhere on the Internet and by 
doing my own tests - there is a lot of things that can be understood and 
explained which would be useful into the wiki. Most interesting parts 
are the cases in which --create can badly rewrite some data on a disk 
(game over), and on which disk (so that in some of those cases, others 
untouched disks may even be used to reconstruct the destroyed one using 
--create with correct parameters - so that the game wasn't really over).

But unfortunately, all of those things aren't into the wiki.
Well, just to say that I knew what I was doing, as the wiki asked.


> Another thing it says is always update to the latest mdadm. I don't
> remember you telling us what version you're using, and the problem you
> describe sounds very much like something I suspect has been fixed in the
> latest versions.

Yes sorry for the delay, I forgot to say it into my previous posts - It 
is running Debian 9 (last apt update/upgrade : mdadm 3.4-4+b1 and linux 
4.9.0-9-amd64)

I guess that if it was a known bug, corrected some time ago, Debian 
would have included the patch into Debian 9? If I'm true, it means that 
the problem may still exist upstream. If I'm wrong, and Debian "mdadm" 
version is unstable, I won't feel really comfortable using "master / sid 
/ experimental" branches for "safety and stability" (that would be 
really uncommon).


By the way, many thanks for your answers. Would be glad if my case 
helped you to find something to improve into mdadm - sorry if not!

Best regards,
Julien
