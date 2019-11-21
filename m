Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4A105414
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUOOM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 09:14:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34810 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKUOOM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 09:14:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id b72so2926827edf.1
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3Oa0vry7VD1C0UQHQQoA7ScyLP5QONEnUaH4lvkHBlw=;
        b=HYamN4A5/s0WeHhSR1X9/IOY91UC0vi8pI36jlsIlmtig1NyKMeMAvs6PfAejMv1K3
         c21bWRKz3LD45deg9hQ5SDU5Jw4klIqxV64oBGDEbpAxc8zZUHXGXKHN2p58wZcDH+/6
         bUzPnInCJqr/pT9tthCjowgPGUBL5nfU3mMW2XgELlEsBlt0PHbT9eDBcMYKd29W45pT
         +f2fVpeFjNAz4NwoojLuEb/68py9M0IMiQN4Lg50rlLP8P/B6qnE+VBTROSZAFveAhln
         RPCF+b3UdLWV3HbQqxU6dPLEp4o1Y5nnClwZjGaPi/WgpufhbAQppsBqHUs7H3bGuGmI
         0bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3Oa0vry7VD1C0UQHQQoA7ScyLP5QONEnUaH4lvkHBlw=;
        b=io6y+JKqRoW0BMjVdgYvLZ/lRzJ3AKuvala2cr5t+PYG5dXhS5kvx59vzq3xH+j7J6
         WnpBTxAXPOmT38YoLxThp1AseKohvRIX7Rm/fQ8UHLKautfTf/v17yz6xDzrF20oyluG
         fE3CQ+a1BNDL0VwegRNUiycCBH+DZjcxjQNNbUXzBvNSJpZIvtGBdP7YBLsYw5xNAlW3
         cmOOVGhk2Sbio4shaEdX5spiRGKv/yil3uRkYVcrxpiT8e0ksX5xMEJYOo3OfMxvh7j7
         wewx6ciw0uNWa3KdttyU0VVc2iahqDiQqwxh/6ZUxNadZ7cPB47mH8x0sOqfCX0HrNIi
         Gwrw==
X-Gm-Message-State: APjAAAWbKt3Cjf2p4yBtyvcL1mcHBhMhGr90XX49XpneORR+hpOAJ0KO
        KnJe+LsvMXIE4iCMtOhCveyhqg==
X-Google-Smtp-Source: APXvYqwBvkSm/pb+RpDptWR5xwu8nR5KCr3MejWgsFW9p9MCHFe8SC2G3jUVqBj+3uiVZ72BhVkNFA==
X-Received: by 2002:a17:906:d96c:: with SMTP id rp12mr14376018ejb.253.1574345648105;
        Thu, 21 Nov 2019 06:14:08 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:4465:ea1d:c50c:3d03? ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id 64sm106692edi.26.2019.11.21.06.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:14:07 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: About raid5 lock up
To:     linux-raid <linux-raid@vger.kernel.org>
Cc:     shinrairis@gmail.com, colyli@suse.de,
        Song Liu <liu.song.a23@gmail.com>
Message-ID: <a9f64be8-0f57-83f7-e7dd-2d6d4386a6f4@cloud.ionos.com>
Date:   Thu, 21 Nov 2019 15:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi All,

Recently, we got a report about raid5 lockup with 4.4.62 kernel as 
follows, but I failed to
reproduce it locally.

  21:40:57 >>> [4783749.306796] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 22
  21:40:58 >>> [4783749.743367] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 39
  21:40:59 >>> [4783750.324941] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 5
  21:41:00 >>> [4783751.739422] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 16
  21:41:00 >>> [4783752.115471] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 21
  21:41:01 >>> [4783752.355232] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 17
  21:41:01 >>> [4783752.627075] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 4
  21:41:01 >>> [4783752.775597] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 0
  21:41:01 >>> [4783752.941282] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 11
  21:41:04 >>> [4783755.955468] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 9
  21:41:04 >>> [4783756.142500] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 23
  21:41:04 >>> [4783756.211894] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 6
  21:41:04 >>> [4783756.264305] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 8
  21:41:07 >>> [4783759.284782] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 41
  21:42:17 >>> [4783828.834689] NMI watchdog: BUG: soft lockup - CPU#2 
stuck for 22s! [ppd:3164]
  21:42:45 >>> [4783856.835762] NMI watchdog: BUG: soft lockup - CPU#2 
stuck for 22s! [ppd:3164]
  21:43:13 >>> [4783884.837093] NMI watchdog: BUG: soft lockup - CPU#2 
stuck for 22s! [ppd:3164]
  21:43:41 >>> [4783912.838201] NMI watchdog: BUG: soft lockup - CPU#2 
stuck for 23s! [ppd:3164]
  21:44:02 >>> [4783933.941087] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 2
  22:04:02 >>> [4785134.037889] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 3
  22:05:37 >>> [4785228.764631] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 10
  22:07:03 >>> [4785315.326793] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 27
  22:08:40 >>> [4785411.462601] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 35

And most hard lockups have similar calltrace like this.

21:42:17 kernel: [4783749.306796] NMI watchdog: Watchdog detected hard 
LOCKUP on cpu 22
21:42:17 kernel: [4783749.306911] Modules linked in: dm_snapshot 
dm_bufio cpufreq_ondemand cpufreq_powersave cpufreq_stats 
cpufreq_userspace cpufreq_conservative ipmi_devintf rdma_ucm ib_ipoib 
ib_uverbs ib_umad x86_pkg_te
mp_thermal crct10dif_pclmul crc32_pclmul ghash_clmulni_intel 
sha256_ssse3 sha256_generic hmac drbg ansi_cprng aesni_intel aes_x86_64 
glue_helper ablk_helper cryptd efi_pstore efivars ipmi_si 
ipmi_msghandler acpi_power_meter hwmon acpi_cpu
freq acpi_pad button scst_vdisk yars(O) ib_srpt scst rdma_cm iw_cm ib_cm 
efivarfs raid456 libcrc32c async_raid6_recov async_memcpy async_pq 
async_xor xor async_tx raid6_pq mlx4_ib ib_sa ib_mad ib_core ib_addr 
ipv6 ib_netlink hid_generic u
sbhid sg crc32c_intel mlx4_core mlx_compat mpt3sas xhci_pci i2c_i801 
ahci i2c_core xhci_hcd libahci
  21:42:17 kernel: [4783749.310231] CPU: 22 PID: 33558 Comm: 
649175e1dc3_0 Tainted: G        W  O    4.4.62-1-storage #4.4.62-1.3
  21:42:17 kernel: [4783749.310233] Hardware name: Supermicro 
SSG-2029P-ACR24L/X11DPH-T, BIOS 3.1 05/22/2019
  21:42:17 kernel: [4783749.310235] task: ffff880bdab08000 ti: 
ffff880fba8e8000 task.ti: ffff880fba8e8000
  21:42:17 kernel: [4783749.310237] RIP: 0010:[<ffffffff81099fb1>]  
[<ffffffff81099fb1>] queued_spin_lock_slowpath+0xf1/0x160
  21:42:17 kernel: [4783749.310245] RSP: 0018:ffff880fba8eb738 EFLAGS: 
00000046
  21:42:17 kernel: [4783749.310246] RAX: 0000000000000000 RBX: 
ffff880c6d7b8800 RCX: ffff88086fc35d80
  21:42:17 kernel: [4783749.310247] RDX: ffff88107fc95d80 RSI: 
00000000005c0000 RDI: ffff880c6d7b8ad4
  21:42:17 kernel: [4783749.310248] RBP: ffff880fba8eb738 R08: 
0000000000000001 R09: 00000000633946d0
  21:42:17 kernel: [4783749.310249] R10: 0000000000000000 R11: 
0000000000000002 R12: ffff880c6d7b8810
  21:42:17 kernel: [4783749.310250] R13: 0000000000000000 R14: 
ffff880bf7fe8000 R15: ffff880bf7fe8000
  21:42:17 kernel: [4783749.310251] FS:  0000000000000000(0000) 
GS:ffff88107fc80000(0000) knlGS:0000000000000000
  21:42:17 kernel: [4783749.310253] CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
  21:42:17 kernel: [4783749.310254] CR2: 0000558286fd0a08 CR3: 
0000000001a09000 CR4: 00000000003406e0
  21:42:17 kernel: [4783749.310255] DR0: 0000000000000000 DR1: 
0000000000000000 DR2: 0000000000000000
  21:42:17 kernel: [4783749.310256] DR3: 0000000000000000 DR6: 
00000000fffe0ff0 DR7: 0000000000000400
  21:42:17 kernel: [4783749.310257] Stack:
  21:42:17 kernel: [4783749.310258]  ffff880fba8eb748 ffffffff81598060 
ffff880fba8eb800 ffffffffa0230b0a
  21:42:17 kernel: [4783749.310261]  ffff880fb74c1c00 0000000002011200 
ffff88046fc03700 ffff880fba8eb7b0
  21:42:17 kernel: [4783749.310263]  ffff880c6d7b8808 0000000000000002 
ffff880c6d7b89d0 0000000001265000
  21:42:17 kernel: [4783749.310265] Call Trace:
  21:42:17 kernel: [4783749.310272]  [<ffffffff81598060>] 
_raw_spin_lock+0x20/0x30
  21:42:17 kernel: [4783749.310275]  [<ffffffffa0230b0a>] 
raid5_get_active_stripe+0x1da/0x5250 [raid456]
  21:42:17 kernel: [4783749.310281]  [<ffffffff8112d165>] ? 
mempool_alloc_slab+0x15/0x20
  21:42:17 kernel: [4783749.310283]  [<ffffffffa0231174>] 
raid5_get_active_stripe+0x844/0x5250 [raid456]
  21:42:17 kernel: [4783749.310289]  [<ffffffff812d5574>] ? 
generic_make_request+0x24/0x2b0
  21:42:17 kernel: [4783749.310293]  [<ffffffff810938b0>] ? 
wait_woken+0x90/0x90
  21:42:17 kernel: [4783749.310298]  [<ffffffff814a2adc>] 
md_make_request+0xfc/0x250
  21:42:17 kernel: [4783749.310309]  [<ffffffff812d5867>] 
submit_bio+0x67/0x150

My understanding is that there could be two possible reasons for lockup:

1. There is deadlock inside raid5 code somewhere which should be fixed.
2. Since spin_lock/unlock_irq are called in raid5_get_active_stripe, 
then if the function need to
handle massive IOs, could it possible hard lockup was triggered due to 
IRQs are disabled more
than 10s? If so, maybe we need to touch nmi watchdog before disable irq.

Coly and Dennis had reported raid5 lock up issues with different kernel 
versions (4.2.8, 4.7.0-rc7
and 4.8-rc5), not sure it they are related or not, but I guess it is not 
fixed in latest code.

Any thoughts?

[1]. https://marc.info/?l=linux-raid&m=150348807422853&w=2
[2]. https://marc.info/?l=linux-raid&m=146883211430999&w=2


Thanks.
Guoqing
