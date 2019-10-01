Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2CFC4433
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 01:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfJAXQx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 19:16:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44924 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfJAXQx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 19:16:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so13023880qkk.11
        for <linux-raid@vger.kernel.org>; Tue, 01 Oct 2019 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJyz/b01Be3qjh9Tm8GwEBEHk6iRYpqrsNsNSgOLXJ0=;
        b=mzqzqyLS3e3NLWT/U9izStlniCQVQ+qYwjVSlvjA7Jpcdo7+Lhdeu32unrDxLWYqYO
         JZ3Qgz02LJFHWcnACQJA6YqcdFjfFx5umSS2h3eiuJS+fRYqU7mpFSOt3Ux8fDpgeG2q
         ewlIEFie6zI9lN1gnjc2QU/bvktzWldu0/CGGZMBQh5ESflsMumnnEBsNGWtY9VG5xnX
         xmpDIjT5WE4aLr8hLg916nz76RRanFTMBTrzrsrC5LeQROHHgy/pt5ssGiLIyuC/FsKE
         nJEJq8shP/KVmXqma4nsI+AKq75vSz9DbfbJyyupM/HSCELeyC2jTcbRR+beInHJ4urO
         Y5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJyz/b01Be3qjh9Tm8GwEBEHk6iRYpqrsNsNSgOLXJ0=;
        b=hGA9IOBR48kFv+vuLPfZcf6FnAunlFnwmv070T0/zgUcynxgzAc2HPnivxTeHYdn4z
         rwCoGcN1Qy94Ubzj8acF8IpLCpgAELQphK4xi3DUFGkJRc+NwxUDf9NRKgFPRHexSX9F
         C24zWrfFTOiadX/6THAUvGcQh/BWUD0s7WG/q5mRQWCqwVCZ+ggLrJAno8Ljuls1DPsS
         5KUs40os3brEOpFUpqL83MgnnBsMnP9jFO6csIbtxVOLAwSuUhacE3M+RpTjYHzyORQC
         +783Z52DmjAOmL09ZSqSurq0ydeqzjOr8RdPUMwWmwWaW8xR8FvNVTIMKkKhBVu76hDd
         lNGw==
X-Gm-Message-State: APjAAAVxcSxyZltO93GxJXUq3pn1nGFZBjK1sw+vF27+egh8wKq/C6X4
        4WC8Iz1sc3+1dets3rCw3Edfff0vPkHJsYAv9aE=
X-Google-Smtp-Source: APXvYqy6Inxz0LRQ3qLVYW2n+D8uUgP3bUsYEkYGNTSXZkZFk3TDm++++UgcWXplU4/h4HxpFzymgyKrz1bg1w4Dc8A=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr742169qkf.203.1569971812054;
 Tue, 01 Oct 2019 16:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <1568627145-14210-1-git-send-email-xni@redhat.com>
 <20190916171514.GA1970@redhat> <b7271fd2-5fea-092f-860c-a129d43c3a7a@redhat.com>
 <CA+-xHTEaYtctDGfY=hq_XuxTW01+sriNb6xyS5-aqtvAkkrZNw@mail.gmail.com> <fbeffe99-afd0-abe7-ba87-85de5ce5c8bb@redhat.com>
In-Reply-To: <fbeffe99-afd0-abe7-ba87-85de5ce5c8bb@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 1 Oct 2019 16:16:40 -0700
Message-ID: <CAPhsuW5n0N-tkPJXFoJeAFj9wzyJN33zz_eDh23jUJwmDNTQfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
To:     Xiao Ni <xni@redhat.com>
Cc:     David Jeffery <djeffery@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        NeilBrown <neilb@suse.de>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Sep 18, 2019 at 10:19 PM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 09/19/2019 03:15 AM, David Jeffery wrote:
> > On Tue, Sep 17, 2019 at 11:21 PM Xiao Ni <xni@redhat.com> wrote:
> >> md_flush_request returns false when one flush bio has data and
> >> pers->make_request function go
> >> on handling it. For example the raid device is raid1. md_flush_request
> >> returns false, raid1_make_request
> >> go on handling the bio. If raid1_make_request fails, the bio is still
> >> lost. Now it looks like only md_handle_request
> >> checks the return value of pers->make_request and go on handling the bio
> >> if pers->make_request fails.
> > But the bio isn't lost.  Using raid1 as an example, the calling sequence is
> > md_handle_request -> raid1_make_request -> md_flush_request.
> > raid1_make_request is already wrapped by md_handle_request.  So this
> > earlier call to md_handle_request will re-submit the bio if raid1_make_request
> > returns false after md_flush_request returns false.  Anything which calls an
> > mddev->pers->make_request function (only md_handle_request after patch)
> > must already handle a return of false or it would also have a bug allowing I/O
> > to be lost.
>
> Thanks for the explanation. You are right. The bio can't be lost.
>
> Regards
> Xiao
> >
> >> There should not be a deadlock if it calls md_handle_request directly.
> >> Am I right? If there is a risk, we
> >> can put those bios into a list and queue a work in workqueue to handle
> >> them. Is it a better way?
> > I don't see a deadlock with calling md_handle_request from md_flush_request.
> > It's just more stack and overhead when we could instead let the first calls to
> > these functions advance the I/O instead of recursing into new instances.
> >
> >> Regards
> >> Xiao
> > David Jeffery

Sorry to jumping late.

@Xiao, does David's patch look good to you? If so, please reply with your
Reviewed-by and/or Tested-by.

Thanks,
Song
