Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA15D20A9C9
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jun 2020 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgFZAQl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 25 Jun 2020 20:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgFZAQl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 25 Jun 2020 20:16:41 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24107207D8
        for <linux-raid@vger.kernel.org>; Fri, 26 Jun 2020 00:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593130600;
        bh=rjYMIhmVj21D/C7J5xF6fjfaqDS6S++Dh15GFgfr4mI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6t8oN4yaMtY+wn2l6GHLE2rVhgyVvvx+nq4JyRoe9Xy7toIfnYdXudyqNwaLU2R9
         vqh873aHefiDpEl7CG0O2IDjtfPqmGfo49NOtjdb4aW/c2CIDNxeIpaNbNZDWcwO2T
         bBO5pSYOJgVDzf1LLIx8YF08F/DKx1oVYUADD3+A=
Received: by mail-lf1-f41.google.com with SMTP id y18so4181815lfh.11
        for <linux-raid@vger.kernel.org>; Thu, 25 Jun 2020 17:16:40 -0700 (PDT)
X-Gm-Message-State: AOAM533F9twEqQV8I5O9x0pmHYRMCLWLH+iIbGuucDUhOVURf6Jh/K+a
        DBSpzdrEl3DctaozjryEVtO2i8FyfcHCoV9o9LE=
X-Google-Smtp-Source: ABdhPJz/DL8H9VSrsyGU05hQk4+fzhfykDBc046/2hrBetns81tftHZM2CYOxYpD3T2EY9HWdlTkP0oEjv/JZ0buhwQ=
X-Received: by 2002:a19:c8c2:: with SMTP id y185mr323616lff.52.1593130598398;
 Thu, 25 Jun 2020 17:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW70kML70Xi3MhubCGBWnLDg0L7sPKwKe9HZHsQHwtzEEQ@mail.gmail.com> <407fa617-c86e-d63d-65ad-3f3058c5e40f@cloud.ionos.com>
In-Reply-To: <407fa617-c86e-d63d-65ad-3f3058c5e40f@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Jun 2020 17:16:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4J84iZWZkCCk8_8uJpPwmvrd2vvHEk-fLQF_HKGioECg@mail.gmail.com>
Message-ID: <CAPhsuW4J84iZWZkCCk8_8uJpPwmvrd2vvHEk-fLQF_HKGioECg@mail.gmail.com>
Subject: Re: [PATCH 1/3] raid5: call clear_batch_ready before set STRIPE_ACTIVE
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jun 25, 2020 at 2:22 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 6/24/20 1:58 AM, Song Liu wrote:
> > On Tue, Jun 16, 2020 at 2:25 AM Guoqing Jiang
> > <guoqing.jiang@cloud.ionos.com> wrote:
> >> We tried to only put the head sh of batch list to handle_list, then the
> >> handle_stripe doesn't handle other members in the batch list. However,
> >> we still got the calltrace in break_stripe_batch_list.
> >>
> >> [593764.644269] stripe state: 2003
> >> kernel: [593764.644299] ------------[ cut here ]------------
> >> kernel: [593764.644308] WARNING: CPU: 12 PID: 856 at drivers/md/raid5.c:4625 break_stripe_batch_list+0x203/0x240 [raid456]
> >> [...]
> >> kernel: [593764.644363] Call Trace:
> >> kernel: [593764.644370]  handle_stripe+0x907/0x20c0 [raid456]
> >> kernel: [593764.644376]  ? __wake_up_common_lock+0x89/0xc0
> >> kernel: [593764.644379]  handle_active_stripes.isra.57+0x35f/0x570 [raid456]
> >> kernel: [593764.644382]  ? raid5_wakeup_stripe_thread+0x96/0x1f0 [raid456]
> >> kernel: [593764.644385]  raid5d+0x480/0x6a0 [raid456]
> >> kernel: [593764.644390]  ? md_thread+0x11f/0x160
> >> kernel: [593764.644392]  md_thread+0x11f/0x160
> >> kernel: [593764.644394]  ? wait_woken+0x80/0x80
> >> kernel: [593764.644396]  kthread+0xfc/0x130
> >> kernel: [593764.644398]  ? find_pers+0x70/0x70
> >> kernel: [593764.644399]  ? kthread_create_on_node+0x70/0x70
> >> kernel: [593764.644401]  ret_from_fork+0x1f/0x30
> >>
> >> As we can see, the stripe was set with STRIPE_ACTIVE and STRIPE_HANDLE,
> >> and only handle_stripe could set those flags then return. And since the
> >> stipe was already in the batch list, we need to return earlier before
> >> set the two flags.
> >>
> >> And after dig a little about git history especially commit 3664847d95e6
> >> ("md/raid5: fix a race condition in stripe batch"), it seems the batched
> >> stipe still could be handled by handle_stipe, then handle_stipe needs to
> >> return earlier if clear_batch_ready to return true.
> >>
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >> ---
> >> Another alternative would be just not warn if STRIPE_ACTIVE is valid for
> >> the batched list.
> >>
> >> What do you think?
> >>
> > This patch looks good to me (haven't tested yet). Let's try with this one.
>
> Ok, pls let me know if there is issue during test.
>
> And do you want a new patch to reflect which I clarified for the line
> number and kernel version?

That's not necessary. If needed, I will make some change when I apply the patch.

Thanks,
Song
