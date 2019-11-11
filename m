Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FECF70AC
	for <lists+linux-raid@lfdr.de>; Mon, 11 Nov 2019 10:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKJ1a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 Nov 2019 04:27:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKJ1a (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 Nov 2019 04:27:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id b72so11389852edf.1
        for <linux-raid@vger.kernel.org>; Mon, 11 Nov 2019 01:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZHXCIYACSsU8TdIZmcNqLMVjzCiYfBZNbtbGkOdS7KY=;
        b=DungZOVlAx4rZb8YbuSLt4CxvT7K5jQPS2l7ho+wXNYB7zZ5rgVOHsJmhv+HIX/vzz
         EGYvefoXnL1uz+ezjJy0QXp7mEKYG8gnxnMaEWPxPVTOQZYHZRluca+PqxTOmHZeRM40
         MZaT9W5taJD5MAYw6HPmAimE3W1mKpGMRrjGWlrGjCArDO2QOitfs9Fi/Kjds0cNGJRA
         3WmBQ4fTJMAHiM9mVJchdUpXJ9XPemAavFMALOsnODtR3ZYnICF9QjM0FnM9Xxx5kmm+
         sOQA6t6C3Vgd9r8MsuILhCX0Gx+i23LAoayUfx0/u0Enn8ztDXcVid+ZJVh/cFqwRxZ/
         WNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZHXCIYACSsU8TdIZmcNqLMVjzCiYfBZNbtbGkOdS7KY=;
        b=YN+9A6dqMI423lGNs0+L7KDIHCL+4jYYO7YASmMMLVPmswGifYZxu41PuOtI6IaIFA
         0cuhZRXwj+9FbIJcmXDIpsDQ0oQ8uje4iszUkjOYYeu+1LvHgWVLlHDr1Z1VPwxAme4B
         V3nCRFeMb3KpP5Z+UyGRnfef1najjGsjKYoQSAGoTQId2QX1tTdXQ7MGUfSStCe9VPgb
         oxzhMa5G8j1cBa6ylIwspuXhm8mXQamyIrQdlKlCKBQ8EWnIIUSopyCJs2cTs9DmhVyM
         XN8Fu5L7r1O5APLlvxZCUa+ZggUg5hpazQsCFHdm2Oa4M/zufYvmbUnL0H7peo9yz121
         Gsjw==
X-Gm-Message-State: APjAAAVoY68NZEICePe4yrRE4W14MZ6+FaEEZJC6kkpxQyh2GpqAQS2V
        JnDG+dlSD2BG9tUiCeAPyQXbiJkRvek6tQ==
X-Google-Smtp-Source: APXvYqxnsmfnFGw5kb46lS5K0a/nDzkFKSN36d+/apPfcD/ziaoKLr04KoRBPSTABocPAfmBlbbq+A==
X-Received: by 2002:a50:ec83:: with SMTP id e3mr25425435edr.292.1573464448793;
        Mon, 11 Nov 2019 01:27:28 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:4de3:f9ba:6e9b:388d? ([2001:1438:4010:2540:4de3:f9ba:6e9b:388d])
        by smtp.gmail.com with ESMTPSA id p20sm521403edt.63.2019.11.11.01.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 01:27:27 -0800 (PST)
Subject: Re: [PATCH 2/8] md: add is_force parameter for some funcs
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-3-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW7MwTvWzDr6voTS92chTm-Znwy74pjyF1=cpXcj27_A3w@mail.gmail.com>
 <dd801115-92b5-85a4-ae6b-504ed888c2e0@cloud.ionos.com>
 <CAPhsuW5wAmD+qOqfZyd=EM4FKcJ48sbAd6jzSCvTp8pJB4jzjQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <8609df21-cc8d-6841-5b3b-5ce59863fd86@cloud.ionos.com>
Date:   Mon, 11 Nov 2019 10:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5wAmD+qOqfZyd=EM4FKcJ48sbAd6jzSCvTp8pJB4jzjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/8/19 11:38 PM, Song Liu wrote:
> On Wed, Nov 6, 2019 at 2:04 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>
> [...]
>
>>>> -static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
>>>> +static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>>>> +                                     bool is_force)
>>> I guess mddev_destroy_serial_pool() doesn't need an extra argument. We
>>> can just to clear_bit, etc.. no?
>> Let me explain a little bit, the function are used in below cases:
>>
>> 1. write-behind mode is enabled and write-mostly device has multi queues,
>> the pool should be destroyed if the last device flagged with CollisionCheck
>> is removed from array, or the write-mostly flag will be cleared from the
>> last
>> device.
>>
>> 2. if we want to enable/disable serialization for normal raid1 in later
>> patch,
>> which means the pool could be created/destroyed whether bitmap is existed
>> or not, and all member device should be flagged with CollisionCheck.
>>
>> The new argument is introduced to distinguish the two cases.
> I understand the difference here. And I agree that we need a new argument
> for mddev_create_serial_pool(). The question is, it is possible NOT to add the
> extra argument to mddev_destory_serial_pool().

I'd prefer to add it, so both create pool and destroy pool have the same 
argument.

Though I can check rdev is NULL or not to differentiate where the two 
functions
are called, but it is a little weird and not intuitive.

Thanks,
Guoqing
