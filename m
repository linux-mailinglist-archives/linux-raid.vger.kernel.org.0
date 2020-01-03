Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649EB12FEFA
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 23:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgACW64 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 17:58:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41220 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgACW64 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 17:58:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so35017551qke.8
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 14:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCrbGreXOc9mYIXB61E/vlfMBHIPGi/kcKBsb+tm+nc=;
        b=LFvIANP8bZ3JqjeLw+RqNiH5LAu2IYJ4Y/TbvcSD7eFrtGJv6Ss7EGiCodStNOulds
         YrOk1GmkHcbaeFgoX2HjdKTuvPaLNqmxvhG1mrxjg4vPqu/czhB56lQDXO+ASlVhnk9v
         V4A6pshre5U5bRTis4heopHB9LCte6uv0St3LEPdCXXZC1tOuEJT/MNe0MdzR35i2TO5
         p2lixYpRrGpkguDqAsnF1MSp+VQeUa4JmlKnp2x4WWc15Xn8f2960NCQicg/hM9YFfXW
         BMYJz6Rbeyrh8W2I8Uoj7iIo3nyHMUFOwgBsWUQorbcsWaQNMTW7BFAske9yUSYk+LjB
         EMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCrbGreXOc9mYIXB61E/vlfMBHIPGi/kcKBsb+tm+nc=;
        b=Lg+r1vTXg7/WUlP2g9cxesJ0TvL0cv8YMm16XXgk1MVOar+8MPkxoQF8vVR53ATP7T
         IjHTggsx3fsqJk7mJCmXqUmk3Hq8swVy3+ZV+x8aa+/OEpcllTlcrL5XEYwnhNl2hc47
         wTrKzTt+lsljI0Ctof7bFUmcMFwZaM1SMtYNq6Mhq8pqWPWuQJJBFq4rnijqAoa1vL4V
         2ERRVXjr4OMbIzFrBcfxJgFhMnP47hNcNLqdYEbyMeBMsUAg3Yrwwhq5TcAZAeFhnGP0
         sDQOYZcoa386IeZrN0KZ0xQiujqPUNy0KukTsG85A19Kew6nlJDN/pgeQ5CtvIR3D7bA
         TkPw==
X-Gm-Message-State: APjAAAVB+3zf6s1xa2MnY6Z3xUUhKiJObfa8/hVPt2UWHEFzzROnLY9j
        OkfuBxtuJExVi6xGIqqnJ289D2sMXDxOn7nfQZ4=
X-Google-Smtp-Source: APXvYqzQA2jjL/VNazLyOVQ5lwRaoNM0IGsPXpo2kebtcVVSafX7glhcer6uZuhSB+mD9sonplUh7X/wVyhHhr7e7tg=
X-Received: by 2002:ae9:e103:: with SMTP id g3mr67705856qkm.353.1578092335212;
 Fri, 03 Jan 2020 14:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com> <20191223094902.12704-6-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191223094902.12704-6-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 14:58:44 -0800
Message-ID: <CAPhsuW6kbPvOkVUGQBG+txJmiOWjRbhvK9BLoBckqraemy0bfQ@mail.gmail.com>
Subject: Re: [PATCH V3 05/10] md: reorgnize mddev_create/destroy_serial_pool
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> So far, IO serialization is used for two scenarios:
>
> 1. raid1 which enables write-behind mode, and there is rdev in the array
> which is multi-queue device and flaged with writemostly.
> 2. IO serialization is enabled or disabled by change serialize_policy.
>
> So introduce rdev_need_serial to check the first scenario. And for 1, IO
> serialization is enabled automatically while 2 is controlled manually.
>
> And it is possible that both scenarios are true, so for create serial pool,
> rdev/rdevs_init_serial should be separate from check if the pool existed or
> not. Then for destroy pool, we need to check if the pool is needed by other
> rdevs due to the first scenario.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/md/md.c | 71 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 796cf70e1c9f..788559f42d43 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -147,28 +147,40 @@ static void rdevs_init_serial(struct mddev *mddev)
>  }
>
>  /*
> - * Create serial_info_pool for raid1 under conditions:
> - * 1. rdev is the first multi-queue device flaged with writemostly,
> - *    also write-behind mode is enabled.
> - * 2. rdev is NULL, means want to enable serialization for all rdevs.
> + * rdev needs to enable serial stuffs if it meets the conditions:
> + * 1. it is multi-queue device flaged with writemostly.
> + * 2. the write-behind mode is enabled.
> + */
> +static int rdev_need_serial(struct md_rdev *rdev)
> +{
> +       return (rdev && rdev->mddev->bitmap_info.max_write_behind > 0 &&
I guess there is not need to check rdev here?

Thanks,
Song
