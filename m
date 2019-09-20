Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40638B975E
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbfITSuF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Fri, 20 Sep 2019 14:50:05 -0400
Received: from mail.ugal.ro ([193.231.148.6]:5246 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405208AbfITSuE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 14:50:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id 0684213A2F557;
        Fri, 20 Sep 2019 18:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0A7wHY5ZuRe3; Fri, 20 Sep 2019 21:49:54 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 7622F13A2F540;
        Fri, 20 Sep 2019 21:49:54 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'Wols Lists'" <antlists@youngman.org.uk>,
        "'Sarah Newman'" <srn@prgmr.com>, <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro> <5D84F749.9070801@youngman.org.uk> <56ccd626-44fe-7266-563c-1da5d11d4180@prgmr.com> <5D851C92.4030009@youngman.org.uk>
In-Reply-To: <5D851C92.4030009@youngman.org.uk>
Subject: RE: RAID 10 with 2 failed drives
Date:   Fri, 20 Sep 2019 21:50:05 +0300
Organization: =?UTF-8?Q?Universitatea_=E2=80=9EDunarea_de_Jos=E2=80=9D_d?=
        =?UTF-8?Q?in_Gala=3Fi?=
Message-ID: <09ea01d56fe4$37c6cde0$a75469a0$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wIdV4DuAX86UEICO3rFy6UPVkbQ
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



-----Original Message-----
From: Wols Lists [mailto:antlists@youngman.org.uk] 
Sent: vineri, 20 septembrie 2019 21:38
To: Sarah Newman <srn@prgmr.com>; Liviu.Petcu@ugal.ro; linux-raid@vger.kernel.org
Subject: Re: RAID 10 with 2 failed drives

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

The partition 2 is for storage (raid 10 array) and partition 1 is for the system (raid 1 array).

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

Yes. It is offset layout.

The rule with raid-10 is that you can lose AT LEAST n-1 drives where n
is the number of mirrors. So if there are three mirrors of two drives
each, this array is safe. You can lose AT MOST p drives, where p is the
number of drives in a mirror. So this array *could* be safe with 2
mirrors. What you can't do is lose n drives that are mirroring each
other. The fact that the array is active makes me suspect that he is lucky.

I hope so... 

NOTE that mdadm has problems with a degraded array if it was working
last time it tried! That doesn't mean it can't get it working, it means
it's trying to draw attention to the problem.

Cheers,
Wol

Thank you Wol!



