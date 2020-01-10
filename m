Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB1136B68
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgAJKva (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jan 2020 05:51:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44861 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgAJKv3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 Jan 2020 05:51:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so1117529edb.11
        for <linux-raid@vger.kernel.org>; Fri, 10 Jan 2020 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DsFZ4jBKISWGfY4eSjLL9nmRtRQim2BgRgpe2bzZk5w=;
        b=cYqt0yFP1VVOBX9a/JG9uPL++JMzp2ThJsvGa1YBpTU49A5hoTmodUewFlnC+xRUdG
         gelVAJTxI/F2BBJG0/VQcsE4996R5bs4didFYE+6/FPIi6+ffXuErOPUff9QtqnAdwHW
         JBh7gk4JuY8Qo5AGLJZncixPzq8GQT3vyJg656jX0liBkyTZz+5zaaGAhEnBDf4RoqCs
         GbCBYS+Hy4rrTstHrPgIeSMaCzwJ/oeYV75XLG6+SxzknnrOzygZbXd8bwPEESZmLJVA
         MR4shktIdVUWIJfYpB570m2+8AHQBfryMHKZXlErmLiNcMqzqzU664zGaapm+AOZtK+a
         zpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DsFZ4jBKISWGfY4eSjLL9nmRtRQim2BgRgpe2bzZk5w=;
        b=szkyVNWRSF4wiIFyTycgzpbhsUzoi6Xg3yycM3M/GInRfnjZHzdeewnYSr9gZ7Du+f
         DTAxxtH6xOs0JHFcculwABghjKmR2+LaZ+ZBDAW58qqMkhblQkolqOBC3d5xte/vgswr
         g2+1zN3USHIGZKMs3cM2WdZcSpOhV+wMVKwWu0FRePpl/eT2vul4tmD/YEHew+it+9g0
         wFLzFxDU9906eKZysonk9zhozDyg1+PrW8fNFk086U79PyvnpwdSwG3SSuEIXrKt1upX
         l29OwYNymB3rt1DSQNvcnbKCaS/XxVyePcx/FSPzoM6eYJbCkC8qKZKba2EIH+ERB72x
         5VAg==
X-Gm-Message-State: APjAAAWK2CIn8CgjbuTUNLquYynIFP0kMKKe8oLsdQtFAIkLtFnnsXKR
        3RMzB7F/9vtOveLBzKttITov/zEixds=
X-Google-Smtp-Source: APXvYqyOzeDqMIclLf5K27dY7nRS6MDWHmRsixu0CYL/zycgJNchCc8baNK5Bvmkn1JNomhu6bg02A==
X-Received: by 2002:a17:906:52d7:: with SMTP id w23mr2532882ejn.74.1578653486566;
        Fri, 10 Jan 2020 02:51:26 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:3044:9fa7:85f1:9686? ([2001:1438:4010:2540:3044:9fa7:85f1:9686])
        by smtp.gmail.com with ESMTPSA id e24sm27379edy.93.2020.01.10.02.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 02:51:26 -0800 (PST)
Subject: Re: [PATCH] raid5: avoid add sh->lru to different list
To:     Song Liu <liu.song.a23@gmail.com>,
        Guoqing Jiang <jgq516@gmail.com>, Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200108163023.9301-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW598WjeigzHPkAEO8YoHwBis8xO79UL8jfRfLUckkGCog@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <458d44b3-4908-367c-7fb6-8cf87043d93f@cloud.ionos.com>
Date:   Fri, 10 Jan 2020 11:51:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW598WjeigzHPkAEO8YoHwBis8xO79UL8jfRfLUckkGCog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,

On 1/10/20 2:06 AM, Song Liu wrote:
> Hi Guoqing and Xiao,
>
> Thanks for looking into this. I am still looking into this. Some
> questions below...

Thanks for looking into it.

> On Wed, Jan 8, 2020 at 8:30 AM <jgq516@gmail.com> wrote:
> [...]
>>   drivers/md/raid5.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 223e97ab27e6..808b0bd18c8c 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -218,6 +218,25 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
>>          BUG_ON(!list_empty(&sh->lru));
>>          BUG_ON(atomic_read(&conf->active_stripes)==0);
>>
>> +       /*
>> +        * If stripe is on unplug list then original caller of __release_stripe
>> +        * is not raid5_unplug, so sh->lru is still in cb->list, don't risk to
>> +        * add lru to another list in do_release_stripe.
>> +        */
> Can we do the check before calling into do_release_stripe()?

Then we need to add the check twice, one in raid5_release_stripe, 
another in
__release_stripe.

>
>> +       if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state))
>> +               clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
>> +       else {
>> +               /*
>> +                * The sh is on unplug list, so increase count (because count
>> +                * is decrease before enter do_release_stripe), then trigger
>> +                * raid5d -> plug -> raid5_unplug -> __release_stripe to handle
>> +                * this stripe.
>> +                */
>> +               atomic_inc(&sh->count);
>> +               md_wakeup_thread(conf->mddev->thread);
>> +               return;
>> +       }
>> +
>>          if (r5c_is_writeback(conf->log))
>>                  for (i = sh->disks; i--; )
>>                          if (test_bit(R5_InJournal, &sh->dev[i].flags))
>> @@ -5441,7 +5460,7 @@ static void raid5_unplug(struct blk_plug_cb *blk_cb, bool from_schedule)
>>                           * is still in our list
>>                           */
>>                          smp_mb__before_atomic();
>> -                       clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
>> +                       clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
>>                          /*
>>                           * STRIPE_ON_RELEASE_LIST could be set here. In that
>>                           * case, the count is always > 1 here
>> @@ -5481,7 +5500,8 @@ static void release_stripe_plug(struct mddev *mddev,
>>                          INIT_LIST_HEAD(cb->temp_inactive_list + i);
>>          }
>>
>> -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
>> +       if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state) &&
>> +           (atomic_read(&sh->count) != 0))
> Do we really see sh->count == 0 here? If yes, I guess we should check
> sh->count first,
> so that we reduce the case where STRIPE_ON_UNPLUG_LIST is set, but the sh is
> not really on the unplug_list.

Yes, it could be, thanks. But with check count first, I am worried a 
potential
race window which causes sh->lru could be added to different lists as well.

1. release_stripe_plug -> atomic_read(&sh->count) != 0

2. do_release_stripe -> atomic_dec_and_test(&sh->count)
!test_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)
                                      list_add_tail(&sh->lru, ***_list);

3. release_stripe_plug -> !test_and_set_bit(STRIPE_ON_UNPLUG_LIST, 
&sh->state)
list_add_tail(&sh->lru, &cb->list);


IMO, the difficult thing is we need kind of atomic operation to check both
sh->count and ON_UNPLUG flag, but we do want lockless as much as possible.

How about get an extra count before add add sh to cb->list? I am 
thinking that
atomic_inc(&sh->count) and atomic_dec(&sh->count) should be paired, right?
Then do_release_stripe should not be triggered in theory. Something like.

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d4d3b67ffbba..225bd9ca4e42 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -222,6 +222,24 @@ static void do_release_stripe(struct r5conf *conf, 
struct stripe_head *sh,
                 for (i = sh->disks; i--; )
                         if (test_bit(R5_InJournal, &sh->dev[i].flags))
                                 injournal++;
+
+       /*
+        * If stripe is on unplug list then original caller of 
__release_stripe
+        * is not raid5_unplug, so sh->lru is still in cb->list, don't 
risk to
+        * add lru to another list in do_release_stripe.
+        */
+       if (unlikely(test_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))){
+               /*
+                * The sh is on unplug list, so increase count (because 
count
+                * is decreased before entering do_release_stripe), then 
trigger
+                * raid5d -> plug -> raid5_unplug -> __release_stripe to 
handle
+                * this stripe.
+                */
+               atomic_inc(&sh->count);
+               md_wakeup_thread(conf->mddev->thread);
+               return;
+       }
+
         /*
          * In the following cases, the stripe cannot be released to cached
          * lists. Therefore, we make the stripe write out and set
@@ -5481,10 +5499,15 @@ static void release_stripe_plug(struct mddev 
*mddev,
                         INIT_LIST_HEAD(cb->temp_inactive_list + i);
         }

-       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
+       /* hold extra count to avoid the running of do_release_stripe */
+       atomic_inc(&sh->count);
+       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
                 list_add_tail(&sh->lru, &cb->list);
-       else
+               atomic_dec(&sh->count);
+       } else {
+               atomic_dec(&sh->count);
                 raid5_release_stripe(sh);
+       }
  }

>>                  list_add_tail(&sh->lru, &cb->list);
>>          else
>>                  raid5_release_stripe(sh);
>>
> Overall, I think we should try our best to let STRIPE_ON_RELEASE_LIST
> means it is
> on release_list, and STRIPE_ON_UNPLUG_LIST means it is on unplug_list. I think
> there will be some exceptions, but we should try to minimize those cases.
>
> Does this make sense?

Agreed, though I don't see there is code to do it unfortunately ...

Thanks,
Guoqing
