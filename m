Return-Path: <linux-raid+bounces-4675-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E1B08723
	for <lists+linux-raid@lfdr.de>; Thu, 17 Jul 2025 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3DD16734E
	for <lists+linux-raid@lfdr.de>; Thu, 17 Jul 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9A253F2B;
	Thu, 17 Jul 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuhHXt0i"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF71BA27;
	Thu, 17 Jul 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738034; cv=none; b=TdW7a/0Vf54b/Gn22vjuSEJL3KD8v/u48swB04Wmr0zejvcyBKri55lkzhU5DSlSfJ7JT53ke6lspNklcrKTib1gFAezurT1ESzJO7yM40+tlT+v9zSEO7B9xgjhA46KECn+6kNdwfWxxKoP2isZQFQI86Yx5sxMxLyvv8Q0Ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738034; c=relaxed/simple;
	bh=+lIfYO3y7dw0JFb5StwtIGCBipr6ahO1kf+WifdA94o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpYUISql+y1e80B3/qApXpyXTCbUinZ9bZQWp9PlPnJKVdTOeETBTWefmnwaGFy4yJV2Qq20ysABT6qYfrQS32AdWZzP+GfxaAMK2F3x4I9oF7IUeE+KOFThQYMsfNA5f1rU1gGNz4IfMiL5nfba1taYornZnhuKoNKbO/wCbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuhHXt0i; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-615a68bd0efso137948eaf.2;
        Thu, 17 Jul 2025 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752738031; x=1753342831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVlVlJXrg0D7LxIDHnIPG4gs6GmZ4sZPsbejHoViL/0=;
        b=XuhHXt0iTG3v9MyXDKrITb2eoP4km/M9o8GF0I0P8pb8/A/YUIRoGTAKMoJNeaShFO
         RIpQSlXYLsh2QfVCgJXH7YHnxwDFWBRsNGMUF8o6X/AcnZLzCTP7GMKxeZOg80ZKlFiF
         FZz2fupkivLdh88KUEYyjXTvyDWdy48avnA/p7aeFgHSyFACuw8AZlXwTcje/dj5qhn/
         vL+3gxPUPJphriwpRtQto+DEp8CTPy5Qi3WenLre3z9SvFoh6TlIKUUBMvLLc9x443HB
         Omzzg+Ku2wPBkNxHUjE6FF3qIS9GJ9bgkrihHZOj0X1+VzTQ/eErswI27EF+fomIgHHw
         pfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738031; x=1753342831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVlVlJXrg0D7LxIDHnIPG4gs6GmZ4sZPsbejHoViL/0=;
        b=A5y+mAgcJYYXuenOLJC1xQlkXav65pGvyeX+EBs98AOFUSvjUOXdpaOc2YvCo68uAT
         PY+7zgV7XUJjJbCWII2hHq1wSJWeSk1kZ3CMJ1R9Nr8hHOXIbpjgZaM9ZmXREkhfrCvO
         Iy82Ff/V3x6xZJ68ajp9gDG+C1v/iKLQTqXPujCTCpo7+q1FPVe6hTbGKAGXSNOHEO4c
         86jpdA95LJIgde+ZRvwA9788BKVX+fjFS8JLYadKCk9r3SmeY/CGPY7NshnKj9zjqkBq
         lnviU1gNtGWhzYpCDcneeyXjWv72Gx3L6I2GBunS+5fIMH33mAK/TVzN/LoDkMqJd3Jy
         9hsA==
X-Forwarded-Encrypted: i=1; AJvYcCVYIbRL+0e9tNLH80db3Dfk6IapgIYG4U4X0G0uT73ibHtdqrNPYIGXmamQmW3COSl7m5qBKxyptDGKC+4=@vger.kernel.org, AJvYcCVv5jJoMMRxq0NFPA9D87llXhf0QexOHhWAJsx/dcnjnT8+pvj1FOM2D5ZiwEj5SCXt8CoYZ/xafGijmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7+gUYWJcx7v+ocZgCp1mmpmCUKTiPQ+38/umAsmum5U0v8Vs
	f5bHs8emirP6QQ+h3nBFnDnwRglvRB2hmI121uoR3X8/SQDdQ2YtIBm+X6jgY/UHi8g6h5vLuje
	sS1zZGjZLHR93t/0s5E3Cp6lcerdCq+g=
X-Gm-Gg: ASbGncuhraF3xNI5dz57V56iLq5lPLT8Dsws7BYtf+wy4VxVwDwrmQF76pXwxyj+7+l
	Sry6MbuKrTpmv7cBRh4Dq52qJ3LzCbu0ZGr371hHH5QJCrx/JSV6k25k2RJqXq6sBncvLXscBAr
	R4VetBi15FE3J/z+q/KWDjgmu8xvaAAUluqNIhU+F+UnACGKYeuOUsfaOuspgP4nhzaSXFFdHSS
	wnIrmy+yzaAzL2cCxjTQ7DvpukSWJWPLpFWf/g=
X-Google-Smtp-Source: AGHT+IGJWiIvJHDzaIAvnyW1Zy8HpyrJE5S9xQNCsaqrC2aEeCmKTukufvnckvLm5xisHc+dnghWjrwPWuLGt27u2/w=
X-Received: by 2002:a05:6820:5082:b0:615:96cd:ebfc with SMTP id
 006d021491bc7-615a1fd1324mr3989901eaf.2.1752738030769; Thu, 17 Jul 2025
 00:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711100930.3398336-1-zhangchunyan@iscas.ac.cn>
 <20250711100930.3398336-5-zhangchunyan@iscas.ac.cn> <eeaae98c-31be-4773-9138-0a1ad22604ad@ghiti.fr>
In-Reply-To: <eeaae98c-31be-4773-9138-0a1ad22604ad@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 17 Jul 2025 15:39:54 +0800
X-Gm-Features: Ac12FXysuaOKL4PyazMs8fqwKP9ALcDhihki1QbFQ1z5W33JT56fFDZG43hJaFE
Message-ID: <CAAfSe-ugr-AX4z6N1_uAQ32gxJ2UqxZ53KjTD7FWOZ+e0T4dtA@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] raid6: riscv: Allow code to be compiled in userspace
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Charlie Jenkins <charlie@rivosinc.com>, Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
	linux-riscv@lists.infradead.org, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Thu, 17 Jul 2025 at 15:04, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On 7/11/25 12:09, Chunyan Zhang wrote:
> > To support userspace raid6test, this patch adds __KERNEL__ ifdef for kernel
> > header inclusions also userspace wrapper definitions to allow code to be
> > compiled in userspace.
> >
> > This patch also drops the NSIZE macro, instead of using the vector length,
> > which can work for both kernel and user space.
> >
> > Signed-off-by: Chunyan Zhang<zhangchunyan@iscas.ac.cn>
> > ---
> >   lib/raid6/recov_rvv.c |   7 +-
> >   lib/raid6/rvv.c       | 297 +++++++++++++++++++++---------------------
> >   lib/raid6/rvv.h       |  17 +++
> >   3 files changed, 170 insertions(+), 151 deletions(-)
> >
> > diff --git a/lib/raid6/recov_rvv.c b/lib/raid6/recov_rvv.c
> > index 500da521a806..8f2be833c015 100644
> > --- a/lib/raid6/recov_rvv.c
> > +++ b/lib/raid6/recov_rvv.c
> > @@ -4,13 +4,8 @@
> >    * Author: Chunyan Zhang<zhangchunyan@iscas.ac.cn>
> >    */
> >
> > -#include <asm/vector.h>
> >   #include <linux/raid/pq.h>
> > -
> > -static int rvv_has_vector(void)
> > -{
> > -     return has_vector();
> > -}
> > +#include "rvv.h"
> >
> >   static void __raid6_2data_recov_rvv(int bytes, u8 *p, u8 *q, u8 *dp,
> >                                   u8 *dq, const u8 *pbmul,
> > diff --git a/lib/raid6/rvv.c b/lib/raid6/rvv.c
> > index 015f3ee4da25..75c9dafedb28 100644
> > --- a/lib/raid6/rvv.c
> > +++ b/lib/raid6/rvv.c
> > @@ -9,17 +9,8 @@
> >    *  Copyright 2002-2004 H. Peter Anvin
> >    */
> >
> > -#include <asm/vector.h>
> > -#include <linux/raid/pq.h>
> >   #include "rvv.h"
> >
> > -#define NSIZE        (riscv_v_vsize / 32) /* NSIZE = vlenb */
> > -
> > -static int rvv_has_vector(void)
> > -{
> > -     return has_vector();
> > -}
> > -
> >   #ifdef __riscv_vector
> >   #error "This code must be built without compiler support for vector"
> >   #endif
> > @@ -28,7 +19,7 @@ static void raid6_rvv1_gen_syndrome_real(int disks, unsigned long bytes, void **
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = disks - 3;         /* Highest data disk */
> > @@ -42,8 +33,10 @@ static void raid6_rvv1_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >        /*v0:wp0,v1:wq0,v2:wd0/w20,v3:w10 */
> > -     for (d = 0; d < bytes; d += NSIZE * 1) {
> > +     for (d = 0; d < bytes; d += nsize * 1) {
> >               /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
>
>
> You missed a few NSIZE in comments

These comments come from int.uc and neon.uc.
I left NSIZE in the comments on purpose, my thought was that would
make this code more readable through matching to the int.uc or neon.uc
:)

>
>
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -51,7 +44,7 @@ static void raid6_rvv1_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vmv.v.v  v1, v0\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize])
> >               );
> >
> >               for (z = z0 - 1 ; z >= 0 ; z--) {
> > @@ -75,7 +68,7 @@ static void raid6_rvv1_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                                     "vxor.vv  v0, v0, v2\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -90,8 +83,8 @@ static void raid6_rvv1_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vse8.v   v1, (%[wq0])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0])
> >               );
> >       }
> >   }
> > @@ -101,7 +94,7 @@ static void raid6_rvv1_xor_syndrome_real(int disks, int start, int stop,
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = stop;              /* P/Q right side optimization */
> > @@ -115,8 +108,10 @@ static void raid6_rvv1_xor_syndrome_real(int disks, int start, int stop,
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*v0:wp0,v1:wq0,v2:wd0/w20,v3:w10 */
> > -     for (d = 0 ; d < bytes ; d += NSIZE * 1) {
> > +     for (d = 0 ; d < bytes ; d += nsize * 1) {
> >               /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -124,7 +119,7 @@ static void raid6_rvv1_xor_syndrome_real(int disks, int start, int stop,
> >                             "vmv.v.v  v1, v0\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize])
> >               );
> >
> >               /* P/Q data pages */
> > @@ -149,7 +144,7 @@ static void raid6_rvv1_xor_syndrome_real(int disks, int start, int stop,
> >                                     "vxor.vv  v0, v0, v2\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -189,8 +184,8 @@ static void raid6_rvv1_xor_syndrome_real(int disks, int start, int stop,
> >                             "vse8.v   v3, (%[wq0])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0])
> >               );
> >       }
> >   }
> > @@ -199,7 +194,7 @@ static void raid6_rvv2_gen_syndrome_real(int disks, unsigned long bytes, void **
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = disks - 3;         /* Highest data disk */
> > @@ -213,11 +208,13 @@ static void raid6_rvv2_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*
> >        *v0:wp0,v1:wq0,v2:wd0/w20,v3:w10
> >        *v4:wp1,v5:wq1,v6:wd1/w21,v7:w11
> >        */
> > -     for (d = 0; d < bytes; d += NSIZE * 2) {
> > +     for (d = 0; d < bytes; d += nsize * 2) {
> >               /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -227,8 +224,8 @@ static void raid6_rvv2_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vmv.v.v  v5, v4\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE]),
> > -                           [wp1]"r"(&dptr[z0][d + 1 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize]),
> > +                           [wp1]"r"(&dptr[z0][d + 1 * nsize])
> >               );
> >
> >               for (z = z0 - 1; z >= 0; z--) {
> > @@ -260,8 +257,8 @@ static void raid6_rvv2_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                                     "vxor.vv  v4, v4, v6\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > -                                   [wd1]"r"(&dptr[z][d + 1 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> > +                                   [wd1]"r"(&dptr[z][d + 1 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -278,10 +275,10 @@ static void raid6_rvv2_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vse8.v   v5, (%[wq1])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0]),
> > -                           [wp1]"r"(&p[d + NSIZE * 1]),
> > -                           [wq1]"r"(&q[d + NSIZE * 1])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0]),
> > +                           [wp1]"r"(&p[d + nsize * 1]),
> > +                           [wq1]"r"(&q[d + nsize * 1])
> >               );
> >       }
> >   }
> > @@ -291,7 +288,7 @@ static void raid6_rvv2_xor_syndrome_real(int disks, int start, int stop,
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = stop;              /* P/Q right side optimization */
> > @@ -305,11 +302,13 @@ static void raid6_rvv2_xor_syndrome_real(int disks, int start, int stop,
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*
> >        *v0:wp0,v1:wq0,v2:wd0/w20,v3:w10
> >        *v4:wp1,v5:wq1,v6:wd1/w21,v7:w11
> >        */
> > -     for (d = 0; d < bytes; d += NSIZE * 2) {
> > +     for (d = 0; d < bytes; d += nsize * 2) {
> >                /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -319,8 +318,8 @@ static void raid6_rvv2_xor_syndrome_real(int disks, int start, int stop,
> >                             "vmv.v.v  v5, v4\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE]),
> > -                           [wp1]"r"(&dptr[z0][d + 1 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize]),
> > +                           [wp1]"r"(&dptr[z0][d + 1 * nsize])
> >               );
> >
> >               /* P/Q data pages */
> > @@ -353,8 +352,8 @@ static void raid6_rvv2_xor_syndrome_real(int disks, int start, int stop,
> >                                     "vxor.vv  v4, v4, v6\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > -                                   [wd1]"r"(&dptr[z][d + 1 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> > +                                   [wd1]"r"(&dptr[z][d + 1 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -407,10 +406,10 @@ static void raid6_rvv2_xor_syndrome_real(int disks, int start, int stop,
> >                             "vse8.v   v7, (%[wq1])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0]),
> > -                           [wp1]"r"(&p[d + NSIZE * 1]),
> > -                           [wq1]"r"(&q[d + NSIZE * 1])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0]),
> > +                           [wp1]"r"(&p[d + nsize * 1]),
> > +                           [wq1]"r"(&q[d + nsize * 1])
> >               );
> >       }
> >   }
> > @@ -419,7 +418,7 @@ static void raid6_rvv4_gen_syndrome_real(int disks, unsigned long bytes, void **
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = disks - 3; /* Highest data disk */
> > @@ -433,13 +432,15 @@ static void raid6_rvv4_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*
> >        *v0:wp0,v1:wq0,v2:wd0/w20,v3:w10
> >        *v4:wp1,v5:wq1,v6:wd1/w21,v7:w11
> >        *v8:wp2,v9:wq2,v10:wd2/w22,v11:w12
> >        *v12:wp3,v13:wq3,v14:wd3/w23,v15:w13
> >        */
> > -     for (d = 0; d < bytes; d += NSIZE * 4) {
> > +     for (d = 0; d < bytes; d += nsize * 4) {
> >               /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -453,10 +454,10 @@ static void raid6_rvv4_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vmv.v.v  v13, v12\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE]),
> > -                           [wp1]"r"(&dptr[z0][d + 1 * NSIZE]),
> > -                           [wp2]"r"(&dptr[z0][d + 2 * NSIZE]),
> > -                           [wp3]"r"(&dptr[z0][d + 3 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize]),
> > +                           [wp1]"r"(&dptr[z0][d + 1 * nsize]),
> > +                           [wp2]"r"(&dptr[z0][d + 2 * nsize]),
> > +                           [wp3]"r"(&dptr[z0][d + 3 * nsize])
> >               );
> >
> >               for (z = z0 - 1; z >= 0; z--) {
> > @@ -504,10 +505,10 @@ static void raid6_rvv4_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                                     "vxor.vv  v12, v12, v14\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > -                                   [wd1]"r"(&dptr[z][d + 1 * NSIZE]),
> > -                                   [wd2]"r"(&dptr[z][d + 2 * NSIZE]),
> > -                                   [wd3]"r"(&dptr[z][d + 3 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> > +                                   [wd1]"r"(&dptr[z][d + 1 * nsize]),
> > +                                   [wd2]"r"(&dptr[z][d + 2 * nsize]),
> > +                                   [wd3]"r"(&dptr[z][d + 3 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -528,14 +529,14 @@ static void raid6_rvv4_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vse8.v   v13, (%[wq3])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0]),
> > -                           [wp1]"r"(&p[d + NSIZE * 1]),
> > -                           [wq1]"r"(&q[d + NSIZE * 1]),
> > -                           [wp2]"r"(&p[d + NSIZE * 2]),
> > -                           [wq2]"r"(&q[d + NSIZE * 2]),
> > -                           [wp3]"r"(&p[d + NSIZE * 3]),
> > -                           [wq3]"r"(&q[d + NSIZE * 3])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0]),
> > +                           [wp1]"r"(&p[d + nsize * 1]),
> > +                           [wq1]"r"(&q[d + nsize * 1]),
> > +                           [wp2]"r"(&p[d + nsize * 2]),
> > +                           [wq2]"r"(&q[d + nsize * 2]),
> > +                           [wp3]"r"(&p[d + nsize * 3]),
> > +                           [wq3]"r"(&q[d + nsize * 3])
> >               );
> >       }
> >   }
> > @@ -545,7 +546,7 @@ static void raid6_rvv4_xor_syndrome_real(int disks, int start, int stop,
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = stop;              /* P/Q right side optimization */
> > @@ -559,13 +560,15 @@ static void raid6_rvv4_xor_syndrome_real(int disks, int start, int stop,
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*
> >        *v0:wp0,v1:wq0,v2:wd0/w20,v3:w10
> >        *v4:wp1,v5:wq1,v6:wd1/w21,v7:w11
> >        *v8:wp2,v9:wq2,v10:wd2/w22,v11:w12
> >        *v12:wp3,v13:wq3,v14:wd3/w23,v15:w13
> >        */
> > -     for (d = 0; d < bytes; d += NSIZE * 4) {
> > +     for (d = 0; d < bytes; d += nsize * 4) {
> >                /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -579,10 +582,10 @@ static void raid6_rvv4_xor_syndrome_real(int disks, int start, int stop,
> >                             "vmv.v.v  v13, v12\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE]),
> > -                           [wp1]"r"(&dptr[z0][d + 1 * NSIZE]),
> > -                           [wp2]"r"(&dptr[z0][d + 2 * NSIZE]),
> > -                           [wp3]"r"(&dptr[z0][d + 3 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize]),
> > +                           [wp1]"r"(&dptr[z0][d + 1 * nsize]),
> > +                           [wp2]"r"(&dptr[z0][d + 2 * nsize]),
> > +                           [wp3]"r"(&dptr[z0][d + 3 * nsize])
> >               );
> >
> >               /* P/Q data pages */
> > @@ -631,10 +634,10 @@ static void raid6_rvv4_xor_syndrome_real(int disks, int start, int stop,
> >                                     "vxor.vv  v12, v12, v14\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > -                                   [wd1]"r"(&dptr[z][d + 1 * NSIZE]),
> > -                                   [wd2]"r"(&dptr[z][d + 2 * NSIZE]),
> > -                                   [wd3]"r"(&dptr[z][d + 3 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> > +                                   [wd1]"r"(&dptr[z][d + 1 * nsize]),
> > +                                   [wd2]"r"(&dptr[z][d + 2 * nsize]),
> > +                                   [wd3]"r"(&dptr[z][d + 3 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -713,14 +716,14 @@ static void raid6_rvv4_xor_syndrome_real(int disks, int start, int stop,
> >                             "vse8.v   v15, (%[wq3])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0]),
> > -                           [wp1]"r"(&p[d + NSIZE * 1]),
> > -                           [wq1]"r"(&q[d + NSIZE * 1]),
> > -                           [wp2]"r"(&p[d + NSIZE * 2]),
> > -                           [wq2]"r"(&q[d + NSIZE * 2]),
> > -                           [wp3]"r"(&p[d + NSIZE * 3]),
> > -                           [wq3]"r"(&q[d + NSIZE * 3])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0]),
> > +                           [wp1]"r"(&p[d + nsize * 1]),
> > +                           [wq1]"r"(&q[d + nsize * 1]),
> > +                           [wp2]"r"(&p[d + nsize * 2]),
> > +                           [wq2]"r"(&q[d + nsize * 2]),
> > +                           [wp3]"r"(&p[d + nsize * 3]),
> > +                           [wq3]"r"(&q[d + nsize * 3])
> >               );
> >       }
> >   }
> > @@ -729,7 +732,7 @@ static void raid6_rvv8_gen_syndrome_real(int disks, unsigned long bytes, void **
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = disks - 3; /* Highest data disk */
> > @@ -743,6 +746,8 @@ static void raid6_rvv8_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*
> >        *v0:wp0,v1:wq0,v2:wd0/w20,v3:w10
> >        *v4:wp1,v5:wq1,v6:wd1/w21,v7:w11
> > @@ -753,7 +758,7 @@ static void raid6_rvv8_gen_syndrome_real(int disks, unsigned long bytes, void **
> >        *v24:wp6,v25:wq6,v26:wd6/w26,v27:w16
> >        *v28:wp7,v29:wq7,v30:wd7/w27,v31:w17
> >        */
> > -     for (d = 0; d < bytes; d += NSIZE * 8) {
> > +     for (d = 0; d < bytes; d += nsize * 8) {
> >               /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -775,14 +780,14 @@ static void raid6_rvv8_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vmv.v.v  v29, v28\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE]),
> > -                           [wp1]"r"(&dptr[z0][d + 1 * NSIZE]),
> > -                           [wp2]"r"(&dptr[z0][d + 2 * NSIZE]),
> > -                           [wp3]"r"(&dptr[z0][d + 3 * NSIZE]),
> > -                           [wp4]"r"(&dptr[z0][d + 4 * NSIZE]),
> > -                           [wp5]"r"(&dptr[z0][d + 5 * NSIZE]),
> > -                           [wp6]"r"(&dptr[z0][d + 6 * NSIZE]),
> > -                           [wp7]"r"(&dptr[z0][d + 7 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize]),
> > +                           [wp1]"r"(&dptr[z0][d + 1 * nsize]),
> > +                           [wp2]"r"(&dptr[z0][d + 2 * nsize]),
> > +                           [wp3]"r"(&dptr[z0][d + 3 * nsize]),
> > +                           [wp4]"r"(&dptr[z0][d + 4 * nsize]),
> > +                           [wp5]"r"(&dptr[z0][d + 5 * nsize]),
> > +                           [wp6]"r"(&dptr[z0][d + 6 * nsize]),
> > +                           [wp7]"r"(&dptr[z0][d + 7 * nsize])
> >               );
> >
> >               for (z = z0 - 1; z >= 0; z--) {
> > @@ -862,14 +867,14 @@ static void raid6_rvv8_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                                     "vxor.vv  v28, v28, v30\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > -                                   [wd1]"r"(&dptr[z][d + 1 * NSIZE]),
> > -                                   [wd2]"r"(&dptr[z][d + 2 * NSIZE]),
> > -                                   [wd3]"r"(&dptr[z][d + 3 * NSIZE]),
> > -                                   [wd4]"r"(&dptr[z][d + 4 * NSIZE]),
> > -                                   [wd5]"r"(&dptr[z][d + 5 * NSIZE]),
> > -                                   [wd6]"r"(&dptr[z][d + 6 * NSIZE]),
> > -                                   [wd7]"r"(&dptr[z][d + 7 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> > +                                   [wd1]"r"(&dptr[z][d + 1 * nsize]),
> > +                                   [wd2]"r"(&dptr[z][d + 2 * nsize]),
> > +                                   [wd3]"r"(&dptr[z][d + 3 * nsize]),
> > +                                   [wd4]"r"(&dptr[z][d + 4 * nsize]),
> > +                                   [wd5]"r"(&dptr[z][d + 5 * nsize]),
> > +                                   [wd6]"r"(&dptr[z][d + 6 * nsize]),
> > +                                   [wd7]"r"(&dptr[z][d + 7 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -898,22 +903,22 @@ static void raid6_rvv8_gen_syndrome_real(int disks, unsigned long bytes, void **
> >                             "vse8.v   v29, (%[wq7])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0]),
> > -                           [wp1]"r"(&p[d + NSIZE * 1]),
> > -                           [wq1]"r"(&q[d + NSIZE * 1]),
> > -                           [wp2]"r"(&p[d + NSIZE * 2]),
> > -                           [wq2]"r"(&q[d + NSIZE * 2]),
> > -                           [wp3]"r"(&p[d + NSIZE * 3]),
> > -                           [wq3]"r"(&q[d + NSIZE * 3]),
> > -                           [wp4]"r"(&p[d + NSIZE * 4]),
> > -                           [wq4]"r"(&q[d + NSIZE * 4]),
> > -                           [wp5]"r"(&p[d + NSIZE * 5]),
> > -                           [wq5]"r"(&q[d + NSIZE * 5]),
> > -                           [wp6]"r"(&p[d + NSIZE * 6]),
> > -                           [wq6]"r"(&q[d + NSIZE * 6]),
> > -                           [wp7]"r"(&p[d + NSIZE * 7]),
> > -                           [wq7]"r"(&q[d + NSIZE * 7])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0]),
> > +                           [wp1]"r"(&p[d + nsize * 1]),
> > +                           [wq1]"r"(&q[d + nsize * 1]),
> > +                           [wp2]"r"(&p[d + nsize * 2]),
> > +                           [wq2]"r"(&q[d + nsize * 2]),
> > +                           [wp3]"r"(&p[d + nsize * 3]),
> > +                           [wq3]"r"(&q[d + nsize * 3]),
> > +                           [wp4]"r"(&p[d + nsize * 4]),
> > +                           [wq4]"r"(&q[d + nsize * 4]),
> > +                           [wp5]"r"(&p[d + nsize * 5]),
> > +                           [wq5]"r"(&q[d + nsize * 5]),
> > +                           [wp6]"r"(&p[d + nsize * 6]),
> > +                           [wq6]"r"(&q[d + nsize * 6]),
> > +                           [wp7]"r"(&p[d + nsize * 7]),
> > +                           [wq7]"r"(&q[d + nsize * 7])
> >               );
> >       }
> >   }
> > @@ -923,7 +928,7 @@ static void raid6_rvv8_xor_syndrome_real(int disks, int start, int stop,
> >   {
> >       u8 **dptr = (u8 **)ptrs;
> >       u8 *p, *q;
> > -     unsigned long vl, d;
> > +     unsigned long vl, d, nsize;
> >       int z, z0;
> >
> >       z0 = stop;              /* P/Q right side optimization */
> > @@ -937,6 +942,8 @@ static void raid6_rvv8_xor_syndrome_real(int disks, int start, int stop,
> >                     : "=&r" (vl)
> >       );
> >
> > +     nsize = vl;
> > +
> >       /*
> >        *v0:wp0,v1:wq0,v2:wd0/w20,v3:w10
> >        *v4:wp1,v5:wq1,v6:wd1/w21,v7:w11
> > @@ -947,7 +954,7 @@ static void raid6_rvv8_xor_syndrome_real(int disks, int start, int stop,
> >        *v24:wp6,v25:wq6,v26:wd6/w26,v27:w16
> >        *v28:wp7,v29:wq7,v30:wd7/w27,v31:w17
> >        */
> > -     for (d = 0; d < bytes; d += NSIZE * 8) {
> > +     for (d = 0; d < bytes; d += nsize * 8) {
> >                /* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
> >               asm volatile (".option  push\n"
> >                             ".option  arch,+v\n"
> > @@ -969,14 +976,14 @@ static void raid6_rvv8_xor_syndrome_real(int disks, int start, int stop,
> >                             "vmv.v.v  v29, v28\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&dptr[z0][d + 0 * NSIZE]),
> > -                           [wp1]"r"(&dptr[z0][d + 1 * NSIZE]),
> > -                           [wp2]"r"(&dptr[z0][d + 2 * NSIZE]),
> > -                           [wp3]"r"(&dptr[z0][d + 3 * NSIZE]),
> > -                           [wp4]"r"(&dptr[z0][d + 4 * NSIZE]),
> > -                           [wp5]"r"(&dptr[z0][d + 5 * NSIZE]),
> > -                           [wp6]"r"(&dptr[z0][d + 6 * NSIZE]),
> > -                           [wp7]"r"(&dptr[z0][d + 7 * NSIZE])
> > +                           [wp0]"r"(&dptr[z0][d + 0 * nsize]),
> > +                           [wp1]"r"(&dptr[z0][d + 1 * nsize]),
> > +                           [wp2]"r"(&dptr[z0][d + 2 * nsize]),
> > +                           [wp3]"r"(&dptr[z0][d + 3 * nsize]),
> > +                           [wp4]"r"(&dptr[z0][d + 4 * nsize]),
> > +                           [wp5]"r"(&dptr[z0][d + 5 * nsize]),
> > +                           [wp6]"r"(&dptr[z0][d + 6 * nsize]),
> > +                           [wp7]"r"(&dptr[z0][d + 7 * nsize])
> >               );
> >
> >               /* P/Q data pages */
> > @@ -1057,14 +1064,14 @@ static void raid6_rvv8_xor_syndrome_real(int disks, int start, int stop,
> >                                     "vxor.vv  v28, v28, v30\n"
> >                                     ".option  pop\n"
> >                                     : :
> > -                                   [wd0]"r"(&dptr[z][d + 0 * NSIZE]),
> > -                                   [wd1]"r"(&dptr[z][d + 1 * NSIZE]),
> > -                                   [wd2]"r"(&dptr[z][d + 2 * NSIZE]),
> > -                                   [wd3]"r"(&dptr[z][d + 3 * NSIZE]),
> > -                                   [wd4]"r"(&dptr[z][d + 4 * NSIZE]),
> > -                                   [wd5]"r"(&dptr[z][d + 5 * NSIZE]),
> > -                                   [wd6]"r"(&dptr[z][d + 6 * NSIZE]),
> > -                                   [wd7]"r"(&dptr[z][d + 7 * NSIZE]),
> > +                                   [wd0]"r"(&dptr[z][d + 0 * nsize]),
> > +                                   [wd1]"r"(&dptr[z][d + 1 * nsize]),
> > +                                   [wd2]"r"(&dptr[z][d + 2 * nsize]),
> > +                                   [wd3]"r"(&dptr[z][d + 3 * nsize]),
> > +                                   [wd4]"r"(&dptr[z][d + 4 * nsize]),
> > +                                   [wd5]"r"(&dptr[z][d + 5 * nsize]),
> > +                                   [wd6]"r"(&dptr[z][d + 6 * nsize]),
> > +                                   [wd7]"r"(&dptr[z][d + 7 * nsize]),
> >                                     [x1d]"r"(0x1d)
> >                       );
> >               }
> > @@ -1195,22 +1202,22 @@ static void raid6_rvv8_xor_syndrome_real(int disks, int start, int stop,
> >                             "vse8.v   v31, (%[wq7])\n"
> >                             ".option  pop\n"
> >                             : :
> > -                           [wp0]"r"(&p[d + NSIZE * 0]),
> > -                           [wq0]"r"(&q[d + NSIZE * 0]),
> > -                           [wp1]"r"(&p[d + NSIZE * 1]),
> > -                           [wq1]"r"(&q[d + NSIZE * 1]),
> > -                           [wp2]"r"(&p[d + NSIZE * 2]),
> > -                           [wq2]"r"(&q[d + NSIZE * 2]),
> > -                           [wp3]"r"(&p[d + NSIZE * 3]),
> > -                           [wq3]"r"(&q[d + NSIZE * 3]),
> > -                           [wp4]"r"(&p[d + NSIZE * 4]),
> > -                           [wq4]"r"(&q[d + NSIZE * 4]),
> > -                           [wp5]"r"(&p[d + NSIZE * 5]),
> > -                           [wq5]"r"(&q[d + NSIZE * 5]),
> > -                           [wp6]"r"(&p[d + NSIZE * 6]),
> > -                           [wq6]"r"(&q[d + NSIZE * 6]),
> > -                           [wp7]"r"(&p[d + NSIZE * 7]),
> > -                           [wq7]"r"(&q[d + NSIZE * 7])
> > +                           [wp0]"r"(&p[d + nsize * 0]),
> > +                           [wq0]"r"(&q[d + nsize * 0]),
> > +                           [wp1]"r"(&p[d + nsize * 1]),
> > +                           [wq1]"r"(&q[d + nsize * 1]),
> > +                           [wp2]"r"(&p[d + nsize * 2]),
> > +                           [wq2]"r"(&q[d + nsize * 2]),
> > +                           [wp3]"r"(&p[d + nsize * 3]),
> > +                           [wq3]"r"(&q[d + nsize * 3]),
> > +                           [wp4]"r"(&p[d + nsize * 4]),
> > +                           [wq4]"r"(&q[d + nsize * 4]),
> > +                           [wp5]"r"(&p[d + nsize * 5]),
> > +                           [wq5]"r"(&q[d + nsize * 5]),
> > +                           [wp6]"r"(&p[d + nsize * 6]),
> > +                           [wq6]"r"(&q[d + nsize * 6]),
> > +                           [wp7]"r"(&p[d + nsize * 7]),
> > +                           [wq7]"r"(&q[d + nsize * 7])
> >               );
> >       }
> >   }
> > diff --git a/lib/raid6/rvv.h b/lib/raid6/rvv.h
> > index 94044a1b707b..6d0708a2c8a4 100644
> > --- a/lib/raid6/rvv.h
> > +++ b/lib/raid6/rvv.h
> > @@ -7,6 +7,23 @@
> >    * Definitions for RISC-V RAID-6 code
> >    */
> >
> > +#ifdef __KERNEL__
> > +#include <asm/vector.h>
> > +#else
> > +#define kernel_vector_begin()
> > +#define kernel_vector_end()
> > +#include <sys/auxv.h>
> > +#include <asm/hwcap.h>
> > +#define has_vector() (getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V)
> > +#endif
> > +
> > +#include <linux/raid/pq.h>
> > +
> > +static int rvv_has_vector(void)
> > +{
> > +     return has_vector();
> > +}
> > +
> >   #define RAID6_RVV_WRAPPER(_n)                                               \
> >       static void raid6_rvv ## _n ## _gen_syndrome(int disks,         \
> >                                       size_t bytes, void **ptrs)      \
>
>
> Otherwise, looks good:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,
Chunyan

