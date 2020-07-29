Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440722316E3
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgG2AoC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 20:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbgG2AoC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jul 2020 20:44:02 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A2E2078E
        for <linux-raid@vger.kernel.org>; Wed, 29 Jul 2020 00:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595983442;
        bh=zCt+tIBx76Uke/M4AE1W7I7ZTnKLV0F0Jzdbi7vcloE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LLIGsgzg2UULWnWefi+3teReZLP0LE0CEb0o4/CBHVwR91/KozcIaF4KfShe3zq59
         4mNMZjrZxZj+R9A0dLcZ4v3ub+oP3oDQ0wmOwDhFa46NsCx1UWYC8Ws41jLqc4R+6P
         fpDJ5kG1zJ/tVMaYMw7Xx66ykraJc83hSlpxyGWU=
Received: by mail-lf1-f41.google.com with SMTP id h8so12014084lfp.9
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 17:44:01 -0700 (PDT)
X-Gm-Message-State: AOAM532MPzVfNtoBojNtEUBbhuDgtM2JepFCx/ubm9fP5dPUMfyHkql7
        oTawd9BKrDiz9pA/Vq8mkyXH78EaKo5AViV6g7g=
X-Google-Smtp-Source: ABdhPJxuJ2ubkShO+8nF4euLIlIgKnBKNvPIX38xsnUnljPe2R8M+f/zLSAU1mAV0RNsNyM3IZcCn+Wo0JQXBOhT0A8=
X-Received: by 2002:a05:6512:3a5:: with SMTP id v5mr15369034lfp.138.1595983439917;
 Tue, 28 Jul 2020 17:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <1593503737-5067-1-git-send-email-xni@redhat.com>
 <1593503737-5067-2-git-send-email-xni@redhat.com> <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
 <9626595c-cdd8-f46d-629e-67f9b11d2b6a@redhat.com>
In-Reply-To: <9626595c-cdd8-f46d-629e-67f9b11d2b6a@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 17:43:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5RAEb7i-VQ+MS0XfGKNyd=2_=VoGVjk2SU6A30cW9PKg@mail.gmail.com>
Message-ID: <CAPhsuW5RAEb7i-VQ+MS0XfGKNyd=2_=VoGVjk2SU6A30cW9PKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] super1.0 calculates max sectors in a wrong way
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jul 27, 2020 at 6:18 PM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 07/28/2020 01:33 AM, Song Liu wrote:
> > On Tue, Jun 30, 2020 at 12:55 AM Xiao Ni <xni@redhat.com> wrote:
> >> One super1.0 raid array wants to grow size, it needs to check the device max usable
> >> size. If the requested size is bigger than max usable size, it will return an error.
> >>
> >> Now it uses rdev->sectors for max usable size. If one disk is 500G and the raid device
> >> only uses the 100GB of this disk. rdev->sectors can't tell the real max usable size.
> >> The max usable size should be dev_size-(superblock_size+bitmap_size+badblock_size).
> >>
> >> Signed-off-by: Xiao Ni <xni@redhat.com>
> > Thanks for the fix!
> >
> >> ---
> >>   drivers/md/md.c | 26 +++++++++++++++++++++++---
> >>   1 file changed, 23 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index f567f53..d2c5984 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -2183,10 +2183,30 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
> >>                  return 0;
> >>          } else {
> >>                  /* minor version 0; superblock after data */
> >> -               sector_t sb_start;
> >> -               sb_start = (i_size_read(rdev->bdev->bd_inode) >> 9) - 8*2;
> >> +               sector_t sb_start, bm_space;
> >> +               sector_t dev_size = i_size_read(rdev->bdev->bd_inode) >> 9;
> >> +
> >> +               /* 8K is for superblock */
> >> +               sb_start = dev_size - 8*2;
> >>                  sb_start &= ~(sector_t)(4*2 - 1);
> >> -               max_sectors = rdev->sectors + sb_start - rdev->sb_start;
> >> +
> >> +               /* if the device is bigger than 8Gig, save 64k for bitmap usage,
> >> +                * if bigger than 200Gig, save 128k
> >> +                */
> >> +               if (dev_size < 64*2)
> >> +                       bm_space = 0;
> >> +               else if (dev_size - 64*2 >= 200*1024*1024*2)
> >> +                       bm_space = 128*2;
> >> +               else if (dev_size - 4*2 > 8*1024*1024*2)
> >> +                       bm_space = 64*2;
> >> +               else
> >> +                       bm_space = 4*2;
> > Could you explain the handling of bitmap space?
> Hi Song
>
> This calculation of bitmap is decided by mdadm. In mdadm super1.c
> choose_bm_space function,
> it uses this way to calculate bitmap space. Do I need to add comments
> here to describe this?
> Something like "mdadm function choose_bm_space decides the bitmap space"?

Thanks for the explanation.

I merged the two patches, made some changes, and applied it to md-next. Please
let me know whether it looks good.

Song
