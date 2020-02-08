Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2401562B0
	for <lists+linux-raid@lfdr.de>; Sat,  8 Feb 2020 03:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgBHCRI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 21:17:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35520 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBHCRI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 21:17:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so1240769otd.2
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 18:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xh4DjlGI9E6+hbayMzHlZTSsZPcxnsH4MFoYyy+jTg=;
        b=RknrgrOLDbEhW2BgW26b5frubIWW0Q/OK+rIqIOMxj/bcs15UNRZfBstYhJnAHySji
         xatKf6bBMSG/t6V5Vt3iPEIPuo/GF7x25ekVLlzVLYY58a3g4ScNNglWjGqDhQzIgaUA
         I8B+cCmoM3H/W18IQwhLsPmOdGrRe4kWdsldBgfs7YWFSMZaSpFR8itlftxtA4snUwMW
         mXxOgZJxbNb5Q4uysHMsV/jlGuMtTm0jekGVz9URTI0fX/HA0d8EQClS3FI/7cv9eRZh
         ONuDjH/EjJgC9WOiwNmJAFSGIKIqD8caHezPagyc6JUErnmGnUcLMBtdculHBTh1ocB4
         V1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xh4DjlGI9E6+hbayMzHlZTSsZPcxnsH4MFoYyy+jTg=;
        b=JehW9H8myzcM7QDP6jUkz7QrODsbMuo8cZepro06hmcFK8S9Lg2MXG6XYTSGNCRRFr
         ZPpTTA0WpHYAq0IFGk41StvlO21XGNRxPz08Lz8GOcyH6BSyL6zNHmDbb/0wviwhOxo9
         LyHbH8TdHzJYWEZtlNtpdKmzF+EwYZbuQHrflWhwEihUZf6GOuvvdALayk7q8/6mKV9t
         05WWFhl/0A6GspuPwscAknH/eGV6S/6n3C4csxPxUidHM+jVfBxfkV312qwZbZuLqDLn
         DbfEiHb16ThbmtCQVi0dtM0dzPs1fXtg86309Jj5sxxMjke9nHMF0ORaR4KTC8esLfpu
         JNLg==
X-Gm-Message-State: APjAAAWLX2TApDv2JlcDSVJqp13t4vXeKUVDPl5B8ADHvkRl3hOVtBIM
        rD9CJFKYIF2K193i+9ybZIgLJXVW3Ier4lS6m34qcJzf
X-Google-Smtp-Source: APXvYqzRGZkh+HyZ6s5BiFTR5jCJIY2r6xjRGxYsbCAhVPsc7JbEf1cqIDtBLUenIB8Fd5qC23Upvlru1+erHOuo30Q=
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr1920759otr.244.1581128227353;
 Fri, 07 Feb 2020 18:17:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com> <CAPpdf58BTV5duFoSfdC6_07+kqQy0zgfq4=PgErJHqVeikjgBA@mail.gmail.com>
 <1faaef72-62ed-2c36-19d7-f6995691779f@prgmr.com> <CAPpdf58wY2G4XpNhfnHG42fHkpT6Z_EtLnLdtTaGvhRG_N5KKA@mail.gmail.com>
 <1a4495cf-bd6a-7e56-46fa-87ed84d9a13c@prgmr.com>
In-Reply-To: <1a4495cf-bd6a-7e56-46fa-87ed84d9a13c@prgmr.com>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 7 Feb 2020 20:16:31 -0600
Message-ID: <CAPpdf5_6LgC4+R0smoMCMqhQ4KTx8q1_WAUfvZnsqUGBKkVPzw@mail.gmail.com>
Subject: Re: Was Re: Question - - - - now: issue resolved
To:     Sarah Newman <srn@prgmr.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Feb 7, 2020 at 7:24 PM Sarah Newman <srn@prgmr.com> wrote:
>
> On 2/7/20 4:56 PM, o1bigtenor wrote:
> > On Fri, Feb 7, 2020 at 5:41 PM Sarah Newman <srn@prgmr.com> wrote:
>
> >> I said the command dmesg, not /var/log.
> >>
> >> If systemd-journald is broken, or your file system is broken, you could have tons of error messages in dmesg and nothing logged to disk.
> >>
> >
> > Found one couplet - - - it might be applicable (please advise):
> >
> > [12458.717443] EXT4-fs (md0p1): warning: maximal mount count reached,
> > running e2fsck is recommended
> > [12459.215097] EXT4-fs (md0p1): mounted filesystem with ordered data
> > mode. Opts: (null)
>
> What it says. You might want to run fsck at some point. Don't do it while the file system is mounted. If fsck wants to make changes, back up your data
> first.
>
> >> just to make sure it hasn't been moved elsewhere on accident. That seems like the most likely scenario given the lack of error messages, unless no
> >> messages at all have been logged due to previously mentioned issues.
> >>
> > Ran the suggested - - - - - well - - - - somehow I managed to drop the directory
> > into a much smaller one. Dunno how that happened or any details (if someone
> > cares to give method(s) and means for determining that I would be very
> > grateful!) but I have now found the missing directory and its contents
> > seem to be intact.
> >
> > I did understand that maybe asking on the linux-raid 'exchange' might not
> > have been the 'best' place to do so but this seemed quite weird and the
> > directory was on a raid-array and I thought that maybe this could be a signal
> > that there were more issues brewing. That seems now not to be the case.
>
> If something in hardware or the kernel is having issues, almost always you will see error messages.
>
> It's also better to do quick and easy checks first even if you don't have a hypothesis for what would have lead to that state.

Thanks for the help!
