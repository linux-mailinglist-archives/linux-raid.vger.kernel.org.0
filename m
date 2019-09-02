Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080B5A5396
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfIBKGP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 06:06:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32932 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfIBKGP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Sep 2019 06:06:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id o9so3557705edq.0
        for <linux-raid@vger.kernel.org>; Mon, 02 Sep 2019 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sjq6AMqKuhU0vE1DeT+Kxx8UcHX8VX4WyxCSgnuJoZI=;
        b=pm2/tsfRpvUimqzpRbLff6jMBwINS5vidSOkkbLt1ofvv/o38e5u4GgLnDLcTe2FAe
         meOnpUqHWnEEkcmCRsc5BTKjRJuw/8rs+zr4XwO9EZ85gQTWQKkY93d9Lz+3A4ix24ip
         tL7nDcdJDaztlY/fqV3O0zFgO/gboC35bG9ScyUZIDmavGf6vakPNZ1Rx8iNjc8sqz+t
         A3GDMoChQJJhYouvGe55sRxMP0c23JYayDUKdqHk8C/YwLHK5HQt+WT9ZmuXcJ7RXuHj
         uObexxxUZPs28UtkMHi3mCE4hYbL4ZKd5BlikJ6x+OTWN5IROU1um/Xoe7e/hxKQoGav
         xHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=sjq6AMqKuhU0vE1DeT+Kxx8UcHX8VX4WyxCSgnuJoZI=;
        b=YdbQtKSV2AVBwsOcB3gl+xP9A0/aTuWXHuJc5ztF6NDLiTQM2q/1oS0UlMj7TR3/0Q
         4rxiV1yPSNyBvGjZGbtOJsOH3h6wWvKRTe+apBzOBd2olvAuRHCq8w419I853T2NAqNU
         TH5sZcJRUc/rjifNHTGHmvGDzjwGxFtyE9Mw5EGsbCrHELJ6rRBZsSjMOgmYRqQTOAKA
         rsw9qXhOMaiU0DPHNvWwf/NJfmzH+kM9tkC0kzM2hewuwUHS+ElRVyp46gsuxB4+2vR9
         kRZI5ykQRwxizQMibwjVFym86UyGpWHlP3PmwZzvR/D8/sxEsHQS9hIotblgaKki+4U+
         su3Q==
X-Gm-Message-State: APjAAAXSzi5pHTomxVnJBAnwHGP3wmG7zQJIlmLEN6YZigTMsC8ZfpMh
        XiODTtQHmA+p7pxCMjnOBZA1m8uIoMyhG9sz30fb/Q==
X-Google-Smtp-Source: APXvYqz7TwrgH7abHLUA+GY+hZpsZtP5B4DWpJLwXxDPk3JbDQ1tARAjwCm3pw4hx/vu7GoshMGcGzzAmxm+GM06bD0=
X-Received: by 2002:a17:906:4bc2:: with SMTP id x2mr23839644ejv.95.1567418771818;
 Mon, 02 Sep 2019 03:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
In-Reply-To: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Mon, 2 Sep 2019 12:05:34 +0200
Message-ID: <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
Subject: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to data lost
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Sir/Madam,

After a dozen of hours waiting for my array reshape to move on I think
it's finally the right time to ask you for some advice.

Recently I bought 4th WD Red 4TB drive to migrate my 3-disk RAID5
setup to RAID6. All disks are WD Red 4TB, so I have 8TB of usable
space. The space occupation is right now at 50%.

I've installed the 4th disk and added it to the /dev/md0 with the
following command:

mdadm --manage /dev/md0 --add /dev/sdf1

Then I've started the RAID5 to RAID6 migration with the following command:

mdadm --grow /dev/md0 --level=3D6 --raid-disk=3D4

The grow operation started and initially the speed was pretty decent
compared to what I've found over the Internet, but after 12 hours I've
reached 44k/sec and right it's 10k/sec. The cat /proc/mdstat looks as
follows:

Personalities : [raid6] [raid5] [raid4]
md0 : active raid6 sdf1[6] sdd1[4] sda1[5] sde1[3]
      7813771264 blocks super 1.2 level 6, 512k chunk, algorithm 18 [4/3] [=
UUU_]
      [>....................]  reshape =3D  0.1% (4931044/3906885632)
finish=3D6498319.2min speed=3D10K/sec
      bitmap: 8/30 pages [32KB], 65536KB chunk

unused devices: <none>

The reshape process didn't move from 4931044 for 5-6 hours in the time
of writing this question.

The disk layout of the system i'm working on is the following (a dump
from lsblk):

NAME               MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                  8:0    0  3.7T  0 disk
=E2=94=94=E2=94=80sda1               8:1    0  3.7T  0 part
  =E2=94=94=E2=94=80md0              9:0    0  7.3T  0 raid6
    =E2=94=94=E2=94=80vg_data-data 254:0    0  7.3T  0 lvm   /data
sdb                  8:16   0 55.9G  0 disk
=E2=94=9C=E2=94=80sdb1               8:17   0 53.6G  0 part  /
=E2=94=9C=E2=94=80sdb2               8:18   0    1K  0 part
=E2=94=94=E2=94=80sdb5               8:21   0  2.3G  0 part  [SWAP]
sdc                  8:32   0  1.8T  0 disk
=E2=94=94=E2=94=80sdc1               8:33   0  1.8T  0 part  /mnt/Backup-us=
b
sdd                  8:48   0  3.7T  0 disk
=E2=94=94=E2=94=80sdd1               8:49   0  3.7T  0 part
  =E2=94=94=E2=94=80md0              9:0    0  7.3T  0 raid6
    =E2=94=94=E2=94=80vg_data-data 254:0    0  7.3T  0 lvm   /data
sde                  8:64   0  3.7T  0 disk
=E2=94=94=E2=94=80sde1               8:65   0  3.7T  0 part
  =E2=94=94=E2=94=80md0              9:0    0  7.3T  0 raid6
    =E2=94=94=E2=94=80vg_data-data 254:0    0  7.3T  0 lvm   /data
sdf                  8:80   0  3.7T  0 disk
=E2=94=94=E2=94=80sdf1               8:81   0  3.7T  0 part
  =E2=94=94=E2=94=80md0              9:0    0  7.3T  0 raid6
    =E2=94=94=E2=94=80vg_data-data 254:0    0  7.3T  0 lvm   /data

The /dev/md0 is mounted on /data In order to speed up the migration
I've adjusted the following parameters after the reshape was running:

sysctl -w dev.raid.speed_limit_min=3D100000
sysctl -w dev.raid.speed_limit_max=3D500000
echo 4096 > /sys/block/md0/md/stripe_cache_size
blockdev --setra 65536 /dev/md0

I've also issued echo max > /sys/block/md0/md/sync_max two times in
order to see if it won't affect the speed positively.

My problem is that currently, the reshape process seems to be stuck.
If dmesg | grep md0 is issued, the following problems are reported:

[58169.337512] md/raid:md0: raid level 6 active with 3 out of 4
devices, algorithm 18
[58169.805197] md: reshape of RAID array md0
[58169.805201] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[58169.805203] md: using maximum available idle IO bandwidth (but not
more than 200000 KB/sec) for reshape.
[58169.805208] md: using 128k window, over a total of 3906885632k.
[58359.078753] md/raid:md0: read error corrected (8 sectors at 9990072 on s=
dd1)
[58359.078758] md/raid:md0: read error corrected (8 sectors at 9990080 on s=
dd1)
[58359.078761] md/raid:md0: read error corrected (8 sectors at 9990088 on s=
dd1)
[58359.078763] md/raid:md0: read error corrected (8 sectors at 9990096 on s=
dd1)
[58359.078773] md/raid:md0: read error corrected (8 sectors at 9990104 on s=
dd1)
[58359.078774] md/raid:md0: read error corrected (8 sectors at 9990112 on s=
dd1)
[58359.078775] md/raid:md0: read error corrected (8 sectors at 9990120 on s=
dd1)
[58359.078780] md/raid:md0: read error corrected (8 sectors at 9990128 on s=
dd1)
[58359.078781] md/raid:md0: read error corrected (8 sectors at 9990136 on s=
dd1)
[58359.078791] md/raid:md0: read error corrected (8 sectors at 9990072 on s=
da1)
[58666.606583]       Tainted: G         C    3.16.0-4-amd64 #1
[58666.606721]       Tainted: G         C    3.16.0-4-amd64 #1
[58666.606825]       Tainted: G         C    3.16.0-4-amd64 #1
[58666.606948]       Tainted: G         C    3.16.0-4-amd64 #1
[58666.607039]       Tainted: G         C    3.16.0-4-amd64 #1
[58666.607148] INFO: task md0_reshape:17403 blocked for more than 120 secon=
ds.
[58666.607168]       Tainted: G         C    3.16.0-4-amd64 #1
[58666.607206] md0_reshape     D ffff880216d33748     0 17403      2 0x0000=
0000
[58666.607225]  [<ffffffffa0333cf2>] ? is_mddev_idle+0xd2/0x140 [md_mod]
[58666.607229]  [<ffffffffa0336df4>] ? md_do_sync+0x944/0xd80 [md_mod]
[58666.607233]  [<ffffffffa0333b87>] ? md_thread+0x107/0x120 [md_mod]
[58666.607238]  [<ffffffffa0333a80>] ? md_stop+0x40/0x40 [md_mod]
[58786.578974]       Tainted: G         C    3.16.0-4-amd64 #1
[58786.579191]       Tainted: G         C    3.16.0-4-amd64 #1
[58786.579342]       Tainted: G         C    3.16.0-4-amd64 #1
[58786.579508] INFO: task md0_reshape:17403 blocked for more than 120 secon=
ds.
[58786.579545]       Tainted: G         C    3.16.0-4-amd64 #1
[58786.579612] md0_reshape     D ffff880216d33748     0 17403      2 0x0000=
0000
[58786.579639]  [<ffffffffa0333cf2>] ? is_mddev_idle+0xd2/0x140 [md_mod]
[58786.579644]  [<ffffffffa0336df4>] ? md_do_sync+0x944/0xd80 [md_mod]
[58786.579651]  [<ffffffffa0333b87>] ? md_thread+0x107/0x120 [md_mod]
[58786.579658]  [<ffffffffa0333a80>] ? md_stop+0x40/0x40 [md_mod]

Moreover, I cannot access /data contents. If I issue cd /data
everything seems to be fine, but if I list the contents the command ls
literally hangs returning no result and forcing me to kill ssh session
to the server.

I'm using mdadm - v3.3.2 - 21st August 2014 running on Debian Linux
debnas 3.16.0-4-amd64 #1 SMP Debian 3.16.39-1 (2016-12-30) x86_64
GNU/Linux.

The output from iostat -k 1 2 is the following:

Linux 3.16.0-4-amd64 (debnas)   09/02/2019      _x86_64_        (4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           1.25    0.00   15.25   36.91    0.00   46.59

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               4.42        16.33        37.55    2191851    5038772
sda              60.00     29162.00        78.31 3913364324   10508977
sdc               0.11         0.15         0.00      19751         40
sdd              59.64        40.30     29191.39    5408213 3917308368
sde              59.97     29162.68        77.94 3913455394   10459365
sdf               0.12         0.03        36.79       4157    4936637
md0               1.79         7.45        75.01     999197   10066300
dm-0              1.71         7.44        75.01     998645   10066300

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.50    0.00   25.00   74.50    0.00    0.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda               0.00         0.00         0.00          0          0
sdc               0.00         0.00         0.00          0          0
sdd               0.00         0.00         0.00          0          0
sde               0.00         0.00         0.00          0          0
sdf               0.00         0.00         0.00          0          0
md0               0.00         0.00         0.00          0          0
dm-0              0.00         0.00         0.00          0          0

As dmesg reports read errors on sda and sdd I'm publishing the
complete output of smartctl -a for both drives.

user@debnas:/home/user# smartctl -a /dev/sda
smartctl 6.4 2014-10-07 r4002 [x86_64-linux-3.16.0-4-amd64] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red (AF)
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
Local Time is:    Mon Sep  2 11:27:38 2019 CEST
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
  3 Spin_Up_Time            0x0027   225   163   021    Pre-fail
Always       -       3741
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       66
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       183
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       66
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       20
193 Load_Cycle_Count        0x0032   200   200   000    Old_age
Always       -       52
194 Temperature_Celsius     0x0022   113   105   000    Old_age
Always       -       37
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

user@debnas:/home/user# smartctl -a /dev/sdd
smartctl 6.4 2014-10-07 r4002 [x86_64-linux-3.16.0-4-amd64] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red (AF)
Device Model:     WDC WD40EFRX-68N32N0
Serial Number:    WD-WCC7K2HNS0C0
LU WWN Device Id: 5 0014ee 211682e4b
Firmware Version: 82.00A82
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Mon Sep  2 11:30:55 2019 CEST
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
data collection:                (43920) seconds.
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
recommended polling time:        ( 466) minutes.
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
  1 Raw_Read_Error_Rate     0x002f   100   253   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0027   228   200   021    Pre-fail
Always       -       3583
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       8
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       38
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       8
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       6
193 Load_Cycle_Count        0x0032   200   200   000    Old_age
Always       -       6
194 Temperature_Celsius     0x0022   113   104   000    Old_age
Always       -       37
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

To be honest I don't expect the drives to be failed or damaged as they
are completely new devices: before RAID5 to RAID6 migration the 3-disk
RAID5 array had two disks with current_pending_sector. I've bought one
disk and rebuilt the array with two working disks and one with
current_pending_sector errors. After that, I've purchased two more
disks, rebulit the RAID5 array once more to replace the last failing
drive and performed the migration to RAID... in other words the read
errors may come from the time when the RAID5 array was running with
two disks with current_pending_sector errors. This is just my guess,
but after a single rebuild process when the RAID5 disk was replaced
I've lost a single random 4GB file with the error that It cannot be
read.

It seems that the md0_raid process is consuming all the CPU resources.
After Issuing ps aux | grep md0 I can see the CPU utilization is 99.7%
and the reshape is not consuming CPU at all:

root     17401 99.7  0.0      0     0 ?        R    Sep01 1348:35 [md0_raid=
6]
root     17403  0.0  0.0      0     0 ?        D    Sep01   0:04 [md0_resha=
pe]

These are the last lines of dmesg:

[58786.579309] INFO: task postgres:5070 blocked for more than 120 seconds.
[58786.579342]       Tainted: G         C    3.16.0-4-amd64 #1
[58786.579371] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[58786.579409] postgres        D ffff8801e2860ff8     0  5070   3818 0x0000=
0000
[58786.579412]  ffff8801e2860ba0 0000000000000082 0000000000012f40
ffff8801b4767fd8
[58786.579414]  0000000000012f40 ffff8801e2860ba0 ffff88021fa137f0
ffff88021fdbf578
[58786.579416]  0000000000000002 ffffffff8113eb70 ffff8801b4767ba0
0000000000000000
[58786.579419] Call Trace:
[58786.579421]  [<ffffffff8113eb70>] ? wait_on_page_read+0x60/0x60
[58786.579424]  [<ffffffff815178e9>] ? io_schedule+0x99/0x120
[58786.579426]  [<ffffffff8113eb7a>] ? sleep_on_page+0xa/0x10
[58786.579429]  [<ffffffff81517c6c>] ? __wait_on_bit+0x5c/0x90
[58786.579432]  [<ffffffff8113e976>] ? wait_on_page_bit+0xc6/0xd0
[58786.579434]  [<ffffffff810a95f0>] ? autoremove_wake_function+0x30/0x30
[58786.579437]  [<ffffffff8114dc7a>] ? pagevec_lookup_entries+0x1a/0x30
[58786.579440]  [<ffffffff8114e662>] ? truncate_inode_pages_range+0x302/0x5=
a0
[58786.579449]  [<ffffffffa02efb67>] ? __ext4_journal_stop+0x37/0xa0 [ext4]
[58786.579457]  [<ffffffffa02d075b>] ? ext4_rename+0x11b/0x660 [ext4]
[58786.579461]  [<ffffffff811d1212>] ? __inode_wait_for_writeback+0x72/0xc0
[58786.579464]  [<ffffffff812037f8>] ? __dquot_initialize+0x28/0x1c0
[58786.579467]  [<ffffffff810a95f0>] ? autoremove_wake_function+0x30/0x30
[58786.579475]  [<ffffffffa02c79f7>] ? ext4_evict_inode+0x127/0x4e0 [ext4]
[58786.579478]  [<ffffffff811c475c>] ? evict+0xac/0x170
[58786.579481]  [<ffffffff811c0548>] ? __dentry_kill+0x168/0x1d0
[58786.579484]  [<ffffffff811c064e>] ? dput+0x9e/0x170
[58786.579486]  [<ffffffff811b8588>] ? SYSC_renameat2+0x498/0x530
[58786.579491]  [<ffffffff811719a5>] ? vm_munmap+0x45/0x50
[58786.579494]  [<ffffffff8151adcd>] ? system_call_fast_compare_end+0x10/0x=
15

My questions are the following:

What to do in order to move the reshape process forward?

Do you think the data on the md0 is safe?

How to access the data on md0 if I cannot cd to it?

What are those stack traces in the dmesg output?

Help will be greatly appreciated.

Best regards,

Krzysztof Jak=C3=B3bczyk
