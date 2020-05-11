Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409C81CE604
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgEKUxS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 16:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbgEKUxR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 16:53:17 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9449C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 13:53:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z9so3218482qvi.12
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlZqthEoVAUPAp/3IRa9CRoAwgJXxB883AZTHkm/Kd8=;
        b=eB9hrymwV/B5jXLxdSxBG8LamR18rxp/ezJjOiKr7AzjH6PSPWKkBGyVFdQfSBcE2c
         bOweAQ1bwLyYQNl7y8XNs/UZ8T8XKHFZHGsoupbDdJApuLSsim8ltR+Scg084M1xw8UT
         mwLhrqgmDZv88Ld/73lxwRKlfEmwXhvehHS2jFp0k1Y3BFT7/DdrzXgAimyYjhYJUFd6
         ujSe2JjgeGxyrR7UBaDQGNmfyqHvvlSDr5ohrDEq7k0Go6C39ByDiygACjV7qZ7w4Kn+
         7Vgqv1pXUtmEpm6NNVncbS6aldJPHbuUBz4r++q8TSxFXpzbksXLDGz+qW7ZEPJwA/WP
         Rj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlZqthEoVAUPAp/3IRa9CRoAwgJXxB883AZTHkm/Kd8=;
        b=QXEwQ4abDbDkvWklyM/pNG8E50dULw9W/884P6jEUUkU6tt4T3fpYDm5FxgY9VFq5h
         y0s6B/ZoWl1WH/SS4UCTl3nLPfDPicJI1KCEY83eqoEfRG8QPjNerO58L2VkhjeZ+aa7
         QnB2Fvqv6oHG7ATuDATvwxyCCIz4eGWqUSoVu8I9U8DjV8tuPo2slVvprFVxb/TxfQh3
         d5MnbbK35oyRpLUD5wjgjyZlobZ4RWJhpUeyAhmumVJxaJqTP/+czkICPrm8dAyqfrjH
         1rl/tCEoJLVfoasqJGzubq4quG/Lt/S7HxvQEj8GTSS9Gr2buV3PCuG2cfpNUIb6IIP0
         kuoQ==
X-Gm-Message-State: AGi0Pub2prTExLouTuY3M8yEc6wpAjy/cGO/tapP4P8uOuboIQNQipSQ
        dCE0TBJW7ef+gLdGCtoe4PUphTyIuA/PM8YEI8n0Lg==
X-Google-Smtp-Source: APiQypLXOr7klvxnaAh1dc9FAo8Sz8uA9LAiTTBuvUAB0dM81yfQ2idxDoFiTiWGEmaSEShty4+zQYHJT6U4whozXKI=
X-Received: by 2002:a0c:ea43:: with SMTP id u3mr16288230qvp.211.1589230396743;
 Mon, 11 May 2020 13:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200510120725.20947240E1A@gemini.denx.de> <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de> <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
In-Reply-To: <20200511161415.GA8049@lazy.lzy>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 11 May 2020 22:53:05 +0200
Message-ID: <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
Subject: Re: raid6check extremely slow ?
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Piergiorgio,

On Mon, May 11, 2020 at 6:15 PM Piergiorgio Sartor
<piergiorgio.sartor@nexgo.de> wrote:
> Hi again!
>
> I made a quick test.
> I disabled the lock / unlock in raid6check.
>
> With lock / unlock, I get around 1.2MB/sec
> per device component, with ~13% CPU load.
> Wihtout lock / unlock, I get around 15.5MB/sec
> per device component, with ~30% CPU load.
>
> So, it seems the lock / unlock mechanism is
> quite expensive.
>
> I'm not sure what's the best solution, since
> we still need to avoid race conditions.
>
> Any suggestion is welcome!

Would it be possible/effective to lock multiple stripes at once? Lock,
say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
internals, but if locking is O(1) on the number of stripes (at least
if they are consecutive), this would help reduce (potentially by a
factor of 8 or 16) the costs of the locks/unlocks at the expense of
longer locks and their influence on external I/O.

--
Giuseppe "Oblomov" Bilotta
