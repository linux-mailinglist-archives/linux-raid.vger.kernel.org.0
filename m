Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE6A468D
	for <lists+linux-raid@lfdr.de>; Sun,  1 Sep 2019 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHaX22 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 31 Aug 2019 19:28:28 -0400
Received: from de1.gusev.co ([84.16.227.28]:37500 "EHLO mail.gusev.co"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfHaX22 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 31 Aug 2019 19:28:28 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2019 19:28:27 EDT
Received: from [10.0.0.5] (78-57-160-222.static.zebra.lt [78.57.160.222])
        by mail.gusev.co (Postfix) with ESMTPSA id 4990323F1B;
        Sun,  1 Sep 2019 02:22:35 +0300 (EEST)
From:   Dmitrij Gusev <dmitrij@gusev.co>
Subject: Kernel error at a LVM snapshot creation
To:     linux-raid@vger.kernel.org
References: <20190829081514.29660-1-yuyufen@huawei.com>
 <877e6vf45p.fsf@notabene.neil.brown.name>
 <07ffeca5-6b69-0602-0981-2221cfb682af@huawei.com>
Message-ID: <7e8f22ba-e36e-5867-3030-58ac42291585@gusev.co>
Date:   Sun, 1 Sep 2019 02:22:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <07ffeca5-6b69-0602-0981-2221cfb682af@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello.

I get a kernel error every time I create LVM snapshot - at the creation 
and at boot time, though the snapshot itself is working properly.

Sorry if I'm writing to the incorrect mailing list, please direct me to 
the correct one. (I wasn't able to find LVM related).

Linux nexus 4.19.69 #2 SMP Thu Aug 29 16:33:35 CDT 2019 x86_64 Intel(R) 
Xeon(R) E-2174G CPU @ 3.80GHz GenuineIntel GNU/Linux

At boot log:

[   17.160402] ------------[ cut here ]------------
[   17.160900] generic_make_request: Trying to write to read-only 
block-device dm-4 (partno 0)
[   17.161424] WARNING: CPU: 3 PID: 941 at block/blk-core.c:2176 
generic_make_request_checks+0x28d/0x6a0
[   17.161935] Modules linked in: fuse hid_generic usbhid hid i2c_dev 
mei_wdt eeepc_wmi asus_wmi evdev sparse_keymap rfkill wmi_bmof 
snd_hda_codec_hdmi coretemp snd_hda_codec_realtek intel_rapl 
snd_hda_codec_generic x86_pkg_temp_thermal intel_powerclamp kvm_intel 
crct10dif_pclmul crc32_pclmul i915 crc32c_intel ghash_clmulni_intel 
intel_cstate snd_hda_intel snd_hda_codec kvmgt vfio_mdev intel_rapl_perf 
mdev vfio_iommu_type1 vfio kvm snd_hda_core snd_hwdep igb snd_pcm 
snd_timer snd e1000e soundcore irqbypass cec rc_core hwmon dca i2c_i801 
drm_kms_helper drm intel_gtt agpgart thermal fan i2c_algo_bit 
fb_sys_fops syscopyarea sysfillrect sysimgblt i2c_core video mei_me mei 
xhci_pci xhci_hcd button pcc_cpufreq wmi acpi_pad acpi_tad loop 
dm_snapshot dm_bufio ext4 mbcache jbd2
[   17.165955] CPU: 3 PID: 941 Comm: kworker/3:3 Not tainted 4.19.69 #2
[   17.166464] Hardware name: ASUSTeK COMPUTER INC. System Product 
Name/WS C246 PRO, BIOS 1003 06/04/2019
[   17.166952] Workqueue: kcopyd do_work
[   17.167467] RIP: 0010:generic_make_request_checks+0x28d/0x6a0
[   17.167952] Code: 5c 03 00 00 48 89 ef 48 8d 74 24 08 c6 05 11 47 f3 
00 01 e8 55 60 01 00 48 c7 c7 d0 5d 08 bd 48 89 c6 44 89 e2 e8 22 cd cc 
ff <0f> 0b 4c 8b 65 08 8b 45 30 c1 e8 09 49 8b 74 24 50 85 c0 0f 84 5f
[   17.169020] RSP: 0018:ffff9df3c400faf8 EFLAGS: 00010282
[   17.169533] RAX: 0000000000000000 RBX: ffff927c05350988 RCX: 
0000000000000311
[   17.170049] RDX: 0000000000000001 RSI: 0000000000000082 RDI: 
0000000000000246
[   17.170562] RBP: ffff927c06a64900 R08: 0000000000000000 R09: 
0000000000000311
[   17.171106] R10: 0000000000aaaaaa R11: 0000000000000000 R12: 
0000000000000000
[   17.171616] R13: 0000000000000000 R14: 0000000000001000 R15: 
ffff927c05472b80
[   17.172130] FS:  0000000000000000(0000) GS:ffff927c0bb80000(0000) 
knlGS:0000000000000000
[   17.172646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.173191] CR2: 00007f40a05f9ff0 CR3: 000000015a20a004 CR4: 
00000000003606e0
[   17.173711] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   17.174238] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   17.174752] Call Trace:
[   17.175279]  ? kmem_cache_alloc+0x37/0x1c0
[   17.175771]  generic_make_request+0x5b/0x400
[   17.176247]  submit_bio+0x43/0x130
[   17.176726]  ? bio_add_page+0x48/0x60
[   17.177195]  dispatch_io+0x1c8/0x460
[   17.177689]  ? dm_hash_remove_all.cold+0x21/0x21
[   17.178168]  ? list_get_page+0x30/0x30
[   17.178624]  ? dm_kcopyd_do_callback+0x40/0x40
[   17.179102]  dm_io+0x11c/0x210
[   17.179545]  ? dm_hash_remove_all.cold+0x21/0x21
[   17.179990]  ? list_get_page+0x30/0x30
[   17.180429]  run_io_job+0xd4/0x1c0
[   17.180863]  ? dm_kcopyd_do_callback+0x40/0x40
[   17.181293]  ? dm_kcopyd_client_destroy+0x140/0x140
[   17.181719]  process_jobs+0x82/0x1b0
[   17.182147]  do_work+0xb9/0xf0
[   17.182570]  process_one_work+0x1ba/0x3d0
[   17.182992]  worker_thread+0x4d/0x3d0
[   17.183441]  ? process_one_work+0x3d0/0x3d0
[   17.183857]  kthread+0x117/0x130
[   17.184270]  ? kthread_create_worker_on_cpu+0x70/0x70
[   17.184680]  ret_from_fork+0x35/0x40
[   17.185082] ---[ end trace f01c6b7a501faa64 ]---

Best regards,

Dmitrij Gusev


