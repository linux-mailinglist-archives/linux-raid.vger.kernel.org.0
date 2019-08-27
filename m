Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062B99F352
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfH0TdL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 15:33:11 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40979 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbfH0TdL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 27 Aug 2019 15:33:11 -0400
Received: by mail-qt1-f172.google.com with SMTP id i4so210952qtj.8
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pbCkUJwLJJiQJfjlnBcfiQXqYgdX6cPoPVyT8i2CyE=;
        b=rjzOVM6ChU+eF1CVub+KEF0IZj5dLFSPbqD8sCxI9isDYVPVfYQh1xUP1M0vyvV736
         y3AV/fpwBE2foNuOTgDiMHmontuOg+4vUHeX+2VeUVpfdtcozgleeMZPYWIsCeYOck/L
         qH1f3md3zAEH9uEboATKTZYhnskxFbhQmP8t05kAgDGgHxSH2ZSNtr6QHyupplX6xWl3
         F9eLkPHesvQV0DMsW5ArwnVtaU9qcjSp3twqnWMX25O+fCTWxKPO29WkNM6EQJauYvdt
         0kBIqxopmpNvmjYdOnbYVCpxMaM1cJeENzNZxIKbbS8hArfEr1ZqRNJ8mS9Sp/cLyfUI
         acKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pbCkUJwLJJiQJfjlnBcfiQXqYgdX6cPoPVyT8i2CyE=;
        b=Rx+4xvuxnvIrNqnDpAIMWaekMyFTgkMrhdNtyfeIYhXWY1TN5DqIHLmt0xW4xeZXwe
         owGyst0OeCPOVFiLslLfU0APz8OOibjknNXYiMJ9/S9C4Tju0V7I6SmKHrYeniTfo0AZ
         wtYABFJRZam18z7nYg4W+Ri5dAKojzEDVLsTlZpfH+zI4uVvK8HGnXTcODnZMXiPw+Vg
         TT+VT8ib3AdTtERXI53+TwfxeNhc3bF3z9IXNk30gOG619pTz1ut8kTMdSVZC2ZvK4BC
         V/mr3GvimOd1GweEL1fNoMFa/WJYwrhhT66sd2EONNJ1KRl4ddZSo7dBfe+h5IPsi+tK
         +eAA==
X-Gm-Message-State: APjAAAUpdOvAp8iKKbMV8mYbQBNPXe25ijMOkOp8NlpUUXR57daoqHG9
        w/o6I5AjVntKfY2tVNULs+m+GvQWvfAJZAEShXU=
X-Google-Smtp-Source: APXvYqz5dD8ehY5o3tw07lrynzm0NoGhF8Xbof1QKN175VQ7UojPWY/ow6Q/Za0zLVjl97XIknFLnZX8xgdjLyFrH+A=
X-Received: by 2002:ac8:930:: with SMTP id t45mr525760qth.84.1566934390075;
 Tue, 27 Aug 2019 12:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <7401b3e0-fb0c-8ed7-b1cb-28494fbac967@cloud.ionos.com>
 <e2aad07c-1f67-12c7-ac33-6df9cbdac43c@cloud.ionos.com> <CAPhsuW4gu4BaU=2cTNSGQoLEp4xeixRMgDrqfw0Eoxiu=QfeBw@mail.gmail.com>
 <a2536d84-68df-3422-b677-66c666ebb35b@cloud.ionos.com>
In-Reply-To: <a2536d84-68df-3422-b677-66c666ebb35b@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 27 Aug 2019 12:32:59 -0700
Message-ID: <CAPhsuW7Na2_K9dxiLRv0z+BxYvukvXYqimU9jpne8znJqSy9cg@mail.gmail.com>
Subject: Re: WARNING in break_stripe_batch_list with "stripe state: 2001"
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Aug 27, 2019 at 12:39 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi Song,
>
> Thanks a lot for your reply.
>
> On 8/26/19 10:07 PM, Song Liu wrote:
> > Hi Guoqing,
> >
> > Sorry for the delay.
> >
> > On Mon, Aug 26, 2019 at 6:46 AM Guoqing Jiang
> > <guoqing.jiang@cloud.ionos.com> wrote:
> > [...]
> >>> Maybe it makes sense to remove the checking of STRIPE_ACTIVE just like
> >>> commit 550da24f8d62f
> >>> ("md/raid5: preserve STRIPE_PREREAD_ACTIVE in break_stripe_batch_list").
> >>>
> >>> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
> >>> stripe_head *head_sh,
> >>>
> >>>                  list_del_init(&sh->batch_list);
> >>>
> >>> -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
> >>> -                                         (1 << STRIPE_SYNCING) |
> >>> +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
> >>>                                            (1 << STRIPE_REPLACED) |
> >>>                                            (1 << STRIPE_DELAYED) |
> >>>                                            (1 << STRIPE_BIT_DELAY) |
> > This part looks good to me.
> >
> >>> @@ -4626,6 +4626,7 @@ static void break_stripe_batch_list(struct
> >>> stripe_head *head_sh,
> >>>
> >>>                  set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
> >>>                                              (1 <<
> >>> STRIPE_PREREAD_ACTIVE) |
> >>> +                                           (1 << STRIPE_ACTIVE) |
> >>>                                              (1 << STRIPE_DEGRADED) |
> >>>                                              (1 <<
> >>> STRIPE_ON_UNPLUG_LIST)),
> >>>                                head_sh->state & (1 << STRIPE_INSYNC));
> >>>
> > But I think we should not clear STRIPE_ACTIVE here. It should be
> > cleared at the end of handle_stripe().
>
> Yes, actually "clear_bit_unlock(STRIPE_ACTIVE, &sh->state)" is the last
> line in handle_stripe. So we only need to do one line change like.
>
>
> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
> stripe_head *head_sh,
>
>                  list_del_init(&sh->batch_list);
>
> -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
> -                                         (1 << STRIPE_SYNCING) |
> +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>                                            (1 << STRIPE_REPLACED) |
>                                            (1 << STRIPE_DELAYED) |
>                                            (1 << STRIPE_BIT_DELAY) |
>
> I will send formal patch if you are fine with above, thanks again.
>

Yes, this looks good.

Thanks,
Song
