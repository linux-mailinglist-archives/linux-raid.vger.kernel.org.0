Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB26C408E
	for <lists+linux-raid@lfdr.de>; Tue,  1 Oct 2019 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfJAS72 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 14:59:28 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43142 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJAS72 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 14:59:28 -0400
Received: by mail-wr1-f51.google.com with SMTP id q17so16802186wrx.10
        for <linux-raid@vger.kernel.org>; Tue, 01 Oct 2019 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDPjotCjsxHuXGoELEUMC0nmqHCI8zTEJl4hn4LHiEE=;
        b=Kj7EwHydvogT2KwJuVWmuxKRus/5xLw8rD3iAIe2R51FxxdlsjaLTgatxnAl93gLQ1
         04JcPXzI90/h2TY/HUlbcRdVhsqrY2HWB0UtEQ1LtIWwFoxgdCbE0lQzAXRAjkN4hdpp
         WHBaZA0L0h2lus3w0FHWoc8CT+FC0yNzYLFSV1a7AHWsc++s8gbtgslqxQYCMY8fjzot
         efbW7uas46+CEZmtDZ3YZA41FPXfNoZP9BuWDfpRF5QYNhdEAdc3dMIxFW8mD+efz83D
         Jc83tGdvfM1gWoDW3Bz4Neg70qNwaMSsLvQjahlNXABAFrcZeNCEGM1Ik7ld5CjUm2sL
         fD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDPjotCjsxHuXGoELEUMC0nmqHCI8zTEJl4hn4LHiEE=;
        b=CNatAwliU7uxJj7Xsn4swXdgO4eP1g0LQ8Ms3aYPMHzt/R5jVLwn/2eVb4QPUQ9A8l
         LU7FvqLimjdMTw9VgyqMBwieCOMcOwsGMadrWmy8J5e2vh/ixiv++t0vjJIp/OXRQZ4G
         /HMTxlubQ/r0+Ob2T/I8cJEPsOvxpWBI/i3Mbua+6nWMN0ctPXaWC1Hrgg2n0rP+m/Wn
         ijN5RnF3sF5IcZEPcLwOYIXaVTVKsKZGiLpXzYBO+pj33hsWgPEgV2s2afRHR8fwJ/wY
         wIzVvZe6ZIa4v6CO+dvWLjz0dRP1F6jW2dpCRZu7DkuLxxpXIDw3MnS1Xh347YMItFst
         AA7A==
X-Gm-Message-State: APjAAAXLbIZ0U97387vbBJGDShjv2GsxsBSSX55Hqy8YqXX3bNPHYdfR
        MGLm0Go5gt0yHA8e+nzV/nNF5qecLJHSfLftOZh+ZbF8
X-Google-Smtp-Source: APXvYqy5FjXX1x/KIAIkphSnS0nkmr/Z23jRS/sNSlcZR+KOpMKjfZYRu7rpAxFkUGDYR5MQ1TnxbaIPv1GxocgtbcU=
X-Received: by 2002:adf:8b13:: with SMTP id n19mr20378834wra.203.1569956365280;
 Tue, 01 Oct 2019 11:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
 <20190930101443.GA2751@metamorpher.de> <6026f55f-82c9-7b99-8c2b-8d03dfe8f52e@suddenlinkmail.com>
In-Reply-To: <6026f55f-82c9-7b99-8c2b-8d03dfe8f52e@suddenlinkmail.com>
From:   "David F." <df7729@gmail.com>
Date:   Tue, 1 Oct 2019 11:59:14 -0700
Message-ID: <CAGRSmLvHc-gOVmr-fHTo0upUeDNjrQgCk9rSqpALFV1FiHra+g@mail.gmail.com>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>
Cc:     mdraid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

mdadm shouldn't be scanning fd0 or sr0 by default, maybe an option to
make it scan them if they exist would be better.

also because so many tools use /proc/partitions and non partitioned
devices (in real-world, not theoretical or testing) are in there,
maybe better to have option if sr and fd devices should populate there
at all.

On Tue, Oct 1, 2019 at 11:15 AM David C. Rankin
<drankinatty@suddenlinkmail.com> wrote:
>
> On 09/30/2019 05:14 AM, Andreas Klauer wrote:
> > On Sun, Sep 29, 2019 at 03:54:41PM -0700, David F. wrote:
> >> So /proc/partitions can have floppy and optical drives on it.
> >
> > And people might rely on that so removing it is the wrong approach.
> >
>
> and people do...
>
> cat /proc/partitions
> major minor  #blocks  name
>
>    2        0          4 fd0
>    8       16  976762584 sdb
>    8        0  976762584 sda
>    8       32  732574584 sdc
>   11        0    1048575 sr0
>
>
>
>
> --
> David C. Rankin, J.D.,P.E.
