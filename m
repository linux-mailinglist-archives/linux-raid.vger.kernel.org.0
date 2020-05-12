Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5302F1CEA4A
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 03:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgELBxC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 21:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgELBxC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 May 2020 21:53:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047AC061A0C
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 18:53:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so9849616qtb.5
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BTXHok54KO1ppEka7Bf7qxXfR7/tunOaw9BE88nfCUY=;
        b=IZF7C6sORdReu4i3ypkIQZ67cz8UaB/c2afovhDOT9G5PvZOno9XI5B3WG8/c2ZOxw
         R7LRiEEjFely9KQX89uw1WCyhla8IqwoHNEU2Y7xta8R91EcbwT0WYctTSSn8f2o/J2T
         9wByBSOeSnrymELG9d8ouY1rTg64xMdTvBN+cd8EFr7iL/W3DNw7O4gEzG8E2M6fYc3U
         H/Ppqqc/TRsqFRlOnibXzo3vKjQ/vLKNm17aQ//SGpPeDflyf3dqyvk+aZNaGPVi2GYO
         uWJJIRmK2glEddkKLcmSwNPG0/QamSci2fuI7ffJO5G85ubUFj4Yy9ToRAENF4nBpfWY
         yhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BTXHok54KO1ppEka7Bf7qxXfR7/tunOaw9BE88nfCUY=;
        b=t+TwmZBWUTso0IunfLtacwzOehIMV0zx6yziB27x9RgnWTLJEZaOsiDegBQ/GmxsYY
         k21RNuIPK0/CLkH0lkJ4COY393poce//KF63/q3jVv/eaPG7hMCTaO0MgASHLtjSTa1H
         Q0D7U7ksNHHQGQjKLkGEJjdmi6NqWhDKwiqysHnDvGNFhruQlp4QOs+1Bd5s/VoqJksU
         JolwkSgKL/au3BftEgOJA7eyoU7AJ6Eeiy9Mx8CIhiUaS0X4tbXWTQJSQwjJCicHLjfg
         m02G4jRosyGWsyHeN5laE0fBLuIyBBMox7cVxp/+Qo7jn/ak5g63Vh5ysN5cirnXUgGl
         5Xvg==
X-Gm-Message-State: AGi0PuYPQVuAFagG/26diEvAZF6+jvO8YtvFFaN1QY61HAcU0er26maH
        Z1Haw1w7l59eZmaGcq97AGfTe95CloTWtpXkQuc=
X-Google-Smtp-Source: APiQypLBMCzOzztCLNvRqke6Op++RCteQEwxh5g0SSEkOWRx+ftrKXiq3e/cnRToSjusBkDhhld4gUoirxbagK7nOTw=
X-Received: by 2002:ac8:6f25:: with SMTP id i5mr19400677qtv.240.1589248381446;
 Mon, 11 May 2020 18:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200510120725.20947240E1A@gemini.denx.de> <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de> <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy> <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
 <59cd0b9f-b8ac-87c1-bc7e-fd290284a772@cloud.ionos.com> <d350c913-0ec6-c1a2-fb41-1fa0dec6632f@cloud.ionos.com>
In-Reply-To: <d350c913-0ec6-c1a2-fb41-1fa0dec6632f@cloud.ionos.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Tue, 12 May 2020 03:52:50 +0200
Message-ID: <CAOxFTcyj6-8PJwrhfCptZkOPW7iciQOUxuazCcAUnXgnD-d3kg@mail.gmail.com>
Subject: Re: raid6check extremely slow ?
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 11, 2020 at 11:16 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
> On 5/11/20 11:12 PM, Guoqing Jiang wrote:
> > On 5/11/20 10:53 PM, Giuseppe Bilotta wrote:
> >> Would it be possible/effective to lock multiple stripes at once? Lock,
> >> say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
> >> internals, but if locking is O(1) on the number of stripes (at least
> >> if they are consecutive), this would help reduce (potentially by a
> >> factor of 8 or 16) the costs of the locks/unlocks at the expense of
> >> longer locks and their influence on external I/O.
> >>
> >
> > Hmm, maybe something like.
> >
> > check_stripes
> >
> >     -> mddev_suspend
> >
> >     while (whole_stripe_num--) {
> >         check each stripe
> >     }
> >
> >     -> mddev_resume
> >
> >
> > Then just need to call suspend/resume once.
>
> But basically, the array can't process any new requests when checking is

Yeah, locking the entire device might be excessive (especially if it's
a big one). Using a granularity larger than 1 but smaller than the
whole device could be a compromise. Since the =E2=80=9Cno lock=E2=80=9D app=
roach seems
to be about an order of magnitude faster (at least in Piergiorgio's
benchmark), my guess was that something between 8 and 16 could bring
the speed up to be close to the =E2=80=9Cno lock=E2=80=9D case without havi=
ng dramatic
effects on I/O. Reading all 8/16 stripes before processing (assuming
sufficient memory) might even lead to better disk utilization during
the check.

--=20
Giuseppe "Oblomov" Bilotta
