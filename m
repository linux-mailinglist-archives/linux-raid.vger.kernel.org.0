Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5B1398B2
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgAMSRG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 13:17:06 -0500
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:8476 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728966AbgAMSRF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 13:17:05 -0500
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 8BB7C60576A;
        Mon, 13 Jan 2020 18:17:04 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.221.251])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 3D7DD605B0C;
        Mon, 13 Jan 2020 18:16:55 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 00DIGsaA007701
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 13 Jan 2020 19:16:54 +0100
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 00DIGs1v007700;
        Mon, 13 Jan 2020 19:16:54 +0100
Date:   Mon, 13 Jan 2020 19:16:54 +0100
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Song Liu <song@kernel.org>
Cc:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        dm-devel@redhat.com,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: dm-integrity
Message-ID: <20200113181654.GA7645@lazy.lzy>
References: <CAJH6TXhnkB10BUENn0P+qXy4nunwY6QVtgDvaFVpfGDpvE-V=Q@mail.gmail.com>
 <CAPhsuW6srGADYYD4dsUbVVBcz4bfJ-taoOy6ccpXjyU26jVTEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6srGADYYD4dsUbVVBcz4bfJ-taoOy6ccpXjyU26jVTEg@mail.gmail.com>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 13, 2020 at 10:11:00AM -0800, Song Liu wrote:
> + dm-devel
> 
> On Sun, Jan 12, 2020 at 5:43 AM Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com> wrote:
> >
> > I'm testing dm-integrity.
> > Simple question: when corrupted data are found, repair is done
> > immediately or on next scrub?
> >
> > This is what I have:
> >
> > [ 6727.395808] md: data-check of RAID array md0
> > [ 6727.528589] device-mapper: integrity: Checksum failed at sector 0xe228
> > [ 6727.938689] md: md0: data-check done.
> > [ 6749.125075] md: data-check of RAID array md0
> > [ 6749.664269] md: md0: data-check done.
> >
> > if repair is done immediatly, would be possible to add a single log
> > line saying that ?
> > something like:
> > [ 6727.528589] md: md0: Repaired data at sector 0xe228
> 
> I guess this belongs to dm-integrity instead of md?

Eh, well, no.
He is asking about "md" in case the underlying
layer, dm-integrity in this case, returns an error.

This could be the case also if the HDD returns
a read error which the RAID will correct and,
if I get it right, rewrite.

But I guess "md" already returns where the
correction happened, isn't like that?
I recall seeing in the logs something about
it, but it was some time ago...

bye,

-- 

piergiorgio
