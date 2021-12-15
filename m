Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870B476394
	for <lists+linux-raid@lfdr.de>; Wed, 15 Dec 2021 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhLOUma (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Dec 2021 15:42:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41772 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhLOUma (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Dec 2021 15:42:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F17BDB816C2
        for <linux-raid@vger.kernel.org>; Wed, 15 Dec 2021 20:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E1EC36AE5
        for <linux-raid@vger.kernel.org>; Wed, 15 Dec 2021 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639600947;
        bh=ChETt0N1KVegQjEPnHx2jk+pU2CLZcDt3xka93cHc8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UwXaLeg5Oqpib1/LIr+KLWwmJR12roO5rIZE1KQttCuxRkJT9V3891xgSnAey4Ddm
         pKIAv6CayNjHQrYFZX/09OHSvRUkFcFbIrO5nvG7wQAVmfhtl5YgAsLG1/CQZxzXw2
         meSsHgE8oBvRMyBDKqhE6tSnqDbzc/3iX0sHnfV+NnGkPwCRz3yLoNN4XCa71yCC6s
         flregAIdPlsUTgj61Zre7rtQzq8DJ7QJ5utKcXia720NeF4Y/quO4dFD3D0P1zLuUP
         Z2fgR+o+1AteS6jf9isBuH3/MThmv++F6iB56HtqSEtLk5nRcLcqcueVw7Ij6YFtt9
         vuUQHlrmex8wA==
Received: by mail-yb1-f178.google.com with SMTP id y68so58656024ybe.1
        for <linux-raid@vger.kernel.org>; Wed, 15 Dec 2021 12:42:27 -0800 (PST)
X-Gm-Message-State: AOAM531He+gTa1ZhFvsujyADLu9vFsmudDACA7WjzGx5CmgV7HoXBgVS
        aV5VbbznoU8g6BG4wkBj2j1dtecMzqllR/SfHO4=
X-Google-Smtp-Source: ABdhPJzy5nW/VDAO9SSxe3gGKjhnsWSvBh+Ru9wYnvMYLxo5M1lvhU89Jgr3US+uEMxhD8okHiDFoHaQ5yE5ZOTclvM=
X-Received: by 2002:a25:bf8f:: with SMTP id l15mr8525283ybk.670.1639600946785;
 Wed, 15 Dec 2021 12:42:26 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW7OY+5-F6Vk6z=ngSMXEayz3si=Sdf69r4vexRo202X_Q@mail.gmail.com>
 <20211215060906.3230-1-vverma@digitalocean.com> <20211215060906.3230-3-vverma@digitalocean.com>
In-Reply-To: <20211215060906.3230-3-vverma@digitalocean.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 15 Dec 2021 12:42:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5=GLRW9g2QxgBfcx_OKq08x5GqGO4iC86x6YzDHRz8fA@mail.gmail.com>
Message-ID: <CAPhsuW5=GLRW9g2QxgBfcx_OKq08x5GqGO4iC86x6YzDHRz8fA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] md: raid10 add nowait support
To:     Vishal Verma <vverma@digitalocean.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, rgoldwyn@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Dec 14, 2021 at 10:09 PM Vishal Verma <vverma@digitalocean.com> wrote:
>
> This adds nowait support to the RAID10 driver. Very similar to
> raid1 driver changes. It makes RAID10 driver return with EAGAIN
> for situations where it could wait for eg:
>
> - Waiting for the barrier,
> - Too many pending I/Os to be queued,
> - Reshape operation,
> - Discard operation.
>
> wait_barrier() fn is modified to return bool to support error for
> wait barriers. It returns true in case of wait or if wait is not
> required and returns false if wait was required but not performed
> to support nowait.
>
> Signed-off-by: Vishal Verma <vverma@digitalocean.com>
> ---
>  drivers/md/raid10.c | 57 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index dde98f65bd04..f6c73987e9ac 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -952,11 +952,18 @@ static void lower_barrier(struct r10conf *conf)
>         wake_up(&conf->wait_barrier);
>  }
>
> -static void wait_barrier(struct r10conf *conf)
> +static bool wait_barrier(struct r10conf *conf, bool nowait)
>  {
>         spin_lock_irq(&conf->resync_lock);
>         if (conf->barrier) {
>                 struct bio_list *bio_list = current->bio_list;
> +
> +               /* Return false when nowait flag is set */
> +               if (nowait) {
> +                       spin_unlock_irq(&conf->resync_lock);
> +                       return false;
> +               }
> +
>                 conf->nr_waiting++;
>                 /* Wait for the barrier to drop.
>                  * However if there are already pending
> @@ -988,6 +995,7 @@ static void wait_barrier(struct r10conf *conf)
>         }
>         atomic_inc(&conf->nr_pending);
>         spin_unlock_irq(&conf->resync_lock);
> +       return true;
>  }
>
>  static void allow_barrier(struct r10conf *conf)
> @@ -1101,17 +1109,25 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
>  static void regular_request_wait(struct mddev *mddev, struct r10conf *conf,
>                                  struct bio *bio, sector_t sectors)
>  {
> -       wait_barrier(conf);
> +       /* Bail out if REQ_NOWAIT is set for the bio */
> +       if (!wait_barrier(conf, bio->bi_opf & REQ_NOWAIT)) {
> +               bio_wouldblock_error(bio);
> +               return;
> +       }

I think we also need regular_request_wait to return bool and handle it properly.

Thanks,
Song

>         while (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
>             bio->bi_iter.bi_sector < conf->reshape_progress &&
>             bio->bi_iter.bi_sector + sectors > conf->reshape_progress) {
>                 raid10_log(conf->mddev, "wait reshape");
> +               if (bio->bi_opf & REQ_NOWAIT) {
> +                       bio_wouldblock_error(bio);
> +                       return;
> +               }
>                 allow_barrier(conf);
>                 wait_event(conf->wait_barrier,
>                            conf->reshape_progress <= bio->bi_iter.bi_sector ||
>                            conf->reshape_progress >= bio->bi_iter.bi_sector +
>                            sectors);
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>         }
>  }
>
> @@ -1179,7 +1195,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
>                 bio_chain(split, bio);
>                 allow_barrier(conf);
>                 submit_bio_noacct(bio);
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>                 bio = split;
>                 r10_bio->master_bio = bio;
>                 r10_bio->sectors = max_sectors;
> @@ -1338,7 +1354,7 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
>                 raid10_log(conf->mddev, "%s wait rdev %d blocked",
>                                 __func__, blocked_rdev->raid_disk);
>                 md_wait_for_blocked_rdev(blocked_rdev, mddev);
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>                 goto retry_wait;
>         }
>  }
> @@ -1357,6 +1373,11 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
>                                             bio_end_sector(bio)))) {
>                 DEFINE_WAIT(w);
>                 for (;;) {
> +                       /* Bail out if REQ_NOWAIT is set for the bio */
> +                       if (bio->bi_opf & REQ_NOWAIT) {
> +                               bio_wouldblock_error(bio);
> +                               return;
> +                       }
>                         prepare_to_wait(&conf->wait_barrier,
>                                         &w, TASK_IDLE);
>                         if (!md_cluster_ops->area_resyncing(mddev, WRITE,
> @@ -1381,6 +1402,10 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
>                               BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
>                 md_wakeup_thread(mddev->thread);
>                 raid10_log(conf->mddev, "wait reshape metadata");
> +               if (bio->bi_opf & REQ_NOWAIT) {
> +                       bio_wouldblock_error(bio);
> +                       return;
> +               }
>                 wait_event(mddev->sb_wait,
>                            !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
>
> @@ -1390,6 +1415,10 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
>         if (conf->pending_count >= max_queued_requests) {
>                 md_wakeup_thread(mddev->thread);
>                 raid10_log(mddev, "wait queued");
> +               if (bio->bi_opf & REQ_NOWAIT) {
> +                       bio_wouldblock_error(bio);
> +                       return;
> +               }
>                 wait_event(conf->wait_barrier,
>                            conf->pending_count < max_queued_requests);
>         }
> @@ -1482,7 +1511,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
>                 bio_chain(split, bio);
>                 allow_barrier(conf);
>                 submit_bio_noacct(bio);
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>                 bio = split;
>                 r10_bio->master_bio = bio;
>         }
> @@ -1607,7 +1636,11 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>         if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
>                 return -EAGAIN;
>
> -       wait_barrier(conf);
> +       if (bio->bi_opf & REQ_NOWAIT) {
> +               bio_wouldblock_error(bio);
> +               return 0;
> +       }
> +       wait_barrier(conf, false);
>
>         /*
>          * Check reshape again to avoid reshape happens after checking
> @@ -1649,7 +1682,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>                 allow_barrier(conf);
>                 /* Resend the fist split part */
>                 submit_bio_noacct(split);
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>         }
>         div_u64_rem(bio_end, stripe_size, &remainder);
>         if (remainder) {
> @@ -1660,7 +1693,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>                 /* Resend the second split part */
>                 submit_bio_noacct(bio);
>                 bio = split;
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>         }
>
>         bio_start = bio->bi_iter.bi_sector;
> @@ -1816,7 +1849,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>                 end_disk_offset += geo->stride;
>                 atomic_inc(&first_r10bio->remaining);
>                 raid_end_discard_bio(r10_bio);
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>                 goto retry_discard;
>         }
>
> @@ -2011,7 +2044,7 @@ static void print_conf(struct r10conf *conf)
>
>  static void close_sync(struct r10conf *conf)
>  {
> -       wait_barrier(conf);
> +       wait_barrier(conf, false);
>         allow_barrier(conf);
>
>         mempool_exit(&conf->r10buf_pool);
> @@ -4819,7 +4852,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
>         if (need_flush ||
>             time_after(jiffies, conf->reshape_checkpoint + 10*HZ)) {
>                 /* Need to update reshape_position in metadata */
> -               wait_barrier(conf);
> +               wait_barrier(conf, false);
>                 mddev->reshape_position = conf->reshape_progress;
>                 if (mddev->reshape_backwards)
>                         mddev->curr_resync_completed = raid10_size(mddev, 0, 0)
> --
> 2.17.1
>
