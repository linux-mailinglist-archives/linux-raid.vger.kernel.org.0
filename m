Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64871F4662
	for <lists+linux-raid@lfdr.de>; Tue,  9 Jun 2020 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgFIShK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jun 2020 14:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgFIShJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 9 Jun 2020 14:37:09 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602A620691
        for <linux-raid@vger.kernel.org>; Tue,  9 Jun 2020 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591727828;
        bh=u1XRRcH/7pLg+NuZvueEjnqPYgwXwgVBDaiLxB/t1sU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A6eMhqlC5gYXBNqJKG9F6Hm10T4om2R6iEb41Wc7vwpXKyeeJSblsBnzPceDa5slN
         m2G+TQ+BCMbdIkRB/z0vEFiY2MH0csHd8t6X0PNrBdNRe4ziLhgjBLnCf+jzahphsu
         zlnt+fiG42eshjUcWS6dlJmPMBB9lHfHhYQ/4+Ac=
Received: by mail-lj1-f174.google.com with SMTP id 9so16709498ljv.5
        for <linux-raid@vger.kernel.org>; Tue, 09 Jun 2020 11:37:08 -0700 (PDT)
X-Gm-Message-State: AOAM532XIlqjD7AVmQe8cI7a2D6/kLRlFbdXWodz6WTHlKuenqd1OWul
        rWrqKImnaxZqTMQzBOtmtbLDGeLWxWFBb/OjMYE=
X-Google-Smtp-Source: ABdhPJwzeFMXarfRsS+faKyQybDm1uMguA/ncOkPESIVKhA0ZPcE5W65aoBhuK1I3BooMxBO98r19wdfCt6wjzq0JWc=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr10526573ljk.273.1591727826697;
 Tue, 09 Jun 2020 11:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl> <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl> <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl> <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl> <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
 <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl> <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
 <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
 <0cf6454d-a8b5-4bee-5389-94b23c077050@yandex.pl> <CAPhsuW51u6KWLvUntMXPU7stu7oSA+d-yT6zf7G0zCETzLWwiA@mail.gmail.com>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl> <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
In-Reply-To: <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Tue, 9 Jun 2020 11:36:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
Message-ID: <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 9, 2020 at 2:36 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 6/5/20 2:26 PM, Michal Soltys wrote:
> > On 6/4/20 12:07 AM, Song Liu wrote:
> >>
> >> The hang happens at expected place.
> >>
> >>> [Jun 3 09:02] INFO: task mdadm:2858 blocked for more than 120 seconds.
> >>> [  +0.060545]       Tainted: G            E
> >>> 5.4.19-msl-00001-gbf39596faf12 #2
> >>> [  +0.062932] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >>> disables this message.
> >>
> >> Could you please try disable the timeout message with
> >>
> >> echo 0 > /proc/sys/kernel/hung_task_timeout_secs
> >>
> >> And during this wait (after message
> >> "r5c_recovery_flush_data_only_stripes before wait_event"),
> >> checks whether the raid disks (not the journal disk) are taking IOs
> >> (using tools like iostat).
> >>
> >
> > No activity on component drives.
>
> To expand on that - while there is no i/o activity whatsoever at the component drives (as well as journal), the cpu is of course still fully loaded (5 days so far):
>
> UID        PID  PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
> root      8129  6755 15   740  1904  10 Jun04 pts/2    17:42:34 mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdj1 /dev/sdi1 /dev/sdg1 /dev/sdh1
> root      8147     2 84     0     0  30 Jun04 ?        4-02:09:47 [md124_raid5]

I guess the md thread stuck at some stripe. Does the kernel have
CONFIG_DYNAMIC_DEBUG enabled? If so, could you please try enable some pr_debug()
in function handle_stripe()?

Thanks,
Song
