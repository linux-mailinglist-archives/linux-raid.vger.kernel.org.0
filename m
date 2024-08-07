Return-Path: <linux-raid+bounces-2317-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E6949C41
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2024 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EE51F24171
	for <lists+linux-raid@lfdr.de>; Tue,  6 Aug 2024 23:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA23175D42;
	Tue,  6 Aug 2024 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b="M4xzMwjI"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061A166315
	for <linux-raid@vger.kernel.org>; Tue,  6 Aug 2024 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986401; cv=none; b=G1xxFxOtlPp3Y9IVWmkbR5pNf+Xy/XGdns0iSaf43J/93JBdFFMlgYEMbMu2OZ3FwWlzLXTq43u9cPoow6ej23saJfGrTBwEoAK4+VnrXwHlKgQ1aD1lFLIfXecOYvEHanTLR/0NVr9sbJZj00G7KVK9Es6WEUUuTNaBqKJy/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986401; c=relaxed/simple;
	bh=YeMMheC8U/QzF2GpVJaCc0GIi5Vp0x9IbYMqIPmzmnA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O8xQ7cV1oxBi7/Er9AZ5iCTsk97yodaSOVJQuIcGUbt6iKcbqMyvNyK7IYd1H4a1CuOt+3Bpj9vBfji7SZw2JpnCOg0mlo/uE2S3oqd5yQZbUHCg39x24jsoRXAbiYxa/e8RYzZaS/iDxoF0UEvloGunYkCV6EZMJ4ZJ/iopktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lambdal.com; spf=pass smtp.mailfrom=lambdal.com; dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b=M4xzMwjI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lambdal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lambdal.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01afa11cso1912299e87.0
        for <linux-raid@vger.kernel.org>; Tue, 06 Aug 2024 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal.com; s=google; t=1722986397; x=1723591197; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1C9GR1H8augMh9Wn4uVCF5NG9bHlHn4r5ltbEOEFLxA=;
        b=M4xzMwjIed6PfVDNM3RSB8SqihZH5Vf3wulLnknmeU1qOVdx2JU61VFexMKLzKImXh
         I1uyZDZ/UpEBa5VJS0wHce+XE1P5yi/PkNzgWXvU+KFXlvbRNUfrbfNyOHTlo3mfenkW
         YMelWJ2k1Wh7Iv8SoAMI4A/vtS2ZwxKm69gq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722986397; x=1723591197;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C9GR1H8augMh9Wn4uVCF5NG9bHlHn4r5ltbEOEFLxA=;
        b=UAmza/Uiz/qC3RadYstkb/+d4P4r+2YOjgv3xrT53Bpx1Lgt0neeK1DyoqBkA+6E5g
         vxCvO9VhfAMflegweM1eKf4yCJcBl+H2hlMnOUblNwwJA5NKJVhxQer+45uvbVAjL5pb
         GONKqKk9xQmvxs/MEkeAHrUq7l4meoHlcPPJ6fVwjF197p2u99AVgnZAjix8E9SmMm98
         Z5m80LvBT1K1FQu8omechvEt532SSxbBArly8AiZSpG8Y0MhjzBIX7tiKbph7svDqD7g
         VwAH8NOQXOSA796BXKEN+YK6g/sblrsuTf43Zml9lJ2ebPxJwMlW8gzEeqBOs5o+xnvy
         mOQg==
X-Gm-Message-State: AOJu0Yy5c9Pgon/cAV518FWsyECPo+/35acSzyIEqLpHMDHq9ZCN1fYv
	rTMZHKUDi+2lzlvkW2o/I8BZMAknq52VdbF6sAq8jsYHpM1MJN0tYYgOrENCCOm7Ped7YOALvn9
	AFhmewtBSr8jD2XRhbzAU7mdGngJPstckgVZjCQdLUv5kViK9oH5Lnw==
X-Google-Smtp-Source: AGHT+IEJmu60YUS+UnFXK4XWfltJmQf5Kc0alDcWpgt9wxoWsmvmQ+z7DODVOKTqZLvqxSyuuH70gKCn0qA3f5jNudA=
X-Received: by 2002:a05:6512:b8d:b0:52e:f367:709b with SMTP id
 2adb3069b0e04-530bb3a34f9mr11483957e87.42.1722986396178; Tue, 06 Aug 2024
 16:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ryan England <ryan.england@lambdal.com>
Date: Tue, 6 Aug 2024 19:19:45 -0400
Message-ID: <CAEWy8SyOXqk+CYu_8HV-R_bRa8WRVYUu_DhU8=RfZevZZGMRHA@mail.gmail.com>
Subject: RAID missing post reboot
To: linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I've been working on a system with a software RAID for the last couple
of weeks. I ran through the process of creating the array as RAID5
using /dev/nvme0n1p1, /dev/nvme1n1p1, and /dev/nvme2n1p1. I then
create the filesystem, update mdadm.conf, and run update-initramfs -u.

The array and file system are created successfully. It's created as
/dev/md127. I mount it to the system and I can write data to it.
/etc/fstab has also been updated.

After rebooting the machine, the system enters Emergency Mode.
Commenting out the newly created device and rebooting the machine
brings it back to Emergency Mode. I can also skip EM by adding the
nofail option to the mount point in /etc/fstab.

Today, I walked through recreating the array. Once created, I ran
mkfs.ext4 again. This time, I noticed that the command found an ext4
file system. To try and repair it, I ran fsck -y against /dev/md127.
The end of the fsck noted that a resize of the inode (re)creation
failed: Inode checksum does not match inode. Mounting failed, so we
made the filesystem again.

It's worth noting that there's NO data on this array at this time.
Hence why we were able to go through with making the filesystem again.
I made sure to gather all of the info noted within the mdadm wiki and
I've included that below. The only thing not included is mdadm
--detail of each of the partitions because the system doesn't
recognize them as being part of an md. Also, md0 hosts the root volume
and isn't a part of the output below.

As far as troubleshooting is concerned, I've tried the following:
1. mdadm --manage /dev/md127 --run
2. echo "clean" > /sys/block/md127/md/array_state & then run command 1
3. mdadm --assemble --force /dev/md127 /dev/nvme0n1p1 /dev/nvme1n1p1
/dev/nvme2n1p1 & then run command 1

I've also poured over logs. Once, I noticed that nvme2n1p1 wasn't
being recognized as a part of the kernel logs. To rule that out as the
issue, I created a RAID1 between nvme0n1p1 & nvme1n1p1. This still
didn't work.

Looking through journalctl -xb, I found an error noting a package that
was missing. The package is named ibblockdev-mdraid2. Installing that
package still didn't help.

Lastly, I included the output of wipefs at the behest of a colleague.
Any support you can provide will be greatly appreciated.

Regards,
Ryan E.


____________________________________________

Start of the mdadm bug report log file.

Date: Tue Aug  6 02:42:59 PM PDT 2024
uname: Linux REDACTED 5.15.0-117-generic #127-Ubuntu SMP Fri Jul 5
20:13:28 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
command line flags:

____________________________________________

mdadm --version

mdadm - v4.2 - 2021-12-30

____________________________________________

cat /proc/mdstat

Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5]
[raid4] [raid10]
md0 : active raid1 sdb2[1] sda2[0] 1874715648 blocks super 1.2 [2/2]
[UU] bitmap: 8/14 pages [32KB], 65536KB chunk unused devices: <none>

____________________________________________

mdadm --examine /dev/nvme0n1p1 /dev/nvme1n1p1 /dev/nvme2n1p1

/dev/nvme0n1p1: MBR Magic : aa55 Partition[0] : 4294967295 sectors at
1 (type ee)
/dev/nvme1n1p1: MBR Magic : aa55 Partition[0] : 4294967295 sectors at
1 (type ee)
/dev/nvme2n1p1: MBR Magic : aa55 Partition[0] : 4294967295 sectors at
1 (type ee)

____________________________________________

mdadm --detail /dev/nvme0n1p1 /dev/nvme1n1p1 /dev/nvme2n1p1

mdadm: /dev/nvme0n1p1 does not appear to be an md device
mdadm: /dev/nvme1n1p1 does not appear to be an md device
mdadm: /dev/nvme2n1p1 does not appear to be an md device

____________________________________________

smartctl --xall /dev/nvme0n1p1

smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.0-117-generic] (local buil=
d)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Number:                       SAMSUNG MZQL23T8HCLS-00A07
Serial Number:                      S64HNS0TC05245
Firmware Version:                   GDC5602Q
PCI Vendor/Subsystem ID:            0x144d
IEEE OUI Identifier:                0x002538
Total NVM Capacity:                 3,840,755,982,336 [3.84 TB]
Unallocated NVM Capacity:           0
Controller ID:                      6
NVMe Version:                       1.4
Number of Namespaces:               32
Namespace 1 Size/Capacity:          3,840,755,982,336 [3.84 TB]
Namespace 1 Utilization:            71,328,116,736 [71.3 GB]
Namespace 1 Formatted LBA Size:     512
Local Time is:                      Tue Aug  6 15:16:08 2024 PDT
Firmware Updates (0x17):            3 Slots, Slot 1 R/O, no Reset required
Optional Admin Commands (0x005f):   Security Format Frmw_DL NS_Mngmt
Self_Test MI_Snd/Rec
Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero
Sav/Sel_Feat Timestmp
Log Page Attributes (0x0e):         Cmd_Eff_Lg Ext_Get_Lg Telmtry_Lg
Maximum Data Transfer Size:         512 Pages
Warning  Comp. Temp. Threshold:     80 Celsius
Critical Comp. Temp. Threshold:     83 Celsius
Namespace 1 Features (0x1a):        NA_Fields No_ID_Reuse NP_Fields

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +    25.00W   14.00W       -    0  0  0  0       70      70
 1 +     8.00W    8.00W       -    1  1  1  1       70      70

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
 0 +     512       0         0
 1 -    4096       0         0

=3D=3D=3D START OF SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        35 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    0%
Data Units Read:                    31,574,989 [16.1 TB]
Data Units Written:                 304,488 [155 GB]
Host Read Commands:                 36,420,064
Host Write Commands:                3,472,342
Controller Busy Time:               63
Power Cycles:                       11
Power On Hours:                     5,582
Unsafe Shutdowns:                   9
Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0
Temperature Sensor 1:               35 Celsius
Temperature Sensor 2:               44 Celsius

Error Information (NVMe Log 0x01, 16 of 64 entries)
No Errors Logged

____________________________________________

smartctl --xall /dev/nvme1n1p1

smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.0-117-generic] (local buil=
d)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Number:                       SAMSUNG MZQL23T8HCLS-00A07
Serial Number:                      S64HNS0TC05241
Firmware Version:                   GDC5602Q
PCI Vendor/Subsystem ID:            0x144d
IEEE OUI Identifier:                0x002538
Total NVM Capacity:                 3,840,755,982,336 [3.84 TB]
Unallocated NVM Capacity:           0
Controller ID:                      6
NVMe Version:                       1.4
Number of Namespaces:               32
Namespace 1 Size/Capacity:          3,840,755,982,336 [3.84 TB]
Namespace 1 Utilization:            71,324,651,520 [71.3 GB]
Namespace 1 Formatted LBA Size:     512
Local Time is:                      Tue Aug  6 15:16:22 2024 PDT
Firmware Updates (0x17):            3 Slots, Slot 1 R/O, no Reset required
Optional Admin Commands (0x005f):   Security Format Frmw_DL NS_Mngmt
Self_Test MI_Snd/Rec
Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero
Sav/Sel_Feat Timestmp
Log Page Attributes (0x0e):         Cmd_Eff_Lg Ext_Get_Lg Telmtry_Lg
Maximum Data Transfer Size:         512 Pages
Warning  Comp. Temp. Threshold:     80 Celsius
Critical Comp. Temp. Threshold:     83 Celsius
Namespace 1 Features (0x1a):        NA_Fields No_ID_Reuse NP_Fields

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +    25.00W   14.00W       -    0  0  0  0       70      70
 1 +     8.00W    8.00W       -    1  1  1  1       70      70

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
 0 +     512       0         0
 1 -    4096       0         0

=3D=3D=3D START OF SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        34 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    0%
Data Units Read:                    24,073,787 [12.3 TB]
Data Units Written:                 7,805,460 [3.99 TB]
Host Read Commands:                 29,506,475
Host Write Commands:                10,354,117
Controller Busy Time:               64
Power Cycles:                       11
Power On Hours:                     5,582
Unsafe Shutdowns:                   9
Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0
Temperature Sensor 1:               34 Celsius
Temperature Sensor 2:               44 Celsius

Error Information (NVMe Log 0x01, 16 of 64 entries)
No Errors Logged

____________________________________________

smartctl --xall /dev/nvme2n1p1

smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.0-117-generic] (local buil=
d)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Number:                       SAMSUNG MZQL23T8HCLS-00A07
Serial Number:                      S64HNS0TC05244
Firmware Version:                   GDC5602Q
PCI Vendor/Subsystem ID:            0x144d
IEEE OUI Identifier:                0x002538
Total NVM Capacity:                 3,840,755,982,336 [3.84 TB]
Unallocated NVM Capacity:           0
Controller ID:                      6
NVMe Version:                       1.4
Number of Namespaces:               32
Namespace 1 Size/Capacity:          3,840,755,982,336 [3.84 TB]
Namespace 1 Utilization:            3,840,514,523,136 [3.84 TB]
Namespace 1 Formatted LBA Size:     512
Local Time is:                      Tue Aug  6 15:16:33 2024 PDT
Firmware Updates (0x17):            3 Slots, Slot 1 R/O, no Reset required
Optional Admin Commands (0x005f):   Security Format Frmw_DL NS_Mngmt
Self_Test MI_Snd/Rec
Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero
Sav/Sel_Feat Timestmp
Log Page Attributes (0x0e):         Cmd_Eff_Lg Ext_Get_Lg Telmtry_Lg
Maximum Data Transfer Size:         512 Pages
Warning  Comp. Temp. Threshold:     80 Celsius
Critical Comp. Temp. Threshold:     83 Celsius
Namespace 1 Features (0x1a):        NA_Fields No_ID_Reuse NP_Fields

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +    25.00W   14.00W       -    0  0  0  0       70      70
 1 +     8.00W    8.00W       -    1  1  1  1       70      70

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
 0 +     512       0         0
 1 -    4096       0         0

=3D=3D=3D START OF SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        33 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    0%
Data Units Read:                    33,340 [17.0 GB]
Data Units Written:                 24,215,921 [12.3 TB]
Host Read Commands:                 812,460
Host Write Commands:                31,463,496
Controller Busy Time:               50
Power Cycles:                       12
Power On Hours:                     5,582
Unsafe Shutdowns:                   9
Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0
Temperature Sensor 1:               33 Celsius
Temperature Sensor 2:               42 Celsius

Error Information (NVMe Log 0x01, 16 of 64 entries)
No Errors Logged

____________________________________________

lsdrv

PCI [nvme] 22:00.0 Non-Volatile memory controller: Samsung Electronics
Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
=E2=94=94nvme nvme0 SAMSUNG MZQL23T8HCLS-00A07               {S64HNS0TC0524=
5}
 =E2=94=94nvme0n1 3.49t [259:0] Partitioned (gpt)
  =E2=94=94nvme0n1p1 3.49t [259:1] Partitioned (gpt)
PCI [nvme] 23:00.0 Non-Volatile memory controller: Samsung Electronics
Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
=E2=94=94nvme nvme1 SAMSUNG MZQL23T8HCLS-00A07               {S64HNS0TC0524=
1}
 =E2=94=94nvme1n1 3.49t [259:2] Partitioned (gpt)
  =E2=94=94nvme1n1p1 3.49t [259:3] Partitioned (gpt)
PCI [nvme] 24:00.0 Non-Volatile memory controller: Samsung Electronics
Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
=E2=94=94nvme nvme2 SAMSUNG MZQL23T8HCLS-00A07               {S64HNS0TC0524=
4}
 =E2=94=94nvme2n1 3.49t [259:4] Partitioned (gpt)
  =E2=94=94nvme2n1p1 3.49t [259:5] Partitioned (gpt)
PCI [ahci] 64:00.0 SATA controller: ASMedia Technology Inc. ASM1062
Serial ATA Controller (rev 02)
=E2=94=9Cscsi 0:0:0:0 ATA      SAMSUNG MZ7L31T9 {S6ESNS0W416204}
=E2=94=82=E2=94=94sda 1.75t [8:0] Partitioned (gpt)
=E2=94=82 =E2=94=9Csda1 512.00m [8:1] vfat {B0FD-2869}
=E2=94=82 =E2=94=82=E2=94=94Mounted as /dev/sda1 @ /boot/efi
=E2=94=82 =E2=94=94sda2 1.75t [8:2] MD raid1 (0/2) (w/ sdb2) in_sync 'ubunt=
u-server:0'
{2bcfa20a-e221-299c-d3e6-f4cf8124e265}
=E2=94=82  =E2=94=94md0 1.75t [9:0] MD v1.2 raid1 (2) active
{2bcfa20a:-e221-29:9c-d3e6-:f4cf8124e265}
=E2=94=82   =E2=94=82               Partitioned (gpt)
=E2=94=82   =E2=94=94md0p1 1.75t [259:6] ext4 {81b5ccee-9c72-4cac-8579-3b96=
27a8c1b6}
=E2=94=82    =E2=94=94Mounted as /dev/md0p1 @ /
=E2=94=94scsi 1:0:0:0 ATA      SAMSUNG MZ7L31T9 {S6ESNS0W416208}
 =E2=94=94sdb 1.75t [8:16] Partitioned (gpt)
  =E2=94=9Csdb1 512.00m [8:17] vfat {B11F-39A7}
  =E2=94=94sdb2 1.75t [8:18] MD raid1 (1/2) (w/ sda2) in_sync
'ubuntu-server:0' {2bcfa20a-e221-299c-d3e6-f4cf8124e265}
   =E2=94=94md0 1.75t [9:0] MD v1.2 raid1 (2) active
{2bcfa20a:-e221-29:9c-d3e6-:f4cf8124e265}
                    Partitioned (gpt)
PCI [ahci] 66:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD]
FCH SATA Controller [AHCI mode] (rev 91)
=E2=94=94scsi 2:x:x:x [Empty]
PCI [ahci] 66:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD]
FCH SATA Controller [AHCI mode] (rev 91)
=E2=94=94scsi 10:x:x:x [Empty]
PCI [ahci] 04:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD]
FCH SATA Controller [AHCI mode] (rev 91)
=E2=94=94scsi 18:x:x:x [Empty]
PCI [ahci] 04:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD]
FCH SATA Controller [AHCI mode] (rev 91)
=E2=94=94scsi 26:x:x:x [Empty]
Other Block Devices
=E2=94=9Cloop0 0.00k [7:0] Empty/Unknown
=E2=94=9Cloop1 0.00k [7:1] Empty/Unknown
=E2=94=9Cloop2 0.00k [7:2] Empty/Unknown
=E2=94=9Cloop3 0.00k [7:3] Empty/Unknown
=E2=94=9Cloop4 0.00k [7:4] Empty/Unknown
=E2=94=9Cloop5 0.00k [7:5] Empty/Unknown
=E2=94=9Cloop6 0.00k [7:6] Empty/Unknown
=E2=94=94loop7 0.00k [7:7] Empty/Unknown

____________________________________________

wipefs /dev/nvme0n1p1

DEVICE    OFFSET        TYPE UUID LABEL
nvme0n1p1 0x200         gpt
nvme0n1p1 0x37e38900000 gpt
nvme0n1p1 0x1fe         PMBR

____________________________________________

wipefs /dev/nvme1n1p1

DEVICE    OFFSET        TYPE UUID LABEL
nvme1n1p1 0x200         gpt
nvme1n1p1 0x37e38900000 gpt
nvme1n1p1 0x1fe         PMBR

____________________________________________

wipefs /dev/nvme2n1p1

DEVICE    OFFSET        TYPE UUID LABEL
nvme2n1p1 0x200         gpt
nvme2n1p1 0x37e38900000 gpt
nvme2n1p1 0x1fe         PMBR

