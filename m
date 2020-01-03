Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DC12FBDE
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 18:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgACR5y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 12:57:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41752 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgACR5y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 12:57:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so44655489ljc.8
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T45h0z3KwBnxREnUTrzFXE0As3aBiVGmMXPfHvAiCrc=;
        b=ME3gEbQZbbr/QZsMw+4UowYLdv+tkT7Kx1txtgfn7sEOp55cNitgSYFBk88peK+epQ
         +J3i2CZJFT4iqBl+YPG1rpafs6BVjr/+ZpdBkOfCyVVWPjK/lPOZ9mu9ZtnM9dW9mDmZ
         p7zIJtQMDJRz4QmUIdzm7x+ziTzhZErzLhPS0Veqo0WUEcCKpakgIhVVtrVlekhJuE2l
         7II65LyzKRBmvXIyli2rommh77S8uMl9cbzUC7Oi0jMfZYK5YbpM8muX9ioYrdS42Fq+
         Fkfo/r3cb1FTqf4rfLEz9jz3uIIk/Xpfl2qjeSzrCBzvhX4fCWAkKYmBQeB1f0+t067u
         F1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T45h0z3KwBnxREnUTrzFXE0As3aBiVGmMXPfHvAiCrc=;
        b=Sdl5AyNGaWfhjeLqGroExhJIIy5Ewa6Z3PE5U5Ghrbji0S60tk+rDaV58teOVcIPRN
         wvovXaxdaR030bg88mbL7tkJVa+Np66q5tW0+Jdor7qzqnxAR6ad4gX+p/OILqOvkaH9
         Uku7l37u9regxqQLeAyIsoTHBgonVZ0o/vo1QH5RO06u1AT3DR/twPjYxWCIWSQytfKr
         S9gxLJR9tyhmBaw6bQH1rkhcgcK+zGSredKn0d3PR7oU2tf8Ypq+jncfSwlBYUefEfX6
         Uldq6bFyWEBbdGDX3MmLBSsqR+SEDLOu/etY3s6QEag6jmXeLQGELP+VRskbtYh2oGTk
         9RNw==
X-Gm-Message-State: APjAAAVp2S014ug5rnycV/XWdjzo5FKS5LwzVovviwAHzBLdIgTFVovE
        OVglzwS6+CXzHRdkWCY1F9W+Gw90UPzCYQvz7gu0sg==
X-Google-Smtp-Source: APXvYqySsgtANcna5XiXjQx1umFqfJad7O5RlgdWzMFnteTebFbTNR6nQIUvadLqV2HbsYdpP+LkDwWTFpimqqwZ4Vs=
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr53055503ljm.68.1578074272555;
 Fri, 03 Jan 2020 09:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20191220022128.23296-1-liuzhengyuan@kylinos.cn>
In-Reply-To: <20191220022128.23296-1-liuzhengyuan@kylinos.cn>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 09:57:40 -0800
Message-ID: <CAPhsuW4pyv-W7nsLsJYWLnyLAx943pJfp=xas3sTXA0B_nzuog@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] raid6/test: fix a compilation error
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     hpa@zytor.com, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Dec 19, 2019 at 6:21 PM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wro=
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
> Fixes: 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN macros into <=
linux/limits.h>")
> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>

Applied the series to md-next.

Thanks,
Song
