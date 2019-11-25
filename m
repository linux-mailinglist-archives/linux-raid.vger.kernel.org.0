Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25C9108640
	for <lists+linux-raid@lfdr.de>; Mon, 25 Nov 2019 02:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKYBTF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 24 Nov 2019 20:19:05 -0500
Received: from mail.iankelling.org ([72.14.176.105]:38778 "EHLO
        mail.iankelling.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKYBTF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 24 Nov 2019 20:19:05 -0500
X-Greylist: delayed 2552 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Nov 2019 20:19:04 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iankelling.org; s=li; h=MIME-Version:Date:In-reply-to:to:Subject:From:
        References; bh=SCdKBgLsaWlwlOOHB073iusmXjaiNl0jmbNgx5DTgpY=; b=q9dyolNPmF9GrG
        QKht+vcy1mShW/FxOK9DGSSRdh424tjfPiN+nmYrcF5S36LkkX4UHmzUlzHeKph2FUhUXz95Z8bD/
        hfgdCOtb7QPS7mrUNL4RvTXv+TOkQx0woKbJ1tPshkeqV4E5dURD8WBlUo5F93wcx5tb98yaurehm
        gi7iPQlTkTQhoOSPIooDo7bbH7qSejZ/qWexJSWZPN7mDjEaTOM9KPJ+gOWnSN4pPaKwiz10wu8UK
        4x7xk+E0r+eE2zjD1Zd1oyTrQbq2EOKS+touaXminNOwUbbwhFkpJ3xdZtVdcBtVcZnzI2ukQTA9y
        aa00Uar221diypiza9Hw==;
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
        (envelope-from <ian@iankelling.org>)
        id 1iZ2Mi-00039D-A7
        for linux-raid@vger.kernel.org; Sun, 24 Nov 2019 19:36:32 -0500
References: <3fc5f3df-0589-645c-f36a-2eee83e8bccd () gnu ! org>
User-agent: mu4e 1.1.0; emacs 27.0.50
From:   Ian Kelling <ian@iankelling.org>
Subject: Re: Deep into potential data loss issue
to:     linux-raid@vger.kernel.org
In-reply-to: <3fc5f3df-0589-645c-f36a-2eee83e8bccd@gnu.org>
Date:   Sun, 24 Nov 2019 19:36:32 -0500
Message-ID: <877e3ozt9r.fsf@iankelling.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I work with andrew. Here is some additional info. We tried assembling
from within a vm using trisquel 9 (based on ubuntu 18.04), to have a
newer mdadm, then got a kernel panic in the host and rebooted.

Nov 24 17:54:25 xenhost0 kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
Nov 24 17:54:25 xenhost0 kernel: IP: [<ffffffff815c68c1>] remove_and_add_spares+0x111/0x290
Nov 24 17:54:25 xenhost0 kernel: PGD ccd474067 PUD cd2fec067 PMD 0 
Nov 24 17:54:25 xenhost0 kernel: Oops: 0000 [#1] SMP 
Nov 24 17:54:25 xenhost0 kernel: Modules linked in: xt_multiport xen_gntdev xen_evtchn xenfs xen_privcmd ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle xt_tcpudp ip6table_filter ip6_tables iptable_filter ip_tables ebtable_nat ebtables x_tables bridge stp llc dm_crypt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel dm_multipath scsi_dh serio_raw joydev amd64_edac_mod edac_core fam15h_power k10temp edac_mce_amd i2c_piix4 mac_hid nfsd lp shpchp parport auth_rpcgss nfs_acl nfs lockd sunrpc fscache btrfs libcrc32c raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid0 multipath linear dm_mirror dm_region_hash dm_log raid1 raid10 pata_acpi hid_generic usbhid hid aesni_intel aes_x86_64 glue_helper
Nov 24 17:54:25 xenhost0 kernel:  lrw gf128mul ablk_helper cryptd psmouse igb dca ptp ahci pata_atiixp pps_core libahci i2c_algo_bit
Nov 24 17:54:25 xenhost0 kernel: CPU: 10 PID: 8573 Comm: mdadm Not tainted 3.13.0-149-generic #199+7.0trisquel3
Nov 24 17:54:25 xenhost0 kernel: Hardware name: Supermicro H8DG6/H8DGi/H8DG6/H8DGi, BIOS 3.0        09/10/2012
Nov 24 17:54:25 xenhost0 kernel: task: ffff880f82e3c800 ti: ffff88008da22000 task.ti: ffff88008da22000
Nov 24 17:54:25 xenhost0 kernel: RIP: e030:[<ffffffff815c68c1>]  [<ffffffff815c68c1>] remove_and_add_spares+0x111/0x290
Nov 24 17:54:25 xenhost0 kernel: RSP: e02b:ffff88008da23d50  EFLAGS: 00010246
Nov 24 17:54:25 xenhost0 kernel: RAX: 0000000000000000 RBX: ffff880003199800 RCX: ffff880f82a23000
Nov 24 17:54:25 xenhost0 kernel: RDX: 0000000000800032 RSI: ffff880003199800 RDI: ffff880f82a23000
Nov 24 17:54:25 xenhost0 kernel: RBP: ffff88008da23da0 R08: 0000000000000000 R09: 0000000000000922
Nov 24 17:54:25 xenhost0 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: ffff880f82a23018
Nov 24 17:54:25 xenhost0 kernel: R13: ffff880003199800 R14: ffff880f82a23000 R15: ffff880f82a23050
Nov 24 17:54:25 xenhost0 kernel: FS:  00007fa00ffef740(0000) GS:ffff880fea140000(0000) knlGS:0000000000000000
Nov 24 17:54:25 xenhost0 kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
Nov 24 17:54:25 xenhost0 kernel: CR2: 0000000000000058 CR3: 00000009e2fb2000 CR4: 0000000000040660
Nov 24 17:54:25 xenhost0 kernel: Stack:
Nov 24 17:54:25 xenhost0 kernel:  0000000082a23000 0000000000000832 ffff880bf6992000 ffff88008da23d78
Nov 24 17:54:25 xenhost0 kernel:  000000003a07e6ae 0000000000000000 ffff880003199800 0000000000800000
Nov 24 17:54:25 xenhost0 kernel:  ffff880f82a23000 ffff880f9d413400 ffff88008da23e60 ffffffff815ccf84
Nov 24 17:54:25 xenhost0 kernel: Call Trace:
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff815ccf84>] md_ioctl+0x6a4/0x1960
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff81086fba>] ? __queue_delayed_work+0xaa/0x1a0
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff810882a9>] ? try_to_grab_pending+0xa9/0x160
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff811e140b>] ? iput+0x3b/0x190
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff812004e1>] ? __blkdev_put+0x141/0x1a0
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8135234f>] blkdev_ioctl+0x21f/0x7d0
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f97c>] ? system_call_after_swapgs+0x156/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff811ff871>] block_ioctl+0x41/0x50
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff811d8b13>] do_vfs_ioctl+0x2e3/0x4d0
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f93d>] ? system_call_after_swapgs+0x117/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f936>] ? system_call_after_swapgs+0x110/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f92f>] ? system_call_after_swapgs+0x109/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f928>] ? system_call_after_swapgs+0x102/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f921>] ? system_call_after_swapgs+0xfb/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f91a>] ? system_call_after_swapgs+0xf4/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f913>] ? system_call_after_swapgs+0xed/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f90c>] ? system_call_after_swapgs+0xe6/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff811d8d81>] SyS_ioctl+0x81/0xa0
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f8db>] ? system_call_after_swapgs+0xb5/0x170
Nov 24 17:54:25 xenhost0 kernel:  [<ffffffff8174f9b0>] system_call_fastpath+0x1a/0x1f
Nov 24 17:54:25 xenhost0 kernel: Code: 44 89 f8 0f 85 9a 01 00 00 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d c3 66 90 49 8b 46 08 89 4d b0 48 89 de 44 89 45 b4 4c 89 f7 <48> 8b 40 58 e8 06 fb 18 00 85 c0 44 8b 45 b4 8b 4d b0 0f 85 67 
Nov 24 17:54:25 xenhost0 kernel: RIP  [<ffffffff815c68c1>] remove_and_add_spares+0x111/0x290
Nov 24 17:54:25 xenhost0 kernel:  RSP <ffff88008da23d50>
Nov 24 17:54:25 xenhost0 kernel: CR2: 0000000000000058
Nov 24 17:54:25 xenhost0 kernel: ---[ end trace c7981db1fafe0208 ]---


Here is additional info about the array and host.

root@kvmhost0:~# mdadm --detail /dev/md127
/dev/md127:
        Version : 1.2
  Creation Time : Wed Sep 23 12:44:58 2015
     Raid Level : raid10
  Used Dev Size : 234298368 (223.44 GiB 239.92 GB)
   Raid Devices : 4
  Total Devices : 3
    Persistence : Superblock is persistent

    Update Time : Sun Nov 24 14:56:46 2019
          State : active, FAILED, Not Started 
 Active Devices : 2
Working Devices : 3
 Failed Devices : 0
  Spare Devices : 1

         Layout : far=2
     Chunk Size : 512K

           Name : kvmhost0:2  (local to host kvmhost0)
           UUID : b48cabe2:f0241146:11087766:880e4046
         Events : 440956

    Number   Major   Minor   RaidDevice State
       0       8       65        0      active sync   /dev/sde1
       1       0        0        1      removed
       5       8       34        2      spare rebuilding   /dev/sdc2
       3       8       97        3      active sync   /dev/sdg1
root@kvmhost0:~# mdadm --examine /dev/sdc2
/dev/sdc2:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x13
     Array UUID : b48cabe2:f0241146:11087766:880e4046
           Name : kvmhost0:2  (local to host kvmhost0)
  Creation Time : Wed Sep 23 12:44:58 2015
     Raid Level : raid10
   Raid Devices : 4

 Avail Dev Size : 468597936 (223.44 GiB 239.92 GB)
     Array Size : 468596736 (446.89 GiB 479.84 GB)
  Used Dev Size : 468596736 (223.44 GiB 239.92 GB)
    Data Offset : 262144 sectors
   Super Offset : 8 sectors
Recovery Offset : 18446744073709551615 sectors
          State : clean
    Device UUID : 0069598c:816ed125:7f760908:8e2162c3

Internal Bitmap : 8 sectors from superblock
    Update Time : Sun Nov 24 14:56:46 2019
       Checksum : 80a39010 - correct
         Events : 440956

         Layout : far=2
     Chunk Size : 512K

   Device Role : Active device 2
   Array State : A.?A ('A' == active, '.' == missing)
root@kvmhost0:~# mdadm --examine /dev/sdg1
/dev/sdg1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : b48cabe2:f0241146:11087766:880e4046
           Name : kvmhost0:2  (local to host kvmhost0)
  Creation Time : Wed Sep 23 12:44:58 2015
     Raid Level : raid10
   Raid Devices : 4

 Avail Dev Size : 468597936 (223.44 GiB 239.92 GB)
     Array Size : 468596736 (446.89 GiB 479.84 GB)
  Used Dev Size : 468596736 (223.44 GiB 239.92 GB)
    Data Offset : 262144 sectors
   Super Offset : 8 sectors
          State : clean
    Device UUID : 41eede77:2232d98b:6467086e:92657c1a

Internal Bitmap : 8 sectors from superblock
    Update Time : Sun Nov 24 14:56:46 2019
       Checksum : 8f4a1447 - correct
         Events : 440956

         Layout : far=2
     Chunk Size : 512K

   Device Role : Active device 3
   Array State : A.?A ('A' == active, '.' == missing)
root@kvmhost0:~# mdadm --examine /dev/sde1
/dev/sde1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : b48cabe2:f0241146:11087766:880e4046
           Name : kvmhost0:2  (local to host kvmhost0)
  Creation Time : Wed Sep 23 12:44:58 2015
     Raid Level : raid10
   Raid Devices : 4

 Avail Dev Size : 468597936 (223.44 GiB 239.92 GB)
     Array Size : 468596736 (446.89 GiB 479.84 GB)
  Used Dev Size : 468596736 (223.44 GiB 239.92 GB)
    Data Offset : 262144 sectors
   Super Offset : 8 sectors
          State : clean
    Device UUID : a3dfe1eb:b4a93da2:1ad0d13f:2816859f

Internal Bitmap : 8 sectors from superblock
    Update Time : Sun Nov 24 14:56:46 2019
       Checksum : 70839405 - correct
         Events : 440956

         Layout : far=2
     Chunk Size : 512K

   Device Role : Active device 0
   Array State : A.?A ('A' == active, '.' == missing)

root@kvmhost0:~# uname -a
Linux kvmhost0 3.13.0-149-generic #199+7.0trisquel3 SMP Sat Jun 9 21:45:20 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
root@kvmhost0:~# mdadm --version
mdadm - v3.2.5 - 18th May 2012

