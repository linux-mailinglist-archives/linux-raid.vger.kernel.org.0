Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4710D0C9
	for <lists+linux-raid@lfdr.de>; Fri, 29 Nov 2019 05:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2Etb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 Nov 2019 23:49:31 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43720 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfK2Etb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 28 Nov 2019 23:49:31 -0500
Received: by mail-lj1-f182.google.com with SMTP id a13so7339935ljm.10
        for <linux-raid@vger.kernel.org>; Thu, 28 Nov 2019 20:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eMKNteW6eJIg1YcaN3sz/zKOP/ffVpmeBbdgssj2Rso=;
        b=L1Wjzsri3MZRtipHDOveuTJsC1E81xaSnSu4qr8R0KLit40c2mD4dPFn59LfeN/8UD
         OjSDvHAUVC3SCBD5nH6g5lFLq3P1/bHqCMG4yb/nuCf9L+G0wy5cNsKlSvzW2qNHnldU
         dsWQnw9HbhK8p7Qo9JODxrEPqIPMNAqgsK6dEHow2sG9wRI2bEPDCW6mVX2jI0gnnUp3
         E4vDeYTahKad9+FXR47V5l0Mlu74CqrghG49kKF+ap3dAXar9FtxnoJX1uk1rhjB5HlF
         VajiU4eq6SJGXcEWR0vutAgWWegMKC2BoNPYZiUoxc+OdfWxFcujWAF/KR+uEGSYGyBC
         BUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eMKNteW6eJIg1YcaN3sz/zKOP/ffVpmeBbdgssj2Rso=;
        b=SbpQBNODYUseuc+6L5wON/AX5o2kqbxXNotCb8lzPHhzNS1Fj/4zyeZG8PWjpRWyM1
         JSozAwHYQFSzdJnkqt7zwLirQwp564a1pJsCux3TxdRsLtHOrHtUXSJ0jyLpa9bdo1gm
         ROXLE0sXyykfa1kWcTnU3hcGQUvj8ERS1ziXckO7LIqVt/Sstb4YU8B7bolPIapWbzIP
         wBoBvSwJJpCjSsOxkXipNuNso+RXUVL0dw2xexMaypwotv0SlWFfT1W0hLLNXQfd8F3T
         fclj0jdCGV4UoZ37zaob1nlENe9swBOqfrPoaOaWFcl6iDCSuCvm7H8S7qc+fojqZmDn
         pYkA==
X-Gm-Message-State: APjAAAWPsCWbQ3E9zNVGrAk6JbIF/ZwX3hXp7EIx3pomyOBdb1F3+yiS
        jOwv+u2oRPPdMTu7bLaD8AbCUreLIhhSTUIc22/SXJJR3FU=
X-Google-Smtp-Source: APXvYqycU/3KYW78M0stPCFeaa3YkLU25Vb0f/KVZUbVsmK7ascaBlAszxaJ310CBKIgRZM02La2eGVhkxd6k/AzleE=
X-Received: by 2002:a2e:8e69:: with SMTP id t9mr1125341ljk.91.1575002969345;
 Thu, 28 Nov 2019 20:49:29 -0800 (PST)
MIME-Version: 1.0
From:   apfc123@gmail.com
Date:   Thu, 28 Nov 2019 22:49:16 -0600
Message-ID: <CAPJ7j64Pr+q5Kcm88z8v2jnaq06ofyLdOS6REfqqjexu1bC8hA@mail.gmail.com>
Subject: raid5 reshape stuck at 33%
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

Started out with 8 drives, added and grew 4 more at the same time on
mdadm 3.4. The reshape got stuck at 33% and errors showed up in dmesg
about no response for more than 120 seconds, tainted, call trace
etc...I tried rebooting and the reshape won't progress any further. If
I freeze the reshape, then I can mount and read the data, otherwise
mdadm commands won't respond (100% cpu usage)

I also tried booting from the latest debian live image with mdadm 4.1,
but reshape still won't progress past 33%. Suspecting drive issues
(smart tests failed, badblocks), I physically removed one at a time
and forced assemble to see if reshape would progress. I did this
twice, each time with a different drive, which I guess was a bad idea
because the array considers the 12th as a spare now after a --re-add.

Personalities : [raid6] [raid5] [raid4]
md127 : active raid5 sdc1[1] sdi1[9](S) sdd1[11] sde1[12] sdk1[13]
sdl1[14] sdj1[10] sdf1[8] sdg1[6] sdb1[5] sdh1[4] sda1[3]
      27348203008 blocks super 1.2 level 5, 512k chunk, algorithm 2
[12/11] [_UUUUUUUUUUU]
      bitmap: 5/30 pages [20KB], 65536KB chunk

/dev/md127:
           Version : 1.2
     Creation Time : Fri Mar  4 02:28:46 2016
        Raid Level : raid5
        Array Size : 27348203008 (26081.28 GiB 28004.56 GB)
     Used Dev Size : 3906886144 (3725.90 GiB 4000.65 GB)
      Raid Devices : 12
     Total Devices : 12
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Wed Nov 27 23:10:08 2019
             State : clean, degraded
    Active Devices : 11
   Working Devices : 12
    Failed Devices : 0
     Spare Devices : 1

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

     Delta Devices : 4, (8->12)

              Name : debian:one  (local to host debian)
              UUID : a6659be9:4545dfa0:678228ad:294eede4
            Events : 2022146

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1       8       33        1      active sync   /dev/sdc1
       3       8        1        2      active sync   /dev/sda1
       4       8      113        3      active sync   /dev/sdh1
       5       8       17        4      active sync   /dev/sdb1
       6       8       97        5      active sync   /dev/sdg1
       8       8       81        6      active sync   /dev/sdf1
      10       8      145        7      active sync   /dev/sdj1
      14       8      177        8      active sync   /dev/sdl1
      13       8      161        9      active sync   /dev/sdk1
      12       8       65       10      active sync   /dev/sde1
      11       8       49       11      active sync   /dev/sdd1

       9       8      129        -      spare   /dev/sdi1

The reshape is still frozen, volume groups are mounted and I can read
the data. Don't remember when I tried the revert-reshape option but
had an error about reshape is not aligned, try stop and assemble
again. Not sure if it was when the array had 12 active devices or 11.
Is it possible to get back to the 8+4 active array state, and then
successfully revert still?

The initial grow command specified a backup file on a usb drive, but I
can't find it. I assume mdadm deleted it intentionally.

Thanks for any help.
