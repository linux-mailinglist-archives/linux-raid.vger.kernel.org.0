Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F81131CF2
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jan 2020 02:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgAGBCo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 20:02:44 -0500
Received: from mail-vs1-f52.google.com ([209.85.217.52]:42241 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAGBCn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 20:02:43 -0500
Received: by mail-vs1-f52.google.com with SMTP id b79so32853591vsd.9
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 17:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKhJ2d248mEULtEdx4MaiIpA+OAaFHjJ6+RXEkpN7Pg=;
        b=YBvefjncucr9jeO9O+5laJZX03PSQldG+1lv0LoGyPO/X8dFpJnXjSDNbWdK+UIgu+
         t75JO84p9uaHaGAS2fUGAzoPbNrgGDYL6FML6LxRy8BxtN8bBdC/emC9gI9fJ4bwVulw
         e1qifctU98swagY/VGizvc6YIUPUHXwNfmb0ayT5xR72juthGeddShbId6pBlFi8nKNg
         c4Wt1+IiF9D9KQplmnaC7TlY0f4en/44zL+6dKWz7pXd0lM5M8XGE4rkbn2nFPBc0ZEB
         ceI10BOGZu0FxH0OAjO2PlxLhb5r8vPuJiBUXuAHbdzDNDo9TQ9Q6moWAGAbmrbrYaNO
         3Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKhJ2d248mEULtEdx4MaiIpA+OAaFHjJ6+RXEkpN7Pg=;
        b=d2cmzSi0sWOpbaoJLULkfYgsfAYpdW4iueu+4YXl2F8HHUHi6GFWBSZibWS/O4TM7N
         Bh2ZvkTrZZ3dF51HaxYaaI2lS01P0l1FRRrx2cuEVXNxKJ/7w/5eyjvyFeECcH2scIOn
         1zOL9NTwA3A2/R6Q7sqNDNMctlqApBW3355uNi4z+ixQo48idFEiHIdsSyyT9hiflfH/
         FCaJOL7NrVeqTnQ3PTI0F0umziBtzBY/pgPTv3pGEpnDPSjxzLFtgl+2i7aDhMlMVU/8
         EARqe9Knldqxs8CjwnV+EPgi/+P5qk6X5DHhELwdvtFJ/lqPh7Wj/sSWLaFCTMZzvOPD
         Tx6Q==
X-Gm-Message-State: APjAAAUKe/CpPBpXcBzUD0hWauJtJeT7YH7NEaDepouPYIUy/+WLJfkm
        cWnKAg+kHYM7u/4OwKNQsZHA67RLdbWeCQ3EkBb8WhHw
X-Google-Smtp-Source: APXvYqwrQJyODgjjxMNnRCYQDJQMTVLYL8/W8LFxku24Qhh6uZehZwbAf0bYicM1F3fAMP9HYx/+jBAjJcLbuXWU9W0=
X-Received: by 2002:a67:f41a:: with SMTP id p26mr50857224vsn.222.1578358959387;
 Mon, 06 Jan 2020 17:02:39 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <20200106062700.GA2563@metamorpher.de>
In-Reply-To: <20200106062700.GA2563@metamorpher.de>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Mon, 6 Jan 2020 19:02:28 -0600
Message-ID: <CALc6PW6jq3NtXvWrSPOt3AN15aAqrX73vK4qY8WFPvg7E8+wsw@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> Don't use smartctl -H for anything, it'll say passed for broken drives,
> which makes it completely useless for any kind of troubleshooting.
>
> You have to check smartctl -a for any pending, offline, reallocated sectors
> and other things. You should have smartd running and also emailing you,
> with automated selftests on top.

That's funny because the man page for smartctl says that -a is
equivalent to '-H -i -A -l error -l selftest' (for SCSI drives).
Nevertheless, I've included the results of -x (even more info than -a)
for four drives of md0 below.

> > Device is:        Not in smartctl database [for details use: -P showall]
>
> I don't have this type of drive, and some drives are simply unknown,
> but see if your smartctl database is up to date anyway.

Updated the database and saw no change - i.e. drives c,d,e,f (8TB) are
not in database but j,k,l,m (4TB) are in.

> Where do you see changed UUIDs?

My fstab shows the old UUID from when the arrays were originally
created. After the failure, both arrays had different UUIDs which I
added to fstab, but that didn't help because the drives wouldn't
assemble on boot. Also, the old UUIDs can be seen in older logfiles. I
don't have any other evidence that the UUIDs changed, except to say
that both arrays always mounted properly upon boot using the old fstab
UUIDs.

> sdd & sde got kicked for some reason.
> Check if you have logfiles for Sat Jan 4 16:56 2020.

I do have log files for that date & time. In both syslog and kern.log
I can see various messages about MD, md0, md1, degraded arrays, disk
failure, super_written gets error=10, Buffer I/O error on dev md0,
logical block 0, lost sync page write, etc. I can't completely
understand all of it. Should I post those logs here?

> For the bad blocks log, check --examine-badblocks

So --examine-badblocks on both sdc1 and sdf1 gave quite long outputs.
I hope that's not a very bad sign.

> To get rid of it, you can use --update=force-no-bbl
> but you should double check smart before that...
> You can also try reading those specific sectors with dd.
>
> If there are no (physical) bad sectors, assemble force
> should work for this array. Otherwise ddrescue instead.

Here's the full smart report for drives c,d,e,f of md0, as well as the
--examine-badblocks for those drives. Please let me know how to
proceed. I feel like this is getting way over my head.

I will deal with md1 in a separate reply.

Thanks,
Bill

cccccccc

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
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
Local Time is:    Mon Jan  6 17:30:41 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
was completed without error.
Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
without error or no self-test has ever
been run.
Total time to complete Offline
data collection: (  101) seconds.
Offline data collection
capabilities: (0x5b) SMART execute Offline immediate.
Auto Offline data collection on/off support.
Suspend Offline collection upon new
command.
Offline surface scan supported.
Self-test supported.
No Conveyance Self-test supported.
Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
power-saving mode.
Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
General Purpose Logging supported.
Short self-test routine
recommended polling time: (   2) minutes.
Extended self-test routine
recommended polling time: (1351) minutes.
SCT capabilities:        (0x003d) SCT Status supported.
SCT Error Recovery Control supported.
SCT Feature Control supported.
SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
  2 Throughput_Performance  P-S---   134   134   054    -    104
  3 Spin_Up_Time            POS---   100   100   024    -    0
  4 Start_Stop_Count        -O--C-   100   100   000    -    9
  5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
  7 Seek_Error_Rate         PO-R--   100   100   067    -    0
  8 Seek_Time_Performance   P-S---   128   128   020    -    18
  9 Power_On_Hours          -O--C-   099   099   000    -    11301
 10 Spin_Retry_Count        PO--C-   100   100   060    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    9
 22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    449
193 Load_Cycle_Count        -O--C-   100   100   000    -    449
194 Temperature_Celsius     -O----   206   206   000    -    29 (Min/Max 25/38)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL,SL  R/O      8  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ Non-Data log
0x15       GPL,SL  R/W      1  Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
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

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
Device State:                        Active (0)
Current Temperature:                    29 Celsius
Power Cycle Min/Max Temperature:     28/31 Celsius
Lifetime    Min/Max Temperature:     25/38 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/60 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (39)

Index    Estimated Time   Temperature Celsius
  40    2020-01-06 15:23    29  **********
 ...    ..(126 skipped).    ..  **********
  39    2020-01-06 17:30    29  **********

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

Device Statistics (GP Log 0x04)
Page  Offset Size        Value Flags Description
0x01  =====  =               =  ===  == General Statistics (rev 2) ==
0x01  0x008  4               9  ---  Lifetime Power-On Resets
0x01  0x018  6     15556017380  ---  Logical Sectors Written
0x01  0x020  6        17376865  ---  Number of Write Commands
0x01  0x028  6    187333471192  ---  Logical Sectors Read
0x01  0x030  6       202998572  ---  Number of Read Commands
0x01  0x038  6     40686339200  ---  Date and Time TimeStamp
0x03  =====  =               =  ===  == Rotating Media Statistics (rev 1) ==
0x03  0x008  4           11223  ---  Spindle Motor Power-on Hours
0x03  0x010  4           11223  ---  Head Flying Hours
0x03  0x018  4             449  ---  Head Load Events
0x03  0x020  4               0  ---  Number of Reallocated Logical Sectors
0x03  0x028  4          236308  ---  Read Recovery Attempts
0x03  0x030  4               0  ---  Number of Mechanical Start Failures
0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
0x04  0x008  4               0  ---  Number of Reported Uncorrectable Errors
0x04  0x010  4               0  ---  Resets Between Cmd Acceptance and
Completion
0x05  =====  =               =  ===  == Temperature Statistics (rev 1) ==
0x05  0x008  1              29  ---  Current Temperature
0x05  0x010  1              28  N--  Average Short Term Temperature
0x05  0x018  1              29  N--  Average Long Term Temperature
0x05  0x020  1              38  ---  Highest Temperature
0x05  0x028  1              25  ---  Lowest Temperature
0x05  0x030  1              37  N--  Highest Average Short Term Temperature
0x05  0x038  1              25  N--  Lowest Average Short Term Temperature
0x05  0x040  1              34  N--  Highest Average Long Term Temperature
0x05  0x048  1              25  N--  Lowest Average Long Term Temperature
0x05  0x050  4               0  ---  Time in Over-Temperature
0x05  0x058  1              60  ---  Specified Maximum Operating Temperature
0x05  0x060  4               0  ---  Time in Under-Temperature
0x05  0x068  1               0  ---  Specified Minimum Operating Temperature
0x06  =====  =               =  ===  == Transport Statistics (rev 1) ==
0x06  0x008  4               8  ---  Number of Hardware Resets
0x06  0x010  4             108  ---  Number of ASR Events
0x06  0x018  4               0  ---  Number of Interface CRC Errors
                                |||_ C monitored condition met
                                ||__ D supports DSN
                                |___ N normalized value

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2            8  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2            9  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS



dddddddd

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
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
Local Time is:    Mon Jan  6 17:30:42 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
was completed without error.
Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
without error or no self-test has ever
been run.
Total time to complete Offline
data collection: (  101) seconds.
Offline data collection
capabilities: (0x5b) SMART execute Offline immediate.
Auto Offline data collection on/off support.
Suspend Offline collection upon new
command.
Offline surface scan supported.
Self-test supported.
No Conveyance Self-test supported.
Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
power-saving mode.
Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
General Purpose Logging supported.
Short self-test routine
recommended polling time: (   2) minutes.
Extended self-test routine
recommended polling time: (1117) minutes.
SCT capabilities:        (0x003d) SCT Status supported.
SCT Error Recovery Control supported.
SCT Feature Control supported.
SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
  2 Throughput_Performance  P-S---   132   132   054    -    112
  3 Spin_Up_Time            POS---   100   100   024    -    0
  4 Start_Stop_Count        -O--C-   100   100   000    -    9
  5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
  7 Seek_Error_Rate         PO-R--   100   100   067    -    0
  8 Seek_Time_Performance   P-S---   128   128   020    -    18
  9 Power_On_Hours          -O--C-   099   099   000    -    11301
 10 Spin_Retry_Count        PO--C-   100   100   060    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    9
 22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    449
193 Load_Cycle_Count        -O--C-   100   100   000    -    449
194 Temperature_Celsius     -O----   200   200   000    -    30 (Min/Max 25/40)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL,SL  R/O      8  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ Non-Data log
0x15       GPL,SL  R/W      1  Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
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

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
Device State:                        Active (0)
Current Temperature:                    30 Celsius
Power Cycle Min/Max Temperature:     29/32 Celsius
Lifetime    Min/Max Temperature:     25/40 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/60 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (88)

Index    Estimated Time   Temperature Celsius
  89    2020-01-06 15:23    30  ***********
 ...    ..(108 skipped).    ..  ***********
  70    2020-01-06 17:12    30  ***********
  71    2020-01-06 17:13    29  **********
 ...    ..( 13 skipped).    ..  **********
  85    2020-01-06 17:27    29  **********
  86    2020-01-06 17:28    30  ***********
  87    2020-01-06 17:29    30  ***********
  88    2020-01-06 17:30    30  ***********

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

Device Statistics (GP Log 0x04)
Page  Offset Size        Value Flags Description
0x01  =====  =               =  ===  == General Statistics (rev 2) ==
0x01  0x008  4               9  ---  Lifetime Power-On Resets
0x01  0x018  6     15584944764  ---  Logical Sectors Written
0x01  0x020  6        17379271  ---  Number of Write Commands
0x01  0x028  6    187088254616  ---  Logical Sectors Read
0x01  0x030  6       207028223  ---  Number of Read Commands
0x01  0x038  6     40686761200  ---  Date and Time TimeStamp
0x03  =====  =               =  ===  == Rotating Media Statistics (rev 1) ==
0x03  0x008  4           11228  ---  Spindle Motor Power-on Hours
0x03  0x010  4           11228  ---  Head Flying Hours
0x03  0x018  4             449  ---  Head Load Events
0x03  0x020  4               0  ---  Number of Reallocated Logical Sectors
0x03  0x028  4          284413  ---  Read Recovery Attempts
0x03  0x030  4               0  ---  Number of Mechanical Start Failures
0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
0x04  0x008  4               0  ---  Number of Reported Uncorrectable Errors
0x04  0x010  4               0  ---  Resets Between Cmd Acceptance and
Completion
0x05  =====  =               =  ===  == Temperature Statistics (rev 1) ==
0x05  0x008  1              30  ---  Current Temperature
0x05  0x010  1              29  N--  Average Short Term Temperature
0x05  0x018  1              29  N--  Average Long Term Temperature
0x05  0x020  1              40  ---  Highest Temperature
0x05  0x028  1              25  ---  Lowest Temperature
0x05  0x030  1              38  N--  Highest Average Short Term Temperature
0x05  0x038  1              25  N--  Lowest Average Short Term Temperature
0x05  0x040  1              36  N--  Highest Average Long Term Temperature
0x05  0x048  1              25  N--  Lowest Average Long Term Temperature
0x05  0x050  4               0  ---  Time in Over-Temperature
0x05  0x058  1              60  ---  Specified Maximum Operating Temperature
0x05  0x060  4               0  ---  Time in Under-Temperature
0x05  0x068  1               0  ---  Specified Minimum Operating Temperature
0x06  =====  =               =  ===  == Transport Statistics (rev 1) ==
0x06  0x008  4              12  ---  Number of Hardware Resets
0x06  0x010  4             107  ---  Number of ASR Events
0x06  0x018  4               0  ---  Number of Interface CRC Errors
                                |||_ C monitored condition met
                                ||__ D supports DSN
                                |___ N normalized value

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           13  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           13  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS



eeeeeeee

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
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
Local Time is:    Mon Jan  6 17:30:42 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
was completed without error.
Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
without error or no self-test has ever
been run.
Total time to complete Offline
data collection: (  101) seconds.
Offline data collection
capabilities: (0x5b) SMART execute Offline immediate.
Auto Offline data collection on/off support.
Suspend Offline collection upon new
command.
Offline surface scan supported.
Self-test supported.
No Conveyance Self-test supported.
Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
power-saving mode.
Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
General Purpose Logging supported.
Short self-test routine
recommended polling time: (   2) minutes.
Extended self-test routine
recommended polling time: (1100) minutes.
SCT capabilities:        (0x003d) SCT Status supported.
SCT Error Recovery Control supported.
SCT Feature Control supported.
SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
  2 Throughput_Performance  P-S---   133   133   054    -    108
  3 Spin_Up_Time            POS---   253   253   024    -    44 (Average 466)
  4 Start_Stop_Count        -O--C-   100   100   000    -    10
  5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
  7 Seek_Error_Rate         PO-R--   100   100   067    -    0
  8 Seek_Time_Performance   P-S---   128   128   020    -    18
  9 Power_On_Hours          -O--C-   099   099   000    -    11301
 10 Spin_Retry_Count        PO--C-   100   100   060    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    10
 22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    449
193 Load_Cycle_Count        -O--C-   100   100   000    -    449
194 Temperature_Celsius     -O----   193   193   000    -    31 (Min/Max 25/41)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL,SL  R/O      8  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ Non-Data log
0x15       GPL,SL  R/W      1  Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
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

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
Device State:                        Active (0)
Current Temperature:                    31 Celsius
Power Cycle Min/Max Temperature:     30/33 Celsius
Lifetime    Min/Max Temperature:     25/41 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/60 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (61)

Index    Estimated Time   Temperature Celsius
  62    2020-01-06 15:23    31  ************
 ...    ..(111 skipped).    ..  ************
  46    2020-01-06 17:15    31  ************
  47    2020-01-06 17:16    30  ***********
 ...    ..(  9 skipped).    ..  ***********
  57    2020-01-06 17:26    30  ***********
  58    2020-01-06 17:27    31  ************
 ...    ..(  2 skipped).    ..  ************
  61    2020-01-06 17:30    31  ************

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

Device Statistics (GP Log 0x04)
Page  Offset Size        Value Flags Description
0x01  =====  =               =  ===  == General Statistics (rev 2) ==
0x01  0x008  4              10  ---  Lifetime Power-On Resets
0x01  0x018  6     15601983488  ---  Logical Sectors Written
0x01  0x020  6        17360369  ---  Number of Write Commands
0x01  0x028  6    187299744874  ---  Logical Sectors Read
0x01  0x030  6       206128300  ---  Number of Read Commands
0x01  0x038  6     40686141550  ---  Date and Time TimeStamp
0x03  =====  =               =  ===  == Rotating Media Statistics (rev 1) ==
0x03  0x008  4           11227  ---  Spindle Motor Power-on Hours
0x03  0x010  4           11227  ---  Head Flying Hours
0x03  0x018  4             449  ---  Head Load Events
0x03  0x020  4               0  ---  Number of Reallocated Logical Sectors
0x03  0x028  4          288466  ---  Read Recovery Attempts
0x03  0x030  4               0  ---  Number of Mechanical Start Failures
0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
0x04  0x008  4               0  ---  Number of Reported Uncorrectable Errors
0x04  0x010  4               0  ---  Resets Between Cmd Acceptance and
Completion
0x05  =====  =               =  ===  == Temperature Statistics (rev 1) ==
0x05  0x008  1              31  ---  Current Temperature
0x05  0x010  1              30  N--  Average Short Term Temperature
0x05  0x018  1              30  N--  Average Long Term Temperature
0x05  0x020  1              41  ---  Highest Temperature
0x05  0x028  1              25  ---  Lowest Temperature
0x05  0x030  1              39  N--  Highest Average Short Term Temperature
0x05  0x038  1              25  N--  Lowest Average Short Term Temperature
0x05  0x040  1              37  N--  Highest Average Long Term Temperature
0x05  0x048  1              25  N--  Lowest Average Long Term Temperature
0x05  0x050  4               0  ---  Time in Over-Temperature
0x05  0x058  1              60  ---  Specified Maximum Operating Temperature
0x05  0x060  4               0  ---  Time in Under-Temperature
0x05  0x068  1               0  ---  Specified Minimum Operating Temperature
0x06  =====  =               =  ===  == Transport Statistics (rev 1) ==
0x06  0x008  4              12  ---  Number of Hardware Resets
0x06  0x010  4             107  ---  Number of ASR Events
0x06  0x018  4               0  ---  Number of Interface CRC Errors
                                |||_ C monitored condition met
                                ||__ D supports DSN
                                |___ N normalized value

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           13  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           13  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS



ffffffff

smartctl 7.0 2018-12-30 r4883 [x86_64-linux-5.3.0-24-generic] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
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
Local Time is:    Mon Jan  6 17:30:42 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
was completed without error.
Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
without error or no self-test has ever
been run.
Total time to complete Offline
data collection: (  101) seconds.
Offline data collection
capabilities: (0x5b) SMART execute Offline immediate.
Auto Offline data collection on/off support.
Suspend Offline collection upon new
command.
Offline surface scan supported.
Self-test supported.
No Conveyance Self-test supported.
Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
power-saving mode.
Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
General Purpose Logging supported.
Short self-test routine
recommended polling time: (   2) minutes.
Extended self-test routine
recommended polling time: (1242) minutes.
SCT capabilities:        (0x003d) SCT Status supported.
SCT Error Recovery Control supported.
SCT Feature Control supported.
SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
  2 Throughput_Performance  P-S---   134   134   054    -    104
  3 Spin_Up_Time            POS---   100   100   024    -    0
  4 Start_Stop_Count        -O--C-   100   100   000    -    9
  5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
  7 Seek_Error_Rate         PO-R--   100   100   067    -    0
  8 Seek_Time_Performance   P-S---   128   128   020    -    18
  9 Power_On_Hours          -O--C-   099   099   000    -    11301
 10 Spin_Retry_Count        PO--C-   100   100   060    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    9
 22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    449
193 Load_Cycle_Count        -O--C-   100   100   000    -    449
194 Temperature_Celsius     -O----   206   206   000    -    29 (Min/Max 25/39)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL,SL  R/O      8  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ Non-Data log
0x15       GPL,SL  R/W      1  Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
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

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
Device State:                        Active (0)
Current Temperature:                    29 Celsius
Power Cycle Min/Max Temperature:     28/32 Celsius
Lifetime    Min/Max Temperature:     25/39 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/60 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (125)

Index    Estimated Time   Temperature Celsius
 126    2020-01-06 15:23    30  ***********
 ...    ..(  5 skipped).    ..  ***********
   4    2020-01-06 15:29    30  ***********
   5    2020-01-06 15:30    29  **********
   6    2020-01-06 15:31    30  ***********
   7    2020-01-06 15:32    29  **********
 ...    ..(116 skipped).    ..  **********
 124    2020-01-06 17:29    29  **********
 125    2020-01-06 17:30    30  ***********

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

Device Statistics (GP Log 0x04)
Page  Offset Size        Value Flags Description
0x01  =====  =               =  ===  == General Statistics (rev 2) ==
0x01  0x008  4               9  ---  Lifetime Power-On Resets
0x01  0x018  6     31435095658  ---  Logical Sectors Written
0x01  0x020  6        32980490  ---  Number of Write Commands
0x01  0x028  6    171086185749  ---  Logical Sectors Read
0x01  0x030  6       188184608  ---  Number of Read Commands
0x01  0x038  6     40686991750  ---  Date and Time TimeStamp
0x03  =====  =               =  ===  == Rotating Media Statistics (rev 1) ==
0x03  0x008  4           11227  ---  Spindle Motor Power-on Hours
0x03  0x010  4           11227  ---  Head Flying Hours
0x03  0x018  4             449  ---  Head Load Events
0x03  0x020  4               0  ---  Number of Reallocated Logical Sectors
0x03  0x028  4          214843  ---  Read Recovery Attempts
0x03  0x030  4               0  ---  Number of Mechanical Start Failures
0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
0x04  0x008  4               0  ---  Number of Reported Uncorrectable Errors
0x04  0x010  4               0  ---  Resets Between Cmd Acceptance and
Completion
0x05  =====  =               =  ===  == Temperature Statistics (rev 1) ==
0x05  0x008  1              29  ---  Current Temperature
0x05  0x010  1              29  N--  Average Short Term Temperature
0x05  0x018  1              29  N--  Average Long Term Temperature
0x05  0x020  1              39  ---  Highest Temperature
0x05  0x028  1              25  ---  Lowest Temperature
0x05  0x030  1              37  N--  Highest Average Short Term Temperature
0x05  0x038  1              25  N--  Lowest Average Short Term Temperature
0x05  0x040  1              34  N--  Highest Average Long Term Temperature
0x05  0x048  1              25  N--  Lowest Average Long Term Temperature
0x05  0x050  4               0  ---  Time in Over-Temperature
0x05  0x058  1              60  ---  Specified Maximum Operating Temperature
0x05  0x060  4               0  ---  Time in Under-Temperature
0x05  0x068  1               0  ---  Specified Minimum Operating Temperature
0x06  =====  =               =  ===  == Transport Statistics (rev 1) ==
0x06  0x008  4              12  ---  Number of Hardware Resets
0x06  0x010  4             108  ---  Number of ASR Events
0x06  0x018  4               0  ---  Number of Interface CRC Errors
                                |||_ C monitored condition met
                                ||__ D supports DSN
                                |___ N normalized value

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           12  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           13  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

--------------------------------------------------------------------------

bill@bill-desk:~$ for x in {c,d,e,f}; do echo "$x$x$x$x$x$x$x$x" ;
echo ; sudo mdadm --examine-badblocks /dev/sd"$x"1 ; echo ; echo ;
done

cccccccc

Bad-blocks on /dev/sdc1:
      87960997351424 for 0 sectors
    1126020031729664 for 32 sectors
                  64 for 0 sectors
   17965487421915171 for 29 sectors
      87961001545728 for 1 sectors
    1126037345816576 for 288 sectors
                 192 for 0 sectors
   16902809433669632 for 0 sectors
      87961005740032 for 2 sectors
    1126037345816576 for 544 sectors
                 192 for 0 sectors
   12826919829504000 for 0 sectors
      87961009934336 for 3 sectors
    1126037345816576 for 800 sectors
                 192 for 0 sectors
   11695247486615552 for 0 sectors
      87961014128640 for 4 sectors
    1126037345816577 for 32 sectors
                 192 for 0 sectors
    4129782853795840 for 0 sectors
      87961018322944 for 5 sectors
    1126037345816577 for 288 sectors
                 192 for 0 sectors
    3011304650440704 for 0 sectors
      87961022517248 for 6 sectors
    1126037345816577 for 544 sectors
                 192 for 0 sectors
    7650144208027648 for 0 sectors
      87961026711552 for 7 sectors
    1126037345816577 for 800 sectors
                 192 for 0 sectors
    8781816550916096 for 0 sectors
      87961030905856 for 8 sectors
    1126037345816578 for 32 sectors
                 192 for 0 sectors
    6030013824499712 for 0 sectors
      87961035100160 for 9 sectors
    1126037345816578 for 288 sectors
                 192 for 0 sectors
    4910985865330688 for 0 sectors
      87961039294464 for 10 sectors
    1126037345816578 for 544 sectors
                 192 for 0 sectors
     261151191465984 for 0 sectors
      87961043488768 for 11 sectors
    1126037345816578 for 800 sectors
                 192 for 0 sectors
    1393373290168320 for 0 sectors
      87961047683072 for 12 sectors
    1126037345816579 for 32 sectors
                 192 for 0 sectors
   10084188074016768 for 0 sectors
      87961051877376 for 13 sectors
    1126037345816579 for 288 sectors
                 192 for 0 sectors
   11203216033185792 for 0 sectors
      87961056071680 for 14 sectors
    1126037345816579 for 544 sectors
                 192 for 0 sectors
   15290100753629184 for 0 sectors
      87961060265984 for 15 sectors
    1126037345816579 for 800 sectors
                 192 for 0 sectors
   14157878654926848 for 0 sectors
      90160020607488 for 0 sectors
    1126020031730176 for 32 sectors
                  64 for 0 sectors
    1767482121519139 for 29 sectors
      90160024801792 for 1 sectors
    1126037345817088 for 288 sectors
                 192 for 0 sectors
    1575617342472192 for 0 sectors
      90160028996096 for 2 sectors
    1126037345817088 for 544 sectors
                 192 for 0 sectors
    5636113783848960 for 0 sectors
      90160033190400 for 3 sectors
    1126037345817088 for 800 sectors
                 192 for 0 sectors
    4530829720027136 for 0 sectors
      90160037384704 for 4 sectors
    1126037345817089 for 32 sectors
                 192 for 0 sectors
   15542713550110720 for 0 sectors
      90160041579008 for 5 sectors
    1126037345817089 for 288 sectors
                 192 for 0 sectors
   14397847067688960 for 0 sectors
      90160045773312 for 6 sectors
    1126037345817089 for 544 sectors
                 192 for 0 sectors
    9774400672890880 for 0 sectors
      90160049967616 for 7 sectors
    1126037345817089 for 800 sectors
                 192 for 0 sectors
   10879684736712704 for 0 sectors
      90160054161920 for 8 sectors
    1126037345817090 for 32 sectors
                 192 for 0 sectors
   12657869916733440 for 0 sectors
      90160058356224 for 9 sectors
    1126037345817090 for 288 sectors
                 192 for 0 sectors
   11512453678497792 for 0 sectors
      90160062550528 for 10 sectors
    1126037345817090 for 544 sectors
                 192 for 0 sectors
   16177681515151360 for 0 sectors
      90160066744832 for 11 sectors
    1126037345817090 for 800 sectors
                 192 for 0 sectors
   17283515334787072 for 0 sectors
      90160070939136 for 12 sectors
    1126037345817091 for 32 sectors
                 192 for 0 sectors
    7396981655732224 for 0 sectors
      90160075133440 for 13 sectors
    1126037345817091 for 288 sectors
                 192 for 0 sectors
    8542397893967872 for 0 sectors
      90160079327744 for 14 sectors
    1126037345817091 for 544 sectors
                 192 for 0 sectors
    4440120010735616 for 0 sectors
      90160083522048 for 15 sectors
    1126037345817091 for 800 sectors
                 192 for 0 sectors
    3334286191099904 for 0 sectors
      92359043863552 for 0 sectors
    1126020031730688 for 32 sectors
                  64 for 0 sectors
    3654244074782755 for 29 sectors
      92359048057856 for 1 sectors
    1126037345817600 for 288 sectors
                 192 for 0 sectors
    4262823760756736 for 0 sectors
      92359052252160 for 2 sectors
    1126037345817600 for 544 sectors
                 192 for 0 sectors
    8648775643955200 for 0 sectors
      92359056446464 for 3 sectors
    1126037345817600 for 800 sectors
                 192 for 0 sectors
    7499511115022336 for 0 sectors
      92359060640768 for 4 sectors
    1126037345817601 for 32 sectors
                 192 for 0 sectors
   17315126294085632 for 0 sectors
      92359064835072 for 5 sectors
    1126037345817601 for 288 sectors
                 192 for 0 sectors
   16214240276774912 for 0 sectors
      92359069029376 for 6 sectors
    1126037345817601 for 544 sectors
                 192 for 0 sectors
   11265338440155136 for 0 sectors
      92359073223680 for 7 sectors
    1126037345817601 for 800 sectors
                 192 for 0 sectors
   12414602969088000 for 0 sectors
      92359077417984 for 8 sectors
    1126037345817602 for 32 sectors
                 192 for 0 sectors
   10771107963469824 for 0 sectors
      92359081612288 for 9 sectors
    1126037345817602 for 288 sectors
                 192 for 0 sectors
    9669672190345216 for 0 sectors
      92359085806592 for 10 sectors
    1126037345817602 for 544 sectors
                 192 for 0 sectors
   14572394538598400 for 0 sectors
      92359090000896 for 11 sectors
    1126037345817602 for 800 sectors
                 192 for 0 sectors
   15722208823345152 for 0 sectors
      92359094195200 for 12 sectors
    1126037345817603 for 32 sectors
                 192 for 0 sectors
    4780143981625344 for 0 sectors
      92359098389504 for 13 sectors
    1126037345817603 for 288 sectors
                 192 for 0 sectors
    5881579754749952 for 0 sectors
      92359102583808 for 14 sectors
    1126037345817603 for 544 sectors
                 192 for 0 sectors
    1541807359918080 for 0 sectors
      92359106778112 for 15 sectors
    1126037345817603 for 800 sectors
                 192 for 0 sectors
     391993075171328 for 0 sectors
      94558067119616 for 0 sectors
    1126020031731200 for 32 sectors
                  64 for 0 sectors
   15040786492031011 for 29 sectors
      94558071313920 for 1 sectors
    1126037345818112 for 288 sectors
                 192 for 0 sectors
   15394279480360960 for 0 sectors
      94558075508224 for 2 sectors
    1126037345818112 for 544 sectors
                 192 for 0 sectors
   11028118806462464 for 0 sectors
      94558079702528 for 3 sectors
    1126037345818112 for 800 sectors
                 192 for 0 sectors
    9905242556596224 for 0 sectors
      94558083896832 for 4 sectors
    1126037345818113 for 32 sectors
                 192 for 0 sectors
    1143509272756224 for 0 sectors
      94558088091136 for 5 sectors
    1126037345818113 for 288 sectors
                 192 for 0 sectors
      16234976378880 for 0 sectors
      94558092285440 for 6 sectors
    1126037345818113 for 544 sectors
                 192 for 0 sectors
    4945345603698688 for 0 sectors
      94558096479744 for 7 sectors
    1126037345818113 for 800 sectors
                 192 for 0 sectors
    6068221853564928 for 0 sectors
      94558100674048 for 8 sectors
    1126037345818114 for 32 sectors
                 192 for 0 sectors
    8954714754383872 for 0 sectors
      94558104868352 for 9 sectors
    1126037345818114 for 288 sectors
                 192 for 0 sectors
    7826890702192640 for 0 sectors
      94558109062656 for 10 sectors
    1126037345818114 for 544 sectors
                 192 for 0 sectors
    2904377144639488 for 0 sectors
      94558113256960 for 11 sectors
    1126037345818114 for 800 sectors
                 192 for 0 sectors
    4027803150319616 for 0 sectors
      94558117451264 for 12 sectors
    1126037345818115 for 32 sectors
                 192 for 0 sectors
   11663086771503104 for 0 sectors
      94558121645568 for 13 sectors
    1126037345818115 for 288 sectors
                 192 for 0 sectors
   12790910823694336 for 0 sectors
      94558125839872 for 14 sectors
    1126037345818115 for 544 sectors
                 192 for 0 sectors
   17150474427826176 for 0 sectors
      94558130034176 for 15 sectors
    1126037345818115 for 800 sectors
                 192 for 0 sectors
   16027048422146048 for 0 sectors
      96757090375680 for 0 sectors
    1126020031731712 for 32 sectors
                  64 for 0 sectors
    7181477376688163 for 29 sectors
      96757094569984 for 1 sectors
    1126037345818624 for 288 sectors
                 192 for 0 sectors
    7420621155729408 for 0 sectors
      96757098764288 for 2 sectors
    1126037345818624 for 544 sectors
                 192 for 0 sectors
    3309547179474944 for 0 sectors
      96757102958592 for 3 sectors
    1126037345818624 for 800 sectors
                 192 for 0 sectors
    4464859022360576 for 0 sectors
      96757107152896 for 4 sectors
    1126037345818625 for 32 sectors
                 192 for 0 sectors
   11536093178494976 for 0 sectors
      96757111347200 for 5 sectors
    1126037345818625 for 288 sectors
                 192 for 0 sectors
   12634230416736256 for 0 sectors
      96757115541504 for 6 sectors
    1126037345818625 for 544 sectors
                 192 for 0 sectors
   17308254346412032 for 0 sectors
      96757119735808 for 7 sectors
    1126037345818625 for 800 sectors
                 192 for 0 sectors
   16152942503526400 for 0 sectors
      96757123930112 for 8 sectors
    1126037345818626 for 32 sectors
                 192 for 0 sectors
   14421486567686144 for 0 sectors
      96757128124416 for 9 sectors
    1126037345818626 for 288 sectors
                 192 for 0 sectors
   15519074050113536 for 0 sectors
      96757132318720 for 10 sectors
    1126037345818626 for 544 sectors
                 192 for 0 sectors
   10904423748337664 for 0 sectors
      96757136513024 for 11 sectors
    1126037345818626 for 800 sectors
                 192 for 0 sectors
    9749661661265920 for 0 sectors
      96757140707328 for 12 sectors
    1126037345818627 for 32 sectors
                 192 for 0 sectors
    1551977842475008 for 0 sectors
      96757144901632 for 13 sectors
    1126037345818627 for 288 sectors
                 192 for 0 sectors
     454390360047616 for 0 sectors
      96757149095936 for 14 sectors
    1126037345818627 for 544 sectors
                 192 for 0 sectors
    4506090708402176 for 0 sectors
      96757153290240 for 15 sectors
    1126037345818627 for 800 sectors
                 192 for 0 sectors
    5660852795473920 for 0 sectors
      98956113631744 for 0 sectors
    1126020031732224 for 32 sectors
                  64 for 0 sectors
    9033054957862947 for 29 sectors
      98956117826048 for 1 sectors
    1126037345819136 for 288 sectors
                 192 for 0 sectors
   10072643201925120 for 0 sectors
      98956122020352 for 2 sectors
    1126037345819136 for 544 sectors
                 192 for 0 sectors
   14168324015390720 for 0 sectors
      98956126214656 for 3 sectors
    1126037345819136 for 800 sectors
                 192 for 0 sectors
   15279655393165312 for 0 sectors
      98956130408960 for 4 sectors
    1126037345819137 for 32 sectors
                 192 for 0 sectors
    4899440993239040 for 0 sectors
      98956134603264 for 5 sectors
    1126037345819137 for 288 sectors
                 192 for 0 sectors
    6041558696591360 for 0 sectors
      98956138797568 for 6 sectors
    1126037345819137 for 544 sectors
                 192 for 0 sectors
    1382927929704448 for 0 sectors
      98956142991872 for 7 sectors
    1126037345819137 for 800 sectors
                 192 for 0 sectors
     271596551929856 for 0 sectors
      98956147186176 for 8 sectors
    1126037345819138 for 32 sectors
                 192 for 0 sectors
    2999759778349056 for 0 sectors
      98956151380480 for 9 sectors
    1126033046657538 for 288 sectors
                 192 for 0 sectors
   10870064009969664 for 0 sectors
      98956155574784 for 10 sectors
    1126037345819138 for 544 sectors
                 192 for 0 sectors
    8771371190452224 for 0 sectors
      98956159769088 for 11 sectors
    1126037345819138 for 800 sectors
                 192 for 0 sectors
    7660589568491520 for 0 sectors
      98956163963392 for 12 sectors
    1126037345819139 for 32 sectors
                 192 for 0 sectors
   16914354305761280 for 0 sectors
      98956168157696 for 13 sectors
    1126037345819139 for 288 sectors
                 192 for 0 sectors
   15772786358222848 for 0 sectors
      98956172352000 for 14 sectors
    1126037345819139 for 544 sectors
                 192 for 0 sectors
   11705692847079424 for 0 sectors
      98956176546304 for 15 sectors
    1126037345819139 for 800 sectors
                 192 for 0 sectors
   12816474469040128 for 0 sectors
     101155136887808 for 0 sectors
    1126020031732736 for 32 sectors
                  64 for 0 sectors
   12010532445880355 for 29 sectors
     101155141082112 for 1 sectors
    1126037345819648 for 288 sectors
                 192 for 0 sectors
   11669134085455872 for 0 sectors
     101155145276416 for 2 sectors
    1126037345819648 for 544 sectors
                 192 for 0 sectors
   16019901596565504 for 0 sectors
     101155149470720 for 3 sectors
    1126037345819648 for 800 sectors
                 192 for 0 sectors
   17157621253406720 for 0 sectors
     101155153665024 for 4 sectors
    1126037345819649 for 32 sectors
                 192 for 0 sectors
    7832938016145408 for 0 sectors
     101155157859328 for 5 sectors
    1126037345819649 for 288 sectors
                 192 for 0 sectors
    8948667440431104 for 0 sectors
     101155162053632 for 6 sectors
    1126037345819649 for 544 sectors
                 192 for 0 sectors
    4034949975900160 for 0 sectors
     101155166247936 for 7 sectors
    1126037345819649 for 800 sectors
                 192 for 0 sectors
    2897230319058944 for 0 sectors
     101155170442240 for 8 sectors
    1126037345819650 for 32 sectors
                 192 for 0 sectors
      22282290331648 for 0 sectors
     101155174636544 for 9 sectors
    1126037345819650 for 288 sectors
                 192 for 0 sectors
    1137461958803456 for 0 sectors
     101155178830848 for 10 sectors
    1126037345819650 for 544 sectors
                 192 for 0 sectors
    6075368679145472 for 0 sectors
     101155183025152 for 11 sectors
    1126037345819650 for 800 sectors
                 192 for 0 sectors
    4938198778118144 for 0 sectors
     101155187219456 for 12 sectors
    1126037345819651 for 32 sectors
                 192 for 0 sectors
   15388232166408192 for 0 sectors
     101155191413760 for 13 sectors
    1126037345819651 for 288 sectors
                 192 for 0 sectors
   14273052497936384 for 0 sectors
     101155195608064 for 14 sectors
    1126037345819651 for 544 sectors
                 192 for 0 sectors
    9898095731015680 for 0 sectors
     101155199802368 for 15 sectors
    1126037345819651 for 800 sectors
                 192 for 0 sectors
   11035265632043008 for 0 sectors
     103354160143872 for 0 sectors
    1126020031733248 for 32 sectors
                  64 for 0 sectors
    5417860725735459 for 29 sectors
     103354164338176 for 1 sectors
    1126037345820160 for 288 sectors
                 192 for 0 sectors
    4751006923489280 for 0 sectors
     103354168532480 for 2 sectors
    1126037345820160 for 544 sectors
                 192 for 0 sectors
     420030621679616 for 0 sectors
     103354172726784 for 3 sectors
    1126037345820160 for 800 sectors
                 192 for 0 sectors
    1513769813409792 for 0 sectors
     103354176921088 for 4 sectors
    1126037345820161 for 32 sectors
                 192 for 0 sectors
    9640535132209152 for 0 sectors
     103354181115392 for 5 sectors
    1126037345820161 for 288 sectors
                 192 for 0 sectors
   10800245021605888 for 0 sectors
     103354185309696 for 6 sectors
    1126037345820161 for 544 sectors
                 192 for 0 sectors
   15694171276836864 for 0 sectors
     103354189504000 for 7 sectors
    1126037345820161 for 800 sectors
                 192 for 0 sectors
   14600432085106688 for 0 sectors
     103354193698304 for 8 sectors
    1126037345820162 for 32 sectors
                 192 for 0 sectors
   16185103218638848 for 0 sectors
     103354197892608 for 9 sectors
    1126037345820162 for 288 sectors
                 192 for 0 sectors
   17344263352221696 for 0 sectors
     103354202086912 for 10 sectors
    1126037345820162 for 544 sectors
                 192 for 0 sectors
   12386565422579712 for 0 sectors
     103354206281216 for 11 sectors
    1126037345820162 for 800 sectors
                 192 for 0 sectors
   11293375986663424 for 0 sectors
     103354210475520 for 12 sectors
    1126037345820163 for 32 sectors
                 192 for 0 sectors
    4291960818892800 for 0 sectors
     103354214669824 for 13 sectors
    1126037345820163 for 288 sectors
                 192 for 0 sectors
    3132800685309952 for 0 sectors
     103354218864128 for 14 sectors
    1126037345820163 for 544 sectors
                 192 for 0 sectors
    7527548661530624 for 0 sectors
     103354223058432 for 15 sectors
    1126037345820163 for 800 sectors
                 192 for 0 sectors
    8620738097446912 for 0 sectors


dddddddd

Bad-blocks list is empty in /dev/sdd1


eeeeeeee

Bad-blocks list is empty in /dev/sde1


ffffffff

Bad-blocks on /dev/sdf1:
      87960997351424 for 0 sectors
    1126020031729664 for 32 sectors
                  64 for 0 sectors
    4093773847986206 for 99 sectors
      87961001545728 for 1 sectors
    1126037345816576 for 288 sectors
                 192 for 0 sectors
    6470917987237888 for 0 sectors
      87961005740032 for 2 sectors
    1126037345816576 for 544 sectors
                 192 for 0 sectors
    2078369034272768 for 0 sectors
      87961009934336 for 3 sectors
    1126037345816576 for 800 sectors
                 192 for 0 sectors
     981331307659264 for 0 sectors
      87961014128640 for 4 sectors
    1126037345816577 for 32 sectors
                 192 for 0 sectors
   10234546289115136 for 0 sectors
      87961018322944 for 5 sectors
    1126037345816577 for 288 sectors
                 192 for 0 sectors
    9080333957857280 for 0 sectors
      87961022517248 for 6 sectors
    1126037345816577 for 544 sectors
                 192 for 0 sectors
   14035832864243712 for 0 sectors
      87961026711552 for 7 sectors
    1126037345816577 for 800 sectors
                 192 for 0 sectors
   15132870590857216 for 0 sectors
      87961030905856 for 8 sectors
    1126037345816578 for 32 sectors
                 192 for 0 sectors
   17904464526573568 for 0 sectors
      87961035100160 for 9 sectors
    1126037345816578 for 288 sectors
                 192 for 0 sectors
   16750801951129600 for 0 sectors
      87961039294464 for 10 sectors
    1126037345816578 for 544 sectors
                 192 for 0 sectors
   11854676672643072 for 0 sectors
      87961043488768 for 11 sectors
    1126037345816578 for 800 sectors
                 192 for 0 sectors
   12951164643442688 for 0 sectors
      87961047683072 for 12 sectors
    1126037345816579 for 32 sectors
                 192 for 0 sectors
    2572599510958080 for 0 sectors
      87961051877376 for 13 sectors
    1126037345816579 for 288 sectors
                 192 for 0 sectors
    3726262086402048 for 0 sectors
      87961056071680 for 14 sectors
    1126037345816579 for 544 sectors
                 192 for 0 sectors
    8059437411467264 for 0 sectors
      87961060265984 for 15 sectors
    1126037345816579 for 800 sectors
                 192 for 0 sectors
    6962949440667648 for 0 sectors
      90160020607488 for 0 sectors
    1126020031730176 for 32 sectors
                  64 for 0 sectors
   15515500637323294 for 99 sectors
      90160024801792 for 1 sectors
    1126037345817088 for 288 sectors
                 192 for 0 sectors
   13345064684093440 for 0 sectors
      90160028996096 for 2 sectors
    1126037345817088 for 544 sectors
                 192 for 0 sectors
   17722220474269696 for 0 sectors
      90160033190400 for 3 sectors
    1126037345817088 for 800 sectors
                 192 for 0 sectors
   16581202282545152 for 0 sectors
      90160037384704 for 4 sectors
    1126037345817089 for 32 sectors
                 192 for 0 sectors
    8382968707940352 for 0 sectors
      90160041579008 for 5 sectors
    1126037345817089 for 288 sectors
                 192 for 0 sectors
    7272736841793536 for 0 sectors
      90160045773312 for 6 sectors
    1126037345817089 for 544 sectors
                 192 for 0 sectors
    2332631098195968 for 0 sectors
      90160049967616 for 7 sectors
    1126037345817089 for 800 sectors
                 192 for 0 sectors
    3473649289920512 for 0 sectors
      90160054161920 for 8 sectors
    1126037345817090 for 32 sectors
                 192 for 0 sectors
    1697663133155328 for 0 sectors
      90160058356224 for 9 sectors
    1126037345817090 for 288 sectors
                 192 for 0 sectors
     587981022822400 for 0 sectors
      90160062550528 for 10 sectors
    1126037345817090 for 544 sectors
                 192 for 0 sectors
    5499499464097792 for 0 sectors
      90160066744832 for 11 sectors
    1126037345817090 for 800 sectors
                 192 for 0 sectors
    6639967900008448 for 0 sectors
      90160070939136 for 12 sectors
    1126037345817091 for 32 sectors
                 192 for 0 sectors
   13712851323584512 for 0 sectors
      90160075133440 for 13 sectors
    1126037345817091 for 288 sectors
                 192 for 0 sectors
   14822533433917440 for 0 sectors
      90160079327744 for 14 sectors
    1126037345817091 for 544 sectors
                 192 for 0 sectors
   10473964946063360 for 0 sectors
      90160083522048 for 15 sectors
    1126037345817091 for 800 sectors
                 192 for 0 sectors
    9333496510152704 for 0 sectors
      92359043863552 for 0 sectors
    1126020031730688 for 32 sectors
                  64 for 0 sectors
   17349486032453662 for 99 sectors
      92359048057856 for 1 sectors
    1126037345817600 for 288 sectors
                 192 for 0 sectors
   10649062172786688 for 0 sectors
      92359052252160 for 2 sectors
    1126037345817600 for 544 sectors
                 192 for 0 sectors
   14718354707185664 for 0 sectors
      92359056446464 for 3 sectors
    1126037345817600 for 800 sectors
                 192 for 0 sectors
   13603724794527744 for 0 sectors
      92359060640768 for 4 sectors
    1126037345817601 for 32 sectors
                 192 for 0 sectors
    6601759870943232 for 0 sectors
      92359064835072 for 5 sectors
    1126037345817601 for 288 sectors
                 192 for 0 sectors
    5465139725729792 for 0 sectors
      92359069029376 for 6 sectors
    1126037345817601 for 544 sectors
                 192 for 0 sectors
     832897237909504 for 0 sectors
      92359073223680 for 7 sectors
    1126037345817601 for 800 sectors
                 192 for 0 sectors
    1947527150567424 for 0 sectors
      92359077417984 for 8 sectors
    1126037345817602 for 32 sectors
                 192 for 0 sectors
    3575628993396736 for 0 sectors
      92359081612288 for 9 sectors
    1126037345817602 for 288 sectors
                 192 for 0 sectors
    2439558603997184 for 0 sectors
      92359085806592 for 10 sectors
    1126037345817602 for 544 sectors
                 192 for 0 sectors
    7095990347628544 for 0 sectors
      92359090000896 for 11 sectors
    1126037345817602 for 800 sectors
                 192 for 0 sectors
    8210070504472576 for 0 sectors
      92359094195200 for 12 sectors
    1126037345817603 for 32 sectors
                 192 for 0 sectors
   16338485090713600 for 0 sectors
      92359098389504 for 13 sectors
    1126037345817603 for 288 sectors
                 192 for 0 sectors
   17474555480113152 for 0 sectors
      92359102583808 for 14 sectors
    1126037345817603 for 544 sectors
                 192 for 0 sectors
   13381073689903104 for 0 sectors
      92359106778112 for 15 sectors
    1126037345817603 for 800 sectors
                 192 for 0 sectors
   12266993533059072 for 0 sectors
      94558067119616 for 0 sectors
    1126020031731200 for 32 sectors
                  64 for 0 sectors
    1186665104146462 for 99 sectors
      94558071313920 for 1 sectors
    1126037345818112 for 288 sectors
                 192 for 0 sectors
    7953059661479936 for 0 sectors
      94558075508224 for 2 sectors
    1126037345818112 for 544 sectors
                 192 for 0 sectors
    3903558336380928 for 0 sectors
      94558079702528 for 3 sectors
    1126037345818112 for 800 sectors
                 192 for 0 sectors
    2744947958611968 for 0 sectors
      94558083896832 for 4 sectors
    1126037345818113 for 32 sectors
                 192 for 0 sectors
   13194431591088128 for 0 sectors
      94558088091136 for 5 sectors
    1126037345818113 for 288 sectors
                 192 for 0 sectors
   12101791910985728 for 0 sectors
      94558092285440 for 6 sectors
    1126037345818113 for 544 sectors
                 192 for 0 sectors
   16714243189506048 for 0 sectors
      94558096479744 for 7 sectors
    1126037345818113 for 800 sectors
                 192 for 0 sectors
   17872853567275008 for 0 sectors
      94558100674048 for 8 sectors
    1126037345818114 for 32 sectors
                 192 for 0 sectors
   14953375317622784 for 0 sectors
      94558104868352 for 9 sectors
    1126037345818114 for 288 sectors
                 192 for 0 sectors
   13861285393334272 for 0 sectors
      94558109062656 for 10 sectors
    1126037345818114 for 544 sectors
                 192 for 0 sectors
    9185062440402944 for 0 sectors
      94558113256960 for 11 sectors
    1126037345818114 for 800 sectors
                 192 for 0 sectors
   10343123062358016 for 0 sectors
      94558117451264 for 12 sectors
    1126037345818115 for 32 sectors
                 192 for 0 sectors
    1020089092538368 for 0 sectors
      94558121645568 for 13 sectors
    1126037345818115 for 288 sectors
                 192 for 0 sectors
    2112179016826880 for 0 sectors
      94558125839872 for 14 sectors
    1126037345818115 for 544 sectors
                 192 for 0 sectors
    6225452016336896 for 0 sectors
      94558130034176 for 15 sectors
    1126037345818115 for 800 sectors
                 192 for 0 sectors
    5067391394381824 for 0 sectors
      96757090375680 for 0 sectors
    1126020031731712 for 32 sectors
                  64 for 0 sectors
   11500084172685342 for 99 sectors
      96757094569984 for 1 sectors
    1126037345818624 for 288 sectors
                 192 for 0 sectors
   13701306451492864 for 0 sectors
      96757098764288 for 2 sectors
    1126037345818624 for 544 sectors
                 192 for 0 sectors
    9343941870616576 for 0 sectors
      96757102958592 for 3 sectors
    1126037345818624 for 800 sectors
                 192 for 0 sectors
   10463519585599488 for 0 sectors
      96757107152896 for 4 sectors
    1126037345818625 for 32 sectors
                 192 for 0 sectors
     576436150730752 for 0 sectors
      96757111347200 for 5 sectors
    1126037345818625 for 288 sectors
                 192 for 0 sectors
    1709208005246976 for 0 sectors
      96757115541504 for 6 sectors
    1126037345818625 for 544 sectors
                 192 for 0 sectors
    6629522539544576 for 0 sectors
      96757119735808 for 7 sectors
    1126037345818625 for 800 sectors
                 192 for 0 sectors
    5509944824561664 for 0 sectors
      96757123930112 for 8 sectors
    1126037345818626 for 32 sectors
                 192 for 0 sectors
    7261191969701888 for 0 sectors
      96757128124416 for 9 sectors
    1126037345818626 for 288 sectors
                 192 for 0 sectors
    8394513580032000 for 0 sectors
      96757132318720 for 10 sectors
    1126037345818626 for 544 sectors
                 192 for 0 sectors
    3463203929456640 for 0 sectors
      96757136513024 for 11 sectors
    1126037345818626 for 800 sectors
                 192 for 0 sectors
    2343076458659840 for 0 sectors
      96757140707328 for 12 sectors
    1126037345818627 for 32 sectors
                 192 for 0 sectors
   13356609556185088 for 0 sectors
      96757144901632 for 13 sectors
    1126037345818627 for 288 sectors
                 192 for 0 sectors
   12223287945854976 for 0 sectors
      96757149095936 for 14 sectors
    1126037345818627 for 544 sectors
                 192 for 0 sectors
   16591647643009024 for 0 sectors
      96757153290240 for 15 sectors
    1126037345818627 for 800 sectors
                 192 for 0 sectors
   17711775113805824 for 0 sectors
      98956113631744 for 0 sectors
    1126020031732224 for 32 sectors
                  64 for 0 sectors
    4872228080451614 for 99 sectors
      98956117826048 for 1 sectors
    1126037345819136 for 288 sectors
                 192 for 0 sectors
    2596239010955264 for 0 sectors
      98956122020352 for 2 sectors
    1126037345819136 for 544 sectors
                 192 for 0 sectors
    6938210429042688 for 0 sectors
      98956126214656 for 3 sectors
    1126037345819136 for 800 sectors
                 192 for 0 sectors
    8084176423092224 for 0 sectors
      98956130408960 for 4 sectors
    1126037345819137 for 32 sectors
                 192 for 0 sectors
   16774441451126784 for 0 sectors
      98956134603264 for 5 sectors
    1126037345819137 for 288 sectors
                 192 for 0 sectors
   17880825026576384 for 0 sectors
      98956138797568 for 6 sectors
    1126037345819137 for 544 sectors
                 192 for 0 sectors
   12975903655067648 for 0 sectors
      98956142991872 for 7 sectors
    1126037345819137 for 800 sectors
                 192 for 0 sectors
   11829937661018112 for 0 sectors
      98956147186176 for 8 sectors
    1126037345819138 for 32 sectors
                 192 for 0 sectors
    9103973457854464 for 0 sectors
      98956151380480 for 9 sectors
    1126033046657538 for 288 sectors
                 192 for 0 sectors
    3498663179452416 for 0 sectors
      98956155574784 for 10 sectors
    1126037345819138 for 544 sectors
                 192 for 0 sectors
   15157609602482176 for 0 sectors
      98956159769088 for 11 sectors
    1126037345819138 for 800 sectors
                 192 for 0 sectors
   14011093852618752 for 0 sectors
      98956163963392 for 12 sectors
    1126037345819139 for 32 sectors
                 192 for 0 sectors
    6447278487240704 for 0 sectors
      98956168157696 for 13 sectors
    1126037345819139 for 288 sectors
                 192 for 0 sectors
    5340345155977216 for 0 sectors
      98956172352000 for 14 sectors
    1126037345819139 for 544 sectors
                 192 for 0 sectors
     956592296034304 for 0 sectors
      98956176546304 for 15 sectors
    1126037345819139 for 800 sectors
                 192 for 0 sectors
    2103108045897728 for 0 sectors
     101155136887808 for 0 sectors
    1126020031732736 for 32 sectors
                  64 for 0 sectors
    7867297754513438 for 99 sectors
     101155141082112 for 1 sectors
    1126037345819648 for 288 sectors
                 192 for 0 sectors
     990952034402304 for 0 sectors
     101155145276416 for 2 sectors
    1126037345819648 for 544 sectors
                 192 for 0 sectors
    5095428940890112 for 0 sectors
     101155149470720 for 3 sectors
    1126037345819648 for 800 sectors
                 192 for 0 sectors
    6197414469828608 for 0 sectors
     101155153665024 for 4 sectors
    1126037345819649 for 32 sectors
                 192 for 0 sectors
   13832148335198208 for 0 sectors
     101155157859328 for 5 sectors
    1126037345819649 for 288 sectors
                 192 for 0 sectors
   14982512375758848 for 0 sectors
     101155162053632 for 6 sectors
    1126037345819649 for 544 sectors
                 192 for 0 sectors
   10315085515849728 for 0 sectors
     101155166247936 for 7 sectors
    1126037345819649 for 800 sectors
                 192 for 0 sectors
    9213099986911232 for 0 sectors
     101155170442240 for 8 sectors
    1126037345819650 for 32 sectors
                 192 for 0 sectors
   12072654852849664 for 0 sectors
     101155174636544 for 9 sectors
    1126037345819650 for 288 sectors
                 192 for 0 sectors
   13223568649224192 for 0 sectors
     101155178830848 for 10 sectors
    1126037345819650 for 544 sectors
                 192 for 0 sectors
   17844816020766720 for 0 sectors
     101155183025152 for 11 sectors
    1126037345819650 for 800 sectors
                 192 for 0 sectors
   16742280736014336 for 0 sectors
     101155187219456 for 12 sectors
    1126037345819651 for 32 sectors
                 192 for 0 sectors
    7982196719616000 for 0 sectors
     101155191413760 for 13 sectors
    1126037345819651 for 288 sectors
                 192 for 0 sectors
    6831282923241472 for 0 sectors
     101155195608064 for 14 sectors
    1126037345819651 for 544 sectors
                 192 for 0 sectors
    2772985505120256 for 0 sectors
     101155199802368 for 15 sectors
    1126037345819651 for 800 sectors
                 192 for 0 sectors
    3875520789872640 for 0 sectors
     103354160143872 for 0 sectors
    1126020031733248 for 32 sectors
                  64 for 0 sectors
    9683690963599390 for 99 sectors
     103354164338176 for 1 sectors
    1126037345820160 for 288 sectors
                 192 for 0 sectors
   16344532404666368 for 0 sectors
     103354168532480 for 2 sectors
    1126037345820160 for 544 sectors
                 192 for 0 sectors
   12259846707478528 for 0 sectors
     103354172726784 for 3 sectors
    1126037345820160 for 800 sectors
                 192 for 0 sectors
   13388220515483648 for 0 sectors
     103354176921088 for 4 sectors
    1126037345820161 for 32 sectors
                 192 for 0 sectors
    2445605917949952 for 0 sectors
     103354181115392 for 5 sectors
    1126037345820161 for 288 sectors
                 192 for 0 sectors
    3569581679443968 for 0 sectors
     103354185309696 for 6 sectors
    1126037345820161 for 544 sectors
                 192 for 0 sectors
    8217217330053120 for 0 sectors
     103354189504000 for 7 sectors
    1126037345820161 for 800 sectors
                 192 for 0 sectors
    7088843522048000 for 0 sectors
     103354193698304 for 8 sectors
    1126037345820162 for 32 sectors
                 192 for 0 sectors
    5471187039682560 for 0 sectors
     103354197892608 for 9 sectors
    1126037345820162 for 288 sectors
                 192 for 0 sectors
    6595712556990464 for 0 sectors
     103354202086912 for 10 sectors
    1126037345820162 for 544 sectors
                 192 for 0 sectors
    1954673976147968 for 0 sectors
     103354206281216 for 11 sectors
    1126037345820162 for 800 sectors
                 192 for 0 sectors
     825750412328960 for 0 sectors
     103354210475520 for 12 sectors
    1126037345820163 for 32 sectors
                 192 for 0 sectors
   10643014858833920 for 0 sectors
     103354214669824 for 13 sectors
    1126037345820163 for 288 sectors
                 192 for 0 sectors
    9518489341526016 for 0 sectors
     103354218864128 for 14 sectors
    1126037345820163 for 544 sectors
                 192 for 0 sectors
   13596577968947200 for 0 sectors
     103354223058432 for 15 sectors
    1126037345820163 for 800 sectors
                 192 for 0 sectors
   14725501532766208 for 0 sectors
