Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649F01E657A
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbgE1PGw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 11:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403787AbgE1PGw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 11:06:52 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B402075F
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590678411;
        bh=vdK2kffh53N2uGMQCIdN1RyyBYNDRGuOGamDT2tKM5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uc3AP+zue/IdkSa1WanAIdgr3tqovB1XDGaaYUjxm3zfg7VcnvJqvp/YPl9a6ExVW
         Wvy93MHdlvkAZMVS3EVqD2nyTXVnrGHHFY+/jfY9iqVDocNNfiLg/XynbdCJCOwNi5
         49cXHdowEM7byUmQR32Kz0j/8jKHo+E49pv/m9KI=
Received: by mail-lf1-f49.google.com with SMTP id 82so16772152lfh.2
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 08:06:50 -0700 (PDT)
X-Gm-Message-State: AOAM531BCO1z6qIAO3MBVnCTnCdCzDFpj5UOS0kDX4dwcATw5bLvJF5F
        JTuJzGdOR2TTkD3nulIKLZEbBWHa++JipDOH2G0=
X-Google-Smtp-Source: ABdhPJzUoLeOcflyH2D3ubCIKaFBrVfEZMOlGcaqkuXH92s+aXE8MWnab5yzcfejfOWz0mphW9RuEGNYDSYsO0gn/gM=
X-Received: by 2002:a19:ed17:: with SMTP id y23mr1917061lfy.162.1590678408941;
 Thu, 28 May 2020 08:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl> <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl> <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl> <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl> <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl> <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
In-Reply-To: <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 May 2020 08:06:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
Message-ID: <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 28, 2020 at 3:18 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 5/27/20 3:36 PM, Michal Soltys wrote:
> > On 5/27/20 1:37 AM, Song Liu wrote:
> >>
[...]

> To expand on the above (mdadm was started yesterday):
>
> - it went on for ~19+ hours - like previously
> - the last piece in trace output:
>
> xs22:/home/msl=E2=98=A0 tail -n 4 trace.out ; echo
> 09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8b0
> 09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8b8
> 09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8c0
> 09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8c8
>
> So it went through ~120gb of journal (the journal device is 256gb).

This (processing more than 10GB) should not happen. So there must be
something wrong...

> Non-assembling raid issue aside (assuming it's unrelated) - why does it
> take such enormous amount of time ? That's average of like 1.7mb/s

This is slow because we are processing 4kB at a time. But it is slower than
my expectation. What are the speeds measured at boot? Something like the
following in dmesg:

[    3.851064] raid6: avx2x4   gen() 17328 MB/s
[    3.877404] raid6: avx2x4   xor() 11033 MB/s
[    3.903410] raid6: avx2x2   gen() 14710 MB/s
[    3.929410] raid6: avx2x2   xor()  8921 MB/s
[    3.955408] raid6: avx2x1   gen() 12687 MB/s
[    3.981405] raid6: avx2x1   xor()  8414 MB/s
[    4.007409] raid6: sse2x4   gen()  9105 MB/s
[    4.033403] raid6: sse2x4   xor()  5724 MB/s
[    4.059408] raid6: sse2x2   gen()  7570 MB/s
[    4.085410] raid6: sse2x2   xor()  4880 MB/s
[    4.111409] raid6: sse2x1   gen()  6484 MB/s
[    4.137402] raid6: sse2x1   xor()  4412 MB/s

For the next step, could you please try the following the beginning of
--assemble
run?

   trace.py -M 10 'r::r5l_recovery_verify_data_checksum()(retval !=3D 0)'

Thanks,
Song

PS: Some key functions here are inlined and thus not easily traceable. We w=
ill
probably need to patch the kernel for further debugging.

>
> Around 09:08 today, the recovery line popped in the dmesg as previously:
>
> [May27 12:58] md: md124 stopped.
> [  +0.006779] md/raid:md124: device sdf1 operational as raid disk 0
> [  +0.006929] md/raid:md124: device sdj1 operational as raid disk 3
> [  +0.006903] md/raid:md124: device sdi1 operational as raid disk 2
> [  +0.006914] md/raid:md124: device sdh1 operational as raid disk 1
> [  +0.007426] md/raid:md124: raid level 5 active with 4 out of 4
> devices, algorithm 2
> [May28 09:08] md/raid:md124: recovering 24667 data-only stripes and
> 50212 data-parity stripes
