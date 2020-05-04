Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1D1C47B6
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 22:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgEDUML (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDUMK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 16:12:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA75C061A0E
        for <linux-raid@vger.kernel.org>; Mon,  4 May 2020 13:12:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l18so21294wrn.6
        for <linux-raid@vger.kernel.org>; Mon, 04 May 2020 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mGYgHc/GplCMRJpc6euNvBJJXDa/k/WSBhedGq2Ggw=;
        b=hL4A2wPKIcQ4fwPLKzOQETJdN1+w46biuxUCKpDCR/jmWAcRDgbH1zgdx4J2Fb6J9J
         T2tBJkiPxLMR2zID+Q7hWP+zFfVfCdn5sKu0I6W/g2rPn9StHcTX0WYgdAono7oZ+6s/
         z7ZyJT214KLUXa84aJBN7cDxBBmJS72lIepyBFFDmbgAJbA25uZfxbXCbhO6ZgOh7a2f
         HnNDOj3ITPXxwhhda6nZ2tpjEylyDQfiK8zp+TgLZYZRDczajOb9ebIxWRn6e66vOEom
         dclybOsYDp/h2AhQfDz9ZeaTlmmKtwUlT9BopbZUCuKvJBcaziLYP7mQAlgpQlqI6rX7
         HEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mGYgHc/GplCMRJpc6euNvBJJXDa/k/WSBhedGq2Ggw=;
        b=L3RHcYklbCo/2/oIb7qrXjPiYT0WxdSmoZFvq8BLnEm4kQH/qLjCpcYPvRoDWF01Cg
         3Ut75VWrI0zUm27N1GqQp01a7zC6xyJF6dQV5YlYZiht5Xqvth3b1CKnLKJDbwVw1b24
         u1cJIlp5JSuWFt/t2KojPI/8FsDFqcmIxPMonnWqn6+VGuLnV4GuO3GVhPLnKslO2kRw
         SWaemN8oMsASsQr9nZV1hzlYuWf5j2lkrEKITGcRGsrhagF9L9aQzk6nyOlCzbu42gCm
         pY+K5+k/Q4EMICMGp2KSFdULBhMKgudDMrEUTmtR5u9BHQEJQrzkk2M+rViXFJBmoWXp
         3qZg==
X-Gm-Message-State: AGi0PuZd/rH9/V3TRTkWgYIHY/GlwwxLsPTFP9IdoCTrDwoLexrkA1Kp
        Os9znozxQCfNjH7rf4zC2lK7rqn8eYrEjnoUcie6p6vZxsc=
X-Google-Smtp-Source: APiQypIKubHWzsuaewpfR6vt2SDCW8KfDZ7Q9J5wYoATr0spK7z3uHrw4EApDS9Sdjg5xK5Ojb9Qni3IsBWzswTR7vc=
X-Received: by 2002:adf:91a4:: with SMTP id 33mr1046821wri.274.1588623128011;
 Mon, 04 May 2020 13:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk> <20200504162138.GA4791@lazy.lzy>
In-Reply-To: <20200504162138.GA4791@lazy.lzy>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 14:11:51 -0600
Message-ID: <CAJCQCtQaCq+D0YUa-smGqCDAeOQQcq1rM5RJ+xCGsWrCrrnM4A@mail.gmail.com>
Subject: Re: WD Red drives are now SMR drives?
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 4, 2020 at 10:21 AM Piergiorgio Sartor
<piergiorgio.sartor@nexgo.de> wrote:
>
> On Mon, May 04, 2020 at 12:38:04AM +0100, antlists wrote:
> > Has anyone else picked up on this? Apparently 1TB and 8TB drives are still
> > CMR, but new drives between 2 and 6 TB are now SMR drives.
> >
> > https://www.extremetech.com/computing/309730-western-digital-comes-clean-shares-which-hard-drives-use-smr
> >
> > What impact will this have on using them in raid arrays?
>
> https://www.smartmontools.org/ticket/1313
>

I think it is defective abstraction that's the problem, not SMR per se.

For a drive in normal use to fail with write errors like this? It's defective.
[20809.396284] blk_update_request: I/O error, dev sdd, sector
3484334688 op 0x1:(WRITE) flags 0x700 phys_seg 2 prio class 0

As to what kind of performance guarantees they've made or implied, I
think they have an obligation to perform no worse than the slowest
speed of CMR "inside track" performance. However, they want to achieve
that is their technical problem. They market DM-SMR as handling
ordinary file systems without local mitigations.


-- 
Chris Murphy
