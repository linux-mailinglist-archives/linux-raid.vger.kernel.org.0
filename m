Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFFAB58A
	for <lists+linux-raid@lfdr.de>; Fri,  6 Sep 2019 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfIFKN7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Sep 2019 06:13:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40985 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388636AbfIFKN7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 6 Sep 2019 06:13:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id z9so5790017edq.8
        for <linux-raid@vger.kernel.org>; Fri, 06 Sep 2019 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SxQ3aj4zdxxTebd9lwvHttMXxYhCjEO0ST2X5D4q0cw=;
        b=J7BRY1iLuHwb9tfealm/J3JGotF5cpUHwqa8U8M+ik9E1n5iV70qQu7tlTgHzUybJw
         k6wFyYKIkI9ddsM9pn9zc4nEHHs6qXhSwEiOzx4dxCmtl5eLd5s3GijwAVbXPG5n0Shg
         JPZ9SNrtv0L8qUgnDLg340rQsJqH6p677/NXoC9utZDJ2Opzmj1AYRDQfV3ZLJUtROkH
         fmG8eeDr+nejn2K7oUhB8cngwQViuHMBF4x2O/EpAMRjIFq3AboTlj5ZLCtb9e7uQn/L
         JVETcr3SVgTDCbEOQND0HSCAh2bX4vyjjA9kvF+wSREb6r/X9W40bYP8dja9Pu8+Au/d
         IpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SxQ3aj4zdxxTebd9lwvHttMXxYhCjEO0ST2X5D4q0cw=;
        b=GZQRNl407CDr/FhjZlrZLi00qVA5+r7+h0s8I7wyfFTEnH8AmVTEaSKEpUqZODmxAF
         fTSvlRnCyyPKARSvdw16hKk0mGonT3z6oMfb9T6YmD2yzEhi7FoocXuNlEhc/R2TmYlM
         v/sozb0dIs+QvU2wHNmtUOc/LLvoK2CBYFjH0bxRy/7Oi3trvXb3l4KCf5hP/5BC+wMP
         SZrP4ZOFEz8IUDZ7AwLCXpx64DBXC6fd4cMbWDtHuAQP4iEhb8SsygxPekFi6ER1zlAX
         LKeaXK7AFKX6fXY49FTLbFZt9LNeH1HHK7Ie4zPNMZ2RaWq0mx6zGlgGtj+6W386riNU
         dVCg==
X-Gm-Message-State: APjAAAUT9HaSHfTPu4antLi3Mn0p2GxUowGagU9ldLvb+kc4Vh2okHSj
        WYJN/Sg7X0/BSHkscZSgzVCXmvVMTCA=
X-Google-Smtp-Source: APXvYqylb144DxdtpY6QnSJo6rV+ILiG0Qixy1yilvjmoVYg6bPhNd5oRBsM2OvzWE11fKb1gPikug==
X-Received: by 2002:a05:6402:332:: with SMTP id q18mr8771629edw.149.1567764837121;
        Fri, 06 Sep 2019 03:13:57 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:580e:f01e:2458:6dd4? ([2001:1438:4010:2540:580e:f01e:2458:6dd4])
        by smtp.gmail.com with ESMTPSA id c8sm510441ejk.22.2019.09.06.03.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 03:13:56 -0700 (PDT)
Subject: Re: [PATCH] raid5: don't warn with STRIPE_ACTIVE flag in
 break_stripe_batch_list
To:     Song Liu <songliubraving@fb.com>
Cc:     NeilBrown <neilb@suse.com>, linux-raid <linux-raid@vger.kernel.org>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
 <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
 <59821fd6-4dff-9871-7a48-dc9e877449f8@cloud.ionos.com>
 <a528b164-6f9a-3de1-df5e-105aaa71b4d4@cloud.ionos.com>
 <C3CDEAFF-4897-4AC9-9E37-FED5AC9DF738@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <79bd85f3-d88f-b0d9-deda-7b5e2958de7b@cloud.ionos.com>
Date:   Fri, 6 Sep 2019 12:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <C3CDEAFF-4897-4AC9-9E37-FED5AC9DF738@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 9/5/19 7:15 PM, Song Liu wrote:
>
>> On Sep 5, 2019, at 9:09 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>
>> Replace STRIPE_SYNCING with STRIPE_ACTIVE in the subject ...
>>
>> On 8/30/19 4:07 PM, Guoqing Jiang wrote:
>>>
>>> On 8/30/19 1:26 AM, Song Liu wrote:
>>>>> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>>>>
>>>>> Hi Song,
>>>>>
>>>>> On 8/29/19 7:42 AM, Song Liu wrote:
>>>>>> I read the code again, and now I am not sure whether we are fixing the issue.
>>>>>> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTIVE.
>>>>>> It only runs on other stripes in the batch, which should not have STRIPE_ACTIVE.
>>>>>   From the original commit which introduced batch write, it has the description
>>>>> which I think is align with your above sentence.
>>>>>
>>>>> "With below patch, we will automatically batch adjacent full stripe write
>>>>> together. Such stripes will be added to the batch list. Only the first stripe
>>>>> of the list will be put to handle_list and so run handle_stripe().".
>>>>>
>>>>> Could you point me related code which achieve the above purpose? Thanks.
>>>> Do you mean which code makes sure the batched stripe will not be handled?
>>>> This is done via properly maintain STRIPE_HANDLE bit.
>> The raid5_make_request always set STRIPE_HANDLE for stripe which is returned from
>> raid5_get_active_stripe, so seems the batched stripe could also set with STRIPE_HANDLE
>> too, am I miss something?
>>
>> I checked the STRIPE_IO_STARTED flag, it is set in the path: handle_stripe -> ops_run_io.
>> Since both STRIPE_IO_STARTED and STRIPE_ACTIVE are valid, which means the stripe
>> should be handling in the middle of handle_stripe.
>>
>> Maybe the scenario is that raid5_make_request get a lone stripe, then it is added to handle_list
>> since STRIPE_HANDLE is valid, then handle_stripe sets STRIPE_ACTIVE flag to the stripe.
>>
>> Meantime, another full write writes to the same stripe, and added stripe to batch_list by:
>>       raid5_make_request -> add_stripe_bio -> stripe_add_to_batch_list.
>>
>> Then the warning is triggered when err happens in the batch head stripe. There are two
>> ways to address the warning I think.
>>
>> 1. remove the checking of STRIPE_ACTIVE flag since it is possible that a batched stripe
>> could have the flag.
>> 2. if STRIPE_ACTIVE flag is valid, then don't add stripe to batch list.
> I think we should not set STRIPE_HANDLE if the stripe is added to a batch, so something
> like:
>
> diff --git i/drivers/md/raid5.c w/drivers/md/raid5.c
> index 3de4e13bde98..af19f08627ce 100644
> --- i/drivers/md/raid5.c
> +++ w/drivers/md/raid5.c
> @@ -3308,8 +3308,11 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
>          }
>          spin_unlock_irq(&sh->stripe_lock);
>
> -       if (stripe_can_batch(sh))
> +       if (stripe_can_batch(sh)) {
>                  stripe_add_to_batch_list(conf, sh);
> +               if (sh->batch_head)
> +                       return 0;
> +       }
>          return 1;
>
>    overlap:
>
>
> I haven't tested this yet. It could be totally wrong.

The return value of add_stripe_bio should mean the bio is added to 
stripe or not.
With the change, '0' could also means stripe is added to batch list, 
which is really
confusing. Or we can check batch_head before STRIPE_HANDLE.

@@ -5718,7 +5727,8 @@ static bool raid5_make_request(struct mddev 
*mddev, struct bio * bi)
                                 do_flush = false;
                         }

-                       set_bit(STRIPE_HANDLE, &sh->state);
+                       if (!sh->batch_head)
+                               set_bit(STRIPE_HANDLE, &sh->state);


>> Also, there is short window between set STRIPE_ACTIVE and clear the flag in handle_stripe,
>> does it make sense to make rough change like this?
>>
>>   static void handle_stripe(struct stripe_head *sh)
>>   {
>>          struct stripe_head_state s;
>> @@ -4675,7 +4682,7 @@ static void handle_stripe(struct stripe_head *sh)
>>          struct r5dev *pdev, *qdev;
>>
>>          clear_bit(STRIPE_HANDLE, &sh->state);
>> -       if (test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)) {
>> +       if (test_bit(STRIPE_ACTIVE, &sh->state)) {
>>                  /* already being handled, ensure it gets handled
>>                   * again when current action finishes */
>>                  set_bit(STRIPE_HANDLE, &sh->state);
>> @@ -4683,9 +4690,9 @@ static void handle_stripe(struct stripe_head *sh)
>>          }
>>
>>          if (clear_batch_ready(sh) ) {
>> -               clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
>>                  return;
>>          }
>> +       set_bit(STRIPE_ACTIVE, &sh->state);
> I don't think we can do this. We need atomic test_and_set for the stripe.

Hmm, it guarantees only one process can handle the stripe, others have 
to return
earlier. And the side effect in current code is that stripe could set 
with ACTIVE flag
shortly even it is in batch list.

Thanks,
Guoqing
