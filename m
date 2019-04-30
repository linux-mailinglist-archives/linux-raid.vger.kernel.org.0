Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE6F5A5
	for <lists+linux-raid@lfdr.de>; Tue, 30 Apr 2019 13:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfD3LbN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 07:31:13 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:16112 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfD3LbM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Apr 2019 07:31:12 -0400
Received: from [192.168.28.40] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2DD8CB005CE;
        Tue, 30 Apr 2019 13:31:07 +0200 (CEST)
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
 <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
 <20190430092347.GA4799@metamorpher.de>
From:   Julien ROBIN <julien.robin28@free.fr>
Message-ID: <deffabb8-51e8-0120-8c63-ade9e5dfdf9b@free.fr>
Date:   Tue, 30 Apr 2019 13:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430092347.GA4799@metamorpher.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Ok thanks. I tried to deal with overlays but I understood nothing of 
what I was writing so it was getting dangerous (if things already gone 
wrong when I typed simple and right commands, as I believed I was 
understanding the situation, I wasn't going to take the risk of making 
it more complicated for me).

The stackexchange statement is "the problem is that you don't know" so I 
managed to be sure that his statement becomes fake (with an absolutely 
identical configuration from the same OS and same date, and some blank 
test too : default values were good)
  * Version : 1.2
  * Layout : left-symmetric
  * Chunk Size : 512K

So as I was now sure to know, I played the command from my second mail, 
and everything is back online, with my "RAID-VOLUME" ext4 filesystem 
healthy and available.

Anyway, I'll take a copy of the below output for future, and mark serial 
number position into the array (serial of /dev/sdd1, then /dev/sde1, 
then /dev/sdb1) into a file which won't be in the array ;) Because this 
is enough to be able to recreate the array later with right parameters 
and right disk positions.


Every 1.0s: mdadm --detail /dev/md0                  Pix-Server-Sorel: 
Tue Apr 30 12:40:20 2019

/dev/md0:
         Version : 1.2
   Creation Time : Tue Apr 30 12:39:24 2019
      Raid Level : raid5
      Array Size : 15627788288 (14903.82 GiB 16002.86 GB)
   Used Dev Size : 7813894144 (7451.91 GiB 8001.43 GB)
    Raid Devices : 3
   Total Devices : 3
     Persistence : Superblock is persistent

   Intent Bitmap : Internal

     Update Time : Tue Apr 30 12:39:25 2019
           State : clean
  Active Devices : 3
Working Devices : 3
  Failed Devices : 0
   Spare Devices : 0

          Layout : left-symmetric
      Chunk Size : 512K

            Name : Pix-Server-Sorel:0  (local to host Pix-Server-Sorel)
            UUID : 8b28c8aa:28bb7706:fd24a971:7fc464cc
          Events : 1

     Number   Major   Minor   RaidDevice State
        0       8       49        0      active sync   /dev/sdd1
        1       8       65        1      active sync   /dev/sde1
        2       8       17        2      active sync   /dev/sdb1

Thanks for you answer Andreas, as I was waiting at least one expert look 
before typing anything.

------------------------------------------------------------------------

Is it the right place to make some bug report for what happened here? 
Because what caused this mess cannot be considered as normal :
   * Add a prepared disk (unformatted partition) to the array (check 
with mdadm --detail if it now appears as spare)
  * grow the array to its current size +1 : then the array was stuck and 
kind of "crashed".

I feel like nobody knows why this happened. And is this precise case, 
nobody knew what should exactly be done - its a chance I noticed there 
were absolutely no reshaping activity with bwm-ng. And there is some 
others people online who asked for help for the same reason (but without 
having 13.10 TiB of data into it) so the problem is recurrent.

Worst, documentation says to create a backup file to be sure it can be 
recovered in case of incident in early stages, but doing so, it 
completely messes the early stage with the Array and the backup is unusable.

Of course RAID will never protect from mistakes, but mdadm is not 
supposed to be the mistake! This is why I believe something should be 
understood and corrected about what causes this recurrent case.


For beginning with investigations, the only thing I did, this time, that 
was different from others time, was to use "dd if=/dev/urandom 
of=/dev/sdc bs=1024k status=progress" before preparing the disk, just to 
be sure its complete surface is working. Do you think this can be the 
cause of mdadm error? Should the new disk be always full of zeroes 
before preparing partition, then add and grow ?


Best regards,
Julien ROBIN

On 4/30/19 11:23 AM, Andreas Klauer wrote:
> On Tue, Apr 30, 2019 at 10:25:24AM +0200, Julien ROBIN wrote:
>> I'm about to play the following command :
>>
>> mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdd1 /dev/sde1
>> /dev/sdb1 --assume-clean
>>
>> Is it fine ?
> 
> If you must re-create
> 
> - use overlays
> 
> - see https://unix.stackexchange.com/a/131927/30851
> 
> Regards
> Andreas Klauer
> 
