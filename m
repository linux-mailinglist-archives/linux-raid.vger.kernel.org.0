Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98A61E63D2
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbgE1OXv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 10:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391160AbgE1OXs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 10:23:48 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA92208DB
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590675828;
        bh=PgPvUQb1lPZjMZACA88M6QKDNE9lAAgHoIkur1p6qL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E/+DPXOQ2+ECmU0DojyX7gTz7mROTHjdo6a9+Rqtz7pl+Gomr3pUCc2RDAIDdCdZl
         E6DansdHw1thFqxOngF9v+0eWL7yf/qLqYVHHZRzfHrh9w/xmDiKxJNSTX6FjCoUdL
         F3BmzjZeHLMAqgi6ptLZEYf6wtQPVV2bwbte3wvc=
Received: by mail-lj1-f169.google.com with SMTP id v16so33650737ljc.8
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 07:23:47 -0700 (PDT)
X-Gm-Message-State: AOAM532vSHBvjizUPBWQkp5BtIzWOOnfLC6HzQWjkUqVEJcw5SLmnDh/
        FjWp+ej/VM6qHKIWoF5pB5JNSx+xHqdFjeRnOPA=
X-Google-Smtp-Source: ABdhPJwI6B1x6ynYJgWg/EnMJn9/jx85bweMPbUmWgMyGxc/1cK4+ld98FuoTo4G8v4bqLO/pZcytLqt3g0Ohz+hX18=
X-Received: by 2002:a2e:9093:: with SMTP id l19mr1691552ljg.27.1590675826113;
 Thu, 28 May 2020 07:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200527131933.34400-1-yuyufen@huawei.com> <20200527131933.34400-2-yuyufen@huawei.com>
In-Reply-To: <20200527131933.34400-2-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 May 2020 07:23:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7JLcWDEwEcN-6c+NHhMD1qrPtPNPa-k8y9SX3bVX_FzA@mail.gmail.com>
Message-ID: <CAPhsuW7JLcWDEwEcN-6c+NHhMD1qrPtPNPa-k8y9SX3bVX_FzA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] md/raid5: add CONFIG_MD_RAID456_STRIPE_SHIFT to
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

On Wed, May 27, 2020 at 6:20 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
[...]
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index f90e0704bed9..b25f107dafc7 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -472,7 +472,9 @@ struct disk_info {
>   */
>
>  #define NR_STRIPES             256
> -#define STRIPE_SIZE            PAGE_SIZE
> +#define CONFIG_STRIPE_SIZE     (CONFIG_MD_RAID456_STRIPE_SHIFT << 9)
> +#define STRIPE_SIZE            \
> +       (CONFIG_STRIPE_SIZE > PAGE_SIZE ? PAGE_SIZE : CONFIG_STRIPE_SIZE)
>  #define STRIPE_SHIFT           (PAGE_SHIFT - 9)

I think we also need to update STRIPE_SHIFT.

Thanks,
Song
