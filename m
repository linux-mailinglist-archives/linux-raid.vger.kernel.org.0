Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73A1D06FB
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 08:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEMGON (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 02:14:13 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49377 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgEMGON (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 May 2020 02:14:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49MPWj1Qp9z1rsMj
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 08:14:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49MPWj1K0Xz1qspX
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 08:14:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id mNh4DuldgiYo for <linux-raid@vger.kernel.org>;
        Wed, 13 May 2020 08:14:08 +0200 (CEST)
X-Auth-Info: 7BOHTh0mvDItIXncgEsrAJUQHqYSR1d8HGWlx9/qEhs=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 08:14:08 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 244B6A0420; Wed, 13 May 2020 08:14:08 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 76039A0128;
        Wed, 13 May 2020 08:13:58 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 20C84240E1A;
        Wed, 13 May 2020 08:13:58 +0200 (CEST)
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20200512161731.GE7261@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de> <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com> <20200511064022.591C5240E1A@gemini.denx.de> <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com> <20200511153937.GA3225@lazy.lzy> <20200512073747.645CE240E1A@gemini.denx.de> <20200512161731.GE7261@lazy.lzy>
Comments: In-reply-to Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
   message dated "Tue, 12 May 2020 18:17:31 +0200."
Date:   Wed, 13 May 2020 08:13:58 +0200
Message-Id: <20200513061358.20C84240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Piergiorgio,

In message <20200512161731.GE7261@lazy.lzy> you wrote:
>
> > This still does not really explain what is so slow here.  I mean,
> > even if the locking was an expenive operation code-wise, I would
> > expect to see at least one of the CPU cores near 100% then - but
> > botch CPU _and_ I/O are basically idle, and disks are _all_ and
> > _always_ really close at a trhoughput of 400 kB/s - this looks like
> > some intentional bandwith limit - I just can't see where this can be
> > configured?
>
> The code has 2 functions: lock_stripe() and
> unlock_all_stripes().
>
> These are doing more than just lock / unlock.
> First, the memory pages of the process will
> be locked, then some signal will be set to
> "ignore", then the strip will be locked.
>
> The unlock does the opposite in the reverse
> order (unlock, set the signal back, unlock
> the memory pages).
> The difference is that, whatever the reason,
> the unlock unlocks *all* the stripes, not
> only the one locked.
>
> Not sure why.

It does not matter how omplex the operation is - I wonder why it is
taking so long: it cannot be CPU bound, as then I would expect to
see any significant CPU load, but none of the cores shows more than
5...6% usage, ever.  Or it is I/O bound, then I would expect to see
I/O wait, but this is also never more than 0.2...0.3%.

And why are all disks running at pretty exaclty 400 kB/s read rate,
all the time?  this looks like some intentinal bandwith limit, but I
cannot find any knob to change it.



Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Be careful what you wish for. You never know who will be listening.
                                      - Terry Pratchett, _Soul Music_
