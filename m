Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A198F5AFF
	for <lists+linux-raid@lfdr.de>; Fri,  8 Nov 2019 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfKHWix (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Nov 2019 17:38:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38314 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfKHWiw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 Nov 2019 17:38:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so6740419qkn.5
        for <linux-raid@vger.kernel.org>; Fri, 08 Nov 2019 14:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2nEtuU22napONk9ccXvFMrUlpgoTg2U9ySA/YPCp12I=;
        b=pKPDDHBGPwEyiHwJ4TwihM/Nr/q4GNOH+LwiDNxZ72Fp7ZVZnMBgEWYjJq7LUFh804
         MGtIRaH30gNAvWVHmg2Kp/o457rk+9ooCfqMxMK79R7/r/OLb6jKvElLpvL8/iEDkNJI
         cBM0kZUk08GOsfvS/bcDOQkaeRXTYYew/Ww+R9vaFJAo5Pm0DPjqrgF+35cTdipiCWUm
         7rw5goAz+QHxkCNQlwFwnAn7QQP7AfLlk49m1fu5TJJwdXehCqshbsC8hMvFU/tmz17K
         7YyNeHpv6S77EsRM+1gE9bgHIv0JCDk+Hz+nJ8rIA7S5Bw7FRt9DuVroFWkH4CGlcRGY
         3CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nEtuU22napONk9ccXvFMrUlpgoTg2U9ySA/YPCp12I=;
        b=cz5oKLDVoTqLMOgTilXdN3MYd0Dgyoj2Yg5YZDP7K+PdekucW9/zUFTyaYgFZX5LpH
         IpMMkXyStTQMmvmit1O1lMSR8T8LkrBSh3o7fhHM2uuN1yoQEW9KIf9TgPXE/UU9YgpZ
         /shiMBP7rDJa7cF/pmRXA6IAkNmanVvXVAlV878oQcNNB6IL02v0OgoZuMKhEUO/W7mP
         qYGlA3Cb+UXDQbkFl1LDbBhICeoAIqDasM5wioAVfSnafNlLuzP0Qf+rw6T38bZHpR6C
         7VkRxEOq9qCKxEL1bGKiukd/47RG54Zqq+w5UOlpK701djt5lPDgjkGCJkhgOFMv7xFd
         jz3A==
X-Gm-Message-State: APjAAAU6/Wd76zWwnYFCH4GhKzPlHqfa39Nak8PAi1r49PH9dNcnKOxU
        9FnHC1AtSuwbp2jghPTlWctj8LprC1NeZ2kzi2q2CM4Y
X-Google-Smtp-Source: APXvYqzsBQF73c8jMmHxTfAA4WzkCbI5cMjorNuy2MeAgriK9plZYBnq2bVjY92ruh3EjG5buNDZZHMHLD0B+r/WSnk=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr11626918qkg.168.1573252731885;
 Fri, 08 Nov 2019 14:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-3-guoqing.jiang@cloud.ionos.com> <CAPhsuW7MwTvWzDr6voTS92chTm-Znwy74pjyF1=cpXcj27_A3w@mail.gmail.com>
 <dd801115-92b5-85a4-ae6b-504ed888c2e0@cloud.ionos.com>
In-Reply-To: <dd801115-92b5-85a4-ae6b-504ed888c2e0@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 8 Nov 2019 14:38:40 -0800
Message-ID: <CAPhsuW5wAmD+qOqfZyd=EM4FKcJ48sbAd6jzSCvTp8pJB4jzjQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] md: add is_force parameter for some funcs
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Nov 6, 2019 at 2:04 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:

[...]

> >> -static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
> >> +static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
> >> +                                     bool is_force)
> > I guess mddev_destroy_serial_pool() doesn't need an extra argument. We
> > can just to clear_bit, etc.. no?
>
> Let me explain a little bit, the function are used in below cases:
>
> 1. write-behind mode is enabled and write-mostly device has multi queues,
> the pool should be destroyed if the last device flagged with CollisionCheck
> is removed from array, or the write-mostly flag will be cleared from the
> last
> device.
>
> 2. if we want to enable/disable serialization for normal raid1 in later
> patch,
> which means the pool could be created/destroyed whether bitmap is existed
> or not, and all member device should be flagged with CollisionCheck.
>
> The new argument is introduced to distinguish the two cases.

I understand the difference here. And I agree that we need a new argument
for mddev_create_serial_pool(). The question is, it is possible NOT to add the
extra argument to mddev_destory_serial_pool().

Thanks,
Song
