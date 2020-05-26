Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73119A468
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 06:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgDAEpN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 00:45:13 -0400
Received: from atl.turmel.org ([74.117.157.138]:46158 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgDAEpN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 Apr 2020 00:45:13 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJVFX-00014L-MI; Wed, 01 Apr 2020 00:45:11 -0400
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Daniel Jones <dj@iowni.com>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
 <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
 <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org>
Date:   Wed, 1 Apr 2020 00:45:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Daniel,

On 3/31/20 11:39 PM, Daniel Jones wrote:
> Hello Phil, et al.,
> 
> Phil, after reading through your email I have some questions.
> 
>> The array had bad block logging turned on.  We won't re-enable this
>> mis-feature.  It is default, so you must turn it off in your --create.
> 
> Am I able to turn off during --create?  The man page for mdadm on my
> system (mdadm - v4.1 - 2018-10-01) suggests that --update=no-bbl can
> be used for --assemble and --manage but doesn't list it for --create.

Uhm, self compile and see what you get.  In these situations, relying on 
a potentially buggy system mdadm is not recommended.  But if still not 
available in create, fix it afterwards.  You definitely do not want this.

>> However, the one we know appears to be the typical you'd get from
>> one reshape after a modern default creation (262144).
> 
>> You'll have to test four combinations: all at 261124 plus one at a
>> time at 262144.
> 
> I'm confused by the offsets. The one remaining superblock I have
> reports "Data Offset : 261120 sectors".  Your email mentions 261124
> and 262144. I don't understand how these three values are related?

Yeah, doing math in one's head quickly sometimes yields a fail.  262144 
is 128MB in sectors.  Minus 1024 sectors (your chunk size) yields 
261120.  /:

> I think it is most likely that my one existing superblock with 261120
> is one of the original three drives and not the fourth drive that was
> added later.  (Based on the position in drive bay).
> 
> So possible offsets (I'm still not clear on this) could be:
> 
> a) all 261120

Yes.

> b) all 261124

No.

> c) all 262144

No.

> d) three at 261120, one at 262144

Yes.

> e) three at 261120, one at 261124
> f) three at 261124, one at 261120
> g) three at 261124, one at 262144

No, no, and no.

> h) three at 262144, one at 261120

Extremely unlikely.  Not in my recommended combinations to check.

> i) three at 262144, one at 261124

No.

> ( this ignores the combinations of not knowing which drive gets the
> oddball offset )
> ( this also ignores for now the offsets of 259076 and 260100 mentioned below )
> 
>> 2) Member order for the other drives.  Three drives taken three at a
>> time is six combinations.
>>
>> 3) Identity of the first drive kicked out. (Or do we know?)  If not
>> known, there's four more combinations: whether to leave out or one of
>> three left out.
> 
> Can I make any tentative conclusions from this information:
> 
>    Device Role : Active device 1
>    Array State : .AAA ('A' == active, '.' == missing, 'R' == replacing)

This device will always be listed as the 2nd member in all of your 
--create commands, and always with the offset of 261120 - 2048.

> I know /dev/sde is the device that didn't initially respond to BIOS
> and suspect it is the "missing" drive from my superblock.

That eliminates the combinations of (3).  Section (2) becomes three 
drives taken two at a time (since you don't know which device role 
/dev/sde had).  But that is still six combinations.

> I know that /dev/sdc is the drive with a working superblock that
> reports itself as "Active device 1".

Right, as above.

> I don't know how mdadm counts things (starting at 0 or starting at 1,
> left to right or right to left, including or excluding the missing
> drive).

Active devices start with zero.

> Would it be reasonable for a first guess that:
> 
> .AAA = sde sdd sdc sdb  (assuming the order is missing, active 0,
> active 1, active 2) ?

No.  Order is always active devices 0-3, with one of those replaced (in 
order) with "missing".

> Procedure questions:
> 
> If I understand all the above, attempted recovery is going to be along
> the lines of:
> 
> mdadm --create /dev/md0 --force --assume-clean --readonly
> --data-offset=261120 --chunk=512K --level=5 --raid-devices=4 missing
> /dev/sdd /dev/sdc /dev/sdb
> fsck -n /dev/md0

Yes, but with the order above, and with --data-offset=variable when 
mixing them.

> Subject to:
> Don't know if --force is desirable in this case?

Not applicable to --create.

> Might need to try different offsets from above.  Don't know how to set
> offsets if they are different per drive.

man page.

> Should I start with guessing "missing" for 1 or should I start with all 4?
> Might need to try all device orders.
> 
>> Start by creating partitions on all devices, preferably at 2048 sectors.
>> (Should be the default offered.)  Use data offsets 259076 and 260100
>> instead of 261124 and 262144.
> 
> If I understand, this is an alternative to recreating the whole-disk
> mdadm containing one partition. Instead it would involve creating new
> partition tables on each physical drive, creating one partition per
> table, writing superblocks to the new /dev/sd[bcde]1 with offsets
> adjusted by either 2044 or 2048 sectors, and then doing the fsck on
> the assembled RAID.

Yes, 2048.

> I think the advantage proposed here is that it prevents this
> "automated superblock overwrite" from happening again if/when I try
> the motherboard upgrade, but the risk I'm not comfortable with yet is
> going beyond "do the minimum to get it working again". Although it
> isn't practical for me to do a dd full backup of these drives, if I
> can get the array mounted again I can copy off the most important data
> before doing a grander repartitioning.

It's virtually impossible to correct at any time other than create, so 
do it now.  The "minimum" is a rather brutal situation.  Fix it right.

> Can you advise on any of the above?
> 
> Thanks,
> DJ
> 

Phil
