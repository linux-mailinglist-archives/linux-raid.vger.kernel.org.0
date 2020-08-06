Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08D23D487
	for <lists+linux-raid@lfdr.de>; Thu,  6 Aug 2020 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHFAUx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 5 Aug 2020 20:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHFAUx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 5 Aug 2020 20:20:53 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE3E22B48;
        Thu,  6 Aug 2020 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596673252;
        bh=7dbWXaoz7TdzVkI79oGvyml9jxtjtuRhPuSTLvhDVfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TAHwI6lbO8T6WhwcDc2rrRcZzDjgNv/gKgCT3lPKssSmSHdRZCOkEwBATUTuz7HiA
         Ex6obY/vO/bYL7JIq2fw20scKMA7HsvgPwM/AGVIVFuG3bTyELSyaFNRet63J7NeiA
         4rktSimeojR9a76huDRaNuYZ6mFMhTGSQLeXnYsA=
Received: by mail-lf1-f51.google.com with SMTP id b30so25203656lfj.12;
        Wed, 05 Aug 2020 17:20:52 -0700 (PDT)
X-Gm-Message-State: AOAM5316sulzti5Jz+O1l7+buq4rSx9xpiYnHXzre/sNH5n4YuvXnzHE
        ClIrgELl8yIzn0Uj1lVN3h50tTDGMPxyBdiHWk4=
X-Google-Smtp-Source: ABdhPJxh+AUaku3oNgM4YDqXv9HP3rtbDipSkW55DfSp+GUUZ1CPjzQ8KA1gzrM2JO6/2nddbtlLNwZr5RlmYMjOlng=
X-Received: by 2002:a19:7710:: with SMTP id s16mr2698216lfc.162.1596673250381;
 Wed, 05 Aug 2020 17:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200804101645.GB392148@mwanda> <824849e0-c98d-1f22-817c-7a76d3ee22b1@cloud.ionos.com>
 <20200804111549.GN5493@kadam>
In-Reply-To: <20200804111549.GN5493@kadam>
From:   Song Liu <song@kernel.org>
Date:   Wed, 5 Aug 2020 17:20:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4EKCMhL0T=1iMbVYrh1azZOD-jQ-vXDMmZ5cy2m-oW4g@mail.gmail.com>
Message-ID: <CAPhsuW4EKCMhL0T=1iMbVYrh1azZOD-jQ-vXDMmZ5cy2m-oW4g@mail.gmail.com>
Subject: Re: [PATCH] md-cluster: Fix potential error pointer dereference in resize_bitmaps()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Shaohua Li <shli@fb.com>, NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Aug 4, 2020 at 4:16 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Aug 04, 2020 at 12:40:18PM +0200, Guoqing Jiang wrote:
> >
> >
> > On 8/4/20 12:16 PM, Dan Carpenter wrote:
> > > The error handling calls md_bitmap_free(bitmap) which checks for NULL
> > > but will Oops if we pass an error pointer.  Let's set "bitmap" to NULL
> > > on this error path.
> > >
> > > Fixes: afd756286083 ("md-cluster/raid10: resize all the bitmaps before start reshape")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >   drivers/md/md-cluster.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> > > index 73fd50e77975..d50737ec4039 100644
> > > --- a/drivers/md/md-cluster.c
> > > +++ b/drivers/md/md-cluster.c
> > > @@ -1139,6 +1139,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
> > >             bitmap = get_bitmap_from_slot(mddev, i);
> > >             if (IS_ERR(bitmap)) {
> > >                     pr_err("can't get bitmap from slot %d\n", i);
> > > +                   bitmap = NULL;
> > >                     goto out;
> > >             }
> > >             counts = &bitmap->counts;
> >
> > Thanks for the catch, Reviewed-by: Guoqing Jiang
> > <guoqing.jiang@cloud.ionos.com>
> >
> > BTW, seems there could be memory leak in the function since it keeps
> > allocate bitmap
> > in the loop ..., will send a format patch.
> >
> >
> > diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> > index 73fd50e77975..89d7b32489d8 100644
> > --- a/drivers/md/md-cluster.c
> > +++ b/drivers/md/md-cluster.c
> > @@ -1165,6 +1165,8 @@ static int resize_bitmaps(struct mddev *mddev,
> > sector_t newsize, sector_t oldsiz
> >                          * can't resize bitmap
> >                          */
> >                         goto out;
> > +
> > +               md_bitmap_free(bitmap);
>
> Hm...  I'm now not at all certain my patch is correct.  Although it's
> obviously harmless and fixes an Oops.  I had thought that that the call
> to update_bitmap_size(mddev, oldsize) would free the rest of the loop.
>
> I really suspect adding a free like you're suggesting will break the
> success path.
>
> I'm not familiar with this code at all.

Thanks Dan and Guoqing. I applied Dans' patch to md-next.

I think we are leaking bitmap in resize_bitmaps(). But we gonna need
more complex fix than the md_bitmap_free() above.

Thanks,
Song
