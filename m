Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F327A2813
	for <lists+linux-raid@lfdr.de>; Fri, 15 Sep 2023 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjIOU15 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 Sep 2023 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbjIOU1o (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 Sep 2023 16:27:44 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E1AC
        for <linux-raid@vger.kernel.org>; Fri, 15 Sep 2023 13:27:39 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTP
        id hAPdq8f0XOzKlhFPfqI8sI; Fri, 15 Sep 2023 20:27:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFPeqkBjIxtb5hFPeqfLRu; Fri, 15 Sep 2023 20:27:39 +0000
X-Authority-Analysis: v=2.4 cv=IOERtyjG c=1 sm=1 tr=0 ts=6504be3b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=f5UIiaV4ZOzLQmTLUEEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j3w//0Z46CGNssGNDXKmprOdLy+/NVzaiaJIdMDoPNc=; b=ZmiXgWU0KYg4YC4bYpjMAA1/NB
        HwUpbKzMcCWbUlNaS2U9E/kMDSTXJhlwFuyrzYa1OZC9giqk3rnUWzyhp9I/WKi7lp82MR+D6n/uP
        Fasd1Sr7o3nwJcyESLRYQbabTIRDAfSavwnZ9PUkY7VpcCgAbhkyC5tGln67EbFPGiTOIUWoZu9qt
        Aqn89NJaNK+spuPCTnXvGOuRe9oW73PXpBv5kcYh6FniYN9JJ05YHoriOEF4qy3jz70Lm+QNAwJTd
        xKUkKRBLNgiac7ak9iN+Vj8b+hcTxLyt1GYHL9Fe/kbe9N9KlzC7eBTbgEfuJfdlu+4U+q7CaN4RR
        4bjuQXRg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39180 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFPd-002JVV-2Y;
        Fri, 15 Sep 2023 15:27:37 -0500
Message-ID: <6d98461f-a794-a258-9640-78fa277b6e76@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:28:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] md/md-linear: Annotate struct linear_conf with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915200328.never.064-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200328.never.064-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFPd-002JVV-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39180
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 72
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLE8xnYAe0smw1kzOyttdeb1ougvNJbypsbweVEHwTMKP+GLRjXTWDVm84PX8HdQEaUbwI4YVLiaAoJADAbo4M57BmJ77zCIUOkRRW1MfsFoVh0GoAc4
 vuoiCzJtICfb2Mw69C4o4+s/d6b8K4OMVCffq2H4S4paW2EVv/zzekBBHMdEO8PQB/mHE6LJ+PzQMJFDBarIn5SJf7TWDbspcjuiyIR4c2QAwpjwO9GrtmF0
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 9/15/23 14:03, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct linear_conf.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/md/md-linear.c | 26 +++++++++++++-------------
>   drivers/md/md-linear.h |  2 +-
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 71ac99646827..ae2826e9645b 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -69,6 +69,19 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
>   	if (!conf)
>   		return NULL;
>   
> +	/*
> +	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
> +	 * keep a copy of mddev->raid_disks in struct linear_conf is,
> +	 * mddev->raid_disks may not be consistent with pointers number of
> +	 * conf->disks[] when it is updated in linear_add() and used to
> +	 * iterate old conf->disks[] earray in linear_congested().
> +	 * Here conf->raid_disks is always consitent with number of
> +	 * pointers in conf->disks[] array, and mddev->private is updated
> +	 * with rcu_assign_pointer() in linear_addr(), such race can be
> +	 * avoided.
> +	 */
> +	conf->raid_disks = raid_disks;
> +
>   	cnt = 0;
>   	conf->array_sectors = 0;
>   
> @@ -112,19 +125,6 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
>   			conf->disks[i-1].end_sector +
>   			conf->disks[i].rdev->sectors;
>   
> -	/*
> -	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
> -	 * keep a copy of mddev->raid_disks in struct linear_conf is,
> -	 * mddev->raid_disks may not be consistent with pointers number of
> -	 * conf->disks[] when it is updated in linear_add() and used to
> -	 * iterate old conf->disks[] earray in linear_congested().
> -	 * Here conf->raid_disks is always consitent with number of
> -	 * pointers in conf->disks[] array, and mddev->private is updated
> -	 * with rcu_assign_pointer() in linear_addr(), such race can be
> -	 * avoided.
> -	 */
> -	conf->raid_disks = raid_disks;
> -
>   	return conf;
>   
>   out:
> diff --git a/drivers/md/md-linear.h b/drivers/md/md-linear.h
> index 24e97db50ebb..5587eeedb882 100644
> --- a/drivers/md/md-linear.h
> +++ b/drivers/md/md-linear.h
> @@ -12,6 +12,6 @@ struct linear_conf
>   	struct rcu_head		rcu;
>   	sector_t		array_sectors;
>   	int			raid_disks; /* a copy of mddev->raid_disks */
> -	struct dev_info		disks[];
> +	struct dev_info		disks[] __counted_by(raid_disks);
>   };
>   #endif
