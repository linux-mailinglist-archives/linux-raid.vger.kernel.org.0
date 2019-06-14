Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF617457E0
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFNIv0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 04:51:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:60534 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNIvZ (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Fri, 14 Jun 2019 04:51:25 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 14 Jun 2019 02:51:15 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH 2/5] md: introduce mddev_create/destroy_wb_pool for the change of member device
Date:   Fri, 14 Jun 2019 17:10:36 +0800
Message-Id: <20190614091039.32461-3-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190614091039.32461-1-gqjiang@suse.com>
References: <20190614091039.32461-1-gqjiang@suse.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Previously, we called rdev_init_wb to avoid potential data
inconsistency when array is created.

Now, we need to call the function and create mempool if a
device is added or just be flaged as "writemostly". So
mddev_create_wb_pool is introduced and called accordingly.
And for safety reason, we mark implicit GFP_NOIO allocation
scope for create mempool during mddev_suspend/mddev_resume.

And mempool should be removed conversely after remove a
member device or its's "writemostly" flag, which is done
by call mddev_destroy_wb_pool.

Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 drivers/md/md.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/md.h |  2 ++
 2 files changed, 67 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3f816e4d4dd8..7bab12a8d237 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -44,6 +44,7 @@
 
 */
 
+#include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/kthread.h>
 #include <linux/blkdev.h>
@@ -144,6 +145,64 @@ static int rdev_init_wb(struct md_rdev *rdev)
 	return 1;
 }
 
+/*
+ * Create wb_info_pool if rdev is the first multi-queue device flaged
+ * with writemostly, also write-behind mode is enabled.
+ */
+void mddev_create_wb_pool(struct mddev *mddev, struct md_rdev *rdev,
+			  bool is_suspend)
+{
+	if (mddev->bitmap_info.max_write_behind == 0)
+		return;
+
+	if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_wb(rdev))
+		return;
+
+	if (mddev->wb_info_pool == NULL) {
+		unsigned int noio_flag;
+
+		if (!is_suspend)
+			mddev_suspend(mddev);
+		noio_flag = memalloc_noio_save();
+		mddev->wb_info_pool = mempool_create_kmalloc_pool(NR_WB_INFOS,
+							sizeof(struct wb_info));
+		memalloc_noio_restore(noio_flag);
+		if (!mddev->wb_info_pool)
+			pr_err("can't alloc memory pool for writemostly\n");
+		if (!is_suspend)
+			mddev_resume(mddev);
+	}
+}
+EXPORT_SYMBOL_GPL(mddev_create_wb_pool);
+
+/*
+ * destroy wb_info_pool if rdev is the last device flaged with WBCollisionCheck.
+ */
+static void mddev_destroy_wb_pool(struct mddev *mddev, struct md_rdev *rdev)
+{
+	if (!test_and_clear_bit(WBCollisionCheck, &rdev->flags))
+		return;
+
+	if (mddev->wb_info_pool) {
+		struct md_rdev *temp;
+		int num = 0;
+
+		/*
+		 * Check if other rdevs need wb_info_pool.
+		 */
+		rdev_for_each(temp, mddev)
+			if (temp != rdev &&
+			    test_bit(WBCollisionCheck, &temp->flags))
+				num++;
+		if (!num) {
+			mddev_suspend(rdev->mddev);
+			mempool_destroy(mddev->wb_info_pool);
+			mddev->wb_info_pool = NULL;
+			mddev_resume(rdev->mddev);
+		}
+	}
+}
+
 static struct ctl_table_header *raid_table_header;
 
 static struct ctl_table raid_table[] = {
@@ -2230,6 +2289,9 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	rdev->mddev = mddev;
 	pr_debug("md: bind<%s>\n", b);
 
+	if (mddev->raid_disks)
+		mddev_create_wb_pool(mddev, rdev, false);
+
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
 
@@ -2266,6 +2328,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
+	mddev_destroy_wb_pool(rdev->mddev, rdev);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2778,8 +2841,10 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		}
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
+		mddev_create_wb_pool(rdev->mddev, rdev, false);
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
+		mddev_destroy_wb_pool(rdev->mddev, rdev);
 		clear_bit(WriteMostly, &rdev->flags);
 		err = 0;
 	} else if (cmd_match(buf, "blocked")) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index ce9eb6db0538..fcb6cce5a459 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -737,6 +737,8 @@ extern struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
+extern void mddev_create_wb_pool(struct mddev *mddev, struct md_rdev *rdev,
+				 bool is_suspend);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-- 
2.12.3

