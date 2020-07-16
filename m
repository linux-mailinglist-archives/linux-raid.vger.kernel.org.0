Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03EB2229F2
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGPRaO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 13:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGPRaO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 13:30:14 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37152071B
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594920613;
        bh=8wvesQVPSRZYfYW6PRos6ZhTe0nDhiYWmscVCDvRbl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAM9M0blzbh8GPHdsigvRx0/kFgLTmKv8X+SU+NXwTSbdFOTiGmIHgJf/z5SznN48
         isK1fBKT5CEz2w+kecB7hjpvKxcjOKGJQva0FQeAmpriB9Gbpa49l7U1L8dr6RUwjN
         KliA5hPAYV31o6IX1WRu/HqKVPzODhak55opLi40=
Received: by mail-lj1-f170.google.com with SMTP id j11so8882247ljo.7
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 10:30:12 -0700 (PDT)
X-Gm-Message-State: AOAM533NiL6KRaIpIQRm0k84ZT943qK0LypecaFBAYaqX7g72XLHY/Tv
        g/LxBKQ4MPNbLtfS5dz60OGowxu98SFmC2CKfng=
X-Google-Smtp-Source: ABdhPJxKeDxMxBM4AmlB8jNtCrio5gKqQfLxcBu+wxhSLicwOADrlWQu4BoiO1qPjFiFj2T4xSBnsITRktoD8lrivVo=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr2594838ljk.27.1594920611310;
 Thu, 16 Jul 2020 10:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
 <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com> <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
In-Reply-To: <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 16 Jul 2020 10:29:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6HjN0hZ8E998XBpg+WxP5uhZO0on-M-tQ45kpFO5XHqg@mail.gmail.com>
Message-ID: <CAPhsuW6HjN0hZ8E998XBpg+WxP5uhZO0on-M-tQ45kpFO5XHqg@mail.gmail.com>
Subject: Re: [PATCH v4] md: improve io stats accounting
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jul 3, 2020 at 5:32 PM Song Liu <song@kernel.org> wrote:
>
> On Fri, Jul 3, 2020 at 2:27 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
> >
> > Looks good, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> > Thanks,
> > Guoqing
> >
> > On 7/3/20 11:13 AM, Artur Paszkiewicz wrote:
> > > Use generic io accounting functions to manage io stats. There was an
> > > attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
> > > stats accounting functions to simplify io stat accounting"), but it did
> > > not include a call to generic_end_io_acct() and caused issues with
> > > tracking in-flight IOs, so it was later removed in commit 74672d069b29
> > > ("md: fix md io stats accounting broken").
> > >
> > > This patch attempts to fix this by using both disk_start_io_acct() and
> > > disk_end_io_acct(). To make it possible, a struct md_io is allocated for
> > > every new md bio, which includes the io start_time. A new mempool is
> > > introduced for this purpose. We override bio->bi_end_io with our own
> > > callback and call disk_start_io_acct() before passing the bio to
> > > md_handle_request(). When it completes, we call disk_end_io_acct() and
> > > the original bi_end_io callback.
> > >
> > > This adds correct statistics about in-flight IOs and IO processing time,
> > > interpreted e.g. in iostat as await, svctm, aqu-sz and %util.
> > >
> > > It also fixes a situation where too many IOs where reported if a bio was
> > > re-submitted to the mddev, because io accounting is now performed only
> > > on newly arriving bios.
> > >
> > > Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
>
> Applied to md-next. Thanks!

I just noticed another issue with this work on raid456, as iostat
shows something
like:

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
nvme0n1        6306.50 18248.00  636.00 1280.00    45.11    76.19
129.65     3.03    1.23    0.67    1.51   0.76 145.50
nvme1n1       11441.50 13234.00 1069.50  961.00    71.87    55.39
128.35     3.32    1.30    0.90    1.75   0.72 146.50
nvme2n1        8280.50 16352.50  971.50 1231.00    65.53    68.65
124.77     3.20    1.17    0.69    1.54   0.64 142.00
nvme3n1        6158.50 18199.50  567.00 1453.50    39.81    76.74
118.13     3.50    1.40    0.88    1.60   0.73 146.50
md0               0.00     0.00 1436.00 1411.00    89.75    88.19
128.00    22.98    8.07    0.16   16.12   0.52 147.00

md0 here is a RAID-6 array with 4 devices. %util of > 100% is clearly
wrong here.
This only doesn't happen to RAID-0 or RAID-1 in my tests.

Artur, could you please take a look at this?

Thanks,
Song
