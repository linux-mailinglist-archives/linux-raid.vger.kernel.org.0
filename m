Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176EA72392
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jul 2019 03:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfGXBH2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jul 2019 21:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfGXBH1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jul 2019 21:07:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96AC5307D85B;
        Wed, 24 Jul 2019 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 324975D71A;
        Wed, 24 Jul 2019 01:07:24 +0000 (UTC)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Luca Lazzarin <luca.lazzarin@gmail.com>,
        Wol's lists <antlists@youngman.org.uk>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
 <5D25A4A4.2000609@youngman.org.uk>
 <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
 <20190710173354.GA5523@lazy.lzy>
 <08871cf8-8ae7-cde1-7b45-0d75fe42026e@gmail.com>
 <1a8b3284-1338-9165-6359-5fdc71430b22@youngman.org.uk>
 <6359befe-4287-8ca1-b411-5dd907c9e262@gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <9858780a-3b47-a731-316b-ae6622c7870f@redhat.com>
Date:   Wed, 24 Jul 2019 09:07:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <6359befe-4287-8ca1-b411-5dd907c9e262@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 01:07:27 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Luca and Wol

Now it has a problem about the combination of raid6 and dm-integrity. If 
there are many read failures at a time,

it can set the member as faulty.

                 } else if (atomic_read(&rdev->read_errors)
                          > conf->max_nr_stripes)
                         printk(KERN_WARNING
                                "md/raid:%s: Too many read errors, 
failing device %s.\n",
                                mdname(conf->mddev), bdn);

But now it just can be reproduced on virtual machines and we modify 
about 500MB data of the disk. And in real world I think it's hard to 
trigger this.

@Luca, this combination can fix the silent data corruption 
automatically. If there are some data is broken on some sectors, this 
combination can

fix it automatically. I pasted one link several days before. You can 
check it.

Regards

Xiao


On 07/24/2019 04:34 AM, Luca Lazzarin wrote:
> I do not know it. Could you please link me to some infos?
>
> Why do you suggest it?
> I mean, which benefits will it give to me?
>
> Thanks :-)
>
> On 23/07/19 22:30, Wol's lists wrote:
>> On 23/07/2019 21:16, Luca Lazzarin wrote:
>>> Thank you all for your suggestiong.
>>>
>>> I'll probably choose RAID6.
>>
>> Any chance of putting it on top of dm-integrity? If you do can you 
>> post about it (seeing as it's new), but it sounds like it's something 
>> all raids should have.
>>
>> Cheers,
>> Wol
>
>

