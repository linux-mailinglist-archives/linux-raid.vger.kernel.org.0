Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D393C13648C
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 02:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgAJBGm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Jan 2020 20:06:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35098 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgAJBGm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Jan 2020 20:06:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so548342qto.2
        for <linux-raid@vger.kernel.org>; Thu, 09 Jan 2020 17:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YERJMyAUp6a2uhRqplN+SgA9wgMc6y0uH2xRKcTuGU=;
        b=Xe2T1vX4wBppKaqVHZ9aqomizTTdfPAnSueqaPNOq8i0HdVQPWfOzswFeKbhZ/43a1
         tkEagtPa8uVR/z8ebFfhVInOjJkFqHr2nuQC7RRfPyf+LL1wFdZSJvR9i4UTTjf78jFN
         aN2YeSQUL+4bvI2+aEQxyIZesPC2my8fEooOh3Ce5yyEw0Vh84u4bGCa9NWtqWfyDyEU
         qOnbGnZPrUPmXcqz1QHfzHyWNbljXgOZX3JZ3xzSl8vljbIhWzmD30zd6I8JM3RpM030
         E5bdiApTklHhgcW6q1VvYZ+j2MyL5XCcCJGWoHroHh8JkCmyGsVG9lrPsIfFqvVR4Iz3
         GDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YERJMyAUp6a2uhRqplN+SgA9wgMc6y0uH2xRKcTuGU=;
        b=oOYeo4BZvvmiDrLxuLIt3c84iRZTEjG4N/2sqIwCwGmyOWx5H67pPwwPEky2Yc+ghp
         YAM05/cNlHb5Zp5a5D9DpOHTsEVeHK/ghxJ8kSTNUQXTrusfxXxt5crWURycpUUVf/NE
         w+1PgQqSG4u0jZtlZzFluaBgMNu/lrz0NCUGsrqpFytreWyWl2DhVxYRDPsMtsin4/6O
         dpcd0VHD3SBYp3rhK1RdLn1BCHV3M2JyAXzyYctQ6rNDSvYhQ0gu58Hbsu8FLcrD6nzB
         83fZEd9oeHyDTCeNQMVhQKTyePh4K0W8LZJDTtSNwbyzWnHTQdMomJmPGKNqxWRWaV1r
         R/HQ==
X-Gm-Message-State: APjAAAVryTfhOeytwv6DqHp1aoPhXifZtpPv9eJp6scFjDf/qJZhl8rs
        al8ZyjwWxYMeUbXVAGx6OOtkhP7xIz1Sl4/FULw=
X-Google-Smtp-Source: APXvYqzzBFR7OE9hn1wbP5RuJdG8/7IDqc3IUEasWf2lwTxXKH/X5lSlhrhTUchsDESYVihUxQl4VqXa3lNaCH9JF1k=
X-Received: by 2002:ac8:1c1d:: with SMTP id a29mr288011qtk.183.1578618401481;
 Thu, 09 Jan 2020 17:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20200108163023.9301-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200108163023.9301-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 9 Jan 2020 17:06:30 -0800
Message-ID: <CAPhsuW598WjeigzHPkAEO8YoHwBis8xO79UL8jfRfLUckkGCog@mail.gmail.com>
Subject: Re: [PATCH] raid5: avoid add sh->lru to different list
To:     Guoqing Jiang <jgq516@gmail.com>, Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Guoqing and Xiao,

Thanks for looking into this. I am still looking into this. Some
questions below...

On Wed, Jan 8, 2020 at 8:30 AM <jgq516@gmail.com> wrote:
[...]
>
>  drivers/md/raid5.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 223e97ab27e6..808b0bd18c8c 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -218,6 +218,25 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
>         BUG_ON(!list_empty(&sh->lru));
>         BUG_ON(atomic_read(&conf->active_stripes)==0);
>
> +       /*
> +        * If stripe is on unplug list then original caller of __release_stripe
> +        * is not raid5_unplug, so sh->lru is still in cb->list, don't risk to
> +        * add lru to another list in do_release_stripe.
> +        */

Can we do the check before calling into do_release_stripe()?

> +       if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state))
> +               clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
> +       else {
> +               /*
> +                * The sh is on unplug list, so increase count (because count
> +                * is decrease before enter do_release_stripe), then trigger
> +                * raid5d -> plug -> raid5_unplug -> __release_stripe to handle
> +                * this stripe.
> +                */
> +               atomic_inc(&sh->count);
> +               md_wakeup_thread(conf->mddev->thread);
> +               return;
> +       }
> +
>         if (r5c_is_writeback(conf->log))
>                 for (i = sh->disks; i--; )
>                         if (test_bit(R5_InJournal, &sh->dev[i].flags))
> @@ -5441,7 +5460,7 @@ static void raid5_unplug(struct blk_plug_cb *blk_cb, bool from_schedule)
>                          * is still in our list
>                          */
>                         smp_mb__before_atomic();
> -                       clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
> +                       clear_bit_unlock(STRIPE_ON_UNPLUG_LIST, &sh->state);
>                         /*
>                          * STRIPE_ON_RELEASE_LIST could be set here. In that
>                          * case, the count is always > 1 here
> @@ -5481,7 +5500,8 @@ static void release_stripe_plug(struct mddev *mddev,
>                         INIT_LIST_HEAD(cb->temp_inactive_list + i);
>         }
>
> -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
> +       if (!test_and_set_bit_lock(STRIPE_ON_UNPLUG_LIST, &sh->state) &&
> +           (atomic_read(&sh->count) != 0))

Do we really see sh->count == 0 here? If yes, I guess we should check
sh->count first,
so that we reduce the case where STRIPE_ON_UNPLUG_LIST is set, but the sh is
not really on the unplug_list.

>                 list_add_tail(&sh->lru, &cb->list);
>         else
>                 raid5_release_stripe(sh);
>

Overall, I think we should try our best to let STRIPE_ON_RELEASE_LIST
means it is
on release_list, and STRIPE_ON_UNPLUG_LIST means it is on unplug_list. I think
there will be some exceptions, but we should try to minimize those cases.

Does this make sense?

Thanks,
Song
