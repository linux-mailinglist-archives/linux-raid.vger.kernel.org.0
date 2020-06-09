Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4531F41A7
	for <lists+linux-raid@lfdr.de>; Tue,  9 Jun 2020 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgFIRBu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jun 2020 13:01:50 -0400
Received: from mx0a-0019cd01.pphosted.com ([67.231.149.227]:18416 "EHLO
        mx0a-0019cd01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731418AbgFIRBt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jun 2020 13:01:49 -0400
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2020 13:01:47 EDT
Received: from pps.filterd (m0182235.ppops.net [127.0.0.1])
        by mx0a-0019cd01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059GmGdR007985
        for <linux-raid@vger.kernel.org>; Tue, 9 Jun 2020 12:51:23 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mx0a-0019cd01.pphosted.com with ESMTP id 31g7eeymxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Tue, 09 Jun 2020 12:51:22 -0400
Received: by mail-qt1-f197.google.com with SMTP id l1so18962841qtv.13
        for <linux-raid@vger.kernel.org>; Tue, 09 Jun 2020 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fordham-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s/2fjkuXqlHkHGG2kfWfMPS9NExaOVmzCchmfktGdLI=;
        b=XdHvuI9wktX9x0+KeJ3N61N9ksNWQKpTUS2rhhMn834cXWeeoko0OR98n4gIDyCU6q
         bvhnd1NO0KjMXE19KWtCYobUO729L/H/qHDNEgMmIaYPA4oXwaCK3R8XpTW5egBI0hIz
         co3UJdtiEaMWEheJep0W2S2xRbmAsbZVxEWQKmjTdmakIg6xgfxZWocSI7aae+iC7qWn
         FY5+oMHv4caEbNhJl0rC0elvr/aJ+1uhq+axMUXbVTC2vJxeRTcQN77b4LmVMGs5lEWg
         6y2xpqOSmETkTpcu+G9wVWFfCnvNB/njGJ55eNWfmSdDq4Ic7UBcYu1VKNEUbyyNbMKx
         szQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=s/2fjkuXqlHkHGG2kfWfMPS9NExaOVmzCchmfktGdLI=;
        b=KwYKC9yHjGgfOdTRWQysOACSFYTiNnY8ZrfXbfeoQJhi2wGKPdYHHyxPpyXyFVuubd
         WqVsd3VHQO1IU5mX8Zz87B9sE21RUNWbHCY7aOmIe5DbiWmhhWk/671wdN4IDssnEap2
         G3JKdzU+2OwJdzQUVHYYo3i/chqnOMLQv5paxZmGmfFKJoJWspyVqhSrIPVKen6M+uy9
         Msv1jKK/I3jEm+S51R151PaFlfI3PhV2w7LCfnFqOo5RNEIGrFBFx5Fl5niZiVBI2ccK
         59VYvArC5nUmE3+wXGatpDcn+sEQbP1JinnUhOO+rdyzAMq/xZOh9lOokNUIMzkGmxA2
         lO1w==
X-Gm-Message-State: AOAM532STIbXyB6jbQNibpcu0zZXrT4UgMsDCSg4Es86uWXeQE4y9RiR
        eOWAJFu9NLhSfZJU6CfLnif0OnEmbFuz/K1cjtXIpymGQQrAMMMYdv3jGwanQBYmUqa5hakG+RJ
        fFgG++OxGFs0ub6RzcvLq+byj1bhMfLPTG3g=
X-Received: by 2002:ac8:7303:: with SMTP id x3mr11565538qto.44.1591721481127;
        Tue, 09 Jun 2020 09:51:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVrCgV62ZwaEvwOCocwGi+zH5K4dk7rlRSGZ55fLGP/A9VEsT3oXGU+qsPvEUIO3wKVht8sC+wdPVyL3ryI2Q=
X-Received: by 2002:ac8:7303:: with SMTP id x3mr11565482qto.44.1591721480517;
 Tue, 09 Jun 2020 09:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFHi+KSxLugjBpj0vFdC6xJMQrnGUrHDamqA6BcyYBt51r+wAA@mail.gmail.com>
In-Reply-To: <CAFHi+KSxLugjBpj0vFdC6xJMQrnGUrHDamqA6BcyYBt51r+wAA@mail.gmail.com>
From:   Robert Kudyba <rkudyba@fordham.edu>
Date:   Tue, 9 Jun 2020 12:51:08 -0400
Message-ID: <CAFHi+KRL2VfyiQxEPbPQRE8Kkaj1jO+FdUcPikJxFUPN514eRg@mail.gmail.com>
Subject: rsync input/output errors during resyncing of RAID10 e-sata, share
 changed to read-only
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_10:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1031 suspectscore=3
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090128
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Running Fedora 32 connected to a 4 drive e-sata with a software
RAID10. I'm pretty sure based on the below commands /dev/sdb is not
salvageable. As the RAID10 is re-syncing, the share is mounted as
read-only. I'm running a rsync to copy as many files as I can but
input/output errors happen intermittently. If /dev/sdb is showing as a
Removed state why are the system logs being filled with:
Jun  9 11:33:15 ourserver kernel: md: super_written gets error=3D10
Jun  9 11:33:15 ourserver kernel: md: md0: resync interrupted.
Jun  9 11:33:15 ourserver kernel: md: super_written gets error=3D10
Jun  9 11:33:15 ourserver kernel: EXT4-fs error (device md0):
ext4_journal_check_start:84: Detected aborted journal

Here are some related command outputs:

Disk /dev/sda: 1.84 TiB, 2000398934016 bytes, 3907029168 sectors
Disk model: ST2000DM001-1ER1
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: 0x7da9b00e

Device     Boot Start        End    Sectors  Size Id Type
/dev/sda1        2048 3907029167 3907027120  1.8T fd Linux raid autodetect

The backup GPT table is corrupt, but the primary appears OK, so that
will be used.
Disk /dev/sdb: 1.37 TiB, 1500301910016 bytes, 2930277168 sectors
Disk model: ST31500341AS
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: DC9A2601-CFE8-4ADD-85CD-FCBEBFCD8FAF

Device     Start        End    Sectors  Size Type
/dev/sdb1     34 2930277134 2930277101  1.4T Linux RAID

Disk /dev/sdc: 1.37 TiB, 1500301910016 bytes, 2930277168 sectors
Disk model: ST31500341AS
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00ff416d

Device     Boot Start        End    Sectors  Size Id Type
/dev/sdc1        2048 2930277167 2930275120  1.4T fd Linux raid autodetect

Disk /dev/sdf: 1.37 TiB, 1500301910016 bytes, 2930277168 sectors
Disk model: ST31500341AS
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x0001b5c0

Device     Boot Start        End    Sectors  Size Id Type
/dev/sdf1        2048 2930277167 2930275120  1.4T fd Linux raid autodetect

Disk /dev/md0: 2.75 TiB, 3000331190272 bytes, 5860021856 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 8192 bytes / 16384 bytes

Jun  9 11:29:32 ourserver smartd[1159]: Device: /dev/sda [SAT], No
more Currently unreadable (pending) sectors, warning condition reset
after 1 email
Jun  9 11:29:32 ourserver smartd[1159]: Device: /dev/sda [SAT], No
more Offline uncorrectable sectors, warning condition reset after 1
email
Jun  9 11:29:32 ourserver smartd[1159]: Device: /dev/sdb [SAT], FAILED
SMART self-check. BACK UP DATA NOW!
Jun  9 11:29:32 ourserver smartd[1159]: Device: /dev/sdb [SAT], 262
Currently unreadable (pending) sectors
Jun  9 11:29:32 ourserver smartd[1159]: Device: /dev/sdb [SAT], 262
Offline uncorrectable sectors
Jun  9 11:33:00 ourserver kernel: ata18.00: READ LOG DMA EXT failed, trying=
 PIO
Jun  9 11:33:00 ourserver kernel: ata18: failed to read log page 10h (errno=
=3D-5)
Jun  9 11:33:00 ourserver kernel: ata18.00: exception Emask 0x1 SAct
0x8000 SErr 0x0 action 0x0
Jun  9 11:33:00 ourserver kernel: ata18.00: irq_stat 0x40000008
Jun  9 11:33:00 ourserver kernel: ata18.00: failed command: READ FPDMA QUEU=
ED
Jun  9 11:33:00 ourserver kernel: ata18.00: cmd
60/00:78:12:c8:af/01:00:78:00:00/40 tag 15 ncq dma 131072 in#012
  res 40/00:78:12:c8:af/00:00:78:00:00/40 Emask 0x1 (device error)
rsync: read errors mapping "/testfile": Input/output error (5)

Jun  9 11:45:38 ourserver kernel: sd 17:0:0:0: [sdb] tag#18 FAILED
Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
Jun  9 11:45:38 ourserver kernel: sd 17:0:0:0: [sdb] tag#18 CDB:
Read(10) 28 00 36 cb b6 12 00 00 08 00
Jun  9 11:33:11 ourserver kernel: sd 17:0:0:0: [sdb] tag#2 FAILED
Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
Jun  9 11:33:11 ourserver kernel: sd 17:0:0:0: [sdb] tag#2 CDB:
Read(10) 28 00 78 b1 4d 12 00 00 08 00
Jun  9 11:33:11 ourserver kernel: blk_update_request: I/O error, dev
sdb, sector 2024885522 op 0x0:(READ) flags 0x0 phys_seg 1 pri
o class 0

smartctl -a /dev/sdb
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.6.16-300.fc32.x86_64]
(local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org
Short INQUIRY response, skip product id
A mandatory SMART command failed: exiting. To continue, add one or
more '-T permissive' options.

mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Fri Mar 13 16:46:35 2020
        Raid Level : raid10
        Array Size : 2930010928 (2794.28 GiB 3000.33 GB)
     Used Dev Size : 1465005464 (1397.14 GiB 1500.17 GB)
      Raid Devices : 4
     Total Devices : 3
       Persistence : Superblock is persistent

       Update Time : Tue Jun  9 11:38:16 2020
             State : clean, degraded, resyncing
    Active Devices : 3
   Working Devices : 3
    Failed Devices : 0
     Spare Devices : 0

            Layout : near=3D2
        Chunk Size : 8K

Consistency Policy : resync

     Resync Status : 12% complete

              Name : ourserver:0  (local to host ourserver )
              UUID : 88b9fcb6:52d0f235:849bd9d6:c079cfc8
            Events : 1077141

    Number   Major   Minor   RaidDevice State
       0       8       81        0      active sync set-A   /dev/sdf1
       4       8       33        1      active sync set-B   /dev/sdc1
       3       8       17        2      active sync set-A   /dev/sdb1
       -       0        0        3      removed

cat /proc/mdstat
Personalities : [raid10]
md0 : active raid10 sdf1[0] sdb1[3] sdc1[4]
      2930010928 blocks super 1.2 8K chunks 2 near-copies [4/3] [UUU_]
      [=3D=3D>..................]  resync =3D 13.0% (383207968/2930010928)
finish=3D621.1min speed=3D68338K/sec

unused devices: <none>

/lsdrv
**Warning** The following utility(ies) failed to execute:
  sginfo
Some information may be missing.

PCI [ahci] 00:11.5 SATA controller: Intel Corporation C620 Series
Chipset Family SSATA Controller [AHCI mode] (rev 09)
=E2=94=94scsi 0:x:x:x [Empty]
PCI [ahci] 00:17.0 SATA controller: Intel Corporation C620 Series
Chipset Family SATA Controller [AHCI mode] (rev 09)
=E2=94=94scsi 13:0:0:0 PLDS     DVD-ROM DU-8D5LH {432K1PLC0082P5094A00}
 =E2=94=94sr0 1.00g [11:0] Empty/Unknown
PCI [ahci] 3b:00.0 SATA controller: ASMedia Technology Inc. ASM1062
Serial ATA Controller (rev 02)
=E2=94=9Cscsi 14:0:0:0 ATA      ST31500341AS     {9VS21BET}
=E2=94=82=E2=94=94sdf 1.36t [8:80] Partitioned (dos)
=E2=94=82 =E2=94=94sdf1 1.36t [8:81] MD raid10,near2 (0/4) (w/ sdc1,sdb1) i=
n_sync
'newourserver :0' {88b9fcb6-52d0-f235-849b-d9d6c079cfc8}
=E2=94=82  =E2=94=94md0 2.73t [9:0] MD v1.2 raid10,near2 (4) clean DEGRADED=
, 8192b
Chunk, resync (911.50g/5.46t) 201.67m/sec
{88b9fcb6:52d0f235:849bd9d6:c079cfc8}
=E2=94=82   =E2=94=82               ext4 {7198cac0-91b2-4d1d-bb7d-f8fff8ed5=
4a2}
=E2=94=82   =E2=94=94Mounted as /dev/md0 @ /misc/esata
=E2=94=94scsi 15:0:0:0 ATA      ST31500341AS     {9VS1XVGK}
 =E2=94=94sdc 1.36t [8:32] Partitioned (dos)
  =E2=94=94sdc1 1.36t [8:33] MD raid10,near2 (1/4) (w/ sdf1,sdb1) in_sync
'newourserver :0' {88b9fcb6-52d0-f235-849b-d9d6c079cfc8}
   =E2=94=94md0 2.73t [9:0] MD v1.2 raid10,near2 (4) clean DEGRADED, 8192b
Chunk, resync (911.50g/5.46t) 201.67m/sec
{88b9fcb6:52d0f235:849bd9d6:c079cfc8}
                    ext4 {7198cac0-91b2-4d1d-bb7d-f8fff8ed54a2}
PCI [ahci] 5e:00.0 SATA controller: ASMedia Technology Inc. ASM1062
Serial ATA Controller (rev 02)
=E2=94=9Cscsi 16:0:0:0 ATA      ST2000DM001-1ER1 {W4Z24MWZ}
=E2=94=82=E2=94=94sda 1.82t [8:0] Partitioned (dos)
=E2=94=82 =E2=94=94sda1 1.82t [8:1] MD raid10 (4) inactive 'newourserver :0=
'
{88b9fcb6-52d0-f235-849b-d9d6c079cfc8}
=E2=94=94scsi 17:0:0:0 ATA      ST31500341AS
 =E2=94=94sdb 1.36t [8:16] Empty/Unknown
  =E2=94=94sdb1 1.36t [8:17] MD raid10,near2 (2/4) (w/ sdf1,sdc1)
in_sync,write_error,want_replacement 'newourserver :0'
{88b9fcb6-52d0-f235-849b-d9d6c079cfc8}
   =E2=94=94md0 2.73t [9:0] MD v1.2 raid10,near2 (4) clean DEGRADED, 8192b
Chunk, resync (911.50g/5.46t) 201.67m/sec
{88b9fcb6:52d0f235:849bd9d6:c079cfc8}
                    ext4 {7198cac0-91b2-4d1d-bb7d-f8fff8ed54a2}

Last time I tried a resync, it hund at 99.9%. Is there anything else I
should run?

Thanks!

Rob
