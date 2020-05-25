Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90271E13F7
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgEYSSW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSSV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 14:18:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D67C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 11:18:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so1166907wro.1
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=mUJAscHU7wvuSWsBi0lsM/RM2sAeVU+oeaSLT/PVbc4=;
        b=npXM4kL03zVVRtzDm5fmMuGjErVTR3fvYsNLARWlsiZ52xrWF+vPNYG/73C5I0smsF
         YUzwJYw8qC6qLqkNn8LfCW7e3vGk+DRE6aMSq3PTHBBNoYt0Z7k0w4DXgILRo4VD4NQT
         rnTSQVZ3Mf9VxeqcRCBiVaxw0UkL5VQUWjOWiRdqEJV+BO387sK+AlZO32bt1lN9xEAU
         aun9aTQ1sVOGxImrX36QQ/7C65vIYd5DAYy80uNCYqgNUtdpo7m4s9eXM8umxqDTiGgi
         G38Sli0aucmv3YpfD05G4n+msR9sA9zsYiXV1mSf7rz7qeSfO4B3dEm0wyk6d5Ve2w0c
         VX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=mUJAscHU7wvuSWsBi0lsM/RM2sAeVU+oeaSLT/PVbc4=;
        b=gY1YEq8rOJEQ2FhM2fiLzdO9DgdBtK6DjBE8LUwBBpTdausl5qXRjB5YCb48rEJF6+
         gCXcTFq6+uygX4e/DRdBnZR/YKUl9tpP7JS0SXNOAJGPg3g1g7jOu4M5l1pUpZU4638B
         lLODBL2KBBuu8OG4n2rlj6h1RdbfTGxO5c7TgYOoNoSa3ZSXuep38/qcZXlCSCtQtZhy
         HuVUPoWl3G7hV3cI53moyWv5z5Dy1sbj1cHd9iNnvnaclOVsKLJpa0CHi3bw28NPhOIs
         hbvth0Ju/XAilj8PzG9P2JxXGNsPy0CiDDK8dQFjcq9tBhjiGJdNrsaEmOSAf+eG3HDX
         RKCw==
X-Gm-Message-State: AOAM532KUJip2e7P2DNAU/ZdTAYSTHclWXYMpYC3dqMtxpej+XAGsWoE
        aI9bGVlD7HyIcmPSU9Ko/oXWmT5QoAc=
X-Google-Smtp-Source: ABdhPJwiZHP8Wl71S6rZh1veKdUKK3Bd9qvMtTtrAhPOWbJe/4OvnMJq6/7b6lLMrnKd4sBqN9wNZg==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr16978133wrp.426.1590430698031;
        Mon, 25 May 2020 11:18:18 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id s5sm3412123wme.37.2020.05.25.11.18.16
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 11:18:17 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
To:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
Date:   Mon, 25 May 2020 20:18:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ECC09D6.1010300@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>
> Especially
>
> https://raid.wiki.kernel.org/index.php/Asking_for_help
>
> More will follow but we need this info.

You´re totally right. Sorry for not quoting.

All drives are new.

root@nas:~# smartctl --xall /dev/sda
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-12-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD120EFAX-68UNTN0
Serial Number:    8CHM61BE
LU WWN Device Id: 5 000cca 26fd6d13e
Firmware Version: 81.00A81
User Capacity:    12.000.138.625.024 bytes [12,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon May 25 20:12:40 2020 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: 
Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                (   87) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (1197) minutes.
SCT capabilities:              (0x003d) SCT Status supported.
                                         SCT Error Recovery Control 
supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
   1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
   2 Throughput_Performance  --S---   129   129   054    -    104
   3 Spin_Up_Time            POS---   100   100   024    -    0
   4 Start_Stop_Count        -O--C-   100   100   000    -    2
   5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
   7 Seek_Error_Rate         -O-R--   100   100   067    -    0
   8 Seek_Time_Performance   --S---   140   140   020    -    15
   9 Power_On_Hours          -O--C-   100   100   000    -    212
  10 Spin_Retry_Count        -O--C-   100   100   060    -    0
  12 Power_Cycle_Count       -O--CK   100   100   000    -    2
  22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    8
193 Load_Cycle_Count        -O--C-   100   100   000    -    8
194 Temperature_Celsius     -O----   196   196   000    -    33 (Min/Max 
22/37)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                             ||||||_ K auto-keep
                             |||||__ C event count
                             ||||___ R error rate
                             |||____ S speed/performance
                             ||_____ O updated online
                             |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O    255  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0c       GPL     R/O   5501  Pending Defects log
0x10       GPL     R/O      1  SATA NCQ Queued Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ NON-DATA log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x15       GPL     R/W      1  SATA Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    33 Celsius
Power Cycle Min/Max Temperature:     26/37 Celsius
Lifetime    Min/Max Temperature:     22/37 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/65 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (70)

Index    Estimated Time   Temperature Celsius
   71    2020-05-25 18:05    35  ****************
  ...    ..(  9 skipped).    ..  ****************
   81    2020-05-25 18:15    35  ****************
   82    2020-05-25 18:16    34  ***************
   83    2020-05-25 18:17    34  ***************
   84    2020-05-25 18:18    34  ***************
   85    2020-05-25 18:19    35  ****************
  ...    ..(  9 skipped).    ..  ****************
   95    2020-05-25 18:29    35  ****************
   96    2020-05-25 18:30    34  ***************
  ...    ..( 80 skipped).    ..  ***************
   49    2020-05-25 19:51    34  ***************
   50    2020-05-25 19:52    33  **************
  ...    ..( 18 skipped).    ..  **************
   69    2020-05-25 20:11    33  **************
   70    2020-05-25 20:12    35  ****************

SCT Error Recovery Control:
            Read:     70 (7,0 seconds)
           Write:     70 (7,0 seconds)

Device Statistics (GP/SMART Log 0x04) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           53  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           48  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

========================================================

root@nas:~# smartctl --xall /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-12-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD120EFAX-68UNTN0
Serial Number:    8CHUDDLE
LU WWN Device Id: 5 000cca 26fd9a35a
Firmware Version: 81.00A81
User Capacity:    12.000.138.625.024 bytes [12,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon May 25 20:13:47 2020 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: 
Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                (   87) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (1322) minutes.
SCT capabilities:              (0x003d) SCT Status supported.
                                         SCT Error Recovery Control 
supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
   1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
   2 Throughput_Performance  --S---   129   129   054    -    104
   3 Spin_Up_Time            POS---   100   100   024    -    0
   4 Start_Stop_Count        -O--C-   100   100   000    -    2
   5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
   7 Seek_Error_Rate         -O-R--   100   100   067    -    0
   8 Seek_Time_Performance   --S---   128   128   020    -    18
   9 Power_On_Hours          -O--C-   100   100   000    -    212
  10 Spin_Retry_Count        -O--C-   100   100   060    -    0
  12 Power_Cycle_Count       -O--CK   100   100   000    -    2
  22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    4
193 Load_Cycle_Count        -O--C-   100   100   000    -    4
194 Temperature_Celsius     -O----   196   196   000    -    33 (Min/Max 
22/37)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                             ||||||_ K auto-keep
                             |||||__ C event count
                             ||||___ R error rate
                             |||____ S speed/performance
                             ||_____ O updated online
                             |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O    255  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0c       GPL     R/O   5501  Pending Defects log
0x10       GPL     R/O      1  SATA NCQ Queued Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ NON-DATA log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x15       GPL     R/W      1  SATA Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    33 Celsius
Power Cycle Min/Max Temperature:     26/37 Celsius
Lifetime    Min/Max Temperature:     22/37 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/65 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (62)

Index    Estimated Time   Temperature Celsius
   63    2020-05-25 18:06    35  ****************
  ...    ..( 26 skipped).    ..  ****************
   90    2020-05-25 18:33    35  ****************
   91    2020-05-25 18:34    34  ***************
   92    2020-05-25 18:35    34  ***************
   93    2020-05-25 18:36    34  ***************
   94    2020-05-25 18:37    35  ****************
  ...    ..(  9 skipped).    ..  ****************
  104    2020-05-25 18:47    35  ****************
  105    2020-05-25 18:48    34  ***************
  ...    ..( 80 skipped).    ..  ***************
   58    2020-05-25 20:09    34  ***************
   59    2020-05-25 20:10    33  **************
   60    2020-05-25 20:11    33  **************
   61    2020-05-25 20:12    33  **************
   62    2020-05-25 20:13    35  ****************

SCT Error Recovery Control:
            Read:     70 (7,0 seconds)
           Write:     70 (7,0 seconds)

Device Statistics (GP/SMART Log 0x04) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2        12004  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2        12005  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

================================================

root@nas:~# smartctl --xall /dev/sdc
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-12-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD120EFAX-68UNTN0
Serial Number:    8CJMXNDE
LU WWN Device Id: 5 000cca 26fe53da3
Firmware Version: 81.00A81
User Capacity:    12.000.138.625.024 bytes [12,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon May 25 20:15:17 2020 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: 
Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                (   87) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (1260) minutes.
SCT capabilities:              (0x003d) SCT Status supported.
                                         SCT Error Recovery Control 
supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
   1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
   2 Throughput_Performance  --S---   127   127   054    -    112
   3 Spin_Up_Time            POS---   100   100   024    -    0
   4 Start_Stop_Count        -O--C-   100   100   000    -    2
   5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
   7 Seek_Error_Rate         -O-R--   100   100   067    -    0
   8 Seek_Time_Performance   --S---   140   140   020    -    15
   9 Power_On_Hours          -O--C-   100   100   000    -    212
  10 Spin_Retry_Count        -O--C-   100   100   060    -    0
  12 Power_Cycle_Count       -O--CK   100   100   000    -    2
  22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    7
193 Load_Cycle_Count        -O--C-   100   100   000    -    7
194 Temperature_Celsius     -O----   196   196   000    -    33 (Min/Max 
23/37)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                             ||||||_ K auto-keep
                             |||||__ C event count
                             ||||___ R error rate
                             |||____ S speed/performance
                             ||_____ O updated online
                             |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O    255  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0c       GPL     R/O   5501  Pending Defects log
0x10       GPL     R/O      1  SATA NCQ Queued Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ NON-DATA log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x15       GPL     R/W      1  SATA Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    33 Celsius
Power Cycle Min/Max Temperature:     26/37 Celsius
Lifetime    Min/Max Temperature:     23/37 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/65 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (54)

Index    Estimated Time   Temperature Celsius
   55    2020-05-25 18:08    35  ****************
  ...    ..( 22 skipped).    ..  ****************
   78    2020-05-25 18:31    35  ****************
   79    2020-05-25 18:32    34  ***************
  ...    ..(  5 skipped).    ..  ***************
   85    2020-05-25 18:38    34  ***************
   86    2020-05-25 18:39    35  ****************
  ...    ..(  5 skipped).    ..  ****************
   92    2020-05-25 18:45    35  ****************
   93    2020-05-25 18:46    34  ***************
  ...    ..( 81 skipped).    ..  ***************
   47    2020-05-25 20:08    34  ***************
   48    2020-05-25 20:09    33  **************
  ...    ..(  4 skipped).    ..  **************
   53    2020-05-25 20:14    33  **************
   54    2020-05-25 20:15    35  ****************

SCT Error Recovery Control:
            Read:     70 (7,0 seconds)
           Write:     70 (7,0 seconds)

Device Statistics (GP/SMART Log 0x04) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           25  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           26  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

===============================================

root@nas:~# smartctl --xall /dev/sdd
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-12-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD120EFAX-68UNTN0
Serial Number:    8CJNZTLE
LU WWN Device Id: 5 000cca 26fe5ba06
Firmware Version: 81.00A81
User Capacity:    12.000.138.625.024 bytes [12,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon May 25 20:16:28 2020 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: 
Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                (   87) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (1333) minutes.
SCT capabilities:              (0x003d) SCT Status supported.
                                         SCT Error Recovery Control 
supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
   1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
   2 Throughput_Performance  --S---   127   127   054    -    112
   3 Spin_Up_Time            POS---   100   100   024    -    0
   4 Start_Stop_Count        -O--C-   100   100   000    -    2
   5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
   7 Seek_Error_Rate         -O-R--   100   100   067    -    0
   8 Seek_Time_Performance   --S---   140   140   020    -    15
   9 Power_On_Hours          -O--C-   100   100   000    -    212
  10 Spin_Retry_Count        -O--C-   100   100   060    -    0
  12 Power_Cycle_Count       -O--CK   100   100   000    -    2
  22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    10
193 Load_Cycle_Count        -O--C-   100   100   000    -    10
194 Temperature_Celsius     -O----   196   196   000    -    33 (Min/Max 
22/37)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                             ||||||_ K auto-keep
                             |||||__ C event count
                             ||||___ R error rate
                             |||____ S speed/performance
                             ||_____ O updated online
                             |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O    255  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0c       GPL     R/O   5501  Pending Defects log
0x10       GPL     R/O      1  SATA NCQ Queued Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ NON-DATA log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x15       GPL     R/W      1  SATA Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    33 Celsius
Power Cycle Min/Max Temperature:     25/37 Celsius
Lifetime    Min/Max Temperature:     22/37 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/65 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (1)

Index    Estimated Time   Temperature Celsius
    2    2020-05-25 18:09    34  ***************
    3    2020-05-25 18:10    34  ***************
    4    2020-05-25 18:11    34  ***************
    5    2020-05-25 18:12    35  ****************
  ...    ..(  2 skipped).    ..  ****************
    8    2020-05-25 18:15    35  ****************
    9    2020-05-25 18:16    34  ***************
  ...    ..( 48 skipped).    ..  ***************
   58    2020-05-25 19:05    34  ***************
   59    2020-05-25 19:06    33  **************
  ...    ..(  4 skipped).    ..  **************
   64    2020-05-25 19:11    33  **************
   65    2020-05-25 19:12    34  ***************
  ...    ..(  7 skipped).    ..  ***************
   73    2020-05-25 19:20    34  ***************
   74    2020-05-25 19:21    33  **************
  ...    ..(  6 skipped).    ..  **************
   81    2020-05-25 19:28    33  **************
   82    2020-05-25 19:29    34  ***************
  ...    ..(  6 skipped).    ..  ***************
   89    2020-05-25 19:36    34  ***************
   90    2020-05-25 19:37    33  **************
  ...    ..(  8 skipped).    ..  **************
   99    2020-05-25 19:46    33  **************
  100    2020-05-25 19:47    34  ***************
  101    2020-05-25 19:48    34  ***************
  102    2020-05-25 19:49    33  **************
  103    2020-05-25 19:50    34  ***************
  104    2020-05-25 19:51    33  **************
  ...    ..( 23 skipped).    ..  **************
    0    2020-05-25 20:15    33  **************
    1    2020-05-25 20:16    34  ***************

SCT Error Recovery Control:
            Read:     70 (7,0 seconds)
           Write:     70 (7,0 seconds)

Device Statistics (GP/SMART Log 0x04) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           13  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           14  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

=============================================

root@nas:~# smartctl --xall /dev/sde
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-12-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD120EFAX-68UNTN0
Serial Number:    8CHU2XRE
LU WWN Device Id: 5 000cca 26fd97fc4
Firmware Version: 81.00A81
User Capacity:    12.000.138.625.024 bytes [12,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon May 25 20:17:07 2020 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     254 (maximum performance)
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: 
Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                (   87) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (1265) minutes.
SCT capabilities:              (0x003d) SCT Status supported.
                                         SCT Error Recovery Control 
supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
   1 Raw_Read_Error_Rate     PO-R--   100   100   016    -    0
   2 Throughput_Performance  --S---   127   127   054    -    111
   3 Spin_Up_Time            POS---   100   100   024    -    0
   4 Start_Stop_Count        -O--C-   100   100   000    -    2
   5 Reallocated_Sector_Ct   PO--CK   100   100   005    -    0
   7 Seek_Error_Rate         -O-R--   100   100   067    -    0
   8 Seek_Time_Performance   --S---   140   140   020    -    15
   9 Power_On_Hours          -O--C-   100   100   000    -    265
  10 Spin_Retry_Count        -O--C-   100   100   060    -    0
  12 Power_Cycle_Count       -O--CK   100   100   000    -    2
  22 Unknown_Attribute       PO---K   100   100   025    -    100
192 Power-Off_Retract_Count -O--CK   100   100   000    -    12
193 Load_Cycle_Count        -O--C-   100   100   000    -    12
194 Temperature_Celsius     -O----   196   196   000    -    33 (Min/Max 
24/37)
196 Reallocated_Event_Count -O--CK   100   100   000    -    0
197 Current_Pending_Sector  -O---K   100   100   000    -    0
198 Offline_Uncorrectable   ---R--   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O-R--   200   200   000    -    0
                             ||||||_ K auto-keep
                             |||||__ C event count
                             ||||___ R error rate
                             |||____ S speed/performance
                             ||_____ O updated online
                             |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      1  Comprehensive SMART error log
0x03       GPL     R/O      1  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O    255  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0c       GPL     R/O   5501  Pending Defects log
0x10       GPL     R/O      1  SATA NCQ Queued Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ NON-DATA log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x15       GPL     R/W      1  SATA Rebuild Assist log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    256  Current Device Internal Status Data log
0x25       GPL     R/O    256  Saved Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (1 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       256 (0x0100)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    33 Celsius
Power Cycle Min/Max Temperature:     25/37 Celsius
Lifetime    Min/Max Temperature:     24/37 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/65 Celsius
Min/Max Temperature Limit:           -40/70 Celsius
Temperature History Size (Index):    128 (76)

Index    Estimated Time   Temperature Celsius
   77    2020-05-25 18:10    35  ****************
   78    2020-05-25 18:11    34  ***************
  ...    ..(  2 skipped).    ..  ***************
   81    2020-05-25 18:14    34  ***************
   82    2020-05-25 18:15    35  ****************
  ...    ..(  8 skipped).    ..  ****************
   91    2020-05-25 18:24    35  ****************
   92    2020-05-25 18:25    34  ***************
  ...    ..( 63 skipped).    ..  ***************
   28    2020-05-25 19:29    34  ***************
   29    2020-05-25 19:30    33  **************
  ...    ..(  2 skipped).    ..  **************
   32    2020-05-25 19:33    33  **************
   33    2020-05-25 19:34    34  ***************
  ...    ..(  9 skipped).    ..  ***************
   43    2020-05-25 19:44    34  ***************
   44    2020-05-25 19:45    33  **************
  ...    ..(  7 skipped).    ..  **************
   52    2020-05-25 19:53    33  **************
   53    2020-05-25 19:54    34  ***************
  ...    ..(  4 skipped).    ..  ***************
   58    2020-05-25 19:59    34  ***************
   59    2020-05-25 20:00    33  **************
  ...    ..( 15 skipped).    ..  **************
   75    2020-05-25 20:16    33  **************
   76    2020-05-25 20:17    35  ****************

SCT Error Recovery Control:
            Read:     70 (7,0 seconds)
           Write:     70 (7,0 seconds)

Device Statistics (GP/SMART Log 0x04) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2           13  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           14  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

==========================================


Last one, I tried is:


root@nas:~# mdadm -Av --invalid-backup --backup-file=/tmp/bu.bak 
--update=resync /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1
mdadm: looking for devices for /dev/md0
mdadm: /dev/sda1 is identified as a member of /dev/md0, slot 0.
mdadm: /dev/sdb1 is identified as a member of /dev/md0, slot 1.
mdadm: /dev/sdc1 is identified as a member of /dev/md0, slot 2.
mdadm: /dev/sdd1 is identified as a member of /dev/md0, slot 3.
mdadm: /dev/sde1 is identified as a member of /dev/md0, slot 4.
mdadm: /dev/md0 has an active reshape - checking if critical section 
needs to be restored
mdadm: Cannot read from /tmp/bu.bak
mdadm: No backup metadata on device-4
mdadm: Failed to find backup of critical section
mdadm: continuing without restoring backup
mdadm: added /dev/sdb1 to /dev/md0 as 1
mdadm: added /dev/sdc1 to /dev/md0 as 2
mdadm: added /dev/sdd1 to /dev/md0 as 3
mdadm: added /dev/sde1 to /dev/md0 as 4
mdadm: added /dev/sda1 to /dev/md0 as 0
mdadm: failed to RUN_ARRAY /dev/md0: Invalid argument
root@nas:~# mdadm -D /dev/md0
/dev/md0:
         Version : 1.2
      Raid Level : raid0
   Total Devices : 5
     Persistence : Superblock is persistent

           State : inactive

   Delta Devices : 1, (-1->0)
       New Level : raid5
      New Layout : left-symmetric
   New Chunksize : 512K

            Name : nas:0  (local to host nas)
            UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
          Events : 38602

     Number   Major   Minor   RaidDevice

        -       8       65        -        /dev/sde1
        -       8       49        -        /dev/sdd1
        -       8       33        -        /dev/sdc1
        -       8       17        -        /dev/sdb1
        -       8        1        -        /dev/sda1


Thanks for your help

Greetings

Thomas

