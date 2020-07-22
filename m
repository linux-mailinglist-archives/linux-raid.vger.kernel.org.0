Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD425229D14
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGVQ06 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVQ06 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jul 2020 12:26:58 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5369C0619E2
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 09:26:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so1824864ili.6
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kHXQvVGBuGkaVHirVH2ldXpqiigd2kMJlKCki7PqMg=;
        b=ra98AzIYvVtLIKFmQ0582LpmVzZLDFtXPiDLxSIB7SoDAYKfzHUmecVZxZuP/M6Pvb
         fDufO1C+Q4FiAbYniw6ePsXq6IniiF94IvlcqmWtmSWtqcN5EqOCbg+nsxHw7v2/BzpD
         yqdQ4eKGDs88B1pTQ+/lVZ3atNYajhFCrKFlxc6iGCv2w9U5QibkcB5fjdiaYFspwg/7
         DUAeDu27aJnyG2kaxKFRHFuV9pRJvCocGy9/pSs9I4O2w31H+artkiu+wABWqj20BtFU
         4mfkDrAHear+tV6pm6mm5Q1TEtNXZAq/Blh918qa8SfTMXEI9nUlQIkjpdOHfrsto+Ju
         hfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kHXQvVGBuGkaVHirVH2ldXpqiigd2kMJlKCki7PqMg=;
        b=q9v3mOt0Y7mHBp+bqJyUNTBHPK3pug7a/uA7sGJ14lNb3uINaOwrD2Clo+BwVuqP1x
         Jqi5pxK7UzfMThZFd/LpKp4SsWRLjfo2h/S59T360G5itBc7pXNMJg3dWZVVRs+YqL/1
         gkHojw2ndYdjDrfMUvk3mxIS1qOGhBsmSOlCsJUGuIjC6EiDMN5Plf6g8orfUNI654Zv
         4pGDaKDMDqUMuDgjWY+XB5fky9XjM8qdHg8F00j5Pcxn2hSs1G4e4TI15bb4b4gvQDHF
         Mvf3pN3JIpY3TTUhlDzNmn8IuspcNIRW+Zxx8m9TrxLJ237vntXvFF5kHOpIC6VNFeQe
         vfFQ==
X-Gm-Message-State: AOAM531uxHUNR/u+M6oYCveveqPbn/QlqYcu18trKH2b3dj9nQinXaut
        7QjviovSwYLHtcTN1UsB3sj1ZQ36g6HVhAXZCOfVMQ==
X-Google-Smtp-Source: ABdhPJzNeJo6F0VTZ0S6U9fuGWdBKZjH6dGksbNLyWqgmXOtrkpA/UinCG7oju3HCUHK5DY6DzL72Fr4547fWGtbqgk=
X-Received: by 2002:a05:6e02:1253:: with SMTP id j19mr673988ilq.145.1595435216934;
 Wed, 22 Jul 2020 09:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200722062552.212200-1-hch@lst.de> <20200722062552.212200-12-hch@lst.de>
In-Reply-To: <20200722062552.212200-12-hch@lst.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Jul 2020 09:26:45 -0700
Message-ID: <CALvZod6zF7Ak8KWf4dq0pEF2ty7JN_SyNE7PxLjrfF+EuDbZ2w@mail.gmail.com>
Subject: Re: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 21, 2020 at 11:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
> is not set, as the device won't support it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page_io.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ccda7679008851..442061348dfb26 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -403,15 +403,17 @@ int swap_readpage(struct page *page, bool synchronous)
>                 goto out;
>         }
>
> -       ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> -       if (!ret) {
> -               if (trylock_page(page)) {
> -                       swap_slot_free_notify(page);
> -                       unlock_page(page);
> -               }
> +       if (sis->flags & SWP_SYNCHRONOUS_IO) {
> +               ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> +               if (ret) {

!ret

> +                       if (trylock_page(page)) {
> +                               swap_slot_free_notify(page);
> +                               unlock_page(page);
> +                       }
>
> -               count_vm_event(PSWPIN);
> -               goto out;
> +                       count_vm_event(PSWPIN);
> +                       goto out;
> +               }
>         }
>
>         ret = 0;
> --
> 2.27.0
>
