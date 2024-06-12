Return-Path: <linux-raid+bounces-1877-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FB904C8E
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2024 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA851F24197
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3A156641;
	Wed, 12 Jun 2024 07:19:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFC6F077
	for <linux-raid@vger.kernel.org>; Wed, 12 Jun 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.118.73.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176747; cv=none; b=ayYnr3RvXg8ybxhzu/8RUdRAOyd0VGr/dXPlMCzCoHf1otQa66uAR1lspMJ9dteDgzJPH/KHbmQLipAS2xqfNGDSlq2qGY3op3w0W4B+mYsDJl5fzwO4noHQxAMSgKaXAPrL1QKkIWW/vHWvEjTvF9x47pxkXpQl7Roqlp+eysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176747; c=relaxed/simple;
	bh=eCFyq1fEYJC8fmp2MGI1JnuwXsQN7HYvB6mUzzFRyls=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FR34x4AimjCyeuhsR8MYALc7Vdohk5rMbHjBhvTgYwLv2vY7QrZ4HoUoPmiIJihWTETtbY2UaCUxW+XK+GSrfL/JlVZfqjCno1vNU7IOtNgoyM0hcJKKFIhvZs70aqCHfDo/8F4pKWou/ehEj9t2wD41MjfEVDyErOTzNGwqS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net; spf=pass smtp.mailfrom=thelounge.net; arc=none smtp.client-ip=91.118.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thelounge.net
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: h.reindl@thelounge.net)
	by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4VzcNM127szXLL;
	Wed, 12 Jun 2024 09:18:54 +0200 (CEST)
Message-ID: <ce217462-b07e-4b0a-8147-c4dd50f185d8@thelounge.net>
Date: Wed, 12 Jun 2024 09:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID-10 near vs. RAID-1
Content-Language: en-US
From: Reindl Harald <h.reindl@thelounge.net>
To: Paul E Luse <paul.e.luse@linux.intel.com>
Cc: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
 linux-raid@vger.kernel.org
References: <ZmiYHFiqK33Y-_91@lazy.lzy>
 <cd3ed227-1410-478b-b86b-973d76b587df@thelounge.net>
 <20240611171433.375d6e25@peluse-desk5>
 <7116a07d-cb2d-46f4-afc2-e6020aff0f6f@thelounge.net>
Autocrypt: addr=h.reindl@thelounge.net; keydata=
 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
 K4rYsjPimkSIVdrNM//wVKdCTbO+
Organization: the lounge interactive design
In-Reply-To: <7116a07d-cb2d-46f4-afc2-e6020aff0f6f@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 12.06.24 um 09:06 schrieb Reindl Harald:
> 
> 
> Am 12.06.24 um 02:14 schrieb Paul E Luse:
>> On Wed, 12 Jun 2024 01:04:18 +0200
>> Reindl Harald <h.reindl@thelounge.net> wrote:
>>
>>>
>>>
>>> Am 11.06.24 um 20:31 schrieb Piergiorgio Sartor:
>>>> I'm setting up a system with 2 SSD M.2 (NVME).
>>>>
>>>> I was wondering if would it be better, performace
>>>> wise, to have a RAID-10 near layout or a RAID-1.
>>>>
>>>> Looking around I found only one benchmark:
>>>>
>>>> https://strugglers.net/~andy/blog/2019/06/02/exploring-different-linux-raid-10-layouts-with-unbalanced-devices/
>>>>
>>>> Which uses mixed SSD, NVME and SATA.
>>>>
>>>> Does anybody have any suggestions, links, or
>>>> ideas on the topic?
>>>>
>>>> BTW, practically speaking, what's the difference,
>>>> between the two RAIDs?
>>>
>>> i wouldn't even consider a RAID10 with two disks, especially with SSD
>>> and practically you end with a unsupported RAID1 because there are no
>>> stripes with 2 disks
>>>
>>>
>> I don't disagree but I would recommend you try each variation and
>> measure the performance for yourself.  It's a great learning experience
>> if you haven't done it before and there's nothing like trusting your
>> own data over on your own system/config something that someone else has
>> done when there are so many factors that can affect performance.
> 
> the problem with benchmarks is that they often don't reflect mixed, 
> real-world performance - for virtual machine workload the "far" layout 
> wins in case of HDD
> 
> with NVME RAID i pretend it don't matter enough to even waste your time

and with only TWO disks thins might look compleltly different

a 4 disk RAID10 in case of large reads can use all 4 drives at the same 
time while with only two disks there isn't much to gain when you end 
with a practical RAID1 but the complexer scheme

the whole point of RAID10 is that you can double size *and* performance 
because of a least 4 disks and striping

if performance *really* matters buy 4 NVME drives with half the size or 
just keep thins simple

