Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850F412FF0A
	for <lists+linux-raid@lfdr.de>; Sat,  4 Jan 2020 00:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgACXQJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 18:16:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43089 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgACXQJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 18:16:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so35303763qtj.10
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 15:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3jFD6zqffx31lG19bpBPYqMZlsg46krX6BMruyDxJk=;
        b=tQO3imhDoSxDqb/mNg+EIttHCVhWkb+K2JGhdZkCviNlwc5o8fyFAsNs9diAHKkD6i
         ueAoNMQ+hlAB24XiSbZeWzQYeCC1ENyLs06q5NNRuvTJaPOg3u/WfDMUOESHFA64FRKc
         +aGMUWeqF3WM32MD7pmJbVyuCWoo2zKGS5fTvqYau0vz/r1eFIOwiyocaBMf7Fg+RDb2
         BUagy4pcG8aTMNBXf5Fik2Nx2endaDlWz8VAIii6Ec3Jk4mSa61XR0Bxwx7wnY9Ro0rY
         sTaI1+pYkivTJ0gQ3tYEQUYu6cSL2bhcpcriFmtvm4LUeToe+UhjWFakXwhLn8sZUd/x
         jxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3jFD6zqffx31lG19bpBPYqMZlsg46krX6BMruyDxJk=;
        b=gYeqFAMIE683RL90DrHdvmb2caGk9ShI2ibdHeX5Su2LgdgnXBUqh/O4wef0PL05RT
         1N6wX+QLOZ/URwxf9KKICEmYrjaUpFIfnQ08jsBWCtTZKuvOB0rFK0eCnkEBjZHqPgUI
         cSz5eKXIl2OY1h9/xUhqHf5he0fibx3n5hnVtaeYWNSMnVI90/gn5mgt02ssAEE5Ff9i
         7tEPrDa470RGrigT2lfUWOJhrh9PWTOYUrnap9SPHPaz+j/pE7ebOK9BcIucInNWNyh7
         c2uQOJG4iqA3sDjVisq7XP4+noAdWbmRO/+Brk1us7opc+BzcHo4jwWZRO48AdnZtJCM
         gIVg==
X-Gm-Message-State: APjAAAV58wmeYmG+u2roiAUjItw1Gk0xLHmQdtcnk7h7/c6HEQ7IrBnn
        VTHMqqKYsaF/Jq2hwaFtsWMj6NExz534KLQCzlzawbNo
X-Google-Smtp-Source: APXvYqyb4MxdiEiLiBM1PeGSTuoyy2mLWNJDodKgf5VOT8uS5fp1vl/bvX4NT0N8kqvQpkjEHxOolpB8ZVMsKFzaYYo=
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr66453289qtv.308.1578093368579;
 Fri, 03 Jan 2020 15:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com> <20191223094902.12704-11-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191223094902.12704-11-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 15:15:57 -0800
Message-ID: <CAPhsuW5WGdsvse_dPf1cG7Yj-TR6-+653ik1bJvjrNedtD-dPw@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] md/raid1: introduce wait_for_serialization
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Previously, we call check_and_add_serial when serialization is
> enabled for write IO, but it could allocate and free memory
> back and forth.
>
> Now, let's just get an element from memory pool with the new
> function, then insert node to rb tree if no collision happens.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/md/raid1.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 48d553d7989a..cd810e195086 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -56,32 +56,43 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
>  INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, _subtree_last,
>                      START, LAST, static inline, raid1_rb);
>
> -static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
> +static int check_and_add_serial(struct md_rdev *rdev, struct r1bio *r1_bio,
> +                               struct serial_info *si, int idx)
>  {
> -       struct serial_info *si;
>         unsigned long flags;
>         int ret = 0;
> -       struct mddev *mddev = rdev->mddev;
> -       int idx = sector_to_idx(lo);
> +       sector_t lo = r1_bio->sector;
> +       sector_t hi = lo + r1_bio->sectors;
>         struct serial_in_rdev *serial = &rdev->serial[idx];
>
> -       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
> -
>         spin_lock_irqsave(&serial->serial_lock, flags);
>         /* collision happened */
>         if (raid1_rb_iter_first(&serial->serial_rb, lo, hi))
>                 ret = -EBUSY;
> -       if (!ret) {
> +       else {
>                 si->start = lo;
>                 si->last = hi;
>                 raid1_rb_insert(si, &serial->serial_rb);
> -       } else
> -               mempool_free(si, mddev->serial_info_pool);
> +       }
>         spin_unlock_irqrestore(&serial->serial_lock, flags);
>
>         return ret;
>  }
>
> +static void wait_for_serialization(struct md_rdev *rdev, struct r1bio *r1_bio)
> +{
> +       struct mddev *mddev = rdev->mddev;
> +       struct serial_info *si;
> +       int idx = sector_to_idx(r1_bio->sector);
> +       struct serial_in_rdev *serial = &rdev->serial[idx];
> +
> +       if (WARN_ON(!mddev->serial_info_pool))
> +               return;
> +       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
> +       wait_event(serial->serial_io_wait,
> +                  check_and_add_serial(rdev, r1_bio, si, idx) == 0);

Are we leaking si when raid1_rb_iter_first() failed?
