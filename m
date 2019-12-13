Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D534B11E9C2
	for <lists+linux-raid@lfdr.de>; Fri, 13 Dec 2019 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfLMSI3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Dec 2019 13:08:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37982 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMSI2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Dec 2019 13:08:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so318107qki.5
        for <linux-raid@vger.kernel.org>; Fri, 13 Dec 2019 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+o/EBhYI1uPFvQEm0zcHgINLfjMoOj5QhpVVttP9g0=;
        b=FSnY3fRgBXfEz6EKk/vUH2mqXP3dz5+GelTLRkCvryi3OcxOdyc/sEezzSur27UOCU
         bDdUTN0wvjLHvOtf59BgQIw/aFSYzkxvPhcgNYIRUWqj+7v38+/oCy/VwkGMlMd1LNZk
         orke5DLsLZSkXHhdG9y6PsIVdw43/HrPqOQfw3MkFNl0uQNPLWiveSlwU3GDrIJeHXtv
         JaUMBkywDFlW0Z2OkpANzqz5ZieS/yNBH8n2rpnCaH+BRj/pFLBOLMpd1NH4trTqgjyZ
         WEEcm2NrxNejAz8fb/DUlghXPppGbM+1lJTYnS8xhGoLFTeKuT4sfw8ALnq6J76nHPwR
         2YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+o/EBhYI1uPFvQEm0zcHgINLfjMoOj5QhpVVttP9g0=;
        b=BsaRcVS7ADcWlhN78aYkZeiYbzEoO0dLtHbqBnQloWbZYmJEY+MzAVuQzBhstCjCye
         yosIfFcu6L07JVM8H0C5jHnk3mSE+HImLig6eqUUyKbWypWJjwpygp/tKqBCUNzQtBag
         UAkvhBR4xthmVLWd/XNg0jVH89ub2efkEgB4ia+A2+QihfPjW/+lhH/0oHJHTC97Lo+O
         4C0hSNlrnvG0IdwYU87iF7ZASXk0alOAnRSJiPhN/pTYrOXbh91OvPYlRARXTVxQ4k6b
         aneFVXBG9kYrZOyisGQJHn5WYYJV6f/I7LqW0/kW1xlu+D94vrBRSIo+PCZo6vCHA2Ty
         Oixg==
X-Gm-Message-State: APjAAAXh329OuxFD37IGobLv1URdotUdeHGIrRXI93rhXKw6Sr04E8wn
        gA0rxMJNms2qR+TK7UQ6Hossl2J9l1KO7Sl5yPg=
X-Google-Smtp-Source: APXvYqy0IiIAvCMVCmKj8ckQ0XUuv7DE2ysF/K9TYZX6mZ4arbxC0WL5UzBhn0Jl/5PTJNXdWh3m0jiAsQWMuKx0RSs=
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr14871816qkj.497.1576260507657;
 Fri, 13 Dec 2019 10:08:27 -0800 (PST)
MIME-Version: 1.0
References: <b0701f30-5df9-059e-95f1-74a887782528@huawei.com> <f684ec06-cb01-b296-33bd-0e429af01077@huawei.com>
In-Reply-To: <f684ec06-cb01-b296-33bd-0e429af01077@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 13 Dec 2019 10:08:16 -0800
Message-ID: <CAPhsuW5raVXg3BrVpinQ6x-pZgskEMQmd5=uxS+nBk=wO4mrDg@mail.gmail.com>
Subject: Re: [PATCH] md-bitmap: small cleanups
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, guiyao@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Dec 11, 2019 at 6:39 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>
> Friendly ping...

Sorry for the delay. This looks good to me. I will apply it to md-next.

Song

>
> On 2019/12/7 11:00, liuzhiqiang (I) wrote:
> >
> > In md_bitmap_unplug, bitmap->storage.filemap is double checked.
> >
> > In md_bitmap_daemon_work, bitmap->storage.filemap should be checked
> > before reference.
> >
> > Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> > ---
> >  drivers/md/md-bitmap.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> > index 3ad18246fcb3..9860062bdc1e 100644
> > --- a/drivers/md/md-bitmap.c
> > +++ b/drivers/md/md-bitmap.c
> > @@ -1019,8 +1019,6 @@ void md_bitmap_unplug(struct bitmap *bitmap)
> >       /* look at each page to see if there are any set bits that need to be
> >        * flushed out to disk */
> >       for (i = 0; i < bitmap->storage.file_pages; i++) {
> > -             if (!bitmap->storage.filemap)
> > -                     return;
> >               dirty = test_and_clear_page_attr(bitmap, i, BITMAP_PAGE_DIRTY);
> >               need_write = test_and_clear_page_attr(bitmap, i,
> >                                                     BITMAP_PAGE_NEEDWRITE);
> > @@ -1338,7 +1336,8 @@ void md_bitmap_daemon_work(struct mddev *mddev)
> >                                  BITMAP_PAGE_DIRTY))
> >                       /* bitmap_unplug will handle the rest */
> >                       break;
> > -             if (test_and_clear_page_attr(bitmap, j,
> > +             if (bitmap->storage.filemap &&
> > +                 test_and_clear_page_attr(bitmap, j,
> >                                            BITMAP_PAGE_NEEDWRITE)) {
> >                       write_page(bitmap, bitmap->storage.filemap[j], 0);
> >               }
> >
>
