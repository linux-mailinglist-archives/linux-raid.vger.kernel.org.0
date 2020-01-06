Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31512130F8E
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFJev (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 04:34:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43536 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFJev (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 04:34:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so46866556edb.10
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n5KY6KX7CvsCKgmkfqwIazis2633Iv+NElRo9cpDF1U=;
        b=L7Ugt+jTTAhU22+eMXI1My70qRcBTJt2yHzFnW/kJ1WMHkRRA04ndBbutqO29+G1F8
         mZiotsE9zVIf0yyRHFQfA/gAAj2+P30KBIHlm4rG6xsDwnbPoMKHijexbTqbiAorSfie
         z8D4Ql5IvKNjuzC0i8iBb4kjJ32gHndvJIXo1ifES7q8veWqKfQFZ13DlzYGeofJj2i5
         rhSyz8MFP0te25M0aQX0YI6e65K1lmAiGZJd56+kROamms7KZUwBCohTToPxKGM1+a0x
         TJPXaZe3FGHkLD3ciqN+tmpp7O/COd5J1kgv0F1sUnknjW8oLDOBxQxq+wGBbZZbiBxk
         8pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n5KY6KX7CvsCKgmkfqwIazis2633Iv+NElRo9cpDF1U=;
        b=ovpqFy95l/UDV8LDtx2uGfqABPUpeZLXNUbMUCUYHgd+1OCcLwG/WfrDmvf4SprnXD
         4tkML+2YEQZQh5ErPrmpCVnDtf/+lGxapBUl48pETRGkaTmvtCcLXxQw33esSAH2UhcM
         uhgmXgPUMiPh2BGFauWvfGwgmgb+DGBQ/UrnOpOe6id0jKXQEWGlTwRMqEaopEhdgwPj
         mKAzbEl7Q5hkgfUydKTzEebvLqeryRYYZmidMRja1JchkhDKFEJotZQT+/MWKVagSH/W
         KVuDAE5E9zxcRha5czh2F6mMaOT6iK7sg3uNZoBBb6fQxTEwIHn9rt5doC0kBeDCV4f4
         mJlA==
X-Gm-Message-State: APjAAAX9vsr3fhdfMzF+piMxSV6/rNw/1jAf1lJdSNOCLF7ZpWzfjvOL
        SXHOq2XehFXKaSHJs7Brrb5QmjqOjPE=
X-Google-Smtp-Source: APXvYqx85fUYWhNKa7frN5L21xhZ6g58b3NhNPUm9DkJD6pMiNMR5mAXiTI3hC1JHL26S+jpEVmR2g==
X-Received: by 2002:a05:6402:1558:: with SMTP id p24mr106586084edx.120.1578303288877;
        Mon, 06 Jan 2020 01:34:48 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:443c:bea1:ffb8:40f? ([2001:1438:4010:2540:443c:bea1:ffb8:40f])
        by smtp.gmail.com with ESMTPSA id k26sm7633884edv.13.2020.01.06.01.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 01:34:48 -0800 (PST)
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW7qPsc-bZJpAV7H2qjX2MBdW8fusN7TyNphp7bF2SnB9g@mail.gmail.com>
 <CAPhsuW6Wi3++4_CHT9xanXpUH_RafbhPD2SprjKL2oo01fjwfw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <0c667733-2a3d-1fff-4ee8-d492c0bda919@cloud.ionos.com>
Date:   Mon, 6 Jan 2020 10:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6Wi3++4_CHT9xanXpUH_RafbhPD2SprjKL2oo01fjwfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/3/20 11:56 PM, Song Liu wrote:
> On Fri, Jan 3, 2020 at 11:48 AM Song Liu <liu.song.a23@gmail.com> wrote:
>> On Fri, Jan 3, 2020 at 5:56 AM <jgq516@gmail.com> wrote:
>>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>
>> [...]
>>> ---
>>>   drivers/md/raid5.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>> index d4d3b67ffbba..70ef2367fa64 100644
>>> --- a/drivers/md/raid5.c
>>> +++ b/drivers/md/raid5.c
>>> @@ -5481,7 +5481,9 @@ static void release_stripe_plug(struct mddev *mddev,
>>>                          INIT_LIST_HEAD(cb->temp_inactive_list + i);
>>>          }
>>>
>>> -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
>>> +       if (!atomic_read(&sh->count) == 0 &&
>> "!atomic_read(&sh->count) == 0" is confusing. Do you actually mean
>> "atomic_read(&sh->count) == 0"?

If "atomic_read(&sh->count) == 0" is true, which means the sh is handled by
do_release_stripe, so the sh could be added to other lists as I said in 
header,
so I think we should not add the sh to cb->list for this case. IOW, the 
sh could
be added to callback list only if it's count is not '0', no?

> Also, I guess we need to CC stable?

Ok, will add it.

Thanks,
Guoqing


