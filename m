Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2093FA5036
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfIBHtK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 03:49:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbfIBHtJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 03:49:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D79D53C07D3D1FE33D1A;
        Mon,  2 Sep 2019 15:49:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Sep 2019
 15:49:06 +0800
Subject: Re: [PATCH] md/raid1: fail run raid1 array when active disk less than
 one
To:     NeilBrown <neilb@suse.de>, <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>
References: <20190902072436.23225-1-yuyufen@huawei.com>
 <87pnkjdudc.fsf@notabene.neil.brown.name>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <9529c6d5-37f3-a7c4-db86-3ebf04a8c893@huawei.com>
Date:   Mon, 2 Sep 2019 15:49:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87pnkjdudc.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/9/2 15:34, NeilBrown wrote:
> On Mon, Sep 02 2019, Yufen Yu wrote:
>
>> When active disk in raid1 array less than one, we need to return
>> fail to run.
> Seems reasonable, but how can this happen?
> As we never fail the last device in a RAID1, there should always
> appear to be one that is working.
>
> Have you had a situation where this in actually needed?

There is a situation we found in follow patch.
https://marc.info/?l=linux-raid&m=156740736305042&w=2

Though we can fix that situation, I am not sure whether other situation
can also cause the active disk less than one.

Thanks
Yufen

>
> Thanks,
> NeilBrown
>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/md/raid1.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 34e26834ad28..2a554464d6a4 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -3127,6 +3127,13 @@ static int raid1_run(struct mddev *mddev)
>>   		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
>>   		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
>>   			mddev->degraded++;
>> +	/*
>> +	 * RAID1 needs at least one disk in active
>> +	 */
>> +	if (conf->raid_disks - mddev->degraded < 1) {
>> +		ret = -EINVAL;
>> +		goto abort;
>> +	}
>>   
>>   	if (conf->raid_disks - mddev->degraded == 1)
>>   		mddev->recovery_cp = MaxSector;
>> @@ -3160,8 +3167,12 @@ static int raid1_run(struct mddev *mddev)
>>   	ret = md_integrity_register(mddev);
>>   	if (ret) {
>>   		md_unregister_thread(&mddev->thread);
>> -		raid1_free(mddev, conf);
>> +		goto abort;
>>   	}
>> +	return 0;
>> +
>> +abort:
>> +	raid1_free(mddev, conf);
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.17.2


