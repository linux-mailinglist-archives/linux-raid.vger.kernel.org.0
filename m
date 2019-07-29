Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1693A78CB8
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfG2NYF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 09:24:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387449AbfG2NYE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 29 Jul 2019 09:24:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 365C549C5C5A09E40AA1;
        Mon, 29 Jul 2019 21:24:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 21:23:55 +0800
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
 <913a04be-a00c-849c-a064-f2cde477dbe6@huawei.com>
 <d123f888-0f3c-2ba1-5c53-c13586236551@cloud.ionos.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <23c6e9b1-fe59-1536-9fcf-b4acf2805b4a@huawei.com>
Date:   Mon, 29 Jul 2019 21:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d123f888-0f3c-2ba1-5c53-c13586236551@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/7/29 19:54, Guoqing Jiang wrote:
>
>
> On 7/29/19 1:36 PM, Yufen Yu wrote:
>> I don't think this can fix the race condition completely.
>>
>> -               p->rdev = NULL;
>>                   if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>                           synchronize_rcu();
>> +                       p->rdev = NULL;
>>                           if (atomic_read(&rdev->nr_pending)) {
>>
>> If we access conf->mirrors[i].rdev (e.g. raid1_write_request()) after 
>> RCU grace period,
>> synchronize_rcu() will not wait the reader. Then, it also can cause 
>> NULL pointer dereference.
>>
>> That is the reason why we add the new flag 'WantRemove'. It can 
>> prevent the reader to access
>> the 'rdev' after RCU grace period.
>

Sorry for my wrong description. It is  ** after RCU grace start **, not 
'after RCU grace period'.


>
> How about move it to the else branch?
>
> @@ -1825,7 +1828,6 @@ static int raid1_remove_disk(struct mddev 
> *mddev, struct md_rdev *rdev)
>                         err = -EBUSY;
>                         goto abort;
>                 }
> -               p->rdev = NULL;
>                 if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>                         synchronize_rcu();
>                         if (atomic_read(&rdev->nr_pending)) {
> @@ -1833,8 +1835,10 @@ static int raid1_remove_disk(struct mddev 
> *mddev, struct md_rdev *rdev)
>                                 err = -EBUSY;
>                                 p->rdev = rdev;
>                                 goto abort;
> -                       }
> -               }
> +                       } else
> +                               p->rdev = NULL;
> +               } else
> +                       p->rdev = NULL;
>
> After rcu period, the nr_pending should be not zero in your case.
>

I also don't think this can work.

    +                              +
     |                                |
     |                                |
     |  +--->Reader         |          +--->Reader nr_pending++
     |                                |
     |                                |
     |                                |
    +                               +
start rcu period             end rcu period
call synchronize_rcu()    return synchronize_rcu()

If the reader try to read conf->mirrors[i].rdev after rcu peroid start,
synchronize_rcu() will not wait the reader. We assume the current
value of nr_pending is 0. Then, raid1_remove_disk will set 'p->rdev = NULL'.

After that the reader add 'nr_pending' to 1 and try to access 
conf->mirrors[i].rdev,
It can cause NULL pointer dereference.

Adding the new flag 'WantRemove' can prevent the reader to access
conf->mirrors[i].rdev after ** start rcu period **.

Yufen
Thank a lot

> Thanks,
> Guoqing
>
>


