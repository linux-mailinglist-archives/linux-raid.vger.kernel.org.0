Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9292130FAE
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 10:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgAFJmE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 04:42:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36467 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFJmD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 04:42:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so46905693edp.3
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gaGkKftYjAeQRzrMrk7V9+la/hJ8DsT33jh2gJTuewQ=;
        b=BTpqkxBWlHwpekn8vYl1SQBE05+QKw7HaZEp6Gld+GABttkkLWg68HlsO6KmZxVOs8
         1IobivP7mJQYiPlsfQq1z32fm/JS3QFZmT50p71Vg7IZQL2guTlzNl8GyayAKPIbK/ck
         Ey2DxoLdv9tkaPkHhY1vDvIMnyUfAno3QSOY34Iudc2WfI8etgqsKtsAPqVliR6dJXQa
         b+6zfYsjP3F4SMiMnJNLRR9NKzkqP18O0tz/3UTyfRpjnsrj6gtQhzoCwwnvs7JBqsSP
         aSbwGA4nBrjLbOVNopmqJ94g+EJco5DZ/VR+FGoiHqHkEQg3za4crWQ5/y1uBSnK7oUL
         mIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gaGkKftYjAeQRzrMrk7V9+la/hJ8DsT33jh2gJTuewQ=;
        b=git+ufvl/ZcHD5Pxfcu2l5P/7K9RP8ua3jiq4KDdViSWRVu57CSK6nCVelm5b2Qq9D
         K6NZuGnaaBI760637uAbP2XGUeqPpxQQMxfPjI8g6X7EkJVb8W1dNYCzoAVlzRC3oBzZ
         cLPxTuR3zPOvfFAsecoFGQLld7NqoGGEaKOWRmkrxeHho32M3TSqqQf4QuwtjdssXeHt
         zOL9vm44pp7AhKvK5wxu/0P8dG6CrUSLGBAOsnVVV+A7EVL+UyAe5wkGZDgSO/2QaVVh
         6027+TWI5msc7Uo5r/Fx/0vdG4DvkMdeT7OynGh402NPqVthM8RMbxxCPw/+frUYppJy
         n+HQ==
X-Gm-Message-State: APjAAAV/EgcQhB8iIhhUbP77aWIvbG+NkgrkNivRfBRnonl2uMFOzbbe
        Nt/Xii+MNnE0+TR+LNQO2LeGokdGzU8=
X-Google-Smtp-Source: APXvYqxI7ghiXb1kRvNue0nqDwxT6/0i2aHCTQesueebCVMy9CG5i2ZzWtcCeAvGaDcSRfC6Dayd1Q==
X-Received: by 2002:a50:d493:: with SMTP id s19mr105837199edi.77.1578303721817;
        Mon, 06 Jan 2020 01:42:01 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:443c:bea1:ffb8:40f? ([2001:1438:4010:2540:443c:bea1:ffb8:40f])
        by smtp.gmail.com with ESMTPSA id m24sm7388476edr.83.2020.01.06.01.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 01:42:01 -0800 (PST)
Subject: Re: [PATCH V3 05/10] md: reorgnize mddev_create/destroy_serial_pool
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
 <20191223094902.12704-6-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW6kbPvOkVUGQBG+txJmiOWjRbhvK9BLoBckqraemy0bfQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <0dacd146-2bde-5999-08ce-d41fdf73510b@cloud.ionos.com>
Date:   Mon, 6 Jan 2020 10:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6kbPvOkVUGQBG+txJmiOWjRbhvK9BLoBckqraemy0bfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/3/20 11:58 PM, Song Liu wrote:
> On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> So far, IO serialization is used for two scenarios:
>>
>> 1. raid1 which enables write-behind mode, and there is rdev in the array
>> which is multi-queue device and flaged with writemostly.
>> 2. IO serialization is enabled or disabled by change serialize_policy.
>>
>> So introduce rdev_need_serial to check the first scenario. And for 1, IO
>> serialization is enabled automatically while 2 is controlled manually.
>>
>> And it is possible that both scenarios are true, so for create serial pool,
>> rdev/rdevs_init_serial should be separate from check if the pool existed or
>> not. Then for destroy pool, we need to check if the pool is needed by other
>> rdevs due to the first scenario.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   drivers/md/md.c | 71 +++++++++++++++++++++++++++++--------------------
>>   1 file changed, 42 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 796cf70e1c9f..788559f42d43 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -147,28 +147,40 @@ static void rdevs_init_serial(struct mddev *mddev)
>>   }
>>
>>   /*
>> - * Create serial_info_pool for raid1 under conditions:
>> - * 1. rdev is the first multi-queue device flaged with writemostly,
>> - *    also write-behind mode is enabled.
>> - * 2. rdev is NULL, means want to enable serialization for all rdevs.
>> + * rdev needs to enable serial stuffs if it meets the conditions:
>> + * 1. it is multi-queue device flaged with writemostly.
>> + * 2. the write-behind mode is enabled.
>> + */
>> +static int rdev_need_serial(struct md_rdev *rdev)
>> +{
>> +       return (rdev && rdev->mddev->bitmap_info.max_write_behind > 0 &&
> I guess there is not need to check rdev here?

No, the rdev could be passed from mddev_create_serial_pool, and
caller could set it to NULL, pls see patch 0003.

Thanks,
Guoqing
