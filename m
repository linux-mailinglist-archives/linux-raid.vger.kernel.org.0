Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2CA419A
	for <lists+linux-raid@lfdr.de>; Sat, 31 Aug 2019 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfHaCA1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 22:00:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728246AbfHaCA1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 30 Aug 2019 22:00:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 50E3224779B8604E0FC1;
        Sat, 31 Aug 2019 10:00:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 31 Aug 2019
 10:00:18 +0800
Subject: Re: [RFC PATCH] md/raid5: set STRIPE_SIZE as a configurable value
To:     NeilBrown <neilb@suse.de>, <songliubraving@fb.com>,
        <linux-raid@vger.kernel.org>
CC:     <xni@redhat.com>, <yuyufen@huawei.com>
References: <20190829081514.29660-1-yuyufen@huawei.com>
 <877e6vf45p.fsf@notabene.neil.brown.name>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <07ffeca5-6b69-0602-0981-2221cfb682af@huawei.com>
Date:   Sat, 31 Aug 2019 10:00:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <877e6vf45p.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/8/30 16:28, NeilBrown wrote:
> On Thu, Aug 29 2019, Yufen Yu wrote:
>
>> In RAID5, if issued bio has sectors more than STRIPE_SIZE,
>> it will be split in unit of STRIPE_SIZE. For bio sectors
>> less then STRIPE_SIZE, raid5 issue bio to disk in the size
>> of STRIPE_SIZE.
>>
>> For now, STRIPE_SIZE is equal to the value of PAGE_SIZE.
>> That means, RAID5 will issus echo bio to disk at least 64KB
>> when use 64KB page size in arm64.
>>
>> However, filesystem usually issue bio in the unit of 4KB.
>> Then, RAID5 will waste resource of disk bandwidth and compute xor.
>>
>> To avoding the waste, we can add a CONFIG option to set
>> the default STRIPE_SIZE as 4096. User can also set the value
>> bigger than 4KB for some special requirements, such as we know
>> the issued io size is more than 4KB.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/md/Kconfig | 9 +++++++++
>>   drivers/md/raid5.h | 2 +-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index 3834332f4963..4263a655dbbb 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -157,6 +157,15 @@ config MD_RAID456
>>   
>>   	  If unsure, say Y.
>>   
>> +config MD_RAID456_STRIPE_SIZE
>> +	int "RAID4/RAID5/RAID6 stripe size"
>> +	default "4096"
>> +	depends on MD_RAID456
>> +	help
>> +	  The default value is 4096. Only change this if you know
>> +	  what you are doing.
>> +
>> +
>>   config MD_MULTIPATH
>>   	tristate "Multipath I/O support"
>>   	depends on BLK_DEV_MD
>> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
>> index cf991f13403e..2fcf5853b719 100644
>> --- a/drivers/md/raid5.h
>> +++ b/drivers/md/raid5.h
>> @@ -473,7 +473,7 @@ struct disk_info {
>>    */
>>   
>>   #define NR_STRIPES		256
>> -#define STRIPE_SIZE		PAGE_SIZE
>> +#define STRIPE_SIZE		CONFIG_MD_RAID456_STRIPE_SIZE
>>   #define STRIPE_SHIFT		(PAGE_SHIFT - 9)
>>   #define STRIPE_SECTORS		(STRIPE_SIZE>>9)
>>   #define	IO_THRESHOLD		1
>> -- 
>> 2.17.2
> While I agree that this is a problem that should be fixed, I think your
> fix is rather simplistic.
>
> grow_buffers() uses alloc_page() allocate the buffers for each
> stripe_head()
> With this change, it will allocate 64K buffers and use 4K of them.
> This is a waste.  Unfortunately fixing it would be a lot more work.
> I think that is best way forward though.
>
> Also, I don't think this should be a config option - just make it
> always 4096.
>

Thanks a lot for your suggestion and pointing out what I have ignored.
I will rework it.

Thanks
Yufen

