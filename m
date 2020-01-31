Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6114F0C9
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jan 2020 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgAaQn6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jan 2020 11:43:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40026 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgAaQn5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 31 Jan 2020 11:43:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so2945008plp.7
        for <linux-raid@vger.kernel.org>; Fri, 31 Jan 2020 08:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cFe8Eqv6F2e8Cil04q6OUNwZreZYlO33+45ii99RlU=;
        b=hBEWGGHmXb9LA1xxk+DtDb/ku6ceXNZbpnS0kaQnoE77Otz+DEGBpTHsIpFy5BhDWi
         GlA+36+y07ZyTUunTz09f09hiFyb/1O40Z/krF6nMk811uPndgLtx5nqcUoSDwVQn/Jb
         bgLXkWpPgNQ7YoWKBwL+t6GH7ZhyQyCZz10YeZSPCgklbxa0gC0gX3g1dmCIEJdUrGxM
         t9JYeu/Kwzx1EP9jNsnWGqTZunaTfkeaV89EFVcr89MiXT3YH+xonW5TD/wzGZwAKwsF
         4cUSDtLNynYJG3l/NPHs+9/aQp3PpNsEyvuvAhunJ+n2JIOcKi3qTsZyMcTpMOUysMvD
         37jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cFe8Eqv6F2e8Cil04q6OUNwZreZYlO33+45ii99RlU=;
        b=cL692M1dmzTGT7DRNIpBEXpQiJ6qoQt8So73mSpv7ST+CvvkfjjpdcDwQhi0tf6PQb
         nfyx8wzeVEG/6Pshti19zoIGEgXSby625xcwTM+p3scqXHA7bApYKK1ycOQkvIIVwC3U
         mOTUEkD8HC5W9MLbchjffz6Dp9PeBMWHdutA7hfgTLtvDFJ9LUiBRTMhP+K37jbaidqo
         485PJC323GJ7RmJfvGlXtuqnSZBeOYeur799iqp0k8yPfhhi3994I0rt2vWJFzjBRvEa
         ofyLsPCqSIFgHyfwwQn7fb/6nEfeV67c29bWbdxLYAIALdQI7mUZkFFLkcEJqa4jrR1S
         XYbA==
X-Gm-Message-State: APjAAAXjGwzDIcV4YxVOgbXJN8XSt6ZAplS3oGpxA4YipOyCR4aUPS6M
        Nuo8kow336Xf/Sb3mA7JDUQeYw==
X-Google-Smtp-Source: APXvYqyKdNKGcifV5nwC4lokBycHA7qyM0xYXqU63ZsKTPExGlSNJ8Qur7Eqvvwk2DVfi2i0BdwLHA==
X-Received: by 2002:a17:902:7b94:: with SMTP id w20mr11014238pll.257.1580489036255;
        Fri, 31 Jan 2020 08:43:56 -0800 (PST)
Received: from [0.0.0.0] ([2001:1438:4010:2540:248f:cf92:4086:6c4e])
        by smtp.gmail.com with ESMTPSA id 100sm11478528pjo.17.2020.01.31.08.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 08:43:55 -0800 (PST)
Subject: Re: [PATCH] md: optimize barrier usage for Rmw atomic bitops
To:     Davidlohr Bueso <dave@stgolabs.net>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200129181437.25155-1-dave@stgolabs.net>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a7358719-55af-6510-952e-df8f202f1ab9@cloud.ionos.com>
Date:   Fri, 31 Jan 2020 17:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129181437.25155-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/29/20 7:14 PM, Davidlohr Bueso wrote:
> For both set and clear_bit, we can avoid the unnecessary barrier
> on non LL/SC architectures, such as x86. Instead, use the
> smp_mb__{before,after}_atomic() calls.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>   drivers/md/md.c     | 2 +-
>   drivers/md/raid10.c | 7 ++++---
>   drivers/md/raid5.c  | 9 +++++----
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4824d50526fa..4ed2eb6933f7 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2561,7 +2561,7 @@ static bool set_in_sync(struct mddev *mddev)
>   			 * Ensure ->in_sync is visible before we clear
>   			 * ->sync_checkers.
>   			 */
> -			smp_mb();
> +			smp_mb__before_atomic();
>   			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
>   			sysfs_notify_dirent_safe(mddev->sysfs_state);
>   		}
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index ec136e44aef7..1993a1958c75 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1865,9 +1865,10 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   		/* We must have just cleared 'rdev' */
>   		p->rdev = p->replacement;
>   		clear_bit(Replacement, &p->replacement->flags);
> -		smp_mb(); /* Make sure other CPUs may see both as identical
> -			   * but will never see neither -- if they are careful.
> -			   */
> +		/* Make sure other CPUs may see both as identical
> +		 * but will never see neither -- if they are careful.
> +		 */

Since we are here, it is better to change the comment style to

/*
  * ...
  */

> +		smp_mb__after_atomic();
>   		p->replacement = NULL;
>   	}
>   
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index ba00e9877f02..3ad6209287cf 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -364,7 +364,7 @@ static int release_stripe_list(struct r5conf *conf,
>   		int hash;
>   
>   		/* sh could be readded after STRIPE_ON_RELEASE_LIST is cleard */
> -		smp_mb();
> +		smp_mb__before_atomic();
>   		clear_bit(STRIPE_ON_RELEASE_LIST, &sh->state);
>   		/*
>   		 * Don't worry the bit is set here, because if the bit is set
> @@ -7654,9 +7654,10 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   		/* We must have just cleared 'rdev' */
>   		p->rdev = p->replacement;
>   		clear_bit(Replacement, &p->replacement->flags);
> -		smp_mb(); /* Make sure other CPUs may see both as identical
> -			   * but will never see neither - if they are careful
> -			   */

Ditto.

Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks,
Guoqing
