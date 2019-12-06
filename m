Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E49114EA1
	for <lists+linux-raid@lfdr.de>; Fri,  6 Dec 2019 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLFKCf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Dec 2019 05:02:35 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39505 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLFKCe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 6 Dec 2019 05:02:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id v16so5305235edy.6
        for <linux-raid@vger.kernel.org>; Fri, 06 Dec 2019 02:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=60nk2XIqJsdKQg25ZdPST/dPeGPUkQecpD44mLInZQQ=;
        b=AP4PYsP9fWS+/9m0OHGgslBLTjKYYFAcluS83T5q1q833k8QarRHcyfyG7nJs288h8
         5PeogaaFL7rk/GDoryOgI+v6PvFse1aD5VghPCzd0PpEtxOsgpq05BVeX4mTG4Sjz8HR
         L662g1RF7dF4dvbhLxOP54bHMcBcCAcceVXM0tqaxUPMkp8kfOIoyFb7Wy4vwhuAzAj7
         N7HloTqVtJNzeCaaPKwqxo9064SHns/iLXcqd5I+gZRzkG4nOEYM4gTUMr6JeXUFILXe
         KPzzCVlf0lAo5HFD7xT54DtAL0kXUaHnN/vBp2N3QrC1hpmfWi5vcfCPDWcG4mg2otxr
         qcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=60nk2XIqJsdKQg25ZdPST/dPeGPUkQecpD44mLInZQQ=;
        b=CbS+uINpiNIRdhsmJjz6ANlmCSxwSiq9iGzPHTccPmRVHF21Uqlh9Ym6q6vr2ShGqV
         RONw4zf2PhJUtV1pfEVf+FUVaEfufKA3513e5go3OUY58vzqKmjy5vPYMuCH8U9ulNKn
         GdwIvtPKGOTMXjXqxSgDiTDsHF9caoKAMXOMwggUUEfuB+T4PL0Vxm3P2H+EDyp7hAJR
         a72VB+hLHXVtd72GqX0+Mld4+FsP+zJOrVMrsn48Wsd2zj76Yup+lepKphq2pOSs8VpL
         vXhepA44JoaFD1erXeBBOaAko6jzrrTzPAuRMcuw8NEKREf0a1v/SvHCKOHPXubsofZC
         9gOQ==
X-Gm-Message-State: APjAAAUV8Ey1mD1mtqrkeh2bkbrUPrtnU/+IRCQE7qKSlGBQDQyxxnMu
        LpytRdSFQCytFglRpHdPz/NVeQ==
X-Google-Smtp-Source: APXvYqysjLG8NA71UEhoEtPH9Rm4b0lAMWsys4q6OuOHwGJwQJf8ymLtboncede/kiHZldUrECRV8g==
X-Received: by 2002:a17:906:b6c8:: with SMTP id ec8mr14117706ejb.64.1575626552704;
        Fri, 06 Dec 2019 02:02:32 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:25cd:d110:f7c5:c753? ([2001:1438:4010:2540:25cd:d110:f7c5:c753])
        by smtp.gmail.com with ESMTPSA id u9sm455636edr.4.2019.12.06.02.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 02:02:32 -0800 (PST)
Subject: Re: [PATCH] md/raid1: check whether rdev is null before reference in
 raid1_sync_request func
To:     "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>, neilb@suse.de,
        songliubraving@fb.com, axboe@kernel.dk, yuyufen@huawei.com,
        houtao1@huawei.com, tglx@linutronix.de, nate.dailey@stratus.com,
        song@kernel.org, linux-raid@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>, guiyao@huawei.com
References: <e83c3d31-2deb-9d96-4bec-2db73acb109a@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9f387d93-9e30-055d-47a3-2d22a148d43a@cloud.ionos.com>
Date:   Fri, 6 Dec 2019 11:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e83c3d31-2deb-9d96-4bec-2db73acb109a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/6/19 10:40 AM, liuzhiqiang (I) wrote:
> In raid1_sync_request func, rdev should be checked whether it is null
> before reference.

Do you have real calltrace about it?

> Fixes: 06f603851f("md/raid1: avoid reading known bad blocks during resync")
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>   drivers/md/raid1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a409ab6f30bc..0dea35052efe 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2782,7 +2782,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>   				write_targets++;
>   			}
>   		}
> -		if (bio->bi_end_io) {
> +		if (rdev != NULL && bio->bi_end_io) {
>   			atomic_inc(&rdev->nr_pending);
>   			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
>   			bio_set_dev(bio, rdev->bdev);

If "bio->bi_end_io" is true, I think it implys rdev exists because 
bio->bi_end_io is set
when rdev != NUL.  I don't object to add it to make it explicitly, but 
it is not a fix.

Thanks,
Guoqing
