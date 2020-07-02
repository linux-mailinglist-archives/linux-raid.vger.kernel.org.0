Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E56212F97
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 00:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgGBWi4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 18:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgGBWiz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 18:38:55 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986F52075D
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593729534;
        bh=T5DqXyZzlDtiyFipQ6x2iPaXxHVrr8Q/l/LbE2+2OKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q4o21F6aOOQELvTak1gtQsIYqfudcYADCRU7N4tEipfBeWKVrotmm0f2FR+pKaX80
         DZiTo1Uy2vHa/B6PlVrvvo9JRCz+rcp9EGD7E1FcMkyUuZswbvfpeZKTH7tn2LHyWl
         p8FB9NAbRHmg5DqW48yTr3xyYVTzsj2zCfD9V0aY=
Received: by mail-lf1-f50.google.com with SMTP id o4so17213133lfi.7
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 15:38:54 -0700 (PDT)
X-Gm-Message-State: AOAM530MOXyTX8dvrJcgA+pX8WuLEPoNb+CWjgI9cVPK22BW3FqRA+0A
        ZvWF1e7aSHyRjADCRBgFjTI6wM43PByPueo5L7w=
X-Google-Smtp-Source: ABdhPJxThbZIEwnPoWMTh7bNov+9tPGBSQmg9Lf5+8tA+gSiuFT6qekP36pMQlQJutgmsSV9Qw0NcXUPHMdcfwQa820=
X-Received: by 2002:a19:6a14:: with SMTP id u20mr18688207lfu.172.1593729532973;
 Thu, 02 Jul 2020 15:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200702120628.777303-1-yuyufen@huawei.com> <20200702120628.777303-13-yuyufen@huawei.com>
In-Reply-To: <20200702120628.777303-13-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 15:38:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5rTOwd+hPsBobFWD4TWGO4pWMgwt5BVAt=Fnab71MC=w@mail.gmail.com>
Message-ID: <CAPhsuW5rTOwd+hPsBobFWD4TWGO4pWMgwt5BVAt=Fnab71MC=w@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] md/raid5: support config stripe_size by sysfs entry
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
> After this patch, we can adjust stripe_size by writing value into sysfs
> entry, likely, set stripe_size as 16KB:
>
>           echo 16384 > /sys/block/md1/md/stripe_size
>
> Show current stripe_size value:
>
>           cat /sys/block/md1/md/stripe_size
>
> stripe_size should not be bigger than PAGE_SIZE, and it requires to be
> multiple of 4096.

I think we can just merge 02/16 into this one.

>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/md/raid5.c | 69 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index f0fd01d9122e..a3376a4e4e5c 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6715,7 +6715,74 @@ raid5_show_stripe_size(struct mddev  *mddev, char *page)
>  static ssize_t
>  raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
>  {
> -       return -EINVAL;
> +       struct r5conf *conf = mddev->private;

We need mddev_lock(mddev) before accessing mddev->private.

> +       unsigned int new;
> +       int err;
> +       int nr;
> +
> +       if (len >= PAGE_SIZE)
> +               return -EINVAL;
> +       if (kstrtouint(page, 10, &new))
> +               return -EINVAL;
> +       if (!conf)
> +               return -ENODEV;
> +
> +       /*
> +        * When PAGE_SZIE is 4096, we don't need to modify stripe_size.
> +        * And the value should not be bigger than PAGE_SIZE.
> +        * It requires to be multiple of 4096.
> +        */
> +       if (PAGE_SIZE == 4096 || new % 4096 != 0 ||
> +                       new > PAGE_SIZE || new == 0)
> +               return -EINVAL;
> +
> +       if (new == conf->stripe_size)
> +               return len;
> +
> +       pr_debug("md/raid: change stripe_size from %u to %u\n",
> +                       conf->stripe_size, new);
> +
> +       err = mddev_lock(mddev);
> +       if (err)
> +               return err;
> +
> +       if (mddev->sync_thread ||
> +           test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
> +           mddev->reshape_position != MaxSector ||
> +           mddev->sysfs_active) {
> +               err = -EBUSY;
> +               goto out_unlock;
> +       }
> +
> +       nr = conf->max_nr_stripes;
> +
> +       /* 1. suspend raid array */
> +       mddev_suspend(mddev);
> +
> +       /* 2. free all old stripe_head */
> +       mutex_lock(&conf->cache_size_mutex);
> +       shrink_stripes(conf);
> +       BUG_ON(conf->max_nr_stripes != 0);


> +
> +       /* 3. set new stripe_size */
> +       conf->stripe_size = new;
> +       conf->stripe_shift = ilog2(new) - 9;
> +       conf->stripe_sectors = new >> 9;
> +
> +       /* 4. allocate new stripe_head */
> +       if (grow_stripes(conf, nr)) {
> +               pr_warn("md/raid:%s: couldn't allocate buffers\n",
> +                               mdname(mddev));
> +               err = -ENOMEM;
> +       }
> +       mutex_unlock(&conf->cache_size_mutex);
> +
> +       /* 5. resume raid array */
> +       mddev_resume(mddev);
> +
> +out_unlock:
> +       mddev_unlock(mddev);
> +       return err ?: len;
>  }
>
>  static struct md_sysfs_entry
> --
> 2.25.4
>
