Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6263EEF
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 03:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGJB2f (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 21:28:35 -0400
Received: from mail2.trojanworkforce.com.au ([202.44.178.137]:38138 "EHLO
        mail.trojanrecruit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGJB2f (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 21:28:35 -0400
Received: (qmail 15405 invoked by uid 56706); 10 Jul 2019 01:28:33 -0000
Received: from mailinglists@websitemanagers.com.au by gw.prestigetrojan.com.au by uid 1002 with qmail-scanner-1.20 
 ( Clear:RC:1(10.30.10.90):. 
 Processed in 0.013107 secs); 10 Jul 2019 01:28:33 -0000
Received: from unknown (HELO ?10.30.10.90?) (agoryachev@10.30.10.90)
  by mail.trojanrecruit.com.au with ESMTPA; 10 Jul 2019 01:28:33 -0000
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
From:   Adam Goryachev <mailinglists@websitemanagers.com.au>
Message-ID: <30c63d5e-34fb-47ce-71f7-272fb4ef3d17@websitemanagers.com.au>
Date:   Wed, 10 Jul 2019 11:28:33 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <006fbf98-ec73-818d-f9d1-fbe315dc0f60@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/7/19 10:20 am, Reindl Harald wrote:
> Am 10.07.19 um 01:22 schrieb Adam Goryachev
>> I'm not sure why I disagree with you Wol... why is RAID10 so much better
>> than a 3 disk RAID1?
> because rebuilds are much faster and a RAID with 3 disks is a joke anyways

Ummm, so a rebuild of a RAID10 with 3 disks is faster than a rebuild of 
a RAID1 with 3 disks?

The replacement drive will write at 100% of it's speed (as long as we 
can read from the remaining two disks at least at that speed).

So, the difference is can we read from one of the two remaining disks at 
the maximum write speed of the third disk in RAID1 x 3? I think the 
answer would be yes, and therefore the real world difference in rebuild 
speed would be negligible (if not zero).

Why is a RAID1 with 3 mirrors a joke? It has better data protection from 
disk loss than RAID10 (with standard 2 disk mirrors), RAID5, or RAID6 
(which is excluded here anyway as you need a minimum 4 disks for RAID6).

Actually, I really am curious, because if I'm missing something, I'd 
like to improve my knowledge and make better decisions in the future.

PS, unless you were referring to 3 disk RAID10 as a joke?

TBH, I really don't understand RAID10, other than improving performance. 
For example, in a 10 drive RAID10, you have a higher probability to lose 
2 drives that are a "pair" than losing 3 drives in total from a 7 drive 
RAID6 (both events lead to total data loss, although potentially you 
could recover more "usable" data from the RAID10 array since you would 
more likely have a large amount of contiguous data).

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
