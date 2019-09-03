Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595AAA6CE2
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfICP1g (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 11:27:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40819 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICP1g (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 11:27:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so13040963edm.7
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4WqYDNEa6qxFQSQSJIi3ZQY5p2CPZ0T2fSXkpshXOo=;
        b=KHtZuBkPfao77vDcKtILfZfBMiecZawDWZegX+EXQpqFuQGlLssPvw+5XzBGKElZYt
         uHRdEkJrbUfZLT6F4C7/uw5D+CQ+ZUIBCvE3AdpybE1ZgmOkKIrRnsarm0kiuymqocBt
         B4ASluKxTtGN4o37QzRxpmaNDKNjqGduChQPVlgavHeAWgrUmk2Tc/wLzFSGMPOtNAFy
         OdvDS6CgrKO9z05BTTHg+zH3pxiTM4wnQiBQSxVFXvAVzsXVz5hgBL/2HVg3OACLEDVE
         4sn1+436nh5WvOBCCmqzEJ7rrs3vaHuwekNXqfu0VNRGlEJ3wvKbBZn37BWCDCi6Nbqu
         71Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4WqYDNEa6qxFQSQSJIi3ZQY5p2CPZ0T2fSXkpshXOo=;
        b=LOBeZkMek7QAr2icUWm9yg5XRiWomyUjZvqRrESEZ67TwBEQtks8ZxRC/tD7aLOfvl
         RFIqfl4A+oLvej7voBshuOaEK5FgMh/cna8Vvk1EL5+bo599Zd9KbC39nsvRuD2mAOLY
         vcB72oupbVPJV8bJ4a+fvNQIBEK9K6HDJd3RN5FBe62KNt34uzGXSi7oSexDFtZohy5I
         /tcsK+/55M15glnpVtW1SKlWM3sDvOfS+yGJikDsvpxmku6dtSgP5Qau+/TDMsS2/8Af
         3SwiV/G2HRSVpRDPdDqK5R+XumdsQ5Sp9T59cYDM0/u/yv8mSUIX1SUy/aLeKpLmM7H/
         3aXg==
X-Gm-Message-State: APjAAAU4VmJ6jxfMK615t3eWl12OOeeQ4hX4ymO4pR4QHaKMlk0pFTir
        xXF+PSt+7hSf6NhKXt60R97mbO/sohXDdpcRwko=
X-Google-Smtp-Source: APXvYqzkhEV+mOiDGdnRIkGGPhcBLHc/il3AxkEVakWAZf4vbWuipWkZO/UjnKIPcO6RdVE6IESHEUI7i6d3k4SJGWo=
X-Received: by 2002:a17:906:4d56:: with SMTP id b22mr14284031ejv.152.1567524453833;
 Tue, 03 Sep 2019 08:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk> <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
 <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org> <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
 <87h85udyfs.fsf@notabene.neil.brown.name> <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
 <d9a08687-0225-407f-dff0-f7f440786654@turmel.org>
In-Reply-To: <d9a08687-0225-407f-dff0-f7f440786654@turmel.org>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Tue, 3 Sep 2019 17:27:06 +0200
Message-ID: <CA+ojRw=f6_7uOd_6uAt_kcGL3_5-SFdDWtCYBJ-K0rwUQdnmow@mail.gmail.com>
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     Phil Turmel <philip@turmel.org>
Cc:     NeilBrown <neilb@suse.de>, Neil F Brown <nfbrown@suse.com>,
        linux-raid@vger.kernel.org, Wols Lists <antlists@youngman.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good afternoon Phil,

I'm sorry if I didn't follow the etiquette for the mailing lists. It's
actually the first time I'm using one, so I need to do some research
on that topic, but the situation was quite stressful in the begining
and I've skipped that. I hope that the message looks better now.

I think the situation looks worse now. The reshape finished and resync
has begun. During the resync I've found many errors concerning
/dev/sdf which is the part of the md127. Example below:

[77929.632264] md: md127: reshape done.
[77930.353038] md: resync of RAID array md127
[78358.476585] ata5.00: exception Emask 0x0 SAct 0xffffffff SErr 0x0 action 0x0
[78358.477393] ata5.00: irq_stat 0x40000008
[78358.477826] ata5.00: failed command: READ FPDMA QUEUED
[78358.478260] ata5.00: cmd 60/40:b0:f0:41:cd/05:00:07:00:00/40 tag 22
ncq dma 688128 in
                        res 41/40:00:b8:46:cd/00:00:07:00:00/40 Emask
0x409 (media error) <F>
[78358.479118] ata5.00: status: { DRDY ERR }
[78358.479520] ata5.00: error: { UNC }
[78358.481178] ata5.00: configured for UDMA/133
[78358.481348] sd 4:0:0:0: [sdf] tag#22 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[78358.481352] sd 4:0:0:0: [sdf] tag#22 Sense Key : Medium Error [current]
[78358.481355] sd 4:0:0:0: [sdf] tag#22 Add. Sense: Unrecovered read
error - auto reallocate failed
[78358.481359] sd 4:0:0:0: [sdf] tag#22 CDB: Read(16) 88 00 00 00 00
00 07 cd 41 f0 00 00 05 40 00 00
[78358.481362] print_req_error: I/O error, dev sdf, sector 130893496
[78358.481821] ata5: EH complete
[78363.606588] ata5.00: exception Emask 0x0 SAct 0xffffffff SErr 0x0 action 0x0
[78363.607550] ata5.00: irq_stat 0x40000008
[78363.608086] ata5.00: failed command: READ FPDMA QUEUED
[78363.608650] ata5.00: cmd 60/40:98:70:76:cd/05:00:07:00:00/40 tag 19
ncq dma 688128 in
                        res 41/40:00:78:77:cd/00:00:07:00:00/40 Emask
0x409 (media error) <F>
[78363.609867] ata5.00: status: { DRDY ERR }
[78363.610494] ata5.00: error: { UNC }
[78363.612536] ata5.00: configured for UDMA/133
[78363.612671] sd 4:0:0:0: [sdf] tag#19 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[78363.612675] sd 4:0:0:0: [sdf] tag#19 Sense Key : Medium Error [current]
[78363.612678] sd 4:0:0:0: [sdf] tag#19 Add. Sense: Unrecovered read
error - auto reallocate failed
[78363.612682] sd 4:0:0:0: [sdf] tag#19 CDB: Read(16) 88 00 00 00 00
00 07 cd 76 70 00 00 05 40 00 00
[78363.612685] print_req_error: I/O error, dev sdf, sector 130905976
[78363.613474] ata5: EH complete
[78367.196566] ata5.00: exception Emask 0x0 SAct 0xffffffff SErr 0x0 action 0x0
[78367.198040] ata5.00: irq_stat 0x40000008
[78367.198833] ata5.00: failed command: READ FPDMA QUEUED
[78367.199653] ata5.00: cmd 60/40:b8:30:47:cd/05:00:07:00:00/40 tag 23
ncq dma 688128 in
                        res 41/40:00:78:47:cd/00:00:07:00:00/40 Emask
0x409 (media error) <F>
[78367.201382] ata5.00: status: { DRDY ERR }
[78367.202276] ata5.00: error: { UNC }
[78367.204497] ata5.00: configured for UDMA/133
[78367.204626] sd 4:0:0:0: [sdf] tag#23 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[78367.204630] sd 4:0:0:0: [sdf] tag#23 Sense Key : Medium Error [current]
[78367.204634] sd 4:0:0:0: [sdf] tag#23 Add. Sense: Unrecovered read
error - auto reallocate failed
[78367.204638] sd 4:0:0:0: [sdf] tag#23 CDB: Read(16) 88 00 00 00 00
00 07 cd 47 30 00 00 05 40 00 00
[78367.204641] print_req_error: I/O error, dev sdf, sector 130893688
[78367.205718] ata5: EH complete
[78372.686561] ata5.00: exception Emask 0x0 SAct 0xffffffff SErr 0x0 action 0x0
[78372.688585] ata5.00: irq_stat 0x40000008
[78372.689654] ata5.00: failed command: READ FPDMA QUEUED
[78372.690751] ata5.00: cmd 60/40:78:b0:7b:cd/05:00:07:00:00/40 tag 15
ncq dma 688128 in
                        res 41/40:00:e8:7b:cd/00:00:07:00:00/40 Emask
0x409 (media error) <F>
[78372.693034] ata5.00: status: { DRDY ERR }
[78372.694194] ata5.00: error: { UNC }

These information repeats between 77929 and 78721 seconds. There's
really a lot of such information. What does that mean? Doesn't look
good, however I don't observer further errors since `dmesg | tail`
shows:

[78723.057686] raid5_end_read_request: 22 callbacks suppressed
[78723.057688] md/raid:md127: read error corrected (8 sectors at
130891448 on sdf1)
[78723.057719] md/raid:md127: read error corrected (8 sectors at
130903928 on sdf1)
[78723.057761] md/raid:md127: read error corrected (8 sectors at
130904144 on sdf1)
[78723.057804] md/raid:md127: read error corrected (8 sectors at
130904224 on sdf1)
[78723.061817] md/raid:md127: read error corrected (8 sectors at
130904280 on sdf1)
[78723.063796] md/raid:md127: read error corrected (8 sectors at
130891488 on sdf1)
[78723.063846] md/raid:md127: read error corrected (8 sectors at
130904024 on sdf1)
[78723.063889] md/raid:md127: read error corrected (8 sectors at
130904312 on sdf1)
[78723.063934] md/raid:md127: read error corrected (8 sectors at
130904376 on sdf1)
[78723.063980] md/raid:md127: read error corrected (8 sectors at
130904512 on sdf1)
[79225.164085] audit: type=1006 audit(1567523533.835:50): pid=19706
uid=0 old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=3
res=1
[79225.182760] audit: type=1130 audit(1567523533.855:51): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[79225.188489] audit: type=1006 audit(1567523533.865:52): pid=19722
uid=0 old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=4
res=1
[79225.235782] audit: type=1130 audit(1567523533.905:53): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=user@0 comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'

The contents of `/proc/mdstat` are the following:

[root@sysresccd ~]# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md127 : active raid6 sda1[5] sdg1[6] sdd1[4] sdf1[3]
      7813771264 blocks super 1.2 level 6, 512k chunk, algorithm 2 [4/4] [UUUU]
      [=>...................]  resync =  5.9% (234117656/3906885632)
finish=399.3min speed=153265K/sec
      bitmap: 7/30 pages [28KB], 65536KB chunk

unused devices: <none>

The `smartctl -a /def/sdf` shows 1 current pending sector:

[root@sysresccd ~]# smartctl -a /dev/sdf
smartctl 7.0 2018-12-30 r4883 [x86_64-linux-4.19.34-1-lts] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Red
Device Model:     WDC WD40EFRX-68WT0N0
Serial Number:    WD-WCC4E2ZTJ6S9
LU WWN Device Id: 5 0014ee 2629cfe27
Firmware Version: 82.00A82
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Tue Sep  3 15:24:22 2019 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0) The previous self-test routine completed
                                        without error or no self-test has ever
                                        been run.
Total time to complete Offline
data collection:                (51060) seconds.
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
recommended polling time:        ( 511) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.
SCT capabilities:              (0x703d) SCT Status supported.
                                        SCT Error Recovery Control supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       229
  3 Spin_Up_Time            0x0027   196   175   021    Pre-fail
Always       -       7175
  4 Start_Stop_Count        0x0032   096   096   000    Old_age
Always       -       4476
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   092   092   000    Old_age
Always       -       6548
 10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   096   096   000    Old_age
Always       -       4476
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       89
193 Load_Cycle_Count        0x0032   198   198   000    Old_age
Always       -       8128
194 Temperature_Celsius     0x0022   106   106   000    Old_age
Always       -       46
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       1
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

Do you think this drive should be replaced?
Why the array is resyncing?
Is the data in danger in this state?

Best regards,
Krzysztof Jakobczyk
