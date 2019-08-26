Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A539D732
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2019 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfHZUH0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 26 Aug 2019 16:07:26 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:42274 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbfHZUH0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 26 Aug 2019 16:07:26 -0400
Received: by mail-qk1-f173.google.com with SMTP id 201so15118771qkm.9
        for <linux-raid@vger.kernel.org>; Mon, 26 Aug 2019 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wei0oIDnaIZn4tEVB6quf1zPLivQm8RlmHUa9K6EIbw=;
        b=H1GRISm38QOT4wMZzCjDLna2Dsj1CbRrM7MGn8H4HA3NtKNDuDmsvoAgH04WViEwZr
         21wng8GnnJaDOt9GRt1ADSYY/qiqWBvlATeLnizJ9kDE/IaUS2ObHihIdhOQ+V6INFkj
         kf/2DwwqcGoLSeGNtfBBL3usTZrl+xcSg31VKIV8gLfzybiHmHFXyq+wGRJcf31eudGR
         FXYEy+gjxgOvTfRhjaTZ/6+JVBP7laofGeFf25eSnktKBHipnxatP5bxlpKd7fTYPTc6
         ZBbSK9bqiKtCOksMHaTtI66fB3JLpqrLRC3AKiwUGIFuPlLIm9R16EtmWBXbIh7StK33
         B32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wei0oIDnaIZn4tEVB6quf1zPLivQm8RlmHUa9K6EIbw=;
        b=Gn+175tQLlrDzHgtf9tKxQ2FdPZJU6PkD93q5RW45Tm0YVybSLXJMb+sSxKa/twA/g
         sB0toTRClR0J7iRRp37j7SbrQ0VzEl5UBAsrK0hNEGMwM1ACqNLbCWvEwsdtwRl7LQ4L
         m/JHEqiQl62J5NiDcOUj2OlUNKadk75Dq0ZPz+dmzbUbep7OWomZzHhNRz/48CYYJpqr
         bbIYOFo+T6Nx+94R9KaaHje98d8K1mpwjldIYNuziLTFk3IgzgtcLqTcRxvKtw/cyQu8
         ofw2bHCe6um4qugRKtpYnF2twP7s8WYvGOK3yFZY3w4pP0KOi7J3UOw/bo4cmiDa0Jba
         6+dg==
X-Gm-Message-State: APjAAAVo7YS1SI4nQBDzaGyxsS/yYjirURu88prtFGufY1P2hXi4r1QY
        oomQXHBU4w0ig0Ch8LNAFCbDg2MM9QBLo7uBNAg=
X-Google-Smtp-Source: APXvYqw5fzZW1ywTMSjheLToA+1csUWaFPPSlLSt+fHGuH0m8z6n0Cr6mKYUaIRztkbtSrp84B42fKbKhw4R/NUZ+0Y=
X-Received: by 2002:a37:a142:: with SMTP id k63mr17908944qke.487.1566850045545;
 Mon, 26 Aug 2019 13:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <7401b3e0-fb0c-8ed7-b1cb-28494fbac967@cloud.ionos.com> <e2aad07c-1f67-12c7-ac33-6df9cbdac43c@cloud.ionos.com>
In-Reply-To: <e2aad07c-1f67-12c7-ac33-6df9cbdac43c@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 26 Aug 2019 13:07:14 -0700
Message-ID: <CAPhsuW4gu4BaU=2cTNSGQoLEp4xeixRMgDrqfw0Eoxiu=QfeBw@mail.gmail.com>
Subject: Re: WARNING in break_stripe_batch_list with "stripe state: 2001"
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Guoqing,

Sorry for the delay.

On Mon, Aug 26, 2019 at 6:46 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
[...]
> >
> > Maybe it makes sense to remove the checking of STRIPE_ACTIVE just like
> > commit 550da24f8d62f
> > ("md/raid5: preserve STRIPE_PREREAD_ACTIVE in break_stripe_batch_list").
> >
> > @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
> > stripe_head *head_sh,
> >
> >                 list_del_init(&sh->batch_list);
> >
> > -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
> > -                                         (1 << STRIPE_SYNCING) |
> > +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
> >                                           (1 << STRIPE_REPLACED) |
> >                                           (1 << STRIPE_DELAYED) |
> >                                           (1 << STRIPE_BIT_DELAY) |

This part looks good to me.

> > @@ -4626,6 +4626,7 @@ static void break_stripe_batch_list(struct
> > stripe_head *head_sh,
> >
> >                 set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
> >                                             (1 <<
> > STRIPE_PREREAD_ACTIVE) |
> > +                                           (1 << STRIPE_ACTIVE) |
> >                                             (1 << STRIPE_DEGRADED) |
> >                                             (1 <<
> > STRIPE_ON_UNPLUG_LIST)),
> >                               head_sh->state & (1 << STRIPE_INSYNC));
> >

But I think we should not clear STRIPE_ACTIVE here. It should be
cleared at the end of handle_stripe().

Does this make sense?

Thanks,
Song
