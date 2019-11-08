Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622B1F5B6D
	for <lists+linux-raid@lfdr.de>; Fri,  8 Nov 2019 23:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKHWyx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Nov 2019 17:54:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43011 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWyx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 Nov 2019 17:54:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id z23so6726387qkj.10
        for <linux-raid@vger.kernel.org>; Fri, 08 Nov 2019 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZbw4sDgibdmCzTK37XED3jV+3PisAZMFjeCeav2Ols=;
        b=BxIeGqlCX4nzKSg8nI+2/f3LQkWPvgRRzQQfkWW24yZqlZ5PJMmORqsHX8wDTT5tfk
         q5c1Z7xGDETxErINfjwaEQKuhH6HCKANSybzERqyMl38FR/Wy+hFp20qHEkm3og/pM4l
         t5bfQiztGwLbTDQv58zWBytJiIY8lQfHboXYT/PgCHfjheLlgAw7sV/y5aDJcw+/5A3a
         vvgiRCO/ilVBgay68JmI+cE8QSj1ny58qlgrkAgrgXekfQoOm77ijX4J2MLCyVO8VcWe
         hnNE1cJqr6q6W3h3AN4/QhnaREdduFnp1uW3cVuOFgASL+BcbqPnKNGtNcZSq15Iirqo
         pTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZbw4sDgibdmCzTK37XED3jV+3PisAZMFjeCeav2Ols=;
        b=j3EIPo5cWH+cRckSZ136XUTvmaJVzzac4qEjArwLEJgXm8Lh/GojBOD0RTKis8ey36
         CIygGVkAm4zHoUhJvgqlcOMckAroqmQ4oqhi6VHM1oqgGPxVitdgdjGO/L6GpD6f4UGI
         v64D/zLzcS+jDB/IdRmMgO862iw00DeFpA/Lyxxcqjvt4p5z52G2vwW2nk6htQ3eTQpu
         XCVa8M3qQy77cP2dnhXxqeyDopW3sm/uWOX4lsSBPtEM1HpNtaytDU6Ua28/SSfv7se+
         Ppf1NxQbRCN+Thik3JAUWBTaHNF4HR8ttQLO+mwuAV2ibeGj5UTZvyDkab8D3UwOjWrF
         rOiQ==
X-Gm-Message-State: APjAAAW0kGosascH377ubTGAFPm69jt88PyPk+NvJAqMIWr0ag/+hG58
        fbIpQPyrzI7ArF9q2UGPHpPygPAz29nPD6W0U0Q=
X-Google-Smtp-Source: APXvYqxD6wsXoNBkJrc6MJwLiT8T5i3DVxE2WOA6HjiJaPBZKVakdYnlO3VUJM/O//FhftXms31w+BRUWQIY39l1v5Q=
X-Received: by 2002:ae9:de07:: with SMTP id s7mr10820355qkf.89.1573253690888;
 Fri, 08 Nov 2019 14:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com> <20191101142231.23359-4-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191101142231.23359-4-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 8 Nov 2019 14:54:39 -0800
Message-ID: <CAPhsuW6XWZ=NswHpWUvSiR96dO5sm+5Zb19X2KjDUA7os7Bikg@mail.gmail.com>
Subject: Re: [PATCH 3/8] md: add serialize_policy sysfs node for raid1
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
> With the new sysfs node, we can use it to control if raid1 array
> wants serialization for write request or not.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/md/md.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/md.h |  1 +
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 43b7da334e4a..8df94a58512b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -174,6 +174,7 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>                 memalloc_noio_restore(noio_flag);
>                 if (!mddev->serial_info_pool)
>                         pr_err("can't alloc memory pool for writemostly\n");
> +               mddev->serialize_policy = true;
>                 if (!is_suspend)
>                         mddev_resume(mddev);
>         }
> @@ -216,6 +217,7 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>                         mempool_destroy(mddev->serial_info_pool);
>                         mddev->serial_info_pool = NULL;
>                 }
> +               mddev->serialize_policy = false;
>                 mddev_resume(mddev);
>         }
>  }
> @@ -5261,6 +5263,49 @@ static struct md_sysfs_entry md_fail_last_dev =
>  __ATTR(fail_last_dev, S_IRUGO | S_IWUSR, fail_last_dev_show,
>         fail_last_dev_store);
>
> +static ssize_t serialize_policy_show(struct mddev *mddev, char *page)
> +{
> +       return sprintf(page, "%d\n", mddev->serialize_policy);

Maybe show something like "n/a" for non-raid1?

> +}
> +
> +/*
> + * Setting serialize_policy to true to enforce write IO is not reordered
> + * for raid1.
> + */
> +static ssize_t
> +serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
> +{
> +       int err;
> +       bool value;
> +
> +       err = kstrtobool(buf, &value);
> +       if (err || value == mddev->serialize_policy)
> +               return err ?: -EINVAL;

I think we should not return -EINVAL for value == serialize_policy case.

> +
> +       err = mddev_lock(mddev);
> +       if (err)
> +               return err;
> +       if (mddev->pers == NULL ||
> +           (strncmp(mddev->pers->name, "raid1", 4) != 0)) {

Check pers->level == 1 instead?

Also, we need to recheck serialize_policy here.

> +               pr_err("md: serialize_policy is only effective for raid1\n");
> +               err = -EINVAL;
> +               goto unlock;
> +       }
> +
> +       if (value)
> +               mddev_create_serial_pool(mddev, NULL, false, true);
> +       else
> +               mddev_destroy_serial_pool(mddev, NULL, true);
> +unlock:
> +       mddev_unlock(mddev);
> +       return err ?: len;
> +}
> +
> +static struct md_sysfs_entry md_serialize_policy =
> +__ATTR(serialize_policy, S_IRUGO | S_IWUSR, serialize_policy_show,
> +       serialize_policy_store);
> +
> +
>  static struct attribute *md_default_attrs[] = {
>         &md_level.attr,
>         &md_layout.attr,
> @@ -5278,6 +5323,7 @@ static struct attribute *md_default_attrs[] = {
>         &max_corr_read_errors.attr,
>         &md_consistency_policy.attr,
>         &md_fail_last_dev.attr,
> +       &md_serialize_policy.attr,
>         NULL,
>  };
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 291a59a94528..161772066dab 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -494,6 +494,7 @@ struct mddev {
>
>         bool    has_superblocks:1;
>         bool    fail_last_dev:1;
> +       bool    serialize_policy:1;
>  };
>
>  enum recovery_flags {
> --
> 2.17.1
>
