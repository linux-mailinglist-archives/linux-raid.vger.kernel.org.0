Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A6ADC42
	for <lists+linux-raid@lfdr.de>; Mon,  9 Sep 2019 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfIIPkw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Sep 2019 11:40:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44602 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfIIPkw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Sep 2019 11:40:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id p2so12201606edx.11
        for <linux-raid@vger.kernel.org>; Mon, 09 Sep 2019 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AuWXkM97fWX4EYsvSTPWabBfZzQKaTCzjcWV2B/w+OQ=;
        b=BU5czKRYkR2PX+0ZxQQlA4FFL87ZeVmRFaVHct7Fwt/fyZ7hnWKRTDXmzozxpCmjsa
         +a+yCHK/KShEZkGjKCXxOeXzCkCQnGnP1BOimZORFjLD/lRsVUjq1CwT0flRVaG4kLVS
         NgkMQTzpL3FvyZ5lvkUJxOXjnOCAv3lXIsfKak83RnV+rZdl3XDH+JWCSClU2qJfEAb/
         fNDJRhlr/qxWMzN8Ohb/bcSu2INJBEp/BERLV/TVfsNO0SL+3rQl2aWO+VUMaEVFzYji
         Oz70SO3loZAneniYzmDR1asEqPyz/sh9mKwgbS0eAtXYPsNYrTA0iFeU6sqh779K8Byq
         Y5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AuWXkM97fWX4EYsvSTPWabBfZzQKaTCzjcWV2B/w+OQ=;
        b=joPkXdexosX77xL7HhrsOHTpyE1Yu9AJEjhejgbifzRlJtaQjwsHhQKYMw4femYpua
         Wv4QBbrGJbxcA+/AsmRRjDB/0V5+MTuNqPOQgUhpgtTfftOBo0lLLDneFu2Te1atPXnd
         2VSFqPPv3AkQcqBhZIS2IvsCinq67TlbMz9p713BW1pFAJXL6V6yoDoUhUtSyaMohnJi
         Tb75riV7LPMKhg5zW7lEYwp7+J9CcJUxIbw/5VEe9M90M0A2DhOjt8fWuqpG0xwNRseS
         eH9OxEIaG/5smMPBAM9T+NfG1SL1lfqA5p72ZokYQ37CDDELQLuWYFV2tQLZqMdonTLA
         BArw==
X-Gm-Message-State: APjAAAX6ho/jIllK8XRAFsyZmsIsGzX2lqSBAgCVtG4+nl96Bm6AkiFQ
        zhBZfb6E+HydoH6sKAnyqd/jaUZFEkY=
X-Google-Smtp-Source: APXvYqzGPqq0TDDibhl5LALZqhGzOiCvz7/bQmOe3ivEaZHbmw3Me3KYPz46Tm+7lDCO4TdWApWYxw==
X-Received: by 2002:a17:906:c08:: with SMTP id s8mr20207049ejf.66.1568043648986;
        Mon, 09 Sep 2019 08:40:48 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:d8:76cc:10d1:1b4d? ([2001:1438:4010:2540:d8:76cc:10d1:1b4d])
        by smtp.gmail.com with ESMTPSA id w16sm413085edd.93.2019.09.09.08.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 08:40:48 -0700 (PDT)
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
 <79bd85f3-d88f-b0d9-deda-7b5e2958de7b@cloud.ionos.com>
 <BC73D2C7-782A-40D7-9B85-0D7AA6E40A5F@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <36041ea7-cbea-83b5-53ee-411f0e57063c@cloud.ionos.com>
Date:   Mon, 9 Sep 2019 17:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BC73D2C7-782A-40D7-9B85-0D7AA6E40A5F@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,

On 9/9/19 5:10 PM, Song Liu wrote:
> 
> 
>> On Sep 6, 2019, at 11:13 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>
>>
>>
>> On 9/5/19 7:15 PM, Song Liu wrote:
>>>
>>>> On Sep 5, 2019, at 9:09 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>>>
>>>> Replace STRIPE_SYNCING with STRIPE_ACTIVE in the subject ...
>>>>
>>>> On 8/30/19 4:07 PM, Guoqing Jiang wrote:
>>>>>
>>>>> On 8/30/19 1:26 AM, Song Liu wrote:
>>>>>>> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>>>>>>
>>>>>>> Hi Song,
>>>>>>>
>>>>>>> On 8/29/19 7:42 AM, Song Liu wrote:
>>>>>>>> I read the code again, and now I am not sure whether we are fixing the issue.
>>>>>>>> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTIVE.
>>>>>>>> It only runs on other stripes in the batch, which should not have STRIPE_ACTIVE.
>>>>>>>   From the original commit which introduced batch write, it has the description
>>>>>>> which I think is align with your above sentence.
>>>>>>>
>>>>>>> "With below patch, we will automatically batch adjacent full stripe write
>>>>>>> together. Such stripes will be added to the batch list. Only the first stripe
>>>>>>> of the list will be put to handle_list and so run handle_stripe().".
>>>>>>>
>>>>>>> Could you point me related code which achieve the above purpose? Thanks.
>>>>>> Do you mean which code makes sure the batched stripe will not be handled?
>>>>>> This is done via properly maintain STRIPE_HANDLE bit.
>>>> The raid5_make_request always set STRIPE_HANDLE for stripe which is returned from
>>>> raid5_get_active_stripe, so seems the batched stripe could also set with STRIPE_HANDLE
>>>> too, am I miss something?
>>>>
>>>> I checked the STRIPE_IO_STARTED flag, it is set in the path: handle_stripe -> ops_run_io.
>>>> Since both STRIPE_IO_STARTED and STRIPE_ACTIVE are valid, which means the stripe
>>>> should be handling in the middle of handle_stripe.
>>>>
>>>> Maybe the scenario is that raid5_make_request get a lone stripe, then it is added to handle_list
>>>> since STRIPE_HANDLE is valid, then handle_stripe sets STRIPE_ACTIVE flag to the stripe.
>>>>
>>>> Meantime, another full write writes to the same stripe, and added stripe to batch_list by:
>>>>       raid5_make_request -> add_stripe_bio -> stripe_add_to_batch_list.
>>>>
>>>> Then the warning is triggered when err happens in the batch head stripe. There are two
>>>> ways to address the warning I think.
>>>>
>>>> 1. remove the checking of STRIPE_ACTIVE flag since it is possible that a batched stripe
>>>> could have the flag.
>>>> 2. if STRIPE_ACTIVE flag is valid, then don't add stripe to batch list.
>>> I think we should not set STRIPE_HANDLE if the stripe is added to a batch, so something
>>> like:
>>>
>>> diff --git i/drivers/md/raid5.c w/drivers/md/raid5.c
>>> index 3de4e13bde98..af19f08627ce 100644
>>> --- i/drivers/md/raid5.c
>>> +++ w/drivers/md/raid5.c
>>> @@ -3308,8 +3308,11 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
>>>          }
>>>          spin_unlock_irq(&sh->stripe_lock);
>>>
>>> -       if (stripe_can_batch(sh))
>>> +       if (stripe_can_batch(sh)) {
>>>                  stripe_add_to_batch_list(conf, sh);
>>> +               if (sh->batch_head)
>>> +                       return 0;
>>> +       }
>>>          return 1;
>>>
>>>    overlap:
>>>
>>>
>>> I haven't tested this yet. It could be totally wrong.
>>
>> The return value of add_stripe_bio should mean the bio is added to stripe or not.
>> With the change, '0' could also means stripe is added to batch list, which is really
>> confusing. Or we can check batch_head before STRIPE_HANDLE.
>>
>> @@ -5718,7 +5727,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>>                                  do_flush = false;
>>                          }
>>
>> -                       set_bit(STRIPE_HANDLE, &sh->state);
>> +                       if (!sh->batch_head)
>> +                               set_bit(STRIPE_HANDLE, &sh->state);
> 
> I think this works.

Thanks.

> 
>>
>>
>>>> Also, there is short window between set STRIPE_ACTIVE and clear the flag in handle_stripe,
>>>> does it make sense to make rough change like this?
>>>>
>>>>   static void handle_stripe(struct stripe_head *sh)
>>>>   {
>>>>          struct stripe_head_state s;
>>>> @@ -4675,7 +4682,7 @@ static void handle_stripe(struct stripe_head *sh)
>>>>          struct r5dev *pdev, *qdev;
>>>>
>>>>          clear_bit(STRIPE_HANDLE, &sh->state);
>>>> -       if (test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)) {
>>>> +       if (test_bit(STRIPE_ACTIVE, &sh->state)) {
>>>>                  /* already being handled, ensure it gets handled
>>>>                   * again when current action finishes */
>>>>                  set_bit(STRIPE_HANDLE, &sh->state);
>>>> @@ -4683,9 +4690,9 @@ static void handle_stripe(struct stripe_head *sh)
>>>>          }
>>>>
>>>>          if (clear_batch_ready(sh) ) {
>>>> -               clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
>>>>                  return;
>>>>          }
>>>> +       set_bit(STRIPE_ACTIVE, &sh->state);
>>> I don't think we can do this. We need atomic test_and_set for the stripe.
>>
>> Hmm, it guarantees only one process can handle the stripe, others have to return
>> earlier. And the side effect in current code is that stripe could set with ACTIVE flag
>> shortly even it is in batch list.
> 
> I guess this is not a problem with the change above?
> 

Yes, I agree.

I am not sure if the warning is caused with the scenario which I described before.

 >>> Maybe the scenario is that raid5_make_request get a lone stripe, then it is added to handle_list
 >>> since STRIPE_HANDLE is valid, then handle_stripe sets STRIPE_ACTIVE flag to the stripe.
 >>>
 >>> Meantime, another full write writes to the same stripe, and added stripe to batch_list by:
 >>> raid5_make_request -> add_stripe_bio -> stripe_add_to_batch_list.
 >>>
 >>> Then the warning is triggered when err happens in the batch head stripe.

Anyway, I will prepare a patch for above change, and let's see if the warning could
happen or not in future.

BRs,
Guoqing
