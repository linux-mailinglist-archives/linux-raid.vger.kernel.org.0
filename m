Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DEC1F5D62
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jun 2020 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgFJUuk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jun 2020 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUuk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 10 Jun 2020 16:50:40 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63402C03E96B
        for <linux-raid@vger.kernel.org>; Wed, 10 Jun 2020 13:50:40 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id r9so1367992ual.1
        for <linux-raid@vger.kernel.org>; Wed, 10 Jun 2020 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EaiG3NsuD5JvpXEhY1J4wSvi9QR4BFPP6lshTzXI+A=;
        b=T7eY78VBZcHO1q12aJKdW+AimReNdKp07eUhL7Q9QaM1/ifpOBQBH6/E+vl6OnM+4l
         qVoVwGNKaxZ49yLde9G+a+qW0fwsti0xpmYGtnd+m2KVE0S2PBGBfn6HXmKYuwh/NQG4
         G5SHnxj0uEhmP0J2jQ6HUiCliLSl0nld//JFbBbuiMbYTrbWHpRo7iO+YpVcAMTOa50c
         +DPLXusjpJKrGOzj3FyzCLHcvO82CxmUOgowEMY3x8PV6f5l4ub0Qo3AoOVnZsvvO/SP
         nepbygfk3S3sAWxarCo44DsZyx0THEtdPrWU3L5pPUT2XfbTbg06GF0WWhWX6mul08SA
         GgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EaiG3NsuD5JvpXEhY1J4wSvi9QR4BFPP6lshTzXI+A=;
        b=IC/KDbEVM9eeOWXLA9+XlK1Tz9Nk12EChRx2Z3su0mbJD/4GEfg7JmeXqTMmi/SP2F
         CCcm7LHIQYp5vQW+3PUaVsjM3JHPB3VFUGt+I+x7ULg2lIDBSp+ajubL6ceJXZjqVd2X
         lGDObz/hdzZY1V1UCymLHesEOtLzsFZHBxX7V/E1mIb+uqnh75BeEDzivZ86uAG7zI+d
         SUk8PdWRNyXrnsjeEStr14MO1YHmraGcPEWg6dmUSVosDj0DJoxKZvZe7U8v7Wrhnbb0
         rNBDNSrWgiFq2f+wMNssYbpfqwo/DrLLkE1QbocqzGGZx7xcTe3aOi2PuNYJOJA+CkoX
         h2Pg==
X-Gm-Message-State: AOAM531Za7ZWzu493WWl6pWfhwIX4v+W5ByxgBDm+4yevpkT2HF07wV5
        VOZuXMpjY71Qb3u8lOuHMmVbmWuV3yAdzBLbg+WGKVSS+B8=
X-Google-Smtp-Source: ABdhPJwmPLLe428KNJCH/HvwXP4HwtQrinPJSFyOk2bWDqn5WRd/X0uOQUGS+PQsPpKOf0z3pJOFwRs1anrC31rLV+M=
X-Received: by 2002:ab0:72ca:: with SMTP id g10mr4106886uap.16.1591822239483;
 Wed, 10 Jun 2020 13:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAH6h+heYBA5RvBH7GPJ6JkPUYvjxT2A4f_gBVs=Pr-ps6rPRQw@mail.gmail.com>
 <CAPhsuW4UTJZHSQRHt3V2oPAkz8KD1YpG2YNBBg20cBujTCnzug@mail.gmail.com> <CAH6h+he2=_1hgBm3hJ4KAnqxHkPgFj3+q-pPTRHrro1vzxgg3w@mail.gmail.com>
In-Reply-To: <CAH6h+he2=_1hgBm3hJ4KAnqxHkPgFj3+q-pPTRHrro1vzxgg3w@mail.gmail.com>
From:   Marc Smith <msmith626@gmail.com>
Date:   Wed, 10 Jun 2020 16:50:28 -0400
Message-ID: <CAH6h+hfV-JeoRvbEFVpyLTnGhtFLJbDuw_+V=fBU2FFdYFuMYA@mail.gmail.com>
Subject: Re: MD Array 'stat' File - Sectors Read
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Apr 11, 2020 at 12:59 AM Marc Smith <msmith626@gmail.com> wrote:
>
> On Thu, Apr 9, 2020 at 3:11 AM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Mar 30, 2020 at 1:55 PM Marc Smith <msmith626@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > Apologies in advance, as I'm sure this question has been asked many
> > > times and there is a standard answer, but I can't seem to find it on
> > > forums or this mailing list.
> > >
> > > I've always observed this behavior using 'iostat', when looking at
> > > READ throughput numbers, the value is about 4 times more than the real
> > > throughput number. Knowing this, I typically look at the member
> > > devices to determine what throughput is actually being achieved (or
> > > from the application driving the I/O).
> > >
> > > Looking at the sectors read field in the 'stat' file for an MD array
> > > block device:
> > > # cat /sys/block/md127/stat && sleep 1 && cat /sys/block/md127/stat
> > > 93591416        0 55082801792        0       93        0        0
> > >   0        0        0        0        0        0        0        0
> > > 93608938        0 55092996456        0       93        0        0
> > >   0        0        0        0        0        0        0        0
> > >
> > > 55092996456 - 55082801792 = 10194664
> > > 10194664 * 512 = 5219667968
> > > 5219667968 / 1024 / 1024 = 4977
> > >
> > > This device definitely isn't doing 4,977 MiB/s. So now my curiosity is
> > > getting to me: Is this just known/expected behavior for the MD array
> > > block devices? The numbers for WRITE sectors is always accurate as far
> > > as I can tell. Or something configured strangely on my systems?
> > >
> > > I'm using vanilla Linux 5.4.12.
> >
> > Thanks for the report. Could you please share output of
> >
> >    mdadm --detial /dev/md127
> >
>
> # mdadm --detail /dev/md127
> /dev/md127:
>            Version : 1.2
>      Creation Time : Tue Mar 17 17:23:00 2020
>         Raid Level : raid6
>         Array Size : 17580320640 (16765.90 GiB 18002.25 GB)
>      Used Dev Size : 1758032064 (1676.59 GiB 1800.22 GB)
>       Raid Devices : 12
>      Total Devices : 12
>        Persistence : Superblock is persistent
>
>        Update Time : Thu Apr  9 13:07:12 2020
>              State : clean
>     Active Devices : 12
>    Working Devices : 12
>     Failed Devices : 0
>      Spare Devices : 0
>
>             Layout : left-symmetric
>         Chunk Size : 64K
>
> Consistency Policy : resync
>
>               Name : node-126c4f-1:P2024_126c4f_01  (local to host
> node-126c4f-1)
>               UUID : ceccb91b:1e975007:3efb5a9d:eda08d04
>             Events : 79
>
>     Number   Major   Minor   RaidDevice State
>        0       8        0        0      active sync   /dev/sda
>        1       8       16        1      active sync   /dev/sdb
>        2       8       32        2      active sync   /dev/sdc
>        3       8       48        3      active sync   /dev/sdd
>        4       8       64        4      active sync   /dev/sde
>        5       8       80        5      active sync
>        6       8       96        6      active sync   /dev/sdg
>        7       8      112        7      active sync   /dev/sdh
>        8       8      128        8      active sync   /dev/sdi
>        9       8      144        9      active sync   /dev/sdj
>       10       8      160       10      active sync   /dev/sdk
>       11       8      176       11      active sync   /dev/sdl
>
>
> > and
> >
> >    cat /proc/mdstat
>
> # cat /proc/mdstat
> Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
> md127 : active raid6 sda[0] sdl[11] sdk[10] sdj[9] sdi[8] sdh[7]
> sdg[6] sdf[5] sde[4] sdd[3] sdc[2] sdb[1]
>       17580320640 blocks super 1.2 level 6, 64k chunk, algorithm 2
> [12/12] [UUUUUUUUUUUU]
>
> unused devices: <none>
>
>
> Thanks; please let me know if there is any more detail I can provide.

I was about to follow-up on this issue, but then I noticed a couple
recent patches are being discussed and it sounds like these will
resolve what I reported above:
https://marc.info/?l=linux-raid&m=159102814820539
https://marc.info/?l=linux-raid&m=159149103212326

I'll see how these play out and report back if needed.


Thanks,

Marc



>
> --Marc
>
>
> >
> > Song
