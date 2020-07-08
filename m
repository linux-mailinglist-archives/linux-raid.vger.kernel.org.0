Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34092194B4
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jul 2020 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGHXza (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jul 2020 19:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgGHXza (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 Jul 2020 19:55:30 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6AA320659
        for <linux-raid@vger.kernel.org>; Wed,  8 Jul 2020 23:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594252530;
        bh=Y+4Wu6sGJaWkdPn0eDvdvNGyLW7OGwVze5u8gprXxWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q9dLchvW0VOVkBa5xrUdKvgGOfZMvtb+ZNZdEYXqsq8eE/t/sKLxxFuaPQv2ff0jO
         i+Ow6UkEz/NQ2Iougji4KVSuW5Um/DdRH853Q83GYko5LsEJesqQ7buh4zXl/TsG1x
         r8UjOcTBVFngkn+XzqllNulI6tEHnpnzKMcnp6HI=
Received: by mail-lj1-f173.google.com with SMTP id f5so259306ljj.10
        for <linux-raid@vger.kernel.org>; Wed, 08 Jul 2020 16:55:29 -0700 (PDT)
X-Gm-Message-State: AOAM531SOhYBUKnYGOZpOAsp955w5UcaZWBpZZbhsE/vzqk5bwIUheTY
        9MGTTbUVt2I9YKGmSf7Gwm32qOJz2FXsX4E0YMQ=
X-Google-Smtp-Source: ABdhPJxBv3Y8JhOCsb9spcg7NDgy0+uTHpTgMS7xst20Vb7SiYMCQb0RXqCKWkZCqaJI8VW0rGZzLDCw1msg5SVBuSU=
X-Received: by 2002:a2e:7f06:: with SMTP id a6mr26306958ljd.446.1594252528081;
 Wed, 08 Jul 2020 16:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200702120628.777303-1-yuyufen@huawei.com> <CAPhsuW7PgJV-bjaa8v=Zrhd0MqPmjew1dF-Qi0FP6i-809YAQg@mail.gmail.com>
 <0dd1ebed-2802-2bef-48f0-87bbdd2ee8e5@huawei.com>
In-Reply-To: <0dd1ebed-2802-2bef-48f0-87bbdd2ee8e5@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jul 2020 16:55:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7m7qYGe3g2XyZNWZch4Wy0y2URNeUprKAm4si+nyBB8g@mail.gmail.com>
Message-ID: <CAPhsuW7m7qYGe3g2XyZNWZch4Wy0y2URNeUprKAm4si+nyBB8g@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] md/raid5: set STRIPE_SIZE as a configurable value
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 8, 2020 at 6:15 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
>
>
> On 2020/7/3 7:00, Song Liu wrote:
> > On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
> >>
> >> Hi, all
> >>
> >>   For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5
> >>   will issue each bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64.
> >>   However, filesystem usually issue bio in the unit of 4KB. Then, RAID5 may
> >>   waste resource of disk bandwidth.
> >>
> >>   To solve the problem, this patchset try to set stripe_size as a configuare
> >>   value. The default value is 4096. We will add a new sysfs entry and set it
> >>   by writing a new value, likely:
> >>
> >>          echo 16384 > /sys/block/md1/md/stripe_size
> >
> > Higher level question: do we need to support page size that is NOT 4kB
> > times power
> > of 2? Meaning, do we need to support 12kB, 20kB, 24kB, etc. If we only
> > supports, 4kB,
> > 8kB, 16kB, 32kB, etc. some of the logic can be simpler.
>
> Yeah, I think we just support 4kb, 8kb, 16kb, 32kb... is enough.
> But Sorry that I don't know what logic can be simpler in current implementation.
> I mean it also need to allocate page, and record page offset.

I was thinking about replacing multiplication/division with bit
operations (shift left/right).
But I am not very sure how much that matters in modern ARM CPUs. Would you mind
running some benchmarks with this?

Thanks,
Song
