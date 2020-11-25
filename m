Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7914E2C4B63
	for <lists+linux-raid@lfdr.de>; Thu, 26 Nov 2020 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgKYXSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Wed, 25 Nov 2020 18:18:46 -0500
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17328 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgKYXSq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 25 Nov 2020 18:18:46 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1606346321; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=A92Qszm4jBbN+DrZYilq2hIRWdRS03jdOX4Z0LQz6Np5d8H5BmQJJpihA/qT1KZUufcC+kqPS/iPz6wifgjoyCn3pwC+0s5Idvy42JeBMHEYL9BktHHZUauKLM7VGEtcjieHiqKqYA3HsoiaPstT3mBf3941WFwgjsBsP78K00c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1606346321; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ratKEku+YKw3FXAX+mvGUsvJ1X8Yb6VLGZQ5LbUYOjc=; 
        b=BBr+npyXFTeMkPkBA/cRl2/kRkic2zoBWp43pPPeB5HGmaGUCEhbut8NJOiAQMclEdmNDrFt0Ny5Oe8qHXIIe1Z1ew5QrPrwUylD4urgtuifSqw5ouklCC1S12Tlk3fSZ0lE/YedEPylOEuVZjdcozkCEkriTJT5SZe9CO/BCpw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [IPv6:2620:10d:c0a8:1102::1844] (163.114.130.3 [163.114.130.3]) by mx.zoho.eu
        with SMTPS id 1606346320808503.5400399091981; Thu, 26 Nov 2020 00:18:40 +0100 (CET)
Subject: Re: [PATCH 1/1] mdadm/bitmap: locate bitmap calcuate bitmap position
 wrongly
To:     "heming.zhao@suse.com" <heming.zhao@suse.com>,
        Xiao Ni <xni@redhat.com>
Cc:     ncroxon@redhat.com, heinzm@redhat.com, linux-raid@vger.kernel.org
References: <1603865064-27404-1-git-send-email-xni@redhat.com>
 <95046dfe-c770-8950-c720-6b1d30bb1789@suse.com>
 <f0616f2c-7156-8717-349d-7dcf349fd421@redhat.com>
 <779a49d4-43d8-2f8b-59ec-6d45d61cc3f9@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <73df4806-177a-9aca-4968-61c593e3333d@trained-monkey.org>
Date:   Wed, 25 Nov 2020 18:18:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <779a49d4-43d8-2f8b-59ec-6d45d61cc3f9@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/30/20 2:44 AM, heming.zhao@suse.com wrote:
> You are right. Only cluster case can trigger your patch code.
> Hardcode 4096 is correct.

Just catching up, was the conclusion the original patch was correct?

Thanks,
Jes


> On 10/30/20 1:53 PM, Xiao Ni wrote:
>> Hi Heming
>>
>> The cluster raid is only supported by super 1.2, so we don't need to consider the old system when
>> it's a cluster raid.
>>
>> Regards
>> Xiao
>>
>> On 10/28/2020 08:29 PM, heming.zhao@suse.com wrote:
>>> Hello Xiao,
>>>
>>> My review comment:
>>> You code only work in modern system. the boundary is 4k not 512, because using hardcode 4k to call calc_bitmap_size
>>>
>>> In current cluster env, if bitmap area beyond 4K size (or 512 in very old system), locate_bitmap1
>>> will return wrong address.
>>>
>>> Please refer write_bitmap1() to saparate 512 & 4096 case.
>>>
>>> On 10/28/20 2:04 PM, Xiao Ni wrote:
>>>> Now it only adds bitmap offset based on cluster nodes. It's not right. It needs to
>>>> add per node bitmap space to find next node bitmap position.
>>>>
>>>> Signed-off-by: Xiao Ni <xni@redhat.com>
>>>> ---
>>>>    super1.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/super1.c b/super1.c
>>>> index 8b0d6ff..b5b379b 100644
>>>> --- a/super1.c
>>>> +++ b/super1.c
>>>> @@ -2582,8 +2582,9 @@ add_internal_bitmap1(struct supertype *st,
>>>>    static int locate_bitmap1(struct supertype *st, int fd, int node_num)
>>>>    {
>>>> -    unsigned long long offset;
>>>> +    unsigned long long offset, bm_sectors_per_node;
>>>>        struct mdp_superblock_1 *sb;
>>>> +    bitmap_super_t *bms;
>>>>        int mustfree = 0;
>>>>        int ret;
>>>> @@ -2598,8 +2599,13 @@ static int locate_bitmap1(struct supertype *st, int fd, int node_num)
>>>>            ret = 0;
>>>>        else
>>>>            ret = -1;
>>>> -    offset = __le64_to_cpu(sb->super_offset);
>>>> -    offset += (int32_t) __le32_to_cpu(sb->bitmap_offset) * (node_num + 1);
>>>> +
>>>> +    offset = __le64_to_cpu(sb->super_offset) + __le32_to_cpu(sb->bitmap_offset);
>>>> +    if (node_num) {
>>>> +        bms = (bitmap_super_t*)(((char*)sb)+MAX_SB_SIZE);
>>>> +        bm_sectors_per_node = calc_bitmap_size(bms, 4096) >> 9;
>>>> +        offset += bm_sectors_per_node * node_num;
>>>> +    }
>>>>        if (mustfree)
>>>>            free(sb);
>>>>        lseek64(fd, offset<<9, 0);
>>>>
>>
> 


