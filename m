Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460BF1D6DAD
	for <lists+linux-raid@lfdr.de>; Sun, 17 May 2020 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgEQV4B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 17 May 2020 17:56:01 -0400
Received: from atl.turmel.org ([74.117.157.138]:44645 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgEQV4B (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 17 May 2020 17:56:01 -0400
Received: from [45.56.119.232] (helo=[192.168.17.3])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jaRGH-0000U1-Sq; Sun, 17 May 2020 17:55:58 -0400
Subject: Re: RAID wiped superblock recovery
To:     Sam Hurst <sam@sam-hurst.co.uk>, linux-raid@vger.kernel.org
References: <922713c5-0cc1-24cb-14a6-9de7db631f98@sam-hurst.co.uk>
 <0f954924-e7ae-c81e-55f1-afc41e293a18@turmel.org>
 <05011140-3625-5326-96c9-e995f93260f4@sam-hurst.co.uk>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <e7644f86-5342-b7bb-b6de-b37afd74f6cc@turmel.org>
Date:   Sun, 17 May 2020 17:56:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <05011140-3625-5326-96c9-e995f93260f4@sam-hurst.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Sam,

On 5/17/20 9:55 AM, Sam Hurst wrote:
> Hi Phil,

[trim /]

> My complete mdadm -E output:
> 
> sosh@toothless:/$ sudo mdadm -E /dev/sda /dev/sdb /dev/sdc /dev/sdd 
> /dev/sdf /dev/sdg /dev/sdh
> /dev/sda:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x1
>       Array UUID : f3667bf3:e2b718c2:22cbea68:428ea6ca
>             Name : toothless:WDRAID
>    Creation Time : Sat Oct 22 10:52:47 2016
>       Raid Level : raid6
>     Raid Devices : 7
> 
>   Avail Dev Size : 5860271024 (2794.39 GiB 3000.46 GB)
>       Array Size : 14650675200 (13971.97 GiB 15002.29 GB)
>    Used Dev Size : 5860270080 (2794.39 GiB 3000.46 GB)
>      Data Offset : 262144 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=262064 sectors, after=944 sectors
>            State : clean
>      Device UUID : 08c24be4:d352cbb0:edd50ba7:3a70e02e
> 
> Internal Bitmap : 8 sectors from superblock
>      Update Time : Sat May  2 09:49:27 2020
>    Bad Block Log : 512 entries available at offset 24 sectors
>         Checksum : b1df527c - correct
>           Events : 2687251
> 
>           Layout : left-symmetric
>       Chunk Size : 512K
> 
>     Device Role : Active device 0
>     Array State : AAAAAAA ('A' == active, '.' == missing, 'R' == replacing)

[trim /]

>>> So I've tried all six permutations of the devices showing as "spare" 
>>> at the end and I can never get a sensible filesystem out when I do a 
>>> --create.
>>>
>>> Does anyone have any other ideas, or can offer some wisdom into what 
>>> to do next? Otherwise I'm writing a shell script to test all 5040 
>>> permutations...
>>
>> It isn't just order that matters.   You must get the right data offset 
>> and chunk size.  Defaults have changed over the years, and offsets 
>> typically change (+/- 1 chunk) during reshapes.
>>
>> You'll probably have to manually specify this stuff.  Be sure to use 
>> the latest released version of mdadm, even if you have to compile it 
>> yourself.
>>
>> If your data offsets are at least a couple megabytes, consider 
>> partitioning these disks at the same time as you reconstruct--simply 
>> adjust the data offset for the start sector of the partition.  This 
>> will avoid future issues with stupid mobos.  (You aren't the first to 
>> suffer from this.)
> 
> So I've now tried doing this and sadly haven't really gotten anywhere. 
> Given the output of mdadm -E, I've specified the chunk size as 512K, and 
> the data offset as 134MB (given the reported offset of 262144 sectors * 
> sector size of 512 bytes on the devices).

Your math is wrong.  Or rather, you are using the bogus power-of-ten 
definition of "MB" that disk manufacturers use to deliver less space.

Use 128MB.  Or better, specify "262144s".

I generally recommend using fsck -n to verify a combination, not mount. 
But that's because I generally don't bother with overlays.  (And why I 
get away with it...)

> Apologies that it's taken a while to respond to your mail, I just 
> haven't had much time to look at this during the week.

No worries.

Phil
