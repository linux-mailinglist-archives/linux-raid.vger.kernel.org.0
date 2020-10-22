Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB52295603
	for <lists+linux-raid@lfdr.de>; Thu, 22 Oct 2020 03:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894672AbgJVBVb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Oct 2020 21:21:31 -0400
Received: from smtp2.kaist.ac.kr ([143.248.5.229]:45377 "EHLO
        smtp2.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894666AbgJVBVb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Oct 2020 21:21:31 -0400
Received: from unknown (HELO mail1.kaist.ac.kr) (143.248.5.69)
        by 143.248.5.229 with ESMTP; 22 Oct 2020 10:21:29 +0900
X-Original-SENDERIP: 143.248.5.69
X-Original-MAILFROM: dae.r.jeong@kaist.ac.kr
X-Original-RCPTTO: linux-raid@vger.kernel.org
Received: from kaist.ac.kr (143.248.133.220)
        by kaist.ac.kr with ESMTP imoxion SensMail SmtpServer 7.0
        id <7224713023a9492a84dd6477d3f89134> from <dae.r.jeong@kaist.ac.kr>;
        Thu, 22 Oct 2020 10:21:28 +0900
Date:   Thu, 22 Oct 2020 10:21:28 +0900
From:   "Dae R. Jeong" <dae.r.jeong@kaist.ac.kr>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yjkwon@kaist.ac.kr
Subject: [PATCH] md: fix a warning caused by a race between concurrent
 md_ioctl()s
Message-ID: <20201022012128.GA2103465@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Syzkaller reports a warning as belows.
WARNING: CPU: 0 PID: 9647 at drivers/md/md.c:7169
...
Call Trace:
...
RIP: 0010:md_ioctl+0x4017/0x5980 drivers/md/md.c:7169
RSP: 0018:ffff888096027950 EFLAGS: 00010293
RAX: ffff88809322c380 RBX: 0000000000000932 RCX: ffffffff84e266f2
RDX: 0000000000000000 RSI: ffffffff84e299f7 RDI: 0000000000000007
RBP: ffff888096027bc0 R08: ffff88809322c380 R09: ffffed101341a482
R10: ffff888096027940 R11: ffff88809a0d240f R12: 0000000000000932
R13: ffff8880a2c14100 R14: ffff88809a0d2268 R15: ffff88809a0d2408
 __blkdev_driver_ioctl block/ioctl.c:304 [inline]
 blkdev_ioctl+0xece/0x1c10 block/ioctl.c:606
 block_ioctl+0xee/0x130 fs/block_dev.c:1930
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:509 [inline]
 do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl fs/ioctl.c:718 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
 do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is caused by a race between two concurrenct md_ioctl()s closing
the array.
CPU1 (md_ioctl())                   CPU2 (md_ioctl())
------                              ------
set_bit(MD_CLOSING, &mddev->flags);
did_set_md_closing = true;
                                    WARN_ON_ONCE(test_bit(MD_CLOSING,
                                            &mddev->flags));
if(did_set_md_closing)
    clear_bit(MD_CLOSING, &mddev->flags);

Fix the warning by returning immediately if the MD_CLOSING bit is set
in &mddev->flags which indicates that the array is being closed.

Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
Reported-by: syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com
Signed-off-by: Dae R. Jeong <dae.r.jeong@kaist.ac.kr>
---
 drivers/md/md.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 98bac4f304ae..643f7f5be49b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7590,8 +7590,11 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		WARN_ON_ONCE(test_bit(MD_CLOSING, &mddev->flags));
-		set_bit(MD_CLOSING, &mddev->flags);
+		if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
+			mutex_unlock(&mddev->open_mutex);
+			err = -EBUSY;
+			goto out;
+		}
 		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
-- 
2.25.1



