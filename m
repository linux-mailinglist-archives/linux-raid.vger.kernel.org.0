Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C93680E8
	for <lists+linux-raid@lfdr.de>; Sun, 14 Jul 2019 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfGNTFs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Jul 2019 15:05:48 -0400
Received: from michael-notr.mail.tiscali.it ([213.205.33.216]:52561 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728297AbfGNTFs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 14 Jul 2019 15:05:48 -0400
Received: from [192.168.2.137] ([217.27.115.45])
        by michael.mail.tiscali.it with 
        id cj5l2000W0yqAhV01j5l6u; Sun, 14 Jul 2019 19:05:46 +0000
x-auth-user: farmatito@tiscali.it
Subject: Re: Weird behaviour of md, maybe a bug in 4.19.xx kernel?
To:     Sarah Newman <srn@prgmr.com>, linux-raid@vger.kernel.org
Cc:     Wols Lists <antlists@youngman.org.uk>
References: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
 <5D2B3FF9.8000806@youngman.org.uk>
 <4f572716-abd7-5a4e-709c-285a330a92c4@tiscali.it>
 <5da074ee-a0e5-18ac-84ad-6311ff95f0ba@prgmr.com>
From:   Tito <farmatito@tiscali.it>
Message-ID: <202bd4ec-feac-80ab-0622-fae2de37588f@tiscali.it>
Date:   Sun, 14 Jul 2019 21:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5da074ee-a0e5-18ac-84ad-6311ff95f0ba@prgmr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1563131146; bh=Cy7HSZGFmFcrxUygRf/7tI3MJ/McE81dlbwCBwZKKro=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eImghWmUZZ2f4VUOw4PIb8F2gFngu7xqdNSE6DtADNgVz43bQ25raEdqzNOlM/V+1
         uQi9jcDGiI/x3lDeAQa0S59kjrpn45LVCw8YpLxVX/xMnDHz0VjW1kp5gFfpz7ILS/
         utxZ7SfAIgkAXRGBTb526FcAt2bZg2Lms7jbFfHs=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/14/19 7:43 PM, Sarah Newman wrote:
> On 7/14/19 10:05 AM, Tito wrote:
>> On 7/14/19 4:45 PM, Wols Lists wrote:
>>> On 14/07/19 15:05, Tito wrote:
>>>> Hi,
>>>> I've got this email address from the MAINTAINERS file in the linux kernel
>>>> source, so I hope it is the right place to contact.
>>>> I'm running a debian/devuan system for a long time with several
>>>> md arrays on the embedded controller and on a ibm M1015 card
>>>> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
>>>> My typical setup is:
>>>
>>> You've got the right place. I can't see any mention of what disks you
>>> have, because that could well be relevant.
>>>
>>> Can I point you at the raid wiki for a good read ... :-)
>>>
>>> https://raid.wiki.kernel.org/index.php/Linux_Raid
>>>
>>> It contains a bunch of advice on troubleshooting and stuff, and it'll
>>> hopefully help you identify anything weird so making it easier for you
>>> to point us in the right direction and provide us with the stuff we need.
>>>
>>> Cheers,
>>> Wol
>>>
>>
>> Hi,
>> thanks for your advice, read the wiki and gathered all info as requested,
>> hope that attaching them is ok, or do you prefer them in the body.
> 
> 
> On 7/14/19 10:05 AM, Tito wrote:> On 7/14/19 4:45 PM, Wols Lists wrote:
>  >> On 14/07/19 15:05, Tito wrote:
>  >>> Hi,
>  >>> I've got this email address from the MAINTAINERS file in the linux kernel
>  >>> source, so I hope it is the right place to contact.
>  >>> I'm running a debian/devuan system for a long time with several
>  >>> md arrays on the embedded controller and on a ibm M1015 card
>  >>> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
>  >>> My typical setup is:
>  >>
>  >> You've got the right place. I can't see any mention of what disks you
>  >> have, because that could well be relevant.
>  >>
>  >> Can I point you at the raid wiki for a good read ... :-)
>  >>
>  >> https://raid.wiki.kernel.org/index.php/Linux_Raid
>  >>
>  >> It contains a bunch of advice on troubleshooting and stuff, and it'll
>  >> hopefully help you identify anything weird so making it easier for you
>  >> to point us in the right direction and provide us with the stuff we need.
>  >>
>  >> Cheers,
>  >> Wol
>  >>
>  >
>  > Hi,
>  > thanks for your advice, read the wiki and gathered all info as requested,
>  > hope that attaching them is ok, or do you prefer them in the body.
> 
> To me this looks like your problem:
> 
>  > Jul 14 07:54:12 debian kernel: [38809.927619] sd 2:0:6:0: [sdg] tag#580 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>  > Jul 14 07:54:12 debian kernel: [38809.927624] sd 2:0:6:0: [sdg] tag#580 Sense Key : Not Ready [current]
>  > Jul 14 07:54:12 debian kernel: [38809.927627] sd 2:0:6:0: [sdg] tag#580 Add. Sense: Logical unit not ready, cause not reportable
>  > Jul 14 07:54:12 debian kernel: [38809.927632] sd 2:0:6:0: [sdg] tag#580 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> 
> FYI there's no overlap between the drives in the raid1 (sda, sdk, sdj) and the drives in the raid5 and raid6.
> 
> According to lsdrv sda, sdk, sdj, and sdl are all on the on-board SATA controller. If you've never seen an error on sdl despite it being in the raid6 then I'd pin the blame on the SAS2008 card. You should probably start by checking the firmware version and making 
> sure it's up to date. If it is up to date then try looking for bugs and updates related to the mpt3sas driver.
> 
> --Sarah
> 

Hi,
thanks for your advice. I've updated the firmware of the SAS2008 card (reflashed it in IR mode) but it really didn't make any difference,
only switching kernels so far did fix it.
I've changed all the drives in the raid5 array because some of them showed the issue ("Power-on or device reset occurred") and as they were
rather old age I thought that it could be a hardware problem but I can't say if /dev/sdl was among the problematic ones.
Will check the mpt3sas driver.

Best regards and thanks for your help.
Tito




