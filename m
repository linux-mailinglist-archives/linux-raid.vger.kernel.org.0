Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E33286EE3
	for <lists+linux-raid@lfdr.de>; Thu,  8 Oct 2020 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgJHG4g (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 8 Oct 2020 02:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgJHG4g (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 8 Oct 2020 02:56:36 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7661E2184D
        for <linux-raid@vger.kernel.org>; Thu,  8 Oct 2020 06:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602140195;
        bh=dCgpCHYlSLzw8EFWMPORhRBC+PTWjfTJUsp4seTfWG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kW2i19+kKqLOVt8oevA+VC8I1msxuw5ISP24NcM44/hqXYmGAEZyyagbo5vUawoTn
         SJzNmFrRLghAX9LQEtaDRqRjh/P+kuA0RUdRYaQBSE6LPZgvzq2fd+2qgoWQLhaUSy
         wrUxTUjolyRA5B4gyVLXOC/GPmxj9bHiWu+qiPzA=
Received: by mail-lj1-f174.google.com with SMTP id c21so4540053ljn.13
        for <linux-raid@vger.kernel.org>; Wed, 07 Oct 2020 23:56:35 -0700 (PDT)
X-Gm-Message-State: AOAM530KBFBaejwD/usTT+F+WW7HIynCl9Pq/xSt+jyNMSLKFdaZl7bf
        U3g+cq4eTgT8ajFRnEuX1pJuIqMBz6POVj+wUb0=
X-Google-Smtp-Source: ABdhPJzVTSZIj9iQNZ6ApPJb8u/KMr9Xc8J5YiIs8rIzg33ui+l0OT2IjhuuZRMH3SvvnmJKk+wIZjl5Ou5W9Y+PdR0=
X-Received: by 2002:a05:651c:104:: with SMTP id a4mr2742059ljb.273.1602140193600;
 Wed, 07 Oct 2020 23:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <1601185213-7464-1-git-send-email-heming.zhao@suse.com> <fd2dddb4-13d1-31a3-a2ee-031a8e781634@cloud.ionos.com>
In-Reply-To: <fd2dddb4-13d1-31a3-a2ee-031a8e781634@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 7 Oct 2020 23:56:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4r=zwvKKs+WgqBfXiWF1Qn71OKH40ovVReJjPvkUcpug@mail.gmail.com>
Message-ID: <CAPhsuW4r=zwvKKs+WgqBfXiWF1Qn71OKH40ovVReJjPvkUcpug@mail.gmail.com>
Subject: Re: [PATCH] [md-cluster] fix memory leak for bitmap
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Zhao Heming <heming.zhao@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 7, 2020 at 8:36 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 9/27/20 07:40, Zhao Heming wrote:
> > current code doesn't free temporary bitmap memory.
> >
> > Signed-off-by: Zhao Heming <heming.zhao@suse.com>
> > ---
> >   drivers/md/md-bitmap.c  | 1 +
> >   drivers/md/md-cluster.c | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> > index b10c519..593fe15 100644
> > --- a/drivers/md/md-bitmap.c
> > +++ b/drivers/md/md-bitmap.c
> > @@ -2012,6 +2012,7 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
> >       md_bitmap_unplug(mddev->bitmap);
> >       *low = lo;
> >       *high = hi;
> > +     md_bitmap_free(bitmap);
> >
> >       return rv;
> >   }
> > diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> > index d50737e..afbbc55 100644
> > --- a/drivers/md/md-cluster.c
> > +++ b/drivers/md/md-cluster.c
> > @@ -1166,6 +1166,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
> >                        * can't resize bitmap
> >                        */
> >                       goto out;
> > +             md_bitmap_free(bitmap);
> >       }
> >
> >       return 0;
>
> I'd prefer add a comment for get_bitmap_from_slot to mention it's caller
> need to
> free bitmap.

I added comment to the patch with Guoqing's "Suggested-by" tag, and applied
it to md-next. I also made some changes to the commit log of all 3 patches from
Heming.

Herming, for future patches, please prefix the subject with "md:" or
"md/bitmap".

Thanks,
Song
