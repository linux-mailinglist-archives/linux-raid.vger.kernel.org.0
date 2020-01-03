Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBFB12FD3E
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 20:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgACTs3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 14:48:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36596 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgACTs2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 14:48:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so35012297qkc.3
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1suEM0Se8YTK6HgtfKDPggX5x8w2o50vcGFsb+a4L8=;
        b=TZiIXVo+eL2zFhQmAoe7h6hxxWAqPuGsAM7HM/drk00P03AQpgCQsY5klVUgo0KjSU
         EtcqlaWZYSZH4rkQC8bNOmx3ukA6+WezfD93kikIWBl19L2MXYrAO4MJQDyRlMmX75mN
         Z4juHIseU/fu95hDc9Ej+gKht+LiH9GGnx4c6yvOYpBPWXtmJHwpL0mnvdTRZTSUCqf3
         3s1VTXeuZyWlp22PDhobxXGH7X55e7Nj88IOAoegmG3nnCBH0wu4wicEQERKxjYBRazH
         V5wRgf9n0C97wTQeAAqKPiDUcCsdcJkmTD046nBuvSpv27wxECoyVr1Sy3F/8iu0Ep/f
         PlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1suEM0Se8YTK6HgtfKDPggX5x8w2o50vcGFsb+a4L8=;
        b=PYB3g1D5uy6oP+HpqB2zrnlkO1gYHc7ZnGXAilSRMBmcoyJUEZDbEH3uUmmeDerYZM
         zhCTMKBsxcZwWHfQMwB201ItMfHWS8xeVt1adw2/Ocu1DDfw2iloO3ChSVmHv8ZE1Vq8
         qLLL1AjrHQo7VM25SNGk4H5mPXQGHsbyyf7/DfnxGUrHqeb6kY9Tgv462aU1ygvzJg0t
         50qlpNd7CT7OocZmRm8j8MJsDvR1fsAPF3mHfitnN5MVuiWUXea4lS33HmnOcAXj6D25
         Uiwrn4BBMH7VpwyMPtqzYVTvacn3Phj4Z8DmoNwCNQQZIeJB0DZXeIswM7cpxO+p3xiz
         aDDA==
X-Gm-Message-State: APjAAAXmyKw8jGhqr9YgEj8Il7aR17nPPkkfulL/nSDhT0CfZFLa7iB8
        gFVfrrkWSweF8F3VsX7U5JhCeiblAJ7iUyehoUw=
X-Google-Smtp-Source: APXvYqzsVAQVMSxkHvTb7eGYV158JKfmKMFlMYgQN241zXS9R8DSHPY9EB44lPPcm1ZlvmD9zNKDs5joN+gPon8K6wc=
X-Received: by 2002:a37:7b43:: with SMTP id w64mr72047198qkc.203.1578080907963;
 Fri, 03 Jan 2020 11:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 11:48:17 -0800
Message-ID: <CAPhsuW7qPsc-bZJpAV7H2qjX2MBdW8fusN7TyNphp7bF2SnB9g@mail.gmail.com>
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jan 3, 2020 at 5:56 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
[...]
> ---
>  drivers/md/raid5.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index d4d3b67ffbba..70ef2367fa64 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5481,7 +5481,9 @@ static void release_stripe_plug(struct mddev *mddev,
>                         INIT_LIST_HEAD(cb->temp_inactive_list + i);
>         }
>
> -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
> +       if (!atomic_read(&sh->count) == 0 &&
"!atomic_read(&sh->count) == 0" is confusing. Do you actually mean
"atomic_read(&sh->count) == 0"?

Thanks,
Song
