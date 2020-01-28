Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5314BF20
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jan 2020 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA1SEP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jan 2020 13:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1SEO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jan 2020 13:04:14 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCC322522
        for <linux-raid@vger.kernel.org>; Tue, 28 Jan 2020 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580234654;
        bh=MP+R/Zov678VqWsHKV3RvXEUXFrOM/ceRE+7s1iGBmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C9htH62qUnHV/jl2K+q16Jx9hComTeiBQLjROyLXTokmMEMRgkJ7opGO7s6EXQR3S
         SI2glkoK0OhsVYOtVCU7Azm3AO+m+52hzbcOygSp24qwuZCfQPUoZPl6OKKp+rVdg2
         mqO5IAODBc/7lDW3u8YfeTQf1CYcD3W4iF/6qZGE=
Received: by mail-lj1-f173.google.com with SMTP id x14so13297428ljd.13
        for <linux-raid@vger.kernel.org>; Tue, 28 Jan 2020 10:04:13 -0800 (PST)
X-Gm-Message-State: APjAAAUoGm9rnkvrE55RtsD/2KPwepw9qPkUi16mLO3IlNrMEUeGUfLh
        i1HbZOQ4QfiWccOVvHxJqe58aioV25/HYRqXjxc=
X-Google-Smtp-Source: APXvYqx/lY3J/G84B+4I3NDopSxvrwySdkhYxtZ9JfLsxIRcfF0xBrbQWSbqDMdh5yw3WC0nxWpW+VP4lBJlw3s6Gfk=
X-Received: by 2002:a2e:9183:: with SMTP id f3mr13932883ljg.64.1580234651671;
 Tue, 28 Jan 2020 10:04:11 -0800 (PST)
MIME-Version: 1.0
References: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
 <CAPhsuW4Jc-qef9uW-JSut90qOpDc_4VoAFpMU8KwqnK7EeT_xg@mail.gmail.com> <ac3ae81d-8dad-8b4e-bc61-fc37514e3929@icdsoft.com>
In-Reply-To: <ac3ae81d-8dad-8b4e-bc61-fc37514e3929@icdsoft.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jan 2020 10:04:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4JJiDroE33m0=XE9PxtUOncK3--waY_zxxbAT9j+1m6g@mail.gmail.com>
Message-ID: <CAPhsuW4JJiDroE33m0=XE9PxtUOncK3--waY_zxxbAT9j+1m6g@mail.gmail.com>
Subject: Re: Pausing md check hangs
To:     Georgi Nikolov <gnikolov@icdsoft.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jan 28, 2020 at 12:11 AM Georgi Nikolov <gnikolov@icdsoft.com> wrote:
>
> Yes the kernel is 4.19.67-2+deb10u2. I have tried with 5.4.8-1~bpo10+1
> and same thing happened.
> Before this i have used same thing for a long time with kernel 4.9.189-3.
> It happens most often when there is some heavy IO.

Thanks for the information. I suspect the hang is waiting for md_lock().

Could you please dump the mdX_raid6 stack when the hang happens?
You can do it by:

    cat /proc/$(pidof mdX_raid6)/stack

Thanks,
Song
