Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46522F6B9
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jul 2020 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgG0ReK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jul 2020 13:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgG0ReK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Jul 2020 13:34:10 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA3220729
        for <linux-raid@vger.kernel.org>; Mon, 27 Jul 2020 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595871249;
        bh=UyZeZP4X7TtgZbJmmSnNNeXfY7Xss6pUgf7zOTqV0hE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VRFnpSmnbjXVZAE+7ohSNkG+mbvysRArotYETwZRVYHWsfE31WEPy3RAPmOzDxnxD
         cXotNNcsNfpc2wimeC+mGkLqblcWlCLLYVssmtBExoQPi2+fEiqb8l7tvgX7K/nPZF
         2VNJzZNv+9wKTHxNx5pxrzpHCIWdGT8ClyxlNJSA=
Received: by mail-lf1-f42.google.com with SMTP id y18so9434297lfh.11
        for <linux-raid@vger.kernel.org>; Mon, 27 Jul 2020 10:34:09 -0700 (PDT)
X-Gm-Message-State: AOAM531rGwhZEcQeQhr8AoVe9FS1+S7dVbdLjvEDYYJ7VJKJO64RFoX1
        7J1d/iVJK1pgGwaPQna8I3n2wL8JSM4WOtMT250=
X-Google-Smtp-Source: ABdhPJz+l8RHw2kvlhiOTCKwdWw8Cs+9fjCBeMnaCGMB28kqR2YyXYjDsq+IIo/FGeYSAI2JAtRBMBoBV4cwOCs5XaQ=
X-Received: by 2002:a19:ec12:: with SMTP id b18mr12309480lfa.52.1595871247839;
 Mon, 27 Jul 2020 10:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <1593503737-5067-1-git-send-email-xni@redhat.com> <1593503737-5067-2-git-send-email-xni@redhat.com>
In-Reply-To: <1593503737-5067-2-git-send-email-xni@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jul 2020 10:33:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
Message-ID: <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] super1.0 calculates max sectors in a wrong way
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 30, 2020 at 12:55 AM Xiao Ni <xni@redhat.com> wrote:
>
> One super1.0 raid array wants to grow size, it needs to check the device max usable
> size. If the requested size is bigger than max usable size, it will return an error.
>
> Now it uses rdev->sectors for max usable size. If one disk is 500G and the raid device
> only uses the 100GB of this disk. rdev->sectors can't tell the real max usable size.
> The max usable size should be dev_size-(superblock_size+bitmap_size+badblock_size).
>
> Signed-off-by: Xiao Ni <xni@redhat.com>

Thanks for the fix!

> ---
>  drivers/md/md.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f567f53..d2c5984 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2183,10 +2183,30 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
>                 return 0;
>         } else {
>                 /* minor version 0; superblock after data */
> -               sector_t sb_start;
> -               sb_start = (i_size_read(rdev->bdev->bd_inode) >> 9) - 8*2;
> +               sector_t sb_start, bm_space;
> +               sector_t dev_size = i_size_read(rdev->bdev->bd_inode) >> 9;
> +
> +               /* 8K is for superblock */
> +               sb_start = dev_size - 8*2;
>                 sb_start &= ~(sector_t)(4*2 - 1);
> -               max_sectors = rdev->sectors + sb_start - rdev->sb_start;
> +
> +               /* if the device is bigger than 8Gig, save 64k for bitmap usage,
> +                * if bigger than 200Gig, save 128k
> +                */
> +               if (dev_size < 64*2)
> +                       bm_space = 0;
> +               else if (dev_size - 64*2 >= 200*1024*1024*2)
> +                       bm_space = 128*2;
> +               else if (dev_size - 4*2 > 8*1024*1024*2)
> +                       bm_space = 64*2;
> +               else
> +                       bm_space = 4*2;

Could you explain the handling of bitmap space?

Thanks,
Song
