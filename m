Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104F3F086E
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 22:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfKEVdV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 16:33:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43389 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEVdV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 16:33:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id l24so13007117qtp.10
        for <linux-raid@vger.kernel.org>; Tue, 05 Nov 2019 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWAEF0qlVWVQA6jQ7Ek/eFl/PTtiG0jaR4OPJ4AUKZw=;
        b=Or6EcKIwdoEnEqfjg01L5R29gTnZiMS0NW5KOw8hI79imiRCjG/5dpjdnvizoeL/Wn
         3D5Nia9WtI0HejM3vklGmnFekcjA3rbMQ0hHttW4yRGISHRQqEAj79nehthNYMj6KfPk
         AnnrDzHLvE4B9VavP+Z/jEANOFopbIHrjSFl+A0545HYWJw6QwRWXLIY+3ltz+MJvPgl
         VXvc4zq2dVFQwmojzk9Us7lBlrRZYbiJnafIaRRnSqNZh1qdQ6Nj3Kllm54A8ZAi68sV
         tnYbl/umwbP+PEMti+ZSpZSYp/e0oGkGYEDwsu4KN9vKCH/qjfiwT7pajWQm0QUwGfEM
         8ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWAEF0qlVWVQA6jQ7Ek/eFl/PTtiG0jaR4OPJ4AUKZw=;
        b=l+2yZYVKsb2oLsXndij0z4geqLf2Zdn3mtPAkxz5suwElBv6ZsCyjL8SfbyxWEe/zz
         MJSsaWWKGta+SYE4bBoYDvNr134KxSH0qhtO4DcKeX6CCPdWhSeVALaIG/q4rLTTaaBF
         p9fwWnVey25taRksXnhJjSJH7iC9W6lA1G/x4ek0lLshrxel/PP22BYPpOp2SAFouIth
         cpkmEtMZzlXJVTIR9pmOOnaqWR0wMv167e+ru/sk06tGllDc4J+g2FYAbYmOg4NPz5DO
         ffxAkibLZH6VoSOjNs1NRFRDp341zXxWBs7EUEa8Q//P7FggoRos9I2sojN2vdkA7t/q
         dX2g==
X-Gm-Message-State: APjAAAV7FPKi5MFU6RSx0n01E6iYEDKd2EukMZAgcO72jf1e+lwh6FZn
        uRzcp9KH74QVsv+hU410UqWTIj8VRBlS46Xt428571wI
X-Google-Smtp-Source: APXvYqz8ToY/nVfYIsVdRrjqv7hUT0JWvQ1mtwlEvRXb90z8GYhHTI6mvzGynINHF+C3NNi0eVViuawIB316C0iT/N8=
X-Received: by 2002:ac8:1b85:: with SMTP id z5mr19799886qtj.308.1572989600404;
 Tue, 05 Nov 2019 13:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191104200157.31656-1-ncroxon@redhat.com> <CAPhsuW7J-3ewXRvB9H1m44L_sVnuKBGTLcuRiKKN4YLRNivxtQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7J-3ewXRvB9H1m44L_sVnuKBGTLcuRiKKN4YLRNivxtQ@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Nov 2019 13:33:09 -0800
Message-ID: <CAPhsuW7E6tHy6-1+NnQPhr82sZO9aRTSEyhNoh_+fS8HQi=+nQ@mail.gmail.com>
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Nov 5, 2019 at 1:14 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Mon, Nov 4, 2019 at 12:02 PM Nigel Croxon <ncroxon@redhat.com> wrote:
> >
> > The MD driver for level-456 should prevent re-reading read errors.
> >
> > For redundant raid it makes no sense to retry the operation:
> > When one of the disks in the array hits a read error, that will
> > cause a stall for the reading process:
> > - either the read succeeds (e.g. after 4 seconds the HDD error
> > strategy could read the sector)
> > - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> > seconds (might be even longer)
> >
> > The user can enable/disable this functionality by the following
> > commands:
> > To Enable:
> > echo 1 > /proc/sys/dev/raid/raid456_retry_read_error
> >
> > To Disable, type the following at anytime:
> > echo 0 > /proc/sys/dev/raid/raid456_retry_read_error
> >
> > Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> > ---
> >  drivers/md/md.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/md/md.h    |  3 +++
> >  drivers/md/raid5.c |  3 ++-
> >  3 files changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 6f0ecfe8eab2..75b8b0615328 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -125,6 +125,12 @@ static inline int speed_max(struct mddev *mddev)
> >                 mddev->sync_speed_max : sysctl_speed_limit_max;
> >  }
> >
> > +static int sysctl_raid456_retry_read_error = 0;
> > +static inline void set_raid456_retry_re(struct mddev *mddev, int re)
> > +{
> > +       (re ? set_bit : clear_bit)(MD_RAID456_RETRY_RE, &mddev->flags);
>
> Let's just keep this
> if (re)
>      set_bit(...);
> else
>      clear_bit(..);
>
> > +}
> > +
> >  static int rdev_init_wb(struct md_rdev *rdev)
> >  {
> >         if (rdev->bdev->bd_queue->nr_hw_queues == 1)
> > @@ -213,6 +219,13 @@ static struct ctl_table raid_table[] = {
> >                 .mode           = S_IRUGO|S_IWUSR,
> >                 .proc_handler   = proc_dointvec,
> >         },
> > +       {
> > +               .procname       = "raid456_retry_read_error",
> > +               .data           = &sysctl_raid456_retry_read_error,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = S_IRUGO|S_IWUSR,
> > +               .proc_handler   = proc_dointvec,
> > +       },
> >         { }
> >  };
>
> How about we add this to md_redundancy_attrs instead?

Actually, I think raid5_attrs is better.

Thanks,
Song
