Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096132194A1
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jul 2020 01:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgGHXwL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jul 2020 19:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHXwL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 Jul 2020 19:52:11 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0B8206DF
        for <linux-raid@vger.kernel.org>; Wed,  8 Jul 2020 23:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594252331;
        bh=TlXXYv1Ez9GJYqV36kSuIjhR5kM1wkaq+r6Gybdc964=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gwEqKMkHv3jh1DpSkb3/HkmYx275LTpy4Qi1EhtOQukxq3N4UTRxkEvvImA4OpVWX
         WQL+2nVevtWPc+hqW3aoPlRJ2GG98krkMmwGqSYZhip0FCXY6hxCq+uVuU0mRkHHgx
         +syNxFLhtsXE86hFAfz1nCLIdN1ig8Mkv/MSR5R8=
Received: by mail-lj1-f177.google.com with SMTP id s9so253051ljm.11
        for <linux-raid@vger.kernel.org>; Wed, 08 Jul 2020 16:52:10 -0700 (PDT)
X-Gm-Message-State: AOAM532PN8CUG6yogko/p4GVnZ3IwczzweExdpPsFr2AKR1go0AenoRU
        bhvrp+RHzRAdd2JgMx8oX4e+YvH07fAlXFKLO7A=
X-Google-Smtp-Source: ABdhPJwLaPyqIo3TModQqaQTzbry+MpBoEZINV0Tf9awcBVMm45/RVuKv7ukc5884Kr2Bn6vZYWJn6S862jwIVYkdQ4=
X-Received: by 2002:a2e:8707:: with SMTP id m7mr24050201lji.350.1594252329252;
 Wed, 08 Jul 2020 16:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl> <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl> <CAPhsuW59Q7mU9WH36RHs9kb-TMk7FmrQL+JCApupf_TZtpWynA@mail.gmail.com>
 <4a03e900-61a8-f150-9be8-739e88ba8ce6@yandex.pl> <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
 <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl> <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
 <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl> <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
 <57247f5e-ec38-fb8c-9684-abbe699945fb@yandex.pl> <CAPhsuW4hnpsbhQWWNKqgnw4nhp4Ho+gFbPU2fGjoMOcM8y7L+Q@mail.gmail.com>
 <15a3dd66-39a9-894d-3e72-d231cf36758e@yandex.pl> <4577498e-4124-ac6f-9d76-1f039fa1ba80@yandex.pl>
 <CAPhsuW4Y-23m7JexbnUCO3pq6+yTNrMrN6v-od+FFzZU8PgCdA@mail.gmail.com> <40054126-5009-3633-b7f9-198c2cc53ce7@yandex.pl>
In-Reply-To: <40054126-5009-3633-b7f9-198c2cc53ce7@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jul 2020 16:51:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6tzdneY9C7kiZTC-qhK-se_JhY2e683PQo09QvAqyP6Q@mail.gmail.com>
Message-ID: <CAPhsuW6tzdneY9C7kiZTC-qhK-se_JhY2e683PQo09QvAqyP6Q@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 8, 2020 at 4:29 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 7/7/20 12:08 AM, Song Liu wrote:
> >>
> >> So, what kind of next step after this ?
> >
> > Sorry for the delay. I read the log again, and found the following
> > line caused this issue:
> >
> > [ +16.088243] r5l_write_super_and_discard_space set MD_SB_CHANGE_PENDING
> >
> > The attached patch should workaround this issue. Could you please give it a try?
>
> Yea, this solved the issue - the raid assembled correctly (so the patch
> is probably a good candidate for lts kernels).

Thanks for testing the patch. I will work on applying it to upstream.

>
> Thanks for helping with this bug.
>
> Underlying filesystems are mountable/usable as well - albeit read-only
> fsck (ext4) or btrfs check do find some minor issues; tough to say at
> this point what was the exact culprit.
>
> In this particular case - imho - one issue remains: the assembly is
> slower than full resync (without bitmap), which outside of some
> performance gains (writeback journal) and write-hole fixing - kind of
> completely defeats the point of having such resync policy in the first
> place.

Totally agreed that we need to improve the recovery speed. I will also look
into that.

Thanks again!
Song
