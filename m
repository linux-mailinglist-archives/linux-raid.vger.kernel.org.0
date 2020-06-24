Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611AE207F35
	for <lists+linux-raid@lfdr.de>; Thu, 25 Jun 2020 00:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbgFXWNw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Jun 2020 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgFXWNv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 Jun 2020 18:13:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D24FC061573
        for <linux-raid@vger.kernel.org>; Wed, 24 Jun 2020 15:13:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y10so4016466eje.1
        for <linux-raid@vger.kernel.org>; Wed, 24 Jun 2020 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zVvGwFL7w1rf1tZSh4tu4OIivfpI+fblF+ABa4djRA=;
        b=d5U/Ixa3qujgYtxClzaqd4CtPjZTdoZ+Mai8RtyNBKpLlUAOi+H88nDG2/xs1xB2Mt
         mJbK2++IuySnL49sr2oLcLYLTeI8MYwxpO5px0OYrgagWyR7JbTNwrslDtUuPZ/C+dCI
         pqEyz/JHCVDfwJwO7R15lyWTRMKSXXubBlUQn2oXbTVJarBVTzn5NSzqjU4oGsifO+FE
         flQPoa6gfp70pwCm7rc4d4/lU+2KaoAtiyEMMhWg/2TBvgGFhb2CfCEsPMY7V9PCOyc7
         8DHmTs+ZWvLLSvDDIn2Z0JmcaJKluz9o9UkvS4VPyUrZG8E5F9JHFn26kfZJvAd/zpAq
         Sbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zVvGwFL7w1rf1tZSh4tu4OIivfpI+fblF+ABa4djRA=;
        b=BdnWCL5wbObTVO6nIaViZVLxlDjPOuEFpyqCj6gxVj63yFG8z9FwCT/Is3ukKc0skl
         37+ExYptJo7Mkdh+bG+DmmIWVjxhKCVNbIhlzXDQ9QvvyLgLzPfRuDisdU1qAIRA/d9k
         a/fw9iPK+mO55fx5YLXcAb6rfLDKYfv0YAa6RBk4z1wN2maTpCplPMdflJPNxStHOcrw
         cdExZkjigGKS5ieWuicmL0qnyiSrE4dyK6wIduDwB84JhMAUhDxuIepiEZaRtcMpGcIE
         qAHEEoGgur+c2BNQ6ZNzJ1+KWPs8RBfPdzc0LT5BqiG0X9saK78DGIg77W06DyVjcMvR
         c+Sg==
X-Gm-Message-State: AOAM531zfm4OmlI8Wv0HWDOqeucVoh2QFw5/Hd1En+B73DTDoezuitXk
        3DxXiWlf1VrNYUvY5VWghlg7BY1e1XDu5XW8NgCGlrBO/GE=
X-Google-Smtp-Source: ABdhPJzvHyXWJhA5O8jCXhWj6y0gdaKr1CHLKXCJrFIwxczbJPjtEoJ2GzHEIXDnpJTt6Ca1m88NN6bS0haXPcp7D+w=
X-Received: by 2002:a17:906:e298:: with SMTP id gg24mr26528412ejb.120.1593036828836;
 Wed, 24 Jun 2020 15:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <rco1i8$1l34$1@ciao.gmane.io> <24305.24232.459249.386799@quad.stoffel.home>
 <CAPpdf5-RWyGX4Q9qaZBDfxUXedf+MnV3wnXh6R3XSF7-LomKzQ@mail.gmail.com> <24306.13691.769328.392093@quad.stoffel.home>
In-Reply-To: <24306.13691.769328.392093@quad.stoffel.home>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Wed, 24 Jun 2020 17:13:13 -0500
Message-ID: <CAPpdf5-iggWaKBbaFw39fDCeddrR=k_b6DTbKHAzhFTdDu-_BA@mail.gmail.com>
Subject: Re: RAID types & chunks sizes for new NAS drives
To:     John Stoffel <john@stoffel.org>
Cc:     Ian Pilcher <arequipeno@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 23, 2020 at 12:01 PM John Stoffel <john@stoffel.org> wrote:

MEC 2548HT

>
> >>>>> "o1bigtenor" == o1bigtenor  <o1bigtenor@gmail.com> writes:
>
> o1bigtenor> On Mon, Jun 22, 2020 at 9:06 PM John Stoffel <john@stoffel.org> wrote:
> >>
> o1bigtenor> snip
>
> >> In any case, make sure you get NAS rated disks, either the newest WD
> >> RED+ (or is it Blue?)  In any case, make sure to NOT get the SMR
> >> (Shingled Magnetic Recording) format drives.  See previous threads in
> >> this group, as well as the arstechnica.com discussion about it all
> >> that they disk last month.  Very informative.
> >>
> >> Personally, with regular hard disks, I still kinda think 4gb is the
> >> sweet spot, since you can just mirror pairs of the disks and then
> >> stripe across on top as needed.  I like my storage simple, because
> >> when (not if!) it all hits the fan, simple is easier to recover from.
> >>
> o1bigtenor> Did you mean 4 TB or 4 GB as you wrote?
> o1bigtenor> (Somewhat of a difference I do believe.)
>
> LOL!  I meant 4Tb of course... but I do remember when 10mb HDs were
> amazing... :-)

I can remember buying a 40 MB drive where the serial number and drive
information
was hand lettered - - - - That was when 5s were sorta common and 10 MB was
thought to be BIG. Oh well - - - thought it was just a typo but prefer
to make sure of
details!!!

Thanks
