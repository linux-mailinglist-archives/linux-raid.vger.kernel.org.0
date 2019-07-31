Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE847BE8D
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfGaKlN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 31 Jul 2019 06:41:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38613 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfGaKlN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 31 Jul 2019 06:41:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so30447276edo.5
        for <linux-raid@vger.kernel.org>; Wed, 31 Jul 2019 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wBzaB4shsnr/5Yj4K30WiFvJEZAKDqHlevOEbzB2wso=;
        b=OIFJhrmxvdIQsuIlRZYv5j0xgu1eEucGTdfNuAN+e3h7zYZ9CmD43QrPNmosULpwiO
         lA8As/zt4PD6k/3Zp+QLSRIlpCZnwbTfBWYM8R2JSekRSie/7+8342XvhvqnenjcNvq3
         qPi5zlZ3xVaw2NM9+RKhwFwy6uE7UXcdfOKIQoN3W9haEbj03luRh0lDIzPEmrvHvm2p
         Sa5j53ayokicIzIjF2js7Rb1P8hHTpPpSf9IDP5FgeiSPh667sxnaDN19BV0qgj2uJwO
         eQy6lCKeHu7tdsFk/Y18q0KdEkw/hWFeY29Rrwi4wytjNxd+GGhNHSeSSNlPoRInwWZT
         VHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wBzaB4shsnr/5Yj4K30WiFvJEZAKDqHlevOEbzB2wso=;
        b=mmRbmaOel7x6lC/deC/3rYt8S+v9Y/My6oEj3pR1ii2WUYbervq0x7xOd3BXnjEKUP
         ecs9uhYZQDeXonvRb33Y1DyiGcPL0f+2UdyQ5ZWwlP/Sli/4i3h6gAULlJ++6yG+3uFG
         SHv3MP/OZ+B224avqsgitrjHPrdLTzxYdqKdHsddaPl5esG0SDcUd0vMbzT4qDG8yDVd
         Yq2IJCgN28YrSbfFetyS+bCucR5b1+VENU1+zQvbuFrCJh1lDmCXVNkxSSqzAJnEkA8h
         S0K74vDBYV9iPRwVHEiu8anq7XF9vIv35hOYRVrO6oxMmKvNeFuP4x4mkK+dtduirOYI
         w/uA==
X-Gm-Message-State: APjAAAXKTl0a2HVD8Rug1oBZECDR8mXzh7r1dr11oVXa+ImO88bwyzzo
        eINFJamokEaEi6Cnrn3FBPEigeolBdg=
X-Google-Smtp-Source: APXvYqzD2bN3SSrYbQFQ2dCwAWeiQeVSOim1Sh2eHVgUD/S4E3h0UZAk0mrxTejrqfLZlxyD+EyC6g==
X-Received: by 2002:a50:b66f:: with SMTP id c44mr106347538ede.171.1564569669226;
        Wed, 31 Jul 2019 03:41:09 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:4085:2488:da48:c2e0? ([2001:1438:4010:2540:4085:2488:da48:c2e0])
        by smtp.gmail.com with ESMTPSA id n17sm6030142ejk.46.2019.07.31.03.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 03:41:08 -0700 (PDT)
Subject: Re: [PATCH] md/raid1: fix a race between removing rdev and access
 conf->mirrors[i].rdev
To:     Yufen Yu <yuyufen@huawei.com>, liu.song.a23@gmail.com
Cc:     neilb@suse.com, houtao1@huawei.com, zou_wei@huawei.com,
        linux-raid@vger.kernel.org
References: <20190726060051.16630-1-yuyufen@huawei.com>
 <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
 <b98073c3-4b81-dd4a-09b1-47e277c24961@huawei.com>
 <538db63a-d316-5783-f45b-b8310d19b7b9@cloud.ionos.com>
 <d3bec7ef-4e35-8a32-8b11-cda5e99b453d@cloud.ionos.com>
 <3e6b5faf-a588-8cf0-1c49-8ffd15532a19@cloud.ionos.com>
 <913a04be-a00c-849c-a064-f2cde477dbe6@huawei.com>
 <d123f888-0f3c-2ba1-5c53-c13586236551@cloud.ionos.com>
 <23c6e9b1-fe59-1536-9fcf-b4acf2805b4a@huawei.com>
 <e04b36d7-9a12-3af2-d5fd-0dfab37a64ea@cloud.ionos.com>
 <0ce98e64-3b25-0b19-5319-c4b1a54a6847@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a96357de-5341-cd23-9b6d-616ec8502916@cloud.ionos.com>
Date:   Wed, 31 Jul 2019 12:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ce98e64-3b25-0b19-5319-c4b1a54a6847@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/30/19 10:36 AM, Yufen Yu wrote:
>
>
> On 2019/7/29 23:29, Guoqing Jiang wrote:
>>
>>
>> On 7/29/19 3:23 PM, Yufen Yu wrote:
>>>
>>>
>>> On 2019/7/29 19:54, Guoqing Jiang wrote:
>>>>
>>>>
>>>> On 7/29/19 1:36 PM, Yufen Yu wrote:
>>>>> I don't think this can fix the race condition completely.
>>>>>
>>>>> -               p->rdev = NULL;
>>>>>                   if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>>>>                           synchronize_rcu();
>>>>> +                       p->rdev = NULL;
>>>>>                           if (atomic_read(&rdev->nr_pending)) {
>>>>>
>>>>> If we access conf->mirrors[i].rdev (e.g. raid1_write_request()) 
>>>>> after RCU grace period,
>>>>> synchronize_rcu() will not wait the reader. Then, it also can 
>>>>> cause NULL pointer dereference.
>>>>>
>>>>> That is the reason why we add the new flag 'WantRemove'. It can 
>>>>> prevent the reader to access
>>>>> the 'rdev' after RCU grace period.
>>>>
>>>
>>> Sorry for my wrong description. It is  ** after RCU grace start **, 
>>> not 'after RCU grace period'.
>>>
>>>
>>>>
>>>> How about move it to the else branch?
>>>>
>>>> @@ -1825,7 +1828,6 @@ static int raid1_remove_disk(struct mddev 
>>>> *mddev, struct md_rdev *rdev)
>>>>                         err = -EBUSY;
>>>>                         goto abort;
>>>>                 }
>>>> -               p->rdev = NULL;
>>>>                 if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>>>                         synchronize_rcu();
>>>>                         if (atomic_read(&rdev->nr_pending)) {
>>>> @@ -1833,8 +1835,10 @@ static int raid1_remove_disk(struct mddev 
>>>> *mddev, struct md_rdev *rdev)
>>>>                                 err = -EBUSY;
>>>>                                 p->rdev = rdev;
>>>>                                 goto abort;
>>>> -                       }
>>>> -               }
>>>> +                       } else
>>>> +                               p->rdev = NULL;
>>>> +               } else
>>>> +                       p->rdev = NULL;
>>>>
>>>> After rcu period, the nr_pending should be not zero in your case.
>>>>
>>>
>>> I also don't think this can work.
>>>
>>>     +                              +
>>>      |                                |
>>>      |                                |
>>>      |  +--->Reader         |          +--->Reader nr_pending++
>>>      |                                |
>>>      |                                |
>>>      |                                |
>>>     +                               +
>>> start rcu period             end rcu period
>>> call synchronize_rcu()    return synchronize_rcu()
>>>
>>> If the reader try to read conf->mirrors[i].rdev after rcu peroid start,
>>> synchronize_rcu() will not wait the reader. We assume the current
>>> value of nr_pending is 0. Then, raid1_remove_disk will set 'p->rdev 
>>> = NULL'.
>>>
>>> After that the reader add 'nr_pending' to 1 and try to access 
>>> conf->mirrors[i].rdev,
>>> It can cause NULL pointer dereference.
>>>
>>> Adding the new flag 'WantRemove' can prevent the reader to access
>>> conf->mirrors[i].rdev after ** start rcu period **.
>>
>> I have to admit that I don't know RCU well, but add an additional 
>> flag to address rcu related
>> stuff is not a right way from my understanding ...
>>
>> And your original patch set p->rdev to NULL finally which is not 
>> correct I think, I also wonder
>> what will happen if "raid1_remove_disk set WantRemove and p->rdev = 
>> NULL" happens between rcu_read_lock/unlock and access 
>> conf->mirrors[i].rdev.
>>
>
> We should not forget there is 'synchronize_rcu()' between set 
> 'WantRemove'
> and 'p->rdev = NULL'. If your worried scenes is true, it means that 
> the reader
> call rcu_read_lock() before synchronize_rcu().  Then, 
> synchronize_rcu() will wait
> until the reader call rcu_read_unlock(), which is inconsistent with 
> the worried scenes.

I could misunderstood your description.  For write request, two parts in 
it need to
dereference rdev, one has the protection of rcu lock while another 
didn't have the
protection.

1. raid1_write_request
part 1.a has rcu_read_lock, rcu_dereference(rdev) and rcu_read_unlock.

part 1.b:
use rdev to dereference without the protection of rcu read lock, such as
"conf->mirrors[i].rdev->data_offset" in your description.

Now raid1_remove_disk set WantRemove flag before rdev is set to NULL, 
let's say
part 2.a includes those lines: "set_bit(WantRemove, &rdev->flags)", 
synchronize_rcu
and "p->rdev = NULL".

If 2.a is called between 1.a and 1.b, the dereference issue still 
exists, no? So my
naive thinking is to add protection to part 1.b as well.

>
>> Anyway, I hope something like this can work.
>>
>> gjiang@ls00508:/media/gjiang/opensource-tree/linux$ git diff 
>> drivers/md/raid1.c
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 34e26834ad28..62d0b3b69628 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -1471,8 +1471,15 @@ static void raid1_write_request(struct mddev 
>> *mddev, struct bio *bio,
>>
>>         first_clone = 1;
>>
>> +       rcu_read_lock();
>>         for (i = 0; i < disks; i++) {
>>                 struct bio *mbio = NULL;
>> +               struct md_rdev *rdev = 
>> rcu_dereference(conf->mirrors[i].rdev);
>> +               if (!rdev || test_bit(Faulty, &rdev->flags))
>> +                       continue;
>>                 if (!r1_bio->bios[i])
>>                         continue;
>>
>> @@ -1500,7 +1507,6 @@ static void raid1_write_request(struct mddev 
>> *mddev, struct bio *bio,
>>                         mbio = bio_clone_fast(bio, GFP_NOIO, 
>> &mddev->bio_set);
>>
>>                 if (r1_bio->behind_master_bio) {
>> -                       struct md_rdev *rdev = conf->mirrors[i].rdev;
>>
>>                         if (test_bit(WBCollisionCheck, &rdev->flags)) {
>>                                 sector_t lo = r1_bio->sector;
>> @@ -1551,6 +1557,7 @@ static void raid1_write_request(struct mddev 
>> *mddev, struct bio *bio,
>>                         md_wakeup_thread(mddev->thread);
>>                 }
>>         }
>> +       rcu_read_unlock();
>>
>
> The region may sleep to wait memory allocate. So, I don't think it is 
> reasonable
> to add rcu_read_lock/unlock().

Thanks for the investigation, that is why rcu_read_lock/unlock are not 
called here.

>
>> r1_bio_write_done(r1_bio);
>>
>> @@ -1825,16 +1832,19 @@ static int raid1_remove_disk(struct mddev 
>> *mddev, struct md_rdev *rdev)
>>                         err = -EBUSY;
>>                         goto abort;
>>                 }
>> -               p->rdev = NULL;
>>                 if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>                         synchronize_rcu();
>>                         if (atomic_read(&rdev->nr_pending)) {
>>                                 /* lost the race, try later */
>>                                 err = -EBUSY;
>> -                               p->rdev = rdev;
>> +                               rcu_assign_pointer(p->rdev, rdev);
>>                                 goto abort;
>> +                       } else {
>> +                               RCU_INIT_POINTER(p->rdev, NULL);
>> +                               synchronize_rcu();
>
> What is the purpose of adding 'synchronize_rcu()' here?

Just follow some code in kernel since I don't know RCU well as I said.

Another way comes to my mind (totally untested),  and I think this way 
is more reasonable.
BTW, I had no luck to hit the issue since the race is happened in a 
short window, so I can't
verify the change.

@@ -8769,7 +8776,8 @@ static int remove_and_add_spares(struct mddev *mddev,
         int removed = 0;
         bool remove_some = false;

-       if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+       if (this && (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+                    (test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))))
                 /* Mustn't remove devices when resync thread */
                 return 0;


Thanks,
Guoqing
