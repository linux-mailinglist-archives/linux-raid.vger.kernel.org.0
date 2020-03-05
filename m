Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC817AC27
	for <lists+linux-raid@lfdr.de>; Thu,  5 Mar 2020 18:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCERSv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Mar 2020 12:18:51 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:29336 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgCERSu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 5 Mar 2020 12:18:50 -0500
Received: from [81.153.123.203] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1j9u91-0004x6-CM; Thu, 05 Mar 2020 17:18:48 +0000
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable
 I/O
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
 <20200302102542.309e2d19@natsu>
 <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
 <20200302115141.1e796b7c@natsu>
 <c5d8e6d2-a572-5602-6562-795ea52168ac@suddenlinkmail.com>
 <41094cf9-0e3f-e44e-7ec8-0ab433d574a1@suddenlinkmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E613477.7040208@youngman.org.uk>
Date:   Thu, 5 Mar 2020 17:18:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <41094cf9-0e3f-e44e-7ec8-0ab433d574a1@suddenlinkmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/03/20 22:53, David C. Rankin wrote:
> On 03/02/2020 12:57 AM, David C. Rankin wrote:
>> On 03/02/2020 12:51 AM, Roman Mamedov wrote:
>>> Yes, replace the drive ASAP, and see if that solves it.
>>
>> Will do, thank you!
>>
> 
> Drive replaced and rebuilding:
> 
> md4 : active raid1 sdc[3] sdd[2]
>       2930135488 blocks super 1.2 [2/1] [_U]
>       [>....................]  recovery =  1.5% (46390912/2930135488)
> finish=276.0min speed=174102K/sec
>       bitmap: 1/22 pages [4KB], 65536KB chunk
> 
> Things are looking good, speed=174102K/sec, which is a far-sight better than
> speed=2022K/sec. This will give a 4.5 hour rebuild (instead of a 26 day
> scrub). I suspect the virtualbox problems will disappear as well once the
> rebuild is done.
> 
> Thank you to everyone for helping get me pointed in the right direction. I'll
> let you know if I have any further issues here, but I don't anticipate any
> (fingers-crossed...)
> 
Raid 1 - look at dm-integrity. That should make scrubbing (hopefully)
redundant :-)

I might at last soon get my new system up and running (got a shop to
look at it - dud motherboard :-( Of course it's now out of warranty and
my supplier has gone bust, but if the shop say it was dud from the start
I might be able to claim something ...

But that means I'll have a test system - I've acquired about 6 x 1TB
drives - so I shall be playing with some slightly more heavy-duty raid
configs :-)

Cheers,
Wol
