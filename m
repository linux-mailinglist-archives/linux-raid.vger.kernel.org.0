Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E648509E
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2019 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfHGQGk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Aug 2019 12:06:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44907 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387626AbfHGQGk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Aug 2019 12:06:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so86824037edr.11
        for <linux-raid@vger.kernel.org>; Wed, 07 Aug 2019 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bYTjWg0+yAx1WDN8ubMAa1QE6hs+I4fe7+6AMJA+f/A=;
        b=DlhJCpUEP3SsCqgW932jwaJL6kSf8VaZ7mlV2KJPpPXihdzYZYkf75GPPcVWY6lirT
         rvPQcsZAVDurnbWYRWzRZYABv36+q0CPte9GmGP/MQzAGNmZcCiqfv/yBq6yiU9SMrXk
         6uUlk9bKl6BHN5z5m6DiEp9l5JdaSo4pmo3CM+xfMQoshiz6lLPvg2tcYILqrw98ZiDf
         N3vIEwfp7wMgADm4YbpabltbPyb+rH3R/UHTbBgGGqRxvvr5WyyIbl/2gCuF1MUXsLTh
         XEVkT7ojLasrl/KwfkdFil1a3M0qXjeCvW9Pv0lqHQdBZNH+yVZY3zDHwI+KjKEWKCLS
         npAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bYTjWg0+yAx1WDN8ubMAa1QE6hs+I4fe7+6AMJA+f/A=;
        b=bfG7cr9gks6fIfTq6BI7pEnHJrLsWGx2szZi0rwLbp8JNNhD2xYCaUzZJHg6Qub/Dd
         ktGi0RraLu8kP3F9EjF0esP9woGxX06F0mmhu0y3QtOIZmFguP9Y9EGf7zXquA8b8uxI
         QuCwh1AsxnlZYpOcv/bWafblfob+X+wHMxmZoV7z9H3KDYHTb2TWM1i452OYUD6RT21q
         KSAE2ZNXGruj6F0jMvO+EV2piktgAxwXJkw5W4W9DtHqpHG96e/sWcMBCmKOtIAUJXTE
         vymFysn9KgBfg3nf9vPp8sglzEOFz4bJbuz/QXhPpNQJ+9b6sKEgO1o8L3Cr02bSfscc
         S6Kw==
X-Gm-Message-State: APjAAAXLiHuMUiWYrmQXdx8U4f+o/e9wjmxoCi1BMAEmay1aaYP4qCB0
        8oj62WM6WNbtLj20kyGI5FX/FVrcgZM=
X-Google-Smtp-Source: APXvYqwM+Jo/wn7Ecc2G0xgaM0REll8ArhW0RxQU1g9sPh2vWH78mXMBNy2hAWat8raHXSQDlWJVdA==
X-Received: by 2002:aa7:c313:: with SMTP id l19mr10660080edq.258.1565193997766;
        Wed, 07 Aug 2019 09:06:37 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:4127:f672:e618:a425? ([2001:1438:4010:2540:4127:f672:e618:a425])
        by smtp.gmail.com with ESMTPSA id e43sm21384067ede.62.2019.08.07.09.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:06:37 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: WARNING in break_stripe_batch_list with "stripe state: 2001"
To:     linux-raid <linux-raid@vger.kernel.org>
Cc:     NeilBrown <neilb@suse.com>
Message-ID: <7401b3e0-fb0c-8ed7-b1cb-28494fbac967@cloud.ionos.com>
Date:   Wed, 7 Aug 2019 18:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

The below warning is appeared in the 4.14.86 kernel, but seems there is 
no obvious change for the code
in mainline kernel.

   [7028915.431770] stripe state: 2001
   [7028915.431815] ------------[ cut here ]------------
   [7028915.431828] WARNING: CPU: 18 PID: 29089 at drivers/md/raid5.c:4614 break_stripe_batch_list+0x203/0x240 [raid456]
   [7028915.431829] Modules linked in: cpufreq_ondemand cpufreq_conservative cpufreq_userspace cpufreq_powersave ibnbd_server(O) ibtrs_server(O) ibtrs_core(O) sb_edac x86_pkg_temp_thermal crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ib_umad pcbc rdma_ucm ib_ipoib rdma_cm aesni_intel iw_cm aes_x86_64 ib_uverbs efi_pstore ib_cm crypto_simd glue_helper cryptd efivars sg ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad pcc_cpufreq button yars(O) andbd_server(O) andbd_client(O) andbd_shared(O) efivarfs raid10 raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq linear mlx5_ib ib_core ipv6 hid_generic usbhid crc32c_intel mlx5_core mlx_compat ehci_pci xhci_pci i2c_i801 ixgbe ahci i2c_core ehci_hcd xhci_hcd mdio libahci hwmon mpt3sas dca
   [7028915.431879] CPU: 18 PID: 29089 Comm: kworker/u82:5 Tainted: G           O    4.14.86-1-storage #4.14.86-1.2~deb9
   [7028915.431881] Hardware name: Supermicro SSG-2028R-ACR24L/X10DRH-iT, BIOS 3.1 06/18/2018
   [7028915.431888] Workqueue: raid5wq raid5_do_work [raid456]
   [7028915.431890] task: ffff9ab0ef36d7c0 task.stack: ffffb72926f84000
   [7028915.431896] RIP: 0010:break_stripe_batch_list+0x203/0x240 [raid456]
   [7028915.431898] RSP: 0018:ffffb72926f87ba8 EFLAGS: 00010286
   [7028915.431900] RAX: 0000000000000012 RBX: ffff9aaa84a98000 RCX: 0000000000000000
   [7028915.431901] RDX: 0000000000000000 RSI: ffff9ab2bfa15458 RDI: ffff9ab2bfa15458
   [7028915.431902] RBP: ffff9aaa8fb4e900 R08: 0000000000000001 R09: 0000000000002eb4
   [7028915.431903] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff9ab1736f1b00
   [7028915.431904] R13: 0000000000000000 R14: ffff9aaa8fb4e900 R15: 0000000000000001
   [7028915.431906] FS:  0000000000000000(0000) GS:ffff9ab2bfa00000(0000) knlGS:0000000000000000
   [7028915.431907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [7028915.431908] CR2: 00007ff953b9f5d8 CR3: 0000000bf4009002 CR4: 00000000003606e0
   [7028915.431909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   [7028915.431910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   [7028915.431910] Call Trace:
   [7028915.431923]  handle_stripe+0x8e7/0x2020 [raid456]
   [7028915.431930]  ? __wake_up_common_lock+0x89/0xc0
   [7028915.431935]  handle_active_stripes.isra.58+0x35f/0x560 [raid456]
   [7028915.431939]  raid5_do_work+0xc6/0x1f0 [raid456]
   [7028915.431944]  ? process_one_work+0x1c5/0x3b0
   [7028915.431945]  process_one_work+0x1c5/0x3b0
   [7028915.431948]  worker_thread+0x241/0x3e0
   [7028915.431951]  kthread+0xfc/0x130
   [7028915.431954]  ? trace_event_raw_event_workqueue_execute_start+0xa0/0xa0
   [7028915.431956]  ? kthread_create_on_node+0x70/0x70
   [7028915.431961]  ret_from_fork+0x1f/0x30


After go through the code, three places could call 
break_stripe_batch_list, two place are in handle_stripe,
the other is in handle_stripe_clean_event (and handle_stripe_clean_event 
is only called in handle_stripe).

Since "2001" means STRIPE_IO_STARTED (not related to warning) and 
STRIPE_ACTIVE. And handle_stripe
set STRIPE_ACTIVE flag at the beginning, the flag is cleared before 
handle_stripe returns. Which means
if break_stripe_batch_list is called, then STRIPE_ACTIVE should be set 
already, please see below snippet.

handle_stripe
{
             ...
             test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)
             ...
             if (test_and_clear_bit(STRIPE_BATCH_ERR, &sh->state))
                 break_stripe_batch_list(sh, 0);
             ...
             if (s.failed > conf->max_degraded ||
                (s.log_failed && s.injournal == 0)) {
                 ...
                 break_stripe_batch_list(sh, 0);
                 ...
             }
              ...
             if (s.written &&
                 (s.p_failed || ((test_bit(R5_Insync, &pdev->flags)
                              && !test_bit(R5_LOCKED, &pdev->flags)
                              && (test_bit(R5_UPTODATE, &pdev->flags) ||
                                  test_bit(R5_Discard, &pdev->flags))))) &&
                 (s.q_failed || ((test_bit(R5_Insync, &qdev->flags)
                              && !test_bit(R5_LOCKED, &qdev->flags)
                              && (test_bit(R5_UPTODATE, &qdev->flags) ||
                                  test_bit(R5_Discard, &qdev->flags))))))
                     handle_stripe_clean_event(conf, sh, disks);
             ....
             clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
}

So from my understanding, break_stripe_batch_list always triggers (which 
is not good) the warning
if it is called, but the function is called under conditions: too many 
failed devices, write error happened
or failure of pdisk/qdisk etc, which means the warning is happened 
rarely, though I still found the same
issue was reported in list [1].

Maybe it makes sense to remove the checking of STRIPE_ACTIVE just like 
commit 550da24f8d62f
("md/raid5: preserve STRIPE_PREREAD_ACTIVE in break_stripe_batch_list").

@@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct 
stripe_head *head_sh,

                 list_del_init(&sh->batch_list);

-               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
-                                         (1 << STRIPE_SYNCING) |
+               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
                                           (1 << STRIPE_REPLACED) |
                                           (1 << STRIPE_DELAYED) |
                                           (1 << STRIPE_BIT_DELAY) |
@@ -4626,6 +4626,7 @@ static void break_stripe_batch_list(struct 
stripe_head *head_sh,

                 set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
                                             (1 << STRIPE_PREREAD_ACTIVE) |
+                                           (1 << STRIPE_ACTIVE) |
                                             (1 << STRIPE_DEGRADED) |
                                             (1 << STRIPE_ON_UNPLUG_LIST)),
                               head_sh->state & (1 << STRIPE_INSYNC));



[1]. https://www.spinics.net/lists/raid/msg62552.html

Any comments? Thanks in advance.

BRs,
Guoqing

