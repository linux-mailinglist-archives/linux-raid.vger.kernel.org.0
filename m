Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D51CFA1B
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgELQFd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 12:05:33 -0400
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90]:56494 "EHLO
        vsmx012.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgELQFd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 12 May 2020 12:05:33 -0400
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 5B774F34B50;
        Tue, 12 May 2020 16:05:31 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.216.232])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id EA3F419AE5E;
        Tue, 12 May 2020 16:05:20 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 04CG5JOU007290
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 12 May 2020 18:05:19 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 04CG5Jq5007289;
        Tue, 12 May 2020 18:05:19 +0200
Date:   Tue, 12 May 2020 18:05:19 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
Subject: Re: raid6check extremely slow ?
Message-ID: <20200512160519.GA7261@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 11, 2020 at 10:53:05PM +0200, Giuseppe Bilotta wrote:
> Hello Piergiorgio,
> 
> On Mon, May 11, 2020 at 6:15 PM Piergiorgio Sartor
> <piergiorgio.sartor@nexgo.de> wrote:
> > Hi again!
> >
> > I made a quick test.
> > I disabled the lock / unlock in raid6check.
> >
> > With lock / unlock, I get around 1.2MB/sec
> > per device component, with ~13% CPU load.
> > Wihtout lock / unlock, I get around 15.5MB/sec
> > per device component, with ~30% CPU load.
> >
> > So, it seems the lock / unlock mechanism is
> > quite expensive.
> >
> > I'm not sure what's the best solution, since
> > we still need to avoid race conditions.
> >
> > Any suggestion is welcome!
> 
> Would it be possible/effective to lock multiple stripes at once? Lock,
> say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
> internals, but if locking is O(1) on the number of stripes (at least
> if they are consecutive), this would help reduce (potentially by a
> factor of 8 or 16) the costs of the locks/unlocks at the expense of
> longer locks and their influence on external I/O.

Probabily possible, from the technical
point of view, even if I do not know
either the effect.

From the coding point of view, a bit
tricky, boundary conditions and so on
must be properly considered.

> 
> --
> Giuseppe "Oblomov" Bilotta

-- 

piergiorgio
