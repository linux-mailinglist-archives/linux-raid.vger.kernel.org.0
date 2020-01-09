Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646ED1356EE
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2020 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgAIKcP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Jan 2020 05:32:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39699 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbgAIKcO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Jan 2020 05:32:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so2211827wmj.4
        for <linux-raid@vger.kernel.org>; Thu, 09 Jan 2020 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2oevnZBHI5xQ6qJ/UI9mNpuw9+r7+RLBJptyta/bOA4=;
        b=GdfL8AJ9KqP/pDynPtFy+k8eEd4d4h6QKIWQQFmj/Tky6uur+lGW5WaD6oijGMFivS
         ZTTqJFZ53gCxxC/AC3QQWmyRPsTsBGzqcTLEOnFF4B8B52JvWNKxYBaTOS8oDhXPblRq
         6+ztLv/B74IY0d4FFhCdIRspWzYnlIBVI4dibXijN41oiuaVweed/wLQkS7XGP3Av6xH
         0OnfCB1ShnTtjLWIal5kHQSCAHfawy4yf+9tVHQcQIiYqhufLdakCuVPXXcT9KOcMQ8d
         VyhNsoaya5HFBMo311gUr0VYPYNTNpHEHXCsuzZikZc1Dwp7jXxOlQ7C+Zz/Z/GleXGe
         FIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2oevnZBHI5xQ6qJ/UI9mNpuw9+r7+RLBJptyta/bOA4=;
        b=CzzusBozoJjtUZNxJHnzhvWWz6IucQgEOqq0YoddSn9LA969/c9hsCmnC7YHjdG69h
         L9SMJT85oeTYkxW1OSNh+3+M4URyjnrvx2FPU0IMMmgdcHsrSfukMDmlUIW1XZ+q3o4T
         P1LFm/BHKNv78jQZvsQCI/7FTv9PBQAYbUv1H3ixiCH41ZyyzCGXVp4br8MC2I6QmHJ8
         Qbxw7XZG6HI/Qt0HTFXoYO3jGtpEKDyRRUftqHcXOTi5Q8IWEQF+Syu68kvUM0x2X7mw
         ohjSAzl4VTt1gskJJVTbUWpT8rims7V3waLbRS0gHBoipl/IgkstTie+B/+/Go/UK4XS
         l17w==
X-Gm-Message-State: APjAAAV4Yd/UeC8y3LjLfCdFmPi175Kmd0pIe63aNbaMkHDxGKDxv73+
        vtCIZF/dQnIACEOdCc8a72YTy2+KLDk=
X-Google-Smtp-Source: APXvYqz0sQHTaOMIYX01RMnuYNSLsKOKQQNYrTMCLXpSnxViHqttDQXZTlRqplhiwVZwMo4sww0ohQ==
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr4224513wmd.102.1578565930782;
        Thu, 09 Jan 2020 02:32:10 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:3132:ace5:784f:a2c3? ([2001:1438:4010:2540:3132:ace5:784f:a2c3])
        by smtp.gmail.com with ESMTPSA id d16sm8273969wrg.27.2020.01.09.02.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 02:32:10 -0800 (PST)
Subject: Re: [PATCH] raid5: avoid add sh->lru to different list
To:     Xiao Ni <xni@redhat.com>, jgq516@gmail.com, liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org
References: <20200108163023.9301-1-guoqing.jiang@cloud.ionos.com>
 <92b659f5-09ad-d241-90c0-5dfcb6aeda3c@redhat.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <6b837dbe-fefd-05b3-43d3-37749c7ce0b0@cloud.ionos.com>
Date:   Thu, 9 Jan 2020 11:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <92b659f5-09ad-d241-90c0-5dfcb6aeda3c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Xiao,

On 1/9/20 8:02 AM, Xiao Ni wrote:
>
>
> On 01/09/2020 12:30 AM, jgq516@gmail.com wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> release_stripe_plug adds lru to unplug list, then raid5_unplug
>> iterates unplug list and release the stripe in the list. But
>> sh->lru could exist in another list as well since there is no
>> protection of the race since release_stripe_plug is lock free.
>>
>> For example, the same sh could be handled by raid5_release_stripe
>> which is lock free too, it does two things in case "sh->count == 1".
>>
>> 1. add sh to released_stripes.
>>
>> Or
>>
>> 2. go to slow path if sh is already set with ON_RELEASE_LIST.
>>
>> Either 1 or 2 could trigger do_release_stripe finally, and this
>> function mainly move sh->lru to different lists such as delayed_list,
>> handle_list or temp_inactive_list etc.
>
> Hi Guoqing
>
> The sh->count should be >= 1 before calling release_stripe_plug. 
> Because the stripe is got
> from raid5_get_active_stripe. In your example, if the same sh will be 
> handled by raid5_release_stripe.
> The sh->count should be >= 2, right? 

I am not sure it is true, since sh->count could be decreased in both 
raid5_release_stripe (lockless)
and __release_stripe (protected by device_lock), so there are quite a 
lot of paths can decrease the
count.

> Because it should be added 1 when someone gets the same
> sh. So the sh->count can't be zero and can't be released 
> before/in/after release_stripe_plug.

After sh->lru is added to cb->list, could it possible that other 
processes decrease sh->count and
add the same sh->lru to another list? I don't know where can prevent it 
happen.

> Could you explain about this if sh->count can be zero when calling 
> release_stripe_plug?

Because raid5_get_active_stripe is lockless, and image there are massive 
IOs against the same sh
especially when multiple r5workers are activated. I am also not sure the 
sh->count can guarantee
sh->lru lives in only one list, so there could be corner case which 
causes lockup.

>
> When it moves sh->lru to unplug list, it doesn't check sh->count and 
> get any lock. The unplug method
> is to avoid conf->device_lock. Is it enough to check sh->lru here? If 
> it's not empty, it can call raid5_release_stripe
> directly.
>>
>> Then the same node could be in different lists, which causes
> What's the meaning of "node" here? It's stripe?

I means the list node, maybe entry is more appropriate.

>> raid5_unplug sticks with "while (!list_empty(&cb->list))", and
>> since spin_lock_irq(&conf->device_lock) is called before, it
>> causes:
> You mean a dead loop? In the loop, stripe is moved from cb->list. The 
> while loop
> can finish successfully, right?

Please see link [1].

>
>>
>> 1. hard lock up in [1], [2] and [3] since irq is disabled.
>>
>> 2. raid5_get_active_stripe can't get device_lock and calltrace
>> happens.
>>
>> [<ffffffff81598060>] _raw_spin_lock+0x20/0x30
>> [<ffffffffa0230b0a>] raid5_get_active_stripe+0x1da/0x5250 [raid456]
>> [<ffffffff8112d165>] ? mempool_alloc_slab+0x15/0x20
>> [<ffffffffa0231174>] raid5_get_active_stripe+0x844/0x5250 [raid456]
>> [<ffffffff812d5574>] ? generic_make_request+0x24/0x2b0
>> [<ffffffff810938b0>] ? wait_woken+0x90/0x90
>> [<ffffffff814a2adc>] md_make_request+0xfc/0x250
>> [<ffffffff812d5867>] submit_bio+0x67/0x150
>>
>> So, this commit tries to avoid the issue by makes below change:
>>
>> 1. firstly we can't add sh->lru to cb->list if sh->count == 0.
>>
>> 2. check STRIPE_ON_UNPLUG_LIST too in do_release_stripe to avoid
>> list corruption, and the lock version of test_and_set_bit/clear_bit
>> are used (though it should not effective on x86).
>>
>> [1]. https://marc.info/?l=linux-raid&m=150348807422853&w=2
>> [2]. https://marc.info/?l=linux-raid&m=146883211430999&w=2
>> [3]. https://marc.info/?l=linux-raid&m=157434565331673&w=2
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>> As you can see, this version is different from previous one.
>>
>> The previous verison is made because I thought that ON_UNPLUG_LIST
>> and ON_RELEASE_LIST are kind of exclusive, the sh should be
>> only set with  either of the flag but not both, but perhaps
>> it is not true ...
> Yes. The stripe may be handled in other cases and it calls 
> raid5_release_stripe after the job.
> Now the stripe maybe is in conf->released_stripes and sh->count is 1.

So I changed my mind :-). If the sh is on unplug list, then it should be 
handled
by raid5_unplug instead of by other callers, it seems more natural from my
point view whether one sh could live different list simultaneously or not.

>>
>> Instead, since the goal is to avoid put the same sh->lru in
>> different list, or we can fix it from other side. Before
>> do_release_stripe move sh->lru to another list (not cb->list),
>> check if the sh is on unplug list yet, if it is true then wake
>> up mddev->thread to trigger the plug path:
>>
>>    raid5d -> blk_finish_plug -> raid5_unplug ->
>>    __release_stripe -> do_release_stripe
>>
>> Then raid5_unplug remove sh from cb->list one by one, clear
>> ON_UNPLUG_LIST flag and release stripe. So we ensure sh on
>> unplug list is actually handled by plug mechanism instead
>> of other paths.
>>
>> Comments and tests are welcomed.
>>
>> The new changes are tested with "./test --raidtype=raid456",
>> seems good.

Could you help to test the change in your nvdimm environment (would be 
better
if more scenarios are covered) to avoid regression?

>>
>> Thanks,
>> Guoqing
>>
>>   drivers/md/raid5.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 223e97ab27e6..808b0bd18c8c 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -218,6 +218,25 @@ static void do_release_stripe(struct r5conf 
>> *conf, struct stripe_head *sh,
>>       BUG_ON(!list_empty(&sh->lru));
>>       BUG_ON(atomic_read(&conf->active_stripes)==0);
>>   +    /*
>> +     * If stripe is on unplug list then original caller of 
>> __release_stripe
>> +     * is not raid5_unplug, so sh->lru is still in cb->list, don't 
>> risk to
>> +     * add lru to another list in do_release_stripe.
>> +     */
>> +    if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state))
>> +        clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
>> +    else {
>> +        /*
>> +         * The sh is on unplug list, so increase count (because count
>> +         * is decrease before enter do_release_stripe), then trigger
> is decreased before entering

Thanks for checking.

Cheers,
Guoqing
