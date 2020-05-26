Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6331E33CA
	for <lists+linux-raid@lfdr.de>; Wed, 27 May 2020 01:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgEZXiC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 26 May 2020 19:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEZXiC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 26 May 2020 19:38:02 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AC620899
        for <linux-raid@vger.kernel.org>; Tue, 26 May 2020 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590536281;
        bh=Z5edb9GkEGIO2RTFywZYMyxinfAym9Qzy7BurUxSH2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V29/3sV0B70OWlGH+bWf5Cl2KOlYF9CggouLNj3HeUKJVuaii9eDNbGQDW12LdzyN
         MwXNMv2ktphGOSlNMPRsXcnkNaEKrp7PQR0NiawJKO9xYUFTVqDxRQ2MSPcqatr22y
         CV1z9U0REZyIxU8vQLC7/+VFT2S6r07BD6bbXBgo=
Received: by mail-lj1-f179.google.com with SMTP id v16so26722641ljc.8
        for <linux-raid@vger.kernel.org>; Tue, 26 May 2020 16:38:00 -0700 (PDT)
X-Gm-Message-State: AOAM532A4eX0E/manxyjuvE8+V7whd20UCJYQphXslRwzwcDpGdZZEPl
        Wyhr9hZFgdX/owShibeWzMk3iv2TMbwHeh8RQX8=
X-Google-Smtp-Source: ABdhPJyGJgeTrUhuH72Fl9Rf7xZgnffo8Waqz/T5olO0NxgtozumOJ0UL+WyMSXPKKr3V74eWY1D9XzWWPDmWE6M0tk=
X-Received: by 2002:a2e:9242:: with SMTP id v2mr1693994ljg.41.1590536279077;
 Tue, 26 May 2020 16:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl> <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl> <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl> <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl>
In-Reply-To: <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 May 2020 16:37:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
Message-ID: <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 25, 2020 at 9:23 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 5/19/20 1:55 AM, Song Liu wrote:
> >
> > 2. try use bcc/bpftrace to trace r5l_recovery_read_page(),
> > specifically, the 4th argument.
> > With bcc, it is something like:
> >
> >      trace.py -M 100 'r5l_recovery_read_page() "%llx", arg4'
> >
> > -M above limits the number of outputs to 100 lines. We may need to
> > increase the limit or
> > remove the constraint. If the system doesn't have bcc/bpftrace. You
> > can also try with
> > kprobe.
> >
>
>
> Trace keeps outputting the following data (with steadily growing 4th
> argument):
>
> PID     TID     COMM            FUNC             -
> 3456    3456    mdadm           r5l_recovery_read_page 98f65b8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65c0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65c8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65d0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65d8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65e0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65e8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65f0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65f8
> 3456    3456    mdadm           r5l_recovery_read_page 98f6600
> 3456    3456    mdadm           r5l_recovery_read_page 98f65c0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65c8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65d0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65d8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65e0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65e8
> 3456    3456    mdadm           r5l_recovery_read_page 98f65f0
> 3456    3456    mdadm           r5l_recovery_read_page 98f65f8
> 3456    3456    mdadm           r5l_recovery_read_page 98f6600
> 3456    3456    mdadm           r5l_recovery_read_page 98f6608
> 3456    3456    mdadm           r5l_recovery_read_page 98f6610
>
> ... a few minutes later ...
>
> PID     TID     COMM            FUNC             -
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b60
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b68
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b70
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b78
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b80
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b88
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b90
>
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b98
> 3456    3456    mdadm           r5l_recovery_read_page 9b69ba0
> 3456    3456    mdadm           r5l_recovery_read_page 9b69ba8
>
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69bb0
>
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69bb8
> 3456    3456    mdadm           r5l_recovery_read_page 9b69bc0
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69bc8
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b90
>
>
> 3456    3456    mdadm           r5l_recovery_read_page 9b69b98
> 3456    3456    mdadm           r5l_recovery_read_page 9b69ba0
> 3456    3456    mdadm           r5l_recovery_read_page 9b69ba8
> 3456    3456    mdadm           r5l_recovery_read_page 9b69bb0
> 3456    3456    mdadm           r5l_recovery_read_page 9b69bb8
>
> ... and so on

Looks like the kernel has processed about 1.2GB of journal (9b69bb8 -
98f65b8 sectors).
And the limit is min(1/4 disk size, 10GB).

I just checked the code, it should stop once it hits checksum
mismatch. Does it keep going
after half hour or so?

Thanks,
Song
