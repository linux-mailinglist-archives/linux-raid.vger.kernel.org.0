Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C305E1995E3
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgCaMAo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 08:00:44 -0400
Received: from atl.turmel.org ([74.117.157.138]:59930 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgCaMAo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 31 Mar 2020 08:00:44 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJFZT-0003F3-CY; Tue, 31 Mar 2020 08:00:43 -0400
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Daniel Jones <dj@iowni.com>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
 <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
Date:   Tue, 31 Mar 2020 08:00:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good morning Daniel,

On 3/30/20 10:09 PM, Daniel Jones wrote:
> Hello Phil,
>> In particular, knowledge of the filesystem or nested structure (LVM?) present on the array will be needed to identify the real data offsets of the three mangled members.
> 
> I don't have the history of original creation, but I'm fairly certain
> it was something straightforward like:
> 
>    mdadm --create /dev/md0 {parameters}
>    sudo mkfs.ext4 /dev/md0
>    mount /dev/md0 /mnt/raid5
> 
> After the array was corrupted I needed to comment out the mount from
> my fstab, which was as follows (confirming ext4):
> 
>      /dev/md0                                      /mnt/raid5
>     ext4    defaults        0       0

Ok.  This should be relatively easy, if a bit time consuming.  Things we 
know:

1) array layout, and chunk size: 512k or 1024 sectors
2) Active device #1 offset 261124 sectors.
3) The array had bad block logging turned on.  We won't re-enable this 
mis-feature.  It is default, so you must turn it off in your --create.

Things we don't know:

1) Data offsets for other drives.  However, the one we know appears to 
be the typical you'd get from one reshape after a modern default 
creation (262144).  There are good odds that the others are at this 
offset, except the newest one that might be at 262144.  You'll have to 
test four combinations: all at 261124 plus one at a time at 262144.

2) Member order for the other drives.  Three drives taken three at a 
time is six combinations.

3) Identity of the first drive kicked out. (Or do we know?)  If not 
known, there's four more combinations: whether to leave out or one of 
three left out.

That yields either twenty-four or 96 different --create --assume-clean 
combinations to test to find the one that gives you the cleanest 
filesystem in a read-only fsck.  (Do NOT mount!  Even a read-only mount 
will write to the filesystem.  Only test with fsck -n.)

Start by creating partitions on all devices, preferably at 2048 sectors. 
  (Should be the default offered.)  Use data offsets 259076 and 260100 
instead of 261124 and 262144.

I recommend writing out all the combinations before you start and 
keeping the fsck -n output from each until you have the final version 
you want.

Yeah, I'd write a script to do it all for me, if your best guess 
combination doesn't yield a good filesystem.

> Cheers,
> DJ

Phil
