Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3993E212F58
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 00:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGBWOr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 18:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGBWOq (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 18:14:46 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2D1208B8
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593728086;
        bh=teal2bqh1joC5O7M6tnN3zYSHGbA0zmB87TuDGslmAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uNshThmCHI288KKMJXyPbfV/+Pu19FbuT+fIon/aPNr+ePFuPVvTWTzvBINw//hPU
         fPV9Aj2N5wM1CWJzhU5DuSJnNxag3jlzwEHRhcciuLLIE47UcDn8cZ2f/wzeR/Z9Tf
         5caoUCay/30c9OVb4gsaRE0s1hN5p7ENg8+9C6J0=
Received: by mail-lf1-f42.google.com with SMTP id t9so17152331lfl.5
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 15:14:45 -0700 (PDT)
X-Gm-Message-State: AOAM532gXTis+pZ7rBRywZs/g55IbX5x+S8Tbrniqhf78Q74AuKq6B3Y
        1vAjkGHcLj3RNgNaGhiSf1cFKLD/XMktJM6+P58=
X-Google-Smtp-Source: ABdhPJxvpdnUE5DHvSwd6UeqcpCHCZatSBzqU3aJ2WueLaTmHWemWZVo5sRoB9ui0rbgAprYvXpXKpzFpoAkMj0q3Ms=
X-Received: by 2002:a19:701:: with SMTP id 1mr19471835lfh.138.1593728084219;
 Thu, 02 Jul 2020 15:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200702120628.777303-1-yuyufen@huawei.com> <20200702120628.777303-3-yuyufen@huawei.com>
In-Reply-To: <20200702120628.777303-3-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 15:14:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7oDE_hD8=s1zZucn3khXWgrFh-CUewtSguM1KG6628mg@mail.gmail.com>
Message-ID: <CAPhsuW7oDE_hD8=s1zZucn3khXWgrFh-CUewtSguM1KG6628mg@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] md/raid5: add sysfs entry to set and show stripe_size
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
> Here, we don't support setting stripe_size by sysfs.
> Following patches will do that.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/md/raid5.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 2981b853c388..51bc39dab57b 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6518,6 +6518,27 @@ raid5_rmw_level = __ATTR(rmw_level, S_IRUGO | S_IWUSR,
>                          raid5_show_rmw_level,
>                          raid5_store_rmw_level);
>
> +static ssize_t
> +raid5_show_stripe_size(struct mddev  *mddev, char *page)
> +{
> +       struct r5conf *conf = mddev->private;
> +
> +       if (conf)
> +               return sprintf(page, "%d\n", conf->stripe_size);
> +       else
> +               return 0;
> +}
> +
> +static ssize_t
> +raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
> +{
> +       return -EINVAL;
> +}

How about we make the file read only for now?

Song
