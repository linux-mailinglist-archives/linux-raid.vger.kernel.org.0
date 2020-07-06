Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47592215675
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jul 2020 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgGFLeL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jul 2020 07:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgGFLeL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jul 2020 07:34:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C0C061794
        for <linux-raid@vger.kernel.org>; Mon,  6 Jul 2020 04:34:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so15749817eja.9
        for <linux-raid@vger.kernel.org>; Mon, 06 Jul 2020 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8L9YbdV2gTN3F4Po/dxxMwSZK6lj/orvKl9FMQpkTxY=;
        b=Y0jnbDVhbJhmEE2/cNt+n4L+TQ/xm/oGdmBQSuB00HGcpww5GWhInND8PXZ0WUxaKm
         MeamaYRRU1IQ+qE29zRkWpUexNu6GuEk5HVHMt+UyMVwu7RKN39J5JbNsreXTNt/X7lX
         W3kfj1Blhi63m0489cJmPJ/5PiIzrukt46blBp+AV8thFqPVd1vGIBRh0rrXMuhLm2Mb
         An5b1JomVo3eMZHB8tiC92xlPFmIJP/f4SxKObPoxsHwHRIu7AYHw/hR+10RVQVJo5cx
         ANkoNRtTs5KGLIQp9CMTva480G8C6nwrO007czoYjaJH0rUPttvZJt1vKm7SP36XW3PP
         b9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8L9YbdV2gTN3F4Po/dxxMwSZK6lj/orvKl9FMQpkTxY=;
        b=B/DV8W9EWZ533ZoAzNR4jXxrhJeM1N7eA/5Uf+l1vYF5PzTpWuLsucZ0IyzGnrzwGa
         yfsX+rEVNAhBIwWAcyf7bm4Xzl6ex6vABhuxvnxR814olLHRreqvwYw2QAWauem0PG8U
         EG+DG2utI/bgDRYVmE2wXOpeg626et7jEB9YIOpjbt5XFEQHw1KvzfD44S3FH23wjuDI
         UWEn4Qs+thPYtnzyJLxBNGtTnQEXRdkozma/JExpDzFpckF9T4krTPQhiXYUuxLbsndp
         Wv/FJVUGWK6D+oZzpdNkJhCIIhQpOA5W4r+uuCmVAUUNw647VofE10x4lSNfNcIWJFQs
         ZGKw==
X-Gm-Message-State: AOAM532yJmth4+gwFML6WNngcSbbkDnZstJjEQOZCA7nFv1qArxVwk2P
        YhnlCpVXXNYYhDdoWuApEZaXVw==
X-Google-Smtp-Source: ABdhPJy4dvvokNsVYgILg/nDSdYIrU9KZA4oPYn6W1w0VVj87UWMKIPTkQZUDdZBbQzaOzvkw+H3kg==
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr42522385ejc.1.1594035249227;
        Mon, 06 Jul 2020 04:34:09 -0700 (PDT)
Received: from ?IPv6:2001:16b8:485d:8000:587:bfc1:3ea4:c2f6? ([2001:16b8:485d:8000:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id i2sm3179083ejp.114.2020.07.06.04.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 04:34:08 -0700 (PDT)
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com, houtao1@huawei.com
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <20200702120628.777303-2-yuyufen@huawei.com>
 <84277307-fc0a-44e2-8564-699651a7ff47@cloud.ionos.com>
Message-ID: <0f99d3f6-ae4e-548d-93c1-32ef4b9d2473@cloud.ionos.com>
Date:   Mon, 6 Jul 2020 13:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <84277307-fc0a-44e2-8564-699651a7ff47@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/6/20 11:09 AM, Guoqing Jiang wrote:
> On 7/2/20 2:06 PM, Yufen Yu wrote:
>> @@ -2509,10 +2532,11 @@ static void raid5_end_read_request(struct bio 
>> * bi)
>>                */
>>               pr_info_ratelimited(
>>                   "md/raid:%s: read error corrected (%lu sectors at 
>> %llu on %s)\n",
>> -                mdname(conf->mddev), STRIPE_SECTORS,
>> +                mdname(conf->mddev),
>> +                conf->stripe_sectors,
>
> The conf->stripe_sectors is printed with %lu format.
>
>> ot allow a suitable chunk size */
>>           return ERR_PTR(-EINVAL);
>>   diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
>> index f90e0704bed9..e36cf71e8465 100644
>> --- a/drivers/md/raid5.h
>> +++ b/drivers/md/raid5.h
>> @@ -472,32 +472,12 @@ struct disk_info {
>>    */
>>     #define NR_STRIPES        256
>> -#define STRIPE_SIZE        PAGE_SIZE
>> -#define STRIPE_SHIFT        (PAGE_SHIFT - 9)
>> -#define STRIPE_SECTORS        (STRIPE_SIZE>>9)
>>   #define    IO_THRESHOLD        1
>>   #define BYPASS_THRESHOLD    1
>>   #define NR_HASH            (PAGE_SIZE / sizeof(struct hlist_head))
>>   #define HASH_MASK        (NR_HASH - 1)
>>   #define MAX_STRIPE_BATCH    8
>
> [...]
>
>>     return NULL;
>> -}
>> -
>>   /* NOTE NR_STRIPE_HASH_LOCKS must remain below 64.
>>    * This is because we sometimes take all the spinlocks
>>    * and creating that much locking depth can cause
>> @@ -574,6 +554,9 @@ struct r5conf {
>>       int            raid_disks;
>>       int            max_nr_stripes;
>>       int            min_nr_stripes;
>> +    unsigned int    stripe_size;
>> +    unsigned int    stripe_shift;
>> +    unsigned int    stripe_sectors;
>
> So you need to define it with "unsigned long".
>
> Also, I am wondering if it is cleaner with something like below.
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8dea4398b191..984eea97e77c 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6918,6 +6918,7 @@ static struct r5conf *setup_conf(struct mddev 
> *mddev)
>         conf = kzalloc(sizeof(struct r5conf), GFP_KERNEL);
>         if (conf == NULL)
>                 goto abort;
> +       r5conf_set_size(conf, PAGE_SIZE);
>         INIT_LIST_HEAD(&conf->free_list);
>         INIT_LIST_HEAD(&conf->pending_list);
>         conf->pending_data = kcalloc(PENDING_IO_MAX,
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index f90e0704bed9..04fc4c514d54 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -471,10 +471,13 @@ struct disk_info {
>   * Stripe cache
>   */
>
> +static unsigned long stripe_size = PAGE_SIZE;
> +static unsigned long stripe_shift = PAGE_SHIFT - 9;
> +static unsigned long stripe_sectors = PAGE_SIZE>>9;
>  #define NR_STRIPES             256
> -#define STRIPE_SIZE            PAGE_SIZE
> -#define STRIPE_SHIFT           (PAGE_SHIFT - 9)
> -#define STRIPE_SECTORS         (STRIPE_SIZE>>9)
> +#define STRIPE_SIZE            stripe_size
> +#define STRIPE_SHIFT           stripe_shift
> +#define STRIPE_SECTORS         stripe_sectors
>  #define        IO_THRESHOLD            1
>  #define BYPASS_THRESHOLD       1
>  #define NR_HASH                        (PAGE_SIZE / sizeof(struct 
> hlist_head))
> @@ -574,6 +577,9 @@ struct r5conf {
>         int                     raid_disks;
>         int                     max_nr_stripes;
>         int                     min_nr_stripes;
> +       unsigned long           stripe_size;
> +       unsigned long           stripe_shift;
> +       unsigned long           stripe_sectors;
>
>         /* reshape_progress is the leading edge of a 'reshape'
>          * It has value MaxSector when no reshape is happening
> @@ -690,6 +696,12 @@ struct r5conf {
>         struct r5pending_data   *next_pending_data;
>  };
>
> +static inline void r5conf_set_size(struct r5conf *conf, unsigned long 
> size)
> +{
> +       stripe_size = conf->stripe_size = size;
> +       stripe_shift = conf->stripe_shift = ilog2(size) - 9;
> +       stripe_sectors = conf->stripe_sectors = size >> 9;
> +}
>
>  /*
>   * Our supported algorithms

Hmm, I guess it can't support multiple raid5 with different sizes.

Thanks,
Guoqing
