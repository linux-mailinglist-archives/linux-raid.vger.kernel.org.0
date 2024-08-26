Return-Path: <linux-raid+bounces-2622-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF4895F3DB
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACD72836FE
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61B18C345;
	Mon, 26 Aug 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0cNKOvU"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FD18BC01
	for <linux-raid@vger.kernel.org>; Mon, 26 Aug 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682547; cv=none; b=g3uUFEf/us202WdyFzDdD40aum/dkngMGJ8H7GlpbYZLyQio4efFjek0oe40aBLHtJcvWAwk9AV9zcOctOKNJs1GFxLz4zLjyOXfpLukDFhydkIEaXLaGE4oM4Ff+G9NALsU89ujdQaNAW3p1GsMuHKK4/mntflYu+wahNk+ewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682547; c=relaxed/simple;
	bh=vu1Xh0B+SMWSJyqw4YUI9vNbYQ/VOCw74vA1rKmmWw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfHvXep4dMR1UJIgNBEYAVMXOmYSTSmdbQVQs3xru51WdTmyOLyUIAXfMG5x8KkTiUvZXfS6P7MfRXPodo5H/bQ74AWucpZ+JIItI6GSSYsCUoHNufXdWPOb9/iCqMYTFGAGhwJowBkggoBynEd3CBV9qL78fd6Du3fU+Y2ctg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0cNKOvU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724682545; x=1756218545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vu1Xh0B+SMWSJyqw4YUI9vNbYQ/VOCw74vA1rKmmWw4=;
  b=c0cNKOvUvmA2LVMsHm8D5kMGviJ+bKl4fYEecGAx2ymdEkyE3oDKySWw
   VUOPqQDmam3KempYkaa340KefH2YLzdsdeXiqw5kKkvCGAaG44X4SflFR
   fWCNjJjWevmQr2VqQ2GUpqLYGDDpyzDqwnY3IWiytB5Yy1zfwPd0cw2n0
   q9XUxgJuVk/uhKGCfxwpmNwiBDleSlQQXWGBnjvA5LOf2xkH2vKcfcQqu
   I2CVsXKassANKlUM7aYIhTl0IwKniuhXvJuFoK7Dk63UPQ5jmgccKlTbk
   GLLPt9y25QGtbEAU6qagSQ7chSWL6R2Lsy93gSoj2KmyUA42dV9MNo6Px
   Q==;
X-CSE-ConnectionGUID: ot6bN9D6S6GoA8XSniLAUw==
X-CSE-MsgGUID: VIdeOGF0QFC2NcRzxD6rZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34267880"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="34267880"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 07:29:05 -0700
X-CSE-ConnectionGUID: 0BH0apV7QtueW6vlgi33tA==
X-CSE-MsgGUID: ismVksD2R/uZE+0JF1a/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62844023"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by orviesa006.jf.intel.com with ESMTP; 26 Aug 2024 07:29:04 -0700
From: Kinga Stefaniuk <kinga.stefaniuk@intel.com>
To: linux-raid@vger.kernel.org
Cc: song@kernel.org,
	yukuai3@huawei.com
Subject: [PATCH v12 1/1] md: generate CHANGE uevents for md device
Date: Mon, 26 Aug 2024 16:28:56 +0200
Message-ID: <20240826142856.16612-2-kinga.stefaniuk@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826142856.16612-1-kinga.stefaniuk@intel.com>
References: <20240826142856.16612-1-kinga.stefaniuk@intel.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mdadm commit 49b69533e8 ("mdmonitor: check if udev has finished
events processing") mdmonitor has been learnt to wait for udev to finish
processing, and later in commit 9935cf0f64f3 ("Mdmonitor: Improve udev
event handling") pooling for MD events on /proc/mdstat file has been
deprecated because relying on udev events is more reliable and less bug
prone (we are not competing with udev).

After those changes we are still observing missing mdmonitor events in
some scenarios, especially SpareEvent is likely to be missed. With this
patch MD will be able to generate more change uevents and wakeup
mdmonitor more frequently to give it possibility to notice events.
MD has md_new_events() functionality to trigger events and with this
patch this function is extended to generate udev CHANGE uevents. It
cannot be done directly because this function is called on interrupts
context, so appropriate workqueue is created. Uevents are less time
critical, it is safe to use workqueue. It is limited to CHANGE event as
there is no need to generate other uevents for now.
With this change, mdmonitor events are less likely to be missed. Our
internal tests suite confirms that, mdmonitor reliability is (again)
improved.
Start using irq methods on all_mddevs_lock, because it can be reached
by interrupt context.

Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
Signed-off-by: Kinga Stefaniuk <kinga.stefaniuk@intel.com>

---
v12: change lock spin_lock/unlock methods on all_mddevs_lock
v11: use irq methods to lock/unlock all_mddevs_lock
v10: move mddev_get into md_new_event
v9: add using md_wq and fix if (sync) condition
v8: fix possible conflict with del_work by adding spin_lock,
    change default sync value to true, now false only on md_error
v7: add new work struct for these events, use md_misc_wq workqueue,
    fix work cancellation
v6: use another workqueue and only on md_error, make configurable
    if kobject_uevent is run immediately on event or queued
v5: fix flush_work missing and commit message fixes
v4: add more detailed commit message
v3: fix problems with calling function from interrupt context,
    add work_queue and queue events notification
v2: resolve merge conflicts with applying the patch

Signed-off-by: Kinga Stefaniuk <kinga.stefaniuk@intel.com>
---
 drivers/md/md.c     | 144 ++++++++++++++++++++++++++------------------
 drivers/md/md.h     |   3 +-
 drivers/md/raid10.c |   2 +-
 drivers/md/raid5.c  |   2 +-
 4 files changed, 91 insertions(+), 60 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d3a837506a36..530ac80be7ba 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -107,6 +107,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 static void mddev_detach(struct mddev *mddev);
 static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
 static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
+static inline struct mddev *mddev_get(struct mddev *mddev);
 
 /*
  * Default number of read corrections we'll attempt on an rdev
@@ -323,6 +324,24 @@ static int start_readonly;
  */
 static bool create_on_open = true;
 
+/*
+ * Enables to iterate over all existing md arrays
+ * all_mddevs_lock protects this list.
+ */
+static LIST_HEAD(all_mddevs);
+static DEFINE_SPINLOCK(all_mddevs_lock);
+
+/*
+ * Send every new event to the userspace.
+ */
+static void md_kobject_uevent_fn(struct work_struct *work)
+{
+	struct mddev *mddev = container_of(work, struct mddev, uevent_work);
+
+	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
+	mddev_put(mddev);
+}
+
 /*
  * We have a system wide 'event count' that is incremented
  * on any 'interesting' event, and readers of /proc/mdstat
@@ -335,20 +354,30 @@ static bool create_on_open = true;
  */
 static DECLARE_WAIT_QUEUE_HEAD(md_event_waiters);
 static atomic_t md_event_count;
-void md_new_event(void)
+
+void md_new_event(struct mddev *mddev, bool sync)
 {
 	atomic_inc(&md_event_count);
 	wake_up(&md_event_waiters);
+
+	if (mddev_is_dm(mddev))
+		return;
+
+	if (!sync) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&mddev->lock, flags);
+		mddev = mddev_get(mddev);
+		spin_unlock_irqrestore(&mddev->lock, flags);
+		if (mddev == NULL)
+			return;
+		queue_work(md_wq, &mddev->uevent_work);
+		return;
+	}
+	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
 }
 EXPORT_SYMBOL_GPL(md_new_event);
 
-/*
- * Enables to iterate over all existing md arrays
- * all_mddevs_lock protects this list.
- */
-static LIST_HEAD(all_mddevs);
-static DEFINE_SPINLOCK(all_mddevs_lock);
-
 static bool is_md_suspended(struct mddev *mddev)
 {
 	return percpu_ref_is_dying(&mddev->active_io);
@@ -720,7 +749,7 @@ void mddev_put(struct mddev *mddev)
 		return;
 
 	__mddev_put(mddev);
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 }
 
 static void md_safemode_timeout(struct timer_list *t);
@@ -773,6 +802,7 @@ int mddev_init(struct mddev *mddev)
 	mddev->resync_max = MaxSector;
 	mddev->level = LEVEL_NONE;
 
+	INIT_WORK(&mddev->uevent_work, md_kobject_uevent_fn);
 	INIT_WORK(&mddev->sync_work, md_start_sync);
 	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
 
@@ -835,7 +865,7 @@ static struct mddev *mddev_alloc(dev_t unit)
 	if (error)
 		goto out_free_new;
 
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	if (unit) {
 		error = -EEXIST;
 		if (mddev_find_locked(unit))
@@ -856,11 +886,11 @@ static struct mddev *mddev_alloc(dev_t unit)
 	}
 
 	list_add(&new->all_mddevs, &all_mddevs);
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 	return new;
 
 out_destroy_new:
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 	mddev_destroy(new);
 out_free_new:
 	kfree(new);
@@ -869,9 +899,9 @@ static struct mddev *mddev_alloc(dev_t unit)
 
 static void mddev_free(struct mddev *mddev)
 {
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	list_del(&mddev->all_mddevs);
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 
 	mddev_destroy(mddev);
 	kfree(mddev);
@@ -2898,7 +2928,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 	if (mddev->degraded)
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_new_event();
+	md_new_event(mddev, true);
 	return 0;
 }
 
@@ -3015,7 +3045,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 				md_kick_rdev_from_array(rdev);
 				if (mddev->pers)
 					set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-				md_new_event();
+				md_new_event(mddev, true);
 			}
 		}
 	} else if (cmd_match(buf, "writemostly")) {
@@ -3366,19 +3396,19 @@ static bool md_rdev_overlaps(struct md_rdev *rdev)
 	struct mddev *mddev;
 	struct md_rdev *rdev2;
 
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
 		if (test_bit(MD_DELETED, &mddev->flags))
 			continue;
 		rdev_for_each(rdev2, mddev) {
 			if (rdev != rdev2 && rdev->bdev == rdev2->bdev &&
 			    md_rdevs_overlap(rdev, rdev2)) {
-				spin_unlock(&all_mddevs_lock);
+				spin_unlock_irq(&all_mddevs_lock);
 				return true;
 			}
 		}
 	}
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 	return false;
 }
 
@@ -4131,7 +4161,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	if (!mddev->thread)
 		md_update_sb(mddev, 1);
 	sysfs_notify_dirent_safe(mddev->sysfs_level);
-	md_new_event();
+	md_new_event(mddev, true);
 	rv = len;
 out_unlock:
 	mddev_unlock_and_resume(mddev);
@@ -4658,7 +4688,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 		export_rdev(rdev, mddev);
 	mddev_unlock_and_resume(mddev);
 	if (!err)
-		md_new_event();
+		md_new_event(mddev, true);
 	return err ? err : len;
 }
 
@@ -5727,12 +5757,12 @@ md_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 
 	if (!entry->show)
 		return -EIO;
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	if (!mddev_get(mddev)) {
-		spin_unlock(&all_mddevs_lock);
+		spin_unlock_irq(&all_mddevs_lock);
 		return -EBUSY;
 	}
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 
 	rv = entry->show(mddev, page);
 	mddev_put(mddev);
@@ -5751,12 +5781,12 @@ md_attr_store(struct kobject *kobj, struct attribute *attr,
 		return -EIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	if (!mddev_get(mddev)) {
-		spin_unlock(&all_mddevs_lock);
+		spin_unlock_irq(&all_mddevs_lock);
 		return -EBUSY;
 	}
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 	rv = entry->store(mddev, page, length);
 	mddev_put(mddev);
 	return rv;
@@ -5901,16 +5931,16 @@ struct mddev *md_alloc(dev_t dev, char *name)
 		/* Need to ensure that 'name' is not a duplicate.
 		 */
 		struct mddev *mddev2;
-		spin_lock(&all_mddevs_lock);
+		spin_lock_irq(&all_mddevs_lock);
 
 		list_for_each_entry(mddev2, &all_mddevs, all_mddevs)
 			if (mddev2->gendisk &&
 			    strcmp(mddev2->gendisk->disk_name, name) == 0) {
-				spin_unlock(&all_mddevs_lock);
+				spin_unlock_irq(&all_mddevs_lock);
 				error = -EEXIST;
 				goto out_free_mddev;
 			}
-		spin_unlock(&all_mddevs_lock);
+		spin_unlock_irq(&all_mddevs_lock);
 	}
 	if (name && dev)
 		/*
@@ -6276,7 +6306,7 @@ int md_run(struct mddev *mddev)
 	if (mddev->sb_flags)
 		md_update_sb(mddev, 0);
 
-	md_new_event();
+	md_new_event(mddev, true);
 	return 0;
 
 bitmap_abort:
@@ -6635,7 +6665,7 @@ static int do_md_stop(struct mddev *mddev, int mode)
 		if (mddev->hold_active == UNTIL_STOP)
 			mddev->hold_active = 0;
 	}
-	md_new_event();
+	md_new_event(mddev, true);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	return 0;
 }
@@ -7131,7 +7161,7 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 	if (!mddev->thread)
 		md_update_sb(mddev, 1);
-	md_new_event();
+	md_new_event(mddev, true);
 
 	return 0;
 busy:
@@ -7202,7 +7232,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	 * array immediately.
 	 */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_new_event();
+	md_new_event(mddev, true);
 	return 0;
 
 abort_export:
@@ -7971,9 +8001,9 @@ static int md_open(struct gendisk *disk, blk_mode_t mode)
 	struct mddev *mddev;
 	int err;
 
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	mddev = mddev_get(disk->private_data);
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 	if (!mddev)
 		return -ENODEV;
 
@@ -8176,7 +8206,7 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 	}
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
-	md_new_event();
+	md_new_event(mddev, false);
 }
 EXPORT_SYMBOL(md_error);
 
@@ -8354,7 +8384,7 @@ static void *md_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(&all_mddevs_lock)
 {
 	seq->poll_event = atomic_read(&md_event_count);
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 
 	return seq_list_start_head(&all_mddevs, *pos);
 }
@@ -8367,7 +8397,7 @@ static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void md_seq_stop(struct seq_file *seq, void *v)
 	__releases(&all_mddevs_lock)
 {
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 }
 
 static int md_seq_show(struct seq_file *seq, void *v)
@@ -8387,7 +8417,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 	if (!mddev_get(mddev))
 		return 0;
 
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
@@ -8458,7 +8488,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 
 	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
 		status_unused(seq);
@@ -8987,7 +9017,7 @@ void md_do_sync(struct md_thread *thread)
 	try_again:
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
 			goto skip;
-		spin_lock(&all_mddevs_lock);
+		spin_lock_irq(&all_mddevs_lock);
 		list_for_each_entry(mddev2, &all_mddevs, all_mddevs) {
 			if (test_bit(MD_DELETED, &mddev2->flags))
 				continue;
@@ -9022,7 +9052,7 @@ void md_do_sync(struct md_thread *thread)
 							desc, mdname(mddev),
 							mdname(mddev2));
 					}
-					spin_unlock(&all_mddevs_lock);
+					spin_unlock_irq(&all_mddevs_lock);
 
 					if (signal_pending(current))
 						flush_signals(current);
@@ -9033,7 +9063,7 @@ void md_do_sync(struct md_thread *thread)
 				finish_wait(&resync_wait, &wq);
 			}
 		}
-		spin_unlock(&all_mddevs_lock);
+		spin_unlock_irq(&all_mddevs_lock);
 	} while (mddev->curr_resync < MD_RESYNC_DELAYED);
 
 	max_sectors = md_sync_max_sectors(mddev, action);
@@ -9073,7 +9103,7 @@ void md_do_sync(struct md_thread *thread)
 		mddev->curr_resync = MD_RESYNC_ACTIVE; /* no longer delayed */
 	mddev->curr_resync_completed = j;
 	sysfs_notify_dirent_safe(mddev->sysfs_completed);
-	md_new_event();
+	md_new_event(mddev, true);
 	update_time = jiffies;
 
 	blk_start_plug(&plug);
@@ -9145,7 +9175,7 @@ void md_do_sync(struct md_thread *thread)
 			/* this is the earliest that rebuild will be
 			 * visible in /proc/mdstat
 			 */
-			md_new_event();
+			md_new_event(mddev, true);
 
 		if (last_check + window > io_sectors || j == max_sectors)
 			continue;
@@ -9411,7 +9441,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 			sysfs_link_rdev(mddev, rdev);
 			if (!test_bit(Journal, &rdev->flags))
 				spares++;
-			md_new_event();
+			md_new_event(mddev, true);
 			set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 		}
 	}
@@ -9530,7 +9560,7 @@ static void md_start_sync(struct work_struct *ws)
 		__mddev_resume(mddev, false);
 	md_wakeup_thread(mddev->sync_thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
-	md_new_event();
+	md_new_event(mddev, true);
 	return;
 
 not_running:
@@ -9782,7 +9812,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
-	md_new_event();
+	md_new_event(mddev, true);
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
 	wake_up(&resync_wait);
@@ -9863,11 +9893,11 @@ static int md_notify_reboot(struct notifier_block *this,
 	struct mddev *mddev, *n;
 	int need_delay = 0;
 
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
 		if (!mddev_get(mddev))
 			continue;
-		spin_unlock(&all_mddevs_lock);
+		spin_unlock_irq(&all_mddevs_lock);
 		if (mddev_trylock(mddev)) {
 			if (mddev->pers)
 				__md_stop_writes(mddev);
@@ -9877,9 +9907,9 @@ static int md_notify_reboot(struct notifier_block *this,
 		}
 		need_delay = 1;
 		mddev_put(mddev);
-		spin_lock(&all_mddevs_lock);
+		spin_lock_irq(&all_mddevs_lock);
 	}
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 
 	/*
 	 * certain more exotic SCSI devices are known to be
@@ -10230,11 +10260,11 @@ static __exit void md_exit(void)
 	}
 	remove_proc_entry("mdstat", NULL);
 
-	spin_lock(&all_mddevs_lock);
+	spin_lock_irq(&all_mddevs_lock);
 	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
 		if (!mddev_get(mddev))
 			continue;
-		spin_unlock(&all_mddevs_lock);
+		spin_unlock_irq(&all_mddevs_lock);
 		export_array(mddev);
 		mddev->ctime = 0;
 		mddev->hold_active = 0;
@@ -10244,9 +10274,9 @@ static __exit void md_exit(void)
 		 * destroy_workqueue() below will wait for that to complete.
 		 */
 		mddev_put(mddev);
-		spin_lock(&all_mddevs_lock);
+		spin_lock_irq(&all_mddevs_lock);
 	}
-	spin_unlock(&all_mddevs_lock);
+	spin_unlock_irq(&all_mddevs_lock);
 
 	destroy_workqueue(md_misc_wq);
 	destroy_workqueue(md_bitmap_wq);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index a0d6827dced9..ab340618828c 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -582,6 +582,7 @@ struct mddev {
 						*/
 	struct work_struct flush_work;
 	struct work_struct event_work;	/* used by dm to report failure event */
+	struct work_struct uevent_work;
 	mempool_t *serial_info_pool;
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
 	struct md_cluster_info		*cluster_info;
@@ -883,7 +884,7 @@ extern int md_super_wait(struct mddev *mddev);
 extern int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		struct page *page, blk_opf_t opf, bool metadata_op);
 extern void md_do_sync(struct md_thread *thread);
-extern void md_new_event(void);
+extern void md_new_event(struct mddev *mddev, bool sync);
 extern void md_allow_write(struct mddev *mddev);
 extern void md_wait_for_blocked_rdev(struct md_rdev *rdev, struct mddev *mddev);
 extern void md_set_array_sectors(struct mddev *mddev, sector_t array_sectors);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 2a9c4ee982e0..f76571079845 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4542,7 +4542,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	conf->reshape_checkpoint = jiffies;
-	md_new_event();
+	md_new_event(mddev, true);
 	return 0;
 
 abort:
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c14cf2410365..9da091b000d7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8525,7 +8525,7 @@ static int raid5_start_reshape(struct mddev *mddev)
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	conf->reshape_checkpoint = jiffies;
-	md_new_event();
+	md_new_event(mddev, true);
 	return 0;
 }
 
-- 
2.43.0


