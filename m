Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D553B8B0E
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfITGaQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 02:30:16 -0400
Received: from mail.ugal.ro ([193.231.148.6]:40791 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394795AbfITGaQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 02:30:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id B7D8C13A2F54C;
        Fri, 20 Sep 2019 06:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3zNDpLdQVZ1h; Fri, 20 Sep 2019 09:28:04 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id AA96F13A2F54A;
        Fri, 20 Sep 2019 09:28:04 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'John Stoffel'" <john@stoffel.org>
Cc:     <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro> <23940.1755.134402.954287@quad.stoffel.home>
In-Reply-To: <23940.1755.134402.954287@quad.stoffel.home>
Subject: RE: RAID 10 with 2 failed drives
Date:   Fri, 20 Sep 2019 09:28:14 +0300
Organization: =?us-ascii?Q?Universitatea_=22Dunarea_de_Jos=22_din_Gala=3Fi?=
Message-ID: <094701d56f7c$95225260$bf66f720$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wLfsDrkpSYrjTA=
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thank you John Stoffel. 

So far I have done nothing but mdadm - exams.  Both disks seem to be gone
and have no led activity. Below are the system information and the details
of the event from /var/log/messages.
Thanks.

# uname -a
Linux Xen 3.10.0+2 #1 SMP Wed Mar 11 11:20:46 EDT 2015 x86_64 x86_64 x86_64
GNU/Linux

# lshw
xen
    description: Rack Mount Chassis
    product: S5520UR ()
    vendor: Intel Corporation
    version: ....................
    serial: ............
    width: 64 bits
    capabilities: vsyscall32
    configuration: administrator_password=disabled boot=normal
chassis=rackmount frontpanel_password=disabled keyboard_password=disabled
power-on_password=disabled uuid=4CA37E6A-3163-11DE-A57D-001517B13238
  *-core
       description: Motherboard
       product: S5520UR
       vendor: Intel Corporation
       physical id: 0
       version: FRU Ver 0.03
       serial: BZUB91703711
     *-firmware
          description: BIOS
          vendor: Intel Corp.
          physical id: 5
          version: S5500.86B.01.00.0038.060120091503
          date: 06/01/2009
          size: 64KiB
          capacity: 8128KiB
          capabilities: pci pnp upgrade shadowing cdboot bootselect edd
int13floppy2880 int5printscreen int9keyboard int14serial int10video acpi usb
ls120boot zipboot netboot
     *-memory
          description: System Memory
          physical id: 21
          slot: System board or motherboard
          size: 24GiB
...

     *-cpu:0
          description: CPU
          product: Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
          vendor: Intel Corp.
          physical id: 3c
          bus info: cpu@0
          version: Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
          slot: CPU1
          size: 2533MHz
          capacity: 4GHz
          width: 64 bits
          clock: 133MHz
...

     *-scsi:0
          physical id: 0
          logical name: scsi0
          capabilities: emulated
        *-disk:0
             description: ATA Disk
             product: ST2000NM0033-9ZM
             vendor: Seagate
             physical id: 0.0.0
             bus info: scsi@0:0.0.0
             logical name: /dev/sda
             version: SN03
             serial: S1X05AEV
             size: 1863GiB (2TB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=5
guid=a95a32bd-3198-4c9b-8445-bac177aa5b31
           *-volume:0
                description: EXT3 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@0:0.0.0,1
                logical name: /dev/sda1
                version: 1.0
                serial: aaa8838f-6792-4491-8ddd-0e0309624e14
                size: 4094MiB
                capacity: 4095MiB
                capabilities: multi precious readonly hidden nomount
journaled large_files recover ext3 ext2 initialized
                configuration: created=2015-08-14 12:12:09 filesystem=ext3
modified=2019-06-13 14:37:43 mounted=2019-06-28 13:46:37 name=ROOT
state=clean
           *-volume:1
                description: Linux RAID partition
                physical id: 2
                bus info: scsi@0:0.0.0,2
                logical name: /dev/sda2
                serial: 4d56a6ce-bd16-4848-ac0e-ee56555c3a4c
                capacity: 1859GiB
                capabilities: multi
                configuration: name=STORAGE
        *-disk:1
             description: ATA Disk
             product: ST2000NM0033-9ZM
             vendor: Seagate
             physical id: 0.1.0
             bus info: scsi@0:0.1.0
             logical name: /dev/sdb
             version: SN03
             serial: S1X05A91
             size: 1863GiB (2TB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=5
guid=a95a32bd-3198-4c9b-8445-bac177aa5b31
           *-volume:0
                description: EXT3 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@0:0.1.0,1
                logical name: /dev/sdb1
                version: 1.0
                serial: aaa8838f-6792-4491-8ddd-0e0309624e14
                size: 4094MiB
                capacity: 4095MiB
                capabilities: multi precious readonly hidden nomount
journaled large_files recover ext3 ext2 initialized
                configuration: created=2015-08-14 12:12:09 filesystem=ext3
modified=2019-06-13 14:37:43 mounted=2019-06-28 13:46:37 name=ROOT
state=clean
           *-volume:1
                description: Linux RAID partition
                physical id: 2
                bus info: scsi@0:0.1.0,2
                logical name: /dev/sdb2
                serial: wjmY2Y-NyBh-RYLr-PgEe-Xu5D-Qj3y-U4Jg4Z
                size: 5565GiB
                capabilities: multi lvm2
                configuration: name=STORAGE
     *-scsi:1
          physical id: 1
          logical name: scsi1
          capabilities: emulated
        *-disk:0
             description: SCSI Disk
             physical id: 0.0.0
             bus info: scsi@1:0.0.0
             logical name: /dev/sdc
             size: 1863GiB (2TB)
        *-disk:1
             description: SCSI Disk
             physical id: 0.1.0
             bus info: scsi@1:0.1.0
             logical name: /dev/sdd
             size: 1863GiB (2TB)
     *-scsi:2
          physical id: 2
          logical name: scsi2
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: ST2000NM0033-9ZM
             vendor: Seagate
             physical id: 0.0.0
             bus info: scsi@2:0.0.0
             logical name: /dev/sde
             version: SN03
             serial: S1Y026RK
             size: 1863GiB (2TB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=5
guid=a95a32bd-3198-4c9b-8445-bac177aa5b31
           *-volume:0
                description: EXT3 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@2:0.0.0,1
                logical name: /dev/sde1
                version: 1.0
                serial: aaa8838f-6792-4491-8ddd-0e0309624e14
                size: 4094MiB
                capacity: 4095MiB
                capabilities: multi precious readonly hidden nomount
journaled large_files recover ext3 ext2 initialized
                configuration: created=2015-08-14 12:12:09 filesystem=ext3
modified=2019-06-13 14:37:43 mounted=2019-06-28 13:46:37 name=ROOT
state=clean
           *-volume:1
                description: Linux RAID partition
                physical id: 2
                bus info: scsi@2:0.0.0,2
                logical name: /dev/sde2
                serial: f54a7e1b-9931-4d31-aa7f-11fd43fd7470
                capacity: 1859GiB
                capabilities: multi
                configuration: name=STORAGE
     *-scsi:3
          physical id: 3
          logical name: scsi3
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: TOSHIBA MG03ACA2
             vendor: Toshiba
             physical id: 0.0.0
             bus info: scsi@3:0.0.0
             logical name: /dev/sdf
             version: FL1A
             serial: Z6O1KVO9F
             size: 1863GiB (2TB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=5
guid=a95a32bd-3198-4c9b-8445-bac177aa5b31
           *-volume:0
                description: EXT3 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@3:0.0.0,1
                logical name: /dev/sdf1
                version: 1.0
                serial: aaa8838f-6792-4491-8ddd-0e0309624e14
                size: 4094MiB
                capacity: 4095MiB
                capabilities: multi precious readonly hidden nomount
journaled large_files recover ext3 ext2 initialized
                configuration: created=2015-08-14 12:12:09 filesystem=ext3
modified=2019-06-13 14:37:43 mounted=2019-06-28 13:46:37 name=ROOT
state=clean
           *-volume:1
                description: Linux RAID partition
                physical id: 2
                bus info: scsi@3:0.0.0,2
                logical name: /dev/sdf2
                serial: e210a350-df27-418b-ae2b-f19d9403266b
                capacity: 1859GiB
                capabilities: multi
                configuration: name=STORAGE




var/log/messages:
...
Sep 19 12:42:41 Xen kernel: [7167427.966305] ata2.00: SRST failed
(errno=-16)
Sep 19 12:42:41 Xen kernel: [7167427.977547] ata2.00: reset failed, giving
up
Sep 19 12:42:41 Xen kernel: [7167427.977551] ata2.00: disabled
Sep 19 12:42:41 Xen kernel: [7167427.977554] ata2.01: disabled
Sep 19 12:42:41 Xen kernel: [7167427.977583] sd 1:0:0:0: [sdc] Unhandled
sense code
Sep 19 12:42:41 Xen kernel: [7167427.977585] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977587] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
Sep 19 12:42:41 Xen kernel: [7167427.977589] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977590] Sense Key : Medium Error
[current] [descriptor]
Sep 19 12:42:41 Xen kernel: [7167427.977593] Descriptor sense data with
sense descriptors (in hex):
Sep 19 12:42:41 Xen kernel: [7167427.977594]         72 03 11 04 00 00 00 0c
00 0a 80 00 00 00 00 00 
Sep 19 12:42:41 Xen kernel: [7167427.977602]         da d6 f5 af 
Sep 19 12:42:41 Xen kernel: [7167427.977605] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977608] Add. Sense: Unrecovered read
error - auto reallocate failed
Sep 19 12:42:41 Xen kernel: [7167427.977610] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977611] Read(10): 28 00 da d6 f5 af 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.977618] end_request: I/O error, dev
sdc, sector 3671520687
Sep 19 12:42:41 Xen kernel: [7167427.977625] md/raid10:md1: sdc2:
rescheduling sector 10989389743
Sep 19 12:42:41 Xen kernel: [7167427.977647] ata2: EH complete
Sep 19 12:42:41 Xen kernel: [7167427.977675] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977677] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977679] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977681] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977682] Read(10): 28 00 da d7 15 df 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.977688] end_request: I/O error, dev
sdc, sector 3671528927
Sep 19 12:42:41 Xen kernel: [7167427.977693] md/raid10:md1: sdc2:
rescheduling sector 10989414367
Sep 19 12:42:41 Xen kernel: [7167427.977712] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977714] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.977715] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977717] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977718] Write(10): 2a 00 da d9 7b 71 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.977724] end_request: I/O error, dev
sdd, sector 3671686001
Sep 19 12:42:41 Xen kernel: [7167427.977739] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977741] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977743] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977744] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977745] Write(10): 2a 00 b7 dd 1d d0 00
00 18 00
Sep 19 12:42:41 Xen kernel: [7167427.977751] end_request: I/O error, dev
sdc, sector 3084721616
Sep 19 12:42:41 Xen kernel: [7167427.977762] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977764] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.977765] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977767] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977768] Write(10): 2a 00 b7 dd 1f d0 00
00 18 00
Sep 19 12:42:41 Xen kernel: [7167427.977774] end_request: I/O error, dev
sdd, sector 3084722128
Sep 19 12:42:41 Xen kernel: [7167427.977793] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977797] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977800] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977805] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977807] Write(10): 2a 00 35 aa d6 98 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.977838] end_request: I/O error, dev
sdc, sector 900388504
Sep 19 12:42:41 Xen kernel: [7167427.977854] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977856] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.977858] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977859] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977860] Write(10): 2a 00 20 f2 fc dc 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.977867] end_request: I/O error, dev
sdd, sector 552795356
Sep 19 12:42:41 Xen kernel: [7167427.977880] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977882] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977883] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977885] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977886] Read(10): 28 00 0b b2 90 00 00
00 58 00
Sep 19 12:42:41 Xen kernel: [7167427.977892] end_request: I/O error, dev
sdc, sector 196251648
Sep 19 12:42:41 Xen kernel: [7167427.977897] md/raid10:md1: sdc2:
rescheduling sector 563583488
Sep 19 12:42:41 Xen kernel: [7167427.977911] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977913] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.977914] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977916] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977917] Write(10): 2a 00 00 34 5f 48 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.977923] end_request: I/O error, dev
sdd, sector 3432264
Sep 19 12:42:41 Xen kernel: [7167427.977934] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977936] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977937] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977939] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977940] Write(10): 2a 00 1a 42 77 50 00
00 40 00
Sep 19 12:42:41 Xen kernel: [7167427.977946] end_request: I/O error, dev
sdc, sector 440563536
Sep 19 12:42:41 Xen kernel: [7167427.977959] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977961] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.977962] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977964] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977965] Write(10): 2a 00 da d9 7b 78 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.977978] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.977980] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.977982] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.977983] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.977985] Write(10): 2a 00 20 f4 4e f0 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.977999] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978001] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.978002] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978004] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978005] Write(10): 2a 00 da dc 55 d8 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.978021] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978023] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978024] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978026] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978027] Write(10): 2a 00 da d9 79 71 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.978042] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978044] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.978045] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978047] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978048] Read(10): 28 00 e0 f7 fc f8 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.978055] md/raid10:md1: sdd2:
rescheduling sector 11297874168
Sep 19 12:42:41 Xen kernel: [7167427.978068] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978069] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978071] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978073] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978074] Write(10): 2a 00 da d9 79 78 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.978089] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978091] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.978092] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978094] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978095] Write(10): 2a 00 da d8 ac e0 00
00 20 00
Sep 19 12:42:41 Xen kernel: [7167427.978111] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978115] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978118] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978121] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978124] Write(10): 2a 00 da d6 d7 78 00
00 20 00
Sep 19 12:42:41 Xen kernel: [7167427.978162] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978166] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.978170] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978176] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978178] Write(10): 2a 00 e1 39 72 b8 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.978227] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978229] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978231] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978233] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978234] Write(10): 2a 00 da d7 42 c0 00
00 20 00
Sep 19 12:42:41 Xen kernel: [7167427.978249] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978252] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.978253] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978255] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978256] Write(10): 2a 00 00 01 e5 00 00
00 60 00
Sep 19 12:42:41 Xen kernel: [7167427.978290] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978292] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978293] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978295] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978296] Write(10): 2a 00 00 34 5f 48 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.978316] md/raid1:md0: Disk failure on
sdc1, disabling device.
Sep 19 12:42:41 Xen kernel: [7167427.978316] md/raid1:md0: Operation
continuing on 5 devices.
Sep 19 12:42:41 Xen kernel: [7167427.978330] md/raid1:md0: Disk failure on
sdd1, disabling device.
Sep 19 12:42:41 Xen kernel: [7167427.978330] md/raid1:md0: Operation
continuing on 4 devices.
Sep 19 12:42:41 Xen kernel: [7167427.978523] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978525] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.978526] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978528] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978529] Write(10): 2a 00 a0 7c ae 38 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.978549] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978551] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978552] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978554] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978555] Write(10): 2a 00 a0 7c ac 38 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.978570] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978572] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978574] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978575] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978576] Write(10): 2a 00 e1 39 70 b8 00
00 10 00
Sep 19 12:42:41 Xen kernel: [7167427.978590] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978592] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978593] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978595] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978596] Write(10): 2a 00 e1 4a e2 d8 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.978617] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978619] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978620] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978622] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978623] Write(10): 2a 00 00 01 e5 00 00
00 60 00
Sep 19 12:42:41 Xen kernel: [7167427.978778] sd 1:0:0:0: [sdc] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.978782] sd 1:0:0:0: [sdc]  
Sep 19 12:42:41 Xen kernel: [7167427.978783] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.978785] sd 1:0:0:0: [sdc] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.978786] Read(10): 28 00 da d6 f5 af 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.986292] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.986294] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.986296] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.986298] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.986299] Read(10): 28 00 da d6 f7 af 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.986326] md/raid10:md1: Disk failure on
sdc2, disabling device.
Sep 19 12:42:41 Xen kernel: [7167427.986326] md/raid10:md1: Operation
continuing on 5 devices.
Sep 19 12:42:41 Xen kernel: [7167427.986341] md/raid10:md1: sdd2:
redirecting sector 10989389743 to another mirror
Sep 19 12:42:41 Xen kernel: [7167427.986429] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.986431] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.986433] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.986435] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.986436] Write(10): 2a 00 e8 e0 88 00 00
00 08 00
Sep 19 12:42:41 Xen kernel: [7167427.986444] md: super_written gets
error=-5, uptodate=0
Sep 19 12:42:41 Xen kernel: [7167427.986446] md/raid10:md1: Disk failure on
sdd2, disabling device.
Sep 19 12:42:41 Xen kernel: [7167427.986446] md/raid10:md1: Operation
continuing on 4 devices.
Sep 19 12:42:41 Xen kernel: [7167427.986458] sd 1:0:1:0: [sdd] Unhandled
error code
Sep 19 12:42:41 Xen kernel: [7167427.986460] sd 1:0:1:0: [sdd]  
Sep 19 12:42:41 Xen kernel: [7167427.986461] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
Sep 19 12:42:41 Xen kernel: [7167427.986463] sd 1:0:1:0: [sdd] CDB: 
Sep 19 12:42:41 Xen kernel: [7167427.986464] Read(10): 28 00 da d6 f7 af 00
00 01 00
Sep 19 12:42:41 Xen kernel: [7167427.986471] md/raid10:md1: sdd2:
rescheduling sector 10989389743
...



-----Original Message-----
From: John Stoffel [mailto:john@stoffel.org] 
Sent: vineri, 20 septembrie 2019 01:53
To: Liviu.Petcu@ugal.ro
Cc: linux-raid@vger.kernel.org
Subject: Re: RAID 10 with 2 failed drives


Liviu> Please let me know if in this situation detailed below, there
Liviu> are chances of restoring the RAID 10 array and how I can do it
Liviu> safely.  Thank you!

It depends.  Do you have either of the two missing disks (/dev/sdc and
/dev/sdd) available at all?  Have you tried doing a badblocks recovery
of either of those disks onto a replacement disk and then trying to
re-assemble your array?

What happens if you do:

  mdadm --assemble --scan

or instead

  mdadm --assemble md99 /dev/sd[abcdef]1

Can you post the output message(s) you get when you try this?

I'm not an export on how the 0.90 version of the metadata mirrors data
across pairs, and then stripes across the pairs.  But if you've lost
both halves of a pair, then you're probably out of luck.

Have you looked at the raid wiki as well?  There's a bunch of good
advice there.

 https://raid.wiki.kernel.org/index.php/Linux_Raid

Good luck!  And post more details of your system as well.

Liviu> Liviu Petcu

Liviu> # mdadm --examine /dev/sd[abcdef]2

Liviu> /dev/sda2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:15 2019
Liviu>           State : active
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e528c455 - correct
Liviu>          Events : 271498

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     5       8        2        5      active sync   /dev/sda2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2
Liviu> /dev/sdb2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:15 2019
Liviu>           State : active
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e528c45b - correct
Liviu>          Events : 271498

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     0       8       18        0      active sync   /dev/sdb2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2
Liviu> /dev/sde2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:16 2019
Liviu>           State : clean
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e52ce91f - correct
Liviu>          Events : 271499

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     3       8       66        3      active sync   /dev/sde2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2
Liviu> /dev/sdf2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:16 2019
Liviu>           State : clean
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e52ce931 - correct
Liviu>          Events : 271499

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     4       8       82        4      active sync   /dev/sdf2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2


