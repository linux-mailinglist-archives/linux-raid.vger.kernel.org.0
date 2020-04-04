Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6819E7DA
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 00:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDDWBI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Apr 2020 18:01:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41063 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDDWBH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 4 Apr 2020 18:01:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so13956352edq.8
        for <linux-raid@vger.kernel.org>; Sat, 04 Apr 2020 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zjt0VbHMiTddhFLATkFwki4K9oKLSooCzyIvwWGjcao=;
        b=UGNRT1A3CTLwJIqstN3mQJksRq38btHZ6NZ/gHOfJaqbk9/Twg/zE8DHTMLlSbNRn/
         UcT5y/O9P0PWW2OuppwFir+NR7dA3xB/ZZ5mbODCRse04lXw4F5LNI6uuOoN1ikDXsxz
         5wrIOJtZ4DntocQpFw1o5uBhAQVfP90UzpMqC8xJ0plFefcu4usnLAi7cnB0WxX4Bu+8
         DZvYGF1y8bFth8E37Xi+aYpdeN7LWmyyFIFQG0fw1AgcC7716Wp25U3uLX936EYVBXwf
         xJtzmR95bly4NLumMZ/JqBEcm+b17XSkBSYRrSKpDPI+FgzV0YLVGb1xfZGKgGmPP+Sh
         kEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zjt0VbHMiTddhFLATkFwki4K9oKLSooCzyIvwWGjcao=;
        b=Q37Pa4+y5b/o1nqH4W2enmFIxgb8c5JCe0WA+WdLUNaNUqDpeSgLdUYJd38Ebetvk+
         mvWcsEL1TtEV98IMRVguQdEFAxC9Yni5Sv89VZgTZRky995depuxFHCqoITFzZe0fEkh
         PGhK/iNQqXbU1Y98T1toyMvAOB8AY9jdSOK+VG9DqY2CIWsEm5RqIywzYtEiFolf477w
         H9HlizQ0+VZpAeyCgQxwor0vfLpNlGztjOTCtZ2PH8spiRXxWP8YkyB3TnZRNGldvUjY
         1A1x61RYaoPf88EYrLenqvFiJWHeIxnms6Y6Ng628IFMLV7LNpRpe+kQ/RrXbQ9snHRG
         mpFQ==
X-Gm-Message-State: AGi0PuaydC6I2Noq8wY6zYsZiCNCX+/xndSpdG8LKLpbol+0ZhjEqHwC
        M4FZxO+X5YrcCxrGC3om+s1jJQ==
X-Google-Smtp-Source: APiQypL+7pEJ83n0hiEXbKMoGXb92bRaFTbb50aMuEBpniUH5S9z+Xk6rN5mGLq3wqHtoeG3BMKq1g==
X-Received: by 2002:a50:9f07:: with SMTP id b7mr13392351edf.148.1586037664624;
        Sat, 04 Apr 2020 15:01:04 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:e120:c0df:e1ea:ba3e])
        by smtp.gmail.com with ESMTPSA id oe24sm1718549ejb.47.2020.04.04.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 15:01:04 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/5] md: don't flush workqueue unconditionally in md_open
Date:   Sat,  4 Apr 2020 23:57:09 +0200
Message-Id: <20200404215711.4272-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We need to check mddev->del_work before flush workqueu since the purpose
of flush is to ensure the previous md is disappeared. Otherwise the similar
deadlock appeared if LOCKDEP is enabled, it is due to md_open holds the
bdev->bd_mutex before flush workqueue.

kernel: [  154.522645] ======================================================
kernel: [  154.522647] WARNING: possible circular locking dependency detected
kernel: [  154.522650] 5.6.0-rc7-lp151.27-default #25 Tainted: G           O
kernel: [  154.522651] ------------------------------------------------------
kernel: [  154.522653] mdadm/2482 is trying to acquire lock:
kernel: [  154.522655] ffff888078529128 ((wq_completion)md_misc){+.+.}, at: flush_workqueue+0x84/0x4b0
kernel: [  154.522673]
kernel: [  154.522673] but task is already holding lock:
kernel: [  154.522675] ffff88804efa9338 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x79/0x590
kernel: [  154.522691]
kernel: [  154.522691] which lock already depends on the new lock.
kernel: [  154.522691]
kernel: [  154.522694]
kernel: [  154.522694] the existing dependency chain (in reverse order) is:
kernel: [  154.522696]
kernel: [  154.522696] -> #4 (&bdev->bd_mutex){+.+.}:
kernel: [  154.522704]        __mutex_lock+0x87/0x950
kernel: [  154.522706]        __blkdev_get+0x79/0x590
kernel: [  154.522708]        blkdev_get+0x65/0x140
kernel: [  154.522709]        blkdev_get_by_dev+0x2f/0x40
kernel: [  154.522716]        lock_rdev+0x3d/0x90 [md_mod]
kernel: [  154.522719]        md_import_device+0xd6/0x1b0 [md_mod]
kernel: [  154.522723]        new_dev_store+0x15e/0x210 [md_mod]
kernel: [  154.522728]        md_attr_store+0x7a/0xc0 [md_mod]
kernel: [  154.522732]        kernfs_fop_write+0x117/0x1b0
kernel: [  154.522735]        vfs_write+0xad/0x1a0
kernel: [  154.522737]        ksys_write+0xa4/0xe0
kernel: [  154.522745]        do_syscall_64+0x64/0x2b0
kernel: [  154.522748]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
kernel: [  154.522749]
kernel: [  154.522749] -> #3 (&mddev->reconfig_mutex){+.+.}:
kernel: [  154.522752]        __mutex_lock+0x87/0x950
kernel: [  154.522756]        new_dev_store+0xc9/0x210 [md_mod]
kernel: [  154.522759]        md_attr_store+0x7a/0xc0 [md_mod]
kernel: [  154.522761]        kernfs_fop_write+0x117/0x1b0
kernel: [  154.522763]        vfs_write+0xad/0x1a0
kernel: [  154.522765]        ksys_write+0xa4/0xe0
kernel: [  154.522767]        do_syscall_64+0x64/0x2b0
kernel: [  154.522769]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
kernel: [  154.522770]
kernel: [  154.522770] -> #2 (kn->count#253){++++}:
kernel: [  154.522775]        __kernfs_remove+0x253/0x2c0
kernel: [  154.522778]        kernfs_remove+0x1f/0x30
kernel: [  154.522780]        kobject_del+0x28/0x60
kernel: [  154.522783]        mddev_delayed_delete+0x24/0x30 [md_mod]
kernel: [  154.522786]        process_one_work+0x2a7/0x5f0
kernel: [  154.522788]        worker_thread+0x2d/0x3d0
kernel: [  154.522793]        kthread+0x117/0x130
kernel: [  154.522795]        ret_from_fork+0x3a/0x50
kernel: [  154.522796]
kernel: [  154.522796] -> #1 ((work_completion)(&mddev->del_work)){+.+.}:
kernel: [  154.522800]        process_one_work+0x27e/0x5f0
kernel: [  154.522802]        worker_thread+0x2d/0x3d0
kernel: [  154.522804]        kthread+0x117/0x130
kernel: [  154.522806]        ret_from_fork+0x3a/0x50
kernel: [  154.522807]
kernel: [  154.522807] -> #0 ((wq_completion)md_misc){+.+.}:
kernel: [  154.522813]        __lock_acquire+0x1392/0x1690
kernel: [  154.522816]        lock_acquire+0xb4/0x1a0
kernel: [  154.522818]        flush_workqueue+0xab/0x4b0
kernel: [  154.522821]        md_open+0xb6/0xc0 [md_mod]
kernel: [  154.522823]        __blkdev_get+0xea/0x590
kernel: [  154.522825]        blkdev_get+0x65/0x140
kernel: [  154.522828]        do_dentry_open+0x1d1/0x380
kernel: [  154.522831]        path_openat+0x567/0xcc0
kernel: [  154.522834]        do_filp_open+0x9b/0x110
kernel: [  154.522836]        do_sys_openat2+0x201/0x2a0
kernel: [  154.522838]        do_sys_open+0x57/0x80
kernel: [  154.522840]        do_syscall_64+0x64/0x2b0
kernel: [  154.522842]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
kernel: [  154.522844]
kernel: [  154.522844] other info that might help us debug this:
kernel: [  154.522844]
kernel: [  154.522846] Chain exists of:
kernel: [  154.522846]   (wq_completion)md_misc --> &mddev->reconfig_mutex --> &bdev->bd_mutex
kernel: [  154.522846]
kernel: [  154.522850]  Possible unsafe locking scenario:
kernel: [  154.522850]
kernel: [  154.522852]        CPU0                    CPU1
kernel: [  154.522853]        ----                    ----
kernel: [  154.522854]   lock(&bdev->bd_mutex);
kernel: [  154.522856]                                lock(&mddev->reconfig_mutex);
kernel: [  154.522858]                                lock(&bdev->bd_mutex);
kernel: [  154.522860]   lock((wq_completion)md_misc);
kernel: [  154.522861]
kernel: [  154.522861]  *** DEADLOCK ***
kernel: [  154.522861]
kernel: [  154.522864] 1 lock held by mdadm/2482:
kernel: [  154.522865]  #0: ffff88804efa9338 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x79/0x590
kernel: [  154.522868]
kernel: [  154.522868] stack backtrace:
kernel: [  154.522873] CPU: 1 PID: 2482 Comm: mdadm Tainted: G           O      5.6.0-rc7-lp151.27-default #25
kernel: [  154.522875] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
kernel: [  154.522878] Call Trace:
kernel: [  154.522881]  dump_stack+0x8f/0xcb
kernel: [  154.522884]  check_noncircular+0x194/0x1b0
kernel: [  154.522888]  ? __lock_acquire+0x1392/0x1690
kernel: [  154.522890]  __lock_acquire+0x1392/0x1690
kernel: [  154.522893]  lock_acquire+0xb4/0x1a0
kernel: [  154.522895]  ? flush_workqueue+0x84/0x4b0
kernel: [  154.522898]  flush_workqueue+0xab/0x4b0
kernel: [  154.522900]  ? flush_workqueue+0x84/0x4b0
kernel: [  154.522905]  ? md_open+0xb6/0xc0 [md_mod]
kernel: [  154.522908]  md_open+0xb6/0xc0 [md_mod]
kernel: [  154.522910]  __blkdev_get+0xea/0x590
kernel: [  154.522912]  ? bd_acquire+0xc0/0xc0
kernel: [  154.522914]  blkdev_get+0x65/0x140
kernel: [  154.522916]  ? bd_acquire+0xc0/0xc0
kernel: [  154.522918]  do_dentry_open+0x1d1/0x380
kernel: [  154.522921]  path_openat+0x567/0xcc0
kernel: [  154.522923]  ? __lock_acquire+0x380/0x1690
kernel: [  154.522926]  do_filp_open+0x9b/0x110
kernel: [  154.522929]  ? __alloc_fd+0xe5/0x1f0
kernel: [  154.522935]  ? kmem_cache_alloc+0x28c/0x630
kernel: [  154.522939]  ? do_sys_openat2+0x201/0x2a0
kernel: [  154.522941]  do_sys_openat2+0x201/0x2a0
kernel: [  154.522944]  do_sys_open+0x57/0x80
kernel: [  154.522946]  do_syscall_64+0x64/0x2b0
kernel: [  154.522948]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
kernel: [  154.522951] RIP: 0033:0x7f98d279d9ae

And md_alloc also flushed the same workqueue, but the thing is different
here. Because all the paths call md_alloc don't hold bdev->bd_mutex, and
the flush is necessary to avoid race condition, so leave it as it is.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2202074ea98f..b4ea0f38ccd8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7767,7 +7767,8 @@ static int md_open(struct block_device *bdev, fmode_t mode)
 		 */
 		mddev_put(mddev);
 		/* Wait until bdev->bd_disk is definitely gone */
-		flush_workqueue(md_misc_wq);
+		if (work_pending(&mddev->del_work))
+			flush_workqueue(md_misc_wq);
 		/* Then retry the open from the top */
 		return -ERESTARTSYS;
 	}
-- 
2.17.1

