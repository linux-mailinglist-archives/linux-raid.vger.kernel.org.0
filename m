Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC0A678B
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfICLig (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 07:38:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39108 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICLif (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 07:38:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id u6so12349071edq.6
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YvgxPnO6GEQ6D8Af20hiva1v69L/gr/L4rPX+WDwRqM=;
        b=A8b+U3X4zffZZ29LIgJlWvnB8gurcqf5piy/uyKfmm1rMjL/JRHz++50/e9jBCWEo+
         4j/CZe+viD819jOmtK7QhP71sgDD1zLr+KDhU/VWbS68aX5YeWB1TCT96uPSILGG0bT/
         xCcBOOyH6mGLmLRn+xTCaivgH4DwxCODfzA2QItWsqPj/jRquRFS+93FSQN9VDsDnEI3
         StVHN8B19VGHxcG71Hw4opw1X/GnG7Nh8kMICtaqvduaOcPBpsFK8ajz0ahqhdGDhc6z
         upNY3HNq5ve3POm90mM6R1pLZBl8v6nbW/jo81SAo7fd/Qnlv7nHY1L7TJJrqpBen/wS
         yDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YvgxPnO6GEQ6D8Af20hiva1v69L/gr/L4rPX+WDwRqM=;
        b=q1iWjB1715t8qbVKwnGLr0zHYJCXHPoxhIjrGHUcxFq7ZOvPKQJN5Pyj9CyeXoz7gC
         ePX49lcfL6RSpVdjCMFJSBM6ogX7v1t3U0TeY2JySpqwEccesVDNAdeuT2gwbMqjirYR
         hEi+xsXpFTg5kpFVLBgzRIAGddlaVlKo5V5w9vm6Ml+o48cXkdxThu2WNJ92IhWQFrhn
         iDzzc9OGX17wZjRVBk05CkIzvLSjwFUIDatiJDxbW1Oxfh1TbKcXivoaDMbW6IXHHdPR
         GRJ2LUi/bb47qbe3vbxJZPZ++8Zuvxbw4f2DtARqa/tJnaIzuLRhcEe8vT2kBneXtfRR
         +lOQ==
X-Gm-Message-State: APjAAAXchI7dRhmb1MJoB2vbERgXQeYAiKDj3rNZ0ZmxxRh4RIEiDsq+
        I9qeCPm3ekeGsxLOqWPFQH54EyzfxZd+XNsm4Jk=
X-Google-Smtp-Source: APXvYqyURM9YQNOcmDhG22rKjgGT0iFwePWYDeava15XbiG/Ha4Nd/TtjDIWGKYzMxaMPW3VvoI+PGKye1Djl/Egl0o=
X-Received: by 2002:a05:6402:347:: with SMTP id r7mr10702941edw.41.1567510711839;
 Tue, 03 Sep 2019 04:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk> <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
 <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org> <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
 <87h85udyfs.fsf@notabene.neil.brown.name>
In-Reply-To: <87h85udyfs.fsf@notabene.neil.brown.name>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Tue, 3 Sep 2019 13:38:05 +0200
Message-ID: <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     NeilBrown <neilb@suse.de>
Cc:     Phil Turmel <philip@turmel.org>, Neil F Brown <nfbrown@suse.com>,
        linux-raid@vger.kernel.org, Wols Lists <antlists@youngman.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Neil,

Many thanks for your input! The support you guys are providing is one of a =
kind!

I've been able to kill some of the blocked processes, releasing the
locked files in the `/data` mount point, but some of them remained
locked.
I've booted with SystemRescueCD and it automatically detected and
assembled the array as md127. The array was in read-only state, but
after mounting it in SystemRescueCD `/mnt` the reshape process started
from begining. Right now the `/proc/mdstat` looks as follows:

[root@sysresccd ~]# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md127 : active raid6 sda1[5] sdg1[6] sdd1[4] sdf1[3]
      7813771264 blocks super 1.2 level 6, 512k chunk, algorithm 18 [4/3] [=
UUU_]
      [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>...]  reshape =
=3D 88.1% (3444089344/3906885632)
finish=3D189.5min speed=3D40688K/sec
      bitmap: 8/30 pages [32KB], 65536KB chunk

unused devices: <none>

Initially the speed was reaching 63M/sec, but now it's a bit slower,
however still at a very good level.

The `mdadm --examine` output is shown below:

[root@sysresccd ~]# mdadm --examine /dev/sda
/dev/sda:
   MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
[root@sysresccd ~]# mdadm --examine /dev/sda1
/dev/sda1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x45
     Array UUID : a3d7766c:aeb658d3:8e2d29b7:4de30dab
           Name : debnas:0
  Creation Time : Thu Dec 25 12:15:20 2014
     Raid Level : raid6
   Raid Devices : 4

 Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
     Array Size : 7813771264 (7451.79 GiB 8001.30 GB)
    Data Offset : 262144 sectors
     New Offset : 131072 sectors
   Super Offset : 8 sectors
          State : active
    Device UUID : 1ca5a215:ce082450:6ebb8d48:ae2e78f6

Internal Bitmap : 8 sectors from superblock
  Reshape pos'n : 6856704000 (6539.06 GiB 7021.26 GB)
     New Layout : left-symmetric

    Update Time : Tue Sep  3 11:17:21 2019
  Bad Block Log : 512 entries available at offset 72 sectors
       Checksum : 159054c7 - correct
         Events : 210442

         Layout : left-symmetric-6
     Chunk Size : 512K

   Device Role : Active device 0
   Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)

What can you say about the data offset?

The question that still remains is: when the reshape in SystemRescueCD
finishes, can I safely mount the array in the outdated host and
perform mdadm and system updates?

Also, what I've found in `dmesg` is quite distressing:

[ 1149.107869] md: reshape of RAID array md127
[ 1149.521336] EXT4-fs (dm-0): 1 orphan inode deleted
[ 1149.521338] EXT4-fs (dm-0): recovery complete
[ 1149.826795] EXT4-fs (dm-0): mounted filesystem with ordered data
mode. Opts: (null)
[ 1151.392376] md/raid:md127: read error corrected (8 sectors at
9990072 on sda1)
[ 1151.392379] md/raid:md127: read error corrected (8 sectors at
9990080 on sda1)
[ 1151.392380] md/raid:md127: read error corrected (8 sectors at
9990088 on sda1)
[ 1151.392382] md/raid:md127: read error corrected (8 sectors at
9990096 on sda1)
[ 1151.392383] md/raid:md127: read error corrected (8 sectors at
9990104 on sda1)
[ 1151.392385] md/raid:md127: read error corrected (8 sectors at
9990112 on sda1)
[ 1151.392387] md/raid:md127: read error corrected (8 sectors at
9990120 on sda1)
[ 1151.392388] md/raid:md127: read error corrected (8 sectors at
9990128 on sda1)
[ 1151.392390] md/raid:md127: read error corrected (8 sectors at
9990136 on sda1)
[ 1151.392391] md/raid:md127: read error corrected (8 sectors at
9990144 on sda1)
[ 1273.654745] raid5_end_read_request: 364 callbacks suppressed
[ 1273.654748] md/raid:md127: read error corrected (8 sectors at
24437552 on sda1)
[ 1273.654750] md/raid:md127: read error corrected (8 sectors at
24437560 on sda1)
[ 1273.654752] md/raid:md127: read error corrected (8 sectors at
24437568 on sda1)
[ 1273.654754] md/raid:md127: read error corrected (8 sectors at
24437576 on sda1)
[ 1273.654756] md/raid:md127: read error corrected (8 sectors at
24437584 on sda1)
[ 1273.654758] md/raid:md127: read error corrected (8 sectors at
24437592 on sda1)
[ 1273.654759] md/raid:md127: read error corrected (8 sectors at
24437600 on sda1)
[ 1273.654761] md/raid:md127: read error corrected (8 sectors at
24437608 on sda1)
[ 1273.654763] md/raid:md127: read error corrected (8 sectors at
24437616 on sda1)
[ 1273.654765] md/raid:md127: read error corrected (8 sectors at
24437624 on sda1)
[ 1324.777467] raid5_end_read_request: 118 callbacks suppressed
[ 1324.777471] md/raid:md127: read error corrected (8 sectors at
30680296 on sdd1)
[ 1324.777474] md/raid:md127: read error corrected (8 sectors at
30680304 on sdd1)
[ 1324.777476] md/raid:md127: read error corrected (8 sectors at
30680312 on sdd1)
[ 1324.777478] md/raid:md127: read error corrected (8 sectors at
30680320 on sdd1)
[ 1324.777480] md/raid:md127: read error corrected (8 sectors at
30680328 on sdd1)
[ 1324.777483] md/raid:md127: read error corrected (8 sectors at
30680336 on sdd1)
[ 1324.777485] md/raid:md127: read error corrected (8 sectors at
30680344 on sdd1)
[ 1324.777487] md/raid:md127: read error corrected (8 sectors at
30680352 on sdd1)
[ 1324.777489] md/raid:md127: read error corrected (8 sectors at
30680360 on sdd1)
[ 1324.777491] md/raid:md127: read error corrected (8 sectors at
30680368 on sdd1)
[ 5225.912468] raid5_end_read_request: 22 callbacks suppressed
[ 5225.912472] md/raid:md127: read error corrected (8 sectors at
509112152 on sda1)
[ 5225.912475] md/raid:md127: read error corrected (8 sectors at
509112160 on sda1)
[ 5225.912477] md/raid:md127: read error corrected (8 sectors at
509112168 on sda1)
[ 5225.912478] md/raid:md127: read error corrected (8 sectors at
509112176 on sda1)
[ 5225.912481] md/raid:md127: read error corrected (8 sectors at
509112184 on sda1)
[ 5225.912482] md/raid:md127: read error corrected (8 sectors at
509112192 on sda1)
[ 5225.912484] md/raid:md127: read error corrected (8 sectors at
509112200 on sda1)
[ 5225.912486] md/raid:md127: read error corrected (8 sectors at
509112208 on sda1)
[ 5225.912488] md/raid:md127: read error corrected (8 sectors at
509112216 on sda1)
[ 5225.912489] md/raid:md127: read error corrected (8 sectors at
509112224 on sda1)
[ 7234.974190] perf: interrupt took too long (2517 > 2500), lowering
kernel.perf_event_max_sample_rate to 79400
[ 9732.823248] perf: interrupt took too long (3152 > 3146), lowering
kernel.perf_event_max_sample_rate to 63400
[16490.333419] perf: interrupt took too long (3943 > 3940), lowering
kernel.perf_event_max_sample_rate to 50700
[24515.160554] audit: type=3D1130 audit(1567468823.835:34): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dshadow comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24515.217087] audit: type=3D1131 audit(1567468823.885:35): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dshadow comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24515.519762] audit: type=3D1130 audit(1567468824.195:36): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlogrotate comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24515.519767] audit: type=3D1131 audit(1567468824.195:37): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlogrotate comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24515.970085] audit: type=3D1130 audit(1567468824.645:38): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dupdatedb comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24515.970098] audit: type=3D1131 audit(1567468824.645:39): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dupdatedb comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24750.433082] audit: type=3D1130 audit(1567469059.105:40): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dman-db comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24750.433086] audit: type=3D1131 audit(1567469059.105:41): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dman-db comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[24891.316197] raid5_end_read_request: 86 callbacks suppressed
[24891.316200] md/raid:md127: read error corrected (8 sectors at
2883434712 on sda1)
[24891.316204] md/raid:md127: read error corrected (8 sectors at
2883434720 on sda1)
[24891.316205] md/raid:md127: read error corrected (8 sectors at
2883434728 on sda1)
[24891.316207] md/raid:md127: read error corrected (8 sectors at
2883434736 on sda1)
[24891.316208] md/raid:md127: read error corrected (8 sectors at
2883434744 on sda1)
[24891.316210] md/raid:md127: read error corrected (8 sectors at
2883434752 on sda1)
[24891.316211] md/raid:md127: read error corrected (8 sectors at
2883434760 on sda1)
[24891.316213] md/raid:md127: read error corrected (8 sectors at
2883434768 on sda1)
[24891.316214] md/raid:md127: read error corrected (8 sectors at
2883434776 on sda1)
[24891.316216] md/raid:md127: read error corrected (8 sectors at
2883434784 on sda1)
[24974.432792] raid5_end_read_request: 22 callbacks suppressed
[24974.432795] md/raid:md127: read error corrected (8 sectors at
2892979280 on sdd1)
[24974.432799] md/raid:md127: read error corrected (8 sectors at
2892979288 on sdd1)
[24974.432801] md/raid:md127: read error corrected (8 sectors at
2892979296 on sdd1)
[24974.432803] md/raid:md127: read error corrected (8 sectors at
2892979304 on sdd1)
[24974.432805] md/raid:md127: read error corrected (8 sectors at
2892979312 on sdd1)
[24974.432807] md/raid:md127: read error corrected (8 sectors at
2892979320 on sdd1)
[24974.432810] md/raid:md127: read error corrected (8 sectors at
2892979328 on sdd1)
[24974.432812] md/raid:md127: read error corrected (8 sectors at
2892979336 on sdd1)
[24974.432814] md/raid:md127: read error corrected (8 sectors at
2892979344 on sdd1)
[24974.432816] md/raid:md127: read error corrected (8 sectors at
2892979352 on sdd1)

What do you think of that? The `smartctl -a` for the reported drives
is not showing anything unusual and the drives are new, so it
shouldn't be a hardware problem (still not noticed by SMART):

[root@sysresccd ~]# smartctl -a /dev/sda
smartctl 7.0 2018-12-30 r4883 [x86_64-linux-4.19.34-1-lts] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red
Device Model:     WDC WD40EFRX-68N32N0
Serial Number:    WD-WCC7K0YEYNV9
LU WWN Device Id: 5 0014ee 2663bb359
Firmware Version: 82.00A82
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Tue Sep  3 11:34:24 2019 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Disab=
led.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                        without error or no self-test has e=
ver
                                        been run.
Total time to complete Offline
data collection:                (45360) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection
on/off support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 482) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.
SCT capabilities:              (0x303d) SCT Status supported.
                                        SCT Error Recovery Control supporte=
d.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0027   210   163   021    Pre-fail
Always       -       4475
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       67
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       195
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       67
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       21
193 Load_Cycle_Count        0x0032   200   200   000    Old_age
Always       -       52
194 Temperature_Celsius     0x0022   110   105   000    Old_age
Always       -       40
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

Can I see if the filest at those reported sectors are correct?

Best regards,
Krzysztof Jakobczyk

wt., 3 wrz 2019 o 02:18 NeilBrown <neilb@suse.de> napisa=C5=82(a):
>
> On Mon, Sep 02 2019, Krzysztof Jak=C3=B3bczyk wrote:
>
> > Gentlemen,
> >
> > Just in order for me not to mix anything important I will quickly
> > summarize what I'm about to do:
> > I will try to release all the files that are being used on the target
> > md0, by checking what is still being used with "lsof /data" and then
> > will kill the processes that are still trying to use the array.
>
> You won't be able to kill those processes, and there is half a chance
> that the "lsof /data" will hang and be unkillable.
>
> > After the files are being unlocked I will perform the outdated host shu=
tdown.
>
> I would
>    sync &
>    wait a little while
>    reboot -f -n
>
> A Linux system should always survive "reboot -f -n" with little data
> loss, usually none.
>
> > I will boot a thumbstick on that computer with SystemRescueCD and will
> > try to assemble the array with the "mdadm --assemble --scan -v --run"
> > applying --force if necessary.
>
> --force shouldn't be necessary, so if the first version doesn't work,
> check with us first.
> >
> > Please confirm me if my understanding is correct.
>
> I'd like some more details: particular "mdadm -E" of one or more
> component drives.  I'm curious what the data offset is.  As you didn't
> need to git a "--backup=3D...." arg to mdadm, I suspect it is reasonably
> large, which is good.
> Sometimes raid reshape needs an 'mdadm' running to help the kernel, and
> if that mdadm gets killed, the reshape will hang.
> But with a largeish data-offset, no mdadm helper is needed.
>
> The hang was reported 307 seconds after a "read error corrected"
> message. And by that time it had hung for at least 120 seconds - maybe
> as much as 240.  So there isn't obviously a strong connection, but maybe
> there is a cause/effect there.
>
> Looking at code fixes since 3.16, I can see a couple of live-lock bugs
> fixed, but they were fixed well before 2016-12-30, so probably got back
> ported to the Debian kernel.
>
> So I cannot easily find an explanation.
>
> I suspect that if you just rebooted, the reshape would restart and
> continue happily (unless/until another read error was found).
> Rebooting to a rescue CD is likely to be safer.
> Likely worst case is that it will hang again, and we'll need to look
> more deeply.
>
> In any case, I'd like to see that "mdadm --examine" output.
>
> Thanks,
> NeilBrown

wt., 3 wrz 2019 o 02:18 NeilBrown <neilb@suse.de> napisa=C5=82(a):
>
> On Mon, Sep 02 2019, Krzysztof Jak=C3=B3bczyk wrote:
>
> > Gentlemen,
> >
> > Just in order for me not to mix anything important I will quickly
> > summarize what I'm about to do:
> > I will try to release all the files that are being used on the target
> > md0, by checking what is still being used with "lsof /data" and then
> > will kill the processes that are still trying to use the array.
>
> You won't be able to kill those processes, and there is half a chance
> that the "lsof /data" will hang and be unkillable.
>
> > After the files are being unlocked I will perform the outdated host shu=
tdown.
>
> I would
>    sync &
>    wait a little while
>    reboot -f -n
>
> A Linux system should always survive "reboot -f -n" with little data
> loss, usually none.
>
> > I will boot a thumbstick on that computer with SystemRescueCD and will
> > try to assemble the array with the "mdadm --assemble --scan -v --run"
> > applying --force if necessary.
>
> --force shouldn't be necessary, so if the first version doesn't work,
> check with us first.
> >
> > Please confirm me if my understanding is correct.
>
> I'd like some more details: particular "mdadm -E" of one or more
> component drives.  I'm curious what the data offset is.  As you didn't
> need to git a "--backup=3D...." arg to mdadm, I suspect it is reasonably
> large, which is good.
> Sometimes raid reshape needs an 'mdadm' running to help the kernel, and
> if that mdadm gets killed, the reshape will hang.
> But with a largeish data-offset, no mdadm helper is needed.
>
> The hang was reported 307 seconds after a "read error corrected"
> message. And by that time it had hung for at least 120 seconds - maybe
> as much as 240.  So there isn't obviously a strong connection, but maybe
> there is a cause/effect there.
>
> Looking at code fixes since 3.16, I can see a couple of live-lock bugs
> fixed, but they were fixed well before 2016-12-30, so probably got back
> ported to the Debian kernel.
>
> So I cannot easily find an explanation.
>
> I suspect that if you just rebooted, the reshape would restart and
> continue happily (unless/until another read error was found).
> Rebooting to a rescue CD is likely to be safer.
> Likely worst case is that it will hang again, and we'll need to look
> more deeply.
>
> In any case, I'd like to see that "mdadm --examine" output.
>
> Thanks,
> NeilBrown
