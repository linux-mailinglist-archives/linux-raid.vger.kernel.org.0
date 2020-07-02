Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1F212C69
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGBShC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 14:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGBShC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 14:37:02 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720F520772;
        Thu,  2 Jul 2020 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593715021;
        bh=oXyP873JXSxXUDLaJ2PczCr29+H24VrrrxyBBBQsazU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IdyL+RqLvFEIYSADu+2aioFigAqG8eb+ZRswbNwAzkoMmi7aROVNoTOs3uVvEqHAj
         5f++O5rpEwaW/WUOzKGFVoyut1KnBRzOq7whpDSHQI7RcHzNwvoVwCmx12XgWUSOBM
         +EI+S1aoIRkFj9CZZTK9iRGDExutbMFJad0tf69Q=
Received: by mail-lf1-f48.google.com with SMTP id g139so16817153lfd.10;
        Thu, 02 Jul 2020 11:37:01 -0700 (PDT)
X-Gm-Message-State: AOAM532TV4zyAQuXqF671KnQgWuVmPM59xwNTqiBtcvo+QfQxEqp453d
        bKpVNqVdFtJfN/ID/rF8wQ5gC2RNchOrw1CFgs8=
X-Google-Smtp-Source: ABdhPJyBPwEIovEMsTlCazUNeVe6jY+ZSMAH2xzuQkuDqgItN4RI0YCu9BSoOZF2333mhp/DChl0UCAxLaaEyLyQoek=
X-Received: by 2002:a19:701:: with SMTP id 1mr18954532lfh.138.1593715019783;
 Thu, 02 Jul 2020 11:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200702113502.37408-1-colin.king@canonical.com> <CAHD1Q_yy2gbBkd31oOJiJk2TU3K4wTV3gVtjLiQo1FW+e=5ivg@mail.gmail.com>
In-Reply-To: <CAHD1Q_yy2gbBkd31oOJiJk2TU3K4wTV3gVtjLiQo1FW+e=5ivg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 11:36:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4r5vLo2Py6Fwd6Oe4Pzr6hfjvXHuEwOc7-X86zhnsi1Q@mail.gmail.com>
Message-ID: <CAPhsuW4r5vLo2Py6Fwd6Oe4Pzr6hfjvXHuEwOc7-X86zhnsi1Q@mail.gmail.com>
Subject: Re: [PATCH] md: raid0/linear: fix dereference before null check on
 pointer mddev
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     Colin King <colin.king@canonical.com>, NeilBrown <neilb@suse.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jul 2, 2020 at 7:41 AM Guilherme Piccoli <gpiccoli@canonical.com> wrote:
>
> Great catch Colin, thanks!
> Feel free to add my:
>
> Reviewed-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

Thanks Colin and Guilherme! Applied to md-next.

>
>
> P.S.  Not sure if it's only me, but the diff is soo much easier to
> read when git is set to use patience diff algorithm:
> https://termbin.com/f8ig

Agreed. Patience is cleaner.
