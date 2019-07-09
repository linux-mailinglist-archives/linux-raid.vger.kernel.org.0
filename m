Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB01763E54
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 01:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGIX3k (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 19:29:40 -0400
Received: from mail2.trojanworkforce.com.au ([202.44.178.137]:50886 "EHLO
        mail.trojanrecruit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGIX3k (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 19:29:40 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 19:29:40 EDT
Received: (qmail 8715 invoked by uid 56706); 9 Jul 2019 23:22:58 -0000
Received: from mailinglists@websitemanagers.com.au by gw.prestigetrojan.com.au by uid 1002 with qmail-scanner-1.20 
 ( Clear:RC:1(10.30.10.90):. 
 Processed in 0.013259 secs); 09 Jul 2019 23:22:58 -0000
Received: from unknown (HELO ?10.30.10.90?) (agoryachev@10.30.10.90)
  by mail.trojanrecruit.com.au with ESMTPA; 9 Jul 2019 23:22:57 -0000
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Luca Lazzarin <luca.lazzarin@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
From:   Adam Goryachev <mailinglists@websitemanagers.com.au>
Message-ID: <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
Date:   Wed, 10 Jul 2019 09:22:57 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/7/19 9:03 am, Luca Lazzarin wrote:
> On 10/07/19 00:47, Wols Lists wrote:
>> On 09/07/19 23:17, Luca Lazzarin wrote:
>>> Hi all,
>>>
>>> actually a server of mine has a 2x1TB Raid 1 array.
>>> The disks are becoming old and to avoid possible problems I would like
>>> to replace them.
>>>
>>> Moving from 1TB of space to 2TB could be enough, but since I have to 
>>> buy
>>> the new disks I am considering different possibilities, which are:
>>> 1) 2x2TB Raid 1 array;
>>> 2) 3x2TB Raid 1 array;
>>> 3) 3x1TB Raid 5 array;
>>> 4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
>>> probably are enough for the next 10 year);
>>> 5) 4x1TB Raid 6 array.
>>>
>>> Which one, in your opinion, would the the best solution?
>> What's the price difference between 1TB and 2TB drives? Significant, or
>> not much? If the price difference isn't that much I'd go for the larger
>> drives every time.
> 1TB costs 60 euro, 2TB costs 75 euro (WD Red), so the difference is 
> not significant to me.

I think there are three options that "make sense" to consider:

1) 2x2TB Raid 1 array; 120 euro
2) 3x2TB Raid 1 array; 225 euro
3) 3x1TB Raid 5 array; 180 euro
4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
probably are enough for the next 10 year); 225 euro
5) 4x1TB Raid 6 array. 240 euro

If cost is important, then I would suggest 2 x 2TB in RAID1, but if not, 
then I would choose 3 x 2TB in RAID1, this is IMHO, safer than option 4 
(2 complete disk failures without data loss), cheaper than option 4.

>
>> Is speed important? raid 1 is probably best. I wouldn't run raid 1 over
>> three disks - if you're thinking of that you're probably better off with
>> raid 10.
>>
>> If you want more definite answers than this, though, you're going to
>> have to provide more information about how the server is used - is it
>> home or business, is speed or resilience more important, what do you
>> actually want from the array? Each version has pros and cons.
> The server is a business file server where my colleagues save their 
> data and access the from their laptops.
> Speed is not so much important, I prefer resilience, so the most 
> important thing I would from the array is to prevent as much as 
> possible data corruption and have a safe place where data is stored.
>> Cheers,
>> Wol

I'm not sure why I disagree with you Wol... why is RAID10 so much better 
than a 3 disk RAID1? Linux MD you can use 3 disk RAID10 with 2 mirrors, 
but I don't think that is what you are suggesting, it would bring 
capacity up to 3TB but you can only lose one drive (same as the RAID5 
option).

IMHO, if data resilience is your primary concern, than RAID1 x 3 drives, 
or potentially RAID10 x 3 drives with 3 mirrors if there is some 
technical implementation / performance difference I'm not aware of with 
these two options.

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
