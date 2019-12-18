Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73BD125198
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLRTNc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Dec 2019 14:13:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43891 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRTNc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 18 Dec 2019 14:13:32 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so148101qtj.10
        for <linux-raid@vger.kernel.org>; Wed, 18 Dec 2019 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf5fMZpvZD3+jvSDL0mbXHfxhzknlYf3vnpJXGG9uhE=;
        b=HoigtLHb6QJ8fE/nr5d1d3AR4P5Nm9RhE8qcOYpqK66zvkrKsO/tUUvcMoNYMvGzow
         u45ZipSbnBhp620YnRt/Q1LYoKCBwL/yNyOYowi3JtGe8ZMtJJ8UNZTX2p9BwXge2XtW
         iGhw/Koi7avGO/sRSEYaykPw5urn9lCdi0tYi9CGVPFzaB/AAMwGZSrlBCzUV6fWT0JZ
         lQQoJcq1ZrzpGZcAj82xpJupxZe5UufnTWrNJzTNlsUkLUHmv0mm2XBqNLtQ4AnbsyeD
         H395AsRBvydYjx/8s2YOM44CCyRUtxAA1ZcYQDn5sahEovVGuZq96bXFJJ+mTiKl9cg/
         zwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf5fMZpvZD3+jvSDL0mbXHfxhzknlYf3vnpJXGG9uhE=;
        b=U7D3uk8wfwGWRgJPzQ7W77zYWyY2w4ZQL+aHa70E917bjaCGPaM6d9xBN+3Fde1PSa
         3ce8EzBYWoCiDGAKePUpnI0QkAwt0568ns1QNqidYswTWoUAIsYemaVFYRSXd20zJmo+
         IZkgJoh39SSusSSkLLfHwAEf0WVNopjL8THj5PxNK5k6mrj8+68Y7nbk8ThLqKM9rFbl
         pvKVvQZs2cnuKR3NHAa57vzMxaj2d5MDFGmpTlnKWV6ikDXztqQIDndylarDZZ5FlWV2
         cbUMsSQSVIoJI+y1WQa2n+Mcny1Aw8lfPYv2f3zcwK+9rTSDXZvS6B7kyuPFs7PP4jsk
         l5EA==
X-Gm-Message-State: APjAAAWYA430D+7bofDRxglbhcNvlTxRXQNnEtr8e0XtjbbsU9SoqApG
        X6U8+ylEM8K8oaaU/VDJgA6ZGeddfzpDKIeaEkg=
X-Google-Smtp-Source: APXvYqzAAUYoaN77ph5So52l2Lzuxow7jHrSOWBaXlqXZOl/hFu3+2tJzbnW5ZfbJo+nAdqbQkHqtjsZD96QAX4C4rI=
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr3667637qtv.308.1576696411818;
 Wed, 18 Dec 2019 11:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com> <20191121103728.18919-2-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191121103728.18919-2-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 18 Dec 2019 11:13:20 -0800
Message-ID: <CAPhsuW5gxOPSRGtcquZZNLdq49OgaoKr5WGXvP9dZvALtiSeSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] md: rename wb stuffs
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Previously, wb_info_pool and wb_list stuffs are introduced
> to address potential data inconsistence issue for write
> behind device.
>
> Now rename them to serial related name, since the same
> mechanism will be used to address reorder overlap write
> issue for raid1.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
[...]
>                 rdev_for_each(rdev, mddev) {
>                         if (test_bit(WriteMostly, &rdev->flags) &&
> -                           rdev_init_wb(rdev))
> +                           rdev_init_serial(rdev))
>                                 creat_pool = true;

As we are renaming things, let's also change creat_pool => create_pool.

Thanks,
Song
