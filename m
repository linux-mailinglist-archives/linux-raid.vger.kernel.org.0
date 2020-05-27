Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73301E44AA
	for <lists+linux-raid@lfdr.de>; Wed, 27 May 2020 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbgE0NzB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 May 2020 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbgE0NzA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 27 May 2020 09:55:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941AFC08C5C1
        for <linux-raid@vger.kernel.org>; Wed, 27 May 2020 06:55:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x20so28168776ejb.11
        for <linux-raid@vger.kernel.org>; Wed, 27 May 2020 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mWKxd06OdtRhVL4MZgKeM2W9PRhu4phdDdKOFwiSqGk=;
        b=f0BObvMvX6LmASK7Asr8vsVbjV2iq+jqOnbEhdIVhsBXASv6JWgoZJL4h3LL4j8o5R
         +NeNa2ngwRd07Ln8LaeqpWTI79N/iaxFgaqxyFE5FrGJtPMuiIqtcjJ96NFCJokFYt9f
         1sFWXHhnpBrxlAWzMtpahczmSr4hMwfKUqlIriNCEeuKq5XjORGzGlh5afeMhfPKQG1L
         6ouZVzx5nDeq9ZRD27ejEo12Gz6PDGKknifO6fKEVQqsxj0cwO95n4nKsX5C9T8Hnh8+
         mXbCMFLylRcdMujXZctpZFllagwxxNWB9u0EZALMWDdYp0iBlGKhZBlWxtUIuqxcpi2x
         GD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mWKxd06OdtRhVL4MZgKeM2W9PRhu4phdDdKOFwiSqGk=;
        b=bs37tyrTlmo2vAEEIcaXDWb3QzQAmYsaCaRiXMzYSGyF6sH+G7SyALO2rRBKsU5Y76
         XjJVt+BxRMmm3yjkCs2Mue8BnMeDTbzxaA0AWTsFLjoZZ2uSu5i7dznhAKh/sAfB5Eze
         a0p4OLcrHv0g6J/YGrTR07OO1S5k5gin/YVSlAfftlVc0Otp4tAfhTvhq8EYU6aWV2Ca
         sAaYOCBP3lfzHpmvfkiis1chE+bfmGp2O5EQDrXm+Lx2ilQYr5W95ojDo62BABg9MSzu
         IqjYDtCbkm10M8JKeJBXoLvZR1tbaKzGK+8i7ISOZE6I7EE/JOfqSsKBWgRkosozdGHK
         QLhQ==
X-Gm-Message-State: AOAM530G4tBhZu+c6t9xa3ih0oxTDkzQQJ+oCmarFhRZg2gAToNZBAfB
        CxEe8dywwkRkM/KedC8X18Bsew==
X-Google-Smtp-Source: ABdhPJwYYLG3iki+HKopAHvVTusfiVFSFyeE72JcNo17jvFlf7wfI2YFUA+B/SxKjS2bPn+AcaY1Tw==
X-Received: by 2002:a17:906:b859:: with SMTP id ga25mr6578064ejb.523.1590587699196;
        Wed, 27 May 2020 06:54:59 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48fc:5800:e80e:f5df:f780:7d57? ([2001:16b8:48fc:5800:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id rs25sm2819719ejb.29.2020.05.27.06.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:54:58 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] md/raid5: add CONFIG_MD_RAID456_STRIPE_SHIFT to
 set STRIPE_SIZE
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com, colyli@suse.de,
        xni@redhat.com, houtao1@huawei.com
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <20200527131933.34400-2-yuyufen@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <5fe381f9-e3ce-c2f7-dfac-9f852316b38f@cloud.ionos.com>
Date:   Wed, 27 May 2020 15:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527131933.34400-2-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 5/27/20 3:19 PM, Yufen Yu wrote:
>   +config MD_RAID456_STRIPE_SHIFT
> +	int "RAID4/RAID5/RAID6 stripe size shift"
> +	default "1"
> +	depends on MD_RAID456
> +	help
> +	  When set the value as 'N', stripe size will be set as 'N << 9',
> +	  which is a multiple of 4KB.

If 'N  << 9', then seems you are convert it to sector, do you actually 
mean 'N << 12'?

> +
> +	  The default value is 1, that means the default stripe size is
> +	  4096(1 << 9). Just setting as a bigger value when PAGE_SIZE is
> +	  bigger than 4096. In that case, you can set it as 2(8KB),
> +	  4(16K), 16(64K).

So with the above description, the algorithm should be 2 << 12 = 8KB and 
so on.

> +
> +	  When you try to set a big value, likely 16 on arm64 with 64KB
> +	  PAGE_SIZE, that means, you know size of each io that issued to
> +	  raid device is more than 4096. Otherwise just use default value.
> +
> +	  Normally, using default value can get better performance.
> +	  Only change this value if you know what you are doing.
> +
> +
>   config MD_MULTIPATH
>   	tristate "Multipath I/O support"
>   	depends on BLK_DEV_MD
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index f90e0704bed9..b25f107dafc7 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -472,7 +472,9 @@ struct disk_info {
>    */
>   
>   #define NR_STRIPES		256
> -#define STRIPE_SIZE		PAGE_SIZE
> +#define CONFIG_STRIPE_SIZE	(CONFIG_MD_RAID456_STRIPE_SHIFT << 9)
> +#define STRIPE_SIZE		\
> +	(CONFIG_STRIPE_SIZE > PAGE_SIZE ? PAGE_SIZE : CONFIG_STRIPE_SIZE)

If I am not misunderstand, you need to s/9/12/ above.

Thanks,
Guoqing
