Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32E46B4F
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNUzi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 16:55:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33166 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNUzh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 14 Jun 2019 16:55:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so2607370qkc.0
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVW0k1wD+mT6yVCmR8qVHgZcB3RiYl2RsRwrPRUFrek=;
        b=uHEtjPJ/D1tIz7hLAsj+WdloNvvraUUJs7U2E4xqvLy8eUmqKmTS34sNw315uA7nTl
         htD4n8XpFpAZ6ISTfTrU0YsgXvOfHtln0gIDlJCRNA1svizab0rHGM2hDBgb2L2K3rFu
         o4hCiFGOAjpwikaD+yfBYdxMqP8UTRa2L/ljg4A/thd8lBfPTM4FR3X2LhRhqqPV+hMQ
         6xYtdSTErRsT9ARF9hEE6ERBA+Dn57gQkT/GWRuPdULmwDkgGllWUjINjzbjg7ekNOtV
         YcHP2u53S+tQL+3016/J3dl9CoyA+CUhksmt59KDn7UjhiKaxGYV6sjsvj2kIAiO0X92
         QFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVW0k1wD+mT6yVCmR8qVHgZcB3RiYl2RsRwrPRUFrek=;
        b=XwE96BElq1sWLEqynM8cQDlCiyKvPj6kXj9oIhem9t0QJprP6MSZkcJBL9LFbfIfU2
         uepKfViQVO3qCVMUxLib+Gopc27g2RJNWALo22NdLPaaxP6xhe7K1juQBcprROWagRBz
         e6eBX2nu/qMVWlAG35I4Y/4cCSWTomYvILdStia0WFLOBuZDaJqcoNObPWVBa86q6xrp
         dXcomSuI8LgtSigaMfHoXGZqfqq7C9FBdIxnVZss/Q3UJfWzZ0GBFvc7qbXhjmihnKb3
         b7Ff4zm41s1HwbTp9xXZO5B9icfQP9mpnpvCNe/M5deT8dVQ+C0GCORqL4DUti54tQJb
         WEiw==
X-Gm-Message-State: APjAAAXzMxap+7sLAncD0aqvK7988Sy1l6K5gAcBxNhQ+MXOzDXcST8q
        q6ZFpqauTGeWVQId3d757ZK4L9b0zT25Cv+o9ylTdQ==
X-Google-Smtp-Source: APXvYqy/XBZeC9XPWaH+eV21qfVY/5xQ9s7qO6zTdB0aSdx7wIVB93cf/Ul05NqL+ZyIwAE+Uyq5zPQl8TQ5PwxzDLc=
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr22069949qkl.202.1560545736730;
 Fri, 14 Jun 2019 13:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190613092609.9276-1-gqjiang@suse.com>
In-Reply-To: <20190613092609.9276-1-gqjiang@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 14 Jun 2019 13:55:25 -0700
Message-ID: <CAPhsuW4bZW1aA21SjY-5c0bHTgBaAnWigjBsxdryVYzPzK1EiQ@mail.gmail.com>
Subject: Re: [PATCH V2] md/raid10: read balance chooses idlest disk for SSD
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jun 13, 2019 at 2:05 AM Guoqing Jiang <gqjiang@suse.com> wrote:
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

Thanks Guoqing! I will process the patch.

Song

> ---
> v2:
> 1. use "bool has_nonrot_disk = false" per Song's comment.
>
>  drivers/md/raid10.c | 45 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index aea11476fee6..bd9d29f46834 100644
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
> +       bool has_nonrot_disk = false;
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
