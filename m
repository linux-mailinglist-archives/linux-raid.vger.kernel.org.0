Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA03D1CBB7E
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgEHX6V (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 May 2020 19:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgEHX6U (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 8 May 2020 19:58:20 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3932E24958
        for <linux-raid@vger.kernel.org>; Fri,  8 May 2020 23:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588982300;
        bh=57RdWdCLh6MnBZcoeeGAXbSu+DwqCGQU09DLLrGhanE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JI+ZVtxcwQLcyPFGyApD+7tnzVMlk5+oc/WLQGIJ9MFNIKwFViwnIbxCi5EtqAf6z
         uLSU5jxiZzN+HkbcASTt9XpLYRzHs6vVViMsp6TSBzNBojlTuPcAw/wZ8COj8mZy8c
         3yZ6gv+zzE/LtXbWBOB3VDB8eF4MYtu87MV1WfW8=
Received: by mail-lj1-f181.google.com with SMTP id u6so3471257ljl.6
        for <linux-raid@vger.kernel.org>; Fri, 08 May 2020 16:58:20 -0700 (PDT)
X-Gm-Message-State: AOAM532qsQENs1RjCw5am+W08AAH2qjDjvDMMzwuNhLGm52btqKRd7/k
        gOe5uZzJT5P5xur2xGgN3iinuVmtbyZ/2sNnn1c=
X-Google-Smtp-Source: ABdhPJymokNU+csjdCA9Z5kIJQXD/y5WhFS5BQUJs+IZg+aSi3/eBK6sN0aiU25Byn84P0sxk7rN0cVSDhGFscDn3As=
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr3176434ljl.235.1588982298341;
 Fri, 08 May 2020 16:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200421123952.49025-1-yuyufen@huawei.com> <20200421123952.49025-3-yuyufen@huawei.com>
In-Reply-To: <20200421123952.49025-3-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 May 2020 16:58:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4GxrgnToy=7HowOmWKBOqySdY=-n1KO-fYV+Thof7mtw@mail.gmail.com>
Message-ID: <CAPhsuW4GxrgnToy=7HowOmWKBOqySdY=-n1KO-fYV+Thof7mtw@mail.gmail.com>
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
[...]
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
> +
> +/*
> + * We want to 'compress' multiple buffers to one real page for
> + * stripe_head when PAGE_SIZE is biggger than STRIPE_SIZE. If their
> + * values are equal, no need to use this strategy. For now, it just
> + * support raid level less than 5.
> + */

I don't think "compress" is the right terminology here. It is more
like "share" a page.
Why not support raid6 here?

Overall, the set looks reasonable to me. Please revise and send another version.

Thanks,
Song



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
