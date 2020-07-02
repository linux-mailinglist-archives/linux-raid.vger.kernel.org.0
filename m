Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC29212ECB
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGBVZj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 17:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgGBVZj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 17:25:39 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA9B520885
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593725139;
        bh=Zzm4Gg40LuYSdejYBlczS0MveO6I7wze+tZWAoZM3ZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BjNJnARmvxPw4UuF/JsR7EWFNtO3meObwekWnrLw9kIlIRv6FxYLQYFoEJsVCtN4w
         EAB8ous9VB51uX+aHH9gba36YuYZAN3gU+7A0J+PRjunDcMplkWOz+1MHtnsuaDXsy
         b/wrRbzc95U1Z+dcKbp5jdkHn0pZJpCQK8eImwo0=
Received: by mail-lj1-f175.google.com with SMTP id n23so34129976ljh.7
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 14:25:38 -0700 (PDT)
X-Gm-Message-State: AOAM531ArdyuMp6+scoF0RMDKbY3belWrYG5rIYZiRdX3jdo5zN7Pwpk
        Aot0+jsB3fVaT5ENlsq9YZpyWmq2j33A1Gmfiyg=
X-Google-Smtp-Source: ABdhPJwcKnvVm4IAxh6nUsn97QY39sVAgggAJ1N4bU4q9WJrBxoUedxh0quZKkfyd+Qfb51l+0ljz4hfBRe3EPF7F3A=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr18013001ljk.273.1593725137305;
 Thu, 02 Jul 2020 14:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200702142926.4419-1-artur.paszkiewicz@intel.com>
In-Reply-To: <20200702142926.4419-1-artur.paszkiewicz@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 14:25:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5eMPMH1HcMXi67Ci0rbWhVyiuLodVZB_oaGbrR7abTJQ@mail.gmail.com>
Message-ID: <CAPhsuW5eMPMH1HcMXi67Ci0rbWhVyiuLodVZB_oaGbrR7abTJQ@mail.gmail.com>
Subject: Re: [PATCH v3] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jul 2, 2020 at 7:29 AM Artur Paszkiewicz
<artur.paszkiewicz@intel.com> wrote:
>
> Use generic io accounting functions to manage io stats. There was an
> attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
> stats accounting functions to simplify io stat accounting"), but it did
> not include a call to generic_end_io_acct() and caused issues with
> tracking in-flight IOs, so it was later removed in commit 74672d069b29
> ("md: fix md io stats accounting broken").
>
> This patch attempts to fix this by using both bio_start_io_acct() and
> bio_end_io_acct(). To make it possible, a struct md_io is allocated for
> every new md bio, which includes the io start_time. A new mempool is
> introduced for this purpose. We override bio->bi_end_io with our own
> callback and call bio_start_io_acct() before passing the bio to
> md_handle_request(). When it completes, we call bio_end_io_acct() and
> the original bi_end_io callback.
>
> This adds correct statistics about in-flight IOs and IO processing time,
> interpreted e.g. in iostat as await, svctm, aqu-sz and %util.
>
> It also fixes a situation where too many IOs where reported if a bio was
> re-submitted to the mddev, because io accounting is now performed only
> on newly arriving bios.
>
> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

Thanks Artur and Guoqing!

I run quick test with this. Seems it only adds proper statistics to
raid5 array, but
not to raid0 array. Is this expected?

Song

[...]
