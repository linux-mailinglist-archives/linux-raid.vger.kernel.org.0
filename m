Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E951E788C
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2InL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 04:43:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgE2InK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 04:43:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CF6A3BC00AC0CED150D;
        Fri, 29 May 2020 16:43:07 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 16:42:58 +0800
Subject: Re: [PATCH v3 01/11] md/raid5: add CONFIG_MD_RAID456_STRIPE_SHIFT to
 set STRIPE_SIZE
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, "Xiao Ni" <xni@redhat.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <20200527131933.34400-2-yuyufen@huawei.com>
 <CAPhsuW7JLcWDEwEcN-6c+NHhMD1qrPtPNPa-k8y9SX3bVX_FzA@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <7eb45e9f-c99c-cb78-9362-8f1b7513292f@huawei.com>
Date:   Fri, 29 May 2020 16:42:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7JLcWDEwEcN-6c+NHhMD1qrPtPNPa-k8y9SX3bVX_FzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/28 22:23, Song Liu wrote:
> On Wed, May 27, 2020 at 6:20 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>
> [...]
>> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
>> index f90e0704bed9..b25f107dafc7 100644
>> --- a/drivers/md/raid5.h
>> +++ b/drivers/md/raid5.h
>> @@ -472,7 +472,9 @@ struct disk_info {
>>    */
>>
>>   #define NR_STRIPES             256
>> -#define STRIPE_SIZE            PAGE_SIZE
>> +#define CONFIG_STRIPE_SIZE     (CONFIG_MD_RAID456_STRIPE_SHIFT << 9)
>> +#define STRIPE_SIZE            \
>> +       (CONFIG_STRIPE_SIZE > PAGE_SIZE ? PAGE_SIZE : CONFIG_STRIPE_SIZE)
>>   #define STRIPE_SHIFT           (PAGE_SHIFT - 9)
> 
> I think we also need to update STRIPE_SHIFT.
> 
Yeah, I forgot to update it. Thanks for catching this.

Thanks,
Yufen
