Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191DA212558
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgGBNzZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 09:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgGBNzY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Jul 2020 09:55:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BCC08C5C1
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 06:55:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so29777494ejq.6
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ztmq7h0oJx0WcNaAMzEaPZQyZShySKPhG2+FB12bn+k=;
        b=SZX7HBKWtofFEA4mUwth+YGpzfLVjPa4+7nB5feAju2s7fN2T3sU/6+LxGsilhC8W7
         99i+QUv+ZPRQPdyE+2imnCk6oqNxrzhAKwcMGO3a7+1UvE1aLWAfA81fji8ZGzew/mVX
         xU8dYbPk9tdlduKpmQRsKr2RcImjRT6ikwVTnqbRd2blTdLlVk7bchT96WrPsXu6UbuM
         Vn+BfGGAWgMzJGZBS9C4TRkguWDOJJJ2/rif+c92R2E1z3AHur/azFS0m2f45o2zxk0G
         ZC+HK7lTZkd8/wdYShmUMl3+eByoRbCa2g9P2N4b9EHOzNftJB6ugEiZxmLi8xOfVSTp
         JHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ztmq7h0oJx0WcNaAMzEaPZQyZShySKPhG2+FB12bn+k=;
        b=mm6GdM6R/6oCorW9TYLPtFJY4rcu9XUDw8A/i82zE3dTqUSE+npd2ajYvieQBPNqa3
         VeXgh0oMmnGbcrD5rnho5hhSIZcT4aR0kigE24xBuhhaiCicJ/dAl++iHU2NJ12X8PdM
         9i37Oqw2p73xZ4Occ8OJMGhMY5FnEXBw2BwvLDAVP9UT8mTR568x1P5bsijcMWxr8Adt
         Gm/PdIBS3k/RuylPgPQqtadE51lUeFmxbgBNlkTesmqk2o33EADwe/wuQL1FW5WfjO0E
         nZqa98PSTgA/ENC+iRhL0WB0hjwOyr4zEt//NkuCKtUHrwbJS8sDYf1EmR2mBWBN71nT
         MKyA==
X-Gm-Message-State: AOAM533TjPX+SKy09PgVAcMaPLCL+IIaidytHNvPpjXFEidXAyJ8rCIN
        UtlLbQ/21+HLC4CuzJ121tc6Z1jm5+tzkQbT
X-Google-Smtp-Source: ABdhPJyozG6SPY18uqMrg6bzp53yzoBQ5AR/hcqFndv6xF4Ei3aBlzQheeYuBVNBw2UDkrJGu2tN0g==
X-Received: by 2002:a17:906:7746:: with SMTP id o6mr28495599ejn.75.1593698123059;
        Thu, 02 Jul 2020 06:55:23 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2968:e1c0:a871:b69c? ([2001:1438:4010:2540:2968:e1c0:a871:b69c])
        by smtp.gmail.com with ESMTPSA id t21sm6853595ejr.68.2020.07.02.06.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:55:22 -0700 (PDT)
Subject: Re: [PATCH v2] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20200702105440.17097-1-artur.paszkiewicz@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <c2579e84-dc89-68fe-f6fc-81ad80d3f3ee@cloud.ionos.com>
Date:   Thu, 2 Jul 2020 15:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702105440.17097-1-artur.paszkiewicz@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/2/20 12:54 PM, Artur Paszkiewicz wrote:
> Use generic io accounting functions to manage io stats. There was an
> attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
> stats accounting functions to simplify io stat accounting"), but it did
> not include a call to generic_end_io_acct() and caused issues with
> tracking in-flight IOs, so it was later removed in commit 74672d069b29
> ("md: fix md io stats accounting broken").
>
> This patch attempts to fix this by using both bio_start_io_acct() and
> bio_end_io_acct(). To make it possible, a struct md_io is allocated for
> every new md bio, which includes the io start_time. A new mempool is
> introduced for this purpose. We override bio->bi_end_io with our own
> callback and call bio_start_io_acct() before passing the bio to
> md_handle_request(). When it completes, we call bio_end_io_acct() and
> the original bi_end_io callback.
>
> This adds correct statistics about in-flight IOs and IO processing time,
> interpreted e.g. in iostat as await, svctm, aqu-sz and %util.
>
> It also fixes a situation where too many IOs where reported if a bio was
> re-submitted to the mddev, because io accounting is now performed only
> on newly arriving bios.
>
> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> ---
> v2:
> - Just override the bi_end_io without having to clone the original bio.
> - Rebased onto latest md-next.
>
>   drivers/md/md.c | 56 ++++++++++++++++++++++++++++++++++++++-----------
>   drivers/md/md.h |  1 +
>   2 files changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8bb69c61afe0..25dd3f4116c3 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -463,12 +463,33 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
>   }
>   EXPORT_SYMBOL(md_handle_request);
>   
> +struct md_io {
> +	struct mddev *mddev;
> +	bio_end_io_t *orig_bi_end_io;
> +	void *orig_bi_private;
> +	unsigned long start_time;
> +};
> +
> +static void md_end_io(struct bio *bio)
> +{
> +	struct md_io *md_io = bio->bi_private;
> +	struct mddev *mddev = md_io->mddev;
> +
> +	bio_end_io_acct(bio, md_io->start_time);
> +
> +	bio->bi_end_io = md_io->orig_bi_end_io;
> +	bio->bi_private = md_io->orig_bi_private;
> +
> +	mempool_free(md_io, &mddev->md_io_pool);
> +
> +	if (bio->bi_end_io)
> +		bio->bi_end_io(bio);
> +}
> +
>   static blk_qc_t md_submit_bio(struct bio *bio)
>   {
>   	const int rw = bio_data_dir(bio);
> -	const int sgrp = op_stat_group(bio_op(bio));
>   	struct mddev *mddev = bio->bi_disk->private_data;
> -	unsigned int sectors;
>   
>   	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
>   		bio_io_error(bio);
> @@ -488,21 +509,26 @@ static blk_qc_t md_submit_bio(struct bio *bio)
>   		return BLK_QC_T_NONE;
>   	}
>   
> -	/*
> -	 * save the sectors now since our bio can
> -	 * go away inside make_request
> -	 */
> -	sectors = bio_sectors(bio);
> +	if (bio->bi_end_io != md_end_io) {
> +		struct md_io *md_io;
> +
> +		md_io = mempool_alloc(&mddev->md_io_pool, GFP_NOIO);
> +		md_io->mddev = mddev;
> +		md_io->start_time = jiffies;
> +		md_io->orig_bi_end_io = bio->bi_end_io;
> +		md_io->orig_bi_private = bio->bi_private;
> +
> +		bio->bi_end_io = md_end_io;
> +		bio->bi_private = md_io;
> +
> +		bio_start_io_acct(bio);

It can just be "md_io->start_time = bio_start_io_acct(bio)", with that

Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks,
Guoqing

