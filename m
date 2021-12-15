Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2A47635F
	for <lists+linux-raid@lfdr.de>; Wed, 15 Dec 2021 21:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhLOUdv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Dec 2021 15:33:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48222 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhLOUdu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Dec 2021 15:33:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C127617AD
        for <linux-raid@vger.kernel.org>; Wed, 15 Dec 2021 20:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC4C36AE4
        for <linux-raid@vger.kernel.org>; Wed, 15 Dec 2021 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639600429;
        bh=aqjA8y0g+lXlmLHNkACAEGh2HFnJ6YQeXEAkl//3Llc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6Krq5Zrx7v5dj+qEHuMiH9kb5e9V5+cqWHEPyC+9BizPK3Hev/ZLc8Ib82PYIBVt
         k7ohYVUrcCYmv/27Pkk2m4Ap493Y84IjhKeubRNaafpZtOq7vEM0RhqFsbQnGBpDq9
         Yu5e0JKe/sCYJoEWnnNS1F2Xz84LdTR8a07KUDZ7q5q6m8RHv5H59bHph5Eo5YBpYa
         Vyo7BaBlyi8ufU/B2bGgeSOXnNHIQEwmbPA+jLUO1PLszkDCX/FSMNewCHVR22tBMg
         OqD7f+xkZuMZ4s/6nX6BoSh+KMQgh0GTkEqeSK3FCHv8cUlZ366xCBsy72sEjRNFcK
         o3dzZmfakrJNQ==
Received: by mail-yb1-f179.google.com with SMTP id q74so58483070ybq.11
        for <linux-raid@vger.kernel.org>; Wed, 15 Dec 2021 12:33:49 -0800 (PST)
X-Gm-Message-State: AOAM531KKr7ViqtYFmnAjnCInINLOs4StZ90MEvPCVmhsNneG0WtpdNa
        JGEXodtdyKi9hxbsu8lqDq50Hcp8vJQupv6efVM=
X-Google-Smtp-Source: ABdhPJzUdEEXjMePgGfwU96euLc8SiDIMfJCTx7x6EgvBo+x5YZ15l06Bh+a7UI0qwVF4s7Lbz5mkozgD3RUe6CuSQI=
X-Received: by 2002:a25:850b:: with SMTP id w11mr8753354ybk.208.1639600428906;
 Wed, 15 Dec 2021 12:33:48 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW7OY+5-F6Vk6z=ngSMXEayz3si=Sdf69r4vexRo202X_Q@mail.gmail.com>
 <20211215060906.3230-1-vverma@digitalocean.com> <20211215060906.3230-2-vverma@digitalocean.com>
In-Reply-To: <20211215060906.3230-2-vverma@digitalocean.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 15 Dec 2021 12:33:38 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5vrMcyMHXNyyFUkzdHnWAGs+WUSLwkrrpyt81Bu3ap2g@mail.gmail.com>
Message-ID: <CAPhsuW5vrMcyMHXNyyFUkzdHnWAGs+WUSLwkrrpyt81Bu3ap2g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] md: raid1 add nowait support
To:     Vishal Verma <vverma@digitalocean.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, rgoldwyn@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Dec 14, 2021 at 10:09 PM Vishal Verma <vverma@digitalocean.com> wrote:
>
> This adds nowait support to the RAID1 driver. It makes RAID1 driver
> return with EAGAIN for situations where it could wait for eg:
>
> - Waiting for the barrier,
> - Array got frozen,
> - Too many pending I/Os to be queued.
>
> wait_barrier() fn is modified to return bool to support error for
> wait barriers. It returns true in case of wait or if wait is not
> required and returns false if wait was required but not performed
> to support nowait.

Please see some detailed comments below. But a general and more important
question: were you able to trigger these conditions (path that lead to
bio_wouldblock_error) in the tests?

Ideally, we should test all these conditions. If something is really
hard to trigger,
please highlight that in the commit log, so that I can run more tests on them.

Thanks,
Song

>
> Signed-off-by: Vishal Verma <vverma@digitalocean.com>
> ---
>  drivers/md/raid1.c | 74 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 7dc8026cf6ee..727d31de5694 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -929,8 +929,9 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr)
>         wake_up(&conf->wait_barrier);
>  }
>
> -static void _wait_barrier(struct r1conf *conf, int idx)
> +static bool _wait_barrier(struct r1conf *conf, int idx, bool nowait)
>  {
> +       bool ret = true;
>         /*
>          * We need to increase conf->nr_pending[idx] very early here,
>          * then raise_barrier() can be blocked when it waits for
> @@ -961,7 +962,7 @@ static void _wait_barrier(struct r1conf *conf, int idx)
>          */
>         if (!READ_ONCE(conf->array_frozen) &&
>             !atomic_read(&conf->barrier[idx]))
> -               return;
> +               return ret;
>
>         /*
>          * After holding conf->resync_lock, conf->nr_pending[idx]
> @@ -979,18 +980,27 @@ static void _wait_barrier(struct r1conf *conf, int idx)
>          */
>         wake_up(&conf->wait_barrier);
>         /* Wait for the barrier in same barrier unit bucket to drop. */
> -       wait_event_lock_irq(conf->wait_barrier,
> -                           !conf->array_frozen &&
> -                            !atomic_read(&conf->barrier[idx]),
> -                           conf->resync_lock);
> +       if (conf->array_frozen || atomic_read(&conf->barrier[idx])) {

Do we really need this check?

> +               /* Return false when nowait flag is set */
> +               if (nowait)
> +                       ret = false;
> +               else {
> +                       wait_event_lock_irq(conf->wait_barrier,
> +                                       !conf->array_frozen &&
> +                                       !atomic_read(&conf->barrier[idx]),
> +                                       conf->resync_lock);
> +               }
> +       }
>         atomic_inc(&conf->nr_pending[idx]);

Were you able to trigger the condition in the tests? I think we should
only increase
nr_pending for ret == true. Otherwise, we will leak a nr_pending.

>         atomic_dec(&conf->nr_waiting[idx]);
>         spin_unlock_irq(&conf->resync_lock);
> +       return ret;
>  }
>
> -static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
> +static bool wait_read_barrier(struct r1conf *conf, sector_t sector_nr, bool nowait)
>  {
>         int idx = sector_to_idx(sector_nr);
> +       bool ret = true;
>
>         /*
>          * Very similar to _wait_barrier(). The difference is, for read
> @@ -1002,7 +1012,7 @@ static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
>         atomic_inc(&conf->nr_pending[idx]);
>
>         if (!READ_ONCE(conf->array_frozen))
> -               return;
> +               return ret;
>
>         spin_lock_irq(&conf->resync_lock);
>         atomic_inc(&conf->nr_waiting[idx]);
> @@ -1013,19 +1023,27 @@ static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
>          */
>         wake_up(&conf->wait_barrier);
>         /* Wait for array to be unfrozen */
> -       wait_event_lock_irq(conf->wait_barrier,
> -                           !conf->array_frozen,
> -                           conf->resync_lock);
> +       if (conf->array_frozen || atomic_read(&conf->barrier[idx])) {

I guess we don't need this either. Also, the condition there is not identical
to wait_barrier (no need to check conf->barrier[idx]).

> +               if (nowait)
> +                       /* Return false when nowait flag is set */
> +                       ret = false;
> +               else {
> +                       wait_event_lock_irq(conf->wait_barrier,
> +                                       !conf->array_frozen,
> +                                       conf->resync_lock);
> +               }
> +       }
>         atomic_inc(&conf->nr_pending[idx]);

ditto on nr_pending.

>         atomic_dec(&conf->nr_waiting[idx]);
>         spin_unlock_irq(&conf->resync_lock);
> +       return ret;
>  }
>
> -static void wait_barrier(struct r1conf *conf, sector_t sector_nr)
> +static bool wait_barrier(struct r1conf *conf, sector_t sector_nr, bool nowait)
>  {
>         int idx = sector_to_idx(sector_nr);
>
> -       _wait_barrier(conf, idx);
> +       return _wait_barrier(conf, idx, nowait);
>  }
>
>  static void _allow_barrier(struct r1conf *conf, int idx)
> @@ -1236,7 +1254,11 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
>          * Still need barrier for READ in case that whole
>          * array is frozen.
>          */
> -       wait_read_barrier(conf, bio->bi_iter.bi_sector);
> +       if (!wait_read_barrier(conf, bio->bi_iter.bi_sector,
> +                               bio->bi_opf & REQ_NOWAIT)) {
> +               bio_wouldblock_error(bio);
> +               return;
> +       }
>
>         if (!r1_bio)
>                 r1_bio = alloc_r1bio(mddev, bio);
> @@ -1336,6 +1358,10 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>                      bio->bi_iter.bi_sector, bio_end_sector(bio))) {
>
>                 DEFINE_WAIT(w);
> +               if (bio->bi_opf & REQ_NOWAIT) {
> +                       bio_wouldblock_error(bio);
> +                       return;
> +               }
>                 for (;;) {
>                         prepare_to_wait(&conf->wait_barrier,
>                                         &w, TASK_IDLE);
> @@ -1353,17 +1379,26 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>          * thread has put up a bar for new requests.
>          * Continue immediately if no resync is active currently.
>          */
> -       wait_barrier(conf, bio->bi_iter.bi_sector);
> +       if (!wait_barrier(conf, bio->bi_iter.bi_sector,
> +                               bio->bi_opf & REQ_NOWAIT)) {
> +               bio_wouldblock_error(bio);
> +               return;
> +       }
>
>         r1_bio = alloc_r1bio(mddev, bio);
>         r1_bio->sectors = max_write_sectors;
>
>         if (conf->pending_count >= max_queued_requests) {
>                 md_wakeup_thread(mddev->thread);
> +               if (bio->bi_opf & REQ_NOWAIT) {
> +                       bio_wouldblock_error(bio);

I think we need to fix conf->nr_pending before returning.

> +                       return;
> +               }
>                 raid1_log(mddev, "wait queued");
>                 wait_event(conf->wait_barrier,
>                            conf->pending_count < max_queued_requests);
>         }
> +
>         /* first select target devices under rcu_lock and
>          * inc refcount on their rdev.  Record them by setting
>          * bios[x] to bio
> @@ -1458,9 +1493,14 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>                                 rdev_dec_pending(conf->mirrors[j].rdev, mddev);
>                 r1_bio->state = 0;
>                 allow_barrier(conf, bio->bi_iter.bi_sector);
> +
> +               if (bio->bi_opf & REQ_NOWAIT) {
> +                       bio_wouldblock_error(bio);
> +                       return;
> +               }
>                 raid1_log(mddev, "wait rdev %d blocked", blocked_rdev->raid_disk);
>                 md_wait_for_blocked_rdev(blocked_rdev, mddev);
> -               wait_barrier(conf, bio->bi_iter.bi_sector);
> +               wait_barrier(conf, bio->bi_iter.bi_sector, false);
>                 goto retry_write;
>         }
>
> @@ -1687,7 +1727,7 @@ static void close_sync(struct r1conf *conf)
>         int idx;
>
>         for (idx = 0; idx < BARRIER_BUCKETS_NR; idx++) {
> -               _wait_barrier(conf, idx);
> +               _wait_barrier(conf, idx, false);
>                 _allow_barrier(conf, idx);
>         }
>
> --
> 2.17.1
>
