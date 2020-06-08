Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958791F1B23
	for <lists+linux-raid@lfdr.de>; Mon,  8 Jun 2020 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgFHOhc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 8 Jun 2020 10:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgFHOhb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 8 Jun 2020 10:37:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD28C08C5C2
        for <linux-raid@vger.kernel.org>; Mon,  8 Jun 2020 07:37:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so18591540eju.2
        for <linux-raid@vger.kernel.org>; Mon, 08 Jun 2020 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MdwwIRMIbQELUj+o7jOVd+0Jb/6eTzJI3fJ3Dq8vMLA=;
        b=cjzI/JUI5aFpuui/XLJVI/NViLbhFFmsBCvm/q09wUzVFZRtG6AIA8/v29pCF/+EuN
         49fS8lEsQoR3EtQ0VEz4T0Rm2p3XX7Z0hEPjtEULZSFF8xYkawom6T0R8rOX8kQ5ovT/
         AVSnG6P0FGw9YIjg5kjykAQWdBArEsNBvhWOJRMoEdAVcv/rmV5AP5mXcjVGwhCwcNxE
         5ArqW7NlDIrdQcbm6QE11NjVc5FmBw7tA0vst5QvSfpN29qwN8JQ81Ogj4yH2RCqxx3C
         B9Kekjh0ORQnRFgaTMAAtJ8GbPmqnLrZqwSuhE/mG0gEfFLFwaMxu6dMyhr0MpH6KzDB
         6Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MdwwIRMIbQELUj+o7jOVd+0Jb/6eTzJI3fJ3Dq8vMLA=;
        b=e7u6rdfLQdThCUZISFKNOyUaPpCteDn7Q44RQGLocBuwOVhKLsVbRuDhXwpHdPTuck
         iU0I9VnFOhvm68rnEB+g9/8tAHGU6TLPREwuC87aR8Efk+v0DeamVM7rxn0iwjLLfXvc
         jh1oTvf5wzKiNEq6nakTAuDx0A4ZbbqdcS4nNZegLakzY0oFWHxdmh7IKQR/QgmLZDEx
         tE9GPzdLzKSNR7+7eAxc6Xj4W337N02/YYOOceYMWhN2uOy5p9AhZy4vR+jwuq+1uN9L
         HRr0WUXr7uIHd8GMnto3TDmUp/ODnkA3NXIkiF2QxpkGp1brpTf7Nhpy1x8Qw/irpgOC
         aH0Q==
X-Gm-Message-State: AOAM532j9Ra06/MJYhHtANIRS3QURNy+3+V11R4c3tdRsJKdAbiLfmYv
        3fqcvIzjelloOgwuFhiAf6jkzohtrfs=
X-Google-Smtp-Source: ABdhPJxBtE2H4kPxGERaqrXI2th/ZcNwq1oVwfU47vy9TFCs6kVtnazZgcra/N3E1zHeBOJRRsVt6Q==
X-Received: by 2002:a17:907:2052:: with SMTP id pg18mr20323259ejb.513.1591627049494;
        Mon, 08 Jun 2020 07:37:29 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48fc:4c00:f967:9014:5748:3cac? ([2001:16b8:48fc:4c00:f967:9014:5748:3cac])
        by smtp.gmail.com with ESMTPSA id 63sm2320008edy.8.2020.06.08.07.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:37:28 -0700 (PDT)
Subject: Re: [PATCH] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <d09aefa9-00ed-ef94-f5c4-50be91828170@cloud.ionos.com>
Date:   Mon, 8 Jun 2020 16:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/1/20 6:12 PM, Artur Paszkiewicz wrote:
> Use generic io accounting functions to manage io stats. There was an
> attempt to do this earlier in commit 18c0b223cf990172 ("md: use generic
> io stats accounting functions to simplify io stat accounting"), but it
> did not include a call to generic_end_io_acct() and caused issues with
> tracking in-flight IOs, so it was later removed in commit
> 74672d069b298b03 ("md: fix md io stats accounting broken").
>
> This patch attempts to fix this by using both generic_start_io_acct()
> and generic_end_io_acct(). To make it possible, in md_make_request() a
> bio is cloned with additional data - struct md_io, which includes the io
> start_time. A new bioset is introduced for this purpose. We call
> generic_start_io_acct() and pass the clone instead of the original to
> md_handle_request(). When it completes, we call generic_end_io_acct()
> and complete the original bio.
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
>   drivers/md/md.c | 65 +++++++++++++++++++++++++++++++++++++++----------
>   drivers/md/md.h |  1 +
>   2 files changed, 53 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f567f536b529..5a9f167ef5b9 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -463,12 +463,32 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
>   }
>   EXPORT_SYMBOL(md_handle_request);
>   
> +struct md_io {
> +	struct mddev *mddev;
> +	struct bio *orig_bio;
> +	unsigned long start_time;
> +	struct bio orig_bio_clone;
> +};
> +
> +static void md_end_request(struct bio *bio)
> +{
> +	struct md_io *md_io = bio->bi_private;
> +	struct mddev *mddev = md_io->mddev;
> +	struct bio *orig_bio = md_io->orig_bio;
> +
> +	orig_bio->bi_status = bio->bi_status;
> +
> +	generic_end_io_acct(mddev->queue, bio_op(orig_bio),
> +			    &mddev->gendisk->part0, md_io->start_time);

[...]

> +		generic_start_io_acct(mddev->queue, bio_op(bio),
> +				      bio_sectors(bio), &mddev->gendisk->part0);
> +	}
> +

Now, you need to switch to call bio_{start,end}_io_acct instead of
generic_{start,end}_io_acct after the changes from Christoph.

Thanks,
Guoqing
