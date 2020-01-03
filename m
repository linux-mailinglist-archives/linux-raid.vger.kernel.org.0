Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF412FEF8
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 23:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgACW5L (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 17:57:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37272 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgACW5L (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 17:57:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so35060549qky.4
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 14:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ow6KjopIezijqBMuNh/UzHLfMSaz+d0jvHCOoMaV64=;
        b=f2EbSVTOs9w0WMryFANmZ5jJhxZEzoiHQm88kXNsp5SCKXq24ItYHBm0p5N4bgabMh
         ToXlPSgQrwh/8ynUabdSdkduaKuPgogcns4EG+afMuDY4mlg6Wnt7PoA5wF9kXq3yWCa
         YVhaWEhcfVa1zDxmOfJMn4POcSBe2lEl/8qHHshVsvz+zhNjcI4hOi5HvCqjIbF4T5gy
         9CVzCqGmHDBqCPR04C3QLb3cwbnZSwZSfj49mf3U9R2WSvcrx2CtPDnHhWSlrevRSmZ4
         IY6UoI3zpVwZgQzTnbAkAm9HoEiJkk1RMTE3r5TP+56SFW4cDkdxmYwVHEYWGBtU27wn
         nfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ow6KjopIezijqBMuNh/UzHLfMSaz+d0jvHCOoMaV64=;
        b=CFyglWVZPs6ttbZVeTSw5izOcpU68rhr6UqBR0Fh4wjtA9lJ2OQ/nstjVwme87G3hA
         btgv6dvLwfGHqiDWMtjl56O2oJILprCwDLBFnRiSifeZPllxWwE8MBGI5bWhIxETaot8
         fcZcN3owCgNAxb8o63I2vezxRzsK4zNC3/sCh/jJaHkiG1inRytOtUrnFTC88F1sASgc
         jgz5JJgThkttIZnXtSMuUKZK+5v7kYNbw6H9JVlNr3QKBSYXo0daOfZTADZ7ZaTbZAj5
         +4DgWAEs4FKCYLvJjiBNc2JU305LLraKCtH1flHglLZDZSxZbu0mvE9CsKnU9jvvka9H
         6d7Q==
X-Gm-Message-State: APjAAAVnjZ4rngCXf3FGrCIBMF9VPAl6bofjwNgdnttouTypsJrQY8wf
        gR/t1c0ouPyaEuNCRE8Xj5sCJytRiI0uplUKOBo=
X-Google-Smtp-Source: APXvYqytto62cu8j/OMyHotxmV8/swwHRgoIiDBgpNgNRKWBEFkLYliJ0oEBcqIfdCTPQBpgRPaCJ8YB2Racae86dAA=
X-Received: by 2002:ae9:f502:: with SMTP id o2mr69388774qkg.89.1578092230034;
 Fri, 03 Jan 2020 14:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com> <CAPhsuW7qPsc-bZJpAV7H2qjX2MBdW8fusN7TyNphp7bF2SnB9g@mail.gmail.com>
In-Reply-To: <CAPhsuW7qPsc-bZJpAV7H2qjX2MBdW8fusN7TyNphp7bF2SnB9g@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 14:56:58 -0800
Message-ID: <CAPhsuW6Wi3++4_CHT9xanXpUH_RafbhPD2SprjKL2oo01fjwfw@mail.gmail.com>
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jan 3, 2020 at 11:48 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Fri, Jan 3, 2020 at 5:56 AM <jgq516@gmail.com> wrote:
> >
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> [...]
> > ---
> >  drivers/md/raid5.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index d4d3b67ffbba..70ef2367fa64 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -5481,7 +5481,9 @@ static void release_stripe_plug(struct mddev *mddev,
> >                         INIT_LIST_HEAD(cb->temp_inactive_list + i);
> >         }
> >
> > -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
> > +       if (!atomic_read(&sh->count) == 0 &&
> "!atomic_read(&sh->count) == 0" is confusing. Do you actually mean
> "atomic_read(&sh->count) == 0"?

Also, I guess we need to CC stable?

Thanks,
Song
