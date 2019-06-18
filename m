Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0B4A40B
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfFROa4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 10:30:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40342 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFROa4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 10:30:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so15535970qtn.7
        for <linux-raid@vger.kernel.org>; Tue, 18 Jun 2019 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xostE2ZqhTGu6CujSEzVI1iN6tus3tWXpNZk+CD1qUE=;
        b=cX01KG65uGihctXIAU4k9s0nQ3BJ7c5j3uBJ8my4pynEg2uyiPjzLCIIE6QXK3KlYO
         HNy7iTj/rCgcSsaUfLKgkNJs/7gP42MEQRW0ybpMcAXzSDuwqU3njna2EJ0n/0rW3DW4
         W54y3ZuZvYSdYpocbWNgp/sSruDNVlNIQ0g2sHLRByzs592V4mnVxy9OY8rO2qJVqTGM
         tViKgVMUjEan61CoOpyCHK+WwloJxDUuf6w6uOutBShs1dajEuRn2q3oaoBnTA8db5qj
         iCnw88fQ+CsMKBvxUMwdG+f6xJBYRbDKjV0alKH5JNlbnv4Q6ibMlmKjM8w+t//vuYae
         2Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xostE2ZqhTGu6CujSEzVI1iN6tus3tWXpNZk+CD1qUE=;
        b=WahFhutLNj16XxztWigqpdwDadMX/3hrcihlm/ZEjt+qXhXbhPO+w+iL85KbdJOp8e
         yDG46tPMEJdiylLVyt1PSpMArLwYcYlbHKhByOLYIXnx6KeM/FQhZjRKLFeMFTRtfR67
         3g6qU8t6LwKk7vi+LM6R5vL8oD0SbVoxtXV9QBrqslLSiFn14kxeKfHTHS1BMhFMXguP
         5HIDIhjFe3kghfjjFtxJ8WJRKBsaX2gkczbuRhBYLU9g7fs0RsBIkxYzqnfo9qmQSV6V
         H6C4/JkVzLyK12iarS+AU78dYHM59n3in0OnyNDjDuTijsjKJAy6MQlLCiKRlNxRnQM8
         6GiA==
X-Gm-Message-State: APjAAAVHlNomCB2gRYkSfHa7ffK90LHP86TtnX562pWDO1AurQpKNpcz
        xLboyQP1sBrWGw0vrjkYPSTN78TRhgzP6sjZaEBSmQ==
X-Google-Smtp-Source: APXvYqyqrq8RIiElEvew0kdgHq8iDT8o42u9vJYHcPmM/jzEAPo1zxIQXr/H0yrFDynLtwUs7J3DyG7MX+QeELEib/0=
X-Received: by 2002:aed:3b66:: with SMTP id q35mr101448147qte.118.1560868255732;
 Tue, 18 Jun 2019 07:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-1-gqjiang@suse.com> <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com> <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
 <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
In-Reply-To: <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 18 Jun 2019 07:30:44 -0700
Message-ID: <CAPhsuW4mDPdDWQp2MdJ2Db9HoTuawPQZO9bCHOH-XtQs0LLfKQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 17, 2019 at 9:58 PM Guoqing Jiang <gqjiang@suse.com> wrote:
>
>
>
> On 6/18/19 12:41 PM, Song Liu wrote:
> > On Mon, Jun 17, 2019 at 8:41 PM Guoqing Jiang <gqjiang@suse.com> wrote:
> > <snip>
> >
> >>>> +};
> >>> Have we measured the performance overhead of this?
> >>> The linear search for every IO worries me.
> >>   From array's view, I think the performance will not be impacted,
> >> because write IO is complete
> >> after it reached all the non-writemostly devices.
> >>
> > Hmm... How about the cpu utilization rate? Have you got chance
> > to do some simple benchmarking?
> >
>
> I can't see the impact of cpu in simple test, because it really depends on
> how slow the writemostly device is.
>
> And the modern multi-queue device (also flagged as writemostly) would
> be fast enough to handle the write-behind IO in time, which means there
> should only a few (or zero) elements in wb_list, but it is a potential issue
> which need to be addressed.

Yeah, this makes sense. We can keep the linear search for now.

Thanks,
Song
