Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14283A38C1
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfH3OFT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 10:05:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33332 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3OFT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 30 Aug 2019 10:05:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id l26so7525328edr.0
        for <linux-raid@vger.kernel.org>; Fri, 30 Aug 2019 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FhAwx6F8kDAcloZhIbdtMkULykd37D7ItAvBH2gSS/Q=;
        b=CkCJBxROhsoSGL60+4LFfmNjV7/PLYWYuYiGnNwdWE3lvZO/AHQG4SXsQfkz3ZUqrl
         7XRdgmVdZecoRdl3DOVbVrfSzevc2VnHz9Y5fnj3Nz+Eh485FZj68KiAw1U2V302S+FJ
         oIUTjeEGeRZOvY003rbMkE9Hr4SynxjkqrdPPXscxAae3c2ftds2j0qIsEleWc1Kwm5E
         PSKpgrc8/kVKM4/GVnjxIncOC9Hpa34IlJg6T9rK9+HdGb1nvshtUOf3ie5LiwH9Jubg
         nkKgkOF7NwG1rM2YeOnIkk8PIG3lPBp4RlcxWRDFRAF0QSvi+MDseQyLYZVhCRXJCnZB
         7p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FhAwx6F8kDAcloZhIbdtMkULykd37D7ItAvBH2gSS/Q=;
        b=ReZUpqGikI60+ciPdif0ulObjNS3NJ3Y9Q5JHppWsH7mBrUVGZgTxmXAmsn4UKCxAD
         /Fv9L68OXPqvoWkLRtCIqpbqYiYz99e/4Ock9pxCTV7AwJqgp8NA9Sv81bVIuR8sIntD
         IhFuydecXZ590n81bVsVuWSzmlTEMuwdZY0V0F8QSyntFNTFaMdB9jsk63YXCQR1SEXT
         UmSL8nguFXuAhOl/7wxozR8YZUF70WFChw94ETZEUgxFh/DjhAwGxa28wjpigNQE/8Rx
         d981an/AhVFSYu2fxwnxsTvvyy+X037gvf1BRkaaQweA2B0Do17b/izeQd/FM327rgmD
         RVvQ==
X-Gm-Message-State: APjAAAWctfH9ApIj+uMTr4+zhPDnynt8DgghENy86Nv166BKhVbaf33G
        3HDEGrJ94CeJ7RPTWqldYIAzmqmTQv0=
X-Google-Smtp-Source: APXvYqzDU55u2UP9HZ+kBEgKmRPJQX7V72nqGwTOcdcrLvS9+HG0SqGXV5RsdP9icnl0VaeIyld3IQ==
X-Received: by 2002:a17:906:32c2:: with SMTP id k2mr13058949ejk.308.1567173916780;
        Fri, 30 Aug 2019 07:05:16 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:bd3e:de57:2010:1b? ([2001:1438:4010:2540:bd3e:de57:2010:1b])
        by smtp.gmail.com with ESMTPSA id r20sm225645ejz.42.2019.08.30.07.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 07:05:16 -0700 (PDT)
Subject: Re: WARNING in break_stripe_batch_list with "stripe state: 2001"
To:     NeilBrown <neilb@suse.de>, Song Liu <liu.song.a23@gmail.com>
Cc:     Neil F Brown <nfbrown@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <7401b3e0-fb0c-8ed7-b1cb-28494fbac967@cloud.ionos.com>
 <e2aad07c-1f67-12c7-ac33-6df9cbdac43c@cloud.ionos.com>
 <CAPhsuW4gu4BaU=2cTNSGQoLEp4xeixRMgDrqfw0Eoxiu=QfeBw@mail.gmail.com>
 <a2536d84-68df-3422-b677-66c666ebb35b@cloud.ionos.com>
 <874l1zf3gd.fsf@notabene.neil.brown.name>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f2ed26b0-1c44-f74c-90bf-07260a9dedbb@cloud.ionos.com>
Date:   Fri, 30 Aug 2019 16:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l1zf3gd.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Neil,

Thanks for your comment!

On 8/30/19 10:43 AM, NeilBrown wrote:
> On Tue, Aug 27 2019, Guoqing Jiang wrote:
>
>> Hi Song,
>>
>> Thanks a lot for your reply.
>>
>> On 8/26/19 10:07 PM, Song Liu wrote:
>>> Hi Guoqing,
>>>
>>> Sorry for the delay.
>>>
>>> On Mon, Aug 26, 2019 at 6:46 AM Guoqing Jiang
>>> <guoqing.jiang@cloud.ionos.com> wrote:
>>> [...]
>>>>> Maybe it makes sense to remove the checking of STRIPE_ACTIVE just like
>>>>> commit 550da24f8d62f
>>>>> ("md/raid5: preserve STRIPE_PREREAD_ACTIVE in break_stripe_batch_list").
>>>>>
>>>>> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
>>>>> stripe_head *head_sh,
>>>>>
>>>>>                   list_del_init(&sh->batch_list);
>>>>>
>>>>> -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>>>>> -                                         (1 << STRIPE_SYNCING) |
>>>>> +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>>>>>                                             (1 << STRIPE_REPLACED) |
>>>>>                                             (1 << STRIPE_DELAYED) |
>>>>>                                             (1 << STRIPE_BIT_DELAY) |
>>> This part looks good to me.
>>>
>>>>> @@ -4626,6 +4626,7 @@ static void break_stripe_batch_list(struct
>>>>> stripe_head *head_sh,
>>>>>
>>>>>                   set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
>>>>>                                               (1 <<
>>>>> STRIPE_PREREAD_ACTIVE) |
>>>>> +                                           (1 << STRIPE_ACTIVE) |
>>>>>                                               (1 << STRIPE_DEGRADED) |
>>>>>                                               (1 <<
>>>>> STRIPE_ON_UNPLUG_LIST)),
>>>>>                                 head_sh->state & (1 << STRIPE_INSYNC));
>>>>>
>>> But I think we should not clear STRIPE_ACTIVE here. It should be
>>> cleared at the end of handle_stripe().
>> Yes, actually "clear_bit_unlock(STRIPE_ACTIVE, &sh->state)" is the last
>> line in handle_stripe. So we only need to do one line change like.
>>
>>
>> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
>> stripe_head *head_sh,
>>
>>                   list_del_init(&sh->batch_list);
>>
>> -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>> -                                         (1 << STRIPE_SYNCING) |
>> +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>>                                             (1 << STRIPE_REPLACED) |
>>                                             (1 << STRIPE_DELAYED) |
>>                                             (1 << STRIPE_BIT_DELAY) |
>>
>> I will send formal patch if you are fine with above, thanks again.
> This is probably OK.
>
> I think that when the 'handle_flags' argument is zero, an error has
> occurred and STRIPE_ACTIVE is expected to be set.
> When it is non-zero, it shouldn't be set.

Yes, indeed. When error (STRIPE_BATCH_ERR or lost more than max_degraded 
devices)
happens, handle_stripe calls break_stripe_batch_list with set 
'handle_flags' to zero.

> I'm not sure it is worth encoding that in the warning, but it probably
> is worth making that clear in the commit message.

Maybe something like this.

@@ -4607,24 +4609,25 @@ static void break_stripe_batch_list(struct 
stripe_head *head_sh,
         struct stripe_head *sh, *next;
         int i;
         int do_wakeup = 0;
-
+       unsigned long warn_states = (1 << STRIPE_SYNCING) |
+                                   (1 << STRIPE_REPLACED) |
+                                   (1 << STRIPE_BIT_DELAY) |
+                                   (1 << STRIPE_FULL_WRITE) |
+                                   (1 << STRIPE_BIOFILL_RUN) |
+                                   (1 << STRIPE_COMPUTE_RUN) |
+                                   (1 << STRIPE_OPS_REQ_PENDING) |
+                                   (1 << STRIPE_DISCARD) |
+                                   (1 << STRIPE_BATCH_READY) |
+                                   (1 << STRIPE_BATCH_ERR) |
+                                   (1 << STRIPE_BITMAP_PENDING);
+
+
+       if (handle_flags)
+               warn_states = warn_states | (1 << STRIPE_ACTIVE);
         list_for_each_entry_safe(sh, next, &head_sh->batch_list, 
batch_list) {

                 list_del_init(&sh->batch_list);
-
-               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
-                                         (1 << STRIPE_SYNCING) |
-                                         (1 << STRIPE_REPLACED) |
-                                         (1 << STRIPE_DELAYED) |
-                                         (1 << STRIPE_BIT_DELAY) |
-                                         (1 << STRIPE_FULL_WRITE) |
-                                         (1 << STRIPE_BIOFILL_RUN) |
-                                         (1 << STRIPE_COMPUTE_RUN)  |
-                                         (1 << STRIPE_OPS_REQ_PENDING) |
-                                         (1 << STRIPE_DISCARD) |
-                                         (1 << STRIPE_BATCH_READY) |
-                                         (1 << STRIPE_BATCH_ERR) |
-                                         (1 << STRIPE_BITMAP_PENDING)),
+               WARN_ONCE(sh->state & warn_states,
                         "stripe state: %lx\n", sh->state);

Best Regards,
Guoqing

