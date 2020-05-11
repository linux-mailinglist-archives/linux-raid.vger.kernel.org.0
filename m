Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3721CD587
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgEKJld (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 05:41:33 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:52128 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgEKJlc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 05:41:32 -0400
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 0B1B16740F7C;
        Mon, 11 May 2020 12:41:28 +0300 (MSK)
Received: from sas1-26681efc71ef.qloud-c.yandex.net (sas1-26681efc71ef.qloud-c.yandex.net [2a02:6b8:c08:37a4:0:640:2668:1efc])
        by mxback7o.mail.yandex.net (mxback/Yandex) with ESMTP id yKL0WgAc9v-fRSatHhb;
        Mon, 11 May 2020 12:41:28 +0300
Received: by sas1-26681efc71ef.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id DORVneTPcb-fQ3umc3B;
        Mon, 11 May 2020 12:41:26 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [general question] rare silent data corruption when writing data
To:     Sarah Newman <srn@prgmr.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     John Stoffel <john@stoffel.org>,
        Roger Heflin <rogerheflin@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
 <CAAMCDef6hKJsPw3738KJ0vEEwnVKB-QpTMJ6aSeybse-4h+y6Q@mail.gmail.com>
 <24244.30530.155404.154787@quad.stoffel.home>
 <adccabc0-529f-e0a9-538f-1e5b784269e4@yandex.pl>
 <CAJCQCtRWvsKwwoZejERq=_OLXEa3JQd5RJ65tCz=X=Sp1xtRMQ@mail.gmail.com>
 <cd93b47a-7d77-5491-9632-0cea1f34bbe4@prgmr.com>
 <532aaee8-7140-fc30-c376-dbea880186c7@prgmr.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <397960a1-9757-7de7-cba7-a9778d13254d@yandex.pl>
Date:   Mon, 11 May 2020 11:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <532aaee8-7140-fc30-c376-dbea880186c7@prgmr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/10/20 9:12 PM, Sarah Newman wrote:
> On 5/10/20 12:05 PM, Sarah Newman wrote:
>> On 5/7/20 8:44 PM, Chris Murphy wrote:
>>>
>>> I would change very little until you track this down, if the goal is
>>> to track it down and get it fixed.
>>>
>>> I'm not sure if LVM thinp is supported with LVM raid still, which if
>>> it's not supported yet then I can understand using mdadm raid5 instead
>>> of LVM raid5.
>>
>>
>> My apologies if this ideas was considered and discarded already, but 
>> the bug being hard to reproduce right after reboot and the error being 
>> exactly the size of a page sounds like a memory use after free bug or 
>> similar.
>>
>> A debug kernel build with one or more of these options may find the 
>> problem:
>>
>> CONFIG_DEBUG_PAGEALLOC
>> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
>> CONFIG_PAGE_POISONING + page_poison=1
>> CONFIG_KASAN
>>
>> --Sarah
> 
> And on further reflection you may as well add these:
> 
> CONFIG_DEBUG_OBJECTS
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT
> CONFIG_CRASH_DUMP (kdump)
> 
> + anything else available. Basically turn debugging on all the way.
> 
> If you can reproduce reliably with these, then you can try the latest 
> kernel with the same options and have some confidence the problem was 
> legitimately fixed.
> 

After compiling the kernel with above options enabled - and if this is 
the underlying issue as you suspect - will it just pop in dmesg if I hit 
this bug, or do I need some extra tools/preparation/etc. ?

