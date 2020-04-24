Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061981B6F6E
	for <lists+linux-raid@lfdr.de>; Fri, 24 Apr 2020 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgDXHwz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Apr 2020 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgDXHwz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Apr 2020 03:52:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C25C09B045
        for <linux-raid@vger.kernel.org>; Fri, 24 Apr 2020 00:52:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so2501566pjz.1
        for <linux-raid@vger.kernel.org>; Fri, 24 Apr 2020 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1qtda+EBJiJ6hwR6xxcsxO446LLKpz91oT+TT275Klw=;
        b=c9N7E7iA++d03caQIO1FRUt2fal4Oxbk1duDkSDWLgytR5IpEtkwd4x/NsOf4qoB0y
         X09VC111+Bu4LApbR2Eg6Nz/CqKijIaAB5PbMRCQJoqIwaS3HHZsaHWRPXEMHkBcH9Z7
         nKFfkdpdwIxbJcV3RTl0h/OpdG7fdQCxLjYzRPFkIqT5jQd+8DUeSr7TKMm7U8BLV72A
         nZ7eFr7cXhACoSDbzxlLrqOeivLhVxibaJGCw3lUSNcSf5TTCtGdKue9JsVj9fDNW+le
         THqOXA+uR5aNE48K6JATl+QmgbY/j5qK7dXJ3POm8ts7eLEKDu2r9U4wB+TO68LN+psN
         ITYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1qtda+EBJiJ6hwR6xxcsxO446LLKpz91oT+TT275Klw=;
        b=iNFTyxiKOSUeHlNGupeFOhTJHoedh9pJEwOY9uU8JP8fdnWc/tGJVVH1fqdxCY2Bly
         7GvXers74VlAnUptEhir7y2NJUkCIr2o1mxfgNdx4/HCs42mbFZsQhh2/m079xVGYp/y
         7SqF+N04OtZ5ZFfnbZApkqUaYFB8IUWRcbACBUJU3RX/ExIh2sdDLStpEAIRJCgX8s5j
         iHHAOL1OYHWPQEoP4fyHzzCZyl9k1nFLJkaUnfwDJozsIgvB8VEiDSxP6i6Kt9tMQA/V
         6ZXkr4qm26Jt8PSbPDhRfMQJYugv421PsFQdBx9/qOGfikrLaJKQpDZm9BOIQT1kqnkg
         04hA==
X-Gm-Message-State: AGi0PuYzoCZWg1xy0iI7+jN7IH9N5ohKhKhbwquVGeIMM5ByxRwpC5pv
        TQ/dAoN9fKPXbjpmIG5E4fvE9A==
X-Google-Smtp-Source: APiQypL+oHmikN6vFdzj9cGMPSBaikyGd5zA1JiIzTfEGZtSI+lY4ReO31qOsV0g+bpxuc5pHMSxmQ==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr8033638plc.245.1587714774201;
        Fri, 24 Apr 2020 00:52:54 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4844:d000:6d4b:554:cd7c:6b19? ([2001:16b8:4844:d000:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id 1sm4295114pjc.32.2020.04.24.00.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 00:52:53 -0700 (PDT)
Subject: Re: [PATCH] md/raid1: release pending accounting for an I/O only
 after write-behind is also finished
To:     David Jeffery <djeffery@redhat.com>, linux-raid@vger.kernel.org
Cc:     Song Liu <song@kernel.org>
References: <20200127152619.GA3596@redhat>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <c6da909e-7394-bea4-9efe-48ae6dbb7f0b@cloud.ionos.com>
Date:   Fri, 24 Apr 2020 09:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200127152619.GA3596@redhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/27/20 4:26 PM, David Jeffery wrote:
> When using RAID1 and write-behind, md can deadlock when errors occur. With
> write-behind, r1bio structs can be accounted by raid1 as queued but not
> counted as pending. The pending count is dropped when the original bio is
> returned complete but write-behind for the r1bio may still be active.
>
> This breaks the accounting used in some conditions to know when the raid1
> md device has reached an idle state. It can result in calls to
> freeze_array deadlocking. freeze_array will never complete from a negative
> "unqueued" value being calculated due to a queued count larger than the
> pending count.
>
> To properly account for write-behind, move the call to allow_barrier from
> call_bio_endio to raid_end_bio_io. When using write-behind, md can call
> call_bio_endio before all write-behind I/O is complete. Using
> raid_end_bio_io for the point to call allow_barrier will release the
> pending count at a point where all I/O for an r1bio, even write-behind, is
> done.
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>
>   raid1.c |   13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 201fd8aec59a..0196a9d9f7e9 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
>   static void call_bio_endio(struct r1bio *r1_bio)
>   {
>   	struct bio *bio = r1_bio->master_bio;
> -	struct r1conf *conf = r1_bio->mddev->private;
>   
>   	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
>   		bio->bi_status = BLK_STS_IOERR;
>   
>   	bio_endio(bio);
> -	/*
> -	 * Wake up any possible resync thread that waits for the device
> -	 * to go idle.
> -	 */
> -	allow_barrier(conf, r1_bio->sector);
>   }
>   
>   static void raid_end_bio_io(struct r1bio *r1_bio)
>   {
>   	struct bio *bio = r1_bio->master_bio;
> +	struct r1conf *conf = r1_bio->mddev->private;
>   
>   	/* if nobody has done the final endio yet, do it now */
>   	if (!test_and_set_bit(R1BIO_Returned, &r1_bio->state)) {
> @@ -305,6 +300,12 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
>   
>   		call_bio_endio(r1_bio);
>   	}
> +	/*
> +	 * Wake up any possible resync thread that waits for the device
> +	 * to go idle.  All I/Os, even write-behind writes, are done.
> +	 */
> +	allow_barrier(conf, r1_bio->sector);
> +
>   	free_r1bio(r1_bio);
>   }
>

Actually, it reverts part of change in 
d2eb35acfdccbe2a3622ed6cc441a5482148423b,
not sure if it is better to move the call of allow_barrier back to 
free_r1bio, just FYI.

Thanks,
Guoqing
