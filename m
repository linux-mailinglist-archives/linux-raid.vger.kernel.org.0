Return-Path: <linux-raid+bounces-3532-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0CA1C711
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jan 2025 09:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD13A8170
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jan 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190914F9F3;
	Sun, 26 Jan 2025 08:42:32 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F433FB1B;
	Sun, 26 Jan 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737880952; cv=none; b=f8W4n2sjGseHu/qUPkEXgMkjYTgWk4bzy/T2xFgcVkk5QSb5mDBcP5DrflBdDK02UfZymJ9yIngCZ9qn/U2joUHbaIOZKvrZdeQuyorNKCaUNuUXFtkZTKJ4WwQ668hfX+4KXWFXPAfxSLtm4GPR2dWzhaAys7Tmq+5RdpN+Jws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737880952; c=relaxed/simple;
	bh=T0LSqFIKqxaB3sWrSg2bTFiKGZlwT3K+JKP2y81zL7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQ7pzTIYYcvp3jq/3pYi4S9Bmi5w02N/Fmif7Pe+Ay8n+RfskL0Dlxgf7ZdYr7QpEx6CRmFRos0ooaWmlXEGy9rzpH2BWJrQXeVZWS+jnYzrB3PXj884D8AEbbCdX/eJHDpa778GzUTk5fnEl5J6ug3SOqqLzLBZcujfME8xg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YglQy5Cbhz4f3jMF;
	Sun, 26 Jan 2025 16:42:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C08031A09FA;
	Sun, 26 Jan 2025 16:42:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAXa8Vt9ZVntan_Bw--.50248S4;
	Sun, 26 Jan 2025 16:42:22 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	song@kernel.org,
	yukuai3@huawei.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC] md: introduce llbitmap
Date: Sun, 26 Jan 2025 16:36:24 +0800
Message-Id: <20250126083624.1675849-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXa8Vt9ZVntan_Bw--.50248S4
X-Coremail-Antispam: 1UD129KBjvAXoWDJw4kuw4xAr48Zw4UtFy7ZFb_yoWrCFy7Jo
	WfZr9xXr48Xr1UWryDAr1YyFy3Ww18Kw1Yy34akFs8Wa1UJ3W0vw4fGrW3Grn0qrWYvr47
	tF97Xw4rWF48GrWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This is still one huge patch for now, not quite friendly to review. :(
Main purpose of this RFC version is to make sure people will agree at
the design, and perhaps can help to test this version. :) I already do
some basic functional test myself.

Background

Redundant data is used to enhance data fault tolerance, and the storage
method for redundant data vary depending on the RAID levels. And it's
important to maintain the consistency of redundant data.

Bitmap is used to record which data blocks have been synchronized and which
ones need to be resynchronized or recovered. Each bit in the bitmap
represents a segment of data in the array. When a bit is set, it indicates
that the multiple redundant copies of that data segment may not be
consistent. Data synchronization can be performed based on the bitmap after
power failure or readding a disk. If there is no bitmap, a full disk
synchronization is required.

Bitmap IO

A hidden disk, named mdxxx_bitmap, is created for bitmap, see details in
llbitmap_add_disk(). And a file is created as well to manage bitmap IO for
this disk, see details in llbitmap_open_disk(). Read/write bitmap is
converted to buffer IO to this file.

State Machine

Each bit is one byte, contain 6 difference state, see llbitmap_state. And
there are total 8 differenct actions, see llbitmap_action, can change state:

llbitmap state machine: transitions between states

|           | Startwrite | Startsync | Endsync | Abortsync| Reload   | Daemon | Discard   | Stale     |
| --------- | ---------- | --------- | ------- | -------  | -------- | ------ | --------- | --------- |
| Unwritten | Dirty      | x         | x       | x        | x        | x      | x         | x         |
| Clean     | Dirty      | x         | x       | x        | x        | x      | Unwritten | NeedSync  |
| Dirty     | x          | x         | x       | x        | NeedSync | Clean  | Unwritten | NeedSync  |
| NeedSync  | x          | Syncing   | x       | x        | x        | x      | Unwritten | x         |
| Syncing   | x          | Syncing   | Dirty   | NeedSync | NeedSync | x      | Unwritten | NeedSync  |

special illustration:
- Unwritten is special state, which means user never write data, hence there
  is no need to resync/recover data. This is safe if user create filesystems
  for the array, filesystem will make sure user will get zero data for
  unwritten blocks.
- After resync is done, change state from Syncing to Dirty first, in case
  Startwrite happen before the state is Clean.

How to use llbitmap(for RFC version, will probably Changes):
please apply the other patch for mdadm first[1].

```
echo 2 > /sys/module/md_mod/parameters/default_bitmap_version
mdadm --bitmap=lockless
```

[1]: https://lore.kernel.org/all/20250126082714.1588025-1-yukuai1@huaweicloud.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c             |   21 +-
 drivers/md/Kconfig       |   12 +
 drivers/md/Makefile      |    2 +-
 drivers/md/md-bitmap.c   |    7 +
 drivers/md/md-bitmap.h   |   20 +-
 drivers/md/md-llbitmap.c | 1203 ++++++++++++++++++++++++++++++++++++++
 drivers/md/md.c          |   11 +-
 drivers/md/md.h          |    3 +
 drivers/md/raid1-10.c    |    2 -
 include/linux/blkdev.h   |    1 +
 10 files changed, 1266 insertions(+), 16 deletions(-)
 create mode 100644 drivers/md/md-llbitmap.c

diff --git a/block/bdev.c b/block/bdev.c
index 9d73a8fbf7f9..6b4ba6cb04c9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -989,12 +989,26 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
 	return flags;
 }
 
+struct file *bdev_file_alloc(struct block_device *bdev, blk_mode_t mode)
+{
+	unsigned int flags = blk_to_file_flags(mode);
+	struct file *bdev_file;
+
+	bdev_file = alloc_file_pseudo_noaccount(BD_INODE(bdev),
+			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
+
+	if (!IS_ERR(bdev_file))
+		ihold(BD_INODE(bdev));
+
+	return bdev_file;
+}
+EXPORT_SYMBOL_GPL(bdev_file_alloc);
+
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 				   const struct blk_holder_ops *hops)
 {
 	struct file *bdev_file;
 	struct block_device *bdev;
-	unsigned int flags;
 	int ret;
 
 	ret = bdev_permission(dev, mode, holder);
@@ -1005,14 +1019,11 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (!bdev)
 		return ERR_PTR(-ENXIO);
 
-	flags = blk_to_file_flags(mode);
-	bdev_file = alloc_file_pseudo_noaccount(BD_INODE(bdev),
-			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
+	bdev_file = bdev_file_alloc(bdev, mode);
 	if (IS_ERR(bdev_file)) {
 		blkdev_put_no_open(bdev);
 		return bdev_file;
 	}
-	ihold(BD_INODE(bdev));
 
 	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
 	if (ret) {
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 0da07182494c..e5dc893ad09a 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -52,6 +52,18 @@ config MD_BITMAP
 
 	  If unsure, say Y.
 
+config MD_LLBITMAP
+	bool "MD RAID lockless bitmap support"
+	default n
+	depends on BLK_DEV_MD
+	help
+	  If you say Y here, support for the lockless write intent bitmap will
+	  be enabled.
+
+	  Note, this is an experimental feature.
+
+	  If unsure, say N.
+
 config MD_AUTODETECT
 	bool "Autodetect RAID arrays during kernel boot"
 	depends on BLK_DEV_MD=y
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 87bdfc9fe14c..f1ca25cc1408 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -27,7 +27,7 @@ dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
-md-mod-y	+= md.o md-bitmap.o
+md-mod-y	+= md.o md-bitmap.o md-llbitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
 linear-y       += md-linear.o
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index a1bfb3669f3c..63879582d1c3 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -212,6 +212,13 @@ struct bitmap {
 	int cluster_slot;
 };
 
+/* use these for bitmap->flags and bitmap->sb->state bit-fields */
+enum bitmap_state {
+	BITMAP_STALE	   = 1,  /* the bitmap file is out of date or had -EIO */
+	BITMAP_WRITE_ERROR = 2, /* A write error has occurred */
+	BITMAP_HOSTENDIAN  = 15,
+};
+
 static struct workqueue_struct *md_bitmap_wq;
 
 static int __bitmap_resize(struct bitmap *bitmap, sector_t blocks,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 1c716b54b4a8..7eae43d0035d 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -18,13 +18,6 @@ typedef __u16 bitmap_counter_t;
 #define RESYNC_MASK ((bitmap_counter_t) (1 << (COUNTER_BITS - 2)))
 #define COUNTER_MAX ((bitmap_counter_t) RESYNC_MASK - 1)
 
-/* use these for bitmap->flags and bitmap->sb->state bit-fields */
-enum bitmap_state {
-	BITMAP_STALE	   = 1,  /* the bitmap file is out of date or had -EIO */
-	BITMAP_WRITE_ERROR = 2, /* A write error has occurred */
-	BITMAP_HOSTENDIAN  =15,
-};
-
 /* the superblock at the front of the bitmap file -- little endian */
 typedef struct bitmap_super_s {
 	__le32 magic;        /*  0  BITMAP_MAGIC */
@@ -173,4 +166,17 @@ static inline void md_bitmap_exit(void)
 }
 #endif
 
+#ifdef CONFIG_MD_LLBITMAP
+extern int md_llbitmap_init(void);
+extern void md_llbitmap_exit(void);
+#else
+static inline int md_llbitmap_init(void)
+{
+	return 0;
+}
+static inline void md_llbitmap_exit(void)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/md/md-llbitmap.c b/drivers/md/md-llbitmap.c
new file mode 100644
index 000000000000..129b36abae4d
--- /dev/null
+++ b/drivers/md/md-llbitmap.c
@@ -0,0 +1,1203 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/buffer_head.h>
+#include <linux/seq_file.h>
+#include <trace/events/block.h>
+
+#include "md.h"
+#include "md-bitmap.h"
+
+/*
+ * #### Background
+ *
+ * Redundant data is used to enhance data fault tolerance, and the storage
+ * method for redundant data vary depending on the RAID levels. And it's
+ * important to maintain the consistency of redundant data.
+ *
+ * Bitmap is used to record which data blocks have been synchronized and which
+ * ones need to be resynchronized or recovered. Each bit in the bitmap
+ * represents a segment of data in the array. When a bit is set, it indicates
+ * that the multiple redundant copies of that data segment may not be
+ * consistent. Data synchronization can be performed based on the bitmap after
+ * power failure or readding a disk. If there is no bitmap, a full disk
+ * synchronization is required.
+ *
+ * #### Key Concept
+ *
+ * ##### Bitmap IO
+ *
+ * A hidden disk, named mdxxx_bitmap, is created for bitmap, see details in
+ * llbitmap_add_disk(). And a file is created as well to manage bitmap IO for
+ * this disk, see details in llbitmap_open_disk(). Read/write bitmap is
+ * converted to buffer IO to this file.
+ *
+ * ##### State Machine
+ *
+ * Each bit is one byte, contain 6 difference state, see llbitmap_state. And
+ * there are total 8 differenct actions, see llbitmap_action, can change state:
+ *
+ * llbitmap state machine: transitions between states
+ *
+ * |           | Startwrite | Startsync | Endsync | Abortsync| Reload   | Daemon | Discard   | Stale     |
+ * | --------- | ---------- | --------- | ------- | -------  | -------- | ------ | --------- | --------- |
+ * | Unwritten | Dirty      | x         | x       | x        | x        | x      | x         | x         |
+ * | Clean     | Dirty      | x         | x       | x        | x        | x      | Unwritten | NeedSync  |
+ * | Dirty     | x          | x         | x       | x        | NeedSync | Clean  | Unwritten | NeedSync  |
+ * | NeedSync  | x          | Syncing   | x       | x        | x        | x      | Unwritten | x         |
+ * | Syncing   | x          | Syncing   | Dirty   | NeedSync | NeedSync | x      | Unwritten | NeedSync  |
+ *
+ * special illustration:
+ * - Unwritten is special state, which means user never write data, hence there
+ *   is no need to resync/recover data. This is safe if user create filesystems
+ *   for the array, filesystem will make sure user will get zero data for
+ *   unwritten blocks.
+ * - After resync is done, change state from Syncing to Dirty first, in case
+ *   Startwrite happen before the state is Clean.
+ */
+
+#define LLBITMAP_MAJOR_HI 6
+
+/* bitmap is 4K super_block + 4k-64k data */
+#define BITMAP_MAX_SECTOR ((64 + 4) * 2)
+#define BITMAP_SB_SIZE 4096
+
+#define DEFAULT_DAEMON_SLEEP 30
+
+enum llbitmap_flags {
+	/* bitmap is out of date, full recovery is needed */
+	LLB_STALE = 0,
+	/* bitmap IO from all underlying disks failed */
+	LLB_ERROR,
+	/* first use, initialize bitmap */
+	LLB_FIRST_USE,
+};
+
+enum llbitmap_state {
+	/* No valid data, init state after assemble the array */
+	BitUnwritten = 0,
+	/* data is consistent */
+	BitClean,
+	/* data will be consistent after IO is done, set directly for writes */
+	BitDirty,
+	/*
+	 * data need to be resynchronized:
+	 * 1) set directly for writes if array is degraded, prevent full disk
+	 * synchronization after readding a disk;
+	 * 2) reassemble the array after power failure, and dirty bits are
+	 * found after reloading the bitmap;
+	 * */
+	BitNeedSync,
+	/* data is synchronizing */
+	BitSyncing,
+	nr_llbitmap_state,
+	BitNone = 0xff,
+};
+
+enum llbitmap_action {
+	/* User write new data, this is the only acton from IO fast path */
+	BitmapActionStartwrite = 0,
+	/* Start recovery */
+	BitmapActionStartsync,
+	/* Finish recovery */
+	BitmapActionEndsync,
+	/* Failed recovery */
+	BitmapActionAbortsync,
+	/* Reassemble the array */
+	BitmapActionReload,
+	/* Daemon thread is trying to clear dirty bits */
+	BitmapActionDaemon,
+	/* Data is deleted */
+	BitmapActionDiscard,
+	/*
+	 * Bitmap is stale, mark all bits in addition to BitUnwritten to
+	 * BitNeedSync.
+	 */
+	BitmapActionStale,
+	nr_llbitmap_action,
+	/* Init state is BitUnwritten */
+	BitmapActionInit,
+};
+
+struct llbitmap {
+	struct mddev *mddev;
+	/* hidden disk to manage bitmap IO */
+	struct gendisk *bitmap_disk;
+	/* opened hidden disk */
+	struct file *bitmap_file;
+
+	struct bio_set bio_set;
+	struct bio_list retry_list;
+	struct work_struct retry_work;
+	spinlock_t retry_lock;
+
+	/* shift of one chunk */
+	unsigned long chunkshift;
+	/* size of one chunk in sector */
+	unsigned long chunksize;
+	/* total number of chunks */
+	unsigned long chunks;
+	/* fires on first BitDirty state */
+	struct timer_list pending_timer;
+	struct work_struct daemon_work;
+
+	unsigned long flags;
+	__u64	events_cleared;
+};
+
+struct llbitmap_bio {
+	struct md_rdev *rdev;
+	struct bio bio;
+};
+
+struct llbitmap_unplug_work {
+	struct work_struct work;
+	struct llbitmap *llbitmap;
+	struct completion *done;
+};
+
+struct llbitmap_page_work {
+	struct work_struct work;
+	struct file *bitmap_file;
+	struct completion *done;
+	unsigned long page_idx;
+	struct page *page;
+};
+
+static char state_machine[nr_llbitmap_state][nr_llbitmap_action] = {
+	[BitUnwritten] = {BitDirty, BitNone, BitNone, BitNone, BitNone, BitNone, BitNone, BitNone},
+	[BitClean] = {BitDirty, BitNone, BitNone, BitNone, BitNone, BitNone, BitUnwritten, BitNeedSync},
+	[BitDirty] = {BitNone, BitNone, BitNone, BitNone, BitNeedSync, BitClean, BitUnwritten, BitNeedSync},
+	[BitNeedSync] = {BitNone, BitSyncing, BitNone, BitNone, BitNone, BitNone, BitUnwritten, BitNone},
+	[BitSyncing] = {BitNone, BitSyncing, BitDirty, BitNeedSync, BitNeedSync, BitNone, BitUnwritten, BitNeedSync},
+};
+
+static struct workqueue_struct *md_llbitmap_wq;
+
+static void llbitmap_read_page_fn(struct work_struct *work)
+{
+	struct llbitmap_page_work *page_work =
+		container_of(work, struct llbitmap_page_work, work);
+
+	page_work->page = read_mapping_page(page_work->bitmap_file->f_mapping,
+					    page_work->page_idx, NULL);
+	complete(page_work->done);
+}
+
+static enum llbitmap_state state_from_page(struct page *page, loff_t pos)
+{
+	u8 *p = kmap_local_page(page);
+	enum llbitmap_state state = p[offset_in_page(pos)];
+
+	kunmap_local(p);
+	return state;
+}
+
+static void state_to_page(struct page *page, enum llbitmap_state state,
+			  loff_t pos)
+{
+	u8 *p = kmap_local_page(page);
+
+	p[offset_in_page(pos)] = state;
+	set_page_dirty(page);
+	kunmap_local(p);
+}
+
+/*
+ * If there is no page, read in the page asynchronously, because issue
+ * and wait for new IO under submit_bio() context will deadlock.
+ */
+static struct page *llbitmap_read_page_async(struct file *bitmap_file,
+					     loff_t pos)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct llbitmap_page_work page_work = {
+		.bitmap_file = bitmap_file,
+		.page_idx = (pos >> PAGE_SHIFT) + 1,
+		.done = &done,
+	};
+
+	INIT_WORK_ONSTACK(&page_work.work, llbitmap_read_page_fn);
+	queue_work(md_llbitmap_wq, &page_work.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&page_work.work);
+
+	return page_work.page;
+}
+
+static int llbitmap_read(struct file *bitmap_file, enum llbitmap_state *state,
+			 loff_t pos)
+{
+	unsigned long page_idx = (pos >> PAGE_SHIFT) + 1;
+	struct page *page;
+
+	page = find_get_page(bitmap_file->f_mapping, page_idx);
+	if (page && !PageUptodate(page)) {
+		put_page(page);
+		page = NULL;
+	}
+
+	if (unlikely(!page))
+		page = llbitmap_read_page_async(bitmap_file, pos);
+
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	*state = state_from_page(page, pos);
+	put_page(page);
+	return 0;
+}
+
+static int llbitmap_write(struct file *bitmap_file, enum llbitmap_state state,
+			  loff_t pos)
+{
+	unsigned long page_idx = (pos >> PAGE_SHIFT) + 1;
+	struct page *page;
+
+	page = find_get_page(bitmap_file->f_mapping, page_idx);
+	if (page && !PageUptodate(page)) {
+		put_page(page);
+		page = NULL;
+	}
+
+	if (unlikely(!page))
+		page = llbitmap_read_page_async(bitmap_file, pos);
+
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	state_to_page(page, state, pos);
+	put_page(page);
+	return 0;
+}
+
+/* The return value is only used from resync, where @start == @end. */
+static enum llbitmap_state llbitmap_state_machine(struct llbitmap *llbitmap,
+						  unsigned long start,
+						  unsigned long end,
+						  enum llbitmap_action action)
+{
+	bool need_recovery = false;
+	enum llbitmap_state state = BitNone;
+
+	if (test_bit(LLB_ERROR, &llbitmap->flags))
+		return BitNone;
+
+	while (start <= end) {
+		ssize_t ret;
+		enum llbitmap_state c;
+
+		if (action == BitmapActionInit) {
+			state = BitUnwritten;
+			ret = llbitmap_write(llbitmap->bitmap_file, state, start);
+			if (ret < 0) {
+				set_bit(LLB_ERROR, &llbitmap->flags);
+				return BitNone;
+			}
+
+			start++;
+			continue;
+		}
+
+		ret = llbitmap_read(llbitmap->bitmap_file, &c, start);
+		if (ret < 0) {
+			set_bit(LLB_ERROR, &llbitmap->flags);
+			return BitNone;
+		}
+
+		if (c < 0 || c >= nr_llbitmap_state) {
+			pr_err("%s: invalid bit %lu state %d action %d, forcing resync\n",
+			       __func__, start, c, action);
+			c = BitNeedSync;
+			goto write_bitmap;
+		}
+
+		if (c == BitNeedSync)
+			need_recovery = true;
+
+		state = state_machine[c][action];
+		if (state == BitNone) {
+			start++;
+			continue;
+		}
+
+		if (state == BitNeedSync)
+			need_recovery = true;
+		else if (state == BitDirty)
+			/*
+			 * For Startwrite, clear BitDirty after daemon_sleep,
+			 * For Endsync, clear BitDirty immediately.
+			 */
+			timer_reduce(&llbitmap->pending_timer, jiffies +
+				action == BitmapActionStartwrite ?
+				llbitmap->mddev->bitmap_info.daemon_sleep * HZ : 1);
+write_bitmap:
+		ret = llbitmap_write(llbitmap->bitmap_file, state, start);
+		if (ret < 0) {
+			set_bit(LLB_ERROR, &llbitmap->flags);
+			return BitNone;
+		}
+
+		start++;
+	}
+
+	if (need_recovery) {
+		struct mddev *mddev = llbitmap->mddev;
+
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		md_wakeup_thread(mddev->thread);
+	}
+
+	return state;
+}
+
+static void llbitmap_end_write(struct bio *bio)
+{
+	struct bio *parent = bio->bi_private;
+	struct llbitmap_bio *llbitmap_bio;
+	struct md_rdev *rdev;
+
+	if (bio->bi_status == BLK_STS_OK) {
+		WRITE_ONCE(parent->bi_status, BLK_STS_OK);
+	} else {
+		llbitmap_bio = container_of(bio, struct llbitmap_bio, bio);
+		rdev = llbitmap_bio->rdev;
+
+		pr_err("%s: %s: bitmap write failed for %pg\n", __func__,
+		       mdname(rdev->mddev), rdev->bdev);
+		md_error(rdev->mddev, rdev);
+	}
+
+	bio_put(bio);
+	bio_endio(parent);
+}
+
+static void md_llbitmap_retry_bio(struct llbitmap *llbitmap, struct bio *bio)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&llbitmap->retry_lock, flags);
+	bio_list_add(&llbitmap->retry_list, bio);
+	queue_work(md_llbitmap_wq, &llbitmap->retry_work);
+	spin_unlock_irqrestore(&llbitmap->retry_lock, flags);
+}
+
+static void llbitmap_end_read(struct bio *bio)
+{
+	struct bio *parent = bio->bi_private;
+	struct llbitmap_bio *llbitmap_bio;
+	struct llbitmap *llbitmap;
+	struct md_rdev *rdev;
+
+	if (bio->bi_status == BLK_STS_OK) {
+		WRITE_ONCE(parent->bi_status, BLK_STS_OK);
+		bio_put(bio);
+		bio_endio(parent);
+		return;
+	}
+
+	llbitmap_bio = container_of(bio, struct llbitmap_bio, bio);
+	rdev = llbitmap_bio->rdev;
+	pr_err("%s: %s: bitmap read failed for %pg\n", __func__,
+	       mdname(rdev->mddev), rdev->bdev);
+	md_error(rdev->mddev, rdev);
+	bio_put(bio);
+	md_llbitmap_retry_bio(llbitmap, parent);
+}
+
+static void md_llbitmap_retry_fn(struct work_struct *work)
+{
+	struct llbitmap *llbitmap =
+		container_of(work, struct llbitmap, retry_work);
+	struct mddev *mddev = llbitmap->mddev;
+	struct md_rdev *rdev;
+	struct bio *bio;
+
+again:
+	spin_lock_irq(&llbitmap->retry_lock);
+	bio = bio_list_pop(&llbitmap->retry_list);
+	spin_unlock_irq(&llbitmap->retry_lock);
+
+	if (!bio)
+		return;
+
+	rdev_for_each(rdev, mddev) {
+		struct llbitmap_bio *llbitmap_bio;
+		struct bio *new;
+
+		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+			continue;
+
+		new = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
+				      &llbitmap->bio_set);
+		new->bi_iter.bi_sector = bio->bi_iter.bi_sector +
+					 rdev->sb_start +
+					 mddev->bitmap_info.offset;
+		new->bi_opf |= REQ_SYNC | REQ_IDLE | REQ_META;
+		new->bi_private = bio;
+		new->bi_end_io = llbitmap_end_read;
+
+		llbitmap_bio = container_of(new, struct llbitmap_bio, bio);
+		llbitmap_bio->rdev = rdev;
+
+		submit_bio_noacct(new);
+		goto again;
+	}
+}
+
+static void llbitmap_submit_bio(struct bio *bio)
+{
+	struct mddev *mddev = bio->bi_bdev->bd_disk->private_data;
+	struct llbitmap *llbitmap = mddev->bitmap;
+	struct llbitmap_bio *llbitmap_bio;
+	struct md_rdev *rdev;
+	struct bio *new;
+
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH))
+		bio->bi_opf &= ~REQ_PREFLUSH;
+
+	if (!bio_sectors(bio)) {
+		bio_endio(bio);
+		return;
+	}
+
+	/* status will be cleared if any member disk IO succeed */
+	bio->bi_status = BLK_STS_IOERR;
+
+	rdev_for_each(rdev, mddev) {
+		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+			continue;
+
+		new = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
+				      &llbitmap->bio_set);
+		new->bi_iter.bi_sector = bio->bi_iter.bi_sector +
+					 rdev->sb_start +
+					 mddev->bitmap_info.offset;
+		new->bi_opf |= REQ_SYNC | REQ_IDLE | REQ_META;
+
+		llbitmap_bio = container_of(new, struct llbitmap_bio, bio);
+		llbitmap_bio->rdev = rdev;
+		bio_inc_remaining(bio);
+		new->bi_private = bio;
+
+		if (bio_data_dir(bio) == WRITE) {
+			new->bi_end_io = llbitmap_end_write;
+			new->bi_opf |= REQ_FUA;
+			submit_bio_noacct(new);
+			continue;
+		}
+
+		new->bi_end_io = llbitmap_end_read;
+		submit_bio_noacct(new);
+		break;
+	}
+
+	bio_endio(bio);
+}
+
+const struct block_device_operations llbitmap_fops = {
+	.owner = THIS_MODULE,
+	.submit_bio = llbitmap_submit_bio,
+};
+
+static int llbitmap_add_disk(struct llbitmap *llbitmap)
+{
+	struct mddev *mddev = llbitmap->mddev;
+	struct gendisk *disk = blk_alloc_disk(&mddev->gendisk->queue->limits,
+					      NUMA_NO_NODE);
+	int ret;
+
+	if (IS_ERR(disk))
+		return PTR_ERR(disk);
+
+	sprintf(disk->disk_name, "%s_bitmap", mdname(mddev));
+	disk->flags |= GENHD_FL_HIDDEN;
+	disk->fops = &llbitmap_fops;
+
+	ret = add_disk(disk);
+	if (ret) {
+		put_disk(disk);
+		return ret;
+	}
+
+	set_capacity(disk, BITMAP_MAX_SECTOR);
+	disk->private_data = mddev;
+	llbitmap->bitmap_disk = disk;
+	return 0;
+}
+
+static void llbitmap_del_disk(struct llbitmap *llbitmap)
+{
+	struct gendisk *disk = llbitmap->bitmap_disk;
+
+	if (!disk)
+		return;
+
+	llbitmap->bitmap_disk = NULL;
+	del_gendisk(disk);
+	put_disk(disk);
+}
+
+static int llbitmap_open_disk(struct llbitmap *llbitmap)
+{
+	struct gendisk *disk = llbitmap->bitmap_disk;
+	struct file *bitmap_file;
+
+	bitmap_file = bdev_file_alloc(disk->part0,
+				      BLK_OPEN_READ | BLK_OPEN_WRITE);
+	if (IS_ERR(bitmap_file))
+		return PTR_ERR(bitmap_file);
+
+	/* corresponding to the blkdev_put_no_open() from blkdev_release() */
+	get_device(disk_to_dev(disk));
+
+	bitmap_file->f_flags |= O_LARGEFILE;
+	bitmap_file->f_mode |= FMODE_CAN_ODIRECT;
+	bitmap_file->f_mapping = disk->part0->bd_mapping;
+	bitmap_file->f_wb_err = filemap_sample_wb_err(bitmap_file->f_mapping);
+
+	/* not actually opened, let blkdev_release() know */
+	bitmap_file->private_data = ERR_PTR(-ENODEV);
+	llbitmap->bitmap_file = bitmap_file;
+	return 0;
+}
+
+static void llbitmap_close_disk(struct llbitmap *llbitmap)
+{
+	struct file *bitmap_file = llbitmap->bitmap_file;
+
+	if (!bitmap_file)
+		return;
+
+	llbitmap->bitmap_file = NULL;
+	fput(bitmap_file);
+}
+
+static bool llbitmap_enabled(void *data)
+{
+	struct llbitmap *llbitmap = data;
+
+	return llbitmap && !test_bit(LLB_ERROR, &llbitmap->flags);
+}
+
+static int llbitmap_check_support(struct mddev *mddev, int slot)
+{
+	if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
+		pr_notice("md/llbitmap: %s: array with journal cannot have bitmap\n",
+			  mdname(mddev));
+		return -EBUSY;
+	}
+
+	if (mddev->bitmap_info.space == 0) {
+		if (mddev->bitmap_info.default_space == 0) {
+			pr_notice("md/llbitmap: %s: no space for bitmap\n",
+				  mdname(mddev));
+			return -ENOSPC;
+		}
+
+		mddev->bitmap_info.space = mddev->bitmap_info.default_space;
+	}
+
+	if (!mddev->persistent) {
+		pr_notice("md/llbitmap: %s: array must be persistent\n",
+			  mdname(mddev));
+		return -EOPNOTSUPP;
+	}
+
+	if (mddev->bitmap_info.file) {
+		pr_notice("md/llbitmap: %s: doesn't support bitmap file\n",
+			  mdname(mddev));
+		return -EOPNOTSUPP;
+	}
+
+	if (mddev->bitmap_info.external) {
+		pr_notice("md/llbitmap: %s: doesn't support external metadata\n",
+			  mdname(mddev));
+		return -EOPNOTSUPP;
+	}
+
+	if (slot != -1) {
+		pr_notice("md/llbitmap: %s; doesn't support md-cluster\n",
+			  mdname(mddev));
+		return -EOPNOTSUPP;
+	}
+
+	if (mddev_is_dm(mddev)) {
+		pr_notice("md/llbitmap: %s: doesn't support dm-raid\n",
+			  mdname(mddev));
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int llbitmap_init(struct llbitmap *llbitmap)
+{
+	struct mddev *mddev = llbitmap->mddev;
+	sector_t blocks = mddev->resync_max_sectors;
+	unsigned long chunksize = RESYNC_BLOCK_SIZE >> SECTOR_SHIFT;
+	unsigned long chunks = DIV_ROUND_UP(blocks, chunksize);
+	unsigned long space = mddev->bitmap_info.space << SECTOR_SHIFT;
+
+	while (chunks > space) {
+		chunksize = chunksize << 1;
+		chunks = DIV_ROUND_UP(blocks, chunksize);
+	}
+
+	llbitmap->chunkshift = ffz(~chunksize);
+	llbitmap->chunksize = chunksize;
+	llbitmap->chunks = chunks;
+	mddev->bitmap_info.daemon_sleep = DEFAULT_DAEMON_SLEEP;
+
+	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1, BitmapActionInit);
+	return 0;
+}
+
+static int llbitmap_read_sb(struct llbitmap *llbitmap)
+{
+	struct mddev *mddev = llbitmap->mddev;
+	unsigned long daemon_sleep;
+	unsigned long chunksize;
+	unsigned long events;
+	struct page *sb_page;
+	bitmap_super_t *sb;
+	int ret = -EINVAL;
+
+	if (!mddev->bitmap_info.offset) {
+		pr_err("md/llbitmap: %s: no super block found", mdname(mddev));
+		return -EINVAL;
+	}
+
+	sb_page = read_mapping_page(llbitmap->bitmap_file->f_mapping, 0, NULL);
+	if (IS_ERR(sb_page)) {
+		pr_err("md/llbitmap: %s: read super block failed",
+		       mdname(mddev));
+		ret = -EIO;
+		goto out;
+	}
+
+	sb = kmap_local_page(sb_page);
+	if (sb->magic != cpu_to_le32(BITMAP_MAGIC)) {
+		pr_err("md/llbitmap: %s: invalid super block magic number",
+		       mdname(mddev));
+		goto out_put_page;
+	}
+
+	if (sb->version != cpu_to_le32(LLBITMAP_MAJOR_HI)) {
+		pr_err("md/llbitmap: %s: invalid super block version",
+		       mdname(mddev));
+		goto out_put_page;
+	}
+
+	if (memcmp(sb->uuid, mddev->uuid, 16)) {
+		pr_err("md/llbitmap: %s: bitmap superblock UUID mismatch\n",
+		       mdname(mddev));
+		goto out_put_page;
+	}
+
+	llbitmap->flags = le32_to_cpu(sb->state);
+	if (test_and_clear_bit(LLB_FIRST_USE, &llbitmap->flags))
+		return llbitmap_init(llbitmap);
+
+	chunksize = le32_to_cpu(sb->chunksize);
+	if (!is_power_of_2(chunksize)) {
+		pr_err("md/llbitmap: %s: chunksize not a power of 2",
+		       mdname(mddev));
+		goto out_put_page;
+	}
+
+	if (chunksize < DIV_ROUND_UP(mddev->resync_max_sectors,
+				     mddev->bitmap_info.space << SECTOR_SHIFT)) {
+		pr_err("md/llbitmap: %s: chunksize too small %lu < %llu / %lu",
+		       mdname(mddev), chunksize, mddev->resync_max_sectors,
+		       mddev->bitmap_info.space);
+		goto out_put_page;
+	}
+
+	daemon_sleep = le32_to_cpu(sb->daemon_sleep);
+	if (daemon_sleep < 1 || daemon_sleep > MAX_SCHEDULE_TIMEOUT / HZ) {
+		pr_err("md/llbitmap: %s: daemon sleep %lu period out of range",
+		       mdname(mddev), daemon_sleep);
+		goto out_put_page;
+	}
+
+	if (le32_to_cpu(sb->write_behind))
+		pr_warn("md/llbitmap: %s: slow disk is not supported",
+			mdname(mddev));
+
+	events = le64_to_cpu(sb->events);
+	if (events < mddev->events) {
+		pr_warn("md/llbitmap :%s: bitmap file is out of date (%lu < %llu) -- forcing full recovery",
+			mdname(mddev), events, mddev->events);
+		set_bit(LLB_STALE, &llbitmap->flags);
+	}
+
+	sb->sync_size = cpu_to_le64(mddev->resync_max_sectors);
+	mddev->bitmap_info.chunksize = chunksize;
+	mddev->bitmap_info.daemon_sleep = daemon_sleep;
+
+	llbitmap->chunksize = chunksize;
+	llbitmap->chunks = DIV_ROUND_UP(mddev->resync_max_sectors, chunksize);
+	llbitmap->chunkshift = ffz(~chunksize);
+	ret = 0;
+
+out_put_page:
+	put_page(sb_page);
+out:
+	kunmap_local(sb);
+	return ret;
+}
+
+static void llbitmap_pending_timer_fn(struct timer_list *t)
+{
+	struct llbitmap *llbitmap = from_timer(llbitmap, t, pending_timer);
+
+	if (work_busy(&llbitmap->daemon_work)) {
+		pr_warn("daemon_work not finished\n");
+		return;
+	}
+
+	queue_work(md_llbitmap_wq, &llbitmap->daemon_work);
+}
+
+static void md_llbitmap_daemon_fn(struct work_struct *work)
+{
+	struct llbitmap *llbitmap =
+		container_of(work, struct llbitmap, daemon_work);
+
+	mddev_suspend(llbitmap->mddev, false);
+	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1,
+			       BitmapActionDaemon);
+	mddev_resume(llbitmap->mddev);
+}
+
+static int llbitmap_create(struct mddev *mddev, int slot)
+{
+	struct llbitmap *llbitmap;
+	int ret;
+
+	ret = llbitmap_check_support(mddev, slot);
+	if (ret)
+		return ret;
+
+	llbitmap = kzalloc(sizeof(*llbitmap), GFP_KERNEL);
+	if (!llbitmap)
+		return -ENOMEM;
+
+	llbitmap->mddev = mddev;
+	bio_list_init(&llbitmap->retry_list);
+	spin_lock_init(&llbitmap->retry_lock);
+
+	timer_setup(&llbitmap->pending_timer, llbitmap_pending_timer_fn, 0);
+	INIT_WORK(&llbitmap->retry_work, md_llbitmap_retry_fn);
+	INIT_WORK(&llbitmap->daemon_work, md_llbitmap_daemon_fn);
+
+	ret = bioset_init(&llbitmap->bio_set, BIO_POOL_SIZE,
+			  offsetof(struct llbitmap_bio, bio), 0);
+	if (ret)
+		goto err_out;
+
+	ret = llbitmap_add_disk(llbitmap);
+	if (ret)
+		goto err_bio_set;
+
+	ret = llbitmap_open_disk(llbitmap);
+	if (ret)
+		goto err_del_disk;
+
+	mddev->bitmap = llbitmap;
+	ret = llbitmap_read_sb(llbitmap);
+	if (ret)
+		goto err_close_disk;
+
+	return 0;
+
+err_close_disk:
+	mddev->bitmap = NULL;
+	llbitmap_close_disk(llbitmap);
+err_del_disk:
+	llbitmap_del_disk(llbitmap);
+err_bio_set:
+	bioset_exit(&llbitmap->bio_set);
+err_out:
+	kfree(llbitmap);
+	return ret;
+}
+
+static int llbitmap_resize(struct mddev *mddev, sector_t blocks, int chunksize)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long chunks;
+
+	if (chunksize == 0)
+		chunksize = llbitmap->chunksize;
+
+	/* If there is enough space, leave the chunksize unchanged. */
+	chunks = DIV_ROUND_UP(blocks, chunksize);
+	while (chunks > mddev->bitmap_info.space << SECTOR_SHIFT) {
+		chunksize = chunksize << 1;
+		chunks = DIV_ROUND_UP(blocks, chunksize);
+	}
+
+	llbitmap->chunkshift = ffz(~chunksize);
+	llbitmap->chunksize = chunksize;
+	llbitmap->chunks = chunks;
+
+	return 0;
+}
+
+static int llbitmap_load(struct mddev *mddev)
+{
+	enum llbitmap_action action = BitmapActionReload;
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	if (test_and_clear_bit(LLB_STALE, &llbitmap->flags))
+		action = BitmapActionStale;
+
+	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1, action);
+	return 0;
+}
+
+static void llbitmap_destroy(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	if (!llbitmap)
+		return;
+
+	del_timer_sync(&llbitmap->pending_timer);
+	flush_workqueue(md_llbitmap_wq);
+
+	llbitmap_close_disk(llbitmap);
+	llbitmap_del_disk(llbitmap);
+	bioset_exit(&llbitmap->bio_set);
+	kfree(llbitmap);
+}
+
+static void llbitmap_flush(struct mddev *mddev)
+{
+
+}
+
+static void llbitmap_write_all(struct mddev *mddev)
+{
+
+}
+
+static void llbitmap_dirty_bits(struct mddev *mddev, unsigned long s,
+				unsigned long e)
+{
+	llbitmap_state_machine(mddev->bitmap, s, e, BitmapActionStartwrite);
+}
+
+static void llbitmap_unplug_fn(struct work_struct *work)
+{
+	struct llbitmap_unplug_work *unplug_work =
+		container_of(work, struct llbitmap_unplug_work, work);
+	struct llbitmap *llbitmap = unplug_work->llbitmap;
+
+	filemap_write_and_wait_range(llbitmap->bitmap_file->f_mapping,
+				     BITMAP_SB_SIZE,
+				     BITMAP_SB_SIZE + llbitmap->chunks - 1);
+	complete(unplug_work->done);
+}
+
+static void llbitmap_unplug(struct mddev *mddev, bool sync)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct llbitmap *llbitmap = mddev->bitmap;
+	struct llbitmap_unplug_work unplug_work = {
+		.llbitmap = llbitmap,
+		.done = &done,
+	};
+
+	if (!mapping_tagged(llbitmap->bitmap_file->f_mapping,
+			    PAGECACHE_TAG_DIRTY))
+		return;
+
+	INIT_WORK_ONSTACK(&unplug_work.work, llbitmap_unplug_fn);
+	queue_work(md_llbitmap_wq, &unplug_work.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&unplug_work.work);
+}
+
+static void llbitmap_daemon_work(struct mddev *mddev)
+{
+
+}
+
+static void llbitmap_start_behind_write(struct mddev *mddev)
+{
+
+}
+
+static void llbitmap_end_behind_write(struct mddev *mddev)
+{
+
+}
+
+static void llbitmap_wait_behind_writes(struct mddev *mddev)
+{
+
+}
+
+static int llbitmap_startwrite(struct mddev *mddev, sector_t offset,
+			       unsigned long sectors)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long start = offset >> llbitmap->chunkshift;
+	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
+
+	llbitmap_state_machine(llbitmap, start, end, BitmapActionStartwrite);
+	return 0;
+}
+
+static void llbitmap_endwrite(struct mddev *mddev, sector_t offset,
+			      unsigned long sectors)
+{
+
+}
+
+static bool llbitmap_start_sync(struct mddev *mddev, sector_t offset,
+				sector_t *blocks, bool degraded)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+
+	/*
+	 * Handle one bit at a time, this is much simpler. And it doesn't matter
+	 * if md_do_sync() loop more times.
+	 */
+	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	return llbitmap_state_machine(llbitmap, p, p, BitmapActionStartsync) == BitSyncing;
+}
+
+static void llbitmap_end_sync(struct mddev *mddev, sector_t offset,
+			      sector_t *blocks)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+
+	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	llbitmap_state_machine(llbitmap, p, llbitmap->chunks - 1, BitmapActionAbortsync);
+}
+
+static void llbitmap_cond_end_sync(struct mddev *mddev, sector_t sector,
+				   bool force)
+{
+}
+
+static void llbitmap_close_sync(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1, BitmapActionEndsync);
+}
+
+static void llbitmap_update_sb(void *data)
+{
+	struct llbitmap *llbitmap = data;
+	struct mddev *mddev = llbitmap->mddev;
+	struct page *sb_page;
+	bitmap_super_t *sb;
+
+	if (test_bit(LLB_ERROR, &llbitmap->flags))
+		return;
+
+	sb_page = read_mapping_page(llbitmap->bitmap_file->f_mapping, 0, NULL);
+	if (IS_ERR(sb_page)) {
+		pr_err("%s: %s: read super block failed", __func__,
+		       mdname(mddev));
+		set_bit(LLB_ERROR, &llbitmap->flags);
+		return;
+	}
+
+	if (mddev->events < llbitmap->events_cleared)
+		llbitmap->events_cleared = mddev->events;
+
+	sb = kmap_local_page(sb_page);
+	sb->events = cpu_to_le64(mddev->events);
+	sb->state = cpu_to_le32(llbitmap->flags);
+	sb->chunksize = cpu_to_le32(llbitmap->chunksize);
+	sb->sync_size = cpu_to_le64(mddev->resync_max_sectors);
+	sb->events_cleared = cpu_to_le64(llbitmap->events_cleared);
+	sb->sectors_reserved = cpu_to_le32(mddev->bitmap_info.space);
+	sb->daemon_sleep = cpu_to_le32(mddev->bitmap_info.daemon_sleep);
+
+	kunmap_local(sb);
+	set_page_dirty(sb_page);
+	put_page(sb_page);
+
+	if (filemap_write_and_wait_range(llbitmap->bitmap_file->f_mapping, 0,
+					 BITMAP_SB_SIZE) != 0) {
+		pr_err("%s: %s: write super block failed", __func__,
+		       mdname(mddev));
+		set_bit(LLB_ERROR, &llbitmap->flags);
+	}
+}
+
+static int llbitmap_get_stats(void *data, struct md_bitmap_stats *stats)
+{
+	memset(stats, 0, sizeof(*stats));
+	return 0;
+}
+
+static void llbitmap_sync_with_cluster(struct mddev *mddev,
+				       sector_t old_lo, sector_t old_hi,
+				       sector_t new_lo, sector_t new_hi)
+{
+
+}
+
+static void *llbitmap_get_from_slot(struct mddev *mddev, int slot)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static int llbitmap_copy_from_slot(struct mddev *mddev, int slot, sector_t *low,
+				   sector_t *high, bool clear_bits)
+{
+	return -EOPNOTSUPP;
+}
+
+static void llbitmap_set_pages(void *data, unsigned long pages)
+{
+}
+
+static void llbitmap_free(void *data)
+{
+}
+
+static ssize_t bits_show(struct mddev *mddev, char *page)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	int bits[nr_llbitmap_state] = {0};
+	loff_t start = 0;
+
+	if (!llbitmap)
+		return sprintf(page, "no bitmap\n");
+
+	if (test_bit(LLB_ERROR, &llbitmap->flags))
+		return sprintf(page, "bitmap io error\n");
+
+	if (test_bit(LLB_ERROR, &llbitmap->flags))
+		return BitNone;
+
+	while (start < llbitmap->chunks) {
+		ssize_t ret;
+		enum llbitmap_state c;
+
+		ret = llbitmap_read(llbitmap->bitmap_file, &c, start);
+		if (ret < 0) {
+			set_bit(LLB_ERROR, &llbitmap->flags);
+			return sprintf(page, "bitmap io error\n");
+		}
+
+		if (c < 0 || c >= nr_llbitmap_state)
+			pr_err("%s: invalid bit %llu state %d\n",
+			       __func__, start, c);
+		else
+			bits[c]++;
+		start++;
+	}
+
+	return sprintf(page, "unwritten %d\nclean %d\ndirty %d\nneed sync %d\nsyncing %d\n",
+		       bits[BitUnwritten], bits[BitClean], bits[BitDirty],
+		       bits[BitNeedSync], bits[BitSyncing]);
+}
+
+static struct md_sysfs_entry llbitmap_bits =
+__ATTR_RO(bits);
+
+static ssize_t metadata_show(struct mddev *mddev, char *page)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	if (!llbitmap)
+		return sprintf(page, "no bitmap\n");
+
+	return sprintf(page, "chunksize %lu\nchunkshift %lu\nchunks %lu\noffset %llu\ndaemon_sleep %lu\n",
+		       llbitmap->chunksize, llbitmap->chunkshift,
+		       llbitmap->chunks, mddev->bitmap_info.offset,
+		       llbitmap->mddev->bitmap_info.daemon_sleep);
+}
+
+static struct md_sysfs_entry llbitmap_metadata =
+__ATTR_RO(metadata);
+
+static struct attribute *md_llbitmap_attrs[] = {
+	&llbitmap_bits.attr,
+	&llbitmap_metadata.attr,
+	NULL
+};
+
+static struct attribute_group md_llbitmap_group = {
+	.name = "llbitmap",
+	.attrs = md_llbitmap_attrs,
+};
+
+static struct bitmap_operations llbitmap_ops = {
+	.version		= 2,
+
+	.enabled		= llbitmap_enabled,
+	.create			= llbitmap_create,
+	.resize			= llbitmap_resize,
+	.load			= llbitmap_load,
+	.destroy		= llbitmap_destroy,
+	.flush			= llbitmap_flush,
+	.write_all		= llbitmap_write_all,
+	.dirty_bits		= llbitmap_dirty_bits,
+	.unplug			= llbitmap_unplug,
+	.daemon_work		= llbitmap_daemon_work,
+
+	.start_behind_write	= llbitmap_start_behind_write,
+	.end_behind_write	= llbitmap_end_behind_write,
+	.wait_behind_writes	= llbitmap_wait_behind_writes,
+
+	.startwrite		= llbitmap_startwrite,
+	.endwrite		= llbitmap_endwrite,
+	.start_sync		= llbitmap_start_sync,
+	.end_sync		= llbitmap_end_sync,
+	.cond_end_sync		= llbitmap_cond_end_sync,
+	.close_sync		= llbitmap_close_sync,
+
+	.update_sb		= llbitmap_update_sb,
+	.get_stats		= llbitmap_get_stats,
+
+	.sync_with_cluster	= llbitmap_sync_with_cluster,
+	.get_from_slot		= llbitmap_get_from_slot,
+	.copy_from_slot		= llbitmap_copy_from_slot,
+	.set_pages		= llbitmap_set_pages,
+	.free			= llbitmap_free,
+
+	.group			= &md_llbitmap_group,
+};
+
+int md_llbitmap_init(void)
+{
+	md_llbitmap_wq = alloc_workqueue("md_llbitmap",
+					 WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!md_llbitmap_wq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&llbitmap_ops.list);
+	register_md_bitmap(&llbitmap_ops);
+	return 0;
+}
+
+void md_llbitmap_exit(void)
+{
+	destroy_workqueue(md_llbitmap_wq);
+	md_llbitmap_wq = NULL;
+	unregister_md_bitmap(&llbitmap_ops);
+}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9451cc5cc574..94166b2e9512 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -705,10 +705,12 @@ static void mddev_clear_bitmap_ops(struct mddev *mddev)
 	mddev->bitmap_ops = NULL;
 }
 
+static int default_bitmap_version = 1;
+module_param(default_bitmap_version, int, 0644);
 int mddev_init(struct mddev *mddev)
 {
 	/* TODO: support more versions */
-	mddev_set_bitmap_ops(mddev, 1);
+	mddev_set_bitmap_ops(mddev, default_bitmap_version);
 
 	if (percpu_ref_init(&mddev->active_io, active_io_release,
 			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
@@ -10035,6 +10037,10 @@ static int __init md_init(void)
 	if (ret)
 		return ret;
 
+	ret = md_llbitmap_init();
+	if (ret)
+		goto err_bitmap;
+
 	ret = -ENOMEM;
 	md_wq = alloc_workqueue("md", WQ_MEM_RECLAIM, 0);
 	if (!md_wq)
@@ -10066,6 +10072,8 @@ static int __init md_init(void)
 err_misc_wq:
 	destroy_workqueue(md_wq);
 err_wq:
+	md_llbitmap_exit();
+err_bitmap:
 	md_bitmap_exit();
 	return ret;
 }
@@ -10370,6 +10378,7 @@ static __exit void md_exit(void)
 
 	destroy_workqueue(md_misc_wq);
 	destroy_workqueue(md_wq);
+	md_llbitmap_exit();
 	md_bitmap_exit();
 }
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 9e35d49f90a2..597b71799e6e 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -23,6 +23,9 @@
 
 #define MaxSector (~(sector_t)0)
 
+#define RESYNC_BLOCK_SIZE (64*1024)
+#define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
+
 /*
  * These flags should really be called "NO_RETRY" rather than
  * "FAILFAST" because they don't make any promise about time lapse,
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 6b8b7b7f1678..9e88c1179290 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Maximum size of each resync request */
-#define RESYNC_BLOCK_SIZE (64*1024)
-#define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
 
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7ac153e4423a..5c9b1accf4bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1642,6 +1642,7 @@ extern const struct blk_holder_ops fs_holder_ops;
 	(BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
 	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
+struct file *bdev_file_alloc(struct block_device *bdev, blk_mode_t mode);
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
-- 
2.39.2


