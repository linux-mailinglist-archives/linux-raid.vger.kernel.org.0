Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D57C9A94
	for <lists+linux-raid@lfdr.de>; Thu,  3 Oct 2019 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfJCJQz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Oct 2019 05:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfJCJQz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 3 Oct 2019 05:16:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8786F18C4267;
        Thu,  3 Oct 2019 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A18FB5D6A9;
        Thu,  3 Oct 2019 09:16:51 +0000 (UTC)
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-raid@vger.kernel.org, ncroxon@redhat.com, heinzm@redhat.com,
        neilb@suse.de, songliubraving@fb.com
References: <1568627145-14210-1-git-send-email-xni@redhat.com>
 <20190916171514.GA1970@redhat>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <e80828b0-c115-7f50-b3da-241d7c8871c0@redhat.com>
Date:   Thu, 3 Oct 2019 17:16:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190916171514.GA1970@redhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 03 Oct 2019 09:16:54 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi David and Song


On 09/17/2019 01:15 AM, David Jeffery wrote:
> Calling md_handle_request is certainly the simplest way to fix the issue,
> but after more thought I don't think it's the best way.  When the code gets
> to md_flush_request, the code already has md_handle_request and the raid
> driver's make_request function in the stack.
>
> To fix the lost I/O, instead of recursing back into md_handle_request we
> can pass back a bool to indicate if the original make_request call should
> continue to handle the I/O and instead of assuming the flush logic will
> push it to completion.
>
> This patch converts md_flush_request to return a bool and no longer calls
> the raid driver's make_request function.  If the return is true, then the
> md flush logic has or will complete the bio and the md make_request call
> is done.  If false, then the md make_request function needs to keep
> processing like it is a normal I/O carrying bio. Let the original call to
> md_handle_request handle any need to retry sending the bio to the raid
> driver's make_request function should it be needed.
>
> This also marks md_flush_request and the make_request function pointer as
> __must_check to issue warnings should these critical return values be
> ignored.
>
>
> Signed-of-by: David Jeffery <djeffery@redhat.com>
A typing error here Signed-off-by:
>
>
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 7354466ddc90..afcf1d388300 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -244,10 +244,9 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
>   	sector_t start_sector, end_sector, data_offset;
>   	sector_t bio_sector = bio->bi_iter.bi_sector;
>   
> -	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
> -		md_flush_request(mddev, bio);
> +	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
> +	    && md_flush_request(mddev, bio))
>   		return true;
> -	}
>   
>   	tmp_dev = which_dev(mddev, bio_sector);
>   	start_sector = tmp_dev->end_sector - tmp_dev->rdev->sectors;
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index 6780938d2991..152f9e65a226 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -104,10 +104,9 @@ static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
>   	struct multipath_bh * mp_bh;
>   	struct multipath_info *multipath;
>   
> -	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
> -		md_flush_request(mddev, bio);
> +	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
> +	    && md_flush_request(mddev, bio))
>   		return true;
> -	}
>   
>   	mp_bh = mempool_alloc(&conf->pool, GFP_NOIO);
>   
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 24638ccedce4..d2c23f7b1008 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -545,7 +545,13 @@ static void md_submit_flush_data(struct work_struct *ws)
>   	}
>   }
>   
> -void md_flush_request(struct mddev *mddev, struct bio *bio)
> +/*
> + * Manages consolidation of flushes and submitting any flushes needed for
> + * a bio with REQ_PREFLUSH.  Returns true if the bio is finished or is
> + * being finished in another context.  Returns false if the flushing is
> + * complete but still needs the I/O portion of the bio to be processed.
> + */
> +bool md_flush_request(struct mddev *mddev, struct bio *bio)
>   {
>   	ktime_t start = ktime_get_boottime();
>   	spin_lock_irq(&mddev->lock);
> @@ -570,9 +576,10 @@ void md_flush_request(struct mddev *mddev, struct bio *bio)
>   			bio_endio(bio);
>   		else {
>   			bio->bi_opf &= ~REQ_PREFLUSH;
> -			mddev->pers->make_request(mddev, bio);
> +			return false;
>   		}
>   	}
> +	return true;
>   }
>   EXPORT_SYMBOL(md_flush_request);
>   
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 10f98200e2f8..70d1dddf410b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -543,7 +543,7 @@ struct md_personality
>   	int level;
>   	struct list_head list;
>   	struct module *owner;
> -	bool (*make_request)(struct mddev *mddev, struct bio *bio);
> +	bool __must_check (*make_request)(struct mddev *mddev, struct bio *bio);
>   	/*
>   	 * start up works that do NOT require md_thread. tasks that
>   	 * requires md_thread should go into start()
> @@ -696,7 +696,7 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
>   extern void md_finish_reshape(struct mddev *mddev);
>   
>   extern int mddev_congested(struct mddev *mddev, int bits);
> -extern void md_flush_request(struct mddev *mddev, struct bio *bio);
> +extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
>   extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
>   			   sector_t sector, int size, struct page *page);
>   extern int md_super_wait(struct mddev *mddev);
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index bf5cf184a260..2071437b80ca 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -554,10 +554,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
>   	unsigned chunk_sects;
>   	unsigned sectors;
>   
> -	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
> -		md_flush_request(mddev, bio);
> +	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
> +	    && md_flush_request(mddev, bio))
>   		return true;
> -	}
>   
>   	if (unlikely((bio_op(bio) == REQ_OP_DISCARD))) {
>   		raid0_handle_discard(mddev, bio);
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 34e26834ad28..576c02eae286 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1562,10 +1562,9 @@ static bool raid1_make_request(struct mddev *mddev, struct bio *bio)
>   {
>   	sector_t sectors;
>   
> -	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
> -		md_flush_request(mddev, bio);
> +	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
> +	    && md_flush_request(mddev, bio))
>   		return true;
> -	}
>   
>   	/*
>   	 * There is a limit to the maximum size, but
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 8a1354a08a1a..c5c134b3868b 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1523,10 +1523,9 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
>   	int chunk_sects = chunk_mask + 1;
>   	int sectors = bio_sectors(bio);
>   
> -	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
> -		md_flush_request(mddev, bio);
> +	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
> +	    && md_flush_request(mddev, bio))
>   		return true;
> -	}
>   
>   	if (!md_write_start(mddev, bio))
>   		return false;
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 3de4e13bde98..ce935e95e32f 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5584,8 +5584,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   		if (ret == 0)
>   			return true;
>   		if (ret == -ENODEV) {
> -			md_flush_request(mddev, bi);
> -			return true;
> +			if (md_flush_request(mddev, bi))
> +				return true;
>   		}
>   		/* ret == -EAGAIN, fallback */
>   		/*
>

Reviewed-by: Xiao Ni <xni@redhat.com>
