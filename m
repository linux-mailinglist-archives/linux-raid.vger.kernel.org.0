Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F58F087E
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 22:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfKEViP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 16:38:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45232 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfKEViO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 16:38:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id x21so31263048qto.12
        for <linux-raid@vger.kernel.org>; Tue, 05 Nov 2019 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cYNFsAsEJ8K/hQuFn2GfSFwb8KsrMSi7WIt4mr1Dlc=;
        b=g5wcCy48SSO1K3oo9PynqQ7lapH67z5WfbQ4uOIoRV1VcxKEVg2FE1X9reE9Q1hD6/
         N4iQLKxi5HsU6ah7nBkx/3/Zt5Xjjik+guz8ehom9/XCdXYp7QN5LkjW72Fw/2jVeH7T
         XjeqOPYLaOy6DSK0FqPUpM2qIxGji/QAV9SbYHb9MbFrQBmkmesO+WmXjlsiYgITiqdC
         Kd5jMXZt8v675Y3YhLsq+2pmbNwpiNuGkR7OMbN1d168IkYZdbcnMgteYTb10ATeVifc
         q3hLbSzl7pagWri1z5hXiZjbgECItBR1vy7jtCWAnZAqBwXv/wtsV61OH3Txg7IeX/tJ
         HtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cYNFsAsEJ8K/hQuFn2GfSFwb8KsrMSi7WIt4mr1Dlc=;
        b=O9KNOPFqLerWPXRsm54HWBfttpQ5ESrtDJ4y4aHW+t+YmOxFmyVWFEsPPZuI0ThCW1
         kD5lU0DWz2jCUNoWzFuJaZgme2a7wtLkMNt2NT0P6D2v3fsbFhA6d2EnZ7mjW33QZ4+A
         S7DEA2eipq2ojfJtYNyklPSIP/OqqDZP6QZ/Ss8LfSyjQuU/5sV4xOeVlitv0GjOAhX1
         6nPwPVUamjohIga05YwMlVWt/qGdCea87Fbkfq/ETxrklTdT+pK7/C3Zye/8A5MtnzZN
         3iVNQm8+4zyzd2wuKSodoP582Jx7Hwr+AiI+b9o2+tf10+XZTYogItBlH763zmNz7oGO
         Rvnw==
X-Gm-Message-State: APjAAAXEpz5mjPlDrJ/XEXXAmjTVaiuNOHEgv1JoyIBYDgArtmWn/fKz
        HI4+UJaIuFA5FF7u78z7TA8HAa4teH5K99KWtXA=
X-Google-Smtp-Source: APXvYqxWIS8BrMoeshWVbEIQWVB14VLVnDa4GJ+V3DJchFxUCiA7EF9ZeJVVN2J1iLM6oa7wZRt+zSVX5VKaeREVZPk=
X-Received: by 2002:ac8:2f45:: with SMTP id k5mr19872192qta.183.1572989892375;
 Tue, 05 Nov 2019 13:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com> <20191101142231.23359-2-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191101142231.23359-2-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Nov 2019 13:38:01 -0800
Message-ID: <CAPhsuW7xX2D7yibLzTBAJOgSPWEfcmdJERtgXwkGGyhWDPPORg@mail.gmail.com>
Subject: Re: [PATCH 1/8] md: rename wb stuffs
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
> Previously, wb_info_pool and wb_list stuffs are introduced
> to address potential data inconsistence issue for write
> behind device.
>
> Now rename them to serial related name, since the same
> mechanism will be used to address reorder overlap write
> issue for raid1.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/md/md-bitmap.c | 20 ++++++-------
>  drivers/md/md.c        | 68 ++++++++++++++++++++++--------------------
>  drivers/md/md.h        | 22 +++++++-------
>  drivers/md/raid1.c     | 43 +++++++++++++-------------
>  4 files changed, 78 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index b092c7b5282f..5058716918ef 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1790,8 +1790,8 @@ void md_bitmap_destroy(struct mddev *mddev)
>                 return;
>
>         md_bitmap_wait_behind_writes(mddev);

Maybe also rename md_bitmap_wait_behind_writes()?

> -       mempool_destroy(mddev->wb_info_pool);
> -       mddev->wb_info_pool = NULL;
> +       mempool_destroy(mddev->serial_info_pool);
> +       mddev->serial_info_pool = NULL;
>
>         mutex_lock(&mddev->bitmap_info.mutex);
>         spin_lock(&mddev->lock);
> @@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
>                 goto out;
>
>         rdev_for_each(rdev, mddev)
> -               mddev_create_wb_pool(mddev, rdev, true);
> +               mddev_create_serial_pool(mddev, rdev, true);
>
>         if (mddev_is_clustered(mddev))
>                 md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
> @@ -2475,16 +2475,16 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
>         if (backlog > COUNTER_MAX)
>                 return -EINVAL;
>         mddev->bitmap_info.max_write_behind = backlog;

Maybe also max_write_behind?

Well, these are not critical though.

Thanks,
Song
