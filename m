Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1AA1321D6
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jan 2020 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAGJDg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Jan 2020 04:03:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56170 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJDf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Jan 2020 04:03:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so18047312wmj.5
        for <linux-raid@vger.kernel.org>; Tue, 07 Jan 2020 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZjRaFyra9ZrWBPVW+k7UADnjr5VBKCXpZvm+r3gXj8c=;
        b=UTHohhc/ADxocGrHfYG5J7JSEP1xXCACWl7U691KVROO+xL6Q5TXRcO8HkY064rpHe
         DMY/MREsCrBiqFCsqv67zLXI03beH/8jv785WtJD2EboplZIFu1q9rMAfcO4hgZwA/lB
         iDeCcqre+rQLVZ9eCYrfM1Jq/qDdbwXwhHUUiL+QhhcMnhbaA9k5r066tL49Wb28+rQO
         jR+6c/jA1zzTEblgk4I7nhgYfbt27QYmHgDXSUQflXDg/5U+NTwKWpMGxAngo5jRl4l3
         GLrJmvZD+ZkTGGMjeb2t79nX2g4skh7xPd8GwnXyNcPm4gHojRQ/eY2X5/9m0+wmrOwq
         AO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZjRaFyra9ZrWBPVW+k7UADnjr5VBKCXpZvm+r3gXj8c=;
        b=W3EdXLzzvl2By2iZoShWO8KxRlQLkir30lCSTcyqZocEBBUsMnOTuEaopf0V2m83VJ
         kSqQ/5uVzdWNVHV541w0Zkfa7zoz8FCBE/nkiIvvIp0Fczzltbktni3hB/ctlkCJRsXB
         66pA8Fdg+Rf7r+oPAQUkymSwoBOEqMhSL/FGJqQPheWFevjTa2ylbaMM49I0nAXju51m
         YcYZHmS7IiFOFhZCj9/RAbKwLe7xUwLhG93ySTlx+I1MDwbEHqHEzCE7IcU7wSP1pVP8
         CzfjbAvlkEKlTfEdgMwFqI+boSZFi93+EUV+qmK0atEcwn5VXG1REIdVVFxjNl44xyMk
         OSrg==
X-Gm-Message-State: APjAAAVCgGUwcO4ZSSy1/5HwdW+/lHGeuOPTtBeHVWY8xEZ37BeE2ZR3
        ZNGyuclOUgpjO3BB4huAT5V0016/s+s=
X-Google-Smtp-Source: APXvYqxy+XNsq1+uF3sGs3wM4fBNFOa7tnSo8GF7XGG3hV8yk0jXaIwf5b9rcaZiuV57JCAc7HxhgQ==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr39839394wmj.135.1578387813040;
        Tue, 07 Jan 2020 01:03:33 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:e4f3:29f0:7223:b595? ([2001:1438:4010:2540:e4f3:29f0:7223:b595])
        by smtp.gmail.com with ESMTPSA id o15sm77122343wra.83.2020.01.07.01.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 01:03:32 -0800 (PST)
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW7qPsc-bZJpAV7H2qjX2MBdW8fusN7TyNphp7bF2SnB9g@mail.gmail.com>
 <CAPhsuW6Wi3++4_CHT9xanXpUH_RafbhPD2SprjKL2oo01fjwfw@mail.gmail.com>
 <0c667733-2a3d-1fff-4ee8-d492c0bda919@cloud.ionos.com>
 <CAPhsuW6jFF6yP6=z0AmoLRnaDig94a_zHSK9r=bb3APsf+9m8w@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <49d2044f-e068-32e9-411a-b8e470b85883@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 10:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6jFF6yP6=z0AmoLRnaDig94a_zHSK9r=bb3APsf+9m8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/6/20 6:15 PM, Song Liu wrote:
> On Mon, Jan 6, 2020 at 1:34 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>>
>> On 1/3/20 11:56 PM, Song Liu wrote:
>>> On Fri, Jan 3, 2020 at 11:48 AM Song Liu <liu.song.a23@gmail.com> wrote:
>>>> On Fri, Jan 3, 2020 at 5:56 AM <jgq516@gmail.com> wrote:
>>>>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>>>
>>>> [...]
>>>>> ---
>>>>>    drivers/md/raid5.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>>>> index d4d3b67ffbba..70ef2367fa64 100644
>>>>> --- a/drivers/md/raid5.c
>>>>> +++ b/drivers/md/raid5.c
>>>>> @@ -5481,7 +5481,9 @@ static void release_stripe_plug(struct mddev *mddev,
>>>>>                           INIT_LIST_HEAD(cb->temp_inactive_list + i);
>>>>>           }
>>>>>
>>>>> -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
>>>>> +       if (!atomic_read(&sh->count) == 0 &&
>>>> "!atomic_read(&sh->count) == 0" is confusing. Do you actually mean
>>>> "atomic_read(&sh->count) == 0"?
>> If "atomic_read(&sh->count) == 0" is true, which means the sh is handled by
>> do_release_stripe, so the sh could be added to other lists as I said in
>> header,
>> so I think we should not add the sh to cb->list for this case. IOW, the
>> sh could
>> be added to callback list only if it's count is not '0', no?
> I see. I guess it is cleaner with
>    atomic_read(&sh->count) != 0
> or
>    atomic_read(&sh->count) > 0
> ?

Yes, it is cleaner and will change it.

Thanks,
Guoqing
