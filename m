Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EE023B8EC
	for <lists+linux-raid@lfdr.de>; Tue,  4 Aug 2020 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgHDKkX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 4 Aug 2020 06:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHDKkW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 4 Aug 2020 06:40:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C63AC06174A
        for <linux-raid@vger.kernel.org>; Tue,  4 Aug 2020 03:40:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so15063008eds.10
        for <linux-raid@vger.kernel.org>; Tue, 04 Aug 2020 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FM8JJYK+qBxJnc8/UmF8NvAbr5BBXYkB5tYvw/juSbs=;
        b=QBGjDTy7dXfN7Y439bXKTZEi5rOF5e4oqqAIxe0BMubn03iOjAh6my0WURinxnSLkr
         u2APXR//XBXrs0dqtWM9hIcE2Fqppd9OsiQw4qlULWR1BLS9mP0Zrm52YNbybkrpWLAF
         SNudNVvz3tnRB1Q/lkf0sf5lCwjhZVPiA5g25gnbGuhr36uRuhzQ3DJcOUVSyVLSioMx
         n0gHHmYoUrCPGX4wjxS3vu3+sMPcdgZ4gBsUkAMapGkQlkfFcW+Vnrs+aWd/F7aNv+TM
         9/QMINlyTS/ZM+KYGCDEtzoTtI4jtvWSgj32tlV7/iz10ptNMFy1BiotYZ4k7WHlbb+o
         bngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FM8JJYK+qBxJnc8/UmF8NvAbr5BBXYkB5tYvw/juSbs=;
        b=L1xm20Rvu81uOjmSIlYJE9hxalHLesVU3oX8w/HVjnl+1MuSNBoFu15GOMaEUfI2cw
         dmtpYmz1lLOu7dxxP87tyGDc6urMF4WA20vtFE5q7u9UmGUbxPZS7UtYj5CwJ6KxWTLc
         pZXAjURc7Gz4pvtbWwDXiw1rD/afRuUG/iKabm8Yql4tv3ri4wFGf5FLHZzVqVj9Z9yr
         blafQmwNue3Wgxtww71KTsYpQ/OP4BC6DUjiXvkdUc1AoJy7QA48s5mGgbyCxHYu/lxz
         t7WzDv15nRB9hy8zM0dd3smlRXr308jocAA7BoJcU5IyJrVnoPg/H3cMn6fG3AHCiDlK
         2c+A==
X-Gm-Message-State: AOAM532GlzHWPd/VTqnYCLBcKlaBvtcVNG+sH6LWsrgNwMajjneXPFj/
        zlpPxhe6MZHybm7RSRcIUidVzw==
X-Google-Smtp-Source: ABdhPJxfOV2eduhzOiDg6vGAY77Q2gtIYl/znxoFXkKJ/qA/Ptm1RyuR7tZDjWI1v9d3r7jVUhZZQg==
X-Received: by 2002:aa7:c64e:: with SMTP id z14mr1032325edr.368.1596537621083;
        Tue, 04 Aug 2020 03:40:21 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:118f:4f8c:3890:68c8? ([2001:1438:4010:2540:118f:4f8c:3890:68c8])
        by smtp.gmail.com with ESMTPSA id o16sm18458350ejj.106.2020.08.04.03.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 03:40:20 -0700 (PDT)
Subject: Re: [PATCH] md-cluster: Fix potential error pointer dereference in
 resize_bitmaps()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@fb.com>, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200804101645.GB392148@mwanda>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <824849e0-c98d-1f22-817c-7a76d3ee22b1@cloud.ionos.com>
Date:   Tue, 4 Aug 2020 12:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804101645.GB392148@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 8/4/20 12:16 PM, Dan Carpenter wrote:
> The error handling calls md_bitmap_free(bitmap) which checks for NULL
> but will Oops if we pass an error pointer.  Let's set "bitmap" to NULL
> on this error path.
>
> Fixes: afd756286083 ("md-cluster/raid10: resize all the bitmaps before start reshape")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/md/md-cluster.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 73fd50e77975..d50737ec4039 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -1139,6 +1139,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
>   		bitmap = get_bitmap_from_slot(mddev, i);
>   		if (IS_ERR(bitmap)) {
>   			pr_err("can't get bitmap from slot %d\n", i);
> +			bitmap = NULL;
>   			goto out;
>   		}
>   		counts = &bitmap->counts;

Thanks for the catch, Reviewed-by: Guoqing Jiang 
<guoqing.jiang@cloud.ionos.com>

BTW, seems there could be memory leak in the function since it keeps 
allocate bitmap
in the loop ..., will send a format patch.


diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 73fd50e77975..89d7b32489d8 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1165,6 +1165,8 @@ static int resize_bitmaps(struct mddev *mddev, 
sector_t newsize, sector_t oldsiz
                          * can't resize bitmap
                          */
                         goto out;
+
+               md_bitmap_free(bitmap);
         }

         return 0;

Thanks,
Guoqing
