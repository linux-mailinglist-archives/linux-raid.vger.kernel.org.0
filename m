Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2909B1309CE
	for <lists+linux-raid@lfdr.de>; Sun,  5 Jan 2020 21:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAEUGW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 Jan 2020 15:06:22 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:36835 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAEUGT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 Jan 2020 15:06:19 -0500
Received: by mail-vs1-f49.google.com with SMTP id u14so30426431vsu.3
        for <linux-raid@vger.kernel.org>; Sun, 05 Jan 2020 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3aAiuadn+AdBVGtrVU+WxuoOfzLt6bt5xtJQb7Ru/mU=;
        b=ezFHbqgRu1GtZqQPHnvXHqbxgnrg4SMopNpExzB53qrhUSO367vfuTrdNWSQrMAlzv
         LhbQjNlz/dPa4rwHlnMOn/4CBnp1OfAgIhdQc4bhPtTa6pEF+6YgHNSwcutLP0AJ3ZW7
         pYocQa7ODIhtyS5gFSc8GVLnr55CEKsdN5Wv5rAweZ8HAZPXIk9IG2+9x253eWa3ehKp
         Pt8sYLOJYJG+5XUCg56gF2+iiCIU2fsd6GrngbysahfWXRkvLfqHEeQ8rbqrL1VEJUq1
         HR0WJ/IVvoXnJgcJ8AaC5ns0mt1YaQjOH5j0I7Ue8kSI12Hgs3gPvuPZ2l9Y3n5Z1Efq
         nlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3aAiuadn+AdBVGtrVU+WxuoOfzLt6bt5xtJQb7Ru/mU=;
        b=h/XxHycWzNB93DbnEvHODq4krGm22KsIdXZ3W9fzGk4C4wk2SGf1DtRNiPk3Inog6X
         1xNSoKAUKDV48JRasgADniVcvo1GocWml0rPLnqVa1qxp0ypuTwKQOFNeacFdx3bKXmS
         wEKy6hcyFnP24RAJnpMplCWQDWjBRVPjWXG6PGgB0EBScCmojUtX0Nm4eX8spYY1bn2O
         VKPocKhNUZz4gUtugzfqvaUMCj2TKn+qbOaq6ZzJvTYG7ZhI+b6a5kmqq9qps3TaecvJ
         dys5F2t9M0HPTzo+QN2PaxK2B2pSeuFsSLD0BsMx/aSD8iXE5M9pBsBnIAV6nvGRZSlJ
         JSVA==
X-Gm-Message-State: APjAAAXp6Wfjo1kRjYGKvD5v8P6c9/ksk8NyvCaqB6wJqs1BXwuGT+t7
        Lh9pVPaEQ5P/cCTd1uGSIqDMf2un2T7NeUEct/3GnVwP
X-Google-Smtp-Source: APXvYqwyHy1IuqaDLQUayig/zeMV2mGUOpM3q86ZpB4F7Le9OpSKngqSIOQzkAobSxyEJTu2Y5F1RZRbJt1ZigR6jZI=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr50386394vsq.215.1578254777239;
 Sun, 05 Jan 2020 12:06:17 -0800 (PST)
MIME-Version: 1.0
From:   William Morgan <therealbrewer@gmail.com>
Date:   Sun, 5 Jan 2020 14:06:06 -0600
Message-ID: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
Subject: Two raid5 arrays are inactive and have changed UUIDs
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I'm new here and likely don't understand the etiquette. Please be
patient with me.

I have two raid 5 arrays connected through an LSI 9601-16e (SAS2116)
card. I also have a few other single drives connected to the SAS card.
I was mounting both arrays through fstab using the original UUIDs of
the arrays. The system had been working great, remounting both arrays
on boot, etc. until yesterday when I shut the system off to remove one
of the single drives.
I didn't touch the raid array drives at all, but when I rebooted the
system, neither raid array mounted successfully. When I checked their
status, I noticed both arrays had changed to "inactive", and further
investigation showed that the UUIDs of both arrays had changed.
I started investigating using the troubleshooting page of the Linux
raid wiki. I tried to reassemble (no --force however) but it wasn't
successful. Here is a summary of what I noticed:

Smart data seems OK for all drives.I found some reports of bad blocks,
non-identical event counts, and some missing array members.

md0 consists of 4x 8TB drives:

role drive events state
 0    sdc   10080  A.AA (bad blocks reported on this drive)
 1    sdd   10070  AAAA
 2    sde   10070  AAAA
 3    sdf   10080  A.AA (bad blocks reported on this drive)


md1 consists of 4x 4TB drives:

role drive events state
 0    sdj    5948  AAAA
 1    sdk   38643  .AAA
 2    sdl   38643  .AAA
 3    sdm   38643  .AAA

These are the things that stand out to me, but there may be other
issues I've overlooked. I have included the full output of the
troubleshooting commands below. I don't understand why the UUIDs would
have changed, but even after mkconf created a new mdadm.conf file, the
arrays would not assemble or mount. And I don't know how to fix the
situation without losing data. Please let me know how to proceed.

Thanks,
Bill


bill@bill-desk:~$ uname -a
Linux bill-desk 5.3.0-24-generic #26-Ubuntu SMP Thu Nov 14 01:33:18
UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

bill@bill-desk:~$ mdadm --version
mdadm - v4.1 - 2018-10-01

bill@bill-desk:~$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
md1 : inactive sdl1[2](S) sdk1[1](S) sdm1[4](S) sdj1[0](S)
      15627538432 blocks super 1.2

md0 : inactive sdc1[0](S) sde1[2](S) sdf1[4](S) sdd1[1](S)
      31255572480 blocks super 1.2

unused devices: <none>

-------------------------------------------------------------

bill@bill-desk:~$ sudo mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
        Raid Level : raid0
     Total Devices : 4
       Persistence : Superblock is persistent

             State : inactive
   Working Devices : 4

              Name : bill-desk:0  (local to host bill-desk)
              UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
            Events : 10080

    Number   Major   Minor   RaidDevice

       -       8       81        -        /dev/sdf1
       -       8       65        -        /dev/sde1
       -       8       49        -        /dev/sdd1
       -       8       33        -        /dev/sdc1

-------------------------------------------------------------

bill@bill-desk:~$ sudo mdadm --detail /dev/md1
/dev/md1:
           Version : 1.2
        Raid Level : raid0
     Total Devices : 4
       Persistence : Superblock is persistent

             State : inactive
   Working Devices : 4

              Name : bill-desk:1  (local to host bill-desk)
              UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
            Events : 38643

    Number   Major   Minor   RaidDevice

       -       8      193        -        /dev/sdm1
       -       8      177        -        /dev/sdl1
       -       8      161        -        /dev/sdk1
       -       8      145        -        /dev/sdj1

-------------------------------------------------------------

bill@bill-desk:~$ echo ; for x in {c,d,e,f,j,k,l,m}; do echo
"$x$x$x$x$x$x$x$x" ; echo ; sudo smartctl -H -i -l scterc /dev/sd$x ;
echo ; echo ; done

cccccccc

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     HGST HDN728080ALE604
Serial Number:    R6GP4E3Y
LU WWN Device Id: 5 000cca 263c99c65
Firmware Version: A4GNW91X
User Capacity:    8,001,563,222,016 bytes [8.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:49 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



dddddddd

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     HGST HDN728080ALE604
Serial Number:    VJHAWA3X
LU WWN Device Id: 5 000cca 261d309cb
Firmware Version: A4GNW91X
User Capacity:    8,001,563,222,016 bytes [8.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:49 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



eeeeeeee

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     HGST HDN728080ALE604
Serial Number:    R6GBKSSY
LU WWN Device Id: 5 000cca 263c542c6
Firmware Version: A4GNW91X
User Capacity:    8,001,563,222,016 bytes [8.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:49 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



ffffffff

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     HGST HDN728080ALE604
Serial Number:    R6GPTRGY
LU WWN Device Id: 5 000cca 263c9e89b
Firmware Version: A4GNW91X
User Capacity:    8,001,563,222,016 bytes [8.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:49 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



jjjjjjjj

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     HGST Deskstar NAS
Device Model:     HGST HDN724040ALE640
Serial Number:    PK2334PEKD320T
LU WWN Device Id: 5 000cca 250efc678
Firmware Version: MJAOA5E0
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:49 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



kkkkkkkk

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     HGST Deskstar NAS
Device Model:     HGST HDN724040ALE640
Serial Number:    PK1334PEJJKPXS
LU WWN Device Id: 5 000cca 250e3b76a
Firmware Version: MJAOA5E0
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:50 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



llllllll

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     HGST Deskstar NAS
Device Model:     HGST HDN724040ALE640
Serial Number:    PK2334PEKD2AMT
LU WWN Device Id: 5 000cca 250efc3c2
Firmware Version: MJAOA5E0
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:50 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)



mmmmmmmm

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     HGST Deskstar NAS
Device Model:     HGST HDN724040ALE640
Serial Number:    PK2338P4GGE6BC
LU WWN Device Id: 5 000cca 249c68ec4
Firmware Version: MJAOA5E0
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Jan  5 12:48:51 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)


-------------------------------------------------------------

bill@bill-desk:~$ echo ; for x in {c,d,e,f,j,k,l,m} ; do echo
"$x$x$x$x$x$x$x$x" ; echo ; sudo mdadm --examine /dev/sd"$x" ; echo ;
sudo mdadm --examine /dev/sd"$x"1 ; echo ; echo ; done

cccccccc

/dev/sdc:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdc1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x9
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : clean
    Device UUID : ab1323e0:9c0426cf:3e168733:b73e9c5c

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:58:47 2020
  Bad Block Log : 512 entries available at offset 40 sectors - bad
blocks present.
       Checksum : f1492f41 - correct
         Events : 10080

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 0
   Array State : A.AA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


dddddddd

/dev/sdd:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdd1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : clean
    Device UUID : c875f246:ce25d947:a413e198:4100082e

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:56:09 2020
  Bad Block Log : 512 entries available at offset 40 sectors
       Checksum : 79370d0 - correct
         Events : 10070

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 1
   Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


eeeeeeee

/dev/sde:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sde1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : clean
    Device UUID : fd0634e6:6943f723:0e30260e:e253b1f4

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:56:09 2020
  Bad Block Log : 512 entries available at offset 40 sectors
       Checksum : bee18fac - correct
         Events : 10070

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 2
   Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


ffffffff

/dev/sdf:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdf1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x9
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : clean
    Device UUID : 8c628aed:802a5dc8:9d8a8910:9794ec02

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:58:47 2020
  Bad Block Log : 512 entries available at offset 40 sectors - bad
blocks present.
       Checksum : 7b3a6e49 - correct
         Events : 10080

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 3
   Array State : A.AA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


jjjjjjjj

/dev/sdj:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdj1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
           Name : bill-desk:1  (local to host bill-desk)
  Creation Time : Tue Sep 25 23:31:31 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 7813769216 (3725.90 GiB 4000.65 GB)
     Array Size : 11720653824 (11177.69 GiB 12001.95 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : clean
    Device UUID : d555a340:e53ec7ad:56f05a14:144b643d

Internal Bitmap : 8 sectors from superblock
    Update Time : Thu Nov 28 09:41:00 2019
  Bad Block Log : 512 entries available at offset 24 sectors
       Checksum : bd866569 - correct
         Events : 5948

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 0
   Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


kkkkkkkk

/dev/sdk:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdk1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
           Name : bill-desk:1  (local to host bill-desk)
  Creation Time : Tue Sep 25 23:31:31 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 7813769216 (3725.90 GiB 4000.65 GB)
     Array Size : 11720653824 (11177.69 GiB 12001.95 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : active
    Device UUID : d7242c08:8f759c04:db574eeb:928c910b

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:52:59 2020
  Bad Block Log : 512 entries available at offset 24 sectors
       Checksum : 8137c08e - correct
         Events : 38643

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 1
   Array State : .AAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


llllllll

/dev/sdl:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdl1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
           Name : bill-desk:1  (local to host bill-desk)
  Creation Time : Tue Sep 25 23:31:31 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 7813769216 (3725.90 GiB 4000.65 GB)
     Array Size : 11720653824 (11177.69 GiB 12001.95 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : active
    Device UUID : be757792:3c382ac3:77dbdd4e:10c480c5

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:52:59 2020
  Bad Block Log : 512 entries available at offset 24 sectors
       Checksum : e78f8f3e - correct
         Events : 38643

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 2
   Array State : .AAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


mmmmmmmm

/dev/sdm:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

/dev/sdm1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
           Name : bill-desk:1  (local to host bill-desk)
  Creation Time : Tue Sep 25 23:31:31 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 7813769216 (3725.90 GiB 4000.65 GB)
     Array Size : 11720653824 (11177.69 GiB 12001.95 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D0 sectors
          State : active
    Device UUID : d0c03d20:b985ebc9:30e61e2b:8060c297

Internal Bitmap : 8 sectors from superblock
    Update Time : Sat Jan  4 16:52:59 2020
  Bad Block Log : 512 entries available at offset 24 sectors
       Checksum : 2a99cef8 - correct
         Events : 38643

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 3
   Array State : .AAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


-------------------------------------------------------------

bill@bill-desk:~$ sudo ./lsdrv/lsdrv
PCI [ahci] 00:11.0 SATA controller: Advanced Micro Devices, Inc.
[AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
=E2=94=94scsi 0:0:0:0 ATA      MKNSSDCR120GB-DX {MKN1148A0000036541}
 =E2=94=94sda 111.79g [8:0] Partitioned (gpt)
  =E2=94=9Csda1 512.00m [8:1] vfat {15D7-58C2}
  =E2=94=82=E2=94=94Mounted as /dev/sda1 @ /boot/efi
  =E2=94=9Csda2 95.33g [8:2] ext4 {e3d4b44c-d208-4073-b67f-87915576366d}
  =E2=94=82=E2=94=94Mounted as /dev/sda2 @ /
  =E2=94=94sda3 15.96g [8:3] swap {7d289884-ce3a-4f37-95f8-e980ad1d0e20}
PCI [pata_atiixp] 00:14.1 IDE interface: Advanced Micro Devices, Inc.
[AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller (rev 40)
=E2=94=94scsi 1:0:1:0 HL-DT-ST BD-RE  WH16NS60  {KL4J7QB3114}
 =E2=94=94sr0 1.00g [11:0] Empty/Unknown
PCI [ahci] 03:00.0 SATA controller: Marvell Technology Group Ltd.
88SE9172 SATA 6Gb/s Controller (rev 12)
=E2=94=94scsi 6:x:x:x [Empty]
PCI [mpt3sas] 04:00.0 Serial Attached SCSI controller: Broadcom / LSI
SAS2116 PCI-Express Fusion-MPT SAS-2 [Meteor] (rev 02)
=E2=94=9Cphy-8:0 scsi 8:0:1:0 ATA      HGST HDN728080AL {R6GP4E3Y}
=E2=94=82=E2=94=94sdc 7.28t [8:32] Partitioned (gpt)
=E2=94=82 =E2=94=94sdc1 7.28t [8:33] MD  (none/) (w/ sdf1,sde1,sdd1) spare
'bill-desk:0' {06ad8de5-3a7a-15ad-8811-6f44fcdee150}
=E2=94=82  =E2=94=94md0 0.00k [9:0] MD v1.2  () inactive, None (None) None
{06ad8de5:3a7a15ad:88116f44:fcdee150}
=E2=94=82                   Empty/Unknown
=E2=94=9Cphy-8:1 scsi 8:0:2:0 ATA      HGST HDN728080AL {VJHAWA3X}
=E2=94=82=E2=94=94sdd 7.28t [8:48] Partitioned (gpt)
=E2=94=82 =E2=94=94sdd1 7.28t [8:49] MD  (none/) (w/ sdf1,sde1,sdc1) spare
'bill-desk:0' {06ad8de5-3a7a-15ad-8811-6f44fcdee150}
=E2=94=82  =E2=94=94md0 0.00k [9:0] MD v1.2  () inactive, None (None) None
{06ad8de5:3a7a15ad:88116f44:fcdee150}
=E2=94=82                   Empty/Unknown
=E2=94=9Cphy-8:2 scsi 8:0:3:0 ATA      HGST HDN728080AL {R6GBKSSY}
=E2=94=82=E2=94=94sde 7.28t [8:64] Partitioned (gpt)
=E2=94=82 =E2=94=94sde1 7.28t [8:65] MD  (none/) (w/ sdf1,sdd1,sdc1) spare
'bill-desk:0' {06ad8de5-3a7a-15ad-8811-6f44fcdee150}
=E2=94=82  =E2=94=94md0 0.00k [9:0] MD v1.2  () inactive, None (None) None
{06ad8de5:3a7a15ad:88116f44:fcdee150}
=E2=94=82                   Empty/Unknown
=E2=94=9Cphy-8:3 scsi 8:0:4:0 ATA      HGST HDN728080AL {R6GPTRGY}
=E2=94=82=E2=94=94sdf 7.28t [8:80] Partitioned (gpt)
=E2=94=82 =E2=94=94sdf1 7.28t [8:81] MD  (none/) (w/ sde1,sdd1,sdc1) spare
'bill-desk:0' {06ad8de5-3a7a-15ad-8811-6f44fcdee150}
=E2=94=82  =E2=94=94md0 0.00k [9:0] MD v1.2  () inactive, None (None) None
{06ad8de5:3a7a15ad:88116f44:fcdee150}
=E2=94=82                   Empty/Unknown
=E2=94=9Cphy-8:12 scsi 8:0:8:0 ATA      HGST HDN724040AL {PK2334PEKD320T}
=E2=94=82=E2=94=94sdj 3.64t [8:144] Partitioned (gpt)
=E2=94=82 =E2=94=94sdj1 3.64t [8:145] MD  (none/) (w/ sdm1,sdl1,sdk1) spare
'bill-desk:1' {723f939b-62b7-3a3e-e86e-1fe1e37131dc}
=E2=94=82  =E2=94=94md1 0.00k [9:1] MD v1.2  () inactive, None (None) None
{723f939b:62b73a3e:e86e1fe1:e37131dc}
=E2=94=82                   Empty/Unknown
=E2=94=9Cphy-8:13 scsi 8:0:9:0 ATA      HGST HDN724040AL {PK1334PEJJKPXS}
=E2=94=82=E2=94=94sdk 3.64t [8:160] Partitioned (gpt)
=E2=94=82 =E2=94=94sdk1 3.64t [8:161] MD  (none/) (w/ sdm1,sdl1,sdj1) spare
'bill-desk:1' {723f939b-62b7-3a3e-e86e-1fe1e37131dc}
=E2=94=82  =E2=94=94md1 0.00k [9:1] MD v1.2  () inactive, None (None) None
{723f939b:62b73a3e:e86e1fe1:e37131dc}
=E2=94=82                   Empty/Unknown
=E2=94=9Cphy-8:14 scsi 8:0:10:0 ATA      HGST HDN724040AL {PK2334PEKD2AMT}
=E2=94=82=E2=94=94sdl 3.64t [8:176] Partitioned (gpt)
=E2=94=82 =E2=94=94sdl1 3.64t [8:177] MD  (none/) (w/ sdm1,sdk1,sdj1) spare
'bill-desk:1' {723f939b-62b7-3a3e-e86e-1fe1e37131dc}
=E2=94=82  =E2=94=94md1 0.00k [9:1] MD v1.2  () inactive, None (None) None
{723f939b:62b73a3e:e86e1fe1:e37131dc}
=E2=94=82                   Empty/Unknown
=E2=94=94phy-8:15 scsi 8:0:11:0 ATA      HGST HDN724040AL {PK2338P4GGE6BC}
 =E2=94=94sdm 3.64t [8:192] Partitioned (gpt)
  =E2=94=94sdm1 3.64t [8:193] MD  (none/) (w/ sdl1,sdk1,sdj1) spare
'bill-desk:1' {723f939b-62b7-3a3e-e86e-1fe1e37131dc}
   =E2=94=94md1 0.00k [9:1] MD v1.2  () inactive, None (None) None
{723f939b:62b73a3e:e86e1fe1:e37131dc}
                    Empty/Unknown
Other Block Devices
=E2=94=9Cloop0 0.00k [7:0] Empty/Unknown
=E2=94=9Cloop1 0.00k [7:1] Empty/Unknown
=E2=94=9Cloop2 0.00k [7:2] Empty/Unknown
=E2=94=9Cloop3 0.00k [7:3] Empty/Unknown
=E2=94=9Cloop4 0.00k [7:4] Empty/Unknown
=E2=94=9Cloop5 0.00k [7:5] Empty/Unknown
=E2=94=9Cloop6 0.00k [7:6] Empty/Unknown
=E2=94=9Cloop7 0.00k [7:7] Empty/Unknown
=E2=94=94pktcdvd0 0.00k [252:0] Empty/Unknown

-------------------------------------------------------------

bill@bill-desk:~$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID=3D as a more robust way to name device=
s
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point> <type> <options> <dump> <pass>

UUID=3D15D7-58C2 /boot/efi vfat umask=3D0077 0 1
UUID=3De3d4b44c-d208-4073-b67f-87915576366d / ext4 noatime,errors=3Dremount=
-ro 0 1
UUID=3D7d289884-ce3a-4f37-95f8-e980ad1d0e20 none swap sw 0 0

# The first line below shows the new UUID for the RAID5 array "md0".
# The second line is the original UUID from when the arrray was created.
# Both lines are commented out since the array won't mount.
#UUID=3D06ad8de5-3a7a-15ad-8811-6f44fcdee150 /media/bill/FILM ext4 defaults=
 0 2
#UUID=3Dceef50e9-afdd-4903-899d-1ad05a0780e0 /media/bill/FILM ext4 defaults=
 0 2

# The first line below shows the new UUID for the RAID5 array "md1".
# The second line is the original UUID from when the arrray was created.
# Both lines are commented out since the array won't mount.
#UUID=3D723f939b-62b7-3a3e-e86e-1fe1e37131dc /media/bill/OTHER ext4 default=
s 0 2
#UUID=3D0c9eba31-b018-41fc-9645-422884cf26a7 /media/bill/OTHER ext4 default=
s 0 2

-------------------------------------------------------------

bill@bill-desk:~$ cat /etc/mdadm/mdadm.conf
# mdadm.conf
#
# !NB! Run update-initramfs -u after updating this file.
# !NB! This will ensure that initramfs has an uptodate copy.
#
# Please refer to mdadm.conf(5) for information about this file.
#

# by default (built-in), scan all partitions (/proc/partitions) and all
# containers for MD superblocks. alternatively, specify devices to scan, us=
ing
# wildcards if desired.
#DEVICE partitions containers

# automatically tag new arrays as belonging to the local system
HOMEHOST <system>

# instruct the monitoring daemon where to send mail alerts
MAILADDR root

# definitions of existing MD arrays
ARRAY /dev/md/0  metadata=3D1.2 UUID=3D06ad8de5:3a7a15ad:88116f44:fcdee150
name=3Dbill-desk:0
ARRAY /dev/md/1  metadata=3D1.2 UUID=3D723f939b:62b73a3e:e86e1fe1:e37131dc
name=3Dbill-desk:1

# This configuration was auto-generated on Sun, 05 Jan 2020 11:29:49
-0600 by mkconf
