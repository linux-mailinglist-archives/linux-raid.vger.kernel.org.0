Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908E3B94BE
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfITP7K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 11:59:10 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:31263 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfITP7J (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 11:59:09 -0400
Received: from [86.132.37.92] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iBLJJ-0002VE-6L; Fri, 20 Sep 2019 16:59:06 +0100
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro, linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5D84F749.9070801@youngman.org.uk>
Date:   Fri, 20 Sep 2019 16:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/09/19 21:45, Liviu Petcu wrote:
> Hello,
> 
> Please let me know if in this situation detailed below, there are chances of restoring the RAID 10 array and how I can do it safely. 
> Thank you!

This is linux raid 10, not some form of raid 1+0? That's what it looks
like to me. I notice it says the array is active! That I think is good news!

Can you mount it read-only and read it? I would be surprised if you
can't, which means the array is running fine in degraded mode. NOT GOOD
but not a problem provided nothing further goes wrong. I notice it's
also version 0.9 - is it an old array? Have the drives themselves
failed? (which I guess is probably the case :-( I guess the drives
effectively have just the one partition - 2 - and 1 is something
unimportant?

Okay, my take on the situation is that you have two failed drives. The
array is okay but degraded, which is a dangerous position to be in. You
need to replace those failed drives asap. BUT. The array is old, which
means a recovery could tip the remaining drives over the edge.

Can you get a SMART report off the drives? If the other drives look
healthy we can risk a rebuild, if they don't we need to shut the array
down and copy them pronto. Either way you need new drives, which is a
good time to think about your next move.

You've got raid10 - do you want to get some larger drives and go raid-6?
Do you want to increase your disk capacity? etc etc.

Then we can think about either just replacing the failed drives, or
going the whole hog and moving on to a new array.

Cheers,
Wol
> 
> Liviu Petcu
> 
> # mdadm --examine /dev/sd[abcdef]2
> 
> /dev/sda2:
>           Magic : a92b4efc
>         Version : 0.90.00
>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
>   Creation Time : Fri Aug 14 12:11:48 2015
>      Raid Level : raid10
>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
>    Raid Devices : 6
>   Total Devices : 6
> Preferred Minor : 1
> 
>     Update Time : Thu Sep 19 21:05:15 2019
>           State : active
>  Active Devices : 4
> Working Devices : 4
>  Failed Devices : 2
>   Spare Devices : 0
>        Checksum : e528c455 - correct
>          Events : 271498
> 
>          Layout : offset=2
>      Chunk Size : 256K
> 
>       Number   Major   Minor   RaidDevice State
> this     5       8        2        5      active sync   /dev/sda2
> 
>    0     0       8       18        0      active sync   /dev/sdb2
>    1     1       0        0        1      faulty removed
>    2     2       0        0        2      faulty removed
>    3     3       8       66        3      active sync   /dev/sde2
>    4     4       8       82        4      active sync   /dev/sdf2
>    5     5       8        2        5      active sync   /dev/sda2
> /dev/sdb2:
>           Magic : a92b4efc
>         Version : 0.90.00
>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
>   Creation Time : Fri Aug 14 12:11:48 2015
>      Raid Level : raid10
>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
>    Raid Devices : 6
>   Total Devices : 6
> Preferred Minor : 1
> 
>     Update Time : Thu Sep 19 21:05:15 2019
>           State : active
>  Active Devices : 4and
> Working Devices : 4
>  Failed Devices : 2
>   Spare Devices : 0
>        Checksum : e528c45b - correct
>          Events : 271498
> 
>          Layout : offset=2
>      Chunk Size : 256K
> 
>       Number   Major   Minor   RaidDevice State
> this     0       8       18        0      active sync   /dev/sdb2
> 
>    0     0       8       18        0      active sync   /dev/sdb2
>    1     1       0        0        1      faulty removed
>    2     2       0        0        2      faulty removed
>    3     3       8       66        3      active sync   /dev/sde2
>    4     4       8       82        4      active sync   /dev/sdf2
>    5     5       8        2        5      active sync   /dev/sda2
> /dev/sde2:
>           Magic : a92b4efc
>         Version : 0.90.00
>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
>   Creation Time : Fri Aug 14 12:11:48 2015
>      Raid Level : raid10
>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
>    Raid Devices : 6
>   Total Devices : 6
> Preferred Minor : 1
> 
>     Update Time : Thu Sep 19 21:05:16 2019
>           State : clean
>  Active Devices : 4
> Working Devices : 4
>  Failed Devices : 2
>   Spare Devices : 0
>        Checksum : e52ce91f - correct
>          Events : 271499
> 
>          Layout : offset=2
>      Chunk Size : 256K
> 
>       Number   Major   Minor   RaidDevice State
> this     3       8       66        3      active sync   /dev/sde2
> 
>    0     0       8       18        0      active sync   /dev/sdb2
>    1     1       0        0        1      faulty removed
>    2     2       0        0        2      faulty removed
>    3     3       8       66        3      active sync   /dev/sde2
>    4     4       8       82        4      active sync   /dev/sdf2
>    5     5       8        2        5      active sync   /dev/sda2
> /dev/sdf2:
>           Magic : a92b4efc
>         Version : 0.90.00
>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
>   Creation Time : Fri Aug 14 12:11:48 2015
>      Raid Level : raid10
>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
>    Raid Devices : 6
>   Total Devices : 6
> Preferred Minor : 1
> 
>     Update Time : Thu Sep 19 21:05:16 2019
>           State : clean
>  Active Devices : 4
> Working Devices : 4
>  Failed Devices : 2
>   Spare Devices : 0
>        Checksum : e52ce931 - correct
>          Events : 271499
> 
>          Layout : offset=2
>      Chunk Size : 256K
> 
>       Number   Major   Minor   RaidDevice State
> this     4       8       82        4      active sync   /dev/sdf2
> 
>    0     0       8       18        0      active sync   /dev/sdb2
>    1     1       0        0        1      faulty removed
>    2     2       0        0        2      faulty removed
>    3     3       8       66        3      active sync   /dev/sde2
>    4     4       8       82        4      active sync   /dev/sdf2
>    5     5       8        2        5      active sync   /dev/sda2
> 

