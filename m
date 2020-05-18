Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE941D8A14
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERVhh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 17:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVhg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 17:37:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDFC061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 14:37:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so13577283wrt.1
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7ZrgbHAepEtXRim907cXR03K6j7vkm1mYBCdFxH0k54=;
        b=GqXMSEuh4K4LgOscLgmFOllYgF7lT2e2Z8NgTGU58k2wkcyxoykLD1cT0aFtx7qRpj
         UyrwItatV09fNQE9XBf65CjJyrHcIlydrqBk3MSaBGO8TyzWduVqRUnIGVJKXdmKwK3d
         0CsRGoFj8RAEJu3HupK/Nzu9SkStNrMDHfYovTZhPciu4SGZ1CR8AeD77eikuB8xtJRK
         7ylZsLB01vTcYgoY7lcgsy8q9JSc4huF7YTXcbKqDR94YPiWvl5fDHQSjlWAhMTdIxxo
         k7wcuNzTZrjV/bcUYbXL9UkgirQVAYJD0B+YJPmdDBk5B2SPHIMqNdrv0rTXmTwG7po6
         Gofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7ZrgbHAepEtXRim907cXR03K6j7vkm1mYBCdFxH0k54=;
        b=KTr/7eWvXvWNNDu4INm4DhtSm3RZtJWkfIWZriQv11gH4misbjTz4onnIpcsRVJ0Ac
         JnFXtA2FQrd/Lc2ZP3p3vaZU646AnXLYREu8Hk9Ho375MiRJnYuqJlFK8BBjQP5ibB2D
         0gfwnt0DiI3hSjySpdThWVgiUvyWWJ9z8dqOeNXK+9AmSfrlLXmslKuyJJ/j7YY91rcG
         h/cGVmBQtCpqbL2xMwgYSleP4kjElIS4eYhyLEU3Enc18ifjQ7R4mdInYkfmBC87QPwY
         rOa+flIDu2OAo8dWeSNNwuYwDy5FgoXHMUPeCk2fdYgX91mmlKY2kDdScq8wVibX6ekj
         WeHw==
X-Gm-Message-State: AOAM530aRjh2p3867XLH9JZGCenY5x3cgsJ98K08wWMMvSN6QL8RF1HI
        3ta/2hxZOpZjK2bdFA8lyHRL6P5IQKztgQ==
X-Google-Smtp-Source: ABdhPJxB9Ta8ufy/oJkZCpbtUP3PzN3Cz7yWnAzJhuY6EP8PWUzWbJxMh82jZ1H1mOe5OQmUNCMfkA==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr21430556wrw.17.1589837852811;
        Mon, 18 May 2020 14:37:32 -0700 (PDT)
Received: from ?IPv6:2001:16b8:483d:6b00:e80e:f5df:f780:7d57? ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id o26sm18637789wro.83.2020.05.18.14.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 14:37:31 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
 <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
 <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
 <01676778-bfc2-46d4-112b-ee16ef4cbcc1@trained-monkey.org>
 <6bd3cb34-1339-9e1b-1f57-07ef62a70818@cloud.ionos.com>
 <8671d1fb-1b59-cebf-e1f1-09490856e02b@trained-monkey.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b8df31b2-f9cf-4d4d-1846-77304b55b3ea@cloud.ionos.com>
Date:   Mon, 18 May 2020 23:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8671d1fb-1b59-cebf-e1f1-09490856e02b@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 11:06 PM, Jes Sorensen wrote:
> On 5/18/20 2:08 PM, Guoqing Jiang wrote:
>> On 5/18/20 7:50 PM, Jes Sorensen wrote:
>>> On 5/18/20 1:32 PM, Guoqing Jiang wrote:
>>>> On 5/18/20 7:22 PM, Jes Sorensen wrote:
>>>>> On 5/15/20 9:40 AM, Guoqing Jiang wrote:
>>>>>> Got below error when run "make everything".
>>>>>>
>>>>>> restripe.c: In function ‘test_stripes’:
>>>>>> restripe.c:870:4: error: ignoring return value of ‘read’, declared
>>>>>> with attribute warn_unused_result [-Werror=unused-result]
>>>>>>        read(source[i], stripes[i], chunk_size);
>>>>>>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>
>>>>>> Fix it by set the return value of ‘read’ to diskP, which should be
>>>>>> harmless since diskP will be set again before it is used.
>>>>>>
>>>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>>>> ---
>>>>>>     restripe.c | 6 +++++-
>>>>>>     1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/restripe.c b/restripe.c
>>>>>> index 31b07e8..21c90f5 100644
>>>>>> --- a/restripe.c
>>>>>> +++ b/restripe.c
>>>>>> @@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long
>>>>>> *offsets,
>>>>>>               for (i = 0 ; i < raid_disks ; i++) {
>>>>>>                 lseek64(source[i], offsets[i]+start, 0);
>>>>>> -            read(source[i], stripes[i], chunk_size);
>>>>>> +            /*
>>>>>> +             * To resolve "ignoring return value of ‘read’", it
>>>>>> +             * should be harmless since diskP will be again later.
>>>>>> +             */
>>>>>> +            diskP = read(source[i], stripes[i], chunk_size);
>>>>> It doesn't complain on Fedora 32, however checking the return value of
>>>>> lseek64 and read is a good thing.
>>>>>
>>>>> However what you have done is to just masking the return value and
>>>>> throwing it away, is not OK. Please do it properly.
>>>> Yes, it is used to suppress the warning. And set the return value to a
>>>> new variable
>>>> could cause unused-but-set-variable, not sure if there is better way
>>>> now.
>>> The correct way is to check the return values and take appropriate
>>> action if an error is returned.
>> Thanks, just find other places in restripe.c has check like this.
>>
>> "read(source[dnum], buf+disk * chunk_size, chunk_size) != chunk_size)
>>
>> Will send below changes if it is ok.
>>
>> diff --git a/restripe.c b/restripe.c
>> index 31b07e8..48c6506 100644
>> --- a/restripe.c
>> +++ b/restripe.c
>> @@ -867,7 +867,15 @@ int test_stripes(int *source, unsigned long long
>> *offsets,
>>
>>                  for (i = 0 ; i < raid_disks ; i++) {
>>                          lseek64(source[i], offsets[i]+start, 0);
>> -                       read(source[i], stripes[i], chunk_size);
>> +                       if (read(source[i], stripes[i], chunk_size) !=
>> +                           chunk_size) {
>> +                               free(q);
>> +                               free(p);
>> +                               free(blocks);
>> +                               free(stripes);
>> +                               free(stripe_buf);
>> +                               return -1;
>> +                       }
> That should work, however you really should check the return value of
> lseek as well, while looking at this.

Okay, though I did not get complain about it =-O. Anyway, will send v3.

Thanks,
Guoqing
