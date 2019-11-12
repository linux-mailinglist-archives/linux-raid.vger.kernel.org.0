Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB1F8592
	for <lists+linux-raid@lfdr.de>; Tue, 12 Nov 2019 01:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKLAtE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 Nov 2019 19:49:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45044 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLAtE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 Nov 2019 19:49:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so12964422qki.11
        for <linux-raid@vger.kernel.org>; Mon, 11 Nov 2019 16:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpKZwfY8zgwWXP0up9/YKoqJgVxtDm9OvUjfPhDfPDs=;
        b=ThZ8a6mc6olGSrhw4wOCCK5tZBm6ZCcKDiWt/SnHwgIk5pSvVJ9khxJzXJRjebsnch
         XrtPZEfSoxtpuokpJ7KrUiElYlNCHyxpFPEMEl/2/sgwBeg4iYIVJ8BnIF36EmMwB6cy
         R+hY19eKrPSYVDclDEFC13xRiMyATGYqYspX/2ONg4XLMLz11lz4XeqraAXsEhMVX9oO
         Zjf1d2FJ5Y1KU5RpinVi6lTQCx0l7E4UsWlwe2jp/Q+K/oAod6NvBhtEfePN7q0PBz+z
         G7fAoSZUTtEFL0cXJyjaktgX4PI9mR7NohpmvcxzUzBEPj4y5CxQgAzKSG8s/Zk+7Fc1
         2yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpKZwfY8zgwWXP0up9/YKoqJgVxtDm9OvUjfPhDfPDs=;
        b=kxWZOjHqqRw2CkPrfkjQwnIE07l5iJ74Jw4iUTUwOWRte8PJmWvyfHVDb6tGAqfopl
         W/Og+pBO6/A5Qa7mtqUMiSy6Tt0bz9/Z/0Su+q2ny2UJcHbZekO05/geUMKdZmWuw8ZG
         O9s1ldJ42cr3hQY03oMaFhGhUmeIaiHLfsTOpI/9Qh51tyOkXNUrdqQwBZgmuluhXIuW
         T7F58Bmu1yAOZu/l6dJY1MyQkeUlrcm9CgE8oB69mSx0jSmM+xkWLu/tkhupYz18Adv+
         kjkQm6uiYIv0AgcfKK4t3jhXFeJF7qYdBEJkvBZv7HgZNoJeE3oG4F/bQQ5Wmk0BI8iB
         IhVA==
X-Gm-Message-State: APjAAAXFsN7MocHdkJR/KH62rY6tSroUviSd1hXurE1J+llep42LidLZ
        Zs59SGwzJW5jOoATpSWYB/OsKhCyRb+AYrG3q7mAlg==
X-Google-Smtp-Source: APXvYqyj2U3rnKAVOO5+Vb4Q60dDNYVaGkNCwjEv9BedG8iAdYz3Zlz3RyqV9fyxFgwpErje2jQ1t+xwnnSB3TJB4rE=
X-Received: by 2002:a05:620a:68f:: with SMTP id f15mr12948120qkh.497.1573519742929;
 Mon, 11 Nov 2019 16:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20191111153243.9588-1-jpittman@redhat.com> <e914ff58c0dca1f9d63b203157eae64660e0cd5e.camel@redhat.com>
In-Reply-To: <e914ff58c0dca1f9d63b203157eae64660e0cd5e.camel@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 11 Nov 2019 16:48:52 -0800
Message-ID: <CAPhsuW5-Z=Nkw0Pps2TTAE7aXZaoSt08vVU_kQBKMh89dGa1WA@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: prevent access of uninitialized resync_pages offset
To:     Laurence Oberman <loberman@redhat.com>
Cc:     John Pittman <jpittman@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Xiao Ni <xni@redhat.com>, Nigel Croxon <ncroxon@redhat.com>,
        David Jeffery <djeffery@redhat.com>, minlei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 11, 2019 at 8:46 AM Laurence Oberman <loberman@redhat.com> wrote:
>
> On Mon, 2019-11-11 at 10:32 -0500, John Pittman wrote:
> > Due to unneeded multiplication in the out_free_pages portion of
> > r10buf_pool_alloc(), when using a 3-copy raid10 layout, it is
> > possible to access a resync_pages offset that has not been
> > initialized.  This access translates into a crash of the system
> > within resync_free_pages() while passing a bad pointer to
> > put_page().  Remove the multiplication, preventing access to the
> > uninitialized area.
> >
> > Fixes: f0250618361db ("md: raid10: don't use bio's vec table to
> > manage resync pages")
> > Signed-off-by: John Pittman <jpittman@redhat.com>
> > Suggested-by: David Jeffery <djeffery@redhat.com>
> > ---
> >  drivers/md/raid10.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index 299c7b1c9718..8a62c920bb65 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -191,7 +191,7 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags,
> > void *data)
> >
> >  out_free_pages:
> >       while (--j >= 0)
> > -             resync_free_pages(&rps[j * 2]);
> > +             resync_free_pages(&rps[j]);
> >
> >       j = 0;
> >  out_free_bio:
>
> This was reproduduced and tested multiple times by John in the Red Hat
> Lab and tested by the customer. Thanks David and John.
> Reviewed-by: Laurence Oberman <loberman@redhat.com>

Applied to md-next. Thanks for the fix!

Song
