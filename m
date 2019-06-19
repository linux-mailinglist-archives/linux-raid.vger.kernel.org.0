Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81AA4BF9F
	for <lists+linux-raid@lfdr.de>; Wed, 19 Jun 2019 19:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfFSR3K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Jun 2019 13:29:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46872 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfFSR3K (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 19 Jun 2019 13:29:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so20846688qtn.13
        for <linux-raid@vger.kernel.org>; Wed, 19 Jun 2019 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bo+hxziM7qWvaSupRQtXyYdpeQqugqlMw8OyybSxSYA=;
        b=uifU8+o7ciaQsv8rFRC27FL0LeIL6rgQgCqndwfB3Ra0oJ/BZSIuMHGxKgR+NST3Pp
         jt+xCYUFgFyEDZ4iQEcSFw4M1o5fpB7hYT9i5VLKJLUmKsY48X6DQj0uXOwiz37znRkc
         Kt/e/THv2phld1p7Yyt3ooh/kl46Fj6TlFZ9gXODgE4xu/WKnhUY1o0ioyuRYfxoNQKO
         lfIAFy/iNYnpDqkB/Rewut/X4hMh2tCqT+0SNsiWCIEn8qM23aVDq9PKLj4v+aXKg7p2
         HZKPgCdAl6IHxrNqpxlYKsnxwnnGBgSNbXNGxRfFZI+kWnGT+chcC0814fpJ4LdNVMZK
         NkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bo+hxziM7qWvaSupRQtXyYdpeQqugqlMw8OyybSxSYA=;
        b=cajLhKMgan7CjNUqylTTE4BHM2OCmWZ5/tSrS96tthuyF2UoQasb6nFA2jyMokG8Hm
         THzOL2xbuUdSia7q0jP/0+ApHW/Y4g5+gYVlx2sUNSDQwCquYmIkVuihKj0dFkaUzWFO
         GNH5A5XxjB5296HLhn07ANb7qEdL/PlH0ZNfoq6U3ogd8Rw+A00Z54QhhzWsQkF93Yfn
         nwrZgD3bEYxqoHn6+rrLQ/JHVcr9XJyiyDQ3wXUaAt5NAeM5tW2xb1BXkiA2+78CXLgn
         PzDFrJ4nv/mRToJEyiNLHkmFyU4bv3viTzQY2XQpNDR0nP9X7QGTQ89GAnRspXVlns76
         JW0g==
X-Gm-Message-State: APjAAAUBa2G6bjHtUFkzbhOp9d/KUV9MgOH3Er1cZvzX5GM5RIPOVl4m
        EvgcVEmac7Cj+PFlzAFofI7oBn+ojO6QxfnHXXCLcl12
X-Google-Smtp-Source: APXvYqx2oo0xRoUh/hkhJJr9PBvqs9mCRAO0a25kK+QP2WltUYhdwhQnk41MyTEi5H63OzKyo6xQ1xvuetPpACwVHz8=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr34957592qvh.78.1560965348588;
 Wed, 19 Jun 2019 10:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-2-gqjiang@suse.com> <20190619093046.14066-1-gqjiang@suse.com>
In-Reply-To: <20190619093046.14066-1-gqjiang@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 19 Jun 2019 10:28:57 -0700
Message-ID: <CAPhsuW5wuqL=q6THJKwS1ZDkqZLyXaz2gGM7yr==UDOpKOhTVg@mail.gmail.com>
Subject: Re: [PATCH 1/5 V2] md/raid1: fix potential data inconsistency issue
 with write behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jun 19, 2019 at 2:10 AM Guoqing Jiang <gqjiang@suse.com> wrote:
>
> For write-behind mode, we think write IO is complete once it has
> reached all the non-writemostly devices. It works fine for single
> queue devices.
>
> But for multiqueue device, if there are lots of IOs come from upper
> layer, then the write-behind device could issue those IOs to different
> queues, depends on the each queue's delay, so there is no guarantee
> that those IOs can arrive in order.
>
> To address the issue, we need to check the collision among write
> behind IOs, we can only continue without collision, otherwise wait
> for the completion of previous collisioned IO.
>
> And WBCollision is introduced for multiqueue device which is worked
> under write-behind mode.
>
> But this patch doesn't handle below cases which could have the data
> inconsistency issue as well, these cases will be handled in later
> patches.
>
> 1. modify max_write_behind by write backlog node.
> 2. add or remove array's bitmap dynamically.
> 3. the change of member disk.
>
> Reviewed-by: NeilBrown <neilb@suse.com>
> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>

Applied to https://github.com/liu-song-6/linux/tree/md-next

Thanks Guoqing!


> ---
> V2 Changes:
> 1. use temp_wi in list_for_each_entry, thanks for Song's review.
>
>  drivers/md/md.c    | 41 ++++++++++++++++++++++++++++++++
>  drivers/md/md.h    | 21 +++++++++++++++++
>  drivers/md/raid1.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 45ffa23fa85d..3f816e4d4dd8 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -131,6 +131,19 @@ static inline int speed_max(struct mddev *mddev)
>                 mddev->sync_speed_max : sysctl_speed_limit_max;
>  }
>
> +static int rdev_init_wb(struct md_rdev *rdev)
> +{
> +       if (rdev->bdev->bd_queue->nr_hw_queues == 1)
> +               return 0;
> +
> +       spin_lock_init(&rdev->wb_list_lock);
> +       INIT_LIST_HEAD(&rdev->wb_list);
> +       init_waitqueue_head(&rdev->wb_io_wait);
> +       set_bit(WBCollisionCheck, &rdev->flags);
> +
> +       return 1;
> +}
> +
>  static struct ctl_table_header *raid_table_header;
>
>  static struct ctl_table raid_table[] = {
> @@ -5604,6 +5617,32 @@ int md_run(struct mddev *mddev)
>                 md_bitmap_destroy(mddev);
>                 goto abort;
>         }
> +
> +       if (mddev->bitmap_info.max_write_behind > 0) {
> +               bool creat_pool = false;
> +
> +               rdev_for_each(rdev, mddev) {
> +                       if (test_bit(WriteMostly, &rdev->flags) &&
> +                           rdev_init_wb(rdev))
> +                               creat_pool = true;
> +               }
> +               if (creat_pool && mddev->wb_info_pool == NULL) {
> +                       mddev->wb_info_pool =
> +                               mempool_create_kmalloc_pool(NR_WB_INFOS,
> +                                                   sizeof(struct wb_info));
> +                       if (!mddev->wb_info_pool) {
> +                               err = -ENOMEM;
> +                               mddev_detach(mddev);
> +                               if (mddev->private)
> +                                       pers->free(mddev, mddev->private);
> +                               mddev->private = NULL;
> +                               module_put(pers->owner);
> +                               md_bitmap_destroy(mddev);
> +                               goto abort;
> +                       }
> +               }
> +       }
> +
>         if (mddev->queue) {
>                 bool nonrot = true;
>
> @@ -5833,6 +5872,8 @@ static void __md_stop_writes(struct mddev *mddev)
>                         mddev->in_sync = 1;
>                 md_update_sb(mddev, 1);
>         }
> +       mempool_destroy(mddev->wb_info_pool);
> +       mddev->wb_info_pool = NULL;
>  }
>
>  void md_stop_writes(struct mddev *mddev)
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 257cb4c9e22b..ce9eb6db0538 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -116,6 +116,14 @@ struct md_rdev {
>                                            * for reporting to userspace and storing
>                                            * in superblock.
>                                            */
> +
> +       /*
> +        * The members for check collision of write behind IOs.
> +        */
> +       struct list_head wb_list;
> +       spinlock_t wb_list_lock;
> +       wait_queue_head_t wb_io_wait;
> +
>         struct work_struct del_work;    /* used for delayed sysfs removal */
>
>         struct kernfs_node *sysfs_state; /* handle for 'state'
> @@ -200,6 +208,10 @@ enum flag_bits {
>                                  * it didn't fail, so don't use FailFast
>                                  * any more for metadata
>                                  */
> +       WBCollisionCheck,       /*
> +                                * multiqueue device should check if there
> +                                * is collision between write behind bios.
> +                                */
>  };
>
>  static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
> @@ -252,6 +264,14 @@ enum mddev_sb_flags {
>         MD_SB_NEED_REWRITE,     /* metadata write needs to be repeated */
>  };
>
> +#define NR_WB_INFOS    8
> +/* record current range of write behind IOs */
> +struct wb_info {
> +       sector_t lo;
> +       sector_t hi;
> +       struct list_head list;
> +};
> +
>  struct mddev {
>         void                            *private;
>         struct md_personality           *pers;
> @@ -468,6 +488,7 @@ struct mddev {
>                                           */
>         struct work_struct flush_work;
>         struct work_struct event_work;  /* used by dm to report failure event */
> +       mempool_t *wb_info_pool;
>         void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
>         struct md_cluster_info          *cluster_info;
>         unsigned int                    good_device_nr; /* good device num within cluster raid */
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 0c8a098d220e..f1ea17b14b6e 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -83,6 +83,57 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
>
>  #include "raid1-10.c"
>
> +static int check_and_add_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
> +{
> +       struct wb_info *wi, *temp_wi;
> +       unsigned long flags;
> +       int ret = 0;
> +       struct mddev *mddev = rdev->mddev;
> +
> +       wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
> +
> +       spin_lock_irqsave(&rdev->wb_list_lock, flags);
> +       list_for_each_entry(temp_wi, &rdev->wb_list, list) {
> +               /* collision happened */
> +               if (hi > temp_wi->lo && lo < temp_wi->hi) {
> +                       ret = -EBUSY;
> +                       break;
> +               }
> +       }
> +
> +       if (!ret) {
> +               wi->lo = lo;
> +               wi->hi = hi;
> +               list_add(&wi->list, &rdev->wb_list);
> +       } else
> +               mempool_free(wi, mddev->wb_info_pool);
> +       spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
> +
> +       return ret;
> +}
> +
> +static void remove_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
> +{
> +       struct wb_info *wi;
> +       unsigned long flags;
> +       int found = 0;
> +       struct mddev *mddev = rdev->mddev;
> +
> +       spin_lock_irqsave(&rdev->wb_list_lock, flags);
> +       list_for_each_entry(wi, &rdev->wb_list, list)
> +               if (hi == wi->hi && lo == wi->lo) {
> +                       list_del(&wi->list);
> +                       mempool_free(wi, mddev->wb_info_pool);
> +                       found = 1;
> +                       break;
> +               }
> +
> +       if (!found)
> +               WARN_ON("The write behind IO is not recorded\n");
> +       spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
> +       wake_up(&rdev->wb_io_wait);
> +}
> +
>  /*
>   * for resync bio, r1bio pointer can be retrieved from the per-bio
>   * 'struct resync_pages'.
> @@ -484,6 +535,12 @@ static void raid1_end_write_request(struct bio *bio)
>         }
>
>         if (behind) {
> +               if (test_bit(WBCollisionCheck, &rdev->flags)) {
> +                       sector_t lo = r1_bio->sector;
> +                       sector_t hi = r1_bio->sector + r1_bio->sectors;
> +
> +                       remove_wb(rdev, lo, hi);
> +               }
>                 if (test_bit(WriteMostly, &rdev->flags))
>                         atomic_dec(&r1_bio->behind_remaining);
>
> @@ -1482,7 +1539,16 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>                         mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
>
>                 if (r1_bio->behind_master_bio) {
> -                       if (test_bit(WriteMostly, &conf->mirrors[i].rdev->flags))
> +                       struct md_rdev *rdev = conf->mirrors[i].rdev;
> +
> +                       if (test_bit(WBCollisionCheck, &rdev->flags)) {
> +                               sector_t lo = r1_bio->sector;
> +                               sector_t hi = r1_bio->sector + r1_bio->sectors;
> +
> +                               wait_event(rdev->wb_io_wait,
> +                                          check_and_add_wb(rdev, lo, hi) == 0);
> +                       }
> +                       if (test_bit(WriteMostly, &rdev->flags))
>                                 atomic_inc(&r1_bio->behind_remaining);
>                 }
>
> --
> 2.12.3
>
