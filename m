Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072D8A144E
	for <lists+linux-raid@lfdr.de>; Thu, 29 Aug 2019 11:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfH2JFP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Aug 2019 05:05:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39224 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfH2JFO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 29 Aug 2019 05:05:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id g8so3211589edm.6
        for <linux-raid@vger.kernel.org>; Thu, 29 Aug 2019 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JRI0nPniI38X+pKRpGzBrIIS60UyAoEfbv1DH2qoytk=;
        b=bDwlVHQ1toCguj3fWX3nQI7E8Q6eE+aKak3clsoIIl3LkkeYM7OgqHPJNsc2EjM9Dx
         T9QP68nEdFRWbBPfKODekgXFmNWgddd6n6Vain0tzWeo9MR4As27a7Bdtr5SiMWyY0cj
         HxNIV0duWSfjCwBO8wOw7J3R3942D0KWVEoZGJLWIdt9gaP/0E+2KHFlbW4QqjHGnYlD
         MgiC6bpEYGOD13ddnlcew1LbWxlFue3WiH3u97kGE9Lf5BfbfT6q0veZ2jCtepjjHMvc
         dI8KIW5SmIVg14h9E54325qY1AR0ns+9JZaAMwVyuIuRubolHvB8sT0Vqrz6+w0Exog1
         CALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JRI0nPniI38X+pKRpGzBrIIS60UyAoEfbv1DH2qoytk=;
        b=OJ6GFg+myAn39Qh2oS3wsD+e04yn68pzuWfUeWeW58/mRlgzE91IwrKqSHcIC17PzB
         5wWYNvmQEaurccT/f4zzBbSs33+Ns5y+WSJYdnKPWr1S+v94ZZl29iOIKWrkm4hJDkM/
         68kWXfQeKuw8e8U4XzZQFiP6oOGPpk+ndkLYjYPzmwA2mB4uctDzkXc1rrnRabBHZcKV
         Wyu4gWxQvJIeOFeqZNZSHPwga5FftIsq9adaBEZIZO0jNN3T23zC4mBNMXeXZSIoS7OA
         MbRy33I9jxaLF/fl4Nzoqv9y0Cw87alsx2cYEm3mknJVEyhwe/V7j44oOXojE7cBJ2wY
         o4bA==
X-Gm-Message-State: APjAAAUpOwwYFlAY9ZnZaNclG/6iCJJznhfJ7NWfCrpW3mGc37SDuZwJ
        VFQiKDjr5cnnyHIJkHnmjalyCsHyB/I=
X-Google-Smtp-Source: APXvYqyOyf6UcssweKOt4cBKstRSK9rBmosV4EfPuCDmaJxoKD0w32XjMrDNUjaksIufMUC/gnC3aQ==
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr8269407edp.208.1567069512053;
        Thu, 29 Aug 2019 02:05:12 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:cdb3:d5a4:4e7e:3d4b? ([2001:1438:4010:2540:cdb3:d5a4:4e7e:3d4b])
        by smtp.gmail.com with ESMTPSA id x42sm328938edm.77.2019.08.29.02.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 02:05:11 -0700 (PDT)
Subject: Re: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <94a850d9-be0e-5b17-a6ab-7db50f1c0961@cloud.ionos.com>
Date:   Thu, 29 Aug 2019 11:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 8/29/19 7:42 AM, Song Liu wrote:
>> drivers/md/raid5.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 88e56ee98976..e3dced8ad1b5 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -4612,8 +4612,7 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
>>
>> 		list_del_init(&sh->batch_list);
>>
>> -		WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>> -					  (1 << STRIPE_SYNCING) |
>> +		WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>> 					  (1 << STRIPE_REPLACED) |
>> 					  (1 << STRIPE_DELAYED) |
>> 					  (1 << STRIPE_BIT_DELAY) |
> I read the code again, and now I am not sure whether we are fixing the issue.
> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTIVE.
> It only runs on other stripes in the batch, which should not have STRIPE_ACTIVE.
>
> Does this make sense?

Yes, maybe some stripes are added to batch_list with STRIPE_ACTIVE is set.
could it possible caused by the path?

retry_aligned_read -> sh = raid5_get_active_stripe(conf, sector, 0, 1, 1)
                                     ...
                                     if (!add_stripe_bio(sh, raid_bio, 
dd_idx, 0, 0))
                                     ...
                                     handle_stripe(sh)

The sh is added to batch_list by add_stripe_bio -> stripe_add_to_batch_list,
then the state is set to STRIPE_ACTIVE at the beginning of handle_stripe.

Maybe introduce a flag to show that the stripe is in batch_list, and 
don't call
handle_stripe for that stripe, some rough changes like.

gjiang@ls00508:/media/gjiang/opensource-tree/md$ git diff
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e3dced8ad1b5..c04d5b55848a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -817,12 +817,14 @@ static void stripe_add_to_batch_list(struct r5conf 
*conf, struct stripe_head *sh
                  * can still add the stripe to batch list
                  */
                 list_add(&sh->batch_list, &head->batch_list);
+               set_bit(STRIPE_IN_BATCH_LIST, &sh->state);
spin_unlock(&head->batch_head->batch_lock);
         } else {
                 head->batch_head = head;
                 sh->batch_head = head->batch_head;
                 spin_lock(&head->batch_lock);
                 list_add_tail(&sh->batch_list, &head->batch_list);
+               set_bit(STRIPE_IN_BATCH_LIST, &sh->state);
                 spin_unlock(&head->batch_lock);
         }

@@ -6161,7 +6163,8 @@ static int  retry_aligned_read(struct r5conf 
*conf, struct bio *raid_bio,
                 }

                 set_bit(R5_ReadNoMerge, &sh->dev[dd_idx].flags);
-               handle_stripe(sh);
+               if (!test_bit(STRIPE_IN_BATCH_LIST, &sh->state))
+                       handle_stripe(sh);
                 raid5_release_stripe(sh);
                 handled++;
         }
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index cf991f13403e..dee7a1dee505 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -390,6 +390,7 @@ enum {
                                  * in conf->r5c_full_stripe_list)
                                  */
         STRIPE_R5C_PREFLUSH,    /* need to flush journal device */
+       STRIPE_IN_BATCH_LIST,   /* the stripe is already added to batch 
list */
  };

  #define STRIPE_EXPAND_SYNC_FLAGS \

What do you think about it? Thanks.

Regards,
Guoqing
