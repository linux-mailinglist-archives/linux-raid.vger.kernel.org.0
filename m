Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA241C9FDB
	for <lists+linux-raid@lfdr.de>; Fri,  8 May 2020 02:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHA5M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 20:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEHA5M (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 May 2020 20:57:12 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC1821473
        for <linux-raid@vger.kernel.org>; Fri,  8 May 2020 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588899431;
        bh=zjkRhnVUGVk3w8Bf1rrtenXf0RkixbJEZRTBUEphX8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J2Fu1vegdE1PdfH7ICP+mDVQNgZo3v9mAqCMTEE7XoaB/gzkdEsIEe7XIkRBKWdbd
         F8ObmhvToTdZwq0JFk2pAR5tLTwIQjSckQn/5cLVruftUSxNoB2vvNBzPcmcGIkP/b
         XR3vNFGJrGPTwsyI+Y/z7WFJ1zyCWMbaHfDVd/hI=
Received: by mail-lf1-f41.google.com with SMTP id a4so63299lfh.12
        for <linux-raid@vger.kernel.org>; Thu, 07 May 2020 17:57:11 -0700 (PDT)
X-Gm-Message-State: AOAM5335gC/FL1SVEYdTQmgc57An0vfEiY6L9rVFWfq6Px84Yog7e3Pk
        AJGuUXKlrkNjuDPg9YoP+riDFL279ILEOhpiewI=
X-Google-Smtp-Source: ABdhPJzD0K5wlbMboGnSd8MKnxkVFO2hWSST0cKM0YsF/aZCrrYpKleFFLhUhgbEgUoFI+lWWi+awiPI1LpObourPdU=
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr126743lfe.162.1588899429317;
 Thu, 07 May 2020 17:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200421123952.49025-1-yuyufen@huawei.com> <20200421123952.49025-2-yuyufen@huawei.com>
In-Reply-To: <20200421123952.49025-2-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 May 2020 17:56:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4qoT-nGA4RvGhxvabkNsz=x_gseWN7hzp4SFCHdsEZTw@mail.gmail.com>
Message-ID: <CAPhsuW4qoT-nGA4RvGhxvabkNsz=x_gseWN7hzp4SFCHdsEZTw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/8] md/raid5: add CONFIG_MD_RAID456_STRIPE_SIZE to
 set STRIPE_SIZE
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
[...]
> Thus, we provide a configure to set STRIPE_SIZE when PAGE_SIZE is bigger
> than 4096. Normally, default value (4096) can get relatively good
> performance. But if each issued io is bigger than 4096, setting value more
> than 4096 may get better performance.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

I am sorry for the delay response.

> ---
>  drivers/md/Kconfig | 18 ++++++++++++++++++
>  drivers/md/raid5.h |  4 +++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index d6d5ab23c088..05c5a315358b 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -157,6 +157,24 @@ config MD_RAID456
>
>           If unsure, say Y.
>
> +config MD_RAID456_STRIPE_SIZE
> +       int "RAID4/RAID5/RAID6 stripe size"
> +       default "4096"
> +       depends on MD_RAID456
> +       help
> +         The default value is 4096. Just setting a new value when PAGE_SIZE
> +         is bigger than 4096.  In that case, you can set it as more than
> +         4096, such as 8KB, 16K, 64K, which requires that be a multiple of
> +         4K.
> +
> +         When you try to set a big value, likely 64KB on arm64, that means,
> +         you know size of each io that issued to raid device is more than
> +         4096. Otherwise just use default value.
> +
> +         Normally, using default STRIPE_SIZE can get better performance.
> +         Only change this value if you know what you are doing.
> +
> +
>  config MD_MULTIPATH
>         tristate "Multipath I/O support"
>         depends on BLK_DEV_MD
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index f90e0704bed9..b0010991bdc8 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -472,7 +472,9 @@ struct disk_info {
>   */
>
>  #define NR_STRIPES             256
> -#define STRIPE_SIZE            PAGE_SIZE
> +#define STRIPE_SIZE    \
> +       ((PAGE_SIZE > 4096 && (CONFIG_MD_RAID456_STRIPE_SIZE % 4096 == 0)) ? \
> +        CONFIG_MD_RAID456_STRIPE_SIZE : PAGE_SIZE)

How about we make the config multiple of 4kB? So 4096 will be 1, 8192 will be 2.

Thanks,
Song
