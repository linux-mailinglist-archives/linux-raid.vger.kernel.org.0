Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F608F625
	for <lists+linux-raid@lfdr.de>; Thu, 15 Aug 2019 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfHOVCl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 15 Aug 2019 17:02:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37797 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOVCl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 15 Aug 2019 17:02:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so3854210qto.4
        for <linux-raid@vger.kernel.org>; Thu, 15 Aug 2019 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXbhT7KJ8wU6jUdyNEpsuiRjaO59R696+ysrWt0P0R0=;
        b=JtEWRWMZSGOGJhtgvuzjqceZbx/1IZTlbAa/kkw0v3KqZ8U2owFCTftoqjOgzNbChv
         uL2fsNPLWXuZoZsEVEoA/0jM2DaRk886OXiqNuptbHREqz05jcPxgVkdJHEBtmWCLx23
         qQbfNMl0tMcy3Rwo1MPHkHHZBtOAz9IWWYLCnKRJT7Rgwp5m6yMytJW/cj45QmVKRG0a
         hc4uFx/IF0pRh/t5R7enx6YnXj/MTHDz2pG00Zxbfu3xJCuLEKmVSnwY4HEjJ4rlYtOL
         pMLDpVydJsAoLkPVAheViPqrX1JXixnc6bhxqKnBy62CZlOvZHAdEy1I4fBA7Jn5uZwl
         Jkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXbhT7KJ8wU6jUdyNEpsuiRjaO59R696+ysrWt0P0R0=;
        b=M+1hHGy9s9Mhe1Ne03vfquvjVEwv8TRMDbRiTYOxf84Qe1jBAOV8xont8AP7y3WrLx
         WtQa0y+Xy5d/nKlGGufCM0+HuhF0z69SSdH0mKMH5MlyVMsmLjpiY005mV6XqnKqpNTS
         csMpBvZ1HNXxy59zsGBz9d6wiNl3xa923uNySmylOdEFNw0qXjkVeSbqgdvctJXTxRSb
         wrIKdEJOnGUljSndqPJqS7jj4PenqxatYAHpIWBd9ERrZGq7G9TRyIaDV1BSCZUqRzcE
         lRW/Z9vtev/a/GqioFkfmtswflLnXuamyRX8uOM3Zu6tjhcEiMaHYz7gNttvmro5oC+y
         y+mw==
X-Gm-Message-State: APjAAAWnFCmtMTA7HvN+LMJYx8alG2Q4d5Npco6u9X1sO183/FY131sz
        QadwyoKMBRumfdRH+vcBqdyYY7kpLCzZkD2VvHA=
X-Google-Smtp-Source: APXvYqwesLTNDQQFw6//M9diFSBue6i33rE7XX1maFvSYQrpLJapveW2l5ssAwsHidGnSpNFH/tL+mxtq4+yDxk91n0=
X-Received: by 2002:ac8:3258:: with SMTP id y24mr5635888qta.183.1565902960614;
 Thu, 15 Aug 2019 14:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190812153039.13604-1-ncroxon@redhat.com> <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
In-Reply-To: <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 15 Aug 2019 14:02:29 -0700
Message-ID: <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     Xiao Ni <xni@redhat.com>, NeilBrown <neilb@suse.com>
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 12, 2019 at 4:38 PM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 08/12/2019 11:30 PM, Nigel Croxon wrote:
> > Often limits can be changed by admin. When discussing such things
> > it helps if you can provide "self-sustained" facts. Also
> > sometimes the admin thinks he changed a limit, but it did not
> > take effect for some reason or he changed the wrong thing.
> >
> > Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> > ---
> >   drivers/md/raid5.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index 522398f61eea..e2b58b58018b 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -2566,8 +2566,8 @@ static void raid5_end_read_request(struct bio * bi, int error)
> >                               bdn);
> >               } else if (atomic_read(&rdev->read_errors)
> >                        > conf->max_nr_stripes)
> > -                     pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
> > -                            mdname(conf->mddev), bdn);
> > +                     pr_warn("md/raid:%s: Too many read errors (%d), failing device %s.\n",
> > +                            mdname(conf->mddev), conf->max_nr_stripes, bdn);
> >               else
> >                       retry = 1;
> >               if (set_bad && test_bit(In_sync, &rdev->flags)
>
> Hi Nigel
>
> Is it better to print rdev->read_errors too? So it can know the error
> numbers and the max nr stripes

I think rdev->read_errors is more useful here.

Hi Neil,

I have a question for this case: this patch changes an existing pr_warn() line,
which in theory, may break user scripts that grep for this line from dmesg.
How much do we care about these scripts?

Thanks,
Song
