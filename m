Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C622B16EE
	for <lists+linux-raid@lfdr.de>; Fri, 13 Sep 2019 03:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfIMBH4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Sep 2019 21:07:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38321 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfIMBH4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Sep 2019 21:07:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so30282300wrx.5
        for <linux-raid@vger.kernel.org>; Thu, 12 Sep 2019 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VksJ1t50PTxB4ixp4MIDvwFuLqpMTYBO1eHreV5QlKE=;
        b=htpziT4dNIicpvkbC3PG9n65ifV08AfuV81Z58TN5zVSifZtLO2jo1kMGl3cSRXUsw
         xGrqvELcDvHJFX9pNuiaQMhbtwdapo38b33/ofRNhd772SlRpHmXPm0X2YmAsmxTyM9a
         edJU4jUPi0E8ucGFLsSk6G/sEmr5vtDEADlSvE+B1bKab7TaIW7s/VNpYZPIwX1IGWCt
         Rhl/+WzL8SV159eGkYBIcToMuFlLstI5F6fmMjgmE+1v951DBr6OHPZuI55td+ntQFl8
         lZ6d9gm90ZHQUe0iLjiqK+nNrXJHz5e+A/BVHDFXxspR39YEApwAwhC/K15PHpDxdjoA
         UxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VksJ1t50PTxB4ixp4MIDvwFuLqpMTYBO1eHreV5QlKE=;
        b=rkRSkt/HXWbjjrvI/AzIpJd0fy58q+kW7sQs+qI9GHm8SUhNe4qTpXDuG7ibebH9Pt
         Wgtghn0DPwEN6q9QysLeWyQ6R82iqv+9Sw2gpZvPdfmDHVspFAcDTRxftPV7pOTZIi+2
         TNb13eyOHKh4G3G1AkI8WAmRq6TLG/qvw5XjI1+txWKwFD8RcjwMTaSOcaeiMCT+IXFg
         i+1m4ojLdFli7yqcj8H8kSxqor0myGFWxheWey1jTdNO8aq3FiDvwoHHhDShavxjaPUx
         vlJYZBhdQSbQ6TZlqD8pMl8L/g74YN/8miqg8aRRwaTkA6UNGfjxpXIIbyXmf2rdTHsW
         r2ig==
X-Gm-Message-State: APjAAAVZOFUWqrWrOO1dT0r59Bq5yfvaXgP7fZk7KaVUBl36ROVL+xPn
        /DH0OI2ZOqtBvkFuru6LFLfMq03bWFA06QteT7Cmw0QR
X-Google-Smtp-Source: APXvYqyvik7uYYXwceB0fAU+0J0lHf1Pi8NzcjiCNJkaakdlR3vBMeWodH/vYbjO/4F2W+cJHi/c5gusRKctqebV+/E=
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr17202867wrn.54.1568336869840;
 Thu, 12 Sep 2019 18:07:49 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Thu, 12 Sep 2019 18:07:32 -0700
Message-ID: <CAGRSmLvhPOw+KO7yAenXqyLDq__=vSLHMHQJ5f_0iOJ5E5b=Mg@mail.gmail.com>
Subject: Linux RAID 1 Not Working
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I sent a message earlier with an attachment but not sure if it went through?

Basically customer with RAID 1 configuration is not working.

Here's the information.   How is it fixed?

Here's part of what was in the attachment that has the mdadm output:

Running in UEFI mode
Run date: Wed Sep 11 23:45:58 UTC 2019

Linux kernel version (uname -a):
Linux ifl 4.19.67-686-iflnet #1 SMP Tue Aug 20 22:23:39 EDT 2019 i686 n

Storage devices (non-RAID) detected by Linux based on /sys/block:

Optical drives (srx):
  sr0: ATAPI    iHAS124   F      (fw rev = CL9N)
Removable drives (sdx, mmcblkx, nvmex):
  sdc: 29328 MiB SanDisk  Ultra
  sdd: 1440 KiB floppy  Multi    Flash Reader
Fixed hard drives (sdx, mmcblkx, nvmex):
  sda: 476 GiB ATA      Samsung SSD 860
  sdb: 476 GiB ATA      Samsung SSD 860
  sde: 1863 GiB Seagate  BUP Slim BK

Contents of /sys/block:
sda  sdb  sdc  sdd  sde  sr0

Contents of /dev:
block               mem                 sdb4                tty16
         tty41               ttyS0
bsg                 memory_bandwidth    sdb5                tty17
         tty42               ttyS1
btrfs-control       net                 sdc                 tty18
         tty43               ttyS2
bus                 network_latency     sdc1                tty19
         tty44               ttyS3
cdrom               network_throughput  sdd                 tty2
         tty45               urandom
cdrw                null                sde                 tty20
         tty46               usb
char                port                sde1                tty21
         tty47               vcs
console             ppp                 sg0                 tty22
         tty48               vcs1
core                psaux               sg1                 tty23
         tty49               vcs2
cpu_dma_latency     ptmx                sg2                 tty24
         tty5                vcs3
disk                ptp0                sg3                 tty25
         tty50               vcs4
dvd                 pts                 sg4                 tty26
         tty51               vcs5
dvdrw               ram0                sg5                 tty27
         tty52               vcsa
fb0                 ram1                shm                 tty28
         tty53               vcsa1
fd                  random              sr0                 tty29
         tty54               vcsa2
full                rfkill              stderr              tty3
         tty55               vcsa3
fuse                rtc                 stdin               tty30
         tty56               vcsa4
hidraw0             rtc0                stdout              tty31
         tty57               vcsa5
hidraw1             sda                 synth               tty32
         tty58               vcsu
hpet                sda1                tty                 tty33
         tty59               vcsu1
input               sda2                tty0                tty34
         tty6                vcsu2
kmsg                sda3                tty1                tty35
         tty60               vcsu3
lightnvm            sda4                tty10               tty36
         tty61               vcsu4
log                 sda5                tty11               tty37
         tty62               vcsu5
loop-control        sdb                 tty12               tty38
         tty63               vga_arbiter
loop0               sdb1                tty13               tty39
         tty7                zero
loop1               sdb2                tty14               tty4
         tty8
mapper              sdb3                tty15               tty40
         tty9

Contents of /proc/partitions:
major minor  #blocks  name

   8       16  500107608 sdb
   8       17     541696 sdb1
   8       18     101376 sdb2
   8       19      16384 sdb3
   8       20  250609664 sdb4
   8       21  248833024 sdb5
   8        0  500107608 sda
   8        1     541696 sda1
   8        2     101376 sda2
   8        3      16384 sda3
   8        4  250609664 sda4
   8        5  248833024 sda5
  11        0    1048575 sr0
   8       32   30031872 sdc
   8       33   30025453 sdc1
   8       64 1953514583 sde
   8       65 1953511424 sde1

Output of 'fdisk -l' (using fdisk v2.25.2 from util-linux for GPT support)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Disk /dev/sdb: 477 GiB, 512110190592 bytes, 1000215216 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 91F34BD4-FEBE-4953-BCE9-9788995F4FD3

Device         Start        End   Sectors   Size Type
/dev/sdb1       2048    1085439   1083392   529M Windows recovery environment
/dev/sdb2    1085440    1288191    202752    99M EFI System
/dev/sdb3    1288192    1320959     32768    16M Microsoft reserved
/dev/sdb4    1320960  502540287 501219328   239G Microsoft basic data
/dev/sdb5  502540288 1000206335 497666048 237.3G Microsoft basic data

Disk /dev/sda: 477 GiB, 512110190592 bytes, 1000215216 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 91F34BD4-FEBE-4953-BCE9-9788995F4FD3

Device         Start        End   Sectors   Size Type
/dev/sda1       2048    1085439   1083392   529M Windows recovery environment
/dev/sda2    1085440    1288191    202752    99M EFI System
/dev/sda3    1288192    1320959     32768    16M Microsoft reserved
/dev/sda4    1320960  502540287 501219328   239G Microsoft basic data
/dev/sda5  502540288 1000206335 497666048 237.3G Microsoft basic data

Disk /dev/sdc: 28.7 GiB, 30752636928 bytes, 60063744 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x5d79bdb5

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdc1  *       63 60050969 60050907 28.6G  b W95 FAT32

Disk /dev/sde: 1.8 TiB, 2000398933504 bytes, 3907029167 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x394a980b

Device     Boot Start        End    Sectors  Size Id Type
/dev/sde1        2048 3907024895 3907022848  1.8T  7 HPFS/NTFS/exFAT



Contents of /proc/mdstat (Linux software RAID status):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5]
[raid4] [multipath]
unused devices: <none>

Contents of /run/mdadm/map (Linux software RAID arrays):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Contents of /etc/mdadm/mdadm.conf (Linux software RAID config file):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# mdadm.conf
#
# Please refer to mdadm.conf(5) for information about this file.
#

# by default (built-in), scan all partitions (/proc/partitions) and all
# containers for MD superblocks. alternatively, specify devices to scan, using
# wildcards if desired.
DEVICE partitions containers

# automatically tag new arrays as belonging to the local system
HOMEHOST <system>

ARRAY metadata=imsm UUID=da3f02a5:f8a270ee:39e54f6b:4ff045a5
ARRAY /dev/md/Volume1 container=da3f02a5:f8a270ee:39e54f6b:4ff045a5
member=0 UUID=bdbd0dd2:e0957ab7:e6b00192:83cb1fc2

Contents of /tbu/utility/mdadm.txt (mdadm troubleshooting data
captured when 'start-md' is executed):
mdadm - v4.1 - 2018-10-01
Output of 'mdadm --examine --scan'
ARRAY metadata=imsm UUID=da3f02a5:f8a270ee:39e54f6b:4ff045a5
ARRAY /dev/md/Volume1 container=da3f02a5:f8a270ee:39e54f6b:4ff045a5
member=0 UUID=bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
Output of 'mdadm --assemble --scan --no-degraded -v'
mdadm: looking for devices for further assembly
mdadm: no RAID superblock on /dev/sdc1
mdadm: /dev/sdc is not attached to Intel(R) RAID controller.
mdadm: No OROM/EFI properties for /dev/sdc
mdadm: no RAID superblock on /dev/sdc
mdadm: cannot open device /dev/sr0: No medium found
mdadm: no RAID superblock on /dev/sda5
mdadm: no RAID superblock on /dev/sda4
mdadm: no RAID superblock on /dev/sda3
mdadm: no RAID superblock on /dev/sda2
mdadm: no RAID superblock on /dev/sda1
mdadm: No OROM/EFI properties for /dev/sda
mdadm: no RAID superblock on /dev/sda
mdadm: no RAID superblock on /dev/sdb5
mdadm: no RAID superblock on /dev/sdb4
mdadm: no RAID superblock on /dev/sdb3
mdadm: no RAID superblock on /dev/sdb2
mdadm: no RAID superblock on /dev/sdb1
mdadm: No OROM/EFI properties for /dev/sdb
mdadm: no RAID superblock on /dev/sdb
mdadm: looking for devices for /dev/md/Volume1
mdadm: Cannot assemble mbr metadata on /dev/sdc1
mdadm: Cannot assemble mbr metadata on /dev/sdc
mdadm: cannot open device /dev/sr0: No medium found
mdadm: Cannot assemble mbr metadata on /dev/sda5
mdadm: Cannot assemble mbr metadata on /dev/sda4
mdadm: no recogniseable superblock on /dev/sda3
mdadm: Cannot assemble mbr metadata on /dev/sda2
mdadm: Cannot assemble mbr metadata on /dev/sda1
mdadm: No OROM/EFI properties for /dev/sda
mdadm: no RAID superblock on /dev/sda
mdadm: Cannot assemble mbr metadata on /dev/sdb5
mdadm: Cannot assemble mbr metadata on /dev/sdb4
mdadm: no recogniseable superblock on /dev/sdb3
mdadm: Cannot assemble mbr metadata on /dev/sdb2
mdadm: Cannot assemble mbr metadata on /dev/sdb1
mdadm: No OROM/EFI properties for /dev/sdb
mdadm: no RAID superblock on /dev/sdb
Output of 'dmesg | grep md:'


Output of 'mdadm --examine /dev/sda'
/dev/sda:
          Magic : Intel Raid ISM Cfg Sig.
        Version : 1.1.00
    Orig Family : 513ca085
         Family : 513ca085
     Generation : 00016838
     Attributes : All supported
           UUID : da3f02a5:f8a270ee:39e54f6b:4ff045a5
       Checksum : f7229360 correct
    MPB Sectors : 1
          Disks : 2
   RAID Devices : 1

  Disk00 Serial : S419NE0M501755Z
          State : active
             Id : 00000000
    Usable Size : 1000210432 (476.94 GiB 512.11 GB)

[Volume1]:
           UUID : bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
     RAID Level : 1
        Members : 2
          Slots : [UU]
    Failed disk : none
      This Slot : 0
    Sector Size : 512
     Array Size : 1000210432 (476.94 GiB 512.11 GB)
   Per Dev Size : 1000210696 (476.94 GiB 512.11 GB)
  Sector Offset : 0
    Num Stripes : 3907072
     Chunk Size : 64 KiB
       Reserved : 0
  Migrate State : idle
      Map State : normal
    Dirty State : clean
     RWH Policy : off

  Disk01 Serial : S419NE0M501557N
          State : active
             Id : 00000001
    Usable Size : 1000210432 (476.94 GiB 512.11 GB)


Output of 'mdadm --examine /dev/sdb'
/dev/sdb:
          Magic : Intel Raid ISM Cfg Sig.
        Version : 1.1.00
    Orig Family : 513ca085
         Family : 513ca085
     Generation : 00016838
     Attributes : All supported
           UUID : da3f02a5:f8a270ee:39e54f6b:4ff045a5
       Checksum : f7229360 correct
    MPB Sectors : 1
          Disks : 2
   RAID Devices : 1

  Disk01 Serial : S419NE0M501557N
          State : active
             Id : 00000001
    Usable Size : 1000210432 (476.94 GiB 512.11 GB)

[Volume1]:
           UUID : bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
     RAID Level : 1
        Members : 2
          Slots : [UU]
    Failed disk : none
      This Slot : 1
    Sector Size : 512
     Array Size : 1000210432 (476.94 GiB 512.11 GB)
   Per Dev Size : 1000210696 (476.94 GiB 512.11 GB)
  Sector Offset : 0
    Num Stripes : 3907072
     Chunk Size : 64 KiB
       Reserved : 0
  Migrate State : idle
      Map State : normal
    Dirty State : clean
     RWH Policy : off

  Disk00 Serial : S419NE0M501755Z
          State : active
             Id : 00000000
    Usable Size : 1000210432 (476.94 GiB 512.11 GB)


Output of 'mdadm --examine /dev/sdc'
/dev/sdc:
   MBR Magic : aa55
Partition[0] :     60050907 sectors at           63 (type 0b)


Output of 'mdadm --examine /dev/sdd'
mdadm: cannot open /dev/sdd: No medium found


Output of 'mdadm --examine /dev/sde'
/dev/sde:
   MBR Magic : aa55
Partition[0] :   3907022848 sectors at         2048 (type 07)


Output of 'mdadm --detail /dev/md*', if any:
mdadm: cannot open /dev/md*: No such file or directory

Contents of /dev/mapper directory:
crw------T    1 root     root       10, 236 Sep 11 23:41 control

startraid mode = null (default)

Contents of /tbu/utility/dmraid-boot.txt file (from activate command on boot):
NOTICE: checking format identifier asr
NOTICE: checking format identifier hpt37x
NOTICE: checking format identifier hpt45x
NOTICE: checking format identifier jmicron
NOTICE: checking format identifier lsi
NOTICE: checking format identifier nvidia
NOTICE: checking format identifier pdc
NOTICE: checking format identifier sil
NOTICE: checking format identifier via
NOTICE: checking format identifier dos
WARN: locking /var/lock/dmraid/.lock
NOTICE: skipping removable device /dev/sdd
NOTICE: skipping removable device /dev/sdc
NOTICE: /dev/sda: asr     discovering
NOTICE: /dev/sda: hpt37x  discovering
NOTICE: /dev/sda: hpt45x  discovering
NOTICE: /dev/sda: jmicron discovering
NOTICE: /dev/sda: lsi     discovering
NOTICE: /dev/sda: nvidia  discovering
NOTICE: /dev/sda: pdc     discovering
NOTICE: /dev/sda: sil     discovering
NOTICE: /dev/sda: via     discovering
NOTICE: /dev/sdb: asr     discovering
NOTICE: /dev/sdb: hpt37x  discovering
NOTICE: /dev/sdb: hpt45x  discovering
NOTICE: /dev/sdb: jmicron discovering
NOTICE: /dev/sdb: lsi     discovering
NOTICE: /dev/sdb: nvidia  discovering
NOTICE: /dev/sdb: pdc     discovering
NOTICE: /dev/sdb: sil     discovering
NOTICE: /dev/sdb: via     discovering
no raid disks with format:
"asr,hpt37x,hpt45x,jmicron,lsi,nvidia,pdc,sil,via,dos"
WARN: unlocking /var/lock/dmraid/.lock

Output of dmraid --raid_devices command:
/dev/sda: isw, "isw_bdgcjchhej", GROUP, ok, 1000215214 sectors, data@ 0
/dev/sdb: isw, "isw_bdgcjchhej", GROUP, ok, 1000215214 sectors, data@ 0

Output of dmraid -s -s command:
*** Group superset isw_bdgcjchhej
--> Subset
name   : isw_bdgcjchhej_Volume1
size   : 1000210688
stride : 128
type   : mirror
status : ok
subsets: 0
devs   : 2
spares : 0

Output of blkid command:
/dev/sdb1: LABEL="Recovery" UUID="565EEF655EEF3BFD" TYPE="ntfs"
/dev/sdb2: UUID="C4EF-FEDA" TYPE="vfat"
/dev/sdb4: LABEL="Windows" UUID="16F6F56FF6F54F8B" TYPE="ntfs"
/dev/sdb5: LABEL="DATA" UUID="E076591C7658F52E" TYPE="ntfs"
/dev/sda1: LABEL="Recovery" UUID="565EEF655EEF3BFD" TYPE="ntfs"
/dev/sda2: UUID="C4EF-FEDA" TYPE="vfat"
/dev/sda4: LABEL="Windows" UUID="16F6F56FF6F54F8B" TYPE="ntfs"
/dev/sda5: LABEL="DATA" UUID="E076591C7658F52E" TYPE="ntfs"
/dev/sdc1: LABEL="IFL_3_32" UUID="5D79-BDB5" TYPE="vfat"
/dev/sde1: LABEL="Seagate Backup Plus Drive" UUID="B6B0C1AFB0C17701" TYPE="ntfs"

Output of 'free -m' command (memory in MiB):

             total       used       free     shared    buffers     cached
Mem:          2054        151       1902          0          0        101
-/+ buffers/cache:         50       2004
Swap:            0          0          0

Output of lsmod command (loaded modules):

Module                  Size  Used by
hid_generic            16384  0
usbhid                 28672  0
hid                    81920  2 hid_generic,usbhid
usb_storage            40960  0
e1000e                139264  0
sg                     28672  0
video                  32768  0
backlight              16384  1 video
ptp                    20480  1 e1000e
pps_core               16384  1 ptp
i2c_i801               20480  0
i2c_core               28672  1 i2c_i801
evdev                  20480  6
xhci_pci               16384  0
pcspkr                 16384  0
sr_mod                 20480  0
thermal                16384  0
cdrom                  28672  1 sr_mod
sd_mod                 32768  0
xhci_hcd              102400  1 xhci_pci
button                 16384  0
ahci                   32768  0
libahci                24576  1 ahci
dm_mod                 81920  0
dax                    20480  1 dm_mod

Contents of /sys/module:
8250                     fb
nfs_layout_nfsv41_files  rfkill                   speakup_soft
acpi                     firmware_class           nfsv4
    rtc_cmos                 speakup_spkout
acpiphp                  fscache                  nvme
    scsi_mod                 speakup_txprt
ahci                     fuse                     nvme_core
    scsi_transport_fc        spurious
auth_rpcgss              hid                      pci_hotplug
    sd_mod                   sr_mod
backlight                hid_generic              pcie_aspm
    sg                       srcutree
block                    i2c_core                 pciehp
    speakup                  sunrpc
button                   i2c_i801                 pcspkr
    speakup_acntpc           tcp_cubic
cdrom                    i8042                    pps_core
    speakup_acntsa           thermal
cifs                     kernel                   printk
    speakup_apollo           usb_storage
cpufreq                  keyboard                 processor
    speakup_audptr           usbcore
cpuidle                  libahci                  ptp
    speakup_bns              usbhid
cryptomgr                libata                   raid1
    speakup_decext           video
dax                      lockd                    raid10
    speakup_dectlk           vt
dm_mod                   md_mod                   raid456
    speakup_dtlk             workqueue
dns_resolver             module                   random
    speakup_dummy            xhci_hcd
e1000e                   mousedev                 rcupdate
    speakup_keypc            xhci_pci
evdev                    nfs                      rcutree
    speakup_ltlk             xz_dec
