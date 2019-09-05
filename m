Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30D8AA800
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbfIEQJk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 12:09:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36327 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfIEQJk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 12:09:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so3246120edu.3
        for <linux-raid@vger.kernel.org>; Thu, 05 Sep 2019 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MHw6jL80oNY7kPUZiPOL1N2D+myQ6rEhmfpExf3c2Fw=;
        b=gd6IWa+wV/3v/J8914peXl2zELZvxnL/Ske7IK4T4SVxcqW+mw3c6f6sHiornJHEan
         MqQcfkV9OYi4mkxoHBTfkJNzIYVlCP3X/4ubhoxFpHfZXPjApPUsvB+4PCJGq4/Ebja0
         p2IALeJq6bgJCpsyl0+olNNaxfhWhgGqb6Evxnp2gqeKmJLQBP575qJgmkrxVJGobd1J
         wK8nwET+14sEwEHIE8P3NR8q2Qioqx6qyI/4xS8yFkjTi4aRM7DwVouR8Un+vUkC7jg2
         wIKBhjA8QXxL1qiAN2dSjJn93F2SnLDDSAgV99UVC5kUyuX/Akp6CmfeP+6XATmYTGnV
         mwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MHw6jL80oNY7kPUZiPOL1N2D+myQ6rEhmfpExf3c2Fw=;
        b=C48fGIw3KLTKtS9KRRL9Tcygo0Hk9Nl5o5LelvTzZl3t1b25wY1cm0ORRaDEG1J65C
         ZzJA2e9R0r9/R6Fan9tW0OwNT3wSg50JTBMA3Ymb43rxqdLM+vS6w5QeNHd3ghXmzEDH
         iu83dfyBq8waXrq4HykTv6St4UWz/GX6ajPryW2m1co9MZsjlZxNiwf/VxNSD0QfgdR8
         8rYraUB/sKyXHsLrGvFyeXO8hib9onEYy35NA5N0QQS5kPPF4F14MoOVlLXAlrwNjDOU
         AZATX7yi+9oNAI7+7BdTMyrOCh+vX4scm/gCCrf0HhDRHIFxgZIBpE1oIcI1Yl+VuJTh
         QGlg==
X-Gm-Message-State: APjAAAX8+5THIvD1BkpC06iqzWDWlTyx4vDr5MSZ59YZxjH4zpiih2b1
        N/JF+UNl+Rm//cv2ZLHTxMbou2nmapc=
X-Google-Smtp-Source: APXvYqzPnHNBpbBPk78eEd5vYYnl2nuURZeokLVoiNlqCMoEfrVLv4N3FtTAQf6sRNtxYQ6++FtjQg==
X-Received: by 2002:a17:906:f282:: with SMTP id gu2mr3541034ejb.198.1567699777939;
        Thu, 05 Sep 2019 09:09:37 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:580e:f01e:2458:6dd4? ([2001:1438:4010:2540:580e:f01e:2458:6dd4])
        by smtp.gmail.com with ESMTPSA id g11sm452706edu.4.2019.09.05.09.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:09:37 -0700 (PDT)
Subject: Re: [PATCH] raid5: don't warn with STRIPE_ACTIVE flag in
 break_stripe_batch_list
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
 <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
 <59821fd6-4dff-9871-7a48-dc9e877449f8@cloud.ionos.com>
Message-ID: <a528b164-6f9a-3de1-df5e-105aaa71b4d4@cloud.ionos.com>
Date:   Thu, 5 Sep 2019 18:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <59821fd6-4dff-9871-7a48-dc9e877449f8@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Replace STRIPE_SYNCING with STRIPE_ACTIVE in the subject ...

On 8/30/19 4:07 PM, Guoqing Jiang wrote:
>
>
> On 8/30/19 1:26 AM, Song Liu wrote:
>>
>>> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang 
>>> <guoqing.jiang@cloud.ionos.com> wrote:
>>>
>>> Hi Song,
>>>
>>> On 8/29/19 7:42 AM, Song Liu wrote:
>>>> I read the code again, and now I am not sure whether we are fixing 
>>>> the issue.
>>>> This WARN_ONCE() does not run for head_sh, which should have 
>>>> STRIPE_ACTIVE.
>>>> It only runs on other stripes in the batch, which should not have 
>>>> STRIPE_ACTIVE.
>>>  From the original commit which introduced batch write, it has the 
>>> description
>>> which I think is align with your above sentence.
>>>
>>> "With below patch, we will automatically batch adjacent full stripe 
>>> write
>>> together. Such stripes will be added to the batch list. Only the 
>>> first stripe
>>> of the list will be put to handle_list and so run handle_stripe().".
>>>
>>> Could you point me related code which achieve the above purpose? 
>>> Thanks.
>> Do you mean which code makes sure the batched stripe will not be 
>> handled?
>> This is done via properly maintain STRIPE_HANDLE bit.
>

The raid5_make_request always set STRIPE_HANDLE for stripe which is 
returned from
raid5_get_active_stripe, so seems the batched stripe could also set with 
STRIPE_HANDLE
too, am I miss something?

I checked the STRIPE_IO_STARTED flag, it is set in the path: 
handle_stripe -> ops_run_io.
Since both STRIPE_IO_STARTED and STRIPE_ACTIVE are valid, which means 
the stripe
should be handling in the middle of handle_stripe.

Maybe the scenario is that raid5_make_request get a lone stripe, then it 
is added to handle_list
since STRIPE_HANDLE is valid, then handle_stripe sets STRIPE_ACTIVE flag 
to the stripe.

Meantime, another full write writes to the same stripe, and added stripe 
to batch_list by:
      raid5_make_request -> add_stripe_bio -> stripe_add_to_batch_list.

Then the warning is triggered when err happens in the batch head stripe. 
There are two
ways to address the warning I think.

1. remove the checking of STRIPE_ACTIVE flag since it is possible that a 
batched stripe
could have the flag.
2. if STRIPE_ACTIVE flag is valid, then don't add stripe to batch list.

Also, there is short window between set STRIPE_ACTIVE and clear the flag 
in handle_stripe,
does it make sense to make rough change like this?

  static void handle_stripe(struct stripe_head *sh)
  {
         struct stripe_head_state s;
@@ -4675,7 +4682,7 @@ static void handle_stripe(struct stripe_head *sh)
         struct r5dev *pdev, *qdev;

         clear_bit(STRIPE_HANDLE, &sh->state);
-       if (test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)) {
+       if (test_bit(STRIPE_ACTIVE, &sh->state)) {
                 /* already being handled, ensure it gets handled
                  * again when current action finishes */
                 set_bit(STRIPE_HANDLE, &sh->state);
@@ -4683,9 +4690,9 @@ static void handle_stripe(struct stripe_head *sh)
         }

         if (clear_batch_ready(sh) ) {
-               clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
                 return;
         }
+       set_bit(STRIPE_ACTIVE, &sh->state);

Regards,
Guoqing
