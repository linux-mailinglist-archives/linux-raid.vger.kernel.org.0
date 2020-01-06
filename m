Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77BC131697
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAFRSO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 12:18:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46439 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgAFRSN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 12:18:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so2664996qtr.13
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+c4Fho2bOLH8ea21tcLJv6BCK+33XGJdI9tJq/M1kA=;
        b=GgDdSXHHF0SbkmgqrPGA+tFN1tsy+t8lb90wYWh6TAO/rlgwotedGVlLOkmtHX/y55
         wzP+JWGCDHl9U9+Az16orInBG2fm3AxH6hopjjhKiN+YfNr+yOmMKJQDAtzMCh0lG47e
         ry+aZiPy1vlG76923+9rvNsmOSXwXlXcyS09vrKLSACOMCJwzSC/Gb2vXqcY+izmPohi
         s5srFxTPINS+fN4vSvD0eZnhAcc0bB6jAXYH+7Lq4gyb6iqXLwrYNqSzEU4nWquidpXu
         Me9VDxuvidw8LmTi5EPhq+99JJKRQXhnBNeVB0H+MHWjuiks/A3jY6j3JqCvDXBgTI5A
         dqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+c4Fho2bOLH8ea21tcLJv6BCK+33XGJdI9tJq/M1kA=;
        b=oYhRz1wRaHQfegTRX8f9pX6dDmxMIwzTIf7UGoLVIDO8ZxrFmY0OIdfBvoNprkZqg1
         v3fVudih4ROdjagi/yHn+tWTFmYXxOGHmticIBEGo6HEGJYh3j+12UotwBK6mB5X1kjW
         3UPwu3pqcpZAOs/23XtRHfOLQz3ylTcKQjIBp0pO9iksO92eujCVxBsIljZ3O7Y/G4oI
         H54qbjkbojF/k/GRkk41eItEhqqqlyFive+WxeEkjEoc9T0774BGFtTZnYKFsXzkEsHn
         97mLVaLa5qW4uomBvSq1NpY+8M9aCrSEjH/cS7gfN3wxGt4OmtDl6W7ElKQTH64wdTwe
         wPYw==
X-Gm-Message-State: APjAAAWH0ElI9x+Z/35I23Xrb9TfymIyn94Aygq+23D/kF7BdOnZxD0m
        Wh/NAFb6XuNhfXJPUHGOKWd051QfmpgyiG5ICIQ=
X-Google-Smtp-Source: APXvYqy6E7ZfoMX8VuiT4ZWTJuwzg8bZTM5RIkABuNdVhulPHxgopLRK6nBpyzKVwpQJh99vp8jMWWXr1MKluZkgc1w=
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr76340953qtv.308.1578331092861;
 Mon, 06 Jan 2020 09:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
 <20191223094902.12704-11-guoqing.jiang@cloud.ionos.com> <CAPhsuW5WGdsvse_dPf1cG7Yj-TR6-+653ik1bJvjrNedtD-dPw@mail.gmail.com>
 <4eeb2d0b-de15-a8ac-3923-86e64e72663f@cloud.ionos.com> <ef975b75-eb3c-c36e-2a1f-4b3bad920219@cloud.ionos.com>
In-Reply-To: <ef975b75-eb3c-c36e-2a1f-4b3bad920219@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 6 Jan 2020 09:18:01 -0800
Message-ID: <CAPhsuW55a_Dy3SXm5AGFZadw14qb8BWp_FcyzG4gMFTK2u6=cA@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] md/raid1: introduce wait_for_serialization
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 6, 2020 at 2:22 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 1/6/20 10:56 AM, Guoqing Jiang wrote:
> >
> >
> > On 1/4/20 12:15 AM, Song Liu wrote:
> >> On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
> >>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >>>
> >>> Previously, we call check_and_add_serial when serialization is
> >>> enabled for write IO, but it could allocate and free memory
> >>> back and forth.
> >>>
> >>> Now, let's just get an element from memory pool with the new
> >>> function, then insert node to rb tree if no collision happens.
> >>>
> >>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >>> ---
> >>>   drivers/md/raid1.c | 41 ++++++++++++++++++++++-------------------
> >>>   1 file changed, 22 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>> index 48d553d7989a..cd810e195086 100644
> >>> --- a/drivers/md/raid1.c
> >>> +++ b/drivers/md/raid1.c
> >>> @@ -56,32 +56,43 @@ static void lower_barrier(struct r1conf *conf,
> >>> sector_t sector_nr);
> >>>   INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t,
> >>> _subtree_last,
> >>>                       START, LAST, static inline, raid1_rb);
> >>>
> >>> -static int check_and_add_serial(struct md_rdev *rdev, sector_t lo,
> >>> sector_t hi)
> >>> +static int check_and_add_serial(struct md_rdev *rdev, struct r1bio
> >>> *r1_bio,
> >>> +                               struct serial_info *si, int idx)
> >>>   {
> >>> -       struct serial_info *si;
> >>>          unsigned long flags;
> >>>          int ret = 0;
> >>> -       struct mddev *mddev = rdev->mddev;
> >>> -       int idx = sector_to_idx(lo);
> >>> +       sector_t lo = r1_bio->sector;
> >>> +       sector_t hi = lo + r1_bio->sectors;
> >>>          struct serial_in_rdev *serial = &rdev->serial[idx];
> >>>
> >>> -       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
> >>> -
> >>>          spin_lock_irqsave(&serial->serial_lock, flags);
> >>>          /* collision happened */
> >>>          if (raid1_rb_iter_first(&serial->serial_rb, lo, hi))
> >>>                  ret = -EBUSY;
> >>> -       if (!ret) {
> >>> +       else {
> >>>                  si->start = lo;
> >>>                  si->last = hi;
> >>>                  raid1_rb_insert(si, &serial->serial_rb);
> >>> -       } else
> >>> -               mempool_free(si, mddev->serial_info_pool);
> >>> +       }
> >>>          spin_unlock_irqrestore(&serial->serial_lock, flags);
> >>>
> >>>          return ret;
> >>>   }
> >>>
> >>> +static void wait_for_serialization(struct md_rdev *rdev, struct
> >>> r1bio *r1_bio)
> >>> +{
> >>> +       struct mddev *mddev = rdev->mddev;
> >>> +       struct serial_info *si;
> >>> +       int idx = sector_to_idx(r1_bio->sector);
> >>> +       struct serial_in_rdev *serial = &rdev->serial[idx];
> >>> +
> >>> +       if (WARN_ON(!mddev->serial_info_pool))
> >>> +               return;
> >>> +       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
> >>> +       wait_event(serial->serial_io_wait,
> >>> +                  check_and_add_serial(rdev, r1_bio, si, idx) == 0);
> >> Are we leaking si when raid1_rb_iter_first() failed?
> >
>
> Now, 'si' is only allocated once before wait_event, if check_and_add_serial
> returns -EBUSY, then

Ah, I missed the wait part.

Applied the series to md-next.

Thanks,
Song
