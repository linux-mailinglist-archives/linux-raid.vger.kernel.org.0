Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F601DBFF0
	for <lists+linux-raid@lfdr.de>; Wed, 20 May 2020 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgETULz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 May 2020 16:11:55 -0400
Received: from u17383850.onlinehome-server.com ([74.208.250.170]:49021 "EHLO
        u17383850.onlinehome-server.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgETULy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 20 May 2020 16:11:54 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 16:11:54 EDT
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id AF0A1767; Wed, 20 May 2020 16:05:14 -0400 (EDT)
Date:   Wed, 20 May 2020 16:05:14 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Subject: failed disks, mapper, and "Invalid argument"
Message-ID: <20200520200514.GE1415@justpickone.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, all --

I have a four-partition RAID5 array of which one disk failed while I was
out of town and a second failed just today.  Both failed smartctl tests
by not even starting, although I don't have that captured.  Those two
were on a SATA daughtercard, so I swapped them (formerly sde, sdf)
up to the motherboard SATA ports like the other two (still sda, sdb) and
now all are visible and happily pass smartctl checks and generally look
good ... except that my md0 doesn't :-(

I've been through the wiki and other found documentation and have scraped
the archives, but the whole mapper thing is new to me, and I don't know
enough to pin down the error.  I've been attempting to fake-build my
array with overlay devices to see how it will do.  Please forgive the
long post if it's a bit ridiculous; I wanted to make sure that you have
all information :-)

Here's the array after I swapped ports and booted up:

  diskfarm:root:10:~> mdadm --detail /dev/md0
  /dev/md0:
          Version : 1.2
    Creation Time : Mon Feb  6 00:56:35 2017
       Raid Level : raid5
    Used Dev Size : 4294967295
     Raid Devices : 4
    Total Devices : 2
      Persistence : Superblock is persistent

      Update Time : Mon May 18 01:10:07 2020
            State : active, FAILED, Not Started
   Active Devices : 2
  Working Devices : 2
   Failed Devices : 0
    Spare Devices : 0

           Layout : left-symmetric
       Chunk Size : 512K

             Name : diskfarm:0  (local to host diskfarm)
             UUID : ca7008ef:90693dae:6c231ad7:08b3f92d
           Events : 57840

      Number   Major   Minor   RaidDevice State
         0       8       17        0      active sync   /dev/sdb1
         -       0        0        1      removed
         -       0        0        2      removed
         4       8        1        3      active sync   /dev/sda1


  diskfarm:root:10:~> mdadm --examine /dev/sd[abcd]1 | egrep '/dev|vents'
  /dev/sda1:
           Events : 57840
  /dev/sdb1:
           Events : 57840
  /dev/sdc1:
           Events : 57836
  /dev/sdd1:
           Events : 48959

I'd say sdd is the former sde that went away first and sdc that was sdf
only just fell over.

In my first round, I shut down md0

  diskfarm:root:12:~> mdadm --stop /dev/md0
  mdadm: stopped /dev/md0
  diskfarm:root:12:~> cat /proc/mdstat
  Personalities : [raid6] [raid5] [raid4]
  md127 : active raid5 sdf2[0] sdg2[1] sdh2[3]
        1464622080 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UUU]

  unused devices: <none>

and of course it isn't in mdstat any more.  Oops.  But it's down, so we
won't see any more writes that could be messy.

I whipped up four loop devices and created overlay files

  diskfarm:root:13:/mnt/scratch/disks> parallel truncate -s8G overlay-{/} ::: $DEVICES
  ...
  To silence this citation notice: run 'parallel --citation'.

  diskfarm:root:13:/mnt/scratch/disks> ls -goh
  total 33M
  -rw-r--r-- 1 8.0G May 20 14:00 overlay-sda1
  -rw-r--r-- 1 8.0G May 20 14:00 overlay-sdb1
  -rw-r--r-- 1 8.0G May 20 14:00 overlay-sdc1
  -rw-r--r-- 1 8.0G May 20 14:00 overlay-sdd1
  -rw-r--r-- 1  11K May 20 13:20 smartctl-a.sda.out
  -rw-r--r-- 1 5.3K May 20 13:20 smartctl-a.sdb.out
  -rw-r--r-- 1 5.3K May 20 13:20 smartctl-a.sdc.out
  -rw-r--r-- 1 5.3K May 20 13:20 smartctl-a.sdd.out

  diskfarm:root:13:/mnt/scratch/disks> du -skhc overlay-sd*
  8.0M    overlay-sda1
  8.0M    overlay-sdb1
  8.0M    overlay-sdc1
  8.0M    overlay-sdd1
  32M     total

  diskfarm:root:13:/mnt/scratch/disks> ls -goh /dev/mapper/*
  crw------- 1 10, 236 May 20 08:04 /dev/mapper/control
  lrwxrwxrwx 1       7 May 20 14:02 /dev/mapper/sda1 -> ../dm-1
  lrwxrwxrwx 1       7 May 20 14:02 /dev/mapper/sdb1 -> ../dm-0
  lrwxrwxrwx 1       7 May 20 14:02 /dev/mapper/sdc1 -> ../dm-2
  lrwxrwxrwx 1       7 May 20 14:02 /dev/mapper/sdd1 -> ../dm-3

and grabbed my overlays and checked the mapper

  diskfarm:root:13:/mnt/scratch/disks> OVERLAYS=$(parallel echo /dev/mapper/{/} ::: $DEVICES)
  diskfarm:root:13:/mnt/scratch/disks> echo $OVERLAYS
  /dev/mapper/sda1 /dev/mapper/sdb1 /dev/mapper/sdc1 /dev/mapper/sdd1
  diskfarm:root:13:/mnt/scratch/disks> dmsetup status
  sdb1: 0 3518805647 snapshot 16/16777216 16
  sdc1: 0 3518805647 snapshot 16/16777216 16
  sda1: 0 3518805647 snapshot 16/16777216 16
  sdd1: 0 3518805647 snapshot 16/16777216 16

and so far it looks good ... as far as I know :-)

I didn't know if I should try md0, the real array name, or create a new
md1, so I took the safe approach first

  diskfarm:root:13:/mnt/scratch/disks> mdadm --assemble --force /dev/md1 $OVERLAYS
  mdadm: forcing event count in /dev/mapper/sdc1(2) from 57836 upto 57840
  mdadm: clearing FAULTY flag for device 2 in /dev/md1 for /dev/mapper/sdc1
  mdadm: Marking array /dev/md1 as 'clean'
  mdadm: failed to add /dev/mapper/sdd1 to /dev/md1: Invalid argument
  mdadm: failed to add /dev/mapper/sdc1 to /dev/md1: Invalid argument
  mdadm: failed to add /dev/mapper/sda1 to /dev/md1: Invalid argument
  mdadm: failed to add /dev/mapper/sdb1 to /dev/md1: Invalid argument
  mdadm: failed to RUN_ARRAY /dev/md1: Invalid argument

  diskfarm:root:13:/mnt/scratch/disks> cat /proc/mdstat
  Personalities : [raid6] [raid5] [raid4]
  md127 : active raid5 sdf2[0] sdg2[1] sdh2[3]
        1464622080 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UUU]

  unused devices: <none>

  diskfarm:root:13:/mnt/scratch/disks> mdadm --examine /dev/md1
  mdadm: cannot open /dev/md1: No such file or directory

but didn't fet to move on to the next wiki step.  I crossed my fingers
and tried md0

  diskfarm:root:13:/mnt/scratch/disks> mdadm --assemble --force /dev/md0 $OVERLAYS
  mdadm: failed to add /dev/mapper/sdd1 to /dev/md0: Invalid argument
  mdadm: failed to add /dev/mapper/sdc1 to /dev/md0: Invalid argument
  mdadm: failed to add /dev/mapper/sda1 to /dev/md0: Invalid argument
  mdadm: failed to add /dev/mapper/sdb1 to /dev/md0: Invalid argument
  mdadm: failed to RUN_ARRAY /dev/md0: Invalid argument

  diskfarm:root:13:/mnt/scratch/disks> mdadm --assemble --force /dev/md0 --verbose $OVERLAYS
  mdadm: looking for devices for /dev/md0
  mdadm: /dev/mapper/sda1 is identified as a member of /dev/md0, slot 3.
  mdadm: /dev/mapper/sdb1 is identified as a member of /dev/md0, slot 0.
  mdadm: /dev/mapper/sdc1 is identified as a member of /dev/md0, slot 2.
  mdadm: /dev/mapper/sdd1 is identified as a member of /dev/md0, slot 1.
  mdadm: failed to add /dev/mapper/sdd1 to /dev/md0: Invalid argument
  mdadm: failed to add /dev/mapper/sdc1 to /dev/md0: Invalid argument
  mdadm: failed to add /dev/mapper/sda1 to /dev/md0: Invalid argument
  mdadm: failed to add /dev/mapper/sdb1 to /dev/md0: Invalid argument
  mdadm: failed to RUN_ARRAY /dev/md0: Invalid argument

  diskfarm:root:13:/mnt/scratch/disks> mdadm --detail /dev/md0
  mdadm: cannot open /dev/md0: No such file or directory

and STILL got nowhere.  It was at this point that I figured I need to
back away and call for help!  I don't want to try rebuilding the actual
array in case it's out of sync and I lose data.

Soooooo...  There it is.  Any suggestions to correct whatever oops I've
made or complete a step I overlooked?  Any ideas why my assemble didn't?


TIA & HAND

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

