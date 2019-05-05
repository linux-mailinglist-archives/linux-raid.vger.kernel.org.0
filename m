Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC8141AE
	for <lists+linux-raid@lfdr.de>; Sun,  5 May 2019 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEESAz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 May 2019 14:00:55 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:44692 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfEESAz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 5 May 2019 14:00:55 -0400
Received: from [192.168.28.30] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 15356B00571
        for <linux-raid@vger.kernel.org>; Sun,  5 May 2019 20:00:47 +0200 (CEST)
To:     linux-raid@vger.kernel.org
From:   Julien ROBIN <julien.robin28@free.fr>
Subject: Working 2 disks RAID0 : failed mdadm --add command : problem at
 reboot
Message-ID: <13922dd6-12bc-aa7b-5a56-42edbded8400@free.fr>
Date:   Sun, 5 May 2019 20:00:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi folks,

I don't know if this problem is known (and if it's considered as 
normal?). It happens on mdadm 4.1-1 and 3.4-4. I noticed it during my 
tests this weekend. It's not critical as the array can be assembled 
again manually.

If I create a RAID0 with 2 drives (and it's running fine):
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdc1 /dev/sdd1

# mdadm --detail /dev/md0
/dev/md0:
            Version : 1.2
      Creation Time : Sun May  5 18:53:39 2019
         Raid Level : raid0
         Array Size : 4091904 (3.90 GiB 4.19 GB)
       Raid Devices : 2
      Total Devices : 2
        Persistence : Superblock is persistent

        Update Time : Sun May  5 18:53:39 2019
              State : clean
     Active Devices : 2
    Working Devices : 2
     Failed Devices : 0
      Spare Devices : 0

         Chunk Size : 512K

Consistency Policy : none

               Name : Camera-PC:0  (local to host Camera-PC)
               UUID : e3b954a6:ab381819:0aab441c:e1557ee4
             Events : 0

     Number   Major   Minor   RaidDevice State
        0       8       33        0      active sync   /dev/sdc1
        1       8       49        1      active sync   /dev/sdd1

Then I play --add with some 3rd disk
mdadm --manage /dev/md0 --add /dev/sde1
mdadm: add new device failed for /dev/sde1 as 2: Invalid argument.

Nothing seems to have happened, mdadm --detail /dev/md0 shows no change. 
But the /dev/sde1 disk is now shown as Linux RAID member (version 1.2) 
and using the same UUID like the 2 others: it has been like prepared as 
a spare member of the array.

root@Camera-PC:/home/user# mdadm --examine /dev/sdc1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : e3b954a6:ab381819:0aab441c:e1557ee4
            Name : Camera-PC:0  (local to host Camera-PC)
   Creation Time : Sun May  5 18:53:39 2019
      Raid Level : raid0
    Raid Devices : 2

  Avail Dev Size : 4091904 (1998.00 MiB 2095.05 MB)
     Data Offset : 4096 sectors
    Super Offset : 8 sectors
    Unused Space : before=4016 sectors, after=0 sectors
           State : clean
     Device UUID : b3d9733c:009fea7e:f5b4ffb3:0bfa381a

     Update Time : Sun May  5 18:53:39 2019
   Bad Block Log : 512 entries available at offset 8 sectors
        Checksum : 62a315de - correct
          Events : 0

      Chunk Size : 512K

    Device Role : Active device 0
    Array State : AA ('A' == active, '.' == missing, 'R' == replacing)

root@Camera-PC:/home/user# mdadm --examine /dev/sdd1
/dev/sdd1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : e3b954a6:ab381819:0aab441c:e1557ee4
            Name : Camera-PC:0  (local to host Camera-PC)
   Creation Time : Sun May  5 18:53:39 2019
      Raid Level : raid0
    Raid Devices : 2

  Avail Dev Size : 4091904 (1998.00 MiB 2095.05 MB)
     Data Offset : 4096 sectors
    Super Offset : 8 sectors
    Unused Space : before=4016 sectors, after=0 sectors
           State : clean
     Device UUID : fbc9fbbe:db663cf8:9221f6f4:5701f13c

     Update Time : Sun May  5 18:53:39 2019
   Bad Block Log : 512 entries available at offset 8 sectors
        Checksum : c22b41ec - correct
          Events : 0

      Chunk Size : 512K

    Device Role : Active device 1
    Array State : AA ('A' == active, '.' == missing, 'R' == replacing)

root@Camera-PC:/home/user# mdadm --examine /dev/sde1
/dev/sde1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : e3b954a6:ab381819:0aab441c:e1557ee4
            Name : Camera-PC:0  (local to host Camera-PC)
   Creation Time : Sun May  5 18:53:39 2019
      Raid Level : raid0
    Raid Devices : 2

  Avail Dev Size : 4091904 (1998.00 MiB 2095.05 MB)
     Data Offset : 4096 sectors
    Super Offset : 8 sectors
    Unused Space : before=4016 sectors, after=0 sectors
           State : clean
     Device UUID : dba1b29b:4dc661da:a0fa8289:77f16512

     Update Time : Sun May  5 18:53:39 2019
   Bad Block Log : 512 entries available at offset 8 sectors
        Checksum : eb09426c - correct
          Events : 0

      Chunk Size : 512K

    Device Role : spare
    Array State : AA ('A' == active, '.' == missing, 'R' == replacing)


After a reboot :
# mdadm --detail /dev/md127
/dev/md127:
            Version : 1.2
      Creation Time : Sun May  5 18:53:39 2019
         Raid Level : raid0
       Raid Devices : 2
      Total Devices : 3
        Persistence : Superblock is persistent

        Update Time : Sun May  5 18:53:39 2019
              State : active, FAILED, Not Started
     Active Devices : 2
    Working Devices : 3
     Failed Devices : 0
      Spare Devices : 1

         Chunk Size : 512K

Consistency Policy : unknown

               Name : Camera-PC:0  (local to host Camera-PC)
               UUID : e3b954a6:ab381819:0aab441c:e1557ee4
             Events : 0

     Number   Major   Minor   RaidDevice State
        -       0        0        0      removed
        -       0        0        1      removed

        -       8       81        -      spare   /dev/sde1
        -       8       49        1      sync   /dev/sdd1
        -       8       33        0      sync   /dev/sdc1

# mdadm --manage /dev/md127 --remove /dev/sde1
mdadm: hot removed /dev/sde1 from /dev/md127

# mdadm --detail /dev/md127
/dev/md127:
            Version : 1.2
      Creation Time : Sun May  5 18:53:39 2019
         Raid Level : raid0
       Raid Devices : 2
      Total Devices : 2
        Persistence : Superblock is persistent

        Update Time : Sun May  5 18:53:39 2019
              State : active, FAILED, Not Started
     Active Devices : 2
    Working Devices : 2
     Failed Devices : 0
      Spare Devices : 0

         Chunk Size : 512K

Consistency Policy : unknown

               Name : Camera-PC:0  (local to host Camera-PC)
               UUID : e3b954a6:ab381819:0aab441c:e1557ee4
             Events : 0

     Number   Major   Minor   RaidDevice State
        -       0        0        0      removed
        -       0        0        1      removed

        -       8       49        1      sync   /dev/sdd1
        -       8       33        0      sync   /dev/sdc1

Playing mdadm --stop /dev/md127 and assemble it again with /dev/sdc1 and 
/dev/sdd1 is fine but the problem is back after reboot.

In fact, the 3rd disk should be reformatted or removed from the computer 
for the problem to disappear at reboot. If not, the auto-assemble 
mechanism at startup seems to be running this command:

root@Camera-PC:/home/user# mdadm --assemble /dev/md0 /dev/sdc1 /dev/sdd1 
/dev/sde1

Which gives the above mdadm --detail result, and the following output :
mdadm: failed to RUN_ARRAY /dev/md0: Invalid argument

I don't know if running the --add command (with nothing more) to a RAID0 
array should refuse to run, of if maybe spares members into a RAID0 
array shouldn't be causing this problem?

In case this feedback is useful.

Julien
