Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E362A1A35B6
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgDIOSB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 10:18:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDIOSB (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 10:18:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42C95ADE8;
        Thu,  9 Apr 2020 14:17:59 +0000 (UTC)
From:   colyli@suse.de
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     mhocko@suse.com, kent.overstreet@gmail.com,
        guoqing.jiang@cloud.ionos.com, Coly Li <colyli@suse.de>
Subject: [PATCH v3 1/4] md: use memalloc scope APIs in mddev_suspend()/mddev_resume()
Date:   Thu,  9 Apr 2020 22:17:20 +0800
Message-Id: <20200409141723.24447-2-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200409141723.24447-1-colyli@suse.de>
References: <20200409141723.24447-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Coly Li <colyli@suse.de>

In raid5.c:resize_chunk(), scribble_alloc() is called with GFP_NOIO
flag, then it is sent into kvmalloc_array() inside scribble_alloc().

The problem is kvmalloc_array() eventually calls kvmalloc_node() which
does not accept non GFP_KERNEL compatible flag like GFP_NOIO, then
kmalloc_node() is called indeed to allocate physically continuous
pages. When system memory is under heavy pressure, and the requesting
size is large, there is high probability that allocating continueous
pages will fail.

But simply using GFP_KERNEL flag to call kvmalloc_array() is also
progblematic. In the code path where scribble_alloc() is called, the
raid array is suspended, if kvmalloc_node() triggers memory reclaim I/Os
and such I/Os go back to the suspend raid array, deadlock will happen.

What is desired here is to allocate non-physically (a.k.a virtually)
continuous pages and avoid memory reclaim I/Os. Michal Hocko suggests
to use the mmealloc sceope APIs to restrict memory reclaim I/O in
allocating context, specifically to call memalloc_noio_save() when
suspend the raid array and to call memalloc_noio_restore() when
resume the raid array.

This patch adds the memalloc scope APIs in mddev_suspend() and
mddev_resume(), to restrict memory reclaim I/Os during the raid array
is suspended. The benifit of adding the memalloc scope API in the
unified entry point mddev_suspend()/mddev_resume() is, no matter which
md raid array type (personality), we are sure the deadlock by recursive
memory reclaim I/O won't happen on the suspending context.

Please notice that the memalloc scope APIs only take effect on the raid
array suspending context, if the memory allocation is from another new
created kthread after raid array suspended, the recursive memory reclaim
I/Os won't be restricted. The mddev_suspend()/mddev_resume() entries are
used for the critical section where the raid metadata is modifying,
creating a kthread to allocate memory inside the critical section is
queer and very probably being buggy.

Fixes: b330e6a49dc3 ("md: convert to kvmalloc")
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/md.c | 4 ++++
 drivers/md/md.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 271e8a587354..1a8e1bb3a7f4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -527,11 +527,15 @@ void mddev_suspend(struct mddev *mddev)
 	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
 
 	del_timer_sync(&mddev->safemode_timer);
+	/* restrict memory reclaim I/O during raid array is suspend */
+	mddev->noio_flag = memalloc_noio_save();
 }
 EXPORT_SYMBOL_GPL(mddev_suspend);
 
 void mddev_resume(struct mddev *mddev)
 {
+	/* entred the memalloc scope from mddev_suspend() */
+	memalloc_noio_restore(mddev->noio_flag);
 	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (--mddev->suspended)
 		return;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index acd681939112..612814d07d35 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -497,6 +497,7 @@ struct mddev {
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
 	struct md_cluster_info		*cluster_info;
 	unsigned int			good_device_nr;	/* good device num within cluster raid */
+	unsigned int			noio_flag; /* for memalloc scope API */
 
 	bool	has_superblocks:1;
 	bool	fail_last_dev:1;
-- 
2.25.0

