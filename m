Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211E7295578
	for <lists+linux-raid@lfdr.de>; Thu, 22 Oct 2020 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507458AbgJVAY4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Oct 2020 20:24:56 -0400
Received: from smtp2.kaist.ac.kr ([143.248.5.229]:42338 "EHLO
        smtp2.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507464AbgJVAY4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Oct 2020 20:24:56 -0400
Received: from unknown (HELO mail1.kaist.ac.kr) (143.248.5.247)
        by 143.248.5.229 with ESMTP; 22 Oct 2020 09:24:47 +0900
X-Original-SENDERIP: 143.248.5.247
X-Original-MAILFROM: dae.r.jeong@kaist.ac.kr
X-Original-RCPTTO: linux-raid@vger.kernel.org
Received: from kaist.ac.kr (143.248.133.220)
        by kaist.ac.kr with ESMTP imoxion SensMail SmtpServer 7.0
        id <c11218c1806a4492b2d5232b18478074> from <dae.r.jeong@kaist.ac.kr>;
        Thu, 22 Oct 2020 09:24:46 +0900
Date:   Thu, 22 Oct 2020 09:24:46 +0900
From:   "Dae R. Jeong" <dae.r.jeong@kaist.ac.kr>
To:     Song Liu <song@kernel.org>
Cc:     yjkwon@kaist.ac.kr, linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: WARNING in md_ioctl
Message-ID: <20201022002446.GB1811280@dragonet>
References: <20201017110651.GA1602260@dragonet>
 <CAPhsuW583=org7AOR-W2vcQV3pTBxin2LG1tb3On=x6VtjXvxQ@mail.gmail.com>
 <20201019070319.GA1811280@dragonet>
 <CAPhsuW4dR7_pgxg-696M34peSRTPhTmJgpokKr5qAMXd81damg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4dR7_pgxg-696M34peSRTPhTmJgpokKr5qAMXd81damg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> > > diff --git i/drivers/md/md.c w/drivers/md/md.c
> > > index 6072782070230..49442a3f4605b 100644
> > > --- i/drivers/md/md.c
> > > +++ w/drivers/md/md.c
> > > @@ -7591,8 +7591,10 @@ static int md_ioctl(struct block_device *bdev,
> > > fmode_t mode,
> > >                         err = -EBUSY;
> > >                         goto out;
> > >                 }
> > > -               WARN_ON_ONCE(test_bit(MD_CLOSING, &mddev->flags));
> > > -               set_bit(MD_CLOSING, &mddev->flags);
> > > +               if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
> > > +                       err = -EBUSY;
> > > +                       goto out;
> > > +               }
> > >                 did_set_md_closing = true;
> > >                 mutex_unlock(&mddev->open_mutex);
> > >                 sync_blockdev(bdev);
> > >
> 
> Good catch! The fix looks good. Would you like to submit a patch for it?

Sure. I will send a patch soon.

Best regards,
Dae R. Jeong.


