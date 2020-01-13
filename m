Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF538139976
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 19:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMS6U (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 13:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMS6T (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 13:58:19 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8E421556
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578941897;
        bh=LLGb6xBOAcq/qoviGxdnaQV5zJrmI00o3dFSPr0LBW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r/OF/JlHYpoF8UrZY04oflIZk6WZDMM6qDoLhkqnYcumtf6jo/YdUgKTxGWusDis/
         ZotNxOaM2pTThltvFtoYAyTV2gQjJ3JNYTCE1UkFM4w319jI4YiskQK5vPgO1qGBGb
         Pwv00KNPj6vfIYdfkJ+jCl59R0sI6yF5LjgDDMcs=
Received: by mail-qk1-f176.google.com with SMTP id a203so9566511qkc.3
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 10:58:17 -0800 (PST)
X-Gm-Message-State: APjAAAU2sQiPItgC83YNk0sbvVFl0iHX+Vg9HhZc8LNAwkIICFaQWkFS
        v5P35Bo69lvqnSArcra6RYiWWRciy9eyakRMx4w=
X-Google-Smtp-Source: APXvYqxJD+lg5C1nxFDdSFSNMWYGctFhnUOJ/chrc6TUbPdMXrP982xYSzTEub2/HHgK2eEHq9fkvkTtQapfOf49YDg=
X-Received: by 2002:a37:9dcd:: with SMTP id g196mr17794925qke.168.1578941896376;
 Mon, 13 Jan 2020 10:58:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXhnkB10BUENn0P+qXy4nunwY6QVtgDvaFVpfGDpvE-V=Q@mail.gmail.com>
 <CAPhsuW6srGADYYD4dsUbVVBcz4bfJ-taoOy6ccpXjyU26jVTEg@mail.gmail.com> <20200113181654.GA7645@lazy.lzy>
In-Reply-To: <20200113181654.GA7645@lazy.lzy>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Jan 2020 10:58:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6urOBa5s9od-znfn9J2jhz3cCOxmqu6tABvyoCEx5BHQ@mail.gmail.com>
Message-ID: <CAPhsuW6urOBa5s9od-znfn9J2jhz3cCOxmqu6tABvyoCEx5BHQ@mail.gmail.com>
Subject: Re: dm-integrity
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        dm-devel@redhat.com,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 13, 2020 at 10:17 AM Piergiorgio Sartor
<piergiorgio.sartor@nexgo.de> wrote:
>
> On Mon, Jan 13, 2020 at 10:11:00AM -0800, Song Liu wrote:
> > + dm-devel
> >
> > On Sun, Jan 12, 2020 at 5:43 AM Gandalf Corvotempesta
> > <gandalf.corvotempesta@gmail.com> wrote:
> > >
> > > I'm testing dm-integrity.
> > > Simple question: when corrupted data are found, repair is done
> > > immediately or on next scrub?
> > >
> > > This is what I have:
> > >
> > > [ 6727.395808] md: data-check of RAID array md0
> > > [ 6727.528589] device-mapper: integrity: Checksum failed at sector 0xe228
> > > [ 6727.938689] md: md0: data-check done.
> > > [ 6749.125075] md: data-check of RAID array md0
> > > [ 6749.664269] md: md0: data-check done.
> > >
> > > if repair is done immediatly, would be possible to add a single log
> > > line saying that ?
> > > something like:
> > > [ 6727.528589] md: md0: Repaired data at sector 0xe228
> >
> > I guess this belongs to dm-integrity instead of md?
>
> Eh, well, no.
> He is asking about "md" in case the underlying
> layer, dm-integrity in this case, returns an error.
>
> This could be the case also if the HDD returns
> a read error which the RAID will correct and,
> if I get it right, rewrite.

I see. Thanks for the clarification.

>
> But I guess "md" already returns where the
> correction happened, isn't like that?
> I recall seeing in the logs something about
> it, but it was some time ago...

Right now, md_done_sync() doesn't really print any message. I think this is
easy to add. However, md check/recovery is at block granularity, so we
probably cannot print exact which sector got fixed.

Thanks,
Song
