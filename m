Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738B63D254
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404312AbfFKQeg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 12:34:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32846 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404082AbfFKQef (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 12:34:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id x2so14409935qtr.0
        for <linux-raid@vger.kernel.org>; Tue, 11 Jun 2019 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pT9eQXdki6TSUp3Mvxy9Pqpx/lxEeoP8iUkwcEdcz+k=;
        b=Fdjqp0s70uOpKjyJk2QPJyXZ2BxgaNN/ElictSCzojKJAuSkkGYy72ElQxTq5H0JcE
         fnlJCLmuRk4dg1B3ZqohOnIhvoEc0EDuGfASqUa60OCzUGHYC54xgVQESJlwLovrx/u1
         U1h84ABfWW77Ev/izsa+Z/KpUV5Dqki27eo9Y4NIL1LwQv7du0/AdXWBZ9LYX1O4yeoJ
         QN7iWt/vAsN5bNWDtRWKvPQ1qKHDCyMEqN2EaDLQVwhiIQ1/o4iPGWEqPjw6Azzcn2VJ
         QyR0If/SDldXjSjhEFE0OhKiRxjN6r6WFJ/g1stgHzPUT2OxL7D5g2shdJ14/SEsPjDa
         Td1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pT9eQXdki6TSUp3Mvxy9Pqpx/lxEeoP8iUkwcEdcz+k=;
        b=PglAubIY76JSw9Di9BWE58XDo58ck/djhyZr/nvFIjiTnS+/dkbGeY3oWG0+cCb6hp
         L607VYvzVoEj22kS39nxh4XO8668gYFalhDbe0tG8NFNKnloPJpj31cXdWzVoMXGBwIf
         cxZAL/izW8fXhqTQ3f8WbSBQiMDJoyYf9pbrKsZhFDAf08HtzN+lneaUrcc2Ak+fA88u
         hNT+S9i3+np7r/Y/dRgFTekRZu3sHyvStYv/Rc2hICtL64MgXqfW2+bjvFhiu19eTnq1
         MdhK9eAxyvbodjWbECP6iqfEbuZXcppFT51P5y2WT0Th3DZiQH4PXeu18Rbjs/AYd0uk
         ufNw==
X-Gm-Message-State: APjAAAW45wPpsPvaCENt/M+7KIhNHHCloE/zBBGOySrZTEvZqgYvnJk4
        lDL3fOdZZxJCb3NxRpLxUuaXZfMQC/trFEfsAqTfMQ==
X-Google-Smtp-Source: APXvYqy2gCP7L50+8ZfY3WfkajsImm1rzXsTDhtqVirVoRzASYS4hS2I2unQ/atd376xhgQPT1gtfItrb5yTNMsrfCU=
X-Received: by 2002:a0c:8965:: with SMTP id 34mr41680272qvq.26.1560270874778;
 Tue, 11 Jun 2019 09:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190611073311.14120-1-gqjiang@suse.com>
In-Reply-To: <20190611073311.14120-1-gqjiang@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 11 Jun 2019 09:34:23 -0700
Message-ID: <CAPhsuW5+iZ333gE57y2=j7AjdF4VCT1LzZMo=L+ZCUG5F+weYw@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: read balance chooses idlest disk for SSD
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 12:17 AM Guoqing Jiang <gqjiang@suse.com> wrote:
>
> Andy reported that raid10 array with SSD disks has poor
> read performance. Compared with raid1, RAID-1 can be 3x
> faster than RAID-10 sometimes [1].
>
> The thing is that raid10 chooses the low distance disk
> for read request, however, the approach doesn't work
> well for SSD device since it doesn't have spindle like
> HDD, we should just read from the SSD which has less
> pending IO like commit 9dedf60313fa4 ("md/raid1: read
> balance chooses idlest disk for SSD").
>
> So this commit selects the idlest SSD disk for read if
> array has none rotational disk, otherwise, read_balance
> uses the previous distance priority algorithm. With the
> change, the performance of raid10 gets increased largely
> per Andy's test [2].
>
> [1]. https://marc.info/?l=linux-raid&m=155915890004761&w=2
> [2]. https://marc.info/?l=linux-raid&m=155990654223786&w=2
>
> Tested-by: Andy Smith <andy@strugglers.net>
> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
> ---
>  drivers/md/raid10.c | 45 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index aea11476fee6..6e5721f2a074 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -737,15 +737,19 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>         int sectors = r10_bio->sectors;
>         int best_good_sectors;
>         sector_t new_distance, best_dist;
> -       struct md_rdev *best_rdev, *rdev = NULL;
> +       struct md_rdev *best_dist_rdev, *best_pending_rdev, *rdev = NULL;
>         int do_balance;
> -       int best_slot;
> +       int best_dist_slot, best_pending_slot;
> +       int has_nonrot_disk = 0;

nit: Maybe bool has_nonrot_disk = false?

> +       unsigned int min_pending;
>         struct geom *geo = &conf->geo;
>
>         raid10_find_phys(conf, r10_bio);
>         rcu_read_lock();
> -       best_slot = -1;
> -       best_rdev = NULL;
> +       best_dist_slot = -1;
> +       min_pending = UINT_MAX;
> +       best_dist_rdev = NULL;
> +       best_pending_rdev = NULL;
>         best_dist = MaxSector;
>         best_good_sectors = 0;
>         do_balance = 1;
> @@ -767,6 +771,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>                 sector_t first_bad;
>                 int bad_sectors;
>                 sector_t dev_sector;
> +               unsigned int pending;
> +               bool nonrot;
>
>                 if (r10_bio->devs[slot].bio == IO_BLOCKED)
>                         continue;
> @@ -803,8 +809,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>                                         first_bad - dev_sector;
>                                 if (good_sectors > best_good_sectors) {
>                                         best_good_sectors = good_sectors;
> -                                       best_slot = slot;
> -                                       best_rdev = rdev;
> +                                       best_dist_slot = slot;
> +                                       best_dist_rdev = rdev;
>                                 }
>                                 if (!do_balance)
>                                         /* Must read from here */
> @@ -817,14 +823,23 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>                 if (!do_balance)
>                         break;
>
> -               if (best_slot >= 0)
> +               nonrot = blk_queue_nonrot(bdev_get_queue(rdev->bdev));
> +               has_nonrot_disk |= nonrot;
> +               pending = atomic_read(&rdev->nr_pending);
> +               if (min_pending > pending && nonrot) {
> +                       min_pending = pending;
> +                       best_pending_slot = slot;
> +                       best_pending_rdev = rdev;
> +               }
> +
> +               if (best_dist_slot >= 0)
>                         /* At least 2 disks to choose from so failfast is OK */
>                         set_bit(R10BIO_FailFast, &r10_bio->state);
>                 /* This optimisation is debatable, and completely destroys
>                  * sequential read speed for 'far copies' arrays.  So only
>                  * keep it for 'near' arrays, and review those later.
>                  */
> -               if (geo->near_copies > 1 && !atomic_read(&rdev->nr_pending))
> +               if (geo->near_copies > 1 && !pending)
>                         new_distance = 0;
>
>                 /* for far > 1 always use the lowest address */
> @@ -833,15 +848,21 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>                 else
>                         new_distance = abs(r10_bio->devs[slot].addr -
>                                            conf->mirrors[disk].head_position);
> +
>                 if (new_distance < best_dist) {
>                         best_dist = new_distance;
> -                       best_slot = slot;
> -                       best_rdev = rdev;
> +                       best_dist_slot = slot;
> +                       best_dist_rdev = rdev;
>                 }
>         }
>         if (slot >= conf->copies) {
> -               slot = best_slot;
> -               rdev = best_rdev;
> +               if (has_nonrot_disk) {
> +                       slot = best_pending_slot;
> +                       rdev = best_pending_rdev;
> +               } else {
> +                       slot = best_dist_slot;
> +                       rdev = best_dist_rdev;
> +               }
>         }
>
>         if (slot >= 0) {
> --
> 2.12.3
>
