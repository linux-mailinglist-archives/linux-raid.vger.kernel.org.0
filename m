Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2519B2153B4
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jul 2020 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGFIHW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jul 2020 04:07:22 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:57882 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbgGFIHW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jul 2020 04:07:22 -0400
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id CB1664A119B;
        Mon,  6 Jul 2020 11:07:19 +0300 (MSK)
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id C53297F2001A;
        Mon,  6 Jul 2020 11:07:19 +0300 (MSK)
Received: from vla1-bdd5685c3f79.qloud-c.yandex.net (vla1-bdd5685c3f79.qloud-c.yandex.net [2a02:6b8:c0d:4201:0:640:bdd5:685c])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id V6dllA6BcL-7JPeps8g;
        Mon, 06 Jul 2020 11:07:19 +0300
Received: by vla1-bdd5685c3f79.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id kb28Laoaq4-7IE4cCsH;
        Mon, 06 Jul 2020 11:07:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
From:   Michal Soltys <msoltyspl@yandex.pl>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <0cf6454d-a8b5-4bee-5389-94b23c077050@yandex.pl>
 <CAPhsuW51u6KWLvUntMXPU7stu7oSA+d-yT6zf7G0zCETzLWwiA@mail.gmail.com>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl>
 <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl>
 <CAPhsuW59Q7mU9WH36RHs9kb-TMk7FmrQL+JCApupf_TZtpWynA@mail.gmail.com>
 <4a03e900-61a8-f150-9be8-739e88ba8ce6@yandex.pl>
 <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
 <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl>
 <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
 <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl>
 <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
 <57247f5e-ec38-fb8c-9684-abbe699945fb@yandex.pl>
 <CAPhsuW4hnpsbhQWWNKqgnw4nhp4Ho+gFbPU2fGjoMOcM8y7L+Q@mail.gmail.com>
 <15a3dd66-39a9-894d-3e72-d231cf36758e@yandex.pl>
Message-ID: <4577498e-4124-ac6f-9d76-1f039fa1ba80@yandex.pl>
Date:   Mon, 6 Jul 2020 10:07:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <15a3dd66-39a9-894d-3e72-d231cf36758e@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20/06/25 18:11, Michal Soltys wrote:
> On 6/24/20 1:13 AM, Song Liu wrote:
>> On Tue, Jun 23, 2020 at 6:17 AM Michal Soltys <msoltyspl@yandex.pl> 
>> wrote:
>>
>> Hmm.. this is weird, as I think I marked every instance of set_bit
>> MD_SB_CHANGE_PENDING.
>> Would you mind confirm those are to the other array with something like:
>>
>> diff --git i/drivers/md/md.c w/drivers/md/md.c
>> index dbbc8a50e2ed2..e91acfdcec032 100644
>> --- i/drivers/md/md.c
>> +++ w/drivers/md/md.c
>> @@ -8480,7 +8480,7 @@ bool md_write_start(struct mddev *mddev, struct 
>> bio *bi)
>>                          mddev->in_sync = 0;
>>                          set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
>>                          set_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
>> -                       pr_info("%s set MD_SB_CHANGE_PENDING\n", 
>> __func__);
>> +                       pr_info("%s: md: %s set
>> MD_SB_CHANGE_PENDING\n", __func__, mdname(mddev));
>>                          md_wakeup_thread(mddev->thread);
>>                          did_change = 1;
>>                  }
>>
>> Thanks,
>> Song
>>
> 
> dmesg attached
> - md127 - journal
> - md126 - the other raid
> - md125 - the problematic one

So, what kind of next step after this ?
