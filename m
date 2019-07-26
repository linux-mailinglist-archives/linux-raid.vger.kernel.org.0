Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB59C762E2
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jul 2019 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGZJ6K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 26 Jul 2019 05:58:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36805 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJ6K (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 26 Jul 2019 05:58:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so52786392edq.3
        for <linux-raid@vger.kernel.org>; Fri, 26 Jul 2019 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1JjNlFQWRSF2b/+oLjPGX3ufBq6RXV/GQGIuv6Klx7k=;
        b=clKyHfUMrokCANV91ZHQtdTNuc5uYMCLf5NuoJ4t3HnZaLhqnps++a2FW/ksu9mKAy
         mdVECNjs50HaFgQkezXve8zLwAlw6YghSGNkxK4YoAmy856JVc7xPb5tbV1+z9kC95Ei
         pBVQHEkmdZeqmayV/j1Mr28noUL7+MD2TLw7nGHMCmG/Fp7n5NYdWfjeKoq6Shkqlsdj
         OAmhkodUgEI2D/m62+kMiL5lU2zc/esHp25n9FpDgOLiW0xvprE86CBk3TRpTuwg4WVq
         0tHknljIqUuWPi0DHX2hemVvcdTz41/3TPJqDcjCkURde8PZXXnsTFjeKdnI92L23MCz
         blEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JjNlFQWRSF2b/+oLjPGX3ufBq6RXV/GQGIuv6Klx7k=;
        b=Ew1MfjmaeB9ShfU4eF/8EBzEPxNAW24q2fNXU7RYRfcKg/MnuBejoh2x+fUq9Fzk9p
         /hR5IqywbaOtI0mRDIQQSH3hr5hY4AqowqjUomzReLQ0nqYkG+zKgy/IzxY++z+Tn73y
         E2z7CRPYAoJcicwcvAasysWXJgymGKSmFbxRxMk+xgGIktjlBjbEBDFNryeVSxnQyI7v
         POPvW+XbbJJWcSdExIbInM81dYPiufPj0A0TQSjZjyLPxCu3VJ68pBdlYL3vYQ2FMdC5
         bN9uH4dKykCIZhCiI5gi/eYdLo5fLJQSh+syitp2YnXKXFQ4avjUAQPXKdCmPlQUFGJk
         g5zw==
X-Gm-Message-State: APjAAAW5AxevCxSGdDDkViRkrKD/9GBTFEpFg33KiOk3FcM+Xg0FRcEU
        irdxG60kNy10W3hIpGObmaJMhDavOCg=
X-Google-Smtp-Source: APXvYqyYVGnrLUka+kk7N1SYGpiKquNQcxkaO8lnVASzGlE5MUNrfDOD5MVGdagx8bJVRTthGJtVgw==
X-Received: by 2002:a17:906:474a:: with SMTP id j10mr73050510ejs.104.1564135088170;
        Fri, 26 Jul 2019 02:58:08 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:8976:de00:6817:8b02? ([2001:1438:4010:2540:8976:de00:6817:8b02])
        by smtp.gmail.com with ESMTPSA id w4sm10066198eja.34.2019.07.26.02.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 02:58:07 -0700 (PDT)
Subject: Re: [PATCH 2/3] md: don't set In_sync if array is frozen
To:     yuyufen <yuyufen@huawei.com>, Guoqing Jiang <jgq516@gmail.com>,
        liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org
References: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
 <20190724090921.13296-3-guoqing.jiang@cloud.ionos.com>
 <42036d10-faf8-69de-e710-c44baac243bb@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f35f5503-172b-4b29-0ade-d5700a58f3e5@cloud.ionos.com>
Date:   Fri, 26 Jul 2019 11:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <42036d10-faf8-69de-e710-c44baac243bb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/26/19 4:47 AM, yuyufen wrote:
> Hi, Guoqing
> 
> 
> On 2019/7/24 17:09, Guoqing Jiang wrote:
>> When a disk is added to array, the following path is called in mdadm.
>>
>> Manage_subdevs -> sysfs_freeze_array
>>                 -> Manage_add
>>                 -> sysfs_set_str(&info, NULL, "sync_action","idle")
>>
>> Then from kernel side, Manage_add invokes the path (add_new_disk ->
>> validate_super = super_1_validate) to set In_sync flag.
>>
>> Since In_sync means "device is in_sync with rest of array", and the new
>> added disk need to resync thread to help the synchronization of data.
>> And md_reap_sync_thread would call spare_active to set In_sync for the
>> new added disk finally. So don't set In_sync if array is in frozen.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   drivers/md/md.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 0ced0933d246..d0223316064d 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -1826,8 +1826,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
>>                   if (!(le32_to_cpu(sb->feature_map) &
>>                         MD_FEATURE_RECOVERY_BITMAP))
>>                       rdev->saved_raid_disk = -1;
>> -            } else
>> -                set_bit(In_sync, &rdev->flags);
>> +            } else {
>> +                /*
>> +                 * If the array is FROZEN, then the device can't
>> +                 * be in_sync with rest of array.
>> +                 */
>> +                if (!test_bit(MD_RECOVERY_FROZEN,
>> +                          &mddev->recovery))
>> +                    set_bit(In_sync, &rdev->flags);
>> +            }
>>               rdev->raid_disk = role;
>>               break;
>>           }
> 
> super_1_validate() set rdev with 'In_sync', while add_new_disk() will clear the flag bit again after 
> that.
> 
>          clear_bit(In_sync, &rdev->flags); /* just to be sure */
> 
> So, I think there is no bad influence without test FROZEN. Am I ignoring anything?

Yes, you are right about it.

Though there is a small time window that the disk could be showed as 'U', I guess it is better to 
reduce the window so we can get the correct status as much as possible.

Thanks,
Guoqing
