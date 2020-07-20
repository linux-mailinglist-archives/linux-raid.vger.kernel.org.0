Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DEE2256F7
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 07:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgGTFOl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 01:14:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgGTFOl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 01:14:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89002B7EF;
        Mon, 20 Jul 2020 05:14:45 +0000 (UTC)
Subject: Re: [PATCH V1 1/3] Move codes related with submitting discard bio
 into one function
To:     Xiao Ni <xni@redhat.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com
References: <1595221108-10137-1-git-send-email-xni@redhat.com>
 <1595221108-10137-2-git-send-email-xni@redhat.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <409c3135-c831-6afb-5d58-075d0d5a6fc4@suse.de>
Date:   Mon, 20 Jul 2020 13:14:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595221108-10137-2-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/7/20 12:58, Xiao Ni wrote:
> These codes can be used in raid10. So we can move these codes into md.c. raid0 and raid10
> can share these codes.
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>

It looks good to me.

Reviewed-by: Coly Li <colyli@suse.de>




> ---
>  drivers/md/md.c    | 22 ++++++++++++++++++++++
>  drivers/md/md.h    |  3 +++
>  drivers/md/raid0.c | 15 ++-------------
>  3 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 07e5b67..2b8f654 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8559,6 +8559,28 @@ void md_write_end(struct mddev *mddev)
>  
>  EXPORT_SYMBOL(md_write_end);
>  
> +void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
> +				struct bio *bio,
> +				sector_t dev_start, sector_t dev_end)
> +{
> +	struct bio *discard_bio = NULL;
> +
> +	if (__blkdev_issue_discard(rdev->bdev,
> +	    dev_start + rdev->data_offset,
> +	    dev_end - dev_start, GFP_NOIO, 0, &discard_bio) ||
> +	    !discard_bio)
> +		return;
> +
> +	bio_chain(discard_bio, bio);
> +	bio_clone_blkg_association(discard_bio, bio);
> +	if (mddev->gendisk)
> +		trace_block_bio_remap(bdev_get_queue(rdev->bdev),
> +			discard_bio, disk_devt(mddev->gendisk),
> +			bio->bi_iter.bi_sector);
> +	submit_bio_noacct(discard_bio);
> +}
> +EXPORT_SYMBOL(md_submit_discard_bio);
> +
>  /* md_allow_write(mddev)
>   * Calling this ensures that the array is marked 'active' so that writes
>   * may proceed without blocking.  It is important to call this before
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index c26fa8b..83ae77e 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -710,6 +710,9 @@ extern void md_write_end(struct mddev *mddev);
>  extern void md_done_sync(struct mddev *mddev, int blocks, int ok);
>  extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
>  extern void md_finish_reshape(struct mddev *mddev);
> +extern void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
> +				struct bio *bio,
> +				sector_t dev_start, sector_t dev_end);
>  
>  extern int mddev_congested(struct mddev *mddev, int bits);
>  extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index e9e91c8..e37fe8a 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -525,7 +525,6 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>  
>  	for (disk = 0; disk < zone->nb_dev; disk++) {
>  		sector_t dev_start, dev_end;
> -		struct bio *discard_bio = NULL;
>  		struct md_rdev *rdev;
>  
>  		if (disk < start_disk_index)
> @@ -548,18 +547,8 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>  
>  		rdev = conf->devlist[(zone - conf->strip_zone) *
>  			conf->strip_zone[0].nb_dev + disk];
> -		if (__blkdev_issue_discard(rdev->bdev,
> -			dev_start + zone->dev_start + rdev->data_offset,
> -			dev_end - dev_start, GFP_NOIO, 0, &discard_bio) ||
> -		    !discard_bio)
> -			continue;
> -		bio_chain(discard_bio, bio);
> -		bio_clone_blkg_association(discard_bio, bio);
> -		if (mddev->gendisk)
> -			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
> -				discard_bio, disk_devt(mddev->gendisk),
> -				bio->bi_iter.bi_sector);
> -		submit_bio_noacct(discard_bio);
> +		dev_start += zone->dev_start;
> +		md_submit_discard_bio(mddev, rdev, bio, dev_start, dev_end);
>  	}
>  	bio_endio(bio);
>  }
> 

