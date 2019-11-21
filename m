Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C350C105643
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUP7W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Thu, 21 Nov 2019 10:59:22 -0500
Received: from li1843-175.members.linode.com ([172.104.24.175]:48860 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUP7W (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 10:59:22 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 10:59:21 EST
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 60EEF22A99;
        Thu, 21 Nov 2019 10:51:11 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id BE255A5D3F; Thu, 21 Nov 2019 10:51:10 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <24022.45678.691077.153563@quad.stoffel.home>
Date:   Thu, 21 Nov 2019 10:51:10 -0500
From:   "John Stoffel" <john@stoffel.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, shinrairis@gmail.com,
        colyli@suse.de, Song Liu <liu.song.a23@gmail.com>
Subject: Re: About raid5 lock up
In-Reply-To: <a9f64be8-0f57-83f7-e7dd-2d6d4386a6f4@cloud.ionos.com>
References: <a9f64be8-0f57-83f7-e7dd-2d6d4386a6f4@cloud.ionos.com>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Guoqing" == Guoqing Jiang <guoqing.jiang@cloud.ionos.com> writes:

Guoqing> Recently, we got a report about raid5 lockup with 4.4.62
Guoqing> kernel as follows, but I failed to reproduce it locally.

Guoqing>   21:40:57 >>> [4783749.306796] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 22
Guoqing>   21:40:58 >>> [4783749.743367] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 39
Guoqing>   21:40:59 >>> [4783750.324941] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 5
Guoqing>   21:41:00 >>> [4783751.739422] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 16
Guoqing>   21:41:00 >>> [4783752.115471] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 21
Guoqing>   21:41:01 >>> [4783752.355232] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 17
Guoqing>   21:41:01 >>> [4783752.627075] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 4
Guoqing>   21:41:01 >>> [4783752.775597] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 0
Guoqing>   21:41:01 >>> [4783752.941282] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 11
Guoqing>   21:41:04 >>> [4783755.955468] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 9
Guoqing>   21:41:04 >>> [4783756.142500] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 23
Guoqing>   21:41:04 >>> [4783756.211894] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 6
Guoqing>   21:41:04 >>> [4783756.264305] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 8
Guoqing>   21:41:07 >>> [4783759.284782] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 41
Guoqing>   21:42:17 >>> [4783828.834689] NMI watchdog: BUG: soft lockup - CPU#2 
Guoqing> stuck for 22s! [ppd:3164]
Guoqing>   21:42:45 >>> [4783856.835762] NMI watchdog: BUG: soft lockup - CPU#2 
Guoqing> stuck for 22s! [ppd:3164]
Guoqing>   21:43:13 >>> [4783884.837093] NMI watchdog: BUG: soft lockup - CPU#2 
Guoqing> stuck for 22s! [ppd:3164]
Guoqing>   21:43:41 >>> [4783912.838201] NMI watchdog: BUG: soft lockup - CPU#2 
Guoqing> stuck for 23s! [ppd:3164]
Guoqing>   21:44:02 >>> [4783933.941087] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 2
Guoqing>   22:04:02 >>> [4785134.037889] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 3
Guoqing>   22:05:37 >>> [4785228.764631] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 10
Guoqing>   22:07:03 >>> [4785315.326793] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 27
Guoqing>   22:08:40 >>> [4785411.462601] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 35

Guoqing> And most hard lockups have similar calltrace like this.

Guoqing> 21:42:17 kernel: [4783749.306796] NMI watchdog: Watchdog detected hard 
Guoqing> LOCKUP on cpu 22
Guoqing> 21:42:17 kernel: [4783749.306911] Modules linked in: dm_snapshot 
Guoqing> dm_bufio cpufreq_ondemand cpufreq_powersave cpufreq_stats 
Guoqing> cpufreq_userspace cpufreq_conservative ipmi_devintf rdma_ucm ib_ipoib 
Guoqing> ib_uverbs ib_umad x86_pkg_te
Guoqing> mp_thermal crct10dif_pclmul crc32_pclmul ghash_clmulni_intel 
Guoqing> sha256_ssse3 sha256_generic hmac drbg ansi_cprng aesni_intel aes_x86_64 
Guoqing> glue_helper ablk_helper cryptd efi_pstore efivars ipmi_si 
Guoqing> ipmi_msghandler acpi_power_meter hwmon acpi_cpu
Guoqing> freq acpi_pad button scst_vdisk yars(O) ib_srpt scst rdma_cm iw_cm ib_cm 
Guoqing> efivarfs raid456 libcrc32c async_raid6_recov async_memcpy async_pq 
Guoqing> async_xor xor async_tx raid6_pq mlx4_ib ib_sa ib_mad ib_core ib_addr 
Guoqing> ipv6 ib_netlink hid_generic u
Guoqing> sbhid sg crc32c_intel mlx4_core mlx_compat mpt3sas xhci_pci i2c_i801 
Guoqing> ahci i2c_core xhci_hcd libahci
Guoqing>   21:42:17 kernel: [4783749.310231] CPU: 22 PID: 33558 Comm: 
Guoqing> 649175e1dc3_0 Tainted: G        W  O    4.4.62-1-storage #4.4.62-1.3
Guoqing>   21:42:17 kernel: [4783749.310233] Hardware name: Supermicro 
Guoqing> SSG-2029P-ACR24L/X11DPH-T, BIOS 3.1 05/22/2019
Guoqing>   21:42:17 kernel: [4783749.310235] task: ffff880bdab08000 ti: 
Guoqing> ffff880fba8e8000 task.ti: ffff880fba8e8000
Guoqing>   21:42:17 kernel: [4783749.310237] RIP: 0010:[<ffffffff81099fb1>]  
Guoqing> [<ffffffff81099fb1>] queued_spin_lock_slowpath+0xf1/0x160
Guoqing>   21:42:17 kernel: [4783749.310245] RSP: 0018:ffff880fba8eb738 EFLAGS: 
Guoqing> 00000046
Guoqing>   21:42:17 kernel: [4783749.310246] RAX: 0000000000000000 RBX: 
Guoqing> ffff880c6d7b8800 RCX: ffff88086fc35d80
Guoqing>   21:42:17 kernel: [4783749.310247] RDX: ffff88107fc95d80 RSI: 
Guoqing> 00000000005c0000 RDI: ffff880c6d7b8ad4
Guoqing>   21:42:17 kernel: [4783749.310248] RBP: ffff880fba8eb738 R08: 
Guoqing> 0000000000000001 R09: 00000000633946d0
Guoqing>   21:42:17 kernel: [4783749.310249] R10: 0000000000000000 R11: 
Guoqing> 0000000000000002 R12: ffff880c6d7b8810
Guoqing>   21:42:17 kernel: [4783749.310250] R13: 0000000000000000 R14: 
Guoqing> ffff880bf7fe8000 R15: ffff880bf7fe8000
Guoqing>   21:42:17 kernel: [4783749.310251] FS:  0000000000000000(0000) 
Guoqing> GS:ffff88107fc80000(0000) knlGS:0000000000000000
Guoqing>   21:42:17 kernel: [4783749.310253] CS:  0010 DS: 0000 ES: 0000 CR0: 
Guoqing> 0000000080050033
Guoqing>   21:42:17 kernel: [4783749.310254] CR2: 0000558286fd0a08 CR3: 
Guoqing> 0000000001a09000 CR4: 00000000003406e0
Guoqing>   21:42:17 kernel: [4783749.310255] DR0: 0000000000000000 DR1: 
Guoqing> 0000000000000000 DR2: 0000000000000000
Guoqing>   21:42:17 kernel: [4783749.310256] DR3: 0000000000000000 DR6: 
Guoqing> 00000000fffe0ff0 DR7: 0000000000000400
Guoqing>   21:42:17 kernel: [4783749.310257] Stack:
Guoqing>   21:42:17 kernel: [4783749.310258]  ffff880fba8eb748 ffffffff81598060 
Guoqing> ffff880fba8eb800 ffffffffa0230b0a
Guoqing>   21:42:17 kernel: [4783749.310261]  ffff880fb74c1c00 0000000002011200 
Guoqing> ffff88046fc03700 ffff880fba8eb7b0
Guoqing>   21:42:17 kernel: [4783749.310263]  ffff880c6d7b8808 0000000000000002 
Guoqing> ffff880c6d7b89d0 0000000001265000
Guoqing>   21:42:17 kernel: [4783749.310265] Call Trace:
Guoqing>   21:42:17 kernel: [4783749.310272]  [<ffffffff81598060>] 
Guoqing> _raw_spin_lock+0x20/0x30
Guoqing>   21:42:17 kernel: [4783749.310275]  [<ffffffffa0230b0a>] 
Guoqing> raid5_get_active_stripe+0x1da/0x5250 [raid456]
Guoqing>   21:42:17 kernel: [4783749.310281]  [<ffffffff8112d165>] ? 
Guoqing> mempool_alloc_slab+0x15/0x20
Guoqing>   21:42:17 kernel: [4783749.310283]  [<ffffffffa0231174>] 
Guoqing> raid5_get_active_stripe+0x844/0x5250 [raid456]
Guoqing>   21:42:17 kernel: [4783749.310289]  [<ffffffff812d5574>] ? 
Guoqing> generic_make_request+0x24/0x2b0
Guoqing>   21:42:17 kernel: [4783749.310293]  [<ffffffff810938b0>] ? 
Guoqing> wait_woken+0x90/0x90
Guoqing>   21:42:17 kernel: [4783749.310298]  [<ffffffff814a2adc>] 
Guoqing> md_make_request+0xfc/0x250
Guoqing>   21:42:17 kernel: [4783749.310309]  [<ffffffff812d5867>] 
Guoqing> submit_bio+0x67/0x150

Guoqing> My understanding is that there could be two possible reasons for lockup:

Guoqing> 1. There is deadlock inside raid5 code somewhere which should
Guoqing> be fixed.  2. Since spin_lock/unlock_irq are called in
Guoqing> raid5_get_active_stripe, then if the function need to handle
Guoqing> massive IOs, could it possible hard lockup was triggered due
Guoqing> to IRQs are disabled more than 10s? If so, maybe we need to
Guoqing> touch nmi watchdog before disable irq.

Could you use something like a bunch of RAM disks on a large memory
system to stress test the spin_lock?  Esp if you put in some dm-faulty
devices on top?  

REally load it down with FIO tests, and then turn on a faulty disk to
see how it reacts?

Just a thought...
John
