Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39C2145CA
	for <lists+linux-raid@lfdr.de>; Sat,  4 Jul 2020 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGDMZO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Jul 2020 08:25:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7371 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbgGDMZO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 4 Jul 2020 08:25:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E38D1550E1107886075;
        Sat,  4 Jul 2020 20:25:09 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 4 Jul 2020 20:25:03 +0800
Subject: Re: [PATCH v5 12/16] md/raid5: support config stripe_size by sysfs
 entry
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <20200702120628.777303-13-yuyufen@huawei.com>
 <CAPhsuW5rTOwd+hPsBobFWD4TWGO4pWMgwt5BVAt=Fnab71MC=w@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <e5096dc3-1a6e-e021-c114-1186607e438c@huawei.com>
Date:   Sat, 4 Jul 2020 20:25:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5rTOwd+hPsBobFWD4TWGO4pWMgwt5BVAt=Fnab71MC=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/7/3 6:38, Song Liu wrote:
> On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>
>> After this patch, we can adjust stripe_size by writing value into sysfs
>> entry, likely, set stripe_size as 16KB:
>>
>>            echo 16384 > /sys/block/md1/md/stripe_size
>>
>> Show current stripe_size value:
>>
>>            cat /sys/block/md1/md/stripe_size
>>
>> stripe_size should not be bigger than PAGE_SIZE, and it requires to be
>> multiple of 4096.
> 
> I think we can just merge 02/16 into this one.
> 
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/md/raid5.c | 69 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index f0fd01d9122e..a3376a4e4e5c 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -6715,7 +6715,74 @@ raid5_show_stripe_size(struct mddev  *mddev, char *page)
>>   static ssize_t
>>   raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
>>   {
>> -       return -EINVAL;
>> +       struct r5conf *conf = mddev->private;
> 
> We need mddev_lock(mddev) before accessing mddev->private.
>

Thanks to point this bug. I will fix it.

Thanks,
Yufen
