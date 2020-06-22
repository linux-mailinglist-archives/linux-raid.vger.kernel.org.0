Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691FA203CB8
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jun 2020 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgFVQiH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jun 2020 12:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgFVQiG (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 22 Jun 2020 12:38:06 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD022073E
        for <linux-raid@vger.kernel.org>; Mon, 22 Jun 2020 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592843885;
        bh=K0sULFraoBOftVo7FSEog6i1lXIzxej1wCEo1lpFtGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFzd3WlYf0O9jWRxoc7SJKi+r8MMLQBb9jUSea1gk56zb6AhI68O0m/b/V2SqFnCS
         ToT4rEZ04LTqXB1HRUa6Dv2ZWA+PAkbjTnQBnfL7tOPfoNva57o5ND7dqWdVvx5S/E
         cqMShw8fghxQCKimUOASoviAAKf8ASyBJsjbRsPM=
Received: by mail-lj1-f173.google.com with SMTP id z9so20055067ljh.13
        for <linux-raid@vger.kernel.org>; Mon, 22 Jun 2020 09:38:05 -0700 (PDT)
X-Gm-Message-State: AOAM531sxicbgeLv8kZcztKL95NXVHSNyJyyJCIiO5B5fU1oU4+sCnC+
        MO4mGKZP/FaeZQIVqO2RyFom0Q7W8F5vh5+65AI=
X-Google-Smtp-Source: ABdhPJxJkmx2xvfmeS8kv1dWhSuni9o/EOw7Qk/QbhFVM36WhjMYcyiUWTq/IEATt81RdsOYTMr2CeFV325vHAhlC9g=
X-Received: by 2002:a05:651c:1130:: with SMTP id e16mr9066053ljo.10.1592843883784;
 Mon, 22 Jun 2020 09:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
 <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl> <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
 <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
 <0cf6454d-a8b5-4bee-5389-94b23c077050@yandex.pl> <CAPhsuW51u6KWLvUntMXPU7stu7oSA+d-yT6zf7G0zCETzLWwiA@mail.gmail.com>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl> <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl> <CAPhsuW59Q7mU9WH36RHs9kb-TMk7FmrQL+JCApupf_TZtpWynA@mail.gmail.com>
 <4a03e900-61a8-f150-9be8-739e88ba8ce6@yandex.pl> <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
 <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl> <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
 <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl>
In-Reply-To: <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 Jun 2020 09:37:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
Message-ID: <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 22, 2020 at 4:12 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 6/20/20 2:14 AM, Song Liu wrote:
> > On Fri, Jun 19, 2020 at 4:35 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
> >>
> >> On 6/17/20 7:11 PM, Song Liu wrote:
> >>>>
> >>>>> 1. There are two pr_debug() calls in handle_stripe():
> >>>>>           pr_debug("handling stripe %llu, state=%#lx cnt=%d, "
> >>>>>           pr_debug("locked=%d uptodate=%d to_read=%d"
> >>>>>
> >>>>>        Did you enable all of them? Or only the first one?
> >>>>
> >>>> I enabled all of them (I think), to be precise:
> >>>>
> >>>> echo -n 'func handle_stripe +p' >/sys/kernel/debug/dynamic_debug/control
> >>>>
> >>>> Haven't seen any `locked` lines though.
> >>>
> >>> That's a little weird, and probably explains why we stuck. Could you
> >>> please try the attached patch?
> >>>
> >>> Thanks,
> >>> Song
> >>>
> >>
> >> I've started assembly with the above patch, the output can be inspected
> >> from this file:
> >>
> >> https://ufile.io/yx4bbcb4
> >>
> >> This is ~5mb packed dmesg from start of the boot to the relevant parts,
> >> unpacks to ~150mb file.
> >
> > Thanks for the trace. Looks like we may have some issues with
> > MD_SB_CHANGE_PENDING.
> > Could you please try the attached patch?
>
> Should I run this along with pr_debugs from the previous patch enabled ?

We don't need those pr_debug() here.

Thanks,
Song
