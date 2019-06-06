Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C52379D2
	for <lists+linux-raid@lfdr.de>; Thu,  6 Jun 2019 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFFQge (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Jun 2019 12:36:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37225 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFFQgd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Jun 2019 12:36:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so3423573qtk.4
        for <linux-raid@vger.kernel.org>; Thu, 06 Jun 2019 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6eb0u73Upf6ho0W8YIBg7dj/3ceJhzys7B64ndNXq4=;
        b=GRvOOX89ZXT2eRroru4OxpbSxbXRwYire/EWNca4bdN/jZyBRIsXR1lixf6LTctf0U
         DPZW7CJ6s9wsSLQkkRVCfwzRZZkb4qFfvkJaCKEXWjbi5WAJ1vJ+FxatM13MtOL33tn1
         LB27fayFWKI5xbYNPCKVEByM+9Mjoi4kb9L7UvJCMenwmcWSiIt8CsBai9mqT9yA3HGz
         lUUBGK3e4cXT3DjOQe4e8Rk/zfhMsu4yczf/UhmNUfvD8+utZsWMXmIU+AGRPyhpCM4Y
         bCrKmw5NpPY3Mh9oQtFa27Kps2pV8QR1KTW4qh/LXuA3ExAoZgqeCGfmDUIhNwFC1q5P
         4+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6eb0u73Upf6ho0W8YIBg7dj/3ceJhzys7B64ndNXq4=;
        b=kdgHvl5NYBNc1Wze8lOVZia3+Jgw0aI6Gx4HUQvpeBAVXtx6dII/7ngfiSTggGMsHr
         SpdsccIC/9SBD9X3il4mq07oTUheBYhxr6sMOg75AHZYXURN1g2h519dKePJ7AQThhQK
         tgr3XJcLEhbAx7nEjkNuXdGCQgQMPQUxtDD6etKri/umBk42YUD2jcdrMZ488AaySfKz
         0bjrue5BOrp7D3B3l8YrX6PM7bbEs18c0GJd9kLQ1V7fumjPb/Gy3mY9smKZaa42u2qc
         Gagaaa/mLfj/XtEXIs+zNMlcjoKdBfjtDVBxuK4DAst4Do4s0UGecj5CSms9Npo28WhY
         nZJw==
X-Gm-Message-State: APjAAAWtRwXvi9FjDizryF7r7VqrCcDMSchv0FUA90He1f1ohQoznAU1
        odtQlqzwnSLtdbLMsDjg2fvwjZuk32qqZvhsCbk=
X-Google-Smtp-Source: APXvYqybu7PBtSV25auPvSqGaL4KbmpVCDAuqgYifiJUp4v4/5dAgXMZIoE8VMKzXH2W/Fn+oSkW4FtT2sw2sfCCfR0=
X-Received: by 2002:ac8:1af4:: with SMTP id h49mr33492791qtk.183.1559838992665;
 Thu, 06 Jun 2019 09:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1559047314-8460-1-git-send-email-xni@redhat.com>
In-Reply-To: <1559047314-8460-1-git-send-email-xni@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 6 Jun 2019 09:36:21 -0700
Message-ID: <CAPhsuW4cM6Lut0Ueqip4mLVVbGRmXDmdtcMTR-cwmc98etQ4gA@mail.gmail.com>
Subject: Re: [PATCH 1/1] raid5-cache: Need to do start() part job after adding
 journal device
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Michal Soltys <soltys@ziu.info>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 28, 2019 at 5:42 AM Xiao Ni <xni@redhat.com> wrote:
>
> In d5d885fd(md: introduce new personality funciton start()) it splits the init
> job to two parts. The first part run() does the jobs that do not require the
> md threads. The second part start() does the jobs that require the md threads.

nit: checkpatch.pl complains

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#57:
In d5d885fd(md: introduce new personality funciton start()) it splits the init

I fixed this in my tree, so no need to resend.

>
> Now it just does run() in adding new journal device. It needs to do the second
> part start() too.
>
> Fixes: f6b6ec5cfac(raid5-cache: add journal hot add/remove support)

Shall we say Fixes d5d885fd(md: introduce new personality funciton
start()) here?
Or do we really need the fix to earlier versions with f6b6ec5cfac?

Thanks,
Song

> Reported-by: Michal Soltys <soltys@ziu.info>
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>  drivers/md/raid5.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7fde645..0e52f1d 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7680,7 +7680,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>  static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>  {
>         struct r5conf *conf = mddev->private;
> -       int err = -EEXIST;
> +       int ret, err = -EEXIST;
>         int disk;
>         struct disk_info *p;
>         int first = 0;
> @@ -7695,7 +7695,14 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>                  * The array is in readonly mode if journal is missing, so no
>                  * write requests running. We should be safe
>                  */
> -               log_init(conf, rdev, false);
> +               ret = log_init(conf, rdev, false);
> +               if (ret)
> +                       return ret;
> +
> +               ret = r5l_start(conf->log);
> +               if (ret)
> +                       return ret;
> +
>                 return 0;
>         }
>         if (mddev->recovery_disabled == conf->recovery_disabled)
> --
> 2.7.5
>
