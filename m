Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB7123A58
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 23:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLQW5w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 17:57:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42256 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQW5w (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 17:57:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so284196qtq.9
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RpqbiMNXbXWEeteyCXLePoteNjPYxMzJnG2A0LzDQ4k=;
        b=iNy+Xv1rafvnsB9R7FumLTsmmOkK/6itT9LjDanB00iHUWDioRHmt/IQCqFqOxOfyh
         ct1N8kNACAOnD4hcKH/3h9NuYhQ3k0ZFw2EmGtygRJPAJKu7yEUIUv6FU2F/JEcefIoj
         /tnWbUNTZdzNFhjzWt/BlBnthcJXqGPh9iRSBIdBk2eTjs5eZCLpt8Lr+64HgpDa7pT9
         V56wg3u13zP7Wec0/5y7hXMkuI90vfHemg5gjvxDxp0gonft/tECwaDWTSA4jSOwyytb
         8BeK3hh1xSwv6wO1fK+rhEwQ4Ol3mM/txn1T0nRv4anSy9dFyojOu6RsAvBKUiet7/LP
         lfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RpqbiMNXbXWEeteyCXLePoteNjPYxMzJnG2A0LzDQ4k=;
        b=m3+SomPC3UXDOu1fbjKTYLoaPpXmnQV84L5AED17o1ezR1NZ4jLOEwHfquEa/Ie77g
         hAozZHY55XnrB0TAJ1RwPhONmFbTQ+aLbkVw+xS5lfBzkfsgf1/+uGHwwHOoIgeLYLoE
         x4fzi1Q/kmWKiWFtiMidL8wmzfp2BJjeXeHAHxcFDBwN215XyoLhc3bOZ2U8kKtYFSfZ
         YOkdBPTQgQzTroBl6VDWzyoKT0rFtGWh9+tySxWB+foizzHujNVEawg+tKHQPZCGLWLi
         XoEVuR09SR5mwXHgSPW4HzuN2hzTq0CrZ6skv53IO4Z9lfkO0J07aKrITnpm+jX1Qfa9
         40WA==
X-Gm-Message-State: APjAAAXt78utPIGsn84h/Vvw0ZGXzSAZlbKziCMMX0Ngaypcm++niMPW
        YjW7Irs6006MhjCdNyJ9CJVDoGHKh183JLuNVnfG3A==
X-Google-Smtp-Source: APXvYqzmevKgEzshBlkrkDSSaKXk0LYdYSdejHU4K+NOH6YL78AYmYJDk61abVwbkUNeFvjy6S9DUq7ROCJu8aUXbSI=
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr355439qtv.308.1576623471523;
 Tue, 17 Dec 2019 14:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
In-Reply-To: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 17 Dec 2019 14:57:40 -0800
Message-ID: <CAPhsuW6Rd98zybMg_PjPQVe_hxpQB2ufHrEJ2zFw=3vCJC9FxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] raid6/test: fix the compilation error and warning
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     hpa@zytor.com, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 16, 2019 at 5:09 AM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wro=
te:
>
> The compilation error is redeclaration showed as following:
>
>         In file included from ../../../include/linux/limits.h:6,
>                          from /usr/include/x86_64-linux-gnu/bits/local_li=
m.h:38,
>                          from /usr/include/x86_64-linux-gnu/bits/posix1_l=
im.h:161,
>                          from /usr/include/limits.h:183,
>                          from /usr/lib/gcc/x86_64-linux-gnu/8/include-fix=
ed/limits.h:194,
>                          from /usr/lib/gcc/x86_64-linux-gnu/8/include-fix=
ed/syslimits.h:7,
>                          from /usr/lib/gcc/x86_64-linux-gnu/8/include-fix=
ed/limits.h:34,
>                          from ../../../include/linux/raid/pq.h:30,
>                          from algos.c:14:
>         ../../../include/linux/types.h:114:15: error: conflicting types f=
or =E2=80=98int64_t=E2=80=99
>          typedef s64   int64_t;
>                        ^~~~~~~
>         In file included from /usr/include/stdint.h:34,
>                          from /usr/lib/gcc/x86_64-linux-gnu/8/include/std=
int.h:9,
>                          from /usr/include/inttypes.h:27,
>                          from ../../../include/linux/raid/pq.h:29,
>                          from algos.c:14:
>         /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: pre=
vious \
>         declaration of =E2=80=98int64_t=E2=80=99 was here
>          typedef __int64_t int64_t;
>
> The compilation warning is redefination showed as following:
>
>         In file included from tables.c:2:
>         ../../../include/linux/export.h:180: warning: "EXPORT_SYMBOL" red=
efined
>          #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")
>
>         In file included from tables.c:1:
>         ../../../include/linux/raid/pq.h:61: note: this is the location o=
f the previous definition
>          #define EXPORT_SYMBOL(sym)
>
> Fixes: 54d50897d54 ("linux/kernel.h: split *_MAX and *_MIN macros into <l=
inux/limits.h>")

This is the Fixes tag for the error. Please also add a Fixes tag for
the warning. Maybe split
the two fixes into two patches.

Thanks,
Song
