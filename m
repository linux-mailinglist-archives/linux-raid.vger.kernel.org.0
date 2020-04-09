Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6D1A3BCE
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgDIVSr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 17:18:47 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]:34303 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVSr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Apr 2020 17:18:47 -0400
Received: by mail-qv1-f51.google.com with SMTP id s18so91604qvn.1
        for <linux-raid@vger.kernel.org>; Thu, 09 Apr 2020 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Qu8w8rHpoFs0XM3bjyGn1OZMe04R+pkFFGzHdnwg0y8=;
        b=vgYWwmE3RPx2b8RNNx9XBe7bp0zPiB2JQLV11g46Fg5xaWoeDJipbMvpWgJpCtBWUe
         qOuHaRg8fFlsEDqdSehn4kMfJk4hrGJh3TlwHiCwOt3tAOl+GNbGg8FHyOhdGnvs4U0V
         ripRY9nCYeL54i+EIsog3MW2eL+njG74Wr+H32WC2DtVtKg4dyOkc+oD1Tgm8kXxjbv0
         wQlQii67G3H2tov58R3g3KBSFAJWfCkJJXFY3LN1Tn++bAEkDkFYMk2TnvI9wE9AeA+H
         msR1cmhprDuecWw338sVPeHbI77zkN8AitF7Xk5wQLale9kwJH9i+T8sI+9BQTAT6tBC
         o56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Qu8w8rHpoFs0XM3bjyGn1OZMe04R+pkFFGzHdnwg0y8=;
        b=lKLLkNcaoqe1k1RYkXOMKpypVCym3wuXqq+30A18mBitvLB0zsY2N/dVgJ4G0p6Gn8
         2wOJ8WBXisEfnHE2p3Lz88rFGoeglXEQKRBsB6bx9NVpdz7Zvd8dRtaPFuqBmjePC86l
         6Sczi/68VVHhFTLQTa5iMhfeyb8l4geDEIEF2gtTQGIgpD2Ub1QQNeLLOKRVgTwi7YdQ
         fr+U06ol2sVGkfxPWlkRIp7Xhn+fHuRRkpdBAx6GltVbR75eon7j6xwaeNpusDIs94NW
         ZkKiZbgbXvteVMCHj4CaPYbkqLr04V1/vs/q8u+HpskvCxZWg/DSwBhiGM2nk+piKwGk
         aQrA==
X-Gm-Message-State: AGi0PubYKTdz6LcE7bjWi9YNOU6bf6S684LEdW1t2anT1GPyaYAPY9t8
        xWTFXJ9bNKUYroK26xpCGIhv+1Vu6ff3QgEbbqI=
X-Google-Smtp-Source: APiQypL3pHv57JYQ9Bbez19TJ164KLD5hF+EZSPa8W5KeJAnQItpaCAXkfAYyibvMpcNFaTLcc+CFY9jESRrRXrYvmk=
X-Received: by 2002:a0c:ba08:: with SMTP id w8mr2112110qvf.77.1586467127570;
 Thu, 09 Apr 2020 14:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADSg1Jh1i+OPq0_hWOvHxK0xroUbn_w0_ZjxjwcnrbSsBXGY5A@mail.gmail.com>
 <5E25876A.1030004@youngman.org.uk> <CADSg1Jj3XmD_RmSedn3AT9uCXbHQGa6ATBK1UP33onS8Vi=60g@mail.gmail.com>
 <CADSg1Jh7=6XHXbDqWVWg=fa-+09Vd9E+KBuTy6AWucJesFkBmQ@mail.gmail.com> <20200409071940.GA4072@cthulhu.home.robinhill.me.uk>
In-Reply-To: <20200409071940.GA4072@cthulhu.home.robinhill.me.uk>
Reply-To: andrewbass@gmail.com
From:   "Andrey ``Bass'' Shcheglov" <andrewbass@gmail.com>
Date:   Fri, 10 Apr 2020 00:18:34 +0300
Message-ID: <CADSg1JgwR7C6iqTz7gA3tw1WB=NT9_3Wwa1KHbsYLbPh23qrJQ@mail.gmail.com>
Subject: Re: Repairing a RAID1 with non-zero mismatch_cnt, vol. 2
To:     robin@robinhill.me.uk
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Indeed.

The subsequent check resulted in the zero value of mismatch_cnt.

Thank you Robin.

Regards,
Andrey.

On Thu, 9 Apr 2020 at 10:19, Robin Hill <robin@robinhill.me.uk> wrote:
>
> The mismatch_cnt after repair indicates how many repairs were completed.
> You need to run a new repair/check to see whether there are any
> remaining mismatches.
