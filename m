Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6DA1E63F6
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391201AbgE1O26 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 10:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391089AbgE1O24 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 10:28:56 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD577208DB
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590676136;
        bh=h/H97WbfRYlMB2gO6hhzDqDpdzn2XQaAjUBta/g3Mg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lcmqESSzhpaSlgTCsPbySEk7OA47B5Woikm8SB/n/NXN2n9WGrzOd19OLv5ijQ/2q
         r1tXp62wL14kCwN0jVBCQi7+27vgiDlnEW6q0GWmpPWj6UR/IwKp3cwrE8S3zyDB1j
         g2pJEvn5zliGjReTl29ze7aMQV4h/jQGnG2j6msY=
Received: by mail-lj1-f176.google.com with SMTP id m18so33613957ljo.5
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 07:28:55 -0700 (PDT)
X-Gm-Message-State: AOAM531k3sYUuANeI2PtJPyLdpcxt9LrccwLwXqx9f+/EaarUVaqrRWM
        ZJXzjbFWvdqWzKDyIyaqoiHwlilJV0sc8RBpJnE=
X-Google-Smtp-Source: ABdhPJyAWg9/ewUzuKNsME5FZ0f3wxtfcwXZUyGR/7JWwcWuammYcLLylEgxdXYMjiXKePLD74KGeR0KMULhwqaFi6I=
X-Received: by 2002:a05:651c:1130:: with SMTP id e16mr1720974ljo.10.1590676133970;
 Thu, 28 May 2020 07:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200527131933.34400-1-yuyufen@huawei.com> <CAPhsuW7hVgM7yiaBg0Pkaci4NStEdyduCp1+yMf9aguKfm4jKQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7hVgM7yiaBg0Pkaci4NStEdyduCp1+yMf9aguKfm4jKQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 May 2020 07:28:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7DOdPTWX5MNRJULvojFrCQF9_zNH+_ZwkQs4Qug9CpdQ@mail.gmail.com>
Message-ID: <CAPhsuW7DOdPTWX5MNRJULvojFrCQF9_zNH+_ZwkQs4Qug9CpdQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable value
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, Xiao Ni <xni@redhat.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 28, 2020 at 7:10 AM Song Liu <song@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 6:20 AM Yufen Yu <yuyufen@huawei.com> wrote:
> >
> > Hi, all
> >
> >  For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5 will
> >  issus echo bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64. However,
> >  filesystem usually issue bio in the unit of 4KB. Then, RAID5 will waste resource
> >  of disk bandwidth.
> >
>
> Thanks for the patch set.
>
> Since this is a big change, I am planning to process this set after
> upcoming merge window.
> Please let me know if you need it urgently.

I haven't thought about this in detail yet: how about compatibility?
Say we create an
array with STRIPE_SIZE of 4kB, does it work well after we upgrade kernel to have
STRIPE_SIZE of 8kB?

Thanks,
Song
