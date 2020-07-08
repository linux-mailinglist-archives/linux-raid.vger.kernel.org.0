Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069A8217D03
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jul 2020 04:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgGHCWm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Jul 2020 22:22:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729199AbgGHCWm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Jul 2020 22:22:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB0FA6D9311674145312;
        Wed,  8 Jul 2020 10:22:39 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Jul 2020 10:22:33 +0800
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <houtao1@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <20200702120628.777303-2-yuyufen@huawei.com>
 <84277307-fc0a-44e2-8564-699651a7ff47@cloud.ionos.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <a90dd862-3eef-c2db-0ea3-a1049139f9f0@huawei.com>
Date:   Wed, 8 Jul 2020 10:22:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <84277307-fc0a-44e2-8564-699651a7ff47@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/7/6 17:09, Guoqing Jiang wrote:
> On 7/2/20 2:06 PM, Yufen Yu wrote:
>> @@ -2509,10 +2532,11 @@ static void raid5_end_read_request(struct bio * bi)
>>                */
>>               pr_info_ratelimited(
>>                   "md/raid:%s: read error corrected (%lu sectors at %llu on %s)\n",
>> -                mdname(conf->mddev), STRIPE_SECTORS,
>> +                mdname(conf->mddev),
>> +                conf->stripe_sectors,
> 
> The conf->stripe_sectors is printed with %lu format.
> 
>> ot allow a suitable chunk size */
>>           return ERR_PTR(-EINVAL);
>> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
>> index f90e0704bed9..e36cf71e8465 100644
>> --- a/drivers/md/raid5.h
>> +++ b/drivers/md/raid5.h
>> @@ -472,32 +472,12 @@ struct disk_info {
>>    */
>>   #define NR_STRIPES        256
>> -#define STRIPE_SIZE        PAGE_SIZE
>> -#define STRIPE_SHIFT        (PAGE_SHIFT - 9)
>> -#define STRIPE_SECTORS        (STRIPE_SIZE>>9)
>>   #define    IO_THRESHOLD        1
>>   #define BYPASS_THRESHOLD    1
>>   #define NR_HASH            (PAGE_SIZE / sizeof(struct hlist_head))
>>   #define HASH_MASK        (NR_HASH - 1)
>>   #define MAX_STRIPE_BATCH    8
> 
> [...]
> 
>>     return NULL;
>> -}
>> -
>>   /* NOTE NR_STRIPE_HASH_LOCKS must remain below 64.
>>    * This is because we sometimes take all the spinlocks
>>    * and creating that much locking depth can cause
>> @@ -574,6 +554,9 @@ struct r5conf {
>>       int            raid_disks;
>>       int            max_nr_stripes;
>>       int            min_nr_stripes;
>> +    unsigned int    stripe_size;
>> +    unsigned int    stripe_shift;
>> +    unsigned int    stripe_sectors;
> 
> So you need to define it with "unsigned long".

Yes, I will revise it.

Thanks,
Yufen
