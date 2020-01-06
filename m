Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E411E131690
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 18:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFRPl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 12:15:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34779 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRPl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 12:15:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so43015142qtz.1
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwBbtOKd0hUFjOSBuF6dsx/Bqa0lYIJsqfyKLVo9U7s=;
        b=e8hxGPVc22ndYEXq/YuZY6q/qjHj/Lij1FRIqzrgOncO0z3ZcfTxpmuFojq+0vfm7l
         8SsjledgTQLbL1PoaGRoGyVDp2iMbAIcO9kMyoQ+VA8uVN4L25A6esTy24rSrawNhXd/
         zQ2Ems3Bdd9vUEOCu8jUMPI2H/nedbf6mljbyKOyhxZBYVID56NyPgrp72YQcr9XSWBV
         R4rxwUzbZDXwMxw7DTHTHZP0oSOa1bcMuyRt8WpZ0q+bFlSn6QNtQFwrb5LikYO0GITg
         l4zEKRspIG7vA6xnJMwROxF2IT79Na0wDcuURPnhK5GAKKlrVbLZ1TSrlbWdClImTZ53
         l4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwBbtOKd0hUFjOSBuF6dsx/Bqa0lYIJsqfyKLVo9U7s=;
        b=bsyA9BMbLfDCaVUiqclBPDbOwBu9Xn5+Hea3+QDWUunkQNmiecmlb1VQVDGSsiv3CQ
         TlB3XxNLKwRsML4ephplDPMZmkUJlNtd20GdWiPREE5x/bHpDsoMWzyHNgidafDvk5L0
         igb9B3NO/DH1J2r4KM0WfKdubIiio6iBLzHRHCrM5g0XTBhDRzat5gTymk3bjDxD30sb
         8cBYKQjz9+SrpT4sacYTm3fV7JjyIiVMe4x/6epQ7+bgpqQ6wG3Ey6fsKajRU5ayKRzE
         l+wWpHzh0vOFX6OXxkVc499yhSVubgncr55N48LNX0qTn4Uo+YNLt5oiMpExTU9QWTrX
         1h0Q==
X-Gm-Message-State: APjAAAUjXRvIO4LJT1WZtkkkvijpVeEUhkzF4rJkWy9q7bQejr8VNkXc
        zq3R7FyWAPmIFez0BXJJ+wid7i5rDYbEf2W1SfwoIZMb
X-Google-Smtp-Source: APXvYqxglpqmO+JnmqaNOlGLLhJX9ivOiGY8lNtkts6yYyJiSN1sQkdi+MayPmbK5QFyvqQ1fG71tMYnoT4+1LOkzRE=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr73481989qtp.27.1578330940638;
 Mon, 06 Jan 2020 09:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW7qPsc-bZJpAV7H2qjX2MBdW8fusN7TyNphp7bF2SnB9g@mail.gmail.com>
 <CAPhsuW6Wi3++4_CHT9xanXpUH_RafbhPD2SprjKL2oo01fjwfw@mail.gmail.com> <0c667733-2a3d-1fff-4ee8-d492c0bda919@cloud.ionos.com>
In-Reply-To: <0c667733-2a3d-1fff-4ee8-d492c0bda919@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 6 Jan 2020 09:15:28 -0800
Message-ID: <CAPhsuW6jFF6yP6=z0AmoLRnaDig94a_zHSK9r=bb3APsf+9m8w@mail.gmail.com>
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 6, 2020 at 1:34 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 1/3/20 11:56 PM, Song Liu wrote:
> > On Fri, Jan 3, 2020 at 11:48 AM Song Liu <liu.song.a23@gmail.com> wrote:
> >> On Fri, Jan 3, 2020 at 5:56 AM <jgq516@gmail.com> wrote:
> >>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >>>
> >> [...]
> >>> ---
> >>>   drivers/md/raid5.c | 4 +++-
> >>>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> >>> index d4d3b67ffbba..70ef2367fa64 100644
> >>> --- a/drivers/md/raid5.c
> >>> +++ b/drivers/md/raid5.c
> >>> @@ -5481,7 +5481,9 @@ static void release_stripe_plug(struct mddev *mddev,
> >>>                          INIT_LIST_HEAD(cb->temp_inactive_list + i);
> >>>          }
> >>>
> >>> -       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
> >>> +       if (!atomic_read(&sh->count) == 0 &&
> >> "!atomic_read(&sh->count) == 0" is confusing. Do you actually mean
> >> "atomic_read(&sh->count) == 0"?
>
> If "atomic_read(&sh->count) == 0" is true, which means the sh is handled by
> do_release_stripe, so the sh could be added to other lists as I said in
> header,
> so I think we should not add the sh to cb->list for this case. IOW, the
> sh could
> be added to callback list only if it's count is not '0', no?

I see. I guess it is cleaner with
  atomic_read(&sh->count) != 0
or
  atomic_read(&sh->count) > 0
?

Thanks,
Song
