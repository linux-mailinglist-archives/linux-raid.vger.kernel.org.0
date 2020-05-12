Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC51CFA34
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgELQMI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 12:12:08 -0400
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90]:20975 "EHLO
        vsmx012.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbgELQMI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 12 May 2020 12:12:08 -0400
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 66A0EF34DF0;
        Tue, 12 May 2020 16:12:05 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.216.232])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id CD1B119AD97;
        Tue, 12 May 2020 16:11:52 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 04CGBpiC007844
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 12 May 2020 18:11:51 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 04CGBpsn007843;
        Tue, 12 May 2020 18:11:51 +0200
Date:   Tue, 12 May 2020 18:11:51 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
Subject: Re: raid6check extremely slow ?
Message-ID: <20200512161151.GD7261@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
 <59cd0b9f-b8ac-87c1-bc7e-fd290284a772@cloud.ionos.com>
 <d350c913-0ec6-c1a2-fb41-1fa0dec6632f@cloud.ionos.com>
 <CAOxFTcyj6-8PJwrhfCptZkOPW7iciQOUxuazCcAUnXgnD-d3kg@mail.gmail.com>
 <dbc3f2ee-589e-9347-6918-a1f544721443@websitemanagers.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbc3f2ee-589e-9347-6918-a1f544721443@websitemanagers.com.au>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 12, 2020 at 04:27:59PM +1000, Adam Goryachev wrote:
> 
> On 12/5/20 11:52, Giuseppe Bilotta wrote:
> > On Mon, May 11, 2020 at 11:16 PM Guoqing Jiang
> > <guoqing.jiang@cloud.ionos.com> wrote:
> > > On 5/11/20 11:12 PM, Guoqing Jiang wrote:
> > > > On 5/11/20 10:53 PM, Giuseppe Bilotta wrote:
> > > > > Would it be possible/effective to lock multiple stripes at once? Lock,
> > > > > say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
> > > > > internals, but if locking is O(1) on the number of stripes (at least
> > > > > if they are consecutive), this would help reduce (potentially by a
> > > > > factor of 8 or 16) the costs of the locks/unlocks at the expense of
> > > > > longer locks and their influence on external I/O.
> > > > > 
> > > > Hmm, maybe something like.
> > > > 
> > > > check_stripes
> > > > 
> > > >      -> mddev_suspend
> > > > 
> > > >      while (whole_stripe_num--) {
> > > >          check each stripe
> > > >      }
> > > > 
> > > >      -> mddev_resume
> > > > 
> > > > 
> > > > Then just need to call suspend/resume once.
> > > But basically, the array can't process any new requests when checking is
> > Yeah, locking the entire device might be excessive (especially if it's
> > a big one). Using a granularity larger than 1 but smaller than the
> > whole device could be a compromise. Since the “no lock” approach seems
> > to be about an order of magnitude faster (at least in Piergiorgio's
> > benchmark), my guess was that something between 8 and 16 could bring
> > the speed up to be close to the “no lock” case without having dramatic
> > effects on I/O. Reading all 8/16 stripes before processing (assuming
> > sufficient memory) might even lead to better disk utilization during
> > the check.
> 
> I know very little about this, but could you perhaps lock 2 x 16 stripes,
> and then after you complete the first 16, release the first 16, lock the 3rd
> 16 stripes, and while waiting for the lock continue to process the 2nd set
> of 16?

For some reason I don not know, the unlock
is global.
If I recall correctly, this was the way
Neil mentioned is "more" correct.
 
> Would that allow you to do more processing and less waiting for
> lock/release?

I think the general concept of pipelineing
is good, this would really improve the
performances of the whole thing.
If we could just multithread, I suspect
it could improve.

We need to solve the unlock problem...

bye,

> 
> Regards,
> Adam

-- 

piergiorgio
