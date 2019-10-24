Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861ECE3FC3
	for <lists+linux-raid@lfdr.de>; Fri, 25 Oct 2019 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbfJXW4Q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 18:56:16 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41236 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbfJXW4Q (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 24 Oct 2019 18:56:16 -0400
Received: by mail-qk1-f173.google.com with SMTP id p10so14520qkg.8
        for <linux-raid@vger.kernel.org>; Thu, 24 Oct 2019 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3sxMe8r5j1HP72PhsV+QBASxR6tl7O7yvgQyieLvN8=;
        b=dkNF5uxs4A3DskontcXsLY2pzlEGwUWFD0EhwBQsL8Gmd467cgXaZxrFETRU0yxRfp
         n6a4QRdm8+38dzoWMl1BLOLWcsBXm1+KFXi4sMd1RlXgrhgPiVm57cZIIldwVlZbwWk/
         Me/JjSikJcczYllM0HjgqGOgHihNyuLxDErqyWNBTcS66I+1IRh9wka5UO0L7KTBNXZu
         T5xljslhsKeXYI5r7TmCu0Bz6EBBY412K3wXX+8zl2em3fc2WaW4EIpVABDPZvcfe2fE
         CepIHdzGqq8c7YIc6fqajuxmTO7sisg2oks9I2UGSBWPZu1mA9RTm9tmcwuaKO/rW/Tj
         ABsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3sxMe8r5j1HP72PhsV+QBASxR6tl7O7yvgQyieLvN8=;
        b=eAinctQqM9LjZxfy+K91V2zqEo2aiabkQpFGC2RmsFgrFkBERIJk1XXODKtsydq9TM
         1yGvP36p/z0XpnHf4Nhnu7b8xJtuoJWZvlydIRBKQ2MeeDuonrEt6KSjGLfdIF5F5IJh
         jFiXsDfiS8DyPXm+mAOlRvJzSyqZbbYT5wGrgxgMmPM3h5uPvWuM94VyJXkCP0i7n7P3
         W+NssylhxF2hBDLpaOcMLemnasXebnXHwajYnYlkdW0YaUScAHEiqsMpKWiwU+Qr41b9
         tVumX1/DrAqe5mlr70pH6u2x+ed0v+sBBlo04ll70hFzp05GGznpsnBZQ8D/ltd78GGR
         Y4dA==
X-Gm-Message-State: APjAAAWDV3ypyHN44PUgtaLz8Jf66oBBiqN3SpSM9ukChPj0t94JP7CU
        yzx1uYWAza8AACvHxspSsDbiLHnL44ZfzCbN7T4=
X-Google-Smtp-Source: APXvYqwW5N4r51v3UkXKaFp1vhyQ3SM9audOYj6M1y+ah11Xb8agWxlzCqzJxzxlgnzHYMnQ0qVAZQgid7EwJD4IgoQ=
X-Received: by 2002:a37:553:: with SMTP id 80mr151198qkf.353.1571957775205;
 Thu, 24 Oct 2019 15:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <25373b220163b01b8990aa049fec9d18@iki.fi> <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi>
In-Reply-To: <f1de00a04761370d90018f288b9b2996@iki.fi>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 24 Oct 2019 15:56:04 -0700
Message-ID: <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Oct 24, 2019 at 12:42 PM Anssi Hannula <anssi.hannula@iki.fi> wrote:
>
> Song Liu kirjoitti 2019-10-24 21:50:
> > Sorry for delayed reply.
>
> No problem :)
>
> > On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi>
> > wrote:
> >>
> >> Hi all,
> >>
> >> I'm seeing a reshape issue where the array gets stuck with requests
> >> seemingly getting blocked and md0_raid6 process taking 100% CPU
> >> whenever
> >> I --continue the reshape.
> >>
> >>  From what I can tell, the md0_raid6 process is stuck processing a set
> >> of
> >> stripes over and over via handle_stripe() without progressing.
> >>
> >> Log excerpt of one handle_stripe() of an affected stripe with some
> >> extra
> >> logging is below.
> >> The 4600-5200 integers are line numbers for
> >> http://onse.fi/files/reshape-infloop-issue/raid5.c .
> >
> > Maybe add sh->sector to DEBUGPRINT()?
>
> Note that the XX debug printing was guarded by
>
>   bool debout = (sh->sector == 198248960) && __ratelimit(&_rsafasfas);
>
> So everything was for sector 198248960 and rate limited every 20sec to
> avoid a flood.
>
> > Also, please add more DEBUGPRINT() in the
> >
> > if (sh->reconstruct_state == reconstruct_state_result) {
> >
> > case.
>
> OK, added prints there.
>
> Though after logging I noticed that the execution never gets there,
> sh->reconstruct_state is always reconstruct_state_idle at that point.
> It gets cleared on the "XX too many failed" log message (line 4798).
>
I guess the failed = 10 is the problem here..

What does /proc/mdstat say?

Thanks,
Song
