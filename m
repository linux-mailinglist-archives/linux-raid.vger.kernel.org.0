Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72C12155A3
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jul 2020 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGFKeC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jul 2020 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgGFKeB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jul 2020 06:34:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453BC061794
        for <linux-raid@vger.kernel.org>; Mon,  6 Jul 2020 03:34:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t25so40051846lji.12
        for <linux-raid@vger.kernel.org>; Mon, 06 Jul 2020 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=denness-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=FGtKMR9NAlkAN8ktFTn28naKhD+XIe+Qtn8oc02tWNE=;
        b=TCgYKzxG0gNtyL3bn82MUM/dv2DMFegGl+KtdLmzNQdfuOsJQmylOJQZVlKaVBqNmk
         gRCgbGrg9dSZJ3YTSAv8Ute4GyELZdGBwNw07xHRy4547PdmdnJdlprmkSu8zjKXledX
         tCtCn/l6aNCZlM0WvvUCTetokZZjH0bm9GkaN6mBTiT/x+WfZ4Nr3jExfmxxdKm0JnTh
         VBfdikJKCiGrdalvXSyMN5noiMoqPjkRyMe5U4CG1N/TYEuQ1sEMeZZ1fEye/UvytR0a
         nfyqO7qXHS9mX6zulCJ8JTVABlWZfo27ZhylC95uKWkrlrvpkgAzYsqmL+R4n5ociN+v
         OH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FGtKMR9NAlkAN8ktFTn28naKhD+XIe+Qtn8oc02tWNE=;
        b=OOvnQ5Xcvzhv4Go8jcew4gOS1ZPfog9S5qrb3QXsfz7BqLvBbGzC421thHdijqHU4g
         nzWWqaJIwg36uHFl//eospLtbaYh2oSp+SXwZDBoX81AzBGVzJSclNPOSoxxMLPd9m8b
         JQddMgNtW14yEDKKwk0eKq3dgmZgrkTzt/iQQuBJlReCDpMYYxLC4f4apRU10RPi52yF
         PzlgDcaIOAPp6XwZWHb4ABMSPFVrNoah4SCJUGpA2c50XKVFC7O8IO3e2pzfcYYOFXxC
         5HLsQWYgesN++xvtw2PFzyOVxgDNo7bVUehbMIN3wqyUbvVoHuDnUvBj0XbB98D9MyQ5
         Ooeg==
X-Gm-Message-State: AOAM5333AO61RMLoceqwuCs+opD3NFGSMd8f/s6Zi4HvGHsQjwXgnUO9
        +bmjxadx+V2mFFwiaOLALCHW3G0Mk36VAnaQ03LJJ8MXDSUbLUx2
X-Google-Smtp-Source: ABdhPJwrjhTDAptDl/i0DOmOUv2EmhGaAmFdfD37crRfPLsbDVlxKhPOsYq0CMjIXRWlloL1Ln2E31n4o9w0rNKseow=
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr18467563ljk.351.1594031639515;
 Mon, 06 Jul 2020 03:33:59 -0700 (PDT)
MIME-Version: 1.0
From:   Laurie Denness <laurie@denness.net>
Date:   Mon, 6 Jul 2020 11:33:48 +0100
Message-ID: <CAGoQN1Bh0BX3BUZV-2MonU0gvGpAqLR_Cy2KvKCUMF7z9Uw4jQ@mail.gmail.com>
Subject: upgrade from 0.9 to 1.0 metadata caused slight array shrink
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello!
I was happily swapping out my 2TB drives for 4TB in my 5 disk RAID 6
array, when I got bitten by the "0.9 metadata does not support drives
larger than 2TB" issue. The NAS had already run a --grow for me before
I realised this could be a problem.

After reading posts (and backing up my data), I attempted the
instructions as per
https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Converting_between_superblock_versions
and ran:

mdadm --create /dev/md1 -l6 -n5 -c64 --layout=left-symmetric
--metadata=1.0 --assume-clean /dev/sda2 /dev/sdb2 /dev/sdc2 /dev/sdd2
/dev/sde2
(note I tried to be very careful specifying the defaults!)

Here's my mdadm --detail /dev/md1 from before:

root@127.0.0.1:/mnt# mdadm --detail /dev/md1
/dev/md1:
        Version : 0.90
  Creation Time : Fri Nov 26 21:03:23 2010
     Raid Level : raid6
     Array Size : 11714908416 (11172.21 GiB 11996.07 GB)
  Used Dev Size : -1
   Raid Devices : 5
  Total Devices : 5
Preferred Minor : 1
    Persistence : Superblock is persistent

    Update Time : Sun Jul  5 13:00:24 2020
          State : clean
 Active Devices : 5
Working Devices : 5
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 64K

           UUID : 98493182:5d26fa6e:1c0a08b1:19765080
         Events : 0.729722

    Number   Major   Minor   RaidDevice State
       0       8        2        0      active sync   /dev/sda2
       1       8       18        1      active sync   /dev/sdb2
       2       8       34        2      active sync   /dev/sdc2
       3       8       50        3      active sync   /dev/sdd2
       4       8       66        4      active sync   /dev/sde2


And here's the output after the command was run:

root@127.0.0.1:/app/bin# mdadm --detail /dev/md1
/dev/md1:
        Version : 1.0
  Creation Time : Sun Jul  5 15:46:21 2020
     Raid Level : raid6
     Array Size : 11714908032 (11172.21 GiB 11996.07 GB)
  Used Dev Size : 3904969344 (3724.07 GiB 3998.69 GB)
   Raid Devices : 5
  Total Devices : 5
    Persistence : Superblock is persistent

    Update Time : Mon Jul  6 10:57:31 2020
          State : clean
 Active Devices : 5
Working Devices : 5
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 64K

           Name : N5500:1  (local to host N5500)
           UUID : 5c5ee93c:b52b9bc1:d8cba3fd:802b54ac
         Events : 4

    Number   Major   Minor   RaidDevice State
       0       8        2        0      active sync   /dev/sda2
       1       8       18        1      active sync   /dev/sdb2
       2       8       34        2      active sync   /dev/sdc2
       3       8       50        3      active sync   /dev/sdd2
       4       8       66        4      active sync   /dev/sde2



I have LVM and then an XFS filesystem on top of md1, and I got hit by
the dreaded "too small for target":
device-mapper: table: 253:1: md1 too small for target: start=2097536,
len=23427719168, dev_size=23429816064

Which suddenly made sense when I paid attention to the size of the
array before and after:
     Array Size : 11714908416 (11172.21 GiB 11996.07 GB)
     Array Size : 11714908032 (11172.21 GiB 11996.07 GB)

I appear to have lost a tiny amount of space with the re-creation. If
I was not using XFS, I would shrug this off and resize the filesystem,
but since XFS cannot be shrunk, I am open to any advice about the best
course of action to go from here.


Things that crossed my mind:
1) Post here to figure out why I lost a few bytes - here I am! Maybe I
made an error in the re-creation? I did not zero superblocks before
the re-create.
2) The NAS this is hosted on places a 2GB partition that is used for a
5 disk RAID1 (md0) that is only used for swap, so resizing that down
on each drive, failing one by one and letting them resync, so I can
gain back a few megabytes of space and mount my XFS filesystem.


Here's an example of --examine on one of the drives too:

root@127.0.0.1:/app/bin# mdadm -Evvvv /dev/sda2
/dev/sda2:
             Magic : a92b4efc
           Version : 1.0
       Feature Map : 0x0
        Array UUID : 5c5ee93c:b52b9bc1:d8cba3fd:802b54ac
              Name : N5500:1  (local to host N5500)
     Creation Time : Sun Jul  5 15:46:21 2020
        Raid Level : raid6
      Raid Devices : 5

    Avail Dev Size : 7809938808 (3724.07 GiB 3998.69 GB)
        Array Size : 23429816064 (11172.21 GiB 11996.07 GB)
     Used Dev Size : 7809938688 (3724.07 GiB 3998.69 GB)
      Super Offset : 7809939064 sectors
             State : clean
       Device UUID : 3db4c62d:2e43ef6c:bf54eb23:ee928fa9

       Update Time : Mon Jul  6 11:16:51 2020
Update Time(Epoch) : 1594030611
          Checksum : 1ccda3df - correct
   Events(64bits) : 4

            Layout : left-symmetric
        Chunk Size : 64K

      Device Role : Active device 0
      Array State : AAAAA ('A' == active, '.' == missing)


Here's the layout of the drive:

root@127.0.0.1:/tmp# /sbin/sgdisk /dev/sda -p
Disk /dev/sda: 7814037168 sectors, 3.6 TiB
Logical sector size: 512 bytes
Disk identifier (GUID): CCAAA40B-2375-48DA-A8DF-9C629F2E121D
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 7814037134
Partitions will be aligned on 2048-sector boundaries
Total free space is 2014 sectors (1007.0 KiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         4098047   2.0 GiB     FD00
   2         4098048      7814037134   3.6 TiB     FD00


I'm afraid the NAS does not have python available, so I cannot run lsdrv.


Many thanks in advance! Any thoughts welcome.
