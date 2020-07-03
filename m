Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021CB2137A3
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgGCJ1C (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jul 2020 05:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgGCJ1C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jul 2020 05:27:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E8CC08C5C1
        for <linux-raid@vger.kernel.org>; Fri,  3 Jul 2020 02:27:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n2so18073261edr.5
        for <linux-raid@vger.kernel.org>; Fri, 03 Jul 2020 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Q60cfba4oVNnwNwZTKYfbg9c36gDR0qHU+Swmx1gUTg=;
        b=jOe/t4Z9DV7eI8E9K/1vouwY4l4DC75yVnxnW9tcXZWjgMVmlZSz/pyDL5v1xACBjw
         EQ1pdF2BKnXPY0WR/gyuKH0fTNfLnMG/ifQOSCNJY+hzjOObZrBCvRRED/Xb4yHWzXQz
         sOcRBZRtW8GghEQqKzWLJ0zlyScaD6BRsCroJcL64n6vLj6l57OfB1Wbjz2zZR58bPuG
         n1GPOsUBWBXY5Vc6bIMLikA646FtspRfAh5Qsya+a95jOSleEbr/xGF77rHcEXYMp13C
         HtiQJS0OfVKtATpon95yXY03Dv9vVpZpITLrA6jaK5vTPw4lsC0mgIHHRxLxJjElVWpz
         OHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q60cfba4oVNnwNwZTKYfbg9c36gDR0qHU+Swmx1gUTg=;
        b=rSRPBEXDOEZAmmkH+z8NZKQoMxaOG20FhcRLxwbQ4PWPZspZd6pWyUZwCcSKbNXu3V
         bI5OhHD8HrzbRnWij3kgU3B0/YHn+1jYZ2TfEBRH+1ackNCOcguvvGQOi1g8Src07YR0
         A3BCu8THNLFE57A3fejykh+f5L/FzmqvrWJ89NcFztv5q1hAEQ/9+lG0RskqvrI1zJ2O
         68d4Sb3YUDZfFAP4DitDJgQZONLkTkKXC/bxLu4P4eCP+03QL61Xh0F/d97rs1LZkDCo
         8AtZcQJzhriAS1lTIARCuCp6PHLMRyg8my5TkoSKxvlV2E76cGhbZk4PNWZFuAYlC1t9
         Witw==
X-Gm-Message-State: AOAM530Zwy5FDmadn3kUQhkJYBxLPKehj3m+0ygAe1n9aVr3Lq2BerPX
        KMJDtOuDveMDffIe2Gv+h2aXBzbHkW8bnBL2
X-Google-Smtp-Source: ABdhPJzh+E/2bHKNDIYKhFOwjzXlRWEsAHU2q1ScRMCcuslrBkLUgtmTcxvZia/d5nL+HnQvskfNsg==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr35240538edr.53.1593768420791;
        Fri, 03 Jul 2020 02:27:00 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:60ce:5ee7:9c1b:dbd8? ([2001:1438:4010:2540:60ce:5ee7:9c1b:dbd8])
        by smtp.gmail.com with ESMTPSA id a37sm12864903edf.86.2020.07.03.02.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 02:27:00 -0700 (PDT)
Subject: Re: [PATCH v4] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com>
Date:   Fri, 3 Jul 2020 11:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Looks good, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks,
Guoqing

On 7/3/20 11:13 AM, Artur Paszkiewicz wrote:
> Use generic io accounting functions to manage io stats. There was an
> attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
> stats accounting functions to simplify io stat accounting"), but it did
> not include a call to generic_end_io_acct() and caused issues with
> tracking in-flight IOs, so it was later removed in commit 74672d069b29
> ("md: fix md io stats accounting broken").
>
> This patch attempts to fix this by using both disk_start_io_acct() and
> disk_end_io_acct(). To make it possible, a struct md_io is allocated for
> every new md bio, which includes the io start_time. A new mempool is
> introduced for this purpose. We override bio->bi_end_io with our own
> callback and call disk_start_io_acct() before passing the bio to
> md_handle_request(). When it completes, we call disk_end_io_acct() and
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
> v4:
> - Use disk_{start,end}_io_acct() instead of bio_{start,end}_io_acct() to
>    pass mddev->gendisk directly, not bio->bi_disk which gets modified by
>    some personalities.
>
> v3:
> - Use bio_start_io_acct() return value for md_io->start_time (thanks
>    Guoqing!)
>
> v2:
> - Just override the bi_end_io without having to clone the original bio.
> - Rebased onto latest md-next.
>
>   drivers/md/md.c | 57 ++++++++++++++++++++++++++++++++++++++-----------
>   drivers/md/md.h |  1 +
>   2 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8bb69c61afe0..63aeebd9266b 100644
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
> +	disk_end_io_acct(mddev->gendisk, bio_op(bio), md_io->start_time);
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
> @@ -488,21 +509,27 @@ static blk_qc_t md_submit_bio(struct bio *bio)
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
> +		md_io->orig_bi_end_io = bio->bi_end_io;
> +		md_io->orig_bi_private = bio->bi_private;
> +
> +		bio->bi_end_io = md_end_io;
> +		bio->bi_private = md_io;
> +
> +		md_io->start_time = disk_start_io_acct(mddev->gendisk,
> +						       bio_sectors(bio),
> +						       bio_op(bio));
> +	}
> +
>   	/* bio could be mergeable after passing to underlayer */
>   	bio->bi_opf &= ~REQ_NOMERGE;
>   
>   	md_handle_request(mddev, bio);
>   
> -	part_stat_lock();
> -	part_stat_inc(&mddev->gendisk->part0, ios[sgrp]);
> -	part_stat_add(&mddev->gendisk->part0, sectors[sgrp], sectors);
> -	part_stat_unlock();
> -
>   	return BLK_QC_T_NONE;
>   }
>   
> @@ -5545,6 +5572,7 @@ static void md_free(struct kobject *ko)
>   
>   	bioset_exit(&mddev->bio_set);
>   	bioset_exit(&mddev->sync_set);
> +	mempool_exit(&mddev->md_io_pool);
>   	kfree(mddev);
>   }
>   
> @@ -5640,6 +5668,11 @@ static int md_alloc(dev_t dev, char *name)
>   		 */
>   		mddev->hold_active = UNTIL_STOP;
>   
> +	error = mempool_init_kmalloc_pool(&mddev->md_io_pool, BIO_POOL_SIZE,
> +					  sizeof(struct md_io));
> +	if (error)
> +		goto abort;
> +
>   	error = -ENOMEM;
>   	mddev->queue = blk_alloc_queue(NUMA_NO_NODE);
>   	if (!mddev->queue)
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 612814d07d35..c26fa8bd41e7 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -481,6 +481,7 @@ struct mddev {
>   	struct bio_set			sync_set; /* for sync operations like
>   						   * metadata and bitmap writes
>   						   */
> +	mempool_t			md_io_pool;
>   
>   	/* Generic flush handling.
>   	 * The last to finish preflush schedules a worker to submit

