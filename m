Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9597EF12A6
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKFJs0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 04:48:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38944 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKFJs0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 04:48:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id l25so18783787edt.6
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NBNq8vEwhopxxQqtZyjFFr4xar0bE14mHdt473gEW00=;
        b=Ew6GWmZG89iTJXY28ZhNx/DPsQx7oIDRqjNuj5AojCHNCd/XelM0A/rDOnzbVb+MVR
         8n+l97fvsjd66+c22qNk8EscntnV1XmNbeYT3hahAxQgKFS7ZAlxAzGDmQgffCEbSipr
         Jc8Fxd+n5v4BN3+sc6U6p2pKTtikJR5tjB7uJt0qwo5qjm4VhddHBCLLquFg1J5IgVcZ
         sJXKyOEk788sxRVpwbI7a2rLQqqIiiy3i5WqyzN2YXBaDguHAqPN8ipP6soOWxWqUFrm
         LwFwEk88vpXMBbdFXKQvZL6d8/qMz6G3kEFVXJK8gqdpMKSKtn0g0B5w/kOz7ITaVvH8
         9ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NBNq8vEwhopxxQqtZyjFFr4xar0bE14mHdt473gEW00=;
        b=ciCbXOmhIKcJwC8O+T+rc+fioAG8InML6TmExn+cfvbYI64QeYR3yS2eRXER90UM3g
         PHf4dTN5gsanpwggVIB5lnLntmJQh2Ec5B4mSg3/8N0cBDq4Nxi6zA7myqUvOkp/lpSv
         TgPDqhX4mByKWHtL81QdHlm+X//vZzDuoG4PBWvwIChtYGaUL6LobumaCXlRGQUuPsvY
         E5fwUra+HfZdW9c/WyTk+gPguZnak0o9mEdBihcRkQK4AS8ODQmEVF1PH/gUgSILApwl
         VCFBROY8aWgi7Oxnx1wJO8/xAxmRAXtdOxh5iq89R2LP+7lM2KjBNsWYjgSqz+EYW3De
         tFEA==
X-Gm-Message-State: APjAAAXWlgWKnBr3OqrYGePILnZiaHM7s5kJ6Ra0GknwFkl027vyG1cb
        Nx9QhmhioEE4s7i9iZHzsS8FdsZYQHfNOg==
X-Google-Smtp-Source: APXvYqxltPUWEmyoa6c7NJQvdczdNAE6zXmI1JnCQMjdIpkydsBR1ylb330OdHRe6+46MM4jlbUbKw==
X-Received: by 2002:a05:6402:70e:: with SMTP id w14mr1544516edx.95.1573033703912;
        Wed, 06 Nov 2019 01:48:23 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1c1:e73c:e916:21a0? ([2001:1438:4010:2540:1c1:e73c:e916:21a0])
        by smtp.gmail.com with ESMTPSA id m26sm240311edr.16.2019.11.06.01.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:48:23 -0800 (PST)
Subject: Re: [PATCH 1/8] md: rename wb stuffs
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-2-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW7xX2D7yibLzTBAJOgSPWEfcmdJERtgXwkGGyhWDPPORg@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <73e91f4b-8c34-52ad-7ce9-53226b14e241@cloud.ionos.com>
Date:   Wed, 6 Nov 2019 10:48:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7xX2D7yibLzTBAJOgSPWEfcmdJERtgXwkGGyhWDPPORg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/5/19 10:38 PM, Song Liu wrote:
> On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Previously, wb_info_pool and wb_list stuffs are introduced
>> to address potential data inconsistence issue for write
>> behind device.
>>
>> Now rename them to serial related name, since the same
>> mechanism will be used to address reorder overlap write
>> issue for raid1.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   drivers/md/md-bitmap.c | 20 ++++++-------
>>   drivers/md/md.c        | 68 ++++++++++++++++++++++--------------------
>>   drivers/md/md.h        | 22 +++++++-------
>>   drivers/md/raid1.c     | 43 +++++++++++++-------------
>>   4 files changed, 78 insertions(+), 75 deletions(-)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index b092c7b5282f..5058716918ef 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -1790,8 +1790,8 @@ void md_bitmap_destroy(struct mddev *mddev)
>>                  return;
>>
>>          md_bitmap_wait_behind_writes(mddev);
> Maybe also rename md_bitmap_wait_behind_writes()?

Perhaps it is a little confusing, but write behind is another thing,
which belongs to bitmap scope.

If write-behind mode is enabled, the above function is called
whether "write-mostly" device has single queue or multi queue,
we only need to consider the potential data inconsistency issue
for the multi queue device, and this patch only renames stuffs
which are used for handle the issue, but we do not want to change
all write behind related things, right?

>
>> -       mempool_destroy(mddev->wb_info_pool);
>> -       mddev->wb_info_pool = NULL;
>> +       mempool_destroy(mddev->serial_info_pool);
>> +       mddev->serial_info_pool = NULL;
>>
>>          mutex_lock(&mddev->bitmap_info.mutex);
>>          spin_lock(&mddev->lock);
>> @@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
>>                  goto out;
>>
>>          rdev_for_each(rdev, mddev)
>> -               mddev_create_wb_pool(mddev, rdev, true);
>> +               mddev_create_serial_pool(mddev, rdev, true);
>>
>>          if (mddev_is_clustered(mddev))
>>                  md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
>> @@ -2475,16 +2475,16 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
>>          if (backlog > COUNTER_MAX)
>>                  return -EINVAL;
>>          mddev->bitmap_info.max_write_behind = backlog;
> Maybe also max_write_behind?

We should not touch it too.

Thanks,
Guoqing
