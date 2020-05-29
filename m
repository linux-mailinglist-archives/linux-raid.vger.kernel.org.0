Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C31E8969
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgE2VDP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 17:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE2VDP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 17:03:15 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2904620776
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 21:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786194;
        bh=03q0yMhGFiI3tcR+2tmRw39bry6Mhg59c3dl0q14JSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IwTh6QsztOLphTv9o9qBCNfgwf0ngBGe1134H8A7t6i8I8BSXvv2Yixgiv1WRRpsY
         ddwqAC86ReWyfRjH0bMCmZH6xbWPGvGkylrtE66ekomybe9/8XTcBsgtGc4uG5E2s4
         zZRYgfxco4I6/Ibc7Ktbgn8p0B9VEpFKMYa0QQtk=
Received: by mail-lj1-f171.google.com with SMTP id c11so961137ljn.2
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 14:03:14 -0700 (PDT)
X-Gm-Message-State: AOAM5300+Eqi3KTiVXP0HvpPV+9T2Urw33ItO5hzs31xwzqkMtFDhDec
        QWMbGr8V3YnWb/IQcmzEm2Pyu7/GSfz4kQRPrnM=
X-Google-Smtp-Source: ABdhPJyF8ZqWZc27v2vt3YFilBRQyNoB5YQLd/E94ge6P2o7+5lP3WWRpSFdWH5/1xMvjww0/mdiNs44sLCCC+qW4uw=
X-Received: by 2002:a2e:b004:: with SMTP id y4mr5298044ljk.273.1590786192316;
 Fri, 29 May 2020 14:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl> <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl> <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl> <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl> <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl> <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com> <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl>
In-Reply-To: <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Fri, 29 May 2020 14:03:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
Message-ID: <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, May 29, 2020 at 5:09 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 5/28/20 5:06 PM, Song Liu wrote:
> >
> > For the next step, could you please try the following the beginning of
> > --assemble
> > run?
> >
> >     trace.py -M 10 'r::r5l_recovery_verify_data_checksum()(retval != 0)'
> >
> > Thanks,
> > Song
> >
>
> How long should I keep this one running ? So far - after ~1hr - nothing
> got reported.

We can stop it. It didn't really hit any data checksum error in early phase
of the recovery. So it did found a long long journal to recover.

Thanks,
Song
