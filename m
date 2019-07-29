Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0978AA8
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfG2LhG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 07:37:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387483AbfG2LhG (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 29 Jul 2019 07:37:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D061777273E8B30FDCE0;
        Mon, 29 Jul 2019 19:37:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 19:36:55 +0800
Subject: Re: [PATCH] md/raid1: fix a race between removing rdev and access
 conf->mirrors[i].rdev
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        <liu.song.a23@gmail.com>
CC:     <neilb@suse.com>, <houtao1@huawei.com>, <zou_wei@huawei.com>,
        <linux-raid@vger.kernel.org>
References: <20190726060051.16630-1-yuyufen@huawei.com>
 <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
 <b98073c3-4b81-dd4a-09b1-47e277c24961@huawei.com>
 <538db63a-d316-5783-f45b-b8310d19b7b9@cloud.ionos.com>
 <d3bec7ef-4e35-8a32-8b11-cda5e99b453d@cloud.ionos.com>
 <3e6b5faf-a588-8cf0-1c49-8ffd15532a19@cloud.ionos.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <913a04be-a00c-849c-a064-f2cde477dbe6@huawei.com>
Date:   Mon, 29 Jul 2019 19:36:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3e6b5faf-a588-8cf0-1c49-8ffd15532a19@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/7/29 18:17, Guoqing Jiang wrote:
> Now actually add list to CC ..., sorry about it.
>
> On 7/29/19 12:15 PM, Guoqing Jiang wrote:
>> Forgot to cc list ...
>>
>>> Thanks a lot for the detailed explanation!
>>>
>>> For the issue, maybe a better way is to call "p->rdev = NULL" after 
>>> synchronize_rcu().
>>> Could you try the below change? Thanks.
>>>
>>>
>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>> index 34e26834ad28..867808bed325 100644
>>> --- a/drivers/md/raid1.c
>>> +++ b/drivers/md/raid1.c
>>> @@ -1825,16 +1825,17 @@ static int raid1_remove_disk(struct mddev 
>>> *mddev, struct md_rdev *rdev)
>>>                          err = -EBUSY;
>>>                          goto abort;
>>>                  }
>>> -               p->rdev = NULL;
>>>                  if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>>                          synchronize_rcu();
>>> +                       p->rdev = NULL;
>>>                          if (atomic_read(&rdev->nr_pending)) {
>>>                                  /* lost the race, try later */
>>>                                  err = -EBUSY;
>>>                                  p->rdev = rdev;
>>>                                  goto abort;
>>>                          }
>>> -               }
>>> +               } else
>>> +                       p->rdev = NULL;
>>>                  if (conf->mirrors[conf->raid_disks + number].rdev) {
>>>                          /* We just removed a device that is being 
>>> replaced.
>>>                           * Move down the replacement.  We drain all 
>>> IO before
>>>

I don't think this can fix the race condition completely.

-               p->rdev = NULL;
                  if (!test_bit(RemoveSynchronized, &rdev->flags)) {
                          synchronize_rcu();
+                       p->rdev = NULL;
                          if (atomic_read(&rdev->nr_pending)) {

If we access conf->mirrors[i].rdev (e.g. raid1_write_request()) after 
RCU grace period,
synchronize_rcu() will not wait the reader. Then, it also can cause NULL 
pointer dereference.

That is the reason why we add the new flag 'WantRemove'. It can prevent 
the reader to access
the 'rdev' after RCU grace period.


>>>
>>> And I think the change should apply to raid10 as well, but let's see 
>>> the above works or not.
>>>
>>
>> Seems raid10_error doesn't have the code about recovery_disabled, 
>> then it is not necessary for raid10.
>>
>> Thanks,
>> Guoqing
>
> .
>

To be honest, I am not sure if RAID10/RAID5 also has this problem. More 
time needed to debug.

Thanks a lot.
Yufen


