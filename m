Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75894B186C
	for <lists+linux-raid@lfdr.de>; Fri, 13 Sep 2019 08:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfIMGh7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Fri, 13 Sep 2019 02:37:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:12676 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfIMGh7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 13 Sep 2019 02:37:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 23:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="269325082"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2019 23:37:56 -0700
Received: from irsmsx107.ger.corp.intel.com ([169.254.10.7]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.164]) with mapi id 14.03.0439.000;
 Fri, 13 Sep 2019 07:37:56 +0100
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
To:     "David F. " <df7729@gmail.com>
CC:     Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: Linux RAID 1 Not Working
Thread-Topic: Linux RAID 1 Not Working
Thread-Index: AQHVadAZS9lO7uTpZUS8Qrlqyxss76cpF8IA
Date:   Fri, 13 Sep 2019 06:37:55 +0000
Message-ID: <3100213.Shkhs8viAj@mtkaczyk-devel.igk.intel.com>
References: <CAGRSmLvhPOw+KO7yAenXqyLDq__=vSLHMHQJ5f_0iOJ5E5b=Mg@mail.gmail.com>
In-Reply-To: <CAGRSmLvhPOw+KO7yAenXqyLDq__=vSLHMHQJ5f_0iOJ5E5b=Mg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.7.139]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C7C2EA155608243B3B27747F0755D37@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,
Could you provide mdadm --detail-platform output?

> mdadm: No OROM/EFI properties for /dev/sda

Probably Sata controller is in the AHCI mode. Please change it into RAID mode 
in UEFI. 
Mdadm refuses to assemble IMSM raid if it cannot load EFi properties.

If you already have RAID mode, please try mdadm with this fix:
 4ec389e3f0c ("Enable probe_roms to scan more than 6 roms.")

Mariusz


On Friday, September 13, 2019 3:07:32 AM CEST you wrote:
> Hi,
> 
> I sent a message earlier with an attachment but not sure if it went through?
> 
> Basically customer with RAID 1 configuration is not working.
> 
> Here's the information.   How is it fixed?
> 
> Here's part of what was in the attachment that has the mdadm output:
> 
> Running in UEFI mode
> Run date: Wed Sep 11 23:45:58 UTC 2019
> 
> Linux kernel version (uname -a):
> Linux ifl 4.19.67-686-iflnet #1 SMP Tue Aug 20 22:23:39 EDT 2019 i686 n
> 
> Storage devices (non-RAID) detected by Linux based on /sys/block:
> 
> Optical drives (srx):
>   sr0: ATAPI    iHAS124   F      (fw rev = CL9N)
> Removable drives (sdx, mmcblkx, nvmex):
>   sdc: 29328 MiB SanDisk  Ultra
>   sdd: 1440 KiB floppy  Multi    Flash Reader
> Fixed hard drives (sdx, mmcblkx, nvmex):
>   sda: 476 GiB ATA      Samsung SSD 860
>   sdb: 476 GiB ATA      Samsung SSD 860
>   sde: 1863 GiB Seagate  BUP Slim BK
> 
> Contents of /sys/block:
> sda  sdb  sdc  sdd  sde  sr0
> 
> Contents of /dev:
> block               mem                 sdb4                tty16
>          tty41               ttyS0
> bsg                 memory_bandwidth    sdb5                tty17
>          tty42               ttyS1
> btrfs-control       net                 sdc                 tty18
>          tty43               ttyS2
> bus                 network_latency     sdc1                tty19
>          tty44               ttyS3
> cdrom               network_throughput  sdd                 tty2
>          tty45               urandom
> cdrw                null                sde                 tty20
>          tty46               usb
> char                port                sde1                tty21
>          tty47               vcs
> console             ppp                 sg0                 tty22
>          tty48               vcs1
> core                psaux               sg1                 tty23
>          tty49               vcs2
> cpu_dma_latency     ptmx                sg2                 tty24
>          tty5                vcs3
> disk                ptp0                sg3                 tty25
>          tty50               vcs4
> dvd                 pts                 sg4                 tty26
>          tty51               vcs5
> dvdrw               ram0                sg5                 tty27
>          tty52               vcsa
> fb0                 ram1                shm                 tty28
>          tty53               vcsa1
> fd                  random              sr0                 tty29
>          tty54               vcsa2
> full                rfkill              stderr              tty3
>          tty55               vcsa3
> fuse                rtc                 stdin               tty30
>          tty56               vcsa4
> hidraw0             rtc0                stdout              tty31
>          tty57               vcsa5
> hidraw1             sda                 synth               tty32
>          tty58               vcsu
> hpet                sda1                tty                 tty33
>          tty59               vcsu1
> input               sda2                tty0                tty34
>          tty6                vcsu2
> kmsg                sda3                tty1                tty35
>          tty60               vcsu3
> lightnvm            sda4                tty10               tty36
>          tty61               vcsu4
> log                 sda5                tty11               tty37
>          tty62               vcsu5
> loop-control        sdb                 tty12               tty38
>          tty63               vga_arbiter
> loop0               sdb1                tty13               tty39
>          tty7                zero
> loop1               sdb2                tty14               tty4
>          tty8
> mapper              sdb3                tty15               tty40
>          tty9
> 
> Contents of /proc/partitions:
> major minor  #blocks  name
> 
>    8       16  500107608 sdb
>    8       17     541696 sdb1
>    8       18     101376 sdb2
>    8       19      16384 sdb3
>    8       20  250609664 sdb4
>    8       21  248833024 sdb5
>    8        0  500107608 sda
>    8        1     541696 sda1
>    8        2     101376 sda2
>    8        3      16384 sda3
>    8        4  250609664 sda4
>    8        5  248833024 sda5
>   11        0    1048575 sr0
>    8       32   30031872 sdc
>    8       33   30025453 sdc1
>    8       64 1953514583 sde
>    8       65 1953511424 sde1
> 
> Output of 'fdisk -l' (using fdisk v2.25.2 from util-linux for GPT support)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Disk /dev/sdb: 477 GiB, 512110190592 bytes, 1000215216 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> Disk identifier: 91F34BD4-FEBE-4953-BCE9-9788995F4FD3
> 
> Device         Start        End   Sectors   Size Type
> /dev/sdb1       2048    1085439   1083392   529M Windows recovery
> environment /dev/sdb2    1085440    1288191    202752    99M EFI System
> /dev/sdb3    1288192    1320959     32768    16M Microsoft reserved
> /dev/sdb4    1320960  502540287 501219328   239G Microsoft basic data
> /dev/sdb5  502540288 1000206335 497666048 237.3G Microsoft basic data
> 
> Disk /dev/sda: 477 GiB, 512110190592 bytes, 1000215216 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> Disk identifier: 91F34BD4-FEBE-4953-BCE9-9788995F4FD3
> 
> Device         Start        End   Sectors   Size Type
> /dev/sda1       2048    1085439   1083392   529M Windows recovery
> environment /dev/sda2    1085440    1288191    202752    99M EFI System
> /dev/sda3    1288192    1320959     32768    16M Microsoft reserved
> /dev/sda4    1320960  502540287 501219328   239G Microsoft basic data
> /dev/sda5  502540288 1000206335 497666048 237.3G Microsoft basic data
> 
> Disk /dev/sdc: 28.7 GiB, 30752636928 bytes, 60063744 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x5d79bdb5
> 
> Device     Boot Start      End  Sectors  Size Id Type
> /dev/sdc1  *       63 60050969 60050907 28.6G  b W95 FAT32
> 
> Disk /dev/sde: 1.8 TiB, 2000398933504 bytes, 3907029167 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x394a980b
> 
> Device     Boot Start        End    Sectors  Size Id Type
> /dev/sde1        2048 3907024895 3907022848  1.8T  7 HPFS/NTFS/exFAT
> 
> 
> 
> Contents of /proc/mdstat (Linux software RAID status):
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5]
> [raid4] [multipath]
> unused devices: <none>
> 
> Contents of /run/mdadm/map (Linux software RAID arrays):
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Contents of /etc/mdadm/mdadm.conf (Linux software RAID config file):
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> # mdadm.conf
> #
> # Please refer to mdadm.conf(5) for information about this file.
> #
> 
> # by default (built-in), scan all partitions (/proc/partitions) and all
> # containers for MD superblocks. alternatively, specify devices to scan,
> using # wildcards if desired.
> DEVICE partitions containers
> 
> # automatically tag new arrays as belonging to the local system
> HOMEHOST <system>
> 
> ARRAY metadata=imsm UUID=da3f02a5:f8a270ee:39e54f6b:4ff045a5
> ARRAY /dev/md/Volume1 container=da3f02a5:f8a270ee:39e54f6b:4ff045a5
> member=0 UUID=bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
> 
> Contents of /tbu/utility/mdadm.txt (mdadm troubleshooting data
> captured when 'start-md' is executed):
> mdadm - v4.1 - 2018-10-01
> Output of 'mdadm --examine --scan'
> ARRAY metadata=imsm UUID=da3f02a5:f8a270ee:39e54f6b:4ff045a5
> ARRAY /dev/md/Volume1 container=da3f02a5:f8a270ee:39e54f6b:4ff045a5
> member=0 UUID=bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
> Output of 'mdadm --assemble --scan --no-degraded -v'
> mdadm: looking for devices for further assembly
> mdadm: no RAID superblock on /dev/sdc1
> mdadm: /dev/sdc is not attached to Intel(R) RAID controller.
> mdadm: No OROM/EFI properties for /dev/sdc
> mdadm: no RAID superblock on /dev/sdc
> mdadm: cannot open device /dev/sr0: No medium found
> mdadm: no RAID superblock on /dev/sda5
> mdadm: no RAID superblock on /dev/sda4
> mdadm: no RAID superblock on /dev/sda3
> mdadm: no RAID superblock on /dev/sda2
> mdadm: no RAID superblock on /dev/sda1
> mdadm: No OROM/EFI properties for /dev/sda
> mdadm: no RAID superblock on /dev/sda
> mdadm: no RAID superblock on /dev/sdb5
> mdadm: no RAID superblock on /dev/sdb4
> mdadm: no RAID superblock on /dev/sdb3
> mdadm: no RAID superblock on /dev/sdb2
> mdadm: no RAID superblock on /dev/sdb1
> mdadm: No OROM/EFI properties for /dev/sdb
> mdadm: no RAID superblock on /dev/sdb
> mdadm: looking for devices for /dev/md/Volume1
> mdadm: Cannot assemble mbr metadata on /dev/sdc1
> mdadm: Cannot assemble mbr metadata on /dev/sdc
> mdadm: cannot open device /dev/sr0: No medium found
> mdadm: Cannot assemble mbr metadata on /dev/sda5
> mdadm: Cannot assemble mbr metadata on /dev/sda4
> mdadm: no recogniseable superblock on /dev/sda3
> mdadm: Cannot assemble mbr metadata on /dev/sda2
> mdadm: Cannot assemble mbr metadata on /dev/sda1
> mdadm: No OROM/EFI properties for /dev/sda
> mdadm: no RAID superblock on /dev/sda
> mdadm: Cannot assemble mbr metadata on /dev/sdb5
> mdadm: Cannot assemble mbr metadata on /dev/sdb4
> mdadm: no recogniseable superblock on /dev/sdb3
> mdadm: Cannot assemble mbr metadata on /dev/sdb2
> mdadm: Cannot assemble mbr metadata on /dev/sdb1
> mdadm: No OROM/EFI properties for /dev/sdb
> mdadm: no RAID superblock on /dev/sdb
> Output of 'dmesg | grep md:'
> 
> 
> Output of 'mdadm --examine /dev/sda'
> /dev/sda:
>           Magic : Intel Raid ISM Cfg Sig.
>         Version : 1.1.00
>     Orig Family : 513ca085
>          Family : 513ca085
>      Generation : 00016838
>      Attributes : All supported
>            UUID : da3f02a5:f8a270ee:39e54f6b:4ff045a5
>        Checksum : f7229360 correct
>     MPB Sectors : 1
>           Disks : 2
>    RAID Devices : 1
> 
>   Disk00 Serial : S419NE0M501755Z
>           State : active
>              Id : 00000000
>     Usable Size : 1000210432 (476.94 GiB 512.11 GB)
> 
> [Volume1]:
>            UUID : bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
>      RAID Level : 1
>         Members : 2
>           Slots : [UU]
>     Failed disk : none
>       This Slot : 0
>     Sector Size : 512
>      Array Size : 1000210432 (476.94 GiB 512.11 GB)
>    Per Dev Size : 1000210696 (476.94 GiB 512.11 GB)
>   Sector Offset : 0
>     Num Stripes : 3907072
>      Chunk Size : 64 KiB
>        Reserved : 0
>   Migrate State : idle
>       Map State : normal
>     Dirty State : clean
>      RWH Policy : off
> 
>   Disk01 Serial : S419NE0M501557N
>           State : active
>              Id : 00000001
>     Usable Size : 1000210432 (476.94 GiB 512.11 GB)
> 
> 
> Output of 'mdadm --examine /dev/sdb'
> /dev/sdb:
>           Magic : Intel Raid ISM Cfg Sig.
>         Version : 1.1.00
>     Orig Family : 513ca085
>          Family : 513ca085
>      Generation : 00016838
>      Attributes : All supported
>            UUID : da3f02a5:f8a270ee:39e54f6b:4ff045a5
>        Checksum : f7229360 correct
>     MPB Sectors : 1
>           Disks : 2
>    RAID Devices : 1
> 
>   Disk01 Serial : S419NE0M501557N
>           State : active
>              Id : 00000001
>     Usable Size : 1000210432 (476.94 GiB 512.11 GB)
> 
> [Volume1]:
>            UUID : bdbd0dd2:e0957ab7:e6b00192:83cb1fc2
>      RAID Level : 1
>         Members : 2
>           Slots : [UU]
>     Failed disk : none
>       This Slot : 1
>     Sector Size : 512
>      Array Size : 1000210432 (476.94 GiB 512.11 GB)
>    Per Dev Size : 1000210696 (476.94 GiB 512.11 GB)
>   Sector Offset : 0
>     Num Stripes : 3907072
>      Chunk Size : 64 KiB
>        Reserved : 0
>   Migrate State : idle
>       Map State : normal
>     Dirty State : clean
>      RWH Policy : off
> 
>   Disk00 Serial : S419NE0M501755Z
>           State : active
>              Id : 00000000
>     Usable Size : 1000210432 (476.94 GiB 512.11 GB)
> 
> 
> Output of 'mdadm --examine /dev/sdc'
> /dev/sdc:
>    MBR Magic : aa55
> Partition[0] :     60050907 sectors at           63 (type 0b)
> 
> 
> Output of 'mdadm --examine /dev/sdd'
> mdadm: cannot open /dev/sdd: No medium found
> 
> 
> Output of 'mdadm --examine /dev/sde'
> /dev/sde:
>    MBR Magic : aa55
> Partition[0] :   3907022848 sectors at         2048 (type 07)
> 
> 
> Output of 'mdadm --detail /dev/md*', if any:
> mdadm: cannot open /dev/md*: No such file or directory
> 
> Contents of /dev/mapper directory:
> crw------T    1 root     root       10, 236 Sep 11 23:41 control
> 
> startraid mode = null (default)
> 
> Contents of /tbu/utility/dmraid-boot.txt file (from activate command on
> boot): NOTICE: checking format identifier asr
> NOTICE: checking format identifier hpt37x
> NOTICE: checking format identifier hpt45x
> NOTICE: checking format identifier jmicron
> NOTICE: checking format identifier lsi
> NOTICE: checking format identifier nvidia
> NOTICE: checking format identifier pdc
> NOTICE: checking format identifier sil
> NOTICE: checking format identifier via
> NOTICE: checking format identifier dos
> WARN: locking /var/lock/dmraid/.lock
> NOTICE: skipping removable device /dev/sdd
> NOTICE: skipping removable device /dev/sdc
> NOTICE: /dev/sda: asr     discovering
> NOTICE: /dev/sda: hpt37x  discovering
> NOTICE: /dev/sda: hpt45x  discovering
> NOTICE: /dev/sda: jmicron discovering
> NOTICE: /dev/sda: lsi     discovering
> NOTICE: /dev/sda: nvidia  discovering
> NOTICE: /dev/sda: pdc     discovering
> NOTICE: /dev/sda: sil     discovering
> NOTICE: /dev/sda: via     discovering
> NOTICE: /dev/sdb: asr     discovering
> NOTICE: /dev/sdb: hpt37x  discovering
> NOTICE: /dev/sdb: hpt45x  discovering
> NOTICE: /dev/sdb: jmicron discovering
> NOTICE: /dev/sdb: lsi     discovering
> NOTICE: /dev/sdb: nvidia  discovering
> NOTICE: /dev/sdb: pdc     discovering
> NOTICE: /dev/sdb: sil     discovering
> NOTICE: /dev/sdb: via     discovering
> no raid disks with format:
> "asr,hpt37x,hpt45x,jmicron,lsi,nvidia,pdc,sil,via,dos"
> WARN: unlocking /var/lock/dmraid/.lock
> 
> Output of dmraid --raid_devices command:
> /dev/sda: isw, "isw_bdgcjchhej", GROUP, ok, 1000215214 sectors, data@ 0
> /dev/sdb: isw, "isw_bdgcjchhej", GROUP, ok, 1000215214 sectors, data@ 0
> 
> Output of dmraid -s -s command:
> *** Group superset isw_bdgcjchhej
> --> Subset
> name   : isw_bdgcjchhej_Volume1
> size   : 1000210688
> stride : 128
> type   : mirror
> status : ok
> subsets: 0
> devs   : 2
> spares : 0
> 
> Output of blkid command:
> /dev/sdb1: LABEL="Recovery" UUID="565EEF655EEF3BFD" TYPE="ntfs"
> /dev/sdb2: UUID="C4EF-FEDA" TYPE="vfat"
> /dev/sdb4: LABEL="Windows" UUID="16F6F56FF6F54F8B" TYPE="ntfs"
> /dev/sdb5: LABEL="DATA" UUID="E076591C7658F52E" TYPE="ntfs"
> /dev/sda1: LABEL="Recovery" UUID="565EEF655EEF3BFD" TYPE="ntfs"
> /dev/sda2: UUID="C4EF-FEDA" TYPE="vfat"
> /dev/sda4: LABEL="Windows" UUID="16F6F56FF6F54F8B" TYPE="ntfs"
> /dev/sda5: LABEL="DATA" UUID="E076591C7658F52E" TYPE="ntfs"
> /dev/sdc1: LABEL="IFL_3_32" UUID="5D79-BDB5" TYPE="vfat"
> /dev/sde1: LABEL="Seagate Backup Plus Drive" UUID="B6B0C1AFB0C17701"
> TYPE="ntfs"
> 
> Output of 'free -m' command (memory in MiB):
> 
>              total       used       free     shared    buffers     cached
> Mem:          2054        151       1902          0          0        101
> -/+ buffers/cache:         50       2004
> Swap:            0          0          0
> 
> Output of lsmod command (loaded modules):
> 
> Module                  Size  Used by
> hid_generic            16384  0
> usbhid                 28672  0
> hid                    81920  2 hid_generic,usbhid
> usb_storage            40960  0
> e1000e                139264  0
> sg                     28672  0
> video                  32768  0
> backlight              16384  1 video
> ptp                    20480  1 e1000e
> pps_core               16384  1 ptp
> i2c_i801               20480  0
> i2c_core               28672  1 i2c_i801
> evdev                  20480  6
> xhci_pci               16384  0
> pcspkr                 16384  0
> sr_mod                 20480  0
> thermal                16384  0
> cdrom                  28672  1 sr_mod
> sd_mod                 32768  0
> xhci_hcd              102400  1 xhci_pci
> button                 16384  0
> ahci                   32768  0
> libahci                24576  1 ahci
> dm_mod                 81920  0
> dax                    20480  1 dm_mod
> 
> Contents of /sys/module:
> 8250                     fb
> nfs_layout_nfsv41_files  rfkill                   speakup_soft
> acpi                     firmware_class           nfsv4
>     rtc_cmos                 speakup_spkout
> acpiphp                  fscache                  nvme
>     scsi_mod                 speakup_txprt
> ahci                     fuse                     nvme_core
>     scsi_transport_fc        spurious
> auth_rpcgss              hid                      pci_hotplug
>     sd_mod                   sr_mod
> backlight                hid_generic              pcie_aspm
>     sg                       srcutree
> block                    i2c_core                 pciehp
>     speakup                  sunrpc
> button                   i2c_i801                 pcspkr
>     speakup_acntpc           tcp_cubic
> cdrom                    i8042                    pps_core
>     speakup_acntsa           thermal
> cifs                     kernel                   printk
>     speakup_apollo           usb_storage
> cpufreq                  keyboard                 processor
>     speakup_audptr           usbcore
> cpuidle                  libahci                  ptp
>     speakup_bns              usbhid
> cryptomgr                libata                   raid1
>     speakup_decext           video
> dax                      lockd                    raid10
>     speakup_dectlk           vt
> dm_mod                   md_mod                   raid456
>     speakup_dtlk             workqueue
> dns_resolver             module                   random
>     speakup_dummy            xhci_hcd
> e1000e                   mousedev                 rcupdate
>     speakup_keypc            xhci_pci
> evdev                    nfs                      rcutree
>     speakup_ltlk             xz_dec



