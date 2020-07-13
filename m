Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA71C2189F6
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jul 2020 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgGHOSF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jul 2020 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgGHOSE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jul 2020 10:18:04 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F7AC061A0B
        for <linux-raid@vger.kernel.org>; Wed,  8 Jul 2020 07:18:04 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e15so24557465vsc.7
        for <linux-raid@vger.kernel.org>; Wed, 08 Jul 2020 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRR2oJR1zyC/uavTh/YxuWLenLZLmhhz/A0r+ZwnaDk=;
        b=OQcW7xbioXHtmAbx/ip/Tlfp4h7QPUYO95fu9t2pWRbGgWlJdeUbVjfnhrlkb8WbDo
         DuEeB1lMqRZ90j75hQHwVuJhH1GgDEM+TvRUdOlwKpT1wkHK+PCrx4V0ZGYCHmPI+tfN
         UjLCSsrzM3cM8PCZhcfsK7i12HkvY2TIurjbLgTAttoIL23Ns9/mRuf/CWrbyebP+2kV
         qm/QnDQEOKyTcB+HUcFdeDJ/vQfWklXSC7fP+5pxnZvWonHtUicImN5rmgxwg57I3UIl
         nL7HbmxzTse5SSMZ9AoRMyqYF5kLVbJcZ0IFdjtwJa9eMX5SmLx5Qc8Ky0tFlbYpzU2X
         E2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRR2oJR1zyC/uavTh/YxuWLenLZLmhhz/A0r+ZwnaDk=;
        b=g+H4NxC/eJ9gsmSwJfw+Wcztxj25aP+MRTFJPf+Eb+fJdwU8/x6vPKmzzrTQQe2Yks
         ZeI//D38SE0DfoPlAw4UN4S383Mphv5AClVGMpqQwmCohD4u8bU+IkEQ7JnJBhTROjng
         J8bCySCTIla79gIbM/KYj//Sn/50kXKCS+TM7krkUKIxr39WLd56Wpr4ztI/oIK5liIo
         Pq/6k8V4/EkdHNFrQGJ5Z1opS4c+7HoGsuWcoyv1onLDttCoxtAsPoHAnTIRb0Unc7OM
         A324rwQ+6KEcRpeCtE8sEisdhN7U0/1x60K/NRvfo21Hh0cEvjX6QEERm3w2C8wGz8gy
         aC9Q==
X-Gm-Message-State: AOAM533uK4Xz80Qk+h3tVXu52Alklc1Jj2Jbs/NeDPYwSIf1517xgLtO
        9LPinBb+IZQp7gD1Ht8zAb/3/dZpYa8TThe+YNkDnw==
X-Google-Smtp-Source: ABdhPJxQJp92VWdX5KqTmVPfmOl1A/gpaTfKOYLxSE9CCWw6fdiJ4zs2Ef7rqDQv+aFRiUZRPmlsdiPFBfzPND4QOJE=
X-Received: by 2002:a67:f888:: with SMTP id h8mr23246530vso.165.1594217883238;
 Wed, 08 Jul 2020 07:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200708122546.214579-1-hch@lst.de> <20200708122546.214579-7-hch@lst.de>
In-Reply-To: <20200708122546.214579-7-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jul 2020 16:17:26 +0200
Message-ID: <CAPDyKFr5+LRRGMYhWM2At=O9LQSPmFAp0YuQiwmRiV1a6Tx6=g@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: remove the call to check_disk_change
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, 8 Jul 2020 at 14:41, Christoph Hellwig <hch@lst.de> wrote:
>
> The mmc driver doesn't support event notifications, which means
> that check_disk_change is a no-op.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I can queue this via my mmc tree, but perhaps you have plans for some
additional cleanups on top? In such a case, it may be better that this
goes through Jens' tree?

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4791c82f8f7c78..fa313b63413547 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -312,10 +312,7 @@ static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>
>         mutex_lock(&block_mutex);
>         if (md) {
> -               if (md->usage == 2)
> -                       check_disk_change(bdev);
>                 ret = 0;
> -
>                 if ((mode & FMODE_WRITE) && md->read_only) {
>                         mmc_blk_put(md);
>                         ret = -EROFS;
> --
> 2.26.2
>
