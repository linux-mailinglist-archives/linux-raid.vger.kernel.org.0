Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA17212BF8
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgGBSPs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 14:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgGBSPr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 14:15:47 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F1E20870
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593713746;
        bh=C0WUKnIlYfjVvx0mUVI6uISOnIsts5dyM+F+c+lvZwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vSF3KL3/tjTQ9jR9KVfuf94LBKfR/L9pbUEEeQFup/Uj8Gpwg+X9ZFxS6ijwpLinv
         k88J4u/Kt1n+HD0lwzU1tSWdFwDghaIiYExLLlFvgZ3FW4+FyCQip3RjhCHsKJQd/w
         OcF5NSwrBsFrOUyvE7zsJB/kD2D7915wC3hmG6N0=
Received: by mail-lf1-f50.google.com with SMTP id y13so16786230lfe.9
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 11:15:46 -0700 (PDT)
X-Gm-Message-State: AOAM5309mDTiv8DcA85AWVImxNuFf7pcDDFNWsgROybFjV7CFupm4P54
        BO9luEXaX2UkSksk9/1VdwL7+mttveIqxSOU7T8=
X-Google-Smtp-Source: ABdhPJwqt6IdaTxg14NeRe8BXUSkQsNkyNSUh4nMmJUoRcYMbWxIh55l4+YzXUmJidGoL0tfQfE6QZGqBl89lf6aXIw=
X-Received: by 2002:a19:6a14:: with SMTP id u20mr18087994lfu.172.1593713744746;
 Thu, 02 Jul 2020 11:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200702120628.777303-1-yuyufen@huawei.com> <20200702120628.777303-2-yuyufen@huawei.com>
In-Reply-To: <20200702120628.777303-2-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 11:15:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7cSue8BtWhmWMgOTjw42ChTm4cM+gApj_s02rq=YGRkQ@mail.gmail.com>
Message-ID: <CAPhsuW7cSue8BtWhmWMgOTjw42ChTm4cM+gApj_s02rq=YGRkQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> We covert STRIPE_SIZE, STRIPE_SHIFT and STRIPE_SECTORS to stripe_size,
> stripe_shift and stripe_sectors as members of struct r5conf. Then each
> raid456 array can config different stripe_size. This patch is prepared
> for following configurable stripe_size.
>
> Simply replace word STRIPE_ with conf->stripe_ and add 'conf' argument
> for function stripe_hash_locks_hash() and r5_next_bio() to get stripe_size.
> After that, we initialize stripe_size into setup_conf().
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

This patch looks good. Please fix the warning found by the kernel test bot.
Also a nitpick below.

[...]

> -
>  /* NOTE NR_STRIPE_HASH_LOCKS must remain below 64.
>   * This is because we sometimes take all the spinlocks
>   * and creating that much locking depth can cause
> @@ -574,6 +554,9 @@ struct r5conf {
>         int                     raid_disks;
>         int                     max_nr_stripes;
>         int                     min_nr_stripes;
> +       unsigned int    stripe_size;
> +       unsigned int    stripe_shift;
> +       unsigned int    stripe_sectors;

Are you using a different tab size (other than 8)? These 3 new lines are not
aligned with the rest with tab size of 8.

>
>         /* reshape_progress is the leading edge of a 'reshape'
>          * It has value MaxSector when no reshape is happening
> @@ -752,6 +735,24 @@ static inline int algorithm_is_DDF(int layout)
>         return layout >= 8 && layout <= 10;
>  }
>
> +/* bio's attached to a stripe+device for I/O are linked together in bi_sector
> + * order without overlap.  There may be several bio's per stripe+device, and
> + * a bio could span several devices.
> + * When walking this list for a particular stripe+device, we must never proceed
> + * beyond a bio that extends past this device, as the next bio might no longer
> + * be valid.
> + * This function is used to determine the 'next' bio in the list, given the
> + * sector of the current stripe+device
> + */
> +static inline struct bio *
> +r5_next_bio(struct r5conf *conf, struct bio *bio, sector_t sector)
> +{
> +       if (bio_end_sector(bio) < sector + conf->stripe_sectors)
> +               return bio->bi_next;
> +       else
> +               return NULL;
> +}
> +
>  extern void md_raid5_kick_device(struct r5conf *conf);
>  extern int raid5_set_cache_size(struct mddev *mddev, int size);
>  extern sector_t raid5_compute_blocknr(struct stripe_head *sh, int i, int previous);
> --
> 2.25.4
>
