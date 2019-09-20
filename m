Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6007B9750
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393126AbfITSiP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 14:38:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43601 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391785AbfITSiP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 14:38:15 -0400
Received: from [86.132.37.92] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iBNnH-0002Wo-Cl; Fri, 20 Sep 2019 19:38:12 +0100
Subject: Re: RAID 10 with 2 failed drives
To:     Sarah Newman <srn@prgmr.com>, Liviu.Petcu@ugal.ro,
        linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <5D84F749.9070801@youngman.org.uk>
 <56ccd626-44fe-7266-563c-1da5d11d4180@prgmr.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5D851C92.4030009@youngman.org.uk>
Date:   Fri, 20 Sep 2019 19:38:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <56ccd626-44fe-7266-563c-1da5d11d4180@prgmr.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20/09/19 17:24, Sarah Newman wrote:
> On 9/20/19 8:59 AM, Wols Lists wrote:
>> On 19/09/19 21:45, Liviu Petcu wrote:
>>> Hello,
>>>
>>> Please let me know if in this situation detailed below, there are
>>> chances of restoring the RAID 10 array and how I can do it safely.
>>> Thank you!
>>
>> This is linux raid 10, not some form of raid 1+0? That's what it looks
>> like to me. I notice it says the array is active! That I think is good
>> news!
> 
> I thought that there should be a flag like 'degraded' if the raid was
> actually running. I can't find the kernel documentation any more.
> 
>>
>> Can you mount it read-only and read it? I would be surprised if you
>> can't, which means the array is running fine in degraded mode. NOT GOOD
>> but not a problem provided nothing further goes wrong. I notice it's
>> also version 0.9 - is it an old array? Have the drives themselves
>> failed? (which I guess is probably the case :-( I guess the drives
>> effectively have just the one partition - 2 - and 1 is something
>> unimportant?
> 
> What you said is definitely true for a near layout for an even number of
> devices and n=2.
> 
> I thought the offset layout meant any two adjacent raid devices failing
> was data loss, assuming this is accurate:
> 
> http://www.ilsistemista.net/index.php/linux-a-unix/35-linux-software-raid-10-layouts-performance-near-far-and-offset-benchmark-analysis.html?start=1
> 
Except you've failed to extrapolate, sorry. We have six drives, not the
four of the example. Although you could still be right. Does "offset=2"
mean 2 copies, offset layout?

The rule with raid-10 is that you can lose AT LEAST n-1 drives where n
is the number of mirrors. So if there are three mirrors of two drives
each, this array is safe. You can lose AT MOST p drives, where p is the
number of drives in a mirror. So this array *could* be safe with 2
mirrors. What you can't do is lose n drives that are mirroring each
other. The fact that the array is active makes me suspect that he is lucky.

NOTE that mdadm has problems with a degraded array if it was working
last time it tried! That doesn't mean it can't get it working, it means
it's trying to draw attention to the problem.

Cheers,
Wol
