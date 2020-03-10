Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499B1180A1C
	for <lists+linux-raid@lfdr.de>; Tue, 10 Mar 2020 22:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCJVOr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Mar 2020 17:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJVOr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Mar 2020 17:14:47 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97155222C4
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583874886;
        bh=CBfxQT2SOy1Gu9P193rSGFj1GTDAfA2l3h0Q9YqfUbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lva1p8+6YP/wtvbVIjYQoxjkUlAWAnYamw051Xdz4aN1yNBXeS+lHWupr2tzkqwfz
         I+nNh2y1WM3hnJaNNPPFPgy+uLbCySEuXYb/PNB3wK8BS2+SduK9hSWyE0DqgCgs4l
         8Or0qxzXTED55fDRMpjCAQ7NakX7M3DSEGDiJ1KY=
Received: by mail-lf1-f47.google.com with SMTP id s1so12183869lfd.3
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 14:14:46 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1yhzDAo2lRE6YZsTgiiI6KirA2zUO8HRIQp005o0RYYcB4Kmwj
        4914VXJFpx3czpNFF9K8R0hdol4JFTcj0PAIJ/k=
X-Google-Smtp-Source: ADFU+vs5rLxLsjDAuzoudyjw4ppn0CZpfRYozb77wa6mwrwXHjt4ijubzGV3leL4CwqwR18edBpuaz1gYoYJn5qSkJ0=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr37012lfb.69.1583874884782;
 Tue, 10 Mar 2020 14:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200211101004.2993-1-guoqing.jiang@gmx.us> <3be8072d-cecc-d61c-6509-5094b1b24191@cloud.ionos.com>
In-Reply-To: <3be8072d-cecc-d61c-6509-5094b1b24191@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Mar 2020 14:14:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5r8ud=Ffnr4hiuwgU5VKZOpNjP_NWhwnFtkYmV8MqN9g@mail.gmail.com>
Message-ID: <CAPhsuW5r8ud=Ffnr4hiuwgU5VKZOpNjP_NWhwnFtkYmV8MqN9g@mail.gmail.com>
Subject: Re: [PATCH] md: check arrays is suspended in mddev_detach before call
 quiesce operations
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Mar 7, 2020 at 8:56 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Ping ...
>
> On 2/11/20 11:10 AM, Guoqing Jiang wrote:
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> > Don't call quiesce(1) and quiesce(0) if array is already suspended,
> > otherwise in level_store, the array is writable after mddev_detach
> > in below part though the intention is to make array writable after
> > resume.
> >
> >       mddev_suspend(mddev);
> >       mddev_detach(mddev);
> >       ...
> >       mddev_resume(mddev);
> >
> > And it also causes calltrace as follows in [1].
> >
> > [48005.653834] WARNING: CPU: 1 PID: 45380 at kernel/kthread.c:510 kthread_=
> > park+0x77/0x90
> > [...]
> > [48005.653976] CPU: 1 PID: 45380 Comm: mdadm Tainted: G           OE     5=
> > .4.10-arch1-1 #1
> > [48005.653979] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M=
> > ./J4105-ITX, BIOS P1.40 08/06/2018
> > [48005.653984] RIP: 0010:kthread_park+0x77/0x90
> > [48005.654015] Call Trace:
> > [48005.654039]  r5l_quiesce+0x3c/0x70 [raid456]
> > [48005.654052]  raid5_quiesce+0x228/0x2e0 [raid456]
> > [48005.654073]  mddev_detach+0x30/0x70 [md_mod]
> > [48005.654090]  level_store+0x202/0x670 [md_mod]
> > [48005.654099]  ? security_capable+0x40/0x60
> > [48005.654114]  md_attr_store+0x7b/0xc0 [md_mod]
> > [48005.654123]  kernfs_fop_write+0xce/0x1b0
> > [48005.654132]  vfs_write+0xb6/0x1a0
> > [48005.654138]  ksys_write+0x67/0xe0
> > [48005.654146]  do_syscall_64+0x4e/0x140
> > [48005.654155]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [48005.654161] RIP: 0033:0x7fa0c8737497
> >
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D206161
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Sorry for the delay. Applied to md-next.

Thanks,
Song
