Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9134DDE5
	for <lists+linux-raid@lfdr.de>; Fri, 21 Jun 2019 01:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFTXv1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Jun 2019 19:51:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38952 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTXv1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 20 Jun 2019 19:51:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so5084212qta.6
        for <linux-raid@vger.kernel.org>; Thu, 20 Jun 2019 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jix9Vz0RF0if46Y4VGA7qxp0FXzXowTDG4tcUsiXNSQ=;
        b=hRw19Nq8qHYBK4Mxw5jU/LfgeWWN4j2yYQLp5FZuIKquL5Q4hRV5FSPa4+WoScSiRW
         WF0yrxUd+nmn3cd5Uyo6+xX4qvuKmnbYwhvPb14U7T2nMUVRoDr4I1ly7r2uwmol9inI
         /pT5EjPtSXmyvYLI/qp2MUN4TVq55tSq02QMDs3tbUfe8pIM6NrZivBjKrU7WCqdkoKw
         HTtxej7LQoKydwf149DluwvRKsrvzpvwUz4uxgmlAd4jlOFBAjdJ/YsHKs+oNv9P/nmh
         mihnWnIIGVkckrm5IKrQ8t1n4kwzik8kMci8c3foCQgh7tx+NK0p1iz+wF7j19wooUv6
         f/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jix9Vz0RF0if46Y4VGA7qxp0FXzXowTDG4tcUsiXNSQ=;
        b=JZ3nOXNvlYmojkf3EGAwFC4oZ4QbQyGKdqShfXhViQ4tyRZVtWMtNiUFFGnxmSzHoc
         bRSErYzZqy5GsdEpN9oFg47e84gCxvCVZd9utvGdpDyKqKy59s/2ey0kJ6N73/BMPYI6
         yLZ8AAHgCcGfwC5P2ceWkG68V54yEUjsOiN4IrGPEH2t/OTOZXyzXmhswTra6PUdRbvZ
         go/Ouca17RMYVncedK2BhUv1bXmWjMSNAZAyCwrn/ldcqIaBQ64G8WbQSP8rB0t/R//B
         UbW7HFEM4+opnE1GZ91dN17sg+l6ars6yNql2kmuR0ZNLZrHFHaVfBGmdWreTFuToNfO
         mMIA==
X-Gm-Message-State: APjAAAWne5Ihqr5Si4nngCLcNhu2Z7lenYZbDAJTlMNpedo8omxU6lBm
        zMJwqFWha2ZYQS9AoT4ivx3RuYDMf1biXe63H53wMvdr
X-Google-Smtp-Source: APXvYqzx57xek256y18OfOwHdqf1jSTVn5jmqFnxPA90yffvpH3VWxDFUUqEsvgmMmOEFecppezmFqUkQSN27D6NOXM=
X-Received: by 2002:a0c:9807:: with SMTP id c7mr11688645qvd.26.1561074686743;
 Thu, 20 Jun 2019 16:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-1-gqjiang@suse.com>
In-Reply-To: <20190614091039.32461-1-gqjiang@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 20 Jun 2019 16:51:15 -0700
Message-ID: <CAPhsuW5AmE8cGs=r1Fx-5qXcW_QQOEQiyH3NGoOahpzjHhP-PQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix potential data inconsistency issue with write
 behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jun 14, 2019 at 1:51 AM Guoqing Jiang <gqjiang@suse.com> wrote:
>
> Hi,
>
> This patchset tries to avoid potential data inconsistency issue
> which could happen if multi-queue device is flaged as write mostly
> and write behind mode is enabled.
>
> And thanks a lot for Neil's review for the series.
>

Applied to https://github.com/liu-song-6/linux/tree/md-next.

Thanks!
