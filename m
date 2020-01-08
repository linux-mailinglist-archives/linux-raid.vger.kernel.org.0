Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB02E133E58
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jan 2020 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgAHJaY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jan 2020 04:30:24 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:39066 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgAHJaX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jan 2020 04:30:23 -0500
Received: by mail-ua1-f41.google.com with SMTP id 73so854244uac.6
        for <linux-raid@vger.kernel.org>; Wed, 08 Jan 2020 01:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n8tU9v52MmOuTDN0B2N2GrQotE/xkjow5RaF3RMpRS8=;
        b=Bb8NDp6Coo1bSk6l+ArdXQbIrBQqd5XoQ3SduOwXXKD34Q4umgQWdR7qfTL2bd4Yn+
         E1I24JqJSOYZCXJhOz2KpA2nKmPdQ5pEubeX1a7acivJpWc0yhUUrZsnbpHuMGI8/a/u
         y4LzWQodXM5+vYH84uBaHVnBdOVdWOxdj91MAh8WL0+pHb9O3b+W5j5WBNHtXDTmaVeW
         KZSO792idayp7XIkiK1H98lo0XW9h1M/KCRXmwb6uNfEC6KSdTS21FApKiVzLK/nk9jg
         3TYpAoA70B4f5U4Y/xVBChqisQ29cce7t0bmKLs2uHizp8+sMbgAV0Io5+5UXgxJf/9g
         6Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n8tU9v52MmOuTDN0B2N2GrQotE/xkjow5RaF3RMpRS8=;
        b=tzpi1VCCRM66khynag0k2rVY9oS10alVYnEQdWtnGeu9+Nn2S2vpvHEc/KSAWEOqHh
         DjMCdKzNUUZx9kK4GeejZXi6BRSySWk/rx0WIlc07n7RmQOJ9OVkjkcacuYy+KYzEHBG
         WzuBXWXZo/Il9V8JzyUqOOsHrreQErtYNYz1COwtZtTh58vSjfY59R8rp1NEhi1tfFb0
         af2YNWFmRh2Et3Q/dTrxE9PDg1dlpmFopH2kWf07zJceMh3C7U3L9/pceIcO11gshiJE
         qhOBDz0JhfhmChHXYJ1RQECJ/H2lOCipDTGNENJVzeuwiSpVFPWi0piwdsUaip1cyNC4
         VQ1w==
X-Gm-Message-State: APjAAAVt1CYFZneZDD194uPk0YKWc8vamK8+8RX7TLFv5ka2iXgsFJmV
        3kZsrvvNxVxGxso6yy7ThAHJvSHf1STzCsMaYe3vVhL8
X-Google-Smtp-Source: APXvYqzgdGI39+uXa76kxOovf3pL//eKZ2VTgQ78LhXRlcub7+StGh83hZr1AVQjdREVuWMxoob8Wo9VjsuzizPa838=
X-Received: by 2002:ab0:94:: with SMTP id 20mr2433766uaj.71.1578475821987;
 Wed, 08 Jan 2020 01:30:21 -0800 (PST)
MIME-Version: 1.0
From:   Marco Heiming <myx00r@gmail.com>
Date:   Wed, 8 Jan 2020 10:31:28 +0100
Message-ID: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
Subject: Raid 5 cannot be re-assembled after disk was removed
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,
first of all: I am new to mailinglists but i hope my way to ask here is correct.

I am having trouble getting my Raid 5 assembled again after i manually
removed one disk.

So here is what what it looked like at the time it was working:

mdadm -D /dev/md0
/dev/md0:
        Version : 1.2
  Creation Time : Wed Jan  7 18:14:37 2015
     Raid Level : raid5
     Array Size : 5860270080 (5588.79 GiB 6000.92 GB)
  Used Dev Size : 2930135040 (2794.39 GiB 3000.46 GB)
   Raid Devices : 3
  Total Devices : 4
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Tue Aug 30 21:49:51 2016
          State : clean
 Active Devices : 3
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 1

         Layout : left-symmetric
     Chunk Size : 512K

           Name : NAS:0  (local to host NAS)
           UUID : 7b0eee59:07f87155:bdad1d0e:6e3cbad6
         Events : 112031

    Number   Major   Minor   RaidDevice State
       4       8       64        0      active sync   /dev/sde
       1       8       16        1      active sync   /dev/sdb
       3       8       32        2      active sync   /dev/sdc

       0       8        0        -      spare   /dev/sda

Then the following happened:

The disk /dev/sdd broke and was thrown out of the array (this happened
like one month ago already).

Somehow the spare was not activated and so the array degraded was inactive.

I activated the spare and the array was syncing.

After that finished I manually failed and removed /dev/sdd from the
array and physically disconnected it as well.

I thought i could reassemble the array with the remaining three disks
but this currently fails as follows:

(Please note that the new /dev/sdd was previously /dev/sde)


mdadm --examine /dev/sd[b-z]
/dev/sdb:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 7b0eee59:07f87155:bdad1d0e:6e3cbad6
           Name : NAS:0  (local to host NAS)
  Creation Time : Wed Jan  7 18:14:37 2015
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 5860274096 (2794.40 GiB 3000.46 GB)
     Array Size : 8790405120 (8383.18 GiB 9001.37 GB)
  Used Dev Size : 5860270080 (2794.39 GiB 3000.46 GB)
    Data Offset : 259072 sectors
   Super Offset : 8 sectors
   Unused Space : before=258984 sectors, after=4016 sectors
          State : clean
    Device UUID : a286ad29:114690eb:9bb2d0a3:3615f52c

Internal Bitmap : 8 sectors from superblock
    Update Time : Tue Jan  7 09:08:03 2020
  Bad Block Log : 512 entries available at offset 72 sectors
       Checksum : e3007322 - correct
         Events : 273134

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 1
   Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)
/dev/sdc:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 7b0eee59:07f87155:bdad1d0e:6e3cbad6
           Name : NAS:0  (local to host NAS)
  Creation Time : Wed Jan  7 18:14:37 2015
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 5860274096 (2794.40 GiB 3000.46 GB)
     Array Size : 8790405120 (8383.18 GiB 9001.37 GB)
  Used Dev Size : 5860270080 (2794.39 GiB 3000.46 GB)
    Data Offset : 259072 sectors
   Super Offset : 8 sectors
   Unused Space : before=258984 sectors, after=4016 sectors
          State : clean
    Device UUID : c60b01fc:2eaad12c:c3a619af:be9b687d

Internal Bitmap : 8 sectors from superblock
    Update Time : Tue Jan  7 09:08:03 2020
  Bad Block Log : 512 entries available at offset 72 sectors
       Checksum : 5251d716 - correct
         Events : 273134

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 2
   Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)
mdadm: No md superblock detected on /dev/sdd.

When i try to assemble the array with the two (hopefully) fine drives it fails:

mdadm --assemble /dev/md0 /dev/sd[bc] --verbose
mdadm: looking for devices for /dev/md0
mdadm: /dev/sdb is identified as a member of /dev/md0, slot 1.
mdadm: /dev/sdc is identified as a member of /dev/md0, slot 2.
mdadm: no uptodate device for slot 0 of /dev/md0
mdadm: added /dev/sdc to /dev/md0 as 2
mdadm: no uptodate device for slot 3 of /dev/md0
mdadm: added /dev/sdb to /dev/md0 as 1
mdadm: /dev/md0 assembled from 2 drives - not enough to start the array.

Then the array is inactive out of the two disks but is considered as
raid0 instead of raid5:

mdadm --detail -v /dev/md0
/dev/md0:
           Version : 1.2
        Raid Level : raid0
     Total Devices : 2
       Persistence : Superblock is persistent

             State : inactive
   Working Devices : 2

              Name : NAS:0  (local to host NAS)
              UUID : 7b0eee59:07f87155:bdad1d0e:6e3cbad6
            Events : 273134

    Number   Major   Minor   RaidDevice

       -       8       32        -        /dev/sdc
       -       8       16        -        /dev/sdb

cat /proc/mdstat
Personalities :
md0 : inactive sdc[3](S) sdb[1](S)
      5860274096 blocks super 1.2

unused devices: <none>


When i try to add the remaining disk it fails as follows:

mdadm --add /dev/md0 /dev/sdd
mdadm: Cannot get array info for /dev/md0

I am not sure how i should continue to get the array working again and
i hope that you can help me here :)

Thanks in advance,
Marco
