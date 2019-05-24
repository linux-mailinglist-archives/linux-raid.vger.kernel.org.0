Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC929D80
	for <lists+linux-raid@lfdr.de>; Fri, 24 May 2019 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbfEXRvi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 May 2019 13:51:38 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39039 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfEXRvi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 May 2019 13:51:38 -0400
Received: by mail-qk1-f181.google.com with SMTP id i125so6635411qkd.6
        for <linux-raid@vger.kernel.org>; Fri, 24 May 2019 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU1xeETOUcFCNBU7eVJzL8JfYxzgeTqTrgxl0grj1A0=;
        b=p62Qw0pRzhnmUpm4sdDDevK1Ek5bfLHZ39xWR5aCYGtqmau86upare2ZP9uwKfhw7E
         d4GLZ9a0IFpCt+Jdk0TABEfm4wmTdKE/5shNLORbmd44dGwp8eGbFw0ruYeydd/mLqg1
         I2uaBlUwNEhjTeSK2rCboD4ZcS4T1M1iBtfKZjf0FJQcp8uFhBkl0Fk2ZJ5BLnbmhZjU
         rVkYiaHAB81pc80bAXWTMNc/+cD9b/KEtHd53kafh7kOWV7tPLHy/NcekW0z4FhGUXKv
         BpKvM01uE93jx2jkzBuyVurwpflpV0NXheALNdP807hU1OEq5fI+dDgdCv3EJ510WVQu
         eV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU1xeETOUcFCNBU7eVJzL8JfYxzgeTqTrgxl0grj1A0=;
        b=f27hh/p8kzH4VZ6pUPMdtaBBd4v7bTaYyUINuRPQKe9YCs8tUu3vIrFDh0pgl+pMgH
         fV6ruXn7V8s4YX+Dhz03pcodPSkT+NMY/bU7CMW5y/EV+eEfGRXKnTghpUBmzEykgYmO
         NT6dGHKG0KvQ/2BuZikgBzsi3Kw3mtI5LkJ30fj+dVn20u+7CrLovuzC+7cU3YsJ1r/V
         F7ppF/SwIyeRSDzI0y13QJdcIXDhwDjMAAVdYod8YUbiHDzsEMyamzJKCzcYOJz3ImPa
         CkUvQHXEDGL7NJMFNJhn9ViRIMH1WtXvrkoHNDmKLCQoOaplShq2wqm1gGsPYpBI/fC8
         BKSQ==
X-Gm-Message-State: APjAAAWbZDOsVmdJZUV6Dd3IxllbZxntGe/uceIBxeTv7ZThQ5gnhr4Q
        Bcms4qHiLfzn9YKm5O8M0+k0BkWO1wIszRdP3GY=
X-Google-Smtp-Source: APXvYqx7EeYWKeLE/68N2F325q9SHRmfEAJeUUrUauNlwoQvsen5cgGmiLq7F2L6JKoKQl834HFHGv7xd/zjmUJ24XE=
X-Received: by 2002:a0c:986e:: with SMTP id e43mr71966370qvd.78.1558720297421;
 Fri, 24 May 2019 10:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info> <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
 <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info>
In-Reply-To: <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 24 May 2019 10:51:26 -0700
Message-ID: <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
Subject: Re: Few questions about (attempting to use) write journal + call traces
To:     Michal Soltys <soltys@ziu.info>, Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, May 24, 2019 at 3:51 AM Michal Soltys <soltys@ziu.info> wrote:
>
> On 5/23/19 8:09 PM, Song Liu wrote:
> >>>
> >>
> >> Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.
> >
> > Thanks for these experiments. Your analysis makes perfect sense.
> >
> > Do you think you can continue the  experiments with the write journal before
> > this issue got fixed?
> >
> > I am asking because this is not on the top of my list at this time. If
> > this is not
> > blocking other important tests, I would prefer to fix it at a later time.
> >
> > Thanks,
> > Song
> >
>
> Yea it's fine. I can help with testing (whenever you sit down to this
> issues) as well.
>
> Question though - other than trying to add journal to existing live raid
> - is this feature overall safe to use (or are there any other know
> issues one should be aware of beforehand) ?
>
We (Facebook) have done some tests with it. However, we didn't put
it into production. The reason behind this decision was not reliability, but
performance concerns and high level directions. I think Redhat is
evaluating it.

+ Xiao, who might be working on this.

Thanks,
Song
