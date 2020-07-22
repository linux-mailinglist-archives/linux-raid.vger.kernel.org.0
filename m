Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491EC228F88
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 07:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGVFIw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 01:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVFIv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 01:08:51 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F30820771;
        Wed, 22 Jul 2020 05:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595394531;
        bh=DaoTdcyJI9RaUKeacnQJ4Hs0IpG/0+Iat2hoSYkDO7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xqhAu2ueVA+WoDVByXVyll1yJSdkntZ7TgcBKBr5Z3Z1K1FUz+rdvvycnGnhaXsoK
         UenlR6fmF+Q/ewltq5SuaPi2MgCKWWz9YVQz//xIxvbc/HMIbmBmeTh0FLMB5nKHk8
         l2vwoYG0nI9s5XTBfXaylMA5ePwlz6rLYBxSMbn4=
Received: by mail-lf1-f47.google.com with SMTP id u25so593633lfm.1;
        Tue, 21 Jul 2020 22:08:51 -0700 (PDT)
X-Gm-Message-State: AOAM533sTXZz2SU15GGSFH2itYJ1ssDKoYtyvzawKXqAfrA6ZMf1JB+H
        DBGYeN8IEd1Q30bOfQjcGbwLqWcbVo4tEIcS6UE=
X-Google-Smtp-Source: ABdhPJzBOrRHqiVjRuAEeMVLGTv2NJ6bLFAbKswTYPum2C5gT/XsvqYPEet1PjYMpqnu74zTBHMLW9u1TFAHRG/dvpY=
X-Received: by 2002:a19:be53:: with SMTP id o80mr15169025lff.33.1595394529460;
 Tue, 21 Jul 2020 22:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <d01bc32e-3b17-bd4d-faf6-29b4b931c9f6@infradead.org>
In-Reply-To: <d01bc32e-3b17-bd4d-faf6-29b4b931c9f6@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 21 Jul 2020 22:08:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Mg-oKrSrtTUsDq1FGKTQJ30UVKV5en5SCJLrmKBcf2A@mail.gmail.com>
Message-ID: <CAPhsuW7Mg-oKrSrtTUsDq1FGKTQJ30UVKV5en5SCJLrmKBcf2A@mail.gmail.com>
Subject: Re: [PATCH] raid: md_p.h: drop duplicated word in a comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jul 17, 2020 at 4:37 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Drop the doubled word "the" in a comment.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org

Applied to md-next. Thanks!

> ---
>  include/uapi/linux/raid/md_p.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20200714.orig/include/uapi/linux/raid/md_p.h
> +++ linux-next-20200714/include/uapi/linux/raid/md_p.h
> @@ -123,7 +123,7 @@ typedef struct mdp_device_descriptor_s {
>
>  /*
>   * Notes:
> - * - if an array is being reshaped (restriped) in order to change the
> + * - if an array is being reshaped (restriped) in order to change
>   *   the number of active devices in the array, 'raid_disks' will be
>   *   the larger of the old and new numbers.  'delta_disks' will
>   *   be the "new - old".  So if +ve, raid_disks is the new value, and
>
