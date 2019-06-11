Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA083D15D
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbfFKPvK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 11:51:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40867 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfFKPvK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 11:51:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so15110371qtn.7
        for <linux-raid@vger.kernel.org>; Tue, 11 Jun 2019 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nv5auD+XQ0xbUpA9a5WZg/uk/y2Lh+xLtNaMRvFo1f0=;
        b=BM1fGh4rt4YjUHzkBkf5AENtrUj8JqzeUfdF2EZT4aW2xj45Ryi+NOfxFzJSOL7ywH
         pM0b4jsFD/Xjfm8l+CEgTdzeW2zl0M/jdiaezGUORtBIt7QrEuev4HPzycEmwcfyiw9h
         ao25Y5+OAoVK/gs2gANKkB1h9AHZE+WrrkOM8BMUp+d3WXrI+ECuMjdzod92baD/9IR5
         M3/QX5a+piSajmR0aTsiVRkPLYkwlCWsOL13ZGONAR70ZNWSE2jgh2q5q+MoXLl8v8XP
         z8HaLIPifWeQc2Jdde0gALHvysK4qwFJTc56ngKYemFQsY+yo3dKfRYx2i+FSgIVCJhC
         E+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nv5auD+XQ0xbUpA9a5WZg/uk/y2Lh+xLtNaMRvFo1f0=;
        b=JMI5nz5DevuTeBqJwVxg5GWyWR0MbCOmrcOWkp0olRYhJpPRyX+eNbF+Q/aG2bmAJp
         Vrx/yzLsK9y0qtpXAnoqOQElEpim5rsoZmwYHFXT2mcFh8RhFhInCRC6mWz5CaR9sexV
         Jqy/JwLx/iUCTdk8X3lymPVqONDm+LXqwkWmi4rCtZGU7EC3Ke4cxnga3dNdR3sncfe1
         ENPM3/jAtzQlSYkL3E5/md6dmTFgkjXxNAMRfPbmgEFv98tJJXKgLMVrChcJgFP5q9Sq
         IanuSa0XFKgK3HhCPFlm2RN8ib8cRkI3R/vQVKfFPn/GAZzGarMTw94Rd/t6jzTlvv1/
         eKOw==
X-Gm-Message-State: APjAAAV9qEv/J8lGCvwZNH6JXUL2YvtePkUHxs+qoPDVBGveBHqAlJyp
        BXWeEmuNzckhyY5uwc0hGXkanSNm0oYLacKO9EE=
X-Google-Smtp-Source: APXvYqyEbJv9yJsbj10Q1IhJHT2htZsey7Fp+bWKURNIeFLDq7p3Pj1myI8PKd/Cb5bu8CJNwz+3o6ZHSK6DP5BDVKU=
X-Received: by 2002:ac8:152:: with SMTP id f18mr62102423qtg.84.1560268268973;
 Tue, 11 Jun 2019 08:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <1559047314-8460-1-git-send-email-xni@redhat.com>
 <CAPhsuW4cM6Lut0Ueqip4mLVVbGRmXDmdtcMTR-cwmc98etQ4gA@mail.gmail.com> <79011358-24c1-1c59-43d7-75fe6c6c0967@redhat.com>
In-Reply-To: <79011358-24c1-1c59-43d7-75fe6c6c0967@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 11 Jun 2019 08:50:57 -0700
Message-ID: <CAPhsuW62HU4wvT6oR29RwRCeOJ7ShmjR3Yt5vNfgKsN2dGPigA@mail.gmail.com>
Subject: Re: [PATCH 1/1] raid5-cache: Need to do start() part job after adding
 journal device
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Michal Soltys <soltys@ziu.info>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 10, 2019 at 7:13 PM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 06/07/2019 12:36 AM, Song Liu wrote:
> > On Tue, May 28, 2019 at 5:42 AM Xiao Ni <xni@redhat.com> wrote:
> >> In d5d885fd(md: introduce new personality funciton start()) it splits the init
> >> job to two parts. The first part run() does the jobs that do not require the
> >> md threads. The second part start() does the jobs that require the md threads.
> > nit: checkpatch.pl complains
> >
> > WARNING: Possible unwrapped commit description (prefer a maximum 75
> > chars per line)
> > #57:
> > In d5d885fd(md: introduce new personality funciton start()) it splits the init
> >
> > I fixed this in my tree, so no need to resend.
> >
> >> Now it just does run() in adding new journal device. It needs to do the second
> >> part start() too.
> >>
> >> Fixes: f6b6ec5cfac(raid5-cache: add journal hot add/remove support)
> > Shall we say Fixes d5d885fd(md: introduce new personality funciton
> > start()) here?
> > Or do we really need the fix to earlier versions with f6b6ec5cfac?
> Hi Song
>
> You are right. It's better to put d5d885fd in the Fixes line.
>
> Regards
> Xiao

Thanks Xiao! I will modify the commit log.

Song
