Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93411155B05
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGPug (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 10:50:36 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37782 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGPuf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 10:50:35 -0500
Received: by mail-oi1-f170.google.com with SMTP id q84so2410783oic.4
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 07:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gfkdlE1lNjTYnFmVNQCNOoIaFbTvHQlPl/dZ4UJIQJg=;
        b=nWKsroQo8x4IBQtdGi76vW1GHYsxf74wK9aZeV7X0QHd/Rtos1WHqmThtYPzagkgDd
         1X1oPo0Gcps/x6ztkJZ6zZm4TPO6lTGLmv1Lf625UUhkjo/Ote01maWbQCU1XL5iWnSY
         veEFNx8wpGHEg1kEbjxeapkzPnnJiJLcDBOo9ragKBasWC/9nv7WIjwZJoJ+Vppvsghm
         WeYikMHVwfGktgclhvzfS9jrxruI/eZxDyNEahRUqaWM/qbKEQrnI0qcwvPM+iEs/5Mw
         ql4hWluvFvwN6UkOD6qZuayU5Vdv+30UMPl1aRZjF5Yv/N3OmccDqVxZU7fMdCogTH2O
         BNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gfkdlE1lNjTYnFmVNQCNOoIaFbTvHQlPl/dZ4UJIQJg=;
        b=GIiregEUYyfZW6MOnvVgJ+ACLWDeb59nixYUNNlnkC7I+Z3g0hNQvPjgQbZucDWnQW
         /3cUB/AeveweBElPrtzy1KV7/m8+i1WOBfZOFmURzytDcGiYdTgsr0mD5QBmlh8wpaaA
         4ci/UZdPmBOQGkIHMP6O0NQIlfAODEM9T1D5caQwA3/kAri1rOskUOd0uCkmGm5bo3zb
         uY4K/C8MxkJU5qlrD2C06TOtQJxy7mXAWJhVvaay0/cIzGdVDTwFqEOgRaxIwzScQGWV
         i+wpBJvz6Ut6KW02qGT6W7PN/plebpeuXyc8c/STlmkdNe4hGjhoCWh1eErqWU4cVDdZ
         F3Rg==
X-Gm-Message-State: APjAAAUofA94jscTkAaGd0iTaEIfzUJ11yB3HzhLkahrwsURVuBfoogZ
        tnVLrKWOCmpyBwM9UUy9gh6LZCwb/OyW2FU4vEUHCk/omWQ=
X-Google-Smtp-Source: APXvYqynRofpE++87Q7zvHSQf3LRVsBPAac+x0zVu9T9VjWBDLeI5LBYpJYJECQc/Vb2VPfyBqxIT5qejiF8HLRwwTo=
X-Received: by 2002:aca:cd46:: with SMTP id d67mr2515969oig.156.1581090634140;
 Fri, 07 Feb 2020 07:50:34 -0800 (PST)
MIME-Version: 1.0
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 7 Feb 2020 09:49:56 -0600
Message-ID: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
Subject: Question
To:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings

Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
(11) system.
mdadm - v4.1 - 2018-10-01 is the version being used.

Some weirdness is happening - - - vis a vis - - - I have one directory
(not small) that has disappeared. I last accessed said directory
(still have the pdf open which is how I could get this information)
'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
section of the file in question.

Has been suggested to me that I make the array read only until this is resolved.
I have space on the the array on a different system to recover this array.
Suggestions on how to do both of the above would be aprreciated

Checked the drives that make up the array using smartctl and the
results are (I removed text from each result that did not seem to have
any bearing on the test results (I likely used the wrong 'code')):

# smartctl -a /dev/sdb
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.4.0-2-amd64] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Red
Device Model:     WDC WD10EFRX-68FYTN0
Serial Number:    WD-WCC4J3TC25D3
LU WWN Device Id: 5 0014ee 20cd9cd93
Firmware Version: 82.00A82
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Fri Feb  7 08:35:51 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0027   132   130   021    Pre-fail
Always       -       4391
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       165
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   058   058   000    Old_age
Always       -       31314
 10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       148
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       81
193 Load_Cycle_Count        0x0032   187   187   000    Old_age
Always       -       39644
194 Temperature_Celsius     0x0022   115   101   000    Old_age
Always       -       28
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

# smartctl -a /dev/sdc
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.4.0-2-amd64] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Red
Device Model:     WDC WD10EFRX-68FYTN0
Serial Number:    WD-WCC4J6TTLZTE
LU WWN Device Id: 5 0014ee 2b784490e
Firmware Version: 82.00A82
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Fri Feb  7 08:36:49 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0027   132   130   021    Pre-fail
Always       -       4375
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       151
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   056   056   000    Old_age
Always       -       32529
 10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       149
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       80
193 Load_Cycle_Count        0x0032   187   187   000    Old_age
Always       -       39651
194 Temperature_Celsius     0x0022   115   099   000    Old_age
Always       -       28
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

# smartctl -a /dev/sde
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.4.0-2-amd64] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Red
Device Model:     WDC WD10EFRX-68FYTN0
Serial Number:    WD-WCC4J6XRY5AN
LU WWN Device Id: 5 0014ee 20cd940c6
Firmware Version: 82.00A82
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Feb  7 08:37:21 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0027   131   129   021    Pre-fail
Always       -       4441
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       152
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   056   056   000    Old_age
Always       -       32530
 10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       150
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       83
193 Load_Cycle_Count        0x0032   187   187   000    Old_age
Always       -       39603
194 Temperature_Celsius     0x0022   113   094   000    Old_age
Always       -       30
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age
Always       -       1
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

# smartctl -a /dev/sdf
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.4.0-2-amd64] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Red
Device Model:     WDC WD10EFRX-68FYTN0
Serial Number:    WD-WCC4J4XV62F4
LU WWN Device Id: 5 0014ee 20cd9d7d1
Firmware Version: 82.00A82
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Feb  7 08:37:44 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       8
  3 Spin_Up_Time            0x0027   135   134   021    Pre-fail
Always       -       4241
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       165
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   059   059   000    Old_age
Always       -       30121
 10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       148
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       82
193 Load_Cycle_Count        0x0032   187   187   000    Old_age
Always       -       39528
194 Temperature_Celsius     0x0022   115   097   000    Old_age
Always       -       28
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
