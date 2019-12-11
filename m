Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD211BCDC
	for <lists+linux-raid@lfdr.de>; Wed, 11 Dec 2019 20:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfLKT0x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 14:26:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34369 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKT0x (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Dec 2019 14:26:53 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so6251357qvf.1
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LrWevApQilAwafIK1Jn7IO0XdysisjC6aLmKt8o0mg=;
        b=C30Iv+1rLdFEKTwVckomY+nzbtoRhby2sOpzNUOimEouScE+7OurbzEj3KgWtw9wAX
         8tyhov69JSVwquILmaLkGqmbAHI+GaqPc1NDdyB/q9WAt5OsduOE2euNLKBriVaY2yiS
         GSmfMbbKe8pNMODYfhh9xfbMNkBaB1IhXPYWZun+IlUHgIPwARVo9H51dMz9NfIu3boj
         zpf+JriqcLIbBMBxgWTHFrobo2sZ6fPxKL9h6n7zwK3BdhYOawsiNKd/u+XYH3jp2Y8C
         sf2Qf43G4gWNUHKQJaJAUYpW9klhxEdSia+8U6ww3SNp4JCkJJb57l5s0oLCw7ipX1uN
         /hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LrWevApQilAwafIK1Jn7IO0XdysisjC6aLmKt8o0mg=;
        b=BK0II+OM4PY3MRyTI0kftByJjViYQFYcQMyIybl0jGmtAo9FSzB1Lg4zT2CMjaU+FS
         MPJi/ZeVmsmwQe0gH6uEu5BDM0yJEKc7a7xPg786LF7vsd4j2it2hGsN4++WL05/928J
         MluygIvznRTUbNjQTZvkUrZPfXh6RkBIxWcNgMb5jn4WXvUmFOJOF8aZXAd7qihp0vT9
         PJy+nRlOvizx7/Qn7ffMiwLYnbtGftF3xq4PIiDojISyyBDd8bXPD2jXWAmRlmYpif92
         Nbaxc4aOzlZUPTKI/3T+0ZkOtyLnh1XHrn1lnf8+TqxDjRPPLojdcAFx3em/i0wt2iuZ
         bVOA==
X-Gm-Message-State: APjAAAV9NSRrYSxbSRfEX2GvKtOkuCt+EQ1SgXSXNUJAmB9J3zPltMDq
        +Hx0mSOcp5+N/l7EjnlXzFyXMZWEwuFwWXEdTIE=
X-Google-Smtp-Source: APXvYqx44PSS5qiouoOYnDccLu2t1wOc18acuHkhKlHa0n1nHaCh1da+5a6F6ndS1qKZluNrT5HoORIyI/e9y9akVjo=
X-Received: by 2002:a0c:8a31:: with SMTP id 46mr4757439qvt.8.1576092412603;
 Wed, 11 Dec 2019 11:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20191205031318.7098-1-liuzhengyuan@kylinos.cn> <20191205031318.7098-2-liuzhengyuan@kylinos.cn>
In-Reply-To: <20191205031318.7098-2-liuzhengyuan@kylinos.cn>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Dec 2019 11:26:41 -0800
Message-ID: <CAPhsuW7ZYYB6CQY48TjQ86cRJianE5dL07gNKJA-WLYM_AMmsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-raid <linux-raid@vger.kernel.org>, hpa@zytor.com,
        liuzhengyuang521@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Dec 4, 2019 at 7:13 PM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>
> There are several algorithms available for raid6 to generate xor and syndrome
> parity, including basic int1, int2 ... int32 and SIMD optimized implementation
> like sse and neon.  To test and choose the best algorithms at the initial
> stage, we need provide enough disk data to feed the algorithms. However, the
> disk number we provided depends on page size and gfmul table, seeing bellow:
>
>         int __init raid6_select_algo(void)
>         {
>                 const int disks = (65536/PAGE_SIZE) + 2;
>                 ...
>         }
>
> So when come to 64K PAGE_SIZE, there is only one data disk plus 2 parity disk,
> as a result the chosed algorithm is not reliable. For example, on my arm64
> machine with 64K page enabled, it will choose intx32 as the best one, although
> the NEON implementation is better.

I think we can fix this by simply change raid6_select_algo()? We still have

#define STRIPE_SIZE             PAGE_SIZE

So testing with PAGE_SIZE represents real performance.

Thanks,
Song
