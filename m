Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D72128AF
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgGBPxA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGBPw7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Jul 2020 11:52:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120EC08C5C1
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 08:52:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so29274943ljp.6
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1hZZYHT2jx0soQwDY2Nw4ZNux9TK2TS4ou5sFWlySY=;
        b=KwW+/U9fkM+srFlFPvkKz4V3jEnKIKH8ygaroNt4YXgCxeue/VrdTKoJwmcn9oXIVs
         4DY0ZVk34mPlw7u4KLu6rGjhvnrQL6/lofTS76CSIpt1KUwe2M3VISdDz83TvG8iTXSI
         W47Pw8OTk/hC0zb2MZaQ1r596h7N8T5A23JSQkaU9RWiYgGd5Xav7JwLesO4IqMIFUZL
         2VuieIxaw/GaR9iMUF6CkG5lHBbOPJgWIfkSCxXHB48wkXOO7uuaIH8G93d6r33rKKeJ
         p2LG1w2EFwjJvNEP/726kUUAmMNBPXMl5+BvhQTxMO/S6XCBw/1QqIdNdExANIirUL/4
         +A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1hZZYHT2jx0soQwDY2Nw4ZNux9TK2TS4ou5sFWlySY=;
        b=FtBvxiBvNj8w/xYqYA+E7uC53BurqyX59y65r0iEtnjFqhYqbGHVxO+XPCzXPn8395
         nn6+f2RnLg967lK4mRrDYeMmjD0FfXNu5g98XGYn6EHDKulHRX9DCW+Ba77izg0e1MHj
         7yvfq6dlwORmyp+CjPmEEtyTpwCO/mu8i2ErrcWTirZckYsUUZcNLrZvOQBJKDYV4zIj
         NH4hIs+ncHRIWw+C3S+XHK6qhk8wx0YSjcXRrzCYCLYT802+8wd43D9Ba3JaOo6lXA2K
         1fSqfqwF/5J1vH3U1//DYFS4GDRCFpu1pQARcd7C6qJZWE03tkk1NkBPOPXY6Nwgezdb
         ORmA==
X-Gm-Message-State: AOAM5309TtXzWE2vLbpbQ1PpE1MfnnPXKca+Ut8GIYQodqamsya9ptn9
        vgM7TAkrMFpJXSpftT4hOB9nARsYCl2XczNb6OfS4A==
X-Google-Smtp-Source: ABdhPJz3ABkPWjkv8L0FIiK+Kjjg6BO4eaaimJnKQo1xzAYZPxzmmzDpXVUF4bLDPypwEcFJ8kmLmaUrHoL1B8Z52PM=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr16463205ljp.266.1593705177353;
 Thu, 02 Jul 2020 08:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200629193947.2705954-1-hch@lst.de> <20200629193947.2705954-19-hch@lst.de>
 <20200702141001.GA3834@lca.pw> <20200702151453.GA1799@lst.de>
In-Reply-To: <20200702151453.GA1799@lst.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Jul 2020 21:22:46 +0530
Message-ID: <CA+G9fYv6DfJB=DeQFVptAuaVv1Ng-BK0fRHgFZ=DNzymu8LVvw@mail.gmail.com>
Subject: Re: [PATCH 18/20] block: refator submit_bio_noacct
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <cai@lca.pw>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, 2 Jul 2020 at 20:45, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 02, 2020 at 10:10:10AM -0400, Qian Cai wrote:
> > On Mon, Jun 29, 2020 at 09:39:45PM +0200, Christoph Hellwig wrote:
> > > Split out a __submit_bio_noacct helper for the actual de-recursion
> > > algorithm, and simplify the loop by using a continue when we can't
> > > enter the queue for a bio.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reverting this commit and its dependencies,
> >
> > 5a6c35f9af41 block: remove direct_make_request
> > ff93ea0ce763 block: shortcut __submit_bio_noacct for blk-mq drivers
> >
> > fixed the stack-out-of-bounds during boot,
> >
> > https://lore.kernel.org/linux-block/000000000000bcdeaa05a97280e4@google.com/
>
> Yikes.  bio_alloc_bioset pokes into bio_list[1] in a totally
> undocumented way.  But even with that the problem should only show
> up with "block: shortcut __submit_bio_noacct for blk-mq drivers".
>
> Can you try this patch?

Applied your patch on top of linux-next 20200702 and tested on
arm64 and x86_64 devices and the reported BUG fixed.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bf882b8d84450c..9f1bf8658b611a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1155,11 +1155,10 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  {
>         struct gendisk *disk = bio->bi_disk;
> -       struct bio_list bio_list;
> +       struct bio_list bio_list[2] = { };
>         blk_qc_t ret = BLK_QC_T_NONE;
>
> -       bio_list_init(&bio_list);
> -       current->bio_list = &bio_list;
> +       current->bio_list = bio_list;
>
>         do {
>                 WARN_ON_ONCE(bio->bi_disk != disk);
> @@ -1174,7 +1173,7 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>                 }
>
>                 ret = blk_mq_submit_bio(bio);
> -       } while ((bio = bio_list_pop(&bio_list)));
> +       } while ((bio = bio_list_pop(&bio_list[0])));
>
>         current->bio_list = NULL;
>         return ret;

ref:
https://lkft.validation.linaro.org/scheduler/job/1538359#L288
https://lkft.validation.linaro.org/scheduler/job/1538360#L572


- Naresh
