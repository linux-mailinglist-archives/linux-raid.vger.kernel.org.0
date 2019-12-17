Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56058123AC7
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLQX0Y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 18:26:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34441 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQX0Y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 18:26:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so278515qkk.1
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmBVbiAYL9J52YVcQ+6OdV0nAQRcmtI2icE7oDas9oM=;
        b=YA1T/7135VWRB3eM8O689VeuI/BWAnTKrPl9vFdiRjthGWYI6c9achQ8rBRAj+JPTj
         sSwVCbvvJTjhbnK2SAWjs9ytMHp41HS61UTsASWffJgkSGmFrouA9HaPIntcifq5Rcgq
         G5Zglzcnjq+PjwZA0n7KuIGFnltTUrfVzfKRXGbTRwg8c+5kdwFIzBxpF+FaubEoZ1LK
         sERP1uGUiaDz9x3IayFVAc0kD3gRXU9gWjFDGNaUqK9rdiRxH2cjE7cXXN7Scyxu/4D2
         v0pP4qSZlY8nD/PX5Cw16Y4ZKS5hVrr7aVPGUcQMYDYxJjEBBrSagXFnGGT2bG256ciy
         GiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmBVbiAYL9J52YVcQ+6OdV0nAQRcmtI2icE7oDas9oM=;
        b=TL2miJ0pChk2NuBAEF7iOYNsnHAnNd5Pp8WknPRP8IjYRyEKgYySi8jDFBqCtOojyR
         BKm1GqupIoW57Bs8L6LavF8mWknSjhgg60ZODmd+ktyu+MYkhdW4knLeS+gVEl/zOsO6
         Cy9d/qQWgHnw+mTJ18pzyzTNrQpZoDeBIA1jk3yN75mvh5OOZnUxA69hfpvRrb2Rxo/s
         tDmkz5pSQbTT529k9lHB4gMZ+P67NeMqpZ5bP6XNnjyEBNvFhDV7Ym4SliDZXULtmtoH
         eDC0hlH6gyhynkmojXfF80ZS3QfswWM0Vumq/JkEvXwxKSNhKllYhawjJcxW2jXQj/dP
         cIIA==
X-Gm-Message-State: APjAAAUBfkXk68uzogpxcR07nv2tO4xYBp533p7jhGgzKubn8lvbB4N1
        mlTYARnP/8ARk35O9EMHirLO0iSVj10xaOygUu4B/Q==
X-Google-Smtp-Source: APXvYqwjlBBnqpdrHGPbVwjB28rxETkUkZeg/pQUn14xNG7XyX/3F7ij7PU7/8aMj4nUZ6DI/ibMtcA0GjLCWOdCJkE=
X-Received: by 2002:a37:8b85:: with SMTP id n127mr565429qkd.353.1576625183153;
 Tue, 17 Dec 2019 15:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20191216130933.13254-1-liuzhengyuan@kylinos.cn> <20191216130933.13254-2-liuzhengyuan@kylinos.cn>
In-Reply-To: <20191216130933.13254-2-liuzhengyuan@kylinos.cn>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 17 Dec 2019 15:26:11 -0800
Message-ID: <CAPhsuW4FnPFoErW8z05vw2TC2Qhv0URMHjbmme=R2REbikDh=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     hpa@zytor.com, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 16, 2019 at 5:09 AM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>
[...]
> ---
>  include/linux/raid/pq.h | 17 +++++++---
>  lib/raid6/algos.c       | 71 +++++++++++++++++++++++++++--------------
>  2 files changed, 59 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
> index e0ddb47f4402..6b68b9590a6b 100644
> --- a/include/linux/raid/pq.h
> +++ b/include/linux/raid/pq.h
> @@ -8,6 +8,8 @@
>  #ifndef LINUX_RAID_RAID6_H
>  #define LINUX_RAID_RAID6_H
>
> +#define RAID6_DISKS 8

Maybe rename as RAID6_TEST_DISKS.

[...]

> +#endif
>  extern const char raid6_empty_zero_page[PAGE_SIZE];
>
>  #define __init
> @@ -168,11 +174,12 @@ void raid6_dual_recov(int disks, size_t bytes, int faila, int failb,
>  # define pr_err(format, ...) fprintf(stderr, format, ## __VA_ARGS__)
>  # define pr_info(format, ...) fprintf(stdout, format, ## __VA_ARGS__)
>  # define GFP_KERNEL    0
> -# define __get_free_pages(x, y)        ((unsigned long)mmap(NULL, PAGE_SIZE << (y), \
> -                                                    PROT_READ|PROT_WRITE,   \
> -                                                    MAP_PRIVATE|MAP_ANONYMOUS,\
> -                                                    0, 0))
> -# define free_pages(x, y)      munmap((void *)(x), PAGE_SIZE << (y))
> +# define kmalloc(x, y) ((unsigned long)mmap(NULL, (x), PROT_READ|PROT_WRITE, \
> +                                                MAP_PRIVATE|MAP_ANONYMOUS,   \
> +                                                0, 0))
> +# define kfree(x)      munmap((void *)(x), (RAID6_DISKS - 2) * PAGE_SIZE     \
> +                                               <= 65536 ? 2 * PAGE_SIZE :    \
> +                                               (RAID6_DISKS - 2) * PAGE_SIZE)

Why do we change __get_free_pages to kmalloc?

Thanks,
Song

[...]
