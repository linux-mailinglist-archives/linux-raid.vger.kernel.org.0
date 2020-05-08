Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43021CA00E
	for <lists+linux-raid@lfdr.de>; Fri,  8 May 2020 03:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEHB0E (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 21:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgEHB0D (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 May 2020 21:26:03 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B18A20CC7
        for <linux-raid@vger.kernel.org>; Fri,  8 May 2020 01:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588901162;
        bh=rJwv1n0aTjvAz2Lby7+xcF33VFaJj2+YvQvqnrYfr3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZSB/tGtaBUMTvkzRnWsI41Y3YldExk2TJPbK2rDNMbKTMuUyGBlQza7+6/WB02sQs
         0wZvTQCwC5Naf6xzlcyI2MDpvsCrMrlqJ61sFnXzNmCd9wwwGtYROZwInd+0WjFwtc
         mbgXmjXQxEV4XiaBM6ybY/bTkWdMS68qTl85WbQA=
Received: by mail-lf1-f52.google.com with SMTP id d25so106168lfi.11
        for <linux-raid@vger.kernel.org>; Thu, 07 May 2020 18:26:02 -0700 (PDT)
X-Gm-Message-State: AOAM532DZ0SdatBZPb0+lnSNueCNZueFTaSOBfBTG8cm5wMzuGyP5btb
        ESS80dMcAQppOiYWBgRs3igq6+8E63LxJ9oxm1k=
X-Google-Smtp-Source: ABdhPJwXyewKnwQ6obmm/GIkfe6sLUAwz9pS82brj6YfO6mqpQr0Mk70Gv/UY25FHN6aUpv4DFymwo1RvgsdC2Mv4QI=
X-Received: by 2002:a19:644f:: with SMTP id b15mr198595lfj.28.1588901160474;
 Thu, 07 May 2020 18:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200421123952.49025-1-yuyufen@huawei.com> <20200421123952.49025-3-yuyufen@huawei.com>
In-Reply-To: <20200421123952.49025-3-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 May 2020 18:25:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6ETatEq_x+4YEvY2XkFjBWDkodEjrXaAyRpmodvdNzzg@mail.gmail.com>
Message-ID: <CAPhsuW6ETatEq_x+4YEvY2XkFjBWDkodEjrXaAyRpmodvdNzzg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/8] md/raid5: add a member of r5pages for struct stripe_head
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, Xiao Ni <xni@redhat.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Apr 21, 2020 at 5:40 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Since grow_buffers() uses alloc_page() allocate the buffers for each
> stripe_head(), means, it will allocate 64K buffers and just use 4K
> of them, after setting STRIPE_SIZE as 4096.
>
> To avoid waste memory, we try to contain multiple 'page' of sh->dev
> into one real page. That means, multiple sh->dev[i].page will point to
> the only page with different offset. Example of 64K PAGE_SIZE and
> 4K STRIPE_SIZE as following:
>
>                     64K PAGE_SIZE
>           +---+---+---+---+------------------------------+
>           |   |   |   |   |
>           |   |   |   |   |
>           +-+-+-+-+-+-+-+-+------------------------------+
>             ^   ^   ^   ^
>             |   |   |   +----------------------------+
>             |   |   |                                |
>             |   |   +-------------------+            |
>             |   |                       |            |
>             |   +----------+            |            |
>             |              |            |            |
>             +-+            |            |            |
>               |            |            |            |
>         +-----+-----+------+-----+------+-----+------+------+
> sh      | offset(0) | offset(4K) | offset(8K) | offset(16K) |
>  +      +-----------+------------+------------+-------------+
>  +----> dev[0].page  dev[1].page  dev[2].page  dev[3].page
>
> After compressing pages, the users of sh->dev[i].page need to be take care:
>
>   1) When issue bio of stripe_head, bi_io_vec.bv_page will point to
>      the page directly. So, we should make sure bv_offset been set with
>      correct offset.
>
>   2) When compute xor, the page will be passed to computer function.
>      So, we also need to pass offset of that page to computer. Let it
>      compute correct location of each sh->dev[i].page.
>
> This patch will add a new member of r5pages in stripe_head to manage
> all pages needed by each sh->dev[i]. We also add 'offset' for each r5dev
> so that users can get related page offset easily. And add helper function
> to get page and it's index in r5pages array by disk index. This is patch
> in preparation for fallowing changes.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/md/raid5.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index b0010991bdc8..6296578e9585 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -246,6 +246,13 @@ struct stripe_head {
>                 int                  target, target2;
>                 enum sum_check_flags zero_sum_result;
>         } ops;
> +
> +       /* These pages will be used by bios in dev[i] */
> +       struct r5pages {
> +               struct page     **page;
> +               int     size; /* page array size */

Do we really need variable size for each stripe?

Thanks,
Song

PS: I like the overall idea of 2/8 and 3/8. Will continue reviewing later.


> +       } pages;
> +
>         struct r5dev {
>                 /* rreq and rvec are used for the replacement device when
>                  * writing data to both devices.
> @@ -253,6 +260,7 @@ struct stripe_head {
>                 struct bio      req, rreq;
>                 struct bio_vec  vec, rvec;
>                 struct page     *page, *orig_page;
> +               unsigned int    offset;         /* offset of this page */
>                 struct bio      *toread, *read, *towrite, *written;
>                 sector_t        sector;                 /* sector of this page */
>                 unsigned long   flags;
> @@ -754,6 +762,54 @@ static inline int algorithm_is_DDF(int layout)
>         return layout >= 8 && layout <= 10;
>  }
>
> +/*
> + * Return corresponding page index of r5pages array.
> + */
> +static inline int raid5_get_page_index(struct stripe_head *sh, int disk_idx)
> +{
> +       WARN_ON(!sh->pages.page);
> +       if (disk_idx >= sh->raid_conf->pool_size)
> +               return -ENOENT;
> +
> +       return (disk_idx * STRIPE_SIZE) / PAGE_SIZE;
> +}
> +
> +/*
> + * Return offset of the corresponding page for r5dev.
> + */
> +static inline int raid5_get_page_offset(struct stripe_head *sh, int disk_idx)
> +{
> +       WARN_ON(!sh->pages.page);
> +       if (disk_idx >= sh->raid_conf->pool_size)
> +               return -ENOENT;
> +
> +       return (disk_idx * STRIPE_SIZE) % PAGE_SIZE;
> +}
> +
> +/*
> + * Return corresponding page address for r5dev.
> + */
> +static inline struct page *
> +raid5_get_dev_page(struct stripe_head *sh, int disk_idx)
> +{
> +       int idx;
> +
> +       WARN_ON(!sh->pages.page);
> +       idx = raid5_get_page_index(sh, disk_idx);
> +       return sh->pages.page[idx];
> +}
> +
> +/*
> + * We want to 'compress' multiple buffers to one real page for
> + * stripe_head when PAGE_SIZE is biggger than STRIPE_SIZE. If their
> + * values are equal, no need to use this strategy. For now, it just
> + * support raid level less than 5.
> + */
> +static inline int raid5_compress_stripe_pages(struct r5conf *conf)
> +{
> +       return (PAGE_SIZE > STRIPE_SIZE) && (conf->level < 6);
> +}
> +
>  extern void md_raid5_kick_device(struct r5conf *conf);
>  extern int raid5_set_cache_size(struct mddev *mddev, int size);
>  extern sector_t raid5_compute_blocknr(struct stripe_head *sh, int i, int previous);
> --
> 2.21.1
>
