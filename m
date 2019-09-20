Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA1B958F
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfITQYo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 12:24:44 -0400
Received: from mail.prgmr.com ([71.19.149.6]:59092 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388479AbfITQYo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 12:24:44 -0400
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id CC44372008B;
        Fri, 20 Sep 2019 17:19:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com CC44372008B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1569014399;
        bh=aUUUcXHzxrg8LRNi9YAbeuFU03P4/aHe82VjEPH93Ss=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dGFTH7mPFZDL7xdXe05fylOod/kATsbxN8Zudj21pS7HBLxXYLcyhg/x4v63V7R/i
         CGLpYKZtit1xiU4KmTcYOMy7N9AeBqluWNrd9faiPc/Szqx/HFXNK+FAW2BRJiCWkj
         0vnUR2WODhr1og/wJgm34wRhvv4Uka3tJ8E6fCyo=
Subject: Re: RAID 10 with 2 failed drives
To:     Wols Lists <antlists@youngman.org.uk>, Liviu.Petcu@ugal.ro,
        linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <5D84F749.9070801@youngman.org.uk>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <56ccd626-44fe-7266-563c-1da5d11d4180@prgmr.com>
Date:   Fri, 20 Sep 2019 09:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D84F749.9070801@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/20/19 8:59 AM, Wols Lists wrote:
> On 19/09/19 21:45, Liviu Petcu wrote:
>> Hello,
>>
>> Please let me know if in this situation detailed below, there are chances of restoring the RAID 10 array and how I can do it safely.
>> Thank you!
> 
> This is linux raid 10, not some form of raid 1+0? That's what it looks
> like to me. I notice it says the array is active! That I think is good news!

I thought that there should be a flag like 'degraded' if the raid was actually running. I can't find the kernel documentation any more.

> 
> Can you mount it read-only and read it? I would be surprised if you
> can't, which means the array is running fine in degraded mode. NOT GOOD
> but not a problem provided nothing further goes wrong. I notice it's
> also version 0.9 - is it an old array? Have the drives themselves
> failed? (which I guess is probably the case :-( I guess the drives
> effectively have just the one partition - 2 - and 1 is something
> unimportant?

What you said is definitely true for a near layout for an even number of devices and n=2.

I thought the offset layout meant any two adjacent raid devices failing was data loss, assuming this is accurate:

http://www.ilsistemista.net/index.php/linux-a-unix/35-linux-software-raid-10-layouts-performance-near-far-and-offset-benchmark-analysis.html?start=1

--Sarah
