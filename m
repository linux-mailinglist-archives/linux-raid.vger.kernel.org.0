Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFB1A4E12
	for <lists+linux-raid@lfdr.de>; Sat, 11 Apr 2020 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDKE7u (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 Apr 2020 00:59:50 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:46708 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgDKE7u (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 Apr 2020 00:59:50 -0400
Received: by mail-ua1-f47.google.com with SMTP id o14so1325043uat.13
        for <linux-raid@vger.kernel.org>; Fri, 10 Apr 2020 21:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnsBfWVQQTZVsf6XE4i9ln6jk8a2jUqyr7NevDn6ZPk=;
        b=LpWvaNToUZ7HaZS3YwmSLQ5Hd9/Frt2D2hmwlZ2s9w/5nWonRyTzbmRhCMPBHE7t8O
         vCPCIBXtI6ziUh/h0JimJorwuV0a/d0Q/GdjNTa1y2t4KjENfA6HmBV4BqjxGdy7yGuD
         zJFCMpKMpqPwwy4Fn3jHvqYeknty2O2jApDaZAxvi6ohcJ2nlrAuLUaBfpp0vkMi8anA
         guqdQyFNOY91IOyWmwr05UKF1zxo+FVfrkiwPFLTxv0SaJk/ULc9hYrLQ5tpWF/h0POj
         vdEXG8UhjqGg0r0m0VCWooRtKZHmSkqKO7+3w1hPH2Oswo/aEkipBUcM6On54pTw58vX
         A7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnsBfWVQQTZVsf6XE4i9ln6jk8a2jUqyr7NevDn6ZPk=;
        b=fhCh5wyPBSOI3pPGtxalAjzrVBMgnTi2JuxHLlue30bBwmsS85TxZeBm4yRyS9dgd9
         CjZ9ORDCxD73mL50CPgsg+zp8RDR+qzQRRvBbrgKTd7O6vOY8+WU/yGoKJ2d+Nt2lDfX
         jgsJQ1gdxUPP0SuOJaavGyxP2Xv0pU1Ftb8KFZ7tVO9L7bPrucZ3yJmOjW8BkyGCk+Jn
         /15KpwqRgbnLv3BncF4O8otnKke/rtEYfwbUslOK4MUSDf4HhyPUj962TkNfHSSQ1g7u
         mLafia7S2ma8aMoG5BFja8D8qe+aG2af06J5FiAZZsW9BFbZcVV4BqyXqB7YoSbSe/U8
         u1ZQ==
X-Gm-Message-State: AGi0PuZT+vU+kZkSDBNHoEezn6pVwDSFVtv+CNoIFOG+XEj0Frh+7JQL
        J2WMZlGm4oqUUg6qIiuKk2iJ0GPtgknTyya2LcCC4Wfy
X-Google-Smtp-Source: APiQypL1/a/s4k2I3ZBfJ675vKwmklfh+xbZzs8ceezwIQ8Na79POOkaj3bG2O0sTcL3igd5JJdP8DVlaPoqInOtb4A=
X-Received: by 2002:a9f:31d3:: with SMTP id w19mr3961849uad.140.1586581190132;
 Fri, 10 Apr 2020 21:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH6h+heYBA5RvBH7GPJ6JkPUYvjxT2A4f_gBVs=Pr-ps6rPRQw@mail.gmail.com>
 <CAPhsuW4UTJZHSQRHt3V2oPAkz8KD1YpG2YNBBg20cBujTCnzug@mail.gmail.com>
In-Reply-To: <CAPhsuW4UTJZHSQRHt3V2oPAkz8KD1YpG2YNBBg20cBujTCnzug@mail.gmail.com>
From:   Marc Smith <msmith626@gmail.com>
Date:   Sat, 11 Apr 2020 00:59:39 -0400
Message-ID: <CAH6h+he2=_1hgBm3hJ4KAnqxHkPgFj3+q-pPTRHrro1vzxgg3w@mail.gmail.com>
Subject: Re: MD Array 'stat' File - Sectors Read
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Apr 9, 2020 at 3:11 AM Song Liu <song@kernel.org> wrote:
>
> On Mon, Mar 30, 2020 at 1:55 PM Marc Smith <msmith626@gmail.com> wrote:
> >
> > Hi,
> >
> > Apologies in advance, as I'm sure this question has been asked many
> > times and there is a standard answer, but I can't seem to find it on
> > forums or this mailing list.
> >
> > I've always observed this behavior using 'iostat', when looking at
> > READ throughput numbers, the value is about 4 times more than the real
> > throughput number. Knowing this, I typically look at the member
> > devices to determine what throughput is actually being achieved (or
> > from the application driving the I/O).
> >
> > Looking at the sectors read field in the 'stat' file for an MD array
> > block device:
> > # cat /sys/block/md127/stat && sleep 1 && cat /sys/block/md127/stat
> > 93591416        0 55082801792        0       93        0        0
> >   0        0        0        0        0        0        0        0
> > 93608938        0 55092996456        0       93        0        0
> >   0        0        0        0        0        0        0        0
> >
> > 55092996456 - 55082801792 = 10194664
> > 10194664 * 512 = 5219667968
> > 5219667968 / 1024 / 1024 = 4977
> >
> > This device definitely isn't doing 4,977 MiB/s. So now my curiosity is
> > getting to me: Is this just known/expected behavior for the MD array
> > block devices? The numbers for WRITE sectors is always accurate as far
> > as I can tell. Or something configured strangely on my systems?
> >
> > I'm using vanilla Linux 5.4.12.
>
> Thanks for the report. Could you please share output of
>
>    mdadm --detial /dev/md127
>

# mdadm --detail /dev/md127
/dev/md127:
           Version : 1.2
     Creation Time : Tue Mar 17 17:23:00 2020
        Raid Level : raid6
        Array Size : 17580320640 (16765.90 GiB 18002.25 GB)
     Used Dev Size : 1758032064 (1676.59 GiB 1800.22 GB)
      Raid Devices : 12
     Total Devices : 12
       Persistence : Superblock is persistent

       Update Time : Thu Apr  9 13:07:12 2020
             State : clean
    Active Devices : 12
   Working Devices : 12
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 64K

Consistency Policy : resync

              Name : node-126c4f-1:P2024_126c4f_01  (local to host
node-126c4f-1)
              UUID : ceccb91b:1e975007:3efb5a9d:eda08d04
            Events : 79

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync   /dev/sda
       1       8       16        1      active sync   /dev/sdb
       2       8       32        2      active sync   /dev/sdc
       3       8       48        3      active sync   /dev/sdd
       4       8       64        4      active sync   /dev/sde
       5       8       80        5      active sync
       6       8       96        6      active sync   /dev/sdg
       7       8      112        7      active sync   /dev/sdh
       8       8      128        8      active sync   /dev/sdi
       9       8      144        9      active sync   /dev/sdj
      10       8      160       10      active sync   /dev/sdk
      11       8      176       11      active sync   /dev/sdl


> and
>
>    cat /proc/mdstat

# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
md127 : active raid6 sda[0] sdl[11] sdk[10] sdj[9] sdi[8] sdh[7]
sdg[6] sdf[5] sde[4] sdd[3] sdc[2] sdb[1]
      17580320640 blocks super 1.2 level 6, 64k chunk, algorithm 2
[12/12] [UUUUUUUUUUUU]

unused devices: <none>


Thanks; please let me know if there is any more detail I can provide.

--Marc


>
> Song
