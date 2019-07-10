Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53B63F7A
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 05:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfGJDBN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 23:01:13 -0400
Received: from mail2.trojanworkforce.com.au ([202.44.178.137]:52149 "EHLO
        mail.trojanrecruit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJDBN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 23:01:13 -0400
Received: (qmail 11444 invoked by uid 56706); 10 Jul 2019 03:01:09 -0000
Received: from mailinglists@websitemanagers.com.au by gw.prestigetrojan.com.au by uid 1002 with qmail-scanner-1.20 
 ( Clear:RC:1(10.30.10.90):. 
 Processed in 0.02199 secs); 10 Jul 2019 03:01:09 -0000
Received: from unknown (HELO ?10.30.10.90?) (agoryachev@10.30.10.90)
  by mail.trojanrecruit.com.au with ESMTPA; 10 Jul 2019 03:01:09 -0000
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Reindl Harald <h.reindl@thelounge.net>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
 <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
 <006fbf98-ec73-818d-f9d1-fbe315dc0f60@thelounge.net>
 <30c63d5e-34fb-47ce-71f7-272fb4ef3d17@websitemanagers.com.au>
 <0640dd81-a4fe-5847-ec26-3a7dedd5872f@thelounge.net>
 <cb440d7c-e7eb-1826-3f9d-e7b44ab359f6@websitemanagers.com.au>
 <5e40eefb-8158-8c2c-f28d-e9fb657fe6ce@thelounge.net>
From:   Adam Goryachev <mailinglists@websitemanagers.com.au>
Message-ID: <4c4338ea-f5a2-21cf-1c54-2a3a5819d89f@websitemanagers.com.au>
Date:   Wed, 10 Jul 2019 13:01:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5e40eefb-8158-8c2c-f28d-e9fb657fe6ce@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/7/19 12:31 pm, Reindl Harald wrote:
> Am 10.07.19 um 04:18 schrieb Adam Goryachev:
>> On 10/7/19 11:57 am, Reindl Harald wrote:
>>> Am 10.07.19 um 03:28 schrieb Adam Goryachev:
>>>
>>>> TBH, I really don't understand RAID10, other than improving performance.
>>>> For example, in a 10 drive RAID10, you have a higher probability to lose
>>>> 2 drives that are a "pair" than losing 3 drives in total from a 7 drive
>>>> RAID6 (both events lead to total data loss, although potentially you
>>>> could recover more "usable" data from the RAID10 array since you would
>>>> more likely have a large amount of contiguous data).
>>> RAID10 is about performance *and* redundancy *as well* as storage size
>>>
>>> as said: 3 disk RAID10 is a joke and a 3 disk RAID1 is waste of size
>>>
>>> 3x2 TB RAID1 = 2 TB useable
>>> 4x2 TB RAID10 = 4 TB useable
>> So for the cost of an extra 2TB drive, you got:
>>
>> 1) An extra 2TB capacity - which the OP doesn't need
>> 2) Less data protection, you can only lose a MAXIMUM of 2 disks without
>> losing data, but if you lose the "wrong" 2 disks, then you lost all your
>> data.
>>
>> Using 4 x 2TB RAID1 (ie, same cost/number of disks) would mean you can
>> lose any 3 disks with no data loss, and when you replace them, quick and
>> simple recovery process. Even 3 x 2TB allows for ANY 2 disk failure
>> without data loss.
>>
>> The OP stated that performance and capacity was not something that
>> interests him. The primary concern was avoiding the loss of data,
>> presumably due to drive failure, perhaps availability is also important.
>> 2TB is sufficient for 5 years.
> don't change the fact that a 2 TB HDD (when we say performance is not
> important) costs nothing these days and with RAID1 you are limited to
> the write speed of a single disk
>
> so if you are paranoid about drive failures get 6x1 TB = 300 € with 3 TB
> useable which is exatcly between 3x2 RAID1 and 4x2 RAID10 :-)

Assuming you are now suggesting 6 x 1TB in RAID10 with 2 mirrors (to get 
3TB usable) then you are still suffering from the 2 drive failures 
causing loss of all data (although potentially you can lose 3 with no 
data loss). In fact, you might be better off with RAID6 where you can 
lose ANY 2 drives (I haven't had enough coffee to work out probabilities 
on these things). Also, the OP advised their system can only support a 
maximum of 3 drives.

So, you say if I'm really paranoid about drive failures... but how does 
that improve the situation? If I was truly paranoid about drive 
failures, and not concerned with capacity, then I'd buy 6 x 2TB drives 
in RAID1 with 6 mirrors, allowing for any 5 drive failures with no data 
loss. Though I'm not sure anyone would really do that (or be that 
paranoid), as you are likely to have "other" hardware failures before 
you will have multiple (that many) drive failures before being able to 
replace and re-sync the drives. I would be looking at other options like 
DRBD to real-time sync to another machine, and have both machines with 
RAID1 x 3 or RAID1 x 2 rather than RAID1 x 4 or more.

Regards,
Adam

-- 
Adam Goryachev Website Managers www.websitemanagers.com.au
-- 
The information in this e-mail is confidential and may be legally privileged.
It is intended solely for the addressee. Access to this e-mail by anyone else
is unauthorised. If you are not the intended recipient, any disclosure,
copying, distribution or any action taken or omitted to be taken in reliance
on it, is prohibited and may be unlawful. If you have received this message
in error, please notify us immediately. Please also destroy and delete the
message from your computer. Viruses - Any loss/damage incurred by receiving
this email is not the sender's responsibility.
