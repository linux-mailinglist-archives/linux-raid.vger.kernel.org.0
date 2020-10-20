Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2685286EC5
	for <lists+linux-raid@lfdr.de>; Thu,  8 Oct 2020 08:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgJHGgo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 8 Oct 2020 02:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgJHGgn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 8 Oct 2020 02:36:43 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2E02083B
        for <linux-raid@vger.kernel.org>; Thu,  8 Oct 2020 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602139003;
        bh=woHXKYM0n1zlq1NYgEz7wMns5WM2urq6y54xYEYzKsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4Uc4jmS1XFu3NypfFq8l+yWqd0xhfvFBEQaSRh1VuOjsDU8uOX+PpE6bEM2k8+um
         c3M5LsCkjnPaelTWPOT4A1XOliMkvkjeOVSCYNtnLX4mk9hYUyoMTu02t+LiKVJCwh
         wXCB8YGpFG3nGO/Gdqx4K5YbQiYPXXEHZeFOX14M=
Received: by mail-lj1-f181.google.com with SMTP id a15so4531450ljk.2
        for <linux-raid@vger.kernel.org>; Wed, 07 Oct 2020 23:36:43 -0700 (PDT)
X-Gm-Message-State: AOAM533xm2Psvkc4wjGjJdolJIFIvWuGCflBmjRVU8hFdyzVyLfAz2pr
        VaQEKRMIJRVDVpowp7XPWb1FGIZFMdWseRMd7CM=
X-Google-Smtp-Source: ABdhPJxDY624KnrQSl4u2iS9Ri1+n+UKEGKq9a7wBHGjRs+dxayaKOtR6ThMAMcx4SlDIitVy7cf6zpCayJudAyDH0Q=
X-Received: by 2002:a05:651c:104:: with SMTP id a4mr2711140ljb.273.1602139001305;
 Wed, 07 Oct 2020 23:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <1602127149-30561-1-git-send-email-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <1602127149-30561-1-git-send-email-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 7 Oct 2020 23:36:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW60o2ntcgRs16Zors539tTg3ibgF1QxK6kHPRFG95sROg@mail.gmail.com>
Message-ID: <CAPhsuW60o2ntcgRs16Zors539tTg3ibgF1QxK6kHPRFG95sROg@mail.gmail.com>
Subject: Re: [PATCH] md: fix the checking of wrong work queue
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 7, 2020 at 8:20 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> It should check md_rdev_misc_wq instead of md_misc_wq.
>
> Fixes: cc1ffe6 ("md: add new workqueue for delete rdev")
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Applied to md-next.

Thanks,
Song
