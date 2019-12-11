Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A437A11BC7D
	for <lists+linux-raid@lfdr.de>; Wed, 11 Dec 2019 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfLKTGo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 14:06:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44364 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfLKTGo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Dec 2019 14:06:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id g17so7202676qtp.11
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3L+Oghf2+OyZA+eMhocqY8hRsRfwxbo9+zunliTVuRU=;
        b=ZbyXoJsoNJeCUfgok51+Y0HNBogRtu1tUG6BpGunX1FundwA7BSo83OrPS/HWTYcKi
         Mgy8TVegJXGYj8TREDp1Vh0WbjhhRbEod3meffoopwMf4Ru45xYPjwepjJ2GjkiOo3Sc
         wggGqMSudlwE9jHJWmiIsvWSp3q7bkUlPnPPYGk8eKDr1aGPsYbO210ihmhE96NWRq88
         egMr9ppgkkP45lciFzkQdFekOwZAQryJT6cxjtLb0JqaXAgupFHT3So0IYW8MMgF7Gii
         uu6MeGE7SLI/jjeBl9idlw0MqBnyhl9qYvstNjKGgj74d8XS5SzvPlqOb/AV7HKLRgmD
         tWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3L+Oghf2+OyZA+eMhocqY8hRsRfwxbo9+zunliTVuRU=;
        b=Wit6VzAhA04Pwf4z2P5Ne41EwpQpeHlkq8j5smSODF8Tuvci5iiyd3MoyFvtlc7APQ
         UPde+sbhVPNk12URxMHrqDAzDZYJwkYT2XypDXXFiUkEjuRfefk1n4T7/gkHq923FhxB
         0lkKrlir2Ju0Gwc1chx+mAccM1kWosLAmTFrDlq9lBlOfyLhGlABrsCQPTVKm2dbgV/n
         4rbZQ3Ntq5Z8TTfAmFxoNYUV+CGVWX+JPB8N1pIGYG12XByz1zbfqKZ3BAE5NkICcm2I
         qBZVT8+1J2v567DfaWL3Jql3SrHD2x7u7w/U+GL/2fS94/tQqDtPjJQ0uYcUyZtzKG+K
         KOxQ==
X-Gm-Message-State: APjAAAU+BollBUk2trNPn63/nmMIxVWWdGgHJmHduFlqWHH11iMhsgPQ
        yGf77bssYnwfxfl0lAOFqMU/7+yVb6P4nVVMqBU=
X-Google-Smtp-Source: APXvYqzdC7yQ9lAnZiXzeDVA34zY0aFcBFX3YJcjfJ2Hxs9j+h/mfYjddIN345uQwyixOQMyZNB+5IOIRhdhJUX5wv4=
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr4140365qtv.308.1576091203793;
 Wed, 11 Dec 2019 11:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20191205031318.7098-1-liuzhengyuan@kylinos.cn> <CAPhsuW4XhQHf_eyQQszw9jhZCrr6Y0=JFSyk-=k+BbKRjorrNg@mail.gmail.com>
In-Reply-To: <CAPhsuW4XhQHf_eyQQszw9jhZCrr6Y0=JFSyk-=k+BbKRjorrNg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Dec 2019 11:06:32 -0800
Message-ID: <CAPhsuW6LDnv9R=GSsT7vDOmcZYz5Ku0wdJCd6S7AeqOpQRdTKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] raid6/test: fix the compilation error and warning
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-raid <linux-raid@vger.kernel.org>, hpa@zytor.com,
        liuzhengyuang521@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Dec 11, 2019 at 11:04 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Wed, Dec 4, 2019 at 7:13 PM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
> >
> > The compilation error of redeclaration was indroduced by commit 54d50897d54
> > ("linux/kernel.h: split *_MAX and *_MIN macros into <linux/limits.h>"). Fix
>
> Please add a Fixes tag.
Please also include the error message in the change log for reference.

Thanks,
Song
