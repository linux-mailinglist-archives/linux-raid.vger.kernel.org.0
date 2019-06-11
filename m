Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5C41708
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbfFKVkS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 17:40:18 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:38429 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbfFKVkS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 17:40:18 -0400
Date:   Tue, 11 Jun 2019 21:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1560289214;
        bh=SPeUsLnQfp3dKglPWtPAMj69N/28pS5yzvXsQX9ZzsM=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=hC358rHpoY92gmMHMyw5zOHRUFbgMsnqKswTKT0MBR50orCzNerWGvIng7LyxK3aY
         YBAlYFQju8hxTZ2k8G5yK9Gq2fIyOtPn4AjQPgljc2O4Iv0helc5HN/4MhoUmFsZlH
         znldsoKtIBk6UrJ4ddfLtaHt1xvc30vYoxX+AzMk=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   listmailer273 <listmailer273@protonmail.com>
Reply-To: listmailer273 <listmailer273@protonmail.com>
Subject: mdadm: /dev/dm-4 not large enough to join array
Message-ID: <dG0b9ztaXq7nnBqDpNSWA78L_GWp4ZR4ZtYEZSN3QhHJtREVYtNSOhWoVU0BqgPAoPZ4IndRERfrzbLy8dGT6mRBMATSZk8iqLALin2D8r4=@protonmail.com>
Feedback-ID: Fd2eok_VZvV9qRUlslsjKtrrBxHNHXYlqffBaU6nm5OzC147N48I09ApizhQdIxA2KaFG6TNkp7B5i-05Mz4EQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, I'm having trouble readding a disk to an array. The array was created p=
robably 9 years ago, I've had many instances of drives casually dropping ou=
t and coming back. Eventually I enabled the write-intent bitmap to handle t=
he five-day resyncs. (They became essentially immediate.)

I have a disk now that has dropped, and I'm not able to get it back into th=
e array. I'm concerned it could be related to an ancient bug regarding v1.x=
 metadata:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D500309


# mdadm --add /dev/md104  /dev/dm-4
mdadm: /dev/dm-4 not large enough to join array

Has anyone seen this, or know how I might recover from this state?

=3D=3D=3D=3D=3D=3D=3D=3D
Array information:

# mdadm --version
mdadm - v4.1 - 2018-10-01
# uname -a
Linux Host 4.14.120-gentoo #1 SMP PREEMPT Sat May 18 13:16:28 EDT 2019
x86_64 Intel(R) Xeon(R) CPU W3690 @ 3.47GHz GenuineIntel GNU/Linux

The disk just fell out of the array a day ago. (Running Gentoo sources
with the latest mdadm.)

The array,
md104 : active raid6 dm-8[6] dm-6[11] dm-5[8] dm-3[12] dm-2[9] dm-1[10]
dm-0[7]
       23442102912 blocks super 1.2 level 6, 64k chunk, algorithm 2
[8/7] [U_UUUUUU]

and detail,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# mdadm --detail /dev/md104
/dev/md104:
Version : 1.2
Creation Time : Wed Feb 26 00:01:32 2014
Raid Level : raid6
Array Size : 23442102912 (22356.13 GiB 24004.71 GB)
Used Dev Size : 3907017152 (3726.02 GiB 4000.79 GB)
Raid Devices : 8
Total Devices : 7
Persistence : Superblock is persistent

Update Time : Wed Jun  5 21:43:57 2019
State : clean, degraded
Active Devices : 7
Working Devices : 7
Failed Devices : 0
Spare Devices : 0

Layout : left-symmetric
Chunk Size : 64K

Consistency Policy : resync

Name : Host:104  (local to host Host)
UUID : 8627xxxx:uuuu:iiii:dddda772
Events : 23692137

Number   Major   Minor   RaidDevice State
7     252        0        0      active sync   /dev/dm-0
-       0        0        1      removed
6     252        8        2      active sync   /dev/dm-8
10     252        1        3      active sync   /dev/dm-1
9     252        2        4      active sync   /dev/dm-2
8     252        5        5      active sync   /dev/dm-5
11     252        6        6      active sync   /dev/dm-6
12     252        3        7      active sync   /dev/dm-3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


and one of the existing disks,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# mdadm --examine /dev/dm-1
/dev/dm-1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 8627xxxx:uuuu:iiii:dddda772
            Name : Host:104  (local to host Host)
   Creation Time : Wed Feb 26 00:01:32 2014
      Raid Level : raid6
    Raid Devices : 8

  Avail Dev Size : 7814035376 (3726.02 GiB 4000.79 GB)
      Array Size : 23442102912 (22356.13 GiB 24004.71 GB)
   Used Dev Size : 7814034304 (3726.02 GiB 4000.79 GB)
     Data Offset : 640 sectors
    Super Offset : 8 sectors
    Unused Space : before=3D552 sectors, after=3D1712 sectors
           State : active
     Device UUID : 85c9xxxx:uuuu:iiii:dddd

     Update Time : Wed Jun  5 21:45:49 2019
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : ac693b84 - correct
          Events : 23692354

          Layout : left-symmetric
      Chunk Size : 64K

    Device Role : Active device 3
    Array State : A.AAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Consider the disk in question (must be disk 2), /dev/dm-4.

# fdisk -l /dev/dm-4
Disk /dev/dm-4: 3.7 TiB, 4000786767872 bytes, 7814036656 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes

an examine,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# mdadm --examine /dev/dm-4
/dev/dm-4:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x1
      Array UUID : 8627xxxx:uuuu:iiii:dddda772
            Name : Host:104  (local to host Host)
   Creation Time : Wed Feb 26 00:01:32 2014
      Raid Level : raid6
    Raid Devices : 8

  Avail Dev Size : 7814035376 (3726.02 GiB 4000.79 GB)
      Array Size : 23442102912 (22356.13 GiB 24004.71 GB)
   Used Dev Size : 7814034304 (3726.02 GiB 4000.79 GB)
     Data Offset : 640 sectors
    Super Offset : 8 sectors
    Unused Space : before=3D560 sectors, after=3D1712 sectors
           State : active
     Device UUID : eb03xxxx:uuuu:iiii:dddd

Internal Bitmap : 8 sectors from superblock
     Update Time : Sun Jun  2 16:32:03 2019
        Checksum : e4922d44 - correct
          Events : 23087316

          Layout : left-symmetric
      Chunk Size : 64K

    Device Role : Active device 1
    Array State : AAAAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


The array UUID is the same:
# mdadm --examine /dev/dm-4 | grep Array.UUID | ~/bin/crc32
3D3E1222
# mdadm --examine /dev/dm-1 | grep Array.UUID | ~/bin/crc32
3D3E1222
The Host name is the same on the disks and the array.

Just to be sure the disk isn't having a problem at the start or end around =
some metadata,
# dd if=3D/dev/dm-1 bs=3D65536 skip=3D$(( 7814035376 / (65536 / 512) - 1000=
 )) of=3D/dev/null
1010+1 records in / 1010+1 records out
66215936 bytes (66 MB, 63 MiB) copied, 1.19822 s, 55.3 MB/s

# dd if=3D/dev/dm-4 bs=3D65536 skip=3D$(( 7814035376 / (65536 / 512) - 1000=
 )) of=3D/dev/null
1010+1 records in / 1010+1 records out
66215936 bytes (66 MB, 63 MiB) copied, 1.70529 s, 38.8 MB/s

# dd if=3D/dev/dm-4 bs=3D65536 count=3D10000 of=3D/dev/null
10000+0 records in / 10000+0 records out
655360000 bytes (655 MB, 625 MiB) copied, 4.49685 s, 146 MB/s

Both disks are WD40EFRX.


Since having this error, I saw the relation of the above bug to the write-i=
ntent bitmap, so I turned it
off: mdadm --grow /dev/md104 --bitmap=3Dnone /dev/md104.
The result is still the same: "mdadm: /dev/dm-4 not large enough to join ar=
ray".

All of the information above is after turning off the write-intent bitmap f=
or the array. Yesterday I tried downgrading to mdadm 3.4 and the same messa=
ge. "<mdadm - v3.4 - 28th January 2016". "mdadm: /dev/dm-4 not large enough=
 to join array".

Does anyone know if this is a bug, or how I might recover from this state?
