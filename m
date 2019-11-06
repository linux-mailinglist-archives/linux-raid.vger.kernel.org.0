Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02458F133C
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfKFKEI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 05:04:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37341 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKFKEH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 05:04:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id k14so9953523eds.4
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GjSb+MPaHl+LAPkArjuh1QjLIE9vLd4jbx3GbtTwjtY=;
        b=UTu9yj5qMxamtgFXUVAKm3GfscljJzuvVP3PWhsqMjr/DS17UiWu30/SC9oR0KBGMC
         5owzAlj06E7NXg/kT0FXuSq67ywmfeXMckD0PlAGQYom4J0lUcddede6fZQjh7bi/5gq
         mNU8/58rzT23eHeCHec/jPaHhHRj7hLLOY9isDIIUVm4LDDnaosnVQY351dhFDinQfnP
         5nijNJtvjlg2OkgGShPlIMgNa6GBbMINOOnYE5wZ+d7/Eaueby3m8sZAELAHOLp4MST2
         3Il/eJYYvoPoJkCY4nE1dRlfkOZXfkUh9aJqGE3JNEUTUlZ1F0cCHQlBFyeghpJlkSOC
         dNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GjSb+MPaHl+LAPkArjuh1QjLIE9vLd4jbx3GbtTwjtY=;
        b=JoL6fd+kSozfq4vZri46ZU6bYFV83x4ILZw8Ilmxr64XUdxzkUcZbp30GZmj5DKf2w
         q9JBDZeo1TFrBQnRQDNryNXIEV/dHIx2t+YyoK0OU6xgzjlkEAy4fIe2AYU5EW1ViI91
         H71nSde+9L6u4BVQgK9NyDqM/e9ucqeMq5EgsJolWk6jYCfgLRffnnJ5Ex5w2aVGOxUc
         GNPM/YeZ4atuw3tb8TliP2FTYAI8rruLgZwR1yLnVEt2VviJjp134hCAGHZRkzN5UWC+
         KlgsdPJIXO9Sz2q7tuUvSf1IL+zYJzK3cYukVrJgJlwtrq2/2xiDAHvpbaY1XO2u4ANL
         3P5A==
X-Gm-Message-State: APjAAAWVsys9LcBBk8oQ2ObJFHGM+hYJ/GJaRpxM7fqB+ytoEQchU+Uy
        cVinXMXStkA3vzXAYM2TMiOZh6JIFOqEYA==
X-Google-Smtp-Source: APXvYqyZ42AV+xSaDAolLSHcBAXfq8mYDDT9CgmYDVSWfFsk6pc0K++AOWH9CCbXm99dNbXq6vr4Qw==
X-Received: by 2002:a17:907:110f:: with SMTP id qu15mr11417544ejb.179.1573034644376;
        Wed, 06 Nov 2019 02:04:04 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1c1:e73c:e916:21a0? ([2001:1438:4010:2540:1c1:e73c:e916:21a0])
        by smtp.gmail.com with ESMTPSA id f13sm104144eds.72.2019.11.06.02.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:04:03 -0800 (PST)
Subject: Re: [PATCH 2/8] md: add is_force parameter for some funcs
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-3-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW7MwTvWzDr6voTS92chTm-Znwy74pjyF1=cpXcj27_A3w@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <dd801115-92b5-85a4-ae6b-504ed888c2e0@cloud.ionos.com>
Date:   Wed, 6 Nov 2019 11:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7MwTvWzDr6voTS92chTm-Znwy74pjyF1=cpXcj27_A3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/5/19 10:56 PM, Song Liu wrote:
> On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> The related resources (spin_lock, list and waitqueue) are needed
>> for address raid1 reorder overlap issue too, so add "is_force"
>> parameter to funcs (mddev_create/destroy_serial_pool).
> I don't think is_force is a good name. Maybe just call it "force"?

Naming is difficult to me :-), I can change it if you wish.

>> This parameter is set to true if we want to enable or disable
>> raid1 io serialization by writinng sysfs node (in later patch),
>> rdevs_init_serial is added and called when io serialization is
>> enabled.
>>
>> Also rdev_init_serial and clear_bit(CollisionCheck, &rdev->flags)
>> should be called between suspend and resume.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   drivers/md/md-bitmap.c |  4 +--
>>   drivers/md/md.c        | 64 ++++++++++++++++++++++++++++--------------
>>   drivers/md/md.h        |  2 +-
>>   3 files changed, 46 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index 5058716918ef..eff297cf5a81 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
>>                  goto out;
>>
>>          rdev_for_each(rdev, mddev)
>> -               mddev_create_serial_pool(mddev, rdev, true);
>> +               mddev_create_serial_pool(mddev, rdev, true, false);
>>
>>          if (mddev_is_clustered(mddev))
>>                  md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
>> @@ -2484,7 +2484,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
>>                  struct md_rdev *rdev;
>>
>>                  rdev_for_each(rdev, mddev)
>> -                       mddev_create_serial_pool(mddev, rdev, false);
>> +                       mddev_create_serial_pool(mddev, rdev, false, false);
>>          }
>>          if (old_mwb != backlog)
>>                  md_bitmap_update_sb(mddev->bitmap);
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index bbf10b9301b6..43b7da334e4a 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -127,9 +127,6 @@ static inline int speed_max(struct mddev *mddev)
>>
>>   static int rdev_init_serial(struct md_rdev *rdev)
>>   {
>> -       if (rdev->bdev->bd_queue->nr_hw_queues == 1)
>> -               return 0;
>> -
>>          spin_lock_init(&rdev->serial_list_lock);
>>          INIT_LIST_HEAD(&rdev->serial_list);
>>          init_waitqueue_head(&rdev->serial_io_wait);
>> @@ -138,17 +135,27 @@ static int rdev_init_serial(struct md_rdev *rdev)
>>          return 1;
>>   }
>>
>> +static void rdevs_init_serial(struct mddev *mddev)
>> +{
>> +       struct md_rdev *rdev;
>> +
>> +       rdev_for_each(rdev, mddev)
>> +               rdev_init_serial(rdev);
>> +}
>> +
>>   /*
>> - * Create serial_info_pool if rdev is the first multi-queue device flaged
>> - * with writemostly, also write-behind mode is enabled.
>> + * Create serial_info_pool for raid1 under conditions:
>> + * 1. rdev is the first multi-queue device flaged with writemostly,
>> + *    also write-behind mode is enabled.
>> + * 2. is_force is true which means we want to enable serialization
>> + *    for normal raid1 array.
>>    */
>>   void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>> -                         bool is_suspend)
>> +                             bool is_suspend, bool is_force)
>>   {
>> -       if (mddev->bitmap_info.max_write_behind == 0)
>> -               return;
>> -
>> -       if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_serial(rdev))
>> +       if (!is_force && (mddev->bitmap_info.max_write_behind == 0 ||
>> +                         (rdev && (rdev->bdev->bd_queue->nr_hw_queues == 1 ||
>> +                                   !test_bit(WriteMostly, &rdev->flags)))))
>>                  return;
>>
>>          if (mddev->serial_info_pool == NULL) {
>> @@ -156,6 +163,10 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>>
>>                  if (!is_suspend)
>>                          mddev_suspend(mddev);
>> +               if (is_force)
>> +                       rdevs_init_serial(mddev);
>> +               if (!is_force && rdev)
>> +                       rdev_init_serial(rdev);
>>                  noio_flag = memalloc_noio_save();
>>                  mddev->serial_info_pool =
>>                          mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
>> @@ -171,11 +182,13 @@ EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
>>
>>   /*
>>    * Destroy serial_info_pool if rdev is the last device flaged with
>> - * CollisionCheck.
>> + * CollisionCheck, or is_force is true when we disable serialization
>> + * for normal raid1.
>>    */
>> -static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
>> +static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>> +                                     bool is_force)
> I guess mddev_destroy_serial_pool() doesn't need an extra argument. We
> can just to clear_bit, etc.. no?

Let me explain a little bit, the function are used in below cases:

1. write-behind mode is enabled and write-mostly device has multi queues,
the pool should be destroyed if the last device flagged with CollisionCheck
is removed from array, or the write-mostly flag will be cleared from the 
last
device.

2. if we want to enable/disable serialization for normal raid1 in later 
patch,
which means the pool could be created/destroyed whether bitmap is existed
or not, and all member device should be flagged with CollisionCheck.

The new argument is introduced to distinguish the two cases.

Thanks,
Guoqing
