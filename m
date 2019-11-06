Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76FF1B87
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfKFQpp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 11:45:45 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:58110 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfKFQpp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 6 Nov 2019 11:45:45 -0500
Received: from [81.148.226.176] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iSORC-0007Tr-4C; Wed, 06 Nov 2019 16:45:42 +0000
Subject: Re: [PATCH] mdadm.8: add note information for raid0 growing operation
To:     Coly Li <colyli@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20191105075540.56013-1-colyli@suse.de>
 <605de72e-0771-adc8-d39c-fc9e634e9b9b@molgen.mpg.de>
 <29133ed2-98d0-94c0-8787-711ec7d5cb1a@suse.de>
 <5DC1727C.5030409@youngman.org.uk>
 <b6295129-6200-33cb-10dc-5bed6503c442@suse.de>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.de>,
        jes.sorensen@gmail.com
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DC2F8B4.1010201@youngman.org.uk>
Date:   Wed, 6 Nov 2019 16:45:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <b6295129-6200-33cb-10dc-5bed6503c442@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/11/19 13:15, Coly Li wrote:
> On 2019/11/5 9:00 下午, Wols Lists wrote:
>> On 05/11/19 12:44, Coly Li wrote:
>>>>> are devices number before and  after  the grow operation, "* 2" comes
>>>>>
>>>>> device numbers
>>> Copied. I am not sure whether it should be "device numbers" or maybe
>>> "devices numbers", this confuses me *^_^*
>>>
>> It is "device numbers".
>>
>> The trick for English is to ask yourself what is the singular form. Here
>> it is "device number". Then convert that to plural by adding an "s" at
>> the end.
>>
> 
> Let me explain why I am confused.
> 
> Because the raid0 device can be combined by many disks, there will be
> multiple component devices, so I think the number should be "component
> disks number". Then I mentioned old and new numbers, there are two
> numbers, so I am not sure whether I should use "devices numbers",
> because devices means multiple component devices, and numbers means
> there are two numbers (one for old, one for new).
> 
>> English never "doubles up" as far as I'm aware (and I bet someone comes
>> up with an obscure example where it does :-)
>>
> 
> By the above explanation, is it still "device numbers" ?
> 
Yup I think it is :-)

It gets complicated ... :-) But I presume you mean a device can have two
different numbers, one from before the change and one after. In which
case it is "device numbers".

"devices numbers" is grammatically wrong full stop, but you could have a
possessive device(s), as in "device's numbers" (singular device) or
"devices' numbers" (several devices).

English is a tricky language, not because it has that many or
complicated rules (it doesn't), but because it's stolen so many words
and rules from other languages that you're forever tripping up on
something that doesn't follow the usual rules ... :-)

Cheers,
Wol

