Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDF9DEE5
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfH0HkB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 03:40:01 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38842 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0HkA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 27 Aug 2019 03:40:00 -0400
Received: by mail-ed1-f45.google.com with SMTP id r12so30114381edo.5
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E3CLjkR6uB9aVZADJEmjFm4XPfLyBFmrNpXBq+16wQU=;
        b=CUdzlU5h2cOG8KOkIHUlyKrVbqH1DlOCgAuVAV8F4Dv7yxagPnAsFcdUB9vpeqZY8y
         T6ajRr1HMNcZdpTnLOcnTzDv1+SoCxTUN8xzajZyUygNoDNsUj9UY0fxV2LOSXSXwy61
         uKeBszQZV8q54Ul3t+UY9F9akxTPTRgZaXjYjRssx30oaVTqhJvL5iGKlNeVezOvepYo
         vSxAicJ/k7wi93qiejwFTIFYhkBeWrrHmNng1fYm/gtUJL8lOMbAHKn9gXQguzu6ub0N
         Cb+A+gXCFMz1ZzabypZB20fUBNW1JkDAo/QwTgDzBfJNrylw6VUGDy4PHn5G9sQPmIos
         h38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E3CLjkR6uB9aVZADJEmjFm4XPfLyBFmrNpXBq+16wQU=;
        b=OffQs3dH3CwWacj+A+LwOGTCPpGZiNdfa7LwfHOUSUxvrY2v24mcyFuJIvKv8LYgJw
         4/enEx7Hu9N7WdoK9h28YPp4wI8wDFZPDb2kyXpHCt5/zc8rhPN58v3ke4aKwH/OHKyA
         q3vCW+sSg9Ic7IHeGDeR+dfr0zw/DxFIrNE3sBxDj0EX5Q7L0oBBH/V8LSpDQF4oiK0C
         nN7Iq0m1hVJ3AMdSETyqqcaaqBW0aJVEXALVNl5Ew1L+7i/Mlp3ntk2PIJpkT46uotbt
         ByNjV3Qt1xQ6bDfDq0mag7JxOvkWyYzUgB4sAhqQxbkLZ0nWfXe30KYXNio4PTo1B7F9
         lG0g==
X-Gm-Message-State: APjAAAWLrHPbmXwZ2TBkFXrosjgfrHVuuSmfF+q0OacMzBCadS2rNj06
        vWLsKC0qk498I0d8Yg/evOcvVg==
X-Google-Smtp-Source: APXvYqzVC+IqW8rfvWw/Uvfq+AyYfKXA6nmerJLY5Pj5whaEhj78Ua6VjNFr3rjDmUWjQnKTRH5TWw==
X-Received: by 2002:aa7:d5cf:: with SMTP id d15mr22732272eds.67.1566891599023;
        Tue, 27 Aug 2019 00:39:59 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2066:ee3:46b:72eb? ([2001:1438:4010:2540:2066:ee3:46b:72eb])
        by smtp.gmail.com with ESMTPSA id g22sm3160898ejr.87.2019.08.27.00.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 00:39:57 -0700 (PDT)
Subject: Re: WARNING in break_stripe_batch_list with "stripe state: 2001"
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.com>
References: <7401b3e0-fb0c-8ed7-b1cb-28494fbac967@cloud.ionos.com>
 <e2aad07c-1f67-12c7-ac33-6df9cbdac43c@cloud.ionos.com>
 <CAPhsuW4gu4BaU=2cTNSGQoLEp4xeixRMgDrqfw0Eoxiu=QfeBw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a2536d84-68df-3422-b677-66c666ebb35b@cloud.ionos.com>
Date:   Tue, 27 Aug 2019 09:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4gu4BaU=2cTNSGQoLEp4xeixRMgDrqfw0Eoxiu=QfeBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,

Thanks a lot for your reply.

On 8/26/19 10:07 PM, Song Liu wrote:
> Hi Guoqing,
>
> Sorry for the delay.
>
> On Mon, Aug 26, 2019 at 6:46 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
> [...]
>>> Maybe it makes sense to remove the checking of STRIPE_ACTIVE just like
>>> commit 550da24f8d62f
>>> ("md/raid5: preserve STRIPE_PREREAD_ACTIVE in break_stripe_batch_list").
>>>
>>> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
>>> stripe_head *head_sh,
>>>
>>>                  list_del_init(&sh->batch_list);
>>>
>>> -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>>> -                                         (1 << STRIPE_SYNCING) |
>>> +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>>>                                            (1 << STRIPE_REPLACED) |
>>>                                            (1 << STRIPE_DELAYED) |
>>>                                            (1 << STRIPE_BIT_DELAY) |
> This part looks good to me.
>
>>> @@ -4626,6 +4626,7 @@ static void break_stripe_batch_list(struct
>>> stripe_head *head_sh,
>>>
>>>                  set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
>>>                                              (1 <<
>>> STRIPE_PREREAD_ACTIVE) |
>>> +                                           (1 << STRIPE_ACTIVE) |
>>>                                              (1 << STRIPE_DEGRADED) |
>>>                                              (1 <<
>>> STRIPE_ON_UNPLUG_LIST)),
>>>                                head_sh->state & (1 << STRIPE_INSYNC));
>>>
> But I think we should not clear STRIPE_ACTIVE here. It should be
> cleared at the end of handle_stripe().

Yes, actually "clear_bit_unlock(STRIPE_ACTIVE, &sh->state)" is the last
line in handle_stripe. So we only need to do one line change like.


@@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct 
stripe_head *head_sh,

                 list_del_init(&sh->batch_list);

-               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
-                                         (1 << STRIPE_SYNCING) |
+               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
                                           (1 << STRIPE_REPLACED) |
                                           (1 << STRIPE_DELAYED) |
                                           (1 << STRIPE_BIT_DELAY) |

I will send formal patch if you are fine with above, thanks again.

BR,
Guoqing
