Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20B2068BB
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jun 2020 01:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgFWX7L (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 19:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387518AbgFWX7K (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jun 2020 19:59:10 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6C62098B
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 23:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592956749;
        bh=ZqZGU87wE57WFVzdPoidgvgT78LIFkGKPSLQs9zhrok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zmix5afMLJLn1yu56NYMbaGoZlafO8hrkzAtTx23x+v5b345ttmrGr14t+43BeNvC
         JQPjDuFu0w8jbK5dHBAnxlj6gV2/f7k6ogPfSi0z+YLb5AbromdXjQEqcm7HPX/nt3
         iLhZHJgMw7XtyarmqqRmACMw+lgqT62zNdqGaBfs=
Received: by mail-lj1-f174.google.com with SMTP id s1so549727ljo.0
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 16:59:09 -0700 (PDT)
X-Gm-Message-State: AOAM531mwTbcN7i9wnOvMdzx6qh8rTBUMc25x4IOpzW7rLRAcdt07/vR
        +iSEGyEFcBFFnwKb5MGLWEZTfiNiGZi4NfnpvQY=
X-Google-Smtp-Source: ABdhPJy635zmqlkIIpnqs8chg7cHSc6+bhaz7IrYrFhoXMySodi8Uncb4oVfh7b0f994npCmmksfaKxbaGBawgwSjeo=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr12713372ljk.273.1592956747808;
 Tue, 23 Jun 2020 16:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 Jun 2020 16:58:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70kML70Xi3MhubCGBWnLDg0L7sPKwKe9HZHsQHwtzEEQ@mail.gmail.com>
Message-ID: <CAPhsuW70kML70Xi3MhubCGBWnLDg0L7sPKwKe9HZHsQHwtzEEQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] raid5: call clear_batch_ready before set STRIPE_ACTIVE
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 16, 2020 at 2:25 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> We tried to only put the head sh of batch list to handle_list, then the
> handle_stripe doesn't handle other members in the batch list. However,
> we still got the calltrace in break_stripe_batch_list.
>
> [593764.644269] stripe state: 2003
> kernel: [593764.644299] ------------[ cut here ]------------
> kernel: [593764.644308] WARNING: CPU: 12 PID: 856 at drivers/md/raid5.c:4625 break_stripe_batch_list+0x203/0x240 [raid456]
> [...]
> kernel: [593764.644363] Call Trace:
> kernel: [593764.644370]  handle_stripe+0x907/0x20c0 [raid456]
> kernel: [593764.644376]  ? __wake_up_common_lock+0x89/0xc0
> kernel: [593764.644379]  handle_active_stripes.isra.57+0x35f/0x570 [raid456]
> kernel: [593764.644382]  ? raid5_wakeup_stripe_thread+0x96/0x1f0 [raid456]
> kernel: [593764.644385]  raid5d+0x480/0x6a0 [raid456]
> kernel: [593764.644390]  ? md_thread+0x11f/0x160
> kernel: [593764.644392]  md_thread+0x11f/0x160
> kernel: [593764.644394]  ? wait_woken+0x80/0x80
> kernel: [593764.644396]  kthread+0xfc/0x130
> kernel: [593764.644398]  ? find_pers+0x70/0x70
> kernel: [593764.644399]  ? kthread_create_on_node+0x70/0x70
> kernel: [593764.644401]  ret_from_fork+0x1f/0x30
>
> As we can see, the stripe was set with STRIPE_ACTIVE and STRIPE_HANDLE,
> and only handle_stripe could set those flags then return. And since the
> stipe was already in the batch list, we need to return earlier before
> set the two flags.
>
> And after dig a little about git history especially commit 3664847d95e6
> ("md/raid5: fix a race condition in stripe batch"), it seems the batched
> stipe still could be handled by handle_stipe, then handle_stipe needs to
> return earlier if clear_batch_ready to return true.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> Another alternative would be just not warn if STRIPE_ACTIVE is valid for
> the batched list.
>
> What do you think?
>

This patch looks good to me (haven't tested yet). Let's try with this one.

Thanks,
Song
