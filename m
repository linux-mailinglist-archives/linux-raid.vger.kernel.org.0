Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BEF246790
	for <lists+linux-raid@lfdr.de>; Mon, 17 Aug 2020 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHQNoX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 17 Aug 2020 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgHQNoU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 17 Aug 2020 09:44:20 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126FC061342
        for <linux-raid@vger.kernel.org>; Mon, 17 Aug 2020 06:44:19 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id u15so4753150uau.10
        for <linux-raid@vger.kernel.org>; Mon, 17 Aug 2020 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YK1g7CpAj1uxdUMop0TAQ/KlG7NubSk4gl7YMK07x3k=;
        b=ckeoC9vO/EDF3YhPTlzEiluCGyrsP53BCP34FHVrdI8dpxxDV3K+SwS1hVvx0mZcmM
         e2O91NKmU+NTYcN/tz61BiWW9QlDpE/ctnp1RkSV1f3S0tJquoPdWFtFvwbM/qj+ig42
         Zx0Etpm3KzjpWimA7LfYgeTbvIYJ+MqLP2/1WK0GsLq/AJ4Gq3/IYaIVHao2TI3hcZfP
         68I7yu3R0UWmbe6eTH+cBL+DEwLUN/83wu07NWUwmKKz3AZctOS6JJatO5ps/e1MpIEc
         FG4FYDE5qqMgZ9NiMEdTtKRZS7MBhdsf9UCzEXzeLnjCseF8vqop52zofptLynay9JjQ
         6qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK1g7CpAj1uxdUMop0TAQ/KlG7NubSk4gl7YMK07x3k=;
        b=W0eiNGL/GOP+Fgh+yQG3nXfv+3oxgMOc9yLsLHR0pXKGwxQrep6zJ0BHJxK0zIq8n0
         msKyGdOj7LY1bzUYbwllnTOEtowrnmr/F3qlpF5Dqc11VNzEamq1d2U2xh9rpLs3yhNK
         YQEYwZwpw1ouWVKm6Dx2STlvCP/CY5eLqnaGkynPF0YRElC8wEAFqyTNwkIeUEuNUfzl
         SAWlTuVsWDqIQowYisZjEE5ge7RFtJY3K95+gDQBRAyHqyFaVmGKq1lIj07zWtD0s8hQ
         uHfc0Uz9QaO7glKahtNihJF9Wm+JiEDJXZq4Kj3JIlrWUOaH+fxEVZLHSHHprxf7bcP+
         wzdQ==
X-Gm-Message-State: AOAM5306WUrSDA/ffPLKN9v4YQChkgJQetBeWD16Aty0oVBpymfCzZIv
        I7hWEZy0swPBb/aC/6mdvynCeJVKMYHoPMUOHhXFug==
X-Google-Smtp-Source: ABdhPJx2boyWtvrgXSxzxAFNpocIavvkFNhc8FhgjvFzGZM8f5Qera674/ApAjhCKTryvJlmcUOHc2HfleHlukxtHlM=
X-Received: by 2002:a9f:35d0:: with SMTP id u16mr7432899uad.113.1597671858524;
 Mon, 17 Aug 2020 06:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200728163416.556521-1-hch@lst.de> <20200728163416.556521-3-hch@lst.de>
 <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 17 Aug 2020 19:14:04 +0530
Message-ID: <CA+G9fYs4w46bZtgaKTzTLgaqNDcw3vdRaKWuGJ4wN4SSKJqUKA@mail.gmail.com>
Subject: Re: [PATCH 02/23] fs: refactor ksys_umount
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        chrubis <chrubis@suse.cz>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, 6 Aug 2020 at 20:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 28 Jul 2020 at 22:04, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Factor out a path_umount helper that takes a struct path * instead of the
> > actual file name.  This will allow to convert the init and devtmpfs code
> > to properly mount based on a kernel pointer instead of relying on the
> > implicit set_fs(KERNEL_DS) during early init.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/namespace.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 6f8234f74bed90..43834b59eff6c3 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c

<trim>

>
> Regressions on linux next 20200803 tag kernel.
> LTP syscalls test umount03 mount a path for testing and
> umount failed and retired for 50 times and test exit with warning
> and following test cases using that mount path failed.
>
> LTP syscalls tests failed list,
>     * umount03
>     * umount2_01
>     * umount2_02
>     * umount2_03
>     * utime06
>     * copy_file_range01

The reported issue has been fixed in linux next 20200817 tag by
below patch.

fs: fix a struct path leak in path_umount
Make sure we also put the dentry and vfsmnt in the illegal flags and
!may_umount cases.
Fixes: 41525f56e256 ("fs: refactor ksys_umount")

- Naresh
