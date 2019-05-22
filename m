Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51726473
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2019 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfEVNRR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 May 2019 09:17:17 -0400
Received: from drutsystem.com ([84.10.39.251]:34156 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfEVNRR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 May 2019 09:17:17 -0400
To:     linux-raid@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1558531029; bh=8kvMPl6qZX3T0OpnaTG/SOxECH+IPaXyH7UEVIWjM9I=;
        h=To:From:Subject:Date;
        b=9jvbloSUaFxL4MY0UsBPK5zWGPE8rz3ZbN89EgVno0skgrabDGrkBwW7lKP6mtHZi
         FyqMfR0o89edc6sdfWgPFhd8PX9euvskp8mjBkmK0GtWZ2V8pqG10MHfFss/c5mOR9
         i5+DpgBs3ey22i6uJQ9QOsgyfbwWLR+2DL4OAISY=
From:   Michal Soltys <soltys@ziu.info>
Subject: Few questions about (attempting to use) write journal + call traces
Message-ID: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
Date:   Wed, 22 May 2019 15:17:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: 39599743D13.AE548
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

As I started experimenting with journaled raids:

1) can another (raid1) device or lvm mirror (using md underneath) be used formally as a write journal ?
2) for the testing purposes, are loopback devices expected to work ?

I know I can successfully create both of the above (case scenario below), but any attempt to write to such md device ends with hung tasks and D states.


kernel 5.1.3
mdadm 4.1
btrfs filesystem with /var subvolume (where losetup files were created with fallocate)

What I did:

- six 10gb files as backings for /dev/loop[0-5]
- /dev/loop[4-5] - raid1
- /dev/loop[0-3] - raid5

Now at this point both raids work just fine, separately. The problem starts if I create raid1 as raid5's journal (doesn't matter whether w-t or w-b). Any attempt to write to a device like that instantly ends with D and respective traces in dmesg:

May 22 14:39:37 hakai kernel: INFO: task dd:899 blocked for more than 245 seconds.
May 22 14:39:37 hakai kernel:       Not tainted 5.1.3-arch1-1-ARCH #1
May 22 14:39:37 hakai kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 22 14:39:37 hakai kernel: dd              D    0   899    824 0x00000004
May 22 14:39:37 hakai kernel: Call Trace:
May 22 14:39:37 hakai kernel:  ? __schedule+0x30b/0x8b0
May 22 14:39:37 hakai kernel:  ? raid5_unplug+0xb2/0x140 [raid456]
May 22 14:39:37 hakai kernel:  schedule+0x32/0x80
May 22 14:39:37 hakai kernel:  io_schedule+0x12/0x40
May 22 14:39:37 hakai kernel:  wait_on_page_bit+0x138/0x200
May 22 14:39:37 hakai kernel:  ? add_to_page_cache_lru+0xc0/0xc0
May 22 14:39:37 hakai kernel:  __filemap_fdatawait_range+0xb9/0x110
May 22 14:39:37 hakai kernel:  filemap_fdatawait_range+0xe/0x20
May 22 14:39:37 hakai kernel:  filemap_write_and_wait+0x47/0x70
May 22 14:39:37 hakai kernel:  __blkdev_put+0x71/0x1e0
May 22 14:39:37 hakai kernel:  blkdev_close+0x21/0x30
May 22 14:39:37 hakai kernel:  __fput+0xa5/0x1d0
May 22 14:39:37 hakai kernel:  task_work_run+0x8f/0xb0
May 22 14:39:37 hakai kernel:  exit_to_usermode_loop+0xd3/0xe0
May 22 14:39:37 hakai kernel:  do_syscall_64+0x157/0x180
May 22 14:39:37 hakai kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
May 22 14:39:37 hakai kernel: RIP: 0033:0x7f13c4a66348
May 22 14:39:37 hakai kernel: Code: Bad RIP value.
May 22 14:39:37 hakai kernel: RSP: 002b:00007ffcde214058 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
May 22 14:39:37 hakai kernel: RAX: 0000000000000000 RBX: 0000562ed16d5160 RCX: 00007f13c4a66348
May 22 14:39:37 hakai kernel: RDX: 0000000000080000 RSI: 0000000000000000 RDI: 0000000000000001
May 22 14:39:37 hakai kernel: RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
May 22 14:39:37 hakai kernel: R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000001
May 22 14:39:37 hakai kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 00007f13c4301000

May 22 14:39:37 hakai kernel: INFO: task systemd-udevd:313 blocked for more than 245 seconds.
May 22 14:39:37 hakai kernel:       Not tainted 5.1.3-arch1-1-ARCH #1
May 22 14:39:37 hakai kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 22 14:39:37 hakai kernel: systemd-udevd   D    0   313      1 0x00000104
May 22 14:39:37 hakai kernel: Call Trace:
May 22 14:39:37 hakai kernel:  ? __schedule+0x30b/0x8b0
May 22 14:39:37 hakai kernel:  schedule+0x32/0x80
May 22 14:39:37 hakai kernel:  schedule_preempt_disabled+0x14/0x20
May 22 14:39:37 hakai kernel:  __mutex_lock.isra.1+0x217/0x520
May 22 14:39:37 hakai kernel:  ? kobj_lookup+0xf1/0x160
May 22 14:39:37 hakai kernel:  __blkdev_get+0x83/0x540
May 22 14:39:37 hakai kernel:  blkdev_get+0x108/0x340
May 22 14:39:37 hakai kernel:  ? preempt_count_add+0x79/0xb0
May 22 14:39:37 hakai kernel:  ? _raw_spin_lock+0x13/0x30
May 22 14:39:37 hakai kernel:  ? bd_acquire+0xc0/0xc0
May 22 14:39:37 hakai kernel:  do_dentry_open+0x13a/0x380
May 22 14:39:37 hakai kernel:  path_openat+0x2d6/0x1500
May 22 14:39:37 hakai kernel:  ? mntput_no_expire+0x11/0x1a0
May 22 14:39:37 hakai kernel:  ? terminate_walk+0xeb/0x100
May 22 14:39:37 hakai kernel:  do_filp_open+0x93/0x100
May 22 14:39:37 hakai kernel:  ? __check_object_size+0xc1/0x175
May 22 14:39:37 hakai kernel:  ? _raw_spin_unlock+0x16/0x30
May 22 14:39:37 hakai kernel:  do_sys_open+0x186/0x220
May 22 14:39:37 hakai kernel:  do_syscall_64+0x5b/0x180
May 22 14:39:37 hakai kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
May 22 14:39:37 hakai kernel: RIP: 0033:0x7ff24fe549ff
May 22 14:39:37 hakai kernel: Code: Bad RIP value.
May 22 14:39:37 hakai kernel: RSP: 002b:00007ffe7b7ce060 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
May 22 14:39:37 hakai kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff24fe549ff
May 22 14:39:37 hakai kernel: RDX: 00000000000a0800 RSI: 00005578d289be10 RDI: 00000000ffffff9c
May 22 14:39:37 hakai kernel: RBP: 00005578d28b3ea0 R08: 00007ff24fb896d0 R09: 00005578d2891fe0
May 22 14:39:37 hakai kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
May 22 14:39:37 hakai kernel: R13: 00007ffe7b7cf198 R14: 00007ffe7b7cf188 R15: 00005578d27e1254
