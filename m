Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1483B1CEE58
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgELHiB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 03:38:01 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53461 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELHiA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 May 2020 03:38:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49LqQt2s5jz1s1WP
        for <linux-raid@vger.kernel.org>; Tue, 12 May 2020 09:37:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49LqQt2frCz1qv7j
        for <linux-raid@vger.kernel.org>; Tue, 12 May 2020 09:37:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4euFPAC4mFFY for <linux-raid@vger.kernel.org>;
        Tue, 12 May 2020 09:37:57 +0200 (CEST)
X-Auth-Info: At6vJjf4wjLTvydPXG83aqTPrH9h+zKBZczwjd1k0hI=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Tue, 12 May 2020 09:37:57 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 5B1F7A0421; Tue, 12 May 2020 09:37:57 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 8F8B8A0054;
        Tue, 12 May 2020 09:37:47 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 645CE240E1A;
        Tue, 12 May 2020 09:37:47 +0200 (CEST)
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20200511153937.GA3225@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de> <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com> <20200511064022.591C5240E1A@gemini.denx.de> <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com> <20200511153937.GA3225@lazy.lzy>
Comments: In-reply-to Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
   message dated "Mon, 11 May 2020 17:39:37 +0200."
Date:   Tue, 12 May 2020 09:37:47 +0200
Message-Id: <20200512073747.645CE240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Piergiorgio,

In message <20200511153937.GA3225@lazy.lzy> you wrote:
> >     while (length > 0) {
> >             lock_stripe -> write suspend_lo/hi node
> >             ...
> >             unlock_all_stripes -> -> write suspend_lo/hi node
> >     }
> > 
> > I think it explains the stack of raid6check, and maybe it is way that
> > raid6check works, lock
> > stripe, check the stripe then unlock the stripe, just my guess ...
>
> Yes, that's the way it works.
> raid6check lock the stripe, check it, release it.
> This is required in order to avoid race conditions
> between raid6check and some write to the stripe.

This still does not really explain what is so slow here.  I mean,
even if the locking was an expenive operation code-wise, I would
expect to see at least one of the CPU cores near 100% then - but
botch CPU _and_ I/O are basically idle, and disks are _all_ and
_always_ really close at a trhoughput of 400 kB/s - this looks like
some intentional bandwith limit - I just can't see where this can be
configured?

> This could be a way to test if the problem is
> really here.
> That is, remove the lock / unlock (I guess
> there should be only one pair, but better
> check) and check with the array in R/O mode.

I may try this again after this test completed ;-)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's certainly  convenient  the  way  the  crime  (or  condition)  of
stupidity   carries   with   it  its  own  punishment,  automatically
admisistered without remorse, pity, or prejudice. :-)
         -- Tom Christiansen in <559seq$ag1$1@csnews.cs.colorado.edu>
