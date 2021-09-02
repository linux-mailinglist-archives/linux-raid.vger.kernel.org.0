Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631503FE8A8
	for <lists+linux-raid@lfdr.de>; Thu,  2 Sep 2021 07:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhIBFHv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Sep 2021 01:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhIBFHu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Sep 2021 01:07:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A229460F56
        for <linux-raid@vger.kernel.org>; Thu,  2 Sep 2021 05:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630559212;
        bh=eFmio9ARGDcUXKZxWmCA8ZFZaPweZCsUCTDFs3cUXzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2TlqxC7ETZ29sRfRxxkf3H8MaqX531o7tcoXzS/xpbRpcR3u1KPMIvMgijrf4j1y
         ALeCoayU9DqLu6y1MV9Ov+AoVOeHWL1AmK+LTWAk76L3PlEjLAyPvbVjHHrqWefzoA
         V7eM3SieHjE1WKt2NsJmnZz2ykM6fD0kWX6MX/IRZ4lDRXM5BbrAiDbW2b+6u7H9XT
         LiSHLF2LRzaaXxDOPj6znp4V3ik0d+PKBui3tmr05cuSM2OS0zBdWqDGWhMIAfY67h
         DHe9doNvhpUCh7M/wlozjNqASyjxpUsJYO7JPhJ//+zPhabAYFbkGTB5JXB9Gq2A46
         /0sabBvQHKNqQ==
Received: by mail-lf1-f50.google.com with SMTP id bq28so1484063lfb.7
        for <linux-raid@vger.kernel.org>; Wed, 01 Sep 2021 22:06:52 -0700 (PDT)
X-Gm-Message-State: AOAM530ep2gnq/XdHIVmTlBgXLYeo6i4CHWi1v/M/fKzFj/af3d4YTAK
        XJlGb8W4ldV5BpdHgSAh9GfGuUcdFeEGnm6JJFY=
X-Google-Smtp-Source: ABdhPJzzBBqzmgqFODdSWB9h17CyRbCVsi+kl1uU5ZbuZc/IOV7zTtcdfHpHey09GnZAshUKs8q/mrXn6KmIsmkPcbY=
X-Received: by 2002:a05:6512:169d:: with SMTP id bu29mr1185020lfb.160.1630559211070;
 Wed, 01 Sep 2021 22:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210901113833.1334886-1-hch@lst.de>
In-Reply-To: <20210901113833.1334886-1-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Wed, 1 Sep 2021 22:06:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ju1zBwKYNZeWiYjEK0JRnxC7vorym9z=c_x83twd7wg@mail.gmail.com>
Message-ID: <CAPhsuW7ju1zBwKYNZeWiYjEK0JRnxC7vorym9z=c_x83twd7wg@mail.gmail.com>
Subject: Re: fix a lock order reversal in md_alloc
To:     Christoph Hellwig <hch@lst.de>, Jes.Sorensen@gmail.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Christoph,

On Wed, Sep 1, 2021 at 4:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Song,
>
> the first patch in this series fixed the reported lock order reversal
> in md_alloc.  The rest sort out the error handling in that function,
> starting with the patch from Luis to handle add_disk errors, which
> would otherwise conflict with the first patch.

Thanks for the fixes! I have noticed the issue, but haven't got a good
solution for it. I will test and apply the set (maybe after the labor day
long weekend).

>
> Note that I have had a hard time verifying this all works fine as the
> testsuite in mdadm already keeps failing a lot for me with the baseline
> kernel. Some of thos reproducibly and others randomly.  Is there a
> good document somehow describing what to expect from the mdadm test
> suite?

Unfortunately, mdadm test needs quite some work to be really useful again.
I will work with Jes and other folks to come up with a plan for this.

Thanks again,
Song
