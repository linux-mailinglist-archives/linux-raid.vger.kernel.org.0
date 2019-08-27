Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483C39E189
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfH0IM5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 04:12:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41107 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbfH0IM4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 27 Aug 2019 04:12:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id w5so30172238edl.8
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=/AnR2xoBf6enZ/Jf+LU1VP0Cq5Y0RC7egKJCSkR8OLA=;
        b=ZfM2KmNoc+c1Le762QaDD/kYdCmbSU7VHsunKyKq9CCmVnPkWzuAh2iIQkJ1ZHK6n3
         uLS9UmfxpmXcbPp+l+cF4gi9r/RLKN9xVORvvSjyGJgQwNgMyxrhSrueyJNbw9DWD0Et
         lzpGNlRLcVu1GfriOTjz/25Tx7/n0I+Lo9uqKBqNLBGi2WuGne7R46WYM0FVm3NZsDFN
         vzHL5Qynp77XNCi0/u8gTZLZT5XY7vQYlpr5m5gX+7yQuPzQ1ldwnsftCezQlbxFnhSO
         CyVj8kF50ev25xeDrN7TqRy8HCCUpK2jToKH4jc5Yfz5vWueCGGVZC0a2/H7qPST4/Rn
         mwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/AnR2xoBf6enZ/Jf+LU1VP0Cq5Y0RC7egKJCSkR8OLA=;
        b=brJd2nW7qtZNPa901d3EkoQhK//EfPfyMiONNLEqg9xbIfiHhLMH/3pMV0fx6L9VP3
         Jj6gz/3hVXSpM+5jshKjCMoA+sUHTaBDhhkFDPup4hdCq9aUqt4QaOWssHBTpb9ZaZay
         FZspZ/5Xi60jRmJuhl56gMEHLDHc8eVESmkPONiSBj6WA2GWC1Igzg4BsxFklpFp0/ph
         EnkJd7y218x4XGfH6HWT7wd/m1/uQl8hWNHHgxTZDMFRq3MtepETdFVopquVNqxnDl1i
         BrbV0FaoF8dq/BLi6jEHdEKpU6rW++yDpmR82r/r4Zn9bx1ejJ7faPsW/DT9iviCHMUD
         rkHg==
X-Gm-Message-State: APjAAAWeN9KH6m59yuGub2zoXL1/d9Ld4ACVMA6A4DzzDyDW9ciF4o2w
        rmT0xRUDMHAV5GutvmIWysiGVsQ2GQo=
X-Google-Smtp-Source: APXvYqxjcmwI2d/kuRfuZvOcWQGHW45iisFE1GyKRhLuxkbIhYILTZLwNufMO+Fetw+YUNy8REeNQw==
X-Received: by 2002:a50:ee88:: with SMTP id f8mr23046402edr.290.1566893574776;
        Tue, 27 Aug 2019 01:12:54 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2066:ee3:46b:72eb? ([2001:1438:4010:2540:2066:ee3:46b:72eb])
        by smtp.gmail.com with ESMTPSA id g20sm1794766edp.92.2019.08.27.01.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:12:53 -0700 (PDT)
Subject: Re: [PATCH] raid5: fix spelling mistake \"bion\" -> \"bios\"
To:     Shuning Zhang <sunny.s.zhang@oracle.com>,
        linux-raid@vger.kernel.org
References: <1566875864-5386-1-git-send-email-sunny.s.zhang@oracle.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <3658318d-0c75-7afb-9629-9a5135e3149e@cloud.ionos.com>
Date:   Tue, 27 Aug 2019 10:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566875864-5386-1-git-send-email-sunny.s.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 8/27/19 5:17 AM, Shuning Zhang wrote:
> There is a spelling mistake in raid5, fix it.
>
> Signed-off-by: Shuning Zhang <sunny.s.zhang@oracle.com>
> ---
>   drivers/md/raid5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 3de4e13..2a33b13 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -3189,7 +3189,7 @@ schedule_reconstruction(struct stripe_head *sh, struct stripe_head_state *s,
>   }
>   
>   /*
> - * Each stripe/dev can have one or more bion attached.
> + * Each stripe/dev can have one or more bios attached.
>    * toread/towrite point to the first in a chain.
>    * The bi_next chain must be in order.
>    */

Please see the link.

https://marc.info/?l=linux-kernel&m=143037808730977&w=2

Thanks,
Guoqing
