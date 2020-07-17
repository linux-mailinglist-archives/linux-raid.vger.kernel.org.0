Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2005A22473B
	for <lists+linux-raid@lfdr.de>; Sat, 18 Jul 2020 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGQXtx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 19:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGQXtw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jul 2020 19:49:52 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32B62074B
        for <linux-raid@vger.kernel.org>; Fri, 17 Jul 2020 23:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595029792;
        bh=b0R3pRqInnmghQDW4268znQgCoi2fnMbPcDVvJf5ThU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UHzAWIYvyLHuvSme2zWgwB9hSFYUI4o7Vg9KxqxD93it7In6KtqTukWyN2+mJxyWO
         VsxSqgoT6kw96faFCb8sj2/GKW8fs+7WkNksQbUPzzFBTUUrQbXMnc90Ieto/3IE/+
         LqwW/+FVJ7idgrtgfZUg3HmbH1pbfuBHGzzT/Wzw=
Received: by mail-lj1-f171.google.com with SMTP id q7so14642261ljm.1
        for <linux-raid@vger.kernel.org>; Fri, 17 Jul 2020 16:49:51 -0700 (PDT)
X-Gm-Message-State: AOAM532PBslS5Jm+/6ICqk9YwfvwbJ/8CcCt6z/9Dz2oHSvk408raWh2
        h7bmykW4bVwXQkCKbzNO01WcJL86VI0MfKrN7eg=
X-Google-Smtp-Source: ABdhPJxTYs3XtHGBbJcfGWL+PGccROJ1RO+BaeuBuDTtwORcLpWw2zFhxPzeXIHYfqTqhFtG+JHbm/GSXPf5sziaOfE=
X-Received: by 2002:a2e:b175:: with SMTP id a21mr5475751ljm.10.1595029789980;
 Fri, 17 Jul 2020 16:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
 <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com> <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
 <CAPhsuW6HjN0hZ8E998XBpg+WxP5uhZO0on-M-tQ45kpFO5XHqg@mail.gmail.com> <db93b8ae-25a1-5b50-7360-1f9c8e0661c3@intel.com>
In-Reply-To: <db93b8ae-25a1-5b50-7360-1f9c8e0661c3@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 17 Jul 2020 16:49:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7a2cAmBcgyineR3DoAht5=BoSDWHYh2gLJ6ur1+rshyQ@mail.gmail.com>
Message-ID: <CAPhsuW7a2cAmBcgyineR3DoAht5=BoSDWHYh2gLJ6ur1+rshyQ@mail.gmail.com>
Subject: Re: [PATCH v4] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jul 17, 2020 at 3:44 AM Artur Paszkiewicz
<artur.paszkiewicz@intel.com> wrote:
>
> On 7/16/20 7:29 PM, Song Liu wrote:
> > I just noticed another issue with this work on raid456, as iostat
> > shows something
> > like:
> >
> > Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
> > avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> > nvme0n1        6306.50 18248.00  636.00 1280.00    45.11    76.19
> > 129.65     3.03    1.23    0.67    1.51   0.76 145.50
> > nvme1n1       11441.50 13234.00 1069.50  961.00    71.87    55.39
> > 128.35     3.32    1.30    0.90    1.75   0.72 146.50
> > nvme2n1        8280.50 16352.50  971.50 1231.00    65.53    68.65
> > 124.77     3.20    1.17    0.69    1.54   0.64 142.00
> > nvme3n1        6158.50 18199.50  567.00 1453.50    39.81    76.74
> > 118.13     3.50    1.40    0.88    1.60   0.73 146.50
> > md0               0.00     0.00 1436.00 1411.00    89.75    88.19
> > 128.00    22.98    8.07    0.16   16.12   0.52 147.00
> >
> > md0 here is a RAID-6 array with 4 devices. %util of > 100% is clearly
> > wrong here.
> > This only doesn't happen to RAID-0 or RAID-1 in my tests.
> >
> > Artur, could you please take a look at this?
>
> Hi Song,
>
> I think it's not caused by this patch, because %util of the member
> drives is affected as well. I reverted the patch and it's still
> happening:
>
> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
> md0             20.00      2.50     0.00   0.00    0.00   128.00   21.00      2.62     0.00   0.00    0.00   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
> nvme0n1         13.00      1.62   279.00  95.55    0.77   128.00    4.00      0.50   372.00  98.94 1289.00   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    5.17 146.70
> nvme1n1         15.00      1.88   310.00  95.38    0.53   128.00   21.00      2.62   341.00  94.20 1180.29   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   24.80 146.90
> nvme2n1         16.00      2.00   310.00  95.09    0.69   128.00   19.00      2.38   341.00  94.72  832.89   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   15.84 146.80
> nvme3n1         18.00      2.25   403.00  95.72    0.72   128.00   16.00      2.00   248.00  93.94  765.69   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   12.26 114.30
>
> I was only able to reproduce it on a VM, it doesn't occur on real
> hardware (for me). What was your test configuration?

I was testing on VM. But I didn't see this issue after reverting the
patch. Let me
test more.

Thanks,
Song


> Thanks,
> Artur
