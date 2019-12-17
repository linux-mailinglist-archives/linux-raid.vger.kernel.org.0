Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DCB123302
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 17:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLQQy5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 11:54:57 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44575 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQQy5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 11:54:57 -0500
Received: by mail-ed1-f49.google.com with SMTP id bx28so5409526edb.11
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 08:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DFPau643FOOLqcKSolM03xRWenbTC8XH95Y8C76G2Ss=;
        b=aPXcem/6lcGKWRHd54bkjGhuPB0A0aPScq6lFt9p+0tu8RMxUAfQhSSvJUrJkUPx2X
         7gOfzPHsDbwkrAfZTGmyIZ+np3U7uBhIu5ko+ndAg8SG8fWxZ55Dz9DyYz5rmF8Q2D5e
         Xtdk08JXXx0XSDJLBDMcBxrRgFqfZMmnRo9QGZ00sdj2x5FEgeyLzEUBI+QyZj46OZ9G
         qVgpfxKWlJXzfs/4baTxhHQF0CKuBZO9v5H5RDY1qwMWsT/FipPlAobiTRLBGV5ICNnP
         0pM73nLdrdfT/aQjbkEfNJ8mYbBpzGYSYEpr8OWnskAr9awCMpJjQAaZKPRENESn6U/Y
         6Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DFPau643FOOLqcKSolM03xRWenbTC8XH95Y8C76G2Ss=;
        b=ADbIg7pzSmM4DhVb3mLzdwjCUdt6CATVl6a6yrzpHlUYAKkq0H1MP05EGgBnrfzB6P
         MuSCvWssZm6PwK2I6mOh2eWySRYIbXssZOuzcM9cXEwm9l05JhaO1HLiPhqIx84HxbbS
         a9axtdF4n5aW52gYTvFCq5eXTBdWuNNXnr9LsmwgDXJ5AxyZHjTmYgs6FPrr+ZCIvCYi
         KvBxjaORUxReoB1E7BWQ+83A5YIlESOe7f5syL67fR7y++2sf9pubsIt5BGNeL1HtsjI
         EHzaxnVwPdbIFfmW60WU5s4ViiD4madl6azAkF5HtJQVMPuejhIKhVCpxmwjPtN/Fa7c
         ojxA==
X-Gm-Message-State: APjAAAVcQs48kqK+JtTTRkMOCanxDk+LnbunHzI1gcNLbQA7tjWSzZjw
        fhidnnNZxqb7GvRAuqaoMYJwuz91zjzvfQCWEaFvjZ4h
X-Google-Smtp-Source: APXvYqwkFusC96ZSe5FfVgJsIgjMIL8eyFqbuD50H/AGKV7Xz62zv3cq+srX0U0lTGc3hAIHVHWj88G/oNEiSstAb4Y=
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr6259778edx.207.1576601694632;
 Tue, 17 Dec 2019 08:54:54 -0800 (PST)
MIME-Version: 1.0
From:   Patrick Pearcy <patrick.pearcy@gmail.com>
Date:   Tue, 17 Dec 2019 11:54:43 -0500
Message-ID: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
Subject: WD MyCloud PR4100 RAID Failure
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi everyone, I am hoping that someone is able to assist me with
recreating my 'failed' WD My Cloud PR4100 RAID.  I experienced a
series of short power interruptions and despite having a UPS and dual
power sources for my WD MyCloud, it reported that I had: (a) failed
drive 1, (b) installed a new drive 1, (c) failed drive 2 and (d)
installed a new drive 2.   ALL without my touching the system.  I have
a little knowledge of Linux (enough to follow instructions) so I was
able to run SMARTCTL on all 4 drives (no errors) and MDADM examine
(see below).  When trying to force an assemble, I receive the error
that no superblock was found on sda or sdb.  WD support referred me to
a data recovery service that wants me to send all disks to them.  I
believe the data is still present, I just don't know how to get the
array back.  Any assistance or suggestions would be greatly
appreciated.  Thanks!  Patrick

mdadm - v2.6.7.1 - 15th October 2008

MDADM Examine:
/dev/sda1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : 3593a169:b2495fbf:90fa7060:4cac0d65
  Creation Time : Tue Dec 17 10:56:15 2019
     Raid Level : raid1
  Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
     Array Size : 2097088 (2048.28 MiB 2147.42 MB)
   Raid Devices : 4
  Total Devices : 4
Preferred Minor : 0
    Update Time : Tue Dec 17 10:56:16 2019
          State : clean
Internal Bitmap : present
 Active Devices : 4
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 2ac0c510 - correct
         Events : 1

      Number   Major   Minor   RaidDevice State
this     0       8        1        0      active sync   /dev/sda1
   0     0       8        1        0      active sync   /dev/sda1
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1
   3     3       8       49        3      active sync   /dev/sdd1
/dev/sdb1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : 3593a169:b2495fbf:90fa7060:4cac0d65
  Creation Time : Tue Dec 17 10:56:15 2019
     Raid Level : raid1
  Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
     Array Size : 2097088 (2048.28 MiB 2147.42 MB)
   Raid Devices : 4
  Total Devices : 4
Preferred Minor : 0
    Update Time : Tue Dec 17 10:56:16 2019
          State : clean
Internal Bitmap : present
 Active Devices : 4
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 2ac0c522 - correct
         Events : 1

      Number   Major   Minor   RaidDevice State
this     1       8       17        1      active sync   /dev/sdb1
   0     0       8        1        0      active sync   /dev/sda1
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1
   3     3       8       49        3      active sync   /dev/sdd1
/dev/sdc1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : 3593a169:b2495fbf:90fa7060:4cac0d65
  Creation Time : Tue Dec 17 10:56:15 2019
     Raid Level : raid1
  Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
     Array Size : 2097088 (2048.28 MiB 2147.42 MB)
   Raid Devices : 4
  Total Devices : 4
Preferred Minor : 0
    Update Time : Tue Dec 17 10:56:16 2019
          State : clean
Internal Bitmap : present
 Active Devices : 4
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 2ac0c534 - correct
         Events : 1

      Number   Major   Minor   RaidDevice State
this     2       8       33        2      active sync   /dev/sdc1
   0     0       8        1        0      active sync   /dev/sda1
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1
   3     3       8       49        3      active sync   /dev/sdd1
/dev/sdd1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : 3593a169:b2495fbf:90fa7060:4cac0d65
  Creation Time : Tue Dec 17 10:56:15 2019
     Raid Level : raid1
  Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
     Array Size : 2097088 (2048.28 MiB 2147.42 MB)
   Raid Devices : 4
  Total Devices : 4
Preferred Minor : 0
    Update Time : Tue Dec 17 10:56:16 2019
          State : clean
Internal Bitmap : present
 Active Devices : 4
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 2ac0c546 - correct
         Events : 1

      Number   Major   Minor   RaidDevice State
this     3       8       49        3      active sync   /dev/sdd1
   0     0       8        1        0      active sync   /dev/sda1
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1
   3     3       8       49        3      active sync   /dev/sdd1


ReplyForward
1.31 GB (8%) of 15 GB used
Manage
Last account activity: 7 minutes ago
Details
Send =E2=80=AA(Ctrl-Enter)=E2=80=AC
