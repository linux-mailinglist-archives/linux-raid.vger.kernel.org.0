Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895D71D1AE9
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgEMQXH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 12:23:07 -0400
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:54310 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728354AbgEMQXH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 12:23:07 -0400
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 411EE604936;
        Wed, 13 May 2020 16:23:05 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.216.232])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id D59326048DD;
        Wed, 13 May 2020 16:22:56 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 04DGMtlp006297
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 May 2020 18:22:55 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 04DGMt4g006296;
        Wed, 13 May 2020 18:22:55 +0200
Date:   Wed, 13 May 2020 18:22:55 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Wolfgang Denk <wd@denx.de>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
Subject: Re: raid6check extremely slow ?
Message-ID: <20200513162255.GB5530@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511153937.GA3225@lazy.lzy>
 <20200512073747.645CE240E1A@gemini.denx.de>
 <20200512161731.GE7261@lazy.lzy>
 <20200513061358.20C84240E1A@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513061358.20C84240E1A@gemini.denx.de>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 13, 2020 at 08:13:58AM +0200, Wolfgang Denk wrote:
> Dear Piergiorgio,
> 
> In message <20200512161731.GE7261@lazy.lzy> you wrote:
> >
> > > This still does not really explain what is so slow here.  I mean,
> > > even if the locking was an expenive operation code-wise, I would
> > > expect to see at least one of the CPU cores near 100% then - but
> > > botch CPU _and_ I/O are basically idle, and disks are _all_ and
> > > _always_ really close at a trhoughput of 400 kB/s - this looks like
> > > some intentional bandwith limit - I just can't see where this can be
> > > configured?
> >
> > The code has 2 functions: lock_stripe() and
> > unlock_all_stripes().
> >
> > These are doing more than just lock / unlock.
> > First, the memory pages of the process will
> > be locked, then some signal will be set to
> > "ignore", then the strip will be locked.
> >
> > The unlock does the opposite in the reverse
> > order (unlock, set the signal back, unlock
> > the memory pages).
> > The difference is that, whatever the reason,
> > the unlock unlocks *all* the stripes, not
> > only the one locked.
> >
> > Not sure why.
> 
> It does not matter how omplex the operation is - I wonder why it is
> taking so long: it cannot be CPU bound, as then I would expect to
> see any significant CPU load, but none of the cores shows more than
> 5...6% usage, ever.  Or it is I/O bound, then I would expect to see
> I/O wait, but this is also never more than 0.2...0.3%.
> 
> And why are all disks running at pretty exaclty 400 kB/s read rate,
> all the time?  this looks like some intentinal bandwith limit, but I
> cannot find any knob to change it.

In my test I see 1200KB/sec, or 1.2MB/sec,
which is different than yours.

I do not think there is any bandwidth
limitation, otherwise we should see the
same, I guess.

The low CPU load and low data rate seems
to me a symptom of CPU just systematically
waiting (for something).

It would be like putting in the code, here
and there, some usleep().
In the end we'll see low CPU load and low
data rate, *but* very constant.

Likely, is not either I/O wait, but some
other wait.
It could be not the lock stripe, but the
locking of the process memory pages...

This could be easily test, BTW.
Maybe I'll try...

bye,

pg

> 
> 
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Be careful what you wish for. You never know who will be listening.
>                                       - Terry Pratchett, _Soul Music_

-- 

piergiorgio
