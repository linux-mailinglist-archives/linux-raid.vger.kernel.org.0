Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613F01CFA5C
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgELQRm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 12:17:42 -0400
Received: from vsmx009.vodafonemail.xion.oxcs.net ([153.92.174.87]:18908 "EHLO
        vsmx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgELQRm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 12 May 2020 12:17:42 -0400
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 987EC159D8C4;
        Tue, 12 May 2020 16:17:40 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.216.232])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 55A37159D87F;
        Tue, 12 May 2020 16:17:32 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 04CGHVmu007960
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 12 May 2020 18:17:31 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 04CGHVEJ007959;
        Tue, 12 May 2020 18:17:31 +0200
Date:   Tue, 12 May 2020 18:17:31 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Wolfgang Denk <wd@denx.de>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
Subject: Re: raid6check extremely slow ?
Message-ID: <20200512161731.GE7261@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511153937.GA3225@lazy.lzy>
 <20200512073747.645CE240E1A@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512073747.645CE240E1A@gemini.denx.de>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 12, 2020 at 09:37:47AM +0200, Wolfgang Denk wrote:
> Dear Piergiorgio,
> 
> In message <20200511153937.GA3225@lazy.lzy> you wrote:
> > > ??? while (length > 0) {
> > > ??? ??? ??? lock_stripe -> write suspend_lo/hi node
> > > ??? ??? ??? ...
> > > ??? ??? ??? unlock_all_stripes -> -> write suspend_lo/hi node
> > > ??? }
> > > 
> > > I think it explains the stack of raid6check, and maybe it is way that
> > > raid6check works, lock
> > > stripe, check the stripe then unlock the stripe, just my guess ...
> >
> > Yes, that's the way it works.
> > raid6check lock the stripe, check it, release it.
> > This is required in order to avoid race conditions
> > between raid6check and some write to the stripe.
> 
> This still does not really explain what is so slow here.  I mean,
> even if the locking was an expenive operation code-wise, I would
> expect to see at least one of the CPU cores near 100% then - but
> botch CPU _and_ I/O are basically idle, and disks are _all_ and
> _always_ really close at a trhoughput of 400 kB/s - this looks like
> some intentional bandwith limit - I just can't see where this can be
> configured?

The code has 2 functions: lock_stripe() and
unlock_all_stripes().

These are doing more than just lock / unlock.
First, the memory pages of the process will
be locked, then some signal will be set to
"ignore", then the strip will be locked.

The unlock does the opposite in the reverse
order (unlock, set the signal back, unlock
the memory pages).
The difference is that, whatever the reason,
the unlock unlocks *all* the stripes, not
only the one locked.

Not sure why.
 
> > This could be a way to test if the problem is
> > really here.
> > That is, remove the lock / unlock (I guess
> > there should be only one pair, but better
> > check) and check with the array in R/O mode.
> 
> I may try this again after this test completed ;-)

I did it, some performance improvement,
even if not really the possible max.

bye,

pg

> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> It's certainly  convenient  the  way  the  crime  (or  condition)  of
> stupidity   carries   with   it  its  own  punishment,  automatically
> admisistered without remorse, pity, or prejudice. :-)
>          -- Tom Christiansen in <559seq$ag1$1@csnews.cs.colorado.edu>

-- 

piergiorgio
