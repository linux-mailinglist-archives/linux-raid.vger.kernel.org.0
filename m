Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16E1EB5FB
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jun 2020 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFBGs7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jun 2020 02:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgFBGs7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jun 2020 02:48:59 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511232072F
        for <linux-raid@vger.kernel.org>; Tue,  2 Jun 2020 06:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591080538;
        bh=EIO8LavPRmnEyZ1OXVBvLVQPdTUCNmODDeEHUmizUD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PHt5MG8E0T0rhUQPMmKNnEK54KzYp2viDAUdXhY/B1E8i8Cfah9RT9bUFQDYOS97e
         9WP7D88HunrkuOrVqLqBjGVrbxhVtqKqYfN/83nfFbkksoO18vhmshfVWTah+OZWwU
         jA6MAECSzu67DO2BrCrlN2XSPL9ORkQR+A5b6kho=
Received: by mail-lf1-f50.google.com with SMTP id 202so5466384lfe.5
        for <linux-raid@vger.kernel.org>; Mon, 01 Jun 2020 23:48:58 -0700 (PDT)
X-Gm-Message-State: AOAM530ugY0hiTwM6916b397Lijx82tFOceapwN/N/MARBEhC/2vKIrG
        KYas4If85sRo1Lw+1fkEND9gSb6u5OrSeZk+tKo=
X-Google-Smtp-Source: ABdhPJyGrsZn4cTAZhzFKX+CDNJ+15hatyW6ANqE8PFLzRJAIuqdDEs6H+dG4VpT/FJafzqJyijdQKzczeia7f4z/Xw=
X-Received: by 2002:a19:4206:: with SMTP id p6mr13060511lfa.52.1591080536703;
 Mon, 01 Jun 2020 23:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
In-Reply-To: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Jun 2020 23:48:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4fjc4NgFGQUPuAKSvtWvtzyPor876anj64NF=nqaPo5g@mail.gmail.com>
Message-ID: <CAPhsuW4fjc4NgFGQUPuAKSvtWvtzyPor876anj64NF=nqaPo5g@mail.gmail.com>
Subject: Re: [PATCH] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Artur,

Thanks for the patch.

On Mon, Jun 1, 2020 at 9:13 AM Artur Paszkiewicz
<artur.paszkiewicz@intel.com> wrote:
>
> Use generic io accounting functions to manage io stats. There was an
[...]

> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> ---
>  drivers/md/md.c | 65 +++++++++++++++++++++++++++++++++++++++----------
>  drivers/md/md.h |  1 +
>  2 files changed, 53 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f567f536b529..5a9f167ef5b9 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -463,12 +463,32 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
>  }
>  EXPORT_SYMBOL(md_handle_request);
>
>

[...]

>
> -       /*
> -        * save the sectors now since our bio can
> -        * go away inside make_request
> -        */
> -       sectors = bio_sectors(bio);
> +       if (bio->bi_pool != &mddev->md_io_bs) {
> +               struct bio *clone;
> +               struct md_io *md_io;
> +
> +               clone = bio_clone_fast(bio, GFP_NOIO, &mddev->md_io_bs);

Handle clone == NULL?

Also, have you done benchmarks with this change?

Song
