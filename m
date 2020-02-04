Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450831513A4
	for <lists+linux-raid@lfdr.de>; Tue,  4 Feb 2020 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBDA0E (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Feb 2020 19:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgBDA0E (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 3 Feb 2020 19:26:04 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692C920CC7;
        Tue,  4 Feb 2020 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580775963;
        bh=DEnhTGeqYfIEzDziYGUHBt/C1mOgjcVIIMoH0OSvRRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SXMxF1CntPRqjFankbOjPB9lqULjP5rosZEhKcAGQTsJrBCvIgAkjfHFgqTyWIe7j
         CVyxMKuQ5pQQXSi4yefdV1FwIGSHYjgMQ8364BVhTmqSBl2Gy7Ge+1a52UPPCZj97h
         Soh4l59P/Q1q6Ic+l7pVf92EhOlB+ROyhE0xfb2c=
Received: by mail-lj1-f170.google.com with SMTP id q8so16624006ljb.2;
        Mon, 03 Feb 2020 16:26:03 -0800 (PST)
X-Gm-Message-State: APjAAAV3frYcc3qmKY8Vniik2rvkxmcA/Xg1y9J6RlZXoaR4/sHfPWoj
        1ceAeF10V8JP9ur05YICDFczhNFawBtgppPU4cc=
X-Google-Smtp-Source: APXvYqzTusJ+pjfJoFX+ywErYaY8hX/RTm5VsLAItbJ23Up+JMRKi46LwfDxhZObieJ14r9nIZPXVF9K9anoU0IeYxE=
X-Received: by 2002:a2e:810d:: with SMTP id d13mr15391339ljg.113.1580775961545;
 Mon, 03 Feb 2020 16:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20200129181437.25155-1-dave@stgolabs.net> <a7358719-55af-6510-952e-df8f202f1ab9@cloud.ionos.com>
In-Reply-To: <a7358719-55af-6510-952e-df8f202f1ab9@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 3 Feb 2020 16:25:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6k10vZju0r_=HG81gWkZGMQD-0e5Rk-b3tZN7yDTi+jQ@mail.gmail.com>
Message-ID: <CAPhsuW6k10vZju0r_=HG81gWkZGMQD-0e5Rk-b3tZN7yDTi+jQ@mail.gmail.com>
Subject: Re: [PATCH] md: optimize barrier usage for Rmw atomic bitops
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jan 31, 2020 at 8:43 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 1/29/20 7:14 PM, Davidlohr Bueso wrote:
> > For both set and clear_bit, we can avoid the unnecessary barrier
> > on non LL/SC architectures, such as x86. Instead, use the
> > smp_mb__{before,after}_atomic() calls.
> >
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

./scripts/checkpatch.pl reports the following:

=============== 8< =================
WARNING: memory barrier without comment
#81: FILE: drivers/md/md.c:2564:
+                       smp_mb__before_atomic();

WARNING: memory barrier without comment
#112: FILE: drivers/md/raid5.c:367:
+               smp_mb__before_atomic();

WARNING: Missing Signed-off-by: line by nominal patch author
'Davidlohr Bueso <dave@stgolabs.net>'

total: 0 errors, 3 warnings, 42 lines checked
=============== 8< =================

Since we are on it, let's add comments for the barriers. Also, please
double check the email
is correct.

Thanks,
Song
