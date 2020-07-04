Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72B3214260
	for <lists+linux-raid@lfdr.de>; Sat,  4 Jul 2020 02:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGDAcz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jul 2020 20:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGDAcy (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 3 Jul 2020 20:32:54 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8E8720782
        for <linux-raid@vger.kernel.org>; Sat,  4 Jul 2020 00:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593822774;
        bh=qIHwPCY1qQO1vaprEp6D+fffHpq0G/JX7kz/YWiTq3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PL7N/bL77cjpJ508g0QXDv2gU8W18VyECvhR6KQAMcU85aT3a3vqhisIl9JUJJQMW
         4ECvdPRpLBo6GquONVx2sd/gVnjy8eTz3ztm+1hhRN8cEidG3rT5HDFWsZ3BDBqS4K
         15hvlbmaYlbg192CQzjkKZNEwqf9tV4Dx1d67vtQ=
Received: by mail-lf1-f49.google.com with SMTP id m26so19442148lfo.13
        for <linux-raid@vger.kernel.org>; Fri, 03 Jul 2020 17:32:53 -0700 (PDT)
X-Gm-Message-State: AOAM530o38VeD3FgB0LC0ZHvmV1U1k1DsWTIHfbjH+VMN0ykvPWVbxVT
        rggJ1HTwi0ds+aEQNer2A4wLh3UPWOZS7ixxPSs=
X-Google-Smtp-Source: ABdhPJz0e0fqF+q92xHMGL6JICS6Q7lXSp8AosNe9idMtOOiAAoo5V3RtQC+i8lgW9fu/leK+irpzH7ypsaOPh202w8=
X-Received: by 2002:a19:7e09:: with SMTP id z9mr23466521lfc.69.1593822772002;
 Fri, 03 Jul 2020 17:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200703091309.19955-1-artur.paszkiewicz@intel.com> <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com>
In-Reply-To: <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jul 2020 17:32:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
Message-ID: <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
Subject: Re: [PATCH v4] md: improve io stats accounting
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jul 3, 2020 at 2:27 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Looks good, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Thanks,
> Guoqing
>
> On 7/3/20 11:13 AM, Artur Paszkiewicz wrote:
> > Use generic io accounting functions to manage io stats. There was an
> > attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
> > stats accounting functions to simplify io stat accounting"), but it did
> > not include a call to generic_end_io_acct() and caused issues with
> > tracking in-flight IOs, so it was later removed in commit 74672d069b29
> > ("md: fix md io stats accounting broken").
> >
> > This patch attempts to fix this by using both disk_start_io_acct() and
> > disk_end_io_acct(). To make it possible, a struct md_io is allocated for
> > every new md bio, which includes the io start_time. A new mempool is
> > introduced for this purpose. We override bio->bi_end_io with our own
> > callback and call disk_start_io_acct() before passing the bio to
> > md_handle_request(). When it completes, we call disk_end_io_acct() and
> > the original bi_end_io callback.
> >
> > This adds correct statistics about in-flight IOs and IO processing time,
> > interpreted e.g. in iostat as await, svctm, aqu-sz and %util.
> >
> > It also fixes a situation where too many IOs where reported if a bio was
> > re-submitted to the mddev, because io accounting is now performed only
> > on newly arriving bios.
> >
> > Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

Applied to md-next. Thanks!
