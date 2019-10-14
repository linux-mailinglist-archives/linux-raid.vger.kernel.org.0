Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2ED6754
	for <lists+linux-raid@lfdr.de>; Mon, 14 Oct 2019 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfJNQap (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 12:30:45 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40319 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfJNQap (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 14 Oct 2019 12:30:45 -0400
Received: by mail-qt1-f170.google.com with SMTP id m61so26226366qte.7
        for <linux-raid@vger.kernel.org>; Mon, 14 Oct 2019 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vokSOi3llQI9bKCFDRSrc6yW+BiG01VD17ZvPN3AlP0=;
        b=e+GA9nhe6cNcN1o7QR1pDKEvQFW3WHhssCr6Klfl3sNNPSiQG/SbVnXmuX0ixy1nGJ
         IymWfKIZIqnJMlRkZqJ4Zj5AHhR9XZ21y/HYRuKQVJB6ii5FlSl+22WbetKM+hh1Pmqf
         b8uhm7/0n2TwGqmpfS0qjpKnG2sWHLR/fI+6dS34m3TGkLHb9qf2F3eWpYYObtZWjAFj
         Fp/zsJbHwRn3vMBIz367lx95TizysVIIEm9tphwTxWBUmlncz2ZVmkOhek8/EZIw5T+N
         1e+58/dQ3AFEMBII5nQexQaZcVt2eXVVbA/zQajHU4Nhl8nGQBk05IjxjM9+LhQ6xpXe
         bmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vokSOi3llQI9bKCFDRSrc6yW+BiG01VD17ZvPN3AlP0=;
        b=GrnWoa1u2CjLXNvvxpaN+wvQTuO1yl05vmalJ1kTPMSSIgpnG9NmVMZPPdT+PD5TAr
         3hhbos1rAHGbTItBK1ju/mv02KZigveEa5dihSuQDxZPqArGzcx6nhuSQHlH/i6eeS9W
         Lqj5RAAwTvazvnjOMWjuR+nsLyJkTDaa8a85S0ya5wnwtM9QIQBiMAJOJE72Xa+0yxNG
         NP/MX3Yvliw0j2P3hrkRrcqX6A5wALIK1pFaS6CW5fkis9qA5dUd2VzLYvmWt5H5JBIY
         U8txYq/qQCtr3ty7NLv7PhcqZ75YELTkI2Ai7qH9ANzUkGgVeUHi0fCDVlvJfQTcLA2F
         oIgQ==
X-Gm-Message-State: APjAAAVUas8H4u5HNFlgmEBC1dkmEhGa2MVlscUx7O0SneJzekFkaek3
        8BEs6XWBTPaXoZVY0n2b7iJPOTTGkARu3r7sH8k=
X-Google-Smtp-Source: APXvYqx1Pw/MBPnIIPOHbLxsTqKFfcRkmIusVNwo/1zGlg1yTDx+sO2GzOuI3tH+eAr8xzNr+r/yn/KnnGGHAzy8f/0=
X-Received: by 2002:ac8:1a78:: with SMTP id q53mr32929403qtk.379.1571070643858;
 Mon, 14 Oct 2019 09:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <b9b8f42f-cc55-b165-2430-f0c9731002d1@gmail.com>
In-Reply-To: <b9b8f42f-cc55-b165-2430-f0c9731002d1@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 14 Oct 2019 09:30:32 -0700
Message-ID: <CAPhsuW5WiJ9+bKi7Sfra36gCBXF2=38eBu7O_xYL9NYhgn0WbA@mail.gmail.com>
Subject: Re: md/raid0: avoid RAID0 data corruption due to layout confusion. ?
To:     DrYak <doktor.yak@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Oct 14, 2019 at 2:23 AM DrYak <doktor.yak@gmail.com> wrote:
>
> Hello,
>
> I just wanted to point a small thing:
>
> On 2019-10-12 01:37, Song Liu wrote:
> >
> > David, you may consider adding "raid0.default_layout=?" to your kernel
> > command line options.
> >
> > Song
>
> Currently there is a slight mis-match in the actual kernel module:
> the warning message display "raid.default_layout=?" (missing zero)
> instead of "raid0..." (how indeed it should be used).

Good catch! The warning should say raid0. Let me fix it.

Thanks,
Song
