Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31824131693
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFRQ2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 12:16:28 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33137 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgAFRQ2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 12:16:28 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so19344598qvn.0
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1KOYXYy0q4of5vx8qwMkTtCkR8wXevcSEFGNGH8eFg=;
        b=U2IL1TfGc3uVPVaFFn587bZIXmIDT+ZMvzGy2a8MgpaozF32iOF3JQd69FGo2D2rAS
         ecGYAEoyZbNdcCZbrn/qxVLLdp+wurXgbXC29MKVZBzXsEMwnOnr4mtyiswTdoyDZnJZ
         T8NdZcUQ6yUxlplTEc9k3sFUNw2+S4A/EMrteoH1QugsxZNvFq9xZrZn95wSWOixVA2F
         2L7iJ8dYptTHLhZS51RHMbTrvzAVcNhloohoeB2Dx0BJxK/Ohzex8kOlXa0Fp0hSA/z2
         uquB+bU+XQT1r1TyqAUtxbCSEe0JJ5I+BBQ5OkFfulSUEF1LI6ujOXOPT8m11xb3qMTr
         Cb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1KOYXYy0q4of5vx8qwMkTtCkR8wXevcSEFGNGH8eFg=;
        b=GwirUSM3DG6x7iNExXnB9DnJsF3MA4VePWWadw8WrtfAZVrCss9vccoIyboHY3bL2x
         V23P3DYQ/SM8BwItXJijJEvwxuAXcsaSOpLobvQcgzqXtcUwATvNg76XxC9N+hdwNy7B
         w9yXSdGIIcL8AB47Wo/j+CLPYmC502Fn1j3FCFnP1sxl8Qol9JfNSRjbfsLO335L36Kl
         Ejp70jhUHSe8jwpyN+5zFEDmC8DxznLchb/Ko3KdCHvTyxwSDwkdLmiDEOld0eVLv+a4
         EcSAPxvxWYm1+9qwoHFmQpMLbpcPdmPt/x8d0NsS29+/v7FRIsr7y05gmrhBfaxnkiP4
         T4XA==
X-Gm-Message-State: APjAAAUj/2VcD5PiWHlT2ZNZfZZ+jic6Uq5rRj3oQdIwr8Tx1Lx35WHJ
        BcLyFp1sYeVQiK9Qx5m6So4NopRe1VI7POMFl8I=
X-Google-Smtp-Source: APXvYqzC/ovfXYAjwFGHEXXylM+gUQp5VtDq+gNdeaeQlJNNlaDZGSRG3jXD5zFwr6VwOqrNBsW2PjwrxDFzjwwyges=
X-Received: by 2002:a05:6214:923:: with SMTP id dk3mr77264231qvb.96.1578330987212;
 Mon, 06 Jan 2020 09:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
 <20191223094902.12704-6-guoqing.jiang@cloud.ionos.com> <CAPhsuW6kbPvOkVUGQBG+txJmiOWjRbhvK9BLoBckqraemy0bfQ@mail.gmail.com>
 <0dacd146-2bde-5999-08ce-d41fdf73510b@cloud.ionos.com>
In-Reply-To: <0dacd146-2bde-5999-08ce-d41fdf73510b@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 6 Jan 2020 09:16:16 -0800
Message-ID: <CAPhsuW5MSti1LT5ha4=2pMFiEkNFisX0ke5htAVXybo4dAuC5w@mail.gmail.com>
Subject: Re: [PATCH V3 05/10] md: reorgnize mddev_create/destroy_serial_pool
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 6, 2020 at 1:42 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 1/3/20 11:58 PM, Song Liu wrote:
> > On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
> >> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >>
> >> So far, IO serialization is used for two scenarios:
> >>
> >> 1. raid1 which enables write-behind mode, and there is rdev in the array
> >> which is multi-queue device and flaged with writemostly.
> >> 2. IO serialization is enabled or disabled by change serialize_policy.
> >>
> >> So introduce rdev_need_serial to check the first scenario. And for 1, IO
> >> serialization is enabled automatically while 2 is controlled manually.
> >>
> >> And it is possible that both scenarios are true, so for create serial pool,
> >> rdev/rdevs_init_serial should be separate from check if the pool existed or
> >> not. Then for destroy pool, we need to check if the pool is needed by other
> >> rdevs due to the first scenario.
> >>
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >> ---
> >>   drivers/md/md.c | 71 +++++++++++++++++++++++++++++--------------------
> >>   1 file changed, 42 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 796cf70e1c9f..788559f42d43 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -147,28 +147,40 @@ static void rdevs_init_serial(struct mddev *mddev)
> >>   }
> >>
> >>   /*
> >> - * Create serial_info_pool for raid1 under conditions:
> >> - * 1. rdev is the first multi-queue device flaged with writemostly,
> >> - *    also write-behind mode is enabled.
> >> - * 2. rdev is NULL, means want to enable serialization for all rdevs.
> >> + * rdev needs to enable serial stuffs if it meets the conditions:
> >> + * 1. it is multi-queue device flaged with writemostly.
> >> + * 2. the write-behind mode is enabled.
> >> + */
> >> +static int rdev_need_serial(struct md_rdev *rdev)
> >> +{
> >> +       return (rdev && rdev->mddev->bitmap_info.max_write_behind > 0 &&
> > I guess there is not need to check rdev here?
>
> No, the rdev could be passed from mddev_create_serial_pool, and
> caller could set it to NULL, pls see patch 0003.

I see. Thanks for the clarification.

Song
