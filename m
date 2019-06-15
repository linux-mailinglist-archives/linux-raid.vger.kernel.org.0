Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27C470DF
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFOPbC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 15 Jun 2019 11:31:02 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42492 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfFOPbB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 15 Jun 2019 11:31:01 -0400
Received: by mail-qk1-f171.google.com with SMTP id b18so3631148qkc.9
        for <linux-raid@vger.kernel.org>; Sat, 15 Jun 2019 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPs3QItKBnkZhIcjl0GCUcaxE8SXyhyWjJr6/deH1Po=;
        b=dYaxIn08kXBVTyfBJVy3CJHORSxD7F9ATJ898gr9yrUfNcvxo6Lc3xLvtSKDdz/Gsp
         jTSKqDQndzEQIeMbVX1b5T5S2pi7CZuaQ/Ne24tmFISYQ2ZWL0jAPaQBBDOrm9WQ2Ypy
         NiKslE0jyalZZrxnpmVRh9YAJCdVXem6mjaRNQPZDz34XxSZZxCyoyFou+bTQf+xXQ0I
         PttZS7zFywC3dEoqANr72lKs/wcRnNuSLxQfMf2iDQmIbTSwfVbtqBKUmn3ay9Hm9RtE
         /IylMtWFudRsksTblm4l1E+P3D1XNsrimrp8d3SWi10PWT9REX6TzUMIgchGLOpuRMS7
         z/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPs3QItKBnkZhIcjl0GCUcaxE8SXyhyWjJr6/deH1Po=;
        b=ewd9vVXQVfoa+Pk6gLjzsEuLw7BzP8rskV5R7Y7umqsAW1ORaoVU+z9HGIWd3nAMp1
         hHJ8LG7dt6J8OUjlxWs/lVAJGpQjQJbgT3mJjncQH9zlHED+3Lo6G1q3QQF2dTz/DV2D
         3INPRDAngozltprlDlxo6hoob0PTvtL1Fi88DwRGQkAgnxjxBhQSRVgfeX2RIKULweEx
         /aYLWVC9cmc/AoQO654qFBZY0ThTCmzVqt0AneVsOCfjg0dDBOpwJELJxHjQ0/K8djOJ
         M+j/fELJGLkpRza89rklQ5nABFmXWQewd3eIslzyrXP3aYUuQ913MYYt0b4uFntOdQR8
         USkw==
X-Gm-Message-State: APjAAAWxsHSk2KuXkJAldOUHp0gHv6K9MfScrc9ZbjHl8zlq5o9ABOgz
        B3fBKSvKRotoXUjFuZMVJXxjWAFqEv/bg7ck89GEWw==
X-Google-Smtp-Source: APXvYqyMeSlCpwx4+jVwjGmOcBfAkgBXHX3UhX/OMg/bnGAF39LJDokqvIfVZeK61H6910/AviaWyATOP50tXmkWXzg=
X-Received: by 2002:a37:4e92:: with SMTP id c140mr81598100qkb.48.1560612661048;
 Sat, 15 Jun 2019 08:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com> <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
In-Reply-To: <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 15 Jun 2019 08:30:47 -0700
Message-ID: <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
Subject: Re: md0: bitmap file is out of date, resync
To:     Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Jun 15, 2019 at 1:27 AM Mathias G <newsnet-mg-2016@tuxedo.ath.cx> wrote:
>
> Hi Song
>
> Thanks for your reply.
>
> On 15.06.19 02:39, Song Liu wrote:
> > To be clear, this does not happen every time, right?
> This is correct. There are alot of shutdown/reboot sequences without any
> issues.
>
> > And the bitmap is stored in a file? And the file is on a different disk, right?
> No, the bitmap is stored internal.
>
> An printout of the mdadm details:
> > # mdadm --detail /dev/md0
> > /dev/md0:
> >            Version : 1.2
> >      Creation Time : Wed May 16 00:35:33 2018
> >         Raid Level : raid1
> >         Array Size : 1953382464 (1862.89 GiB 2000.26 GB)
> >      Used Dev Size : 1953382464 (1862.89 GiB 2000.26 GB)
> >       Raid Devices : 2
> >      Total Devices : 2
> >        Persistence : Superblock is persistent
> >
> >      Intent Bitmap : Internal
> >
> >        Update Time : Sat Jun 15 10:20:19 2019
> >              State : clean, resyncing
> >     Active Devices : 2
> >    Working Devices : 2
> >     Failed Devices : 0
> >      Spare Devices : 0
> >
> > Consistency Policy : bitmap
> >
> >      Resync Status : 32% complete
> >
> >               Name : $hostname:0  (local to host $hostname)
> >               UUID : 4635f0fe:f2676778:6e9451dc:92a18ede
> >             Events : 233032
> >
> >     Number   Major   Minor   RaidDevice State
> >        0       8       17        0      active sync   /dev/sdb1
> >        3       8       33        1      active sync   /dev/sdc1
>
> Let me know if you need more details.

The events count is just off by 1, so it looks like the bitmap's super
block didn't got update properly. From the code in latest upstream,
we write the superblock with REQ_SYNC, but not REQ_OP_FLUSH
or REQ_FUA, so this _might_ be the problem.

Question: are you running the two drives with write cache on?
If yes, and if your application is not heavy on writes, could you try
turn off HDD write cache and see if the issue repros?

Thanks,
Song

> --
> thanks alot!
>
> regards,
>  mathias
