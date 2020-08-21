Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5A24CD19
	for <lists+linux-raid@lfdr.de>; Fri, 21 Aug 2020 07:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgHUFEx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 21 Aug 2020 01:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHUFEx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 21 Aug 2020 01:04:53 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C903821734
        for <linux-raid@vger.kernel.org>; Fri, 21 Aug 2020 05:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597986293;
        bh=Xz6sHetbP6D61Sca9Yl6mn0mtLhXhxVYrFwEECFfhy0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpKqNJqn4LuM8TOxzlOGmsGRltZcaO/H5EuglNWmSArzWSMkSsIpD5mC7mr+7KJcZ
         I5G32zpvVNaJJZnSxoQm9pI0QIz1i5QdyomNGvaEsBW4oC2c1pFPEcHGQY4HZnEKA2
         M9OA6wgQl4E78CwM1utD5Vz1/vS5VCt2y5sI1adw=
Received: by mail-lj1-f170.google.com with SMTP id w14so490891ljj.4
        for <linux-raid@vger.kernel.org>; Thu, 20 Aug 2020 22:04:52 -0700 (PDT)
X-Gm-Message-State: AOAM532NvJ2cO+igEatOu1HUCcVeO6lOOjk3Pl36mN8nW4o2RXM9NKXc
        +3JDmIGP+AnmTKsGdUCtklnSbaBldrQLCi6pwjU=
X-Google-Smtp-Source: ABdhPJx0yeUaq9TBQYBrRZP5SbhNyykNLwAZ04R/2wGUsof0JwfJldQhakzJkiFXYf2cia776L510Zc28+XFVBkWdyc=
X-Received: by 2002:a2e:b8d6:: with SMTP id s22mr651293ljp.273.1597986291172;
 Thu, 20 Aug 2020 22:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200820132214.3749139-1-yuyufen@huawei.com>
In-Reply-To: <20200820132214.3749139-1-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 20 Aug 2020 22:04:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW473fmPDanrHYwG6NxU3Ai7kd8oo6siKo4A4j1w-pi7rg@mail.gmail.com>
Message-ID: <CAPhsuW473fmPDanrHYwG6NxU3Ai7kd8oo6siKo4A4j1w-pi7rg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Save memory for stripe_head buffer
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Aug 20, 2020 at 6:21 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
[...]
>
>  Patch 8 ~ 10 actually implement shared page between multiple devices of
>  stripe_head. But they only make sense for PAGE_SIZE != 4096, likely, 64KB arm64
>  system. It doesn't make any difference for PAGE_SIZE == 4096 system, likely x86.
>
>  We have run tests of mdadm for raid456 and test raid6test module.
>  Not found obvious errors.

Applied series to md-next.

I noticed there is another case where we allocate page for
sh->dev[i].orig_page in
handle_stripe_dirtying(). This only happens with journal devices.
Please run tests
with journal device.

Thanks,
Song
