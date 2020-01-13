Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C143D139D60
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 00:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMXe0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 18:34:26 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37697 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMXe0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 18:34:26 -0500
Received: by mail-lf1-f42.google.com with SMTP id b15so8268978lfc.4
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 15:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=C1YI4NHByZNRsQVu1aLKDznv16qEbWoVV3GuctwxYPY=;
        b=u8+BHIBxgzi8D2qEmupltQ3B6RIHUzXBSwNaR0GxpY/ChfKojw2CUZT+SgFObHARFM
         rX1vJqvtETOGNeOSJLim/EIh6n90mDNFnW8LR17JGpS+sHhOfzTH58roWvNkOOUcWPN9
         5p7TNfRDLjB5kUE0dSpHse5HTvJFeqT8A0HEb+71Xh9rb0a3S9WOuGWyT5lG3P40FEIT
         Ux9migadfZ1WO7tI4Jhwoi5I7O3o+aIh/opI3yPtBopriJ+1z2b4uqrph19DB+UOUqKj
         e9m8jQEELaiUFqR2zRsuAHcmP+wDkkvDNJ4pGx5vdNQOf4NUQHEtlr3PQLqEKWM3d+38
         3kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C1YI4NHByZNRsQVu1aLKDznv16qEbWoVV3GuctwxYPY=;
        b=kUtiZh5TmnQXsyU0Amm73GmNQIsGs2isLYoGA8NMDD9P1p/IZAbhFJtaxC+xPIO5LV
         YofGKAmuvQohJnMwHYDzTsvhpeWPVkN+rros3zJ3uvWeRSHIRm6hrrp4rG5S4m+htzIh
         0ovW9o0/F7TNeUjWmDfXzAvf9DHs5PL7r2Ni6RcU4tf2Q+t2F6z9US3SWM5hhburaPih
         N5BSAROUewQo8r9dvYYbyhyYf3EKG3HRyjC2EQIf4Ei8Fu8JP3lCfvq2buPLLGrdHr6n
         CMIggG5K5sqIblQVxF6vMB/gqksH0XgfJdED5snf1+z9ydiAmJzehiZppc1O1W19SId6
         x37A==
X-Gm-Message-State: APjAAAW+1L+sJyUnesX2uLcQZoZjPxLwn5Gws0Dg40nwGACzN2PEJKO3
        oOL6+jMLWpZAk0LLi4rouMMPlCCb/D5gPIkGIdPwv1In0cXe/w==
X-Google-Smtp-Source: APXvYqzhCYP/WHTWATaDOPrGEdhzigVycVms9E858z0vma40hGWL4ubCGE1uVitooPLb29r+AC8D4RiQ2vRs3TqNp4Y=
X-Received: by 2002:a05:6512:40e:: with SMTP id u14mr10983343lfk.161.1578958464072;
 Mon, 13 Jan 2020 15:34:24 -0800 (PST)
MIME-Version: 1.0
From:   Rickard Svensson <myhex2020@gmail.com>
Date:   Tue, 14 Jan 2020 00:34:12 +0100
Message-ID: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
Subject: Debian Squeeze raid 1 0
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

One disk in my raid 1 0 failed the other night.
It has been running for +8 years, on my server, a Debian Squeeze.
(And yes, I was just about to update them, bought the HD's and everything)

I thought that i would be able to backup the data, but i got ext4
error aswell, and when i tried to repair that with fsck i got:
"
# fsck -n /dev/md0
fsck.ext4: Attempt to read block from filesystem resulted in short
read while trying to open /dev/md0
Could this be a zero-length partition?
"

So i am wondering if my mdadm raid is okay.
The "State  [clean|active]" and "Array State : AA.."    is not so easy
to interpret, tried to read parts of the threads, but at the same time
is worried that more disks should failt... And I'm starting to get
really stressed :(

All the disk are the same type.  And apparently does not support SCT,
which I was not aware of before.
/dev/sde2  seems to be gone.

"
cat /proc/mdstat
Personalities : [raid10]
md0 : active raid10 sda2[0] sde2[3](F) sdc2[2](F) sdb2[1]
      5840999424 blocks super 1.2 512K chunks 2 near-copies [4/2] [UU__]
"

"
smartctl -H -i -l scterc /dev/sda
smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD30EZRX-00MMMB0
Serial Number:    WD-WMAWZ0328886
Firmware Version: 80.00A80
User Capacity:    3 000 592 982 016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Jan 13 23:53:27 2020 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

Warning: device does not support SCT Error Recovery Control command
"


"
/dev/md0:
        Version : 1.2
  Creation Time : Tue Oct  9 23:30:23 2012
     Raid Level : raid10
     Array Size : 5840999424 (5570.41 GiB 5981.18 GB)
  Used Dev Size : 2920499712 (2785.21 GiB 2990.59 GB)
   Raid Devices : 4
  Total Devices : 4
    Persistence : Superblock is persistent

    Update Time : Mon Jan 13 22:47:33 2020
          State : clean, FAILED
 Active Devices : 2
Working Devices : 2
 Failed Devices : 2
  Spare Devices : 0

         Layout : near=2
     Chunk Size : 512K

           Name : ttserv:0  (local to host ttserv)
           UUID : cb5bfe7a:3806324c:3c1e7030:e6267102
         Events : 2860

    Number   Major   Minor   RaidDevice State
       0       8        2        0      active sync   /dev/sda2
       1       8       18        1      active sync   /dev/sdb2
       2       0        0        2      removed
       3       0        0        3      removed

       2       8       34        -      faulty spare   /dev/sdc2
       3       8       66        -      faulty spare
"

"
/dev/sda2:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x0
     Array UUID : cb5bfe7a:3806324c:3c1e7030:e6267102
           Name : ttserv:0  (local to host ttserv)
  Creation Time : Tue Oct  9 23:30:23 2012
     Raid Level : raid10
   Raid Devices : 4

 Avail Dev Size : 5840999786 (2785.21 GiB 2990.59 GB)
     Array Size : 11681998848 (5570.41 GiB 5981.18 GB)
  Used Dev Size : 5840999424 (2785.21 GiB 2990.59 GB)
    Data Offset : 2048 sectors
   Super Offset : 8 sectors
          State : clean
    Device UUID : f474ad64:6bb236d3:9f69f55c:eb9b8c27

    Update Time : Mon Jan 13 22:47:33 2020
       Checksum : 5c2fce09 - correct
         Events : 2860

         Layout : near=2
     Chunk Size : 512K

   Device Role : Active device 0
   Array State : AA.. ('A' == active, '.' == missing)
/dev/sdb2:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x0
     Array UUID : cb5bfe7a:3806324c:3c1e7030:e6267102
           Name : ttserv:0  (local to host ttserv)
  Creation Time : Tue Oct  9 23:30:23 2012
     Raid Level : raid10
   Raid Devices : 4

 Avail Dev Size : 5840999786 (2785.21 GiB 2990.59 GB)
     Array Size : 11681998848 (5570.41 GiB 5981.18 GB)
  Used Dev Size : 5840999424 (2785.21 GiB 2990.59 GB)
    Data Offset : 2048 sectors
   Super Offset : 8 sectors
          State : clean
    Device UUID : 1a67153d:8d15019a:349926d5:e22dd321

    Update Time : Mon Jan 13 22:47:33 2020
       Checksum : 6dd9e4de - correct
         Events : 2860

         Layout : near=2
     Chunk Size : 512K

   Device Role : Active device 1
   Array State : AA.. ('A' == active, '.' == missing)
/dev/sdc2:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x0
     Array UUID : cb5bfe7a:3806324c:3c1e7030:e6267102
           Name : ttserv:0  (local to host ttserv)
  Creation Time : Tue Oct  9 23:30:23 2012
     Raid Level : raid10
   Raid Devices : 4

 Avail Dev Size : 5840999786 (2785.21 GiB 2990.59 GB)
     Array Size : 11681998848 (5570.41 GiB 5981.18 GB)
  Used Dev Size : 5840999424 (2785.21 GiB 2990.59 GB)
    Data Offset : 2048 sectors
   Super Offset : 8 sectors
          State : active
    Device UUID : 23079ae3:c67969c2:13299e27:8ca3cf7f

    Update Time : Sun Jan 12 00:11:05 2020
       Checksum : ed375eb5 - correct
         Events : 2719

         Layout : near=2
     Chunk Size : 512K

   Device Role : Active device 2
   Array State : AAA. ('A' == active, '.' == missing)
"


I really hope someone can help me!

/Rickard
