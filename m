Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B68F08D5
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfKEV4p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 16:56:45 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34129 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbfKEV4p (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 16:56:45 -0500
Received: by mail-qv1-f67.google.com with SMTP id n12so586075qvt.1
        for <linux-raid@vger.kernel.org>; Tue, 05 Nov 2019 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laeFmyo64kv+sw6dYEmnVd/qFynNQ5UFo9fLWr12vZo=;
        b=QKVbPoYYEXIMB5bH1lWfOSLnxv2qwvPUAoE8u2a9DhU1eqh9WA7Du7lUf15hs5zi9w
         YycW8lTR/PpboP8zxIn4Os/Ll0YAm4auD8xj7celJjGX8cVYOvFWbMctLjbl8o9jbt9s
         Bryi5TDgOvzctT5FgwlAjuNmLyR5XUaD4R6PRecdRXUTAj3Vm102/ue9lZusmOVkMVmc
         OyKu6uVrwE4gg09zKZJhl5swWCIXz/qwGtOeRcsxctsaOUu3oRdxGNcgWCkOKcAhk4Rd
         gZu04NTUIQjRPP3yqSggH/76P3FCdGTZSgA32eLmKed30HMSxLhe8WWUG0qLOiqYN/vQ
         RyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laeFmyo64kv+sw6dYEmnVd/qFynNQ5UFo9fLWr12vZo=;
        b=QhpjCKeE/KS+xgbwKgTMPp6ZveH1gURpjB6tTp+3byOMMQ+dzVKLylOvnhNbW+ggBe
         T1VvOCjASycXySRyF/erwsaUCMVu2F1eiKKr4e+j0iNMfv44Z5j4XbperLpzC12K1lkw
         dDVjpqC2A3YAmANM3gmqC2ABDUkE96zoD3lL7+PBe9+zcYHdVt6LfP7XcPKpEOYe0fl0
         vmQwoxPlO5mQQIveHTjY8V4XURBeuSaUrrGCjqgkJvJi4YcHJAcpmcIQnOy22d+pd75s
         DL+MDJbBtbabp2Xo2TFl/2aPQwrc4lDoI3PmbCHDdAViEmaLenVfCsKiqMjlpkuTDMMZ
         7fag==
X-Gm-Message-State: APjAAAVuipLr5No+bIpzjwHfbRTZpriucOM+5NtNfAZgw7NqTBkUgoPQ
        Sf8iiSAepE28XVpZADArTkcjyzS6ZqWnASfT6sJFhw==
X-Google-Smtp-Source: APXvYqwGj5PgPPt5xppFPdY5lG9OTaHQQZfPBAHHC5mEbZfE7JJE8cnDHETD0u2j4IOqLY1/gkgHUi0gojn0e5MfH2c=
X-Received: by 2002:a05:6214:13e4:: with SMTP id ch4mr4890701qvb.242.1572991003903;
 Tue, 05 Nov 2019 13:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com> <20191101142231.23359-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191101142231.23359-3-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Nov 2019 13:56:32 -0800
Message-ID: <CAPhsuW7MwTvWzDr6voTS92chTm-Znwy74pjyF1=cpXcj27_A3w@mail.gmail.com>
Subject: Re: [PATCH 2/8] md: add is_force parameter for some funcs
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> The related resources (spin_lock, list and waitqueue) are needed
> for address raid1 reorder overlap issue too, so add "is_force"
> parameter to funcs (mddev_create/destroy_serial_pool).

I don't think is_force is a good name. Maybe just call it "force"?

>
> This parameter is set to true if we want to enable or disable
> raid1 io serialization by writinng sysfs node (in later patch),
> rdevs_init_serial is added and called when io serialization is
> enabled.
>
> Also rdev_init_serial and clear_bit(CollisionCheck, &rdev->flags)
> should be called between suspend and resume.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/md/md-bitmap.c |  4 +--
>  drivers/md/md.c        | 64 ++++++++++++++++++++++++++++--------------
>  drivers/md/md.h        |  2 +-
>  3 files changed, 46 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 5058716918ef..eff297cf5a81 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
>                 goto out;
>
>         rdev_for_each(rdev, mddev)
> -               mddev_create_serial_pool(mddev, rdev, true);
> +               mddev_create_serial_pool(mddev, rdev, true, false);
>
>         if (mddev_is_clustered(mddev))
>                 md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
> @@ -2484,7 +2484,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
>                 struct md_rdev *rdev;
>
>                 rdev_for_each(rdev, mddev)
> -                       mddev_create_serial_pool(mddev, rdev, false);
> +                       mddev_create_serial_pool(mddev, rdev, false, false);
>         }
>         if (old_mwb != backlog)
>                 md_bitmap_update_sb(mddev->bitmap);
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index bbf10b9301b6..43b7da334e4a 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -127,9 +127,6 @@ static inline int speed_max(struct mddev *mddev)
>
>  static int rdev_init_serial(struct md_rdev *rdev)
>  {
> -       if (rdev->bdev->bd_queue->nr_hw_queues == 1)
> -               return 0;
> -
>         spin_lock_init(&rdev->serial_list_lock);
>         INIT_LIST_HEAD(&rdev->serial_list);
>         init_waitqueue_head(&rdev->serial_io_wait);
> @@ -138,17 +135,27 @@ static int rdev_init_serial(struct md_rdev *rdev)
>         return 1;
>  }
>
> +static void rdevs_init_serial(struct mddev *mddev)
> +{
> +       struct md_rdev *rdev;
> +
> +       rdev_for_each(rdev, mddev)
> +               rdev_init_serial(rdev);
> +}
> +
>  /*
> - * Create serial_info_pool if rdev is the first multi-queue device flaged
> - * with writemostly, also write-behind mode is enabled.
> + * Create serial_info_pool for raid1 under conditions:
> + * 1. rdev is the first multi-queue device flaged with writemostly,
> + *    also write-behind mode is enabled.
> + * 2. is_force is true which means we want to enable serialization
> + *    for normal raid1 array.
>   */
>  void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
> -                         bool is_suspend)
> +                             bool is_suspend, bool is_force)
>  {
> -       if (mddev->bitmap_info.max_write_behind == 0)
> -               return;
> -
> -       if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_serial(rdev))
> +       if (!is_force && (mddev->bitmap_info.max_write_behind == 0 ||
> +                         (rdev && (rdev->bdev->bd_queue->nr_hw_queues == 1 ||
> +                                   !test_bit(WriteMostly, &rdev->flags)))))
>                 return;
>
>         if (mddev->serial_info_pool == NULL) {
> @@ -156,6 +163,10 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>
>                 if (!is_suspend)
>                         mddev_suspend(mddev);
> +               if (is_force)
> +                       rdevs_init_serial(mddev);
> +               if (!is_force && rdev)
> +                       rdev_init_serial(rdev);
>                 noio_flag = memalloc_noio_save();
>                 mddev->serial_info_pool =
>                         mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
> @@ -171,11 +182,13 @@ EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
>
>  /*
>   * Destroy serial_info_pool if rdev is the last device flaged with
> - * CollisionCheck.
> + * CollisionCheck, or is_force is true when we disable serialization
> + * for normal raid1.
>   */
> -static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
> +static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
> +                                     bool is_force)

I guess mddev_destroy_serial_pool() doesn't need an extra argument. We
can just to
clear_bit, etc.. no?
