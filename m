Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3E1EB60E
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jun 2020 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgFBG7c (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jun 2020 02:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBG7c (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jun 2020 02:59:32 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B3D20738
        for <linux-raid@vger.kernel.org>; Tue,  2 Jun 2020 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591081171;
        bh=G1T3DTsAP5DmYi6qgwbvt0lmODS32Uqh/fyGStZaJnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TitAoY7IbMZnbxaRfkYQzq5SBv+WjcqSYUeDM1vE7xs2805zGwv0s0i27hzNMkVo2
         kGc+4yo3l0PopCWCze24sh2a3AAKzF0ijMEdbAAZH81iR/iTg+AIecL+fOgk6ZWFJY
         ShutxZXWYK1nxWy+6v+3ElRVqYLkhJY+dsldoBiw=
Received: by mail-lf1-f47.google.com with SMTP id u16so5484960lfl.8
        for <linux-raid@vger.kernel.org>; Mon, 01 Jun 2020 23:59:30 -0700 (PDT)
X-Gm-Message-State: AOAM530h12dAQiA7OuZy+vtllcoVn62aPu6Vv6ssbaODqnM1ai6witdZ
        /2X9H2CCIhOqEvYjWtzdMmiiO5n0R2LUwfOa/2w=
X-Google-Smtp-Source: ABdhPJyJ+biU/aGvdA+2OWa+KZieg41Ox+hCW7dIpQm3V6iLO5ArsefGRXFdGvQOO+Gbe5HHqYS6tfCC6I3nQiFJtUo=
X-Received: by 2002:a05:6512:3329:: with SMTP id l9mr12786496lfe.138.1591081169085;
 Mon, 01 Jun 2020 23:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200527131933.34400-1-yuyufen@huawei.com> <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
 <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com> <71f662d7-9aee-a130-c41d-67a691514ef6@cloud.ionos.com>
 <555121b6-fe76-4827-7b8f-7a22ba04ed82@huawei.com> <9acfb512-88ee-b4b0-88d4-94841e72d31a@cloud.ionos.com>
In-Reply-To: <9acfb512-88ee-b4b0-88d4-94841e72d31a@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Jun 2020 23:59:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4UMDKhpGL71R6FY1-Q_u6On68ku4C=xp0UzSaEaCNGkg@mail.gmail.com>
Message-ID: <CAPhsuW4UMDKhpGL71R6FY1-Q_u6On68ku4C=xp0UzSaEaCNGkg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable value
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Yufen Yu <yuyufen@huawei.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Coly Li <colyli@suse.de>,
        Xiao Ni <xni@redhat.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 1, 2020 at 7:02 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> On 5/30/20 4:15 AM, Yufen Yu wrote:
> >
> >
> > On 2020/5/29 20:22, Guoqing Jiang wrote:
> >> On 5/29/20 1:49 PM, Yufen Yu wrote:
> >>>> The 4k rand write performance drops from 100MB/S to 15MB/S?! How
> >>>> about other
> >>>> io sizes? Say 16k, 64K and 256K etc, it would be more convincing if
> >>>> 64KB stripe
> >>>> has better performance than 4KB stripe overall.
> >>>>
> >>>
> >>> Maybe I have not explain clearly. Here, the fio test result shows
> >>> that 4KB
> >>> STRIPE_SIZE is not always have better performance. If applications
> >>> request
> >>> IO size mostly are bigger than 4KB, likely 1MB in test, set
> >>> STRIPE_SIZE with
> >>> a bigger value can get better performance.
> >>>
> >>> So, we try to provide a configurable STRIPE_SIZE, rather than fix
> >>> STRIPE_SIZE as 4096.
> >>
> >> Which means if you set stripe size to 64KB then you should guarantee
> >> the io size should
> >> always bigger then 1MB, right? Given that, I don't think it makes
> >> lots of sense.
> >>
> >
> > No, I think you misunderstood. This patchset just want to optimize
> > RAID5 performance
> > for systems whose PAGE_SIZE is bigger than 4KB, likely 64KB on ARM64.
> > Without this
> > patchset, STRIPE_SIZE is equal to 64KB, means each IO size issued to
> > array disk at
> > least 64KB each time, Right? But filesystems usually issue bio in the
> > unit of 4KB,
> > means sometimes required 4KB but read or write 64KB on disk actually.
> > That would
> > waste resources.
>
> Yes,, it is hard for me to understand your way is better than just make
> stripe size equals to
> 4KB.
>
> >
> > After this patchset, we set STRIPE_SIZE as default 4KB. For systems
> > like X86, which
> > just support 4KB PAGE_SIZE, it will not have any effect. But for 64KB
> > arm64 system,
> > it **normally** can get better performance on filesystems base on
> > raid5, like dbench test.
> >
> > fio test just want to say that, we can also configure STRIPE_SIZE with
> > a bigger value
> > than default 4KB on 64KB ARM64 system when applications mostly issue
> > big IO. It can
> > get better performance for reducing IO split in RAID5.
>
> I do think the flexibility is not enough, if someone set stripe size to
> 64KB by any chance,
> people could complain the performance of raid5 really sucks if the io is
> not big. And it is
> not realistic to let people rebuild the module in case the io size is
> changed, so it would be
> more helpful if the stripe size can be changed dynamically without
> recompile code.

Agreed that it is not ideal to recompile the kernel/module to change stripe
size. It is also possible that multiple arrays in one system have different
optimal stripe sizes. I guess it shouldn't be too complicated to make this
configurable per array?

Thanks,
Song
