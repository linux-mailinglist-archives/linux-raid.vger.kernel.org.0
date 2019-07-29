Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8178F3E
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbfG2P3s (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 11:29:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35802 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbfG2P3r (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 11:29:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id w20so59678748edd.2
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JP52Ot+I50ryYg6z3QM/9+dnKQ3j2DZReE3TJLre4Ac=;
        b=gN/aU7We+QSctKrgYRrGaGZh4AIY1YSraM08lO57Z5op08DhpP1YHg9YeeU+IWX53d
         V8wSCySf5/5TOPsI0Zg6TKBe4s/UeL4CPR9+i7FOrLR/G5QrGHGSQ56Z0TapVCEAYlPe
         zR3Q3/AN22p4Zdgn8l5sV+0lxvB6qhiuX7fnRZoe/4DrJNJqSj3jE5i8X2BfnuVYO3NG
         Q66Bn4cFqxORAYiYKUL9/f8A3ft8TIv6uGA8mWUwDd4I2lBkVEJ45t1uhg6oRuKGFVql
         fGuBVTZl+6+G7B4tslgKnkZT1RWFh4c2cJoMtVDQ1vY0a4uPL+8OEKdyg3TrkK0vfa6D
         n2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JP52Ot+I50ryYg6z3QM/9+dnKQ3j2DZReE3TJLre4Ac=;
        b=JrWUGocYiirE+SR2nSFEBhdY3n6bVdmPsLP2X8c13PoA8jeRVxUAg7Yp0Sdzki6tO0
         lsldwSM4v8LXpiCYCg0huCklIRqO1Qzmb0ifOGU4zPQPrawsn5vp3xoLBBd3EuEktvNB
         JhfOXVkVyR7soiYWtSOIyLe30QZal6P6UFhpv1XBI5xnePLCRK8ncTX6069V5hGAiKpM
         hGjqCu7VU7TKalyG9j4kv/DZZIrdNvnytK433ZBTFcVrhv1ty9ysFLwTT4kSE+1348mJ
         +QUUNM/pI44rb5Y60AYy9bMOS8xVs9EQlCktslQq5XyJwbClpKdbLJEJtsrCfoBvSoP2
         I+UA==
X-Gm-Message-State: APjAAAVQHlj7GJ8dXWR0jsvXKzhtWT6kP0NriOzJh5s79U1s43d2k9NR
        yExIoJsFNFvZZwaUOIcV95s4rWEoSVc=
X-Google-Smtp-Source: APXvYqxGMZUvVV2ZQBy3JUBzTj/xLPkRCv1jzQ3VZWb29Mjfu+eyPyMJOcyzfjdgcf4PIQQMVIzGTw==
X-Received: by 2002:a17:906:c3c5:: with SMTP id cj5mr83359977ejb.272.1564414184850;
        Mon, 29 Jul 2019 08:29:44 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:81b7:a77a:1eec:ec34? ([2001:1438:4010:2540:81b7:a77a:1eec:ec34])
        by smtp.gmail.com with ESMTPSA id x55sm16032897edm.11.2019.07.29.08.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:29:44 -0700 (PDT)
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
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e04b36d7-9a12-3af2-d5fd-0dfab37a64ea@cloud.ionos.com>
Date:   Mon, 29 Jul 2019 17:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <23c6e9b1-fe59-1536-9fcf-b4acf2805b4a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/29/19 3:23 PM, Yufen Yu wrote:
> 
> 
> On 2019/7/29 19:54, Guoqing Jiang wrote:
>>
>>
>> On 7/29/19 1:36 PM, Yufen Yu wrote:
>>> I don't think this can fix the race condition completely.
>>>
>>> -               p->rdev = NULL;
>>>                   if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>>                           synchronize_rcu();
>>> +                       p->rdev = NULL;
>>>                           if (atomic_read(&rdev->nr_pending)) {
>>>
>>> If we access conf->mirrors[i].rdev (e.g. raid1_write_request()) after RCU grace period,
>>> synchronize_rcu() will not wait the reader. Then, it also can cause NULL pointer dereference.
>>>
>>> That is the reason why we add the new flag 'WantRemove'. It can prevent the reader to access
>>> the 'rdev' after RCU grace period.
>>
> 
> Sorry for my wrong description. It is  ** after RCU grace start **, not 'after RCU grace period'.
> 
> 
>>
>> How about move it to the else branch?
>>
>> @@ -1825,7 +1828,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                         err = -EBUSY;
>>                         goto abort;
>>                 }
>> -               p->rdev = NULL;
>>                 if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>                         synchronize_rcu();
>>                         if (atomic_read(&rdev->nr_pending)) {
>> @@ -1833,8 +1835,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                                 err = -EBUSY;
>>                                 p->rdev = rdev;
>>                                 goto abort;
>> -                       }
>> -               }
>> +                       } else
>> +                               p->rdev = NULL;
>> +               } else
>> +                       p->rdev = NULL;
>>
>> After rcu period, the nr_pending should be not zero in your case.
>>
> 
> I also don't think this can work.
> 
>     +                              +
>      |                                |
>      |                                |
>      |  +--->Reader         |          +--->Reader nr_pending++
>      |                                |
>      |                                |
>      |                                |
>     +                               +
> start rcu period             end rcu period
> call synchronize_rcu()    return synchronize_rcu()
> 
> If the reader try to read conf->mirrors[i].rdev after rcu peroid start,
> synchronize_rcu() will not wait the reader. We assume the current
> value of nr_pending is 0. Then, raid1_remove_disk will set 'p->rdev = NULL'.
> 
> After that the reader add 'nr_pending' to 1 and try to access conf->mirrors[i].rdev,
> It can cause NULL pointer dereference.
> 
> Adding the new flag 'WantRemove' can prevent the reader to access
> conf->mirrors[i].rdev after ** start rcu period **.

I have to admit that I don't know RCU well, but add an additional flag to address rcu related
stuff is not a right way from my understanding ...

And your original patch set p->rdev to NULL finally which is not correct I think, I also wonder
what will happen if "raid1_remove_disk set WantRemove and p->rdev = NULL" happens between 
rcu_read_lock/unlock and access conf->mirrors[i].rdev.

Anyway, I hope something like this can work.

gjiang@ls00508:/media/gjiang/opensource-tree/linux$ git diff drivers/md/raid1.c
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 34e26834ad28..62d0b3b69628 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1471,8 +1471,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,

         first_clone = 1;

+       rcu_read_lock();
         for (i = 0; i < disks; i++) {
                 struct bio *mbio = NULL;
+               struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+               if (!rdev || test_bit(Faulty, &rdev->flags))
+                       continue;
                 if (!r1_bio->bios[i])
                         continue;

@@ -1500,7 +1507,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
                         mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);

                 if (r1_bio->behind_master_bio) {
-                       struct md_rdev *rdev = conf->mirrors[i].rdev;

                         if (test_bit(WBCollisionCheck, &rdev->flags)) {
                                 sector_t lo = r1_bio->sector;
@@ -1551,6 +1557,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
                         md_wakeup_thread(mddev->thread);
                 }
         }
+       rcu_read_unlock();

         r1_bio_write_done(r1_bio);

@@ -1825,16 +1832,19 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
                         err = -EBUSY;
                         goto abort;
                 }
-               p->rdev = NULL;
                 if (!test_bit(RemoveSynchronized, &rdev->flags)) {
                         synchronize_rcu();
                         if (atomic_read(&rdev->nr_pending)) {
                                 /* lost the race, try later */
                                 err = -EBUSY;
-                               p->rdev = rdev;
+                               rcu_assign_pointer(p->rdev, rdev);
                                 goto abort;
+                       } else {
+                               RCU_INIT_POINTER(p->rdev, NULL);
+                               synchronize_rcu();
                         }
-               }
+               } else
+                       RCU_INIT_POINTER(p->rdev, NULL);
                 if (conf->mirrors[conf->raid_disks + number].rdev) {
                         /* We just removed a device that is being replaced.
                          * Move down the replacement.  We drain all IO before

Thanks,
Guoqing
