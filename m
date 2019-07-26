Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A0772B8
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jul 2019 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfGZU0E (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 26 Jul 2019 16:26:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40096 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGZU0D (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 26 Jul 2019 16:26:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so53860524qtn.7
        for <linux-raid@vger.kernel.org>; Fri, 26 Jul 2019 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHUURRnzGnrmLI5y4M5ySmRm+i79H61bknDL487SEsw=;
        b=Ky+oFGHUTw/6mQqaD7C5ZRVcCxNmBXDfJAcdycpejoTYmtMm/dCMSaghHFnu5h3iWs
         F63ppvrLZPEjQD+7NZCli5d+mwL+KzkJKxmpqwLoQ9q9yoqAOy+Y4DqHbaSWHEHX2dPE
         rs+jt8PLOAQhS1vjdjtBOwGRFTrivUDbM2yIFdfe3dNKuskGa9+oacXZ9Ht0hXoLNSxr
         SFVpQnImIcJ+dCiRN6n5t9YeLtIChAINQowIbBH9ACfOMGwzLs9RuX4bzoFkwSnBne+6
         YS/vwoIlZlzv2grUqXLI6d/8eYVEALuYW+JAHykvaT+43BgLS40pS9iSgsxz/fraCgno
         5MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHUURRnzGnrmLI5y4M5ySmRm+i79H61bknDL487SEsw=;
        b=lbP3NCsRMfqbuT4v7/cIB31Z/CukZQnoQkdL2C19hNdl9ZdaszGRwbhWVnLuQt9CGA
         gSz0UDWwa0dFhO/hBraV10JJsxv4JLEtZ0kpy/L+XL7mZGEA/qhaolNjNwafcMPbGzoE
         QcBOk2sk5vAhbX0w59REP9/uyN5B3DzhOSfhVyAKhhRrTUva/WpS2yvWM3g4vEObsDGt
         irR2PxTtkDbJnl4vVsqZICoTcnKyWpmOFFQyIbL4jAQg5oxKZm0/a3SkVawq2MN7QJYW
         4N8qdGrbH9m/tuE3TOa9itNz5e3IzPRO7GWEwvwODcWifxsOmfkUkvqJ4TyHcaWNVf2I
         HSnQ==
X-Gm-Message-State: APjAAAVHI3I3N3nFEK98er+S/bQR6P/ZS+K5Prh9XS9einmyBR5X/6jw
        Yv7qCtQBxMzycQt68xqS15QxIyR+QggjVkzo0g4=
X-Google-Smtp-Source: APXvYqyREAB3T1bswRbTZ87L8vjuCz+foeySP2HZyMM6SUJq8m74Sb3LU9sS+dxQBMU2AsPOtq04rvMq91HdgcSiZmE=
X-Received: by 2002:aed:38c2:: with SMTP id k60mr64464232qte.83.1564172762771;
 Fri, 26 Jul 2019 13:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 26 Jul 2019 13:25:51 -0700
Message-ID: <CAPhsuW6063CtvnnjMdVcnY88HseEvtO4P8jUB6WOR3R3GZOPzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] enable fail last device in raid1/10 array
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 24, 2019 at 2:09 AM Guoqing Jiang <jgq516@gmail.com> wrote:
>
> Hi,
>
> The first patch adds the support for fail the last device in raid1/10 array,
> and other two patches fix issue that the new added disk is set with In_sync
> even it doesn't complete the synchorization of data.
>
> Thanks,
> Guoqing

Applied to my local branch. Thanks!

>
> Guoqing Jiang (3):
>   md: allow last device to be forcibly removed from RAID1/RAID10.
>   md: don't set In_sync if array is frozen
>   md: don't call spare_active in md_reap_sync_thread if all member
>     devices can't work
>
>  drivers/md/md.c     | 45 +++++++++++++++++++++++++++++++++++++++++----
>  drivers/md/md.h     |  1 +
>  drivers/md/raid1.c  |  6 +++---
>  drivers/md/raid10.c |  6 +++---
>  4 files changed, 48 insertions(+), 10 deletions(-)
>
> --
> 2.17.1
>
