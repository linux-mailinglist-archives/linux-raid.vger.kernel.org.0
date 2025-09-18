Return-Path: <linux-raid+bounces-4789-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCDB17D53
	for <lists+linux-raid@lfdr.de>; Fri,  1 Aug 2025 09:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA26E620D3B
	for <lists+linux-raid@lfdr.de>; Fri,  1 Aug 2025 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E9227B8E;
	Fri,  1 Aug 2025 07:11:03 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA39223328;
	Fri,  1 Aug 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032263; cv=none; b=RP/2IMTPw064N2NAkjywZkiwopIXnIKQLIDaHInZGhdGCbPp7YmX6oI1Am0lU2VST2PfOetqlTp88zHLUD/PkzuAaSDvEnIhUt4i89n1UhdfwkFmeHqjOFzw0+xRwKgMwj51HA/uI9MFcRIWnqNzAVAzvjAaxoDecIBSPs+utR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032263; c=relaxed/simple;
	bh=ZPMoMxovzPynT+0RByONsBqPInhbAXTDnk6661aadnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmajEYGgDJ6pzK7zkiNvKpP89Ogow2UkGuTgsi+UIZWV7P6J14EB1mtnTXvGNCVwGOsFtRV7p52RDDX444Q6t3SblDH8YWvxlOrpPfE5OaE8/1cY46CWC9aqiQSNrxbICdB1r2Cxs+Y9aCjp61ofYjRSO+pA+jD1ZQLWo0Eq3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4btcYW42vJzYQv9v;
	Fri,  1 Aug 2025 15:10:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 386E01A13D2;
	Fri,  1 Aug 2025 15:10:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxByaIxoqAzACA--.18978S15;
	Fri, 01 Aug 2025 15:10:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	corbet@lwn.net,
	song@kernel.org,
	yukuai3@huawei.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	linan122@huawei.com,
	xni@redhat.com,
	hare@suse.de
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v5 11/11] md/md-llbitmap: introduce new lockless bitmap
Date: Fri,  1 Aug 2025 15:03:46 +0800
Message-Id: <20250801070346.4127558-12-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250801070346.4127558-1-yukuai1@huaweicloud.com>
References: <20250801070346.4127558-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxByaIxoqAzACA--.18978S15
X-Coremail-Antispam: 1UD129KBjvAXoWDCry7GrW8try5Jr47KF4xCrg_yoW7Zw45Ao
	WfZryUJw48Xrn8WrykAr1YkFy3Ww18Kwn0y34Y9Fn8WF4DX3W0v343GrW3Grn8trW5ur47
	tF92qr4rXFs7GFWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOV7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRNdb1DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

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

Key Features:

 - IO fastpath is lockless, if user issues lots of write IO to the same
 bitmap bit in a short time, only the first write have additional overhead
 to update bitmap bit, no additional overhead for the following writes;
 - support only resync or recover written data, means in the case creating
 new array or replacing with a new disk, there is no need to do a full disk
 resync/recovery;

Key Concept:

 - State Machine:

Each bit is one byte, contain 6 difference state, see llbitmap_state. And
there are total 8 differenct actions, see llbitmap_action, can change state:

llbitmap state machine: transitions between states

|           | Startwrite | Startsync | Endsync | Abortsync|
| --------- | ---------- | --------- | ------- | -------  |
| Unwritten | Dirty      | x         | x       | x        |
| Clean     | Dirty      | x         | x       | x        |
| Dirty     | x          | x         | x       | x        |
| NeedSync  | x          | Syncing   | x       | x        |
| Syncing   | x          | Syncing   | Dirty   | NeedSync |

|           | Reload   | Daemon | Discard   | Stale     |
| --------- | -------- | ------ | --------- | --------- |
| Unwritten | x        | x      | x         | x         |
| Clean     | x        | x      | Unwritten | NeedSync  |
| Dirty     | NeedSync | Clean  | Unwritten | NeedSync  |
| NeedSync  | x        | x      | Unwritten | x         |
| Syncing   | NeedSync | x      | Unwritten | NeedSync  |

Typical scenarios:

1) Create new array
All bits will be set to Unwritten by default, if --assume-clean is set,
all bits will be set to Clean instead.

2) write data, raid1/raid10 have full copy of data, while raid456 doesn't and
rely on xor data

2.1) write new data to raid1/raid10:
Unwritten --StartWrite--> Dirty

2.2) write new data to raid456:
Unwritten --StartWrite--> NeedSync

Because the initial recover for raid456 is skipped, the xor data is not build
yet, the bit must set to NeedSync first and after lazy initial recover is
finished, the bit will finially set to Dirty(see 5.1 and 5.4);

2.3) cover write
Clean --StartWrite--> Dirty

3) daemon, if the array is not degraded:
Dirty --Daemon--> Clean

For degraded array, the Dirty bit will never be cleared, prevent full disk
recovery while readding a removed disk.

4) discard
{Clean, Dirty, NeedSync, Syncing} --Discard--> Unwritten

5) resync and recover

5.1) common process
NeedSync --Startsync--> Syncing --Endsync--> Dirty --Daemon--> Clean

5.2) resync after power failure
Dirty --Reload--> NeedSync

5.3) recover while replacing with a new disk
By default, the old bitmap framework will recover all data, and llbitmap
implement this by a new helper, see llbitmap_skip_sync_blocks:

skip recover for bits other than dirty or clean;

5.4) lazy initial recover for raid5:
By default, the old bitmap framework will only allow new recover when there
are spares(new disk), a new recovery flag MD_RECOVERY_LAZY_RECOVER is add
to perform raid456 lazy recover for set bits(from 2.2).

Bitmap IO:

 - Chunksize

The default bitmap size is 128k, incluing 1k bitmap super block, and
the default size of segment of data in the array each bit(chunksize) is 64k,
and chunksize will adjust to twice the old size each time if the total number
bits is not less than 127k.(see llbitmap_init)

 - READ

While creating bitmap, all pages will be allocated and read for llbitmap,
there won't be read afterwards

 - WRITE

WRITE IO is divided into logical_block_size of the array, the dirty state
of each block is tracked independently, for example:

each page is 4k, contain 8 blocks; each block is 512 bytes contain 512 bit;

| page0 | page1 | ... | page 31 |
|       |
|        \-----------------------\
|                                |
| block0 | block1 | ... | block 8|
|        |
|         \-----------------\
|                            |
| bit0 | bit1 | ... | bit511 |

From IO path, if one bit is changed to Dirty or NeedSync, the corresponding
subpage will be marked dirty, such block must write first before the IO is
issued. This behaviour will affect IO performance, to reduce the impact, if
multiple bits are changed in the same block in a short time, all bits in this
block will be changed to Dirty/NeedSync, so that there won't be any overhead
until daemon clears dirty bits.

Dirty Bits syncronization:

IO fast path will set bits to dirty, and those dirty bits will be cleared
by daemon after IO is done. llbitmap_page_ctl is used to synchronize between
IO path and daemon;

IO path:
 1) try to grab a reference, if succeed, set expire time after 5s and return;
 2) if failed to grab a reference, wait for daemon to finish clearing dirty
 bits;

Daemon(Daemon will be waken up every daemon_sleep seconds):
For each page:
 1) check if page expired, if not skip this page; for expired page:
 2) suspend the page and wait for inflight write IO to be done;
 3) change dirty page to clean;
 4) resume the page;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 Documentation/admin-guide/md.rst |   20 +
 drivers/md/Kconfig               |   11 +
 drivers/md/Makefile              |    1 +
 drivers/md/md-bitmap.c           |    9 -
 drivers/md/md-bitmap.h           |   31 +-
 drivers/md/md-llbitmap.c         | 1596 ++++++++++++++++++++++++++++++
 drivers/md/md.c                  |    6 +
 drivers/md/md.h                  |    4 +-
 8 files changed, 1666 insertions(+), 12 deletions(-)
 create mode 100644 drivers/md/md-llbitmap.c

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 001363f81850..47d1347ccd00 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -387,6 +387,8 @@ All md devices contain:
          No bitmap
      bitmap
          The default internal bitmap
+     llbitmap
+         The lockless internal bitmap
 
 If bitmap_type is not none, then additional bitmap attributes bitmap/xxx or
 llbitmap/xxx will be created after md device KOBJ_CHANGE event.
@@ -447,6 +449,24 @@ If bitmap_type is bitmap, then the md device will also contain:
      once the array becomes non-degraded, and this fact has been
      recorded in the metadata.
 
+If bitmap_type is llbitmap, then the md device will also contain:
+
+  llbitmap/bits
+     This is readonly, show status of bitmap bits, the number of each
+     value.
+
+  llbitmap/metadata
+     This is readonly, show bitmap metadata, include chunksize, chunkshift,
+     chunks, offset and daemon_sleep.
+
+  llbitmap/daemon_sleep
+     This is readwrite, time in seconds that daemon function will be
+     triggered to clear dirty bits.
+
+  llbitmap/barrier_idle
+     This is readwrite, time in seconds that page barrier will be idled,
+     means dirty bits in the page will be cleared.
+
 As component devices are added to an md array, they appear in the ``md``
 directory as new directories named::
 
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index f913579e731c..07c19b2182ca 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -52,6 +52,17 @@ config MD_BITMAP
 
 	  If unsure, say Y.
 
+config MD_LLBITMAP
+	bool "MD RAID lockless bitmap support"
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
index 2e18147a9c40..5a51b3408b70 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -29,6 +29,7 @@ dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
 md-mod-y	+= md.o
 md-mod-$(CONFIG_MD_BITMAP)	+= md-bitmap.o
+md-mod-$(CONFIG_MD_LLBITMAP)	+= md-llbitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
 linear-y       += md-linear.o
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index dc050ff94d5b..84b7e2af6dba 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -34,15 +34,6 @@
 #include "md-bitmap.h"
 #include "md-cluster.h"
 
-#define BITMAP_MAJOR_LO 3
-/* version 4 insists the bitmap is in little-endian order
- * with version 3, it is host-endian which is non-portable
- * Version 5 is currently set only for clustered devices
- */
-#define BITMAP_MAJOR_HI 4
-#define BITMAP_MAJOR_CLUSTERED 5
-#define	BITMAP_MAJOR_HOSTENDIAN 3
-
 /*
  * in-memory bitmap:
  *
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 5f41724cbcd8..b42a28fa83a0 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -9,10 +9,26 @@
 
 #define BITMAP_MAGIC 0x6d746962
 
+/*
+ * version 3 is host-endian order, this is deprecated and not used for new
+ * array
+ */
+#define BITMAP_MAJOR_LO		3
+#define BITMAP_MAJOR_HOSTENDIAN	3
+/* version 4 is little-endian order, the default value */
+#define BITMAP_MAJOR_HI		4
+/* version 5 is only used for cluster */
+#define BITMAP_MAJOR_CLUSTERED	5
+/* version 6 is only used for lockless bitmap */
+#define BITMAP_MAJOR_LOCKLESS	6
+
 /* use these for bitmap->flags and bitmap->sb->state bit-fields */
 enum bitmap_state {
-	BITMAP_STALE	   = 1,  /* the bitmap file is out of date or had -EIO */
+	BITMAP_STALE	   = 1, /* the bitmap file is out of date or had -EIO */
 	BITMAP_WRITE_ERROR = 2, /* A write error has occurred */
+	BITMAP_FIRST_USE   = 3, /* llbitmap is just created */
+	BITMAP_CLEAN       = 4, /* llbitmap is created with assume_clean */
+	BITMAP_DAEMON_BUSY = 5, /* llbitmap daemon is not finished after daemon_sleep */
 	BITMAP_HOSTENDIAN  =15,
 };
 
@@ -166,4 +182,17 @@ static inline void md_bitmap_exit(void)
 }
 #endif
 
+#ifdef CONFIG_MD_LLBITMAP
+int md_llbitmap_init(void);
+void md_llbitmap_exit(void);
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
index 000000000000..077203106f4d
--- /dev/null
+++ b/drivers/md/md-llbitmap.c
@@ -0,0 +1,1596 @@
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
+ * #### Key Features
+ *
+ *  - IO fastpath is lockless, if user issues lots of write IO to the same
+ *  bitmap bit in a short time, only the first write have additional overhead
+ *  to update bitmap bit, no additional overhead for the following writes;
+ *  - support only resync or recover written data, means in the case creating
+ *  new array or replacing with a new disk, there is no need to do a full disk
+ *  resync/recovery;
+ *
+ * #### Key Concept
+ *
+ * ##### State Machine
+ *
+ * Each bit is one byte, contain 6 difference state, see llbitmap_state. And
+ * there are total 8 differenct actions, see llbitmap_action, can change state:
+ *
+ * llbitmap state machine: transitions between states
+ *
+ * |           | Startwrite | Startsync | Endsync | Abortsync|
+ * | --------- | ---------- | --------- | ------- | -------  |
+ * | Unwritten | Dirty      | x         | x       | x        |
+ * | Clean     | Dirty      | x         | x       | x        |
+ * | Dirty     | x          | x         | x       | x        |
+ * | NeedSync  | x          | Syncing   | x       | x        |
+ * | Syncing   | x          | Syncing   | Dirty   | NeedSync |
+ *
+ * |           | Reload   | Daemon | Discard   | Stale     |
+ * | --------- | -------- | ------ | --------- | --------- |
+ * | Unwritten | x        | x      | x         | x         |
+ * | Clean     | x        | x      | Unwritten | NeedSync  |
+ * | Dirty     | NeedSync | Clean  | Unwritten | NeedSync  |
+ * | NeedSync  | x        | x      | Unwritten | x         |
+ * | Syncing   | NeedSync | x      | Unwritten | NeedSync  |
+ *
+ * Typical scenarios:
+ *
+ * 1) Create new array
+ * All bits will be set to Unwritten by default, if --assume-clean is set,
+ * all bits will be set to Clean instead.
+ *
+ * 2) write data, raid1/raid10 have full copy of data, while raid456 doesn't and
+ * rely on xor data
+ *
+ * 2.1) write new data to raid1/raid10:
+ * Unwritten --StartWrite--> Dirty
+ *
+ * 2.2) write new data to raid456:
+ * Unwritten --StartWrite--> NeedSync
+ *
+ * Because the initial recover for raid456 is skipped, the xor data is not build
+ * yet, the bit must set to NeedSync first and after lazy initial recover is
+ * finished, the bit will finially set to Dirty(see 5.1 and 5.4);
+ *
+ * 2.3) cover write
+ * Clean --StartWrite--> Dirty
+ *
+ * 3) daemon, if the array is not degraded:
+ * Dirty --Daemon--> Clean
+ *
+ * For degraded array, the Dirty bit will never be cleared, prevent full disk
+ * recovery while readding a removed disk.
+ *
+ * 4) discard
+ * {Clean, Dirty, NeedSync, Syncing} --Discard--> Unwritten
+ *
+ * 5) resync and recover
+ *
+ * 5.1) common process
+ * NeedSync --Startsync--> Syncing --Endsync--> Dirty --Daemon--> Clean
+ *
+ * 5.2) resync after power failure
+ * Dirty --Reload--> NeedSync
+ *
+ * 5.3) recover while replacing with a new disk
+ * By default, the old bitmap framework will recover all data, and llbitmap
+ * implement this by a new helper, see llbitmap_skip_sync_blocks:
+ *
+ * skip recover for bits other than dirty or clean;
+ *
+ * 5.4) lazy initial recover for raid5:
+ * By default, the old bitmap framework will only allow new recover when there
+ * are spares(new disk), a new recovery flag MD_RECOVERY_LAZY_RECOVER is add
+ * to perform raid456 lazy recover for set bits(from 2.2).
+ *
+ * ##### Bitmap IO
+ *
+ * ##### Chunksize
+ *
+ * The default bitmap size is 128k, incluing 1k bitmap super block, and
+ * the default size of segment of data in the array each bit(chunksize) is 64k,
+ * and chunksize will adjust to twice the old size each time if the total number
+ * bits is not less than 127k.(see llbitmap_init)
+ *
+ * ##### READ
+ *
+ * While creating bitmap, all pages will be allocated and read for llbitmap,
+ * there won't be read afterwards
+ *
+ * ##### WRITE
+ *
+ * WRITE IO is divided into logical_block_size of the array, the dirty state
+ * of each block is tracked independently, for example:
+ *
+ * each page is 4k, contain 8 blocks; each block is 512 bytes contain 512 bit;
+ *
+ * | page0 | page1 | ... | page 31 |
+ * |       |
+ * |        \-----------------------\
+ * |                                |
+ * | block0 | block1 | ... | block 8|
+ * |        |
+ * |         \-----------------\
+ * |                            |
+ * | bit0 | bit1 | ... | bit511 |
+ *
+ * From IO path, if one bit is changed to Dirty or NeedSync, the corresponding
+ * subpage will be marked dirty, such block must write first before the IO is
+ * issued. This behaviour will affect IO performance, to reduce the impact, if
+ * multiple bits are changed in the same block in a short time, all bits in this
+ * block will be changed to Dirty/NeedSync, so that there won't be any overhead
+ * until daemon clears dirty bits.
+ *
+ * ##### Dirty Bits syncronization
+ *
+ * IO fast path will set bits to dirty, and those dirty bits will be cleared
+ * by daemon after IO is done. llbitmap_page_ctl is used to synchronize between
+ * IO path and daemon;
+ *
+ * IO path:
+ *  1) try to grab a reference, if succeed, set expire time after 5s and return;
+ *  2) if failed to grab a reference, wait for daemon to finish clearing dirty
+ *  bits;
+ *
+ * Daemon(Daemon will be waken up every daemon_sleep seconds):
+ * For each page:
+ *  1) check if page expired, if not skip this page; for expired page:
+ *  2) suspend the page and wait for inflight write IO to be done;
+ *  3) change dirty page to clean;
+ *  4) resume the page;
+ */
+
+#define BITMAP_DATA_OFFSET 1024
+
+/* 64k is the max IO size of sync IO for raid1/raid10 */
+#define MIN_CHUNK_SIZE (64 * 2)
+
+/* By default, daemon will be waken up every 30s */
+#define DEFAULT_DAEMON_SLEEP 30
+
+/*
+ * Dirtied bits that have not been accessed for more than 5s will be cleared
+ * by daemon.
+ */
+#define DEFAULT_BARRIER_IDLE 5
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
+	 * 3) set for first write for raid5, to build initial xor data lazily
+	 */
+	BitNeedSync,
+	/* data is synchronizing */
+	BitSyncing,
+	BitStateCount,
+	BitNone = 0xff,
+};
+
+enum llbitmap_action {
+	/* User write new data, this is the only action from IO fast path */
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
+	BitmapActionCount,
+	/* Init state is BitUnwritten */
+	BitmapActionInit,
+};
+
+enum llbitmap_page_state {
+	LLPageFlush = 0,
+	LLPageDirty,
+};
+
+struct llbitmap_page_ctl {
+	char *state;
+	struct page *page;
+	unsigned long expire;
+	unsigned long flags;
+	wait_queue_head_t wait;
+	struct percpu_ref active;
+	/* Per block size dirty state, maximum 64k page / 1 sector = 128 */
+	unsigned long dirty[];
+};
+
+struct llbitmap {
+	struct mddev *mddev;
+	struct llbitmap_page_ctl **pctl;
+
+	unsigned int nr_pages;
+	unsigned int io_size;
+	unsigned int blocks_per_page;
+
+	/* shift of one chunk */
+	unsigned long chunkshift;
+	/* size of one chunk in sector */
+	unsigned long chunksize;
+	/* total number of chunks */
+	unsigned long chunks;
+	unsigned long last_end_sync;
+	/*
+	 * time in seconds that dirty bits will be cleared if the page is not
+	 * accessed.
+	 */
+	unsigned long barrier_idle;
+	/* fires on first BitDirty state */
+	struct timer_list pending_timer;
+	struct work_struct daemon_work;
+
+	unsigned long flags;
+	__u64	events_cleared;
+
+	/* for slow disks */
+	atomic_t behind_writes;
+	wait_queue_head_t behind_wait;
+};
+
+struct llbitmap_unplug_work {
+	struct work_struct work;
+	struct llbitmap *llbitmap;
+	struct completion *done;
+};
+
+static struct workqueue_struct *md_llbitmap_io_wq;
+static struct workqueue_struct *md_llbitmap_unplug_wq;
+
+static char state_machine[BitStateCount][BitmapActionCount] = {
+	[BitUnwritten] = {
+		[BitmapActionStartwrite]	= BitDirty,
+		[BitmapActionStartsync]		= BitNone,
+		[BitmapActionEndsync]		= BitNone,
+		[BitmapActionAbortsync]		= BitNone,
+		[BitmapActionReload]		= BitNone,
+		[BitmapActionDaemon]		= BitNone,
+		[BitmapActionDiscard]		= BitNone,
+		[BitmapActionStale]		= BitNone,
+	},
+	[BitClean] = {
+		[BitmapActionStartwrite]	= BitDirty,
+		[BitmapActionStartsync]		= BitNone,
+		[BitmapActionEndsync]		= BitNone,
+		[BitmapActionAbortsync]		= BitNone,
+		[BitmapActionReload]		= BitNone,
+		[BitmapActionDaemon]		= BitNone,
+		[BitmapActionDiscard]		= BitUnwritten,
+		[BitmapActionStale]		= BitNeedSync,
+	},
+	[BitDirty] = {
+		[BitmapActionStartwrite]	= BitNone,
+		[BitmapActionStartsync]		= BitNone,
+		[BitmapActionEndsync]		= BitNone,
+		[BitmapActionAbortsync]		= BitNone,
+		[BitmapActionReload]		= BitNeedSync,
+		[BitmapActionDaemon]		= BitClean,
+		[BitmapActionDiscard]		= BitUnwritten,
+		[BitmapActionStale]		= BitNeedSync,
+	},
+	[BitNeedSync] = {
+		[BitmapActionStartwrite]	= BitNone,
+		[BitmapActionStartsync]		= BitSyncing,
+		[BitmapActionEndsync]		= BitNone,
+		[BitmapActionAbortsync]		= BitNone,
+		[BitmapActionReload]		= BitNone,
+		[BitmapActionDaemon]		= BitNone,
+		[BitmapActionDiscard]		= BitUnwritten,
+		[BitmapActionStale]		= BitNone,
+	},
+	[BitSyncing] = {
+		[BitmapActionStartwrite]	= BitNone,
+		[BitmapActionStartsync]		= BitSyncing,
+		[BitmapActionEndsync]		= BitDirty,
+		[BitmapActionAbortsync]		= BitNeedSync,
+		[BitmapActionReload]		= BitNeedSync,
+		[BitmapActionDaemon]		= BitNone,
+		[BitmapActionDiscard]		= BitUnwritten,
+		[BitmapActionStale]		= BitNeedSync,
+	},
+};
+
+static enum llbitmap_state llbitmap_read(struct llbitmap *llbitmap, loff_t pos)
+{
+	unsigned int idx;
+	unsigned int offset;
+
+	pos += BITMAP_DATA_OFFSET;
+	idx = pos >> PAGE_SHIFT;
+	offset = offset_in_page(pos);
+
+	return llbitmap->pctl[idx]->state[offset];
+}
+
+/* set all the bits in the subpage as dirty */
+static void llbitmap_infect_dirty_bits(struct llbitmap *llbitmap,
+				       struct llbitmap_page_ctl *pctl,
+				       unsigned int block, unsigned int offset)
+{
+	bool level_456 = raid_is_456(llbitmap->mddev);
+	unsigned int io_size = llbitmap->io_size;
+	int pos;
+
+	for (pos = block * io_size; pos < (block + 1) * io_size; pos++) {
+		if (pos == offset)
+			continue;
+
+		switch (pctl->state[pos]) {
+		case BitUnwritten:
+			pctl->state[pos] = level_456 ? BitNeedSync : BitDirty;
+			break;
+		case BitClean:
+			pctl->state[pos] = BitDirty;
+			break;
+		};
+	}
+
+}
+
+static void llbitmap_set_page_dirty(struct llbitmap *llbitmap, int idx,
+				    int offset)
+{
+	struct llbitmap_page_ctl *pctl = llbitmap->pctl[idx];
+	unsigned int io_size = llbitmap->io_size;
+	int block = offset / io_size;
+	int pos;
+
+	if (!test_bit(LLPageDirty, &pctl->flags))
+		set_bit(LLPageDirty, &pctl->flags);
+
+	/*
+	 * The subpage usually contains a total of 512 bits. If any single bit
+	 * within the subpage is marked as dirty, the entire sector will be
+	 * written. To avoid impacting write performance, when multiple bits
+	 * within the same sector are modified within llbitmap->barrier_idle,
+	 * all bits in the sector will be collectively marked as dirty at once.
+	 */
+	if (test_and_set_bit(block, pctl->dirty)) {
+		llbitmap_infect_dirty_bits(llbitmap, pctl, block, offset);
+		return;
+	}
+
+	for (pos = block * io_size; pos < (block + 1) * io_size; pos++) {
+		if (pos == offset)
+			continue;
+		if (pctl->state[pos] == BitDirty ||
+		    pctl->state[pos] == BitNeedSync) {
+			llbitmap_infect_dirty_bits(llbitmap, pctl, block, offset);
+			return;
+		}
+	}
+}
+
+static void llbitmap_write(struct llbitmap *llbitmap, enum llbitmap_state state,
+			   loff_t pos)
+{
+	unsigned int idx;
+	unsigned int offset;
+
+	pos += BITMAP_DATA_OFFSET;
+	idx = pos >> PAGE_SHIFT;
+	offset = offset_in_page(pos);
+
+	llbitmap->pctl[idx]->state[offset] = state;
+	if (state == BitDirty || state == BitNeedSync)
+		llbitmap_set_page_dirty(llbitmap, idx, offset);
+}
+
+static struct page *llbitmap_read_page(struct llbitmap *llbitmap, int idx)
+{
+	struct mddev *mddev = llbitmap->mddev;
+	struct page *page = NULL;
+	struct md_rdev *rdev;
+
+	if (llbitmap->pctl && llbitmap->pctl[idx])
+		page = llbitmap->pctl[idx]->page;
+	if (page)
+		return page;
+
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	rdev_for_each(rdev, mddev) {
+		sector_t sector;
+
+		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+			continue;
+
+		sector = mddev->bitmap_info.offset +
+			 (idx << PAGE_SECTORS_SHIFT);
+
+		if (sync_page_io(rdev, sector, PAGE_SIZE, page, REQ_OP_READ,
+				 true))
+			return page;
+
+		md_error(mddev, rdev);
+	}
+
+	__free_page(page);
+	return ERR_PTR(-EIO);
+}
+
+static void llbitmap_write_page(struct llbitmap *llbitmap, int idx)
+{
+	struct page *page = llbitmap->pctl[idx]->page;
+	struct mddev *mddev = llbitmap->mddev;
+	struct md_rdev *rdev;
+	int bit;
+
+	for (bit = 0; bit < llbitmap->blocks_per_page; bit++) {
+		struct llbitmap_page_ctl *pctl = llbitmap->pctl[idx];
+
+		if (!test_and_clear_bit(bit, pctl->dirty))
+			continue;
+
+		rdev_for_each(rdev, mddev) {
+			sector_t sector;
+			sector_t bit_sector = llbitmap->io_size >> SECTOR_SHIFT;
+
+			if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+				continue;
+
+			sector = mddev->bitmap_info.offset + rdev->sb_start +
+				 (idx << PAGE_SECTORS_SHIFT) +
+				 bit * bit_sector;
+			md_write_metadata(mddev, rdev, sector,
+					  llbitmap->io_size, page,
+					  bit * llbitmap->io_size);
+		}
+	}
+}
+
+static void active_release(struct percpu_ref *ref)
+{
+	struct llbitmap_page_ctl *pctl =
+		container_of(ref, struct llbitmap_page_ctl, active);
+
+	wake_up(&pctl->wait);
+}
+
+static void llbitmap_free_pages(struct llbitmap *llbitmap)
+{
+	int i;
+
+	if (!llbitmap->pctl)
+		return;
+
+	for (i = 0; i < llbitmap->nr_pages; i++) {
+		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
+
+		if (!pctl || !pctl->page)
+			break;
+
+		__free_page(pctl->page);
+		percpu_ref_exit(&pctl->active);
+	}
+
+	kfree(llbitmap->pctl[0]);
+	kfree(llbitmap->pctl);
+	llbitmap->pctl = NULL;
+}
+
+static int llbitmap_cache_pages(struct llbitmap *llbitmap)
+{
+	struct llbitmap_page_ctl *pctl;
+	unsigned int nr_pages = DIV_ROUND_UP(llbitmap->chunks +
+					     BITMAP_DATA_OFFSET, PAGE_SIZE);
+	unsigned int size = struct_size(pctl, dirty, BITS_TO_LONGS(
+						llbitmap->blocks_per_page));
+	int i;
+
+	llbitmap->pctl = kmalloc_array(nr_pages, sizeof(void *),
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!llbitmap->pctl)
+		return -ENOMEM;
+
+	size = round_up(size, cache_line_size());
+	pctl = kmalloc_array(nr_pages, size, GFP_KERNEL | __GFP_ZERO);
+	if (!pctl) {
+		kfree(llbitmap->pctl);
+		return -ENOMEM;
+	}
+
+	llbitmap->nr_pages = nr_pages;
+
+	for (i = 0; i < nr_pages; i++, pctl = (void *)pctl + size) {
+		struct page *page = llbitmap_read_page(llbitmap, i);
+
+		llbitmap->pctl[i] = pctl;
+
+		if (IS_ERR(page)) {
+			llbitmap_free_pages(llbitmap);
+			return PTR_ERR(page);
+		}
+
+		if (percpu_ref_init(&pctl->active, active_release,
+				    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
+			__free_page(page);
+			llbitmap_free_pages(llbitmap);
+			return -ENOMEM;
+		}
+
+		pctl->page = page;
+		pctl->state = page_address(page);
+		init_waitqueue_head(&pctl->wait);
+	}
+
+	return 0;
+}
+
+static void llbitmap_init_state(struct llbitmap *llbitmap)
+{
+	enum llbitmap_state state = BitUnwritten;
+	unsigned long i;
+
+	if (test_and_clear_bit(BITMAP_CLEAN, &llbitmap->flags))
+		state = BitClean;
+
+	for (i = 0; i < llbitmap->chunks; i++)
+		llbitmap_write(llbitmap, state, i);
+}
+
+/* The return value is only used from resync, where @start == @end. */
+static enum llbitmap_state llbitmap_state_machine(struct llbitmap *llbitmap,
+						  unsigned long start,
+						  unsigned long end,
+						  enum llbitmap_action action)
+{
+	struct mddev *mddev = llbitmap->mddev;
+	enum llbitmap_state state = BitNone;
+	bool need_resync = false;
+	bool need_recovery = false;
+
+	if (test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags))
+		return BitNone;
+
+	if (action == BitmapActionInit) {
+		llbitmap_init_state(llbitmap);
+		return BitNone;
+	}
+
+	while (start <= end) {
+		enum llbitmap_state c = llbitmap_read(llbitmap, start);
+
+		if (c < 0 || c >= BitStateCount) {
+			pr_err("%s: invalid bit %lu state %d action %d, forcing resync\n",
+			       __func__, start, c, action);
+			state = BitNeedSync;
+			goto write_bitmap;
+		}
+
+		if (c == BitNeedSync)
+			need_resync = true;
+
+		state = state_machine[c][action];
+		if (state == BitNone) {
+			start++;
+			continue;
+		}
+
+write_bitmap:
+		/* Delay raid456 initial recovery to first write. */
+		if (c == BitUnwritten && state == BitDirty &&
+		    action == BitmapActionStartwrite && raid_is_456(mddev)) {
+			state = BitNeedSync;
+			need_recovery = true;
+		}
+
+		llbitmap_write(llbitmap, state, start);
+
+		if (state == BitNeedSync)
+			need_resync = true;
+		else if (state == BitDirty &&
+			 !timer_pending(&llbitmap->pending_timer))
+			mod_timer(&llbitmap->pending_timer,
+				  jiffies + mddev->bitmap_info.daemon_sleep * HZ);
+
+		start++;
+	}
+
+	if (need_recovery) {
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		set_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
+		md_wakeup_thread(mddev->thread);
+	} else if (need_resync) {
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		md_wakeup_thread(mddev->thread);
+	}
+
+	return state;
+}
+
+static void llbitmap_raise_barrier(struct llbitmap *llbitmap, int page_idx)
+{
+	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
+
+retry:
+	if (likely(percpu_ref_tryget_live(&pctl->active))) {
+		WRITE_ONCE(pctl->expire, jiffies + llbitmap->barrier_idle * HZ);
+		return;
+	}
+
+	wait_event(pctl->wait, !percpu_ref_is_dying(&pctl->active));
+	goto retry;
+}
+
+static void llbitmap_release_barrier(struct llbitmap *llbitmap, int page_idx)
+{
+	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
+
+	percpu_ref_put(&pctl->active);
+}
+
+static int llbitmap_suspend_timeout(struct llbitmap *llbitmap, int page_idx)
+{
+	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
+
+	percpu_ref_kill(&pctl->active);
+
+	if (!wait_event_timeout(pctl->wait, percpu_ref_is_zero(&pctl->active),
+			llbitmap->mddev->bitmap_info.daemon_sleep * HZ))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void llbitmap_resume(struct llbitmap *llbitmap, int page_idx)
+{
+	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
+
+	pctl->expire = LONG_MAX;
+	percpu_ref_resurrect(&pctl->active);
+	wake_up(&pctl->wait);
+}
+
+static int llbitmap_check_support(struct mddev *mddev)
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
+	unsigned long chunksize = MIN_CHUNK_SIZE;
+	unsigned long chunks = DIV_ROUND_UP(blocks, chunksize);
+	unsigned long space = mddev->bitmap_info.space << SECTOR_SHIFT;
+	int ret;
+
+	while (chunks > space) {
+		chunksize = chunksize << 1;
+		chunks = DIV_ROUND_UP(blocks, chunksize);
+	}
+
+	llbitmap->barrier_idle = DEFAULT_BARRIER_IDLE;
+	llbitmap->chunkshift = ffz(~chunksize);
+	llbitmap->chunksize = chunksize;
+	llbitmap->chunks = chunks;
+	mddev->bitmap_info.daemon_sleep = DEFAULT_DAEMON_SLEEP;
+
+	ret = llbitmap_cache_pages(llbitmap);
+	if (ret)
+		return ret;
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
+	sb_page = llbitmap_read_page(llbitmap, 0);
+	if (IS_ERR(sb_page)) {
+		pr_err("md/llbitmap: %s: read super block failed",
+		       mdname(mddev));
+		return -EIO;
+	}
+
+	sb = kmap_local_page(sb_page);
+	if (sb->magic != cpu_to_le32(BITMAP_MAGIC)) {
+		pr_err("md/llbitmap: %s: invalid super block magic number",
+		       mdname(mddev));
+		goto out_put_page;
+	}
+
+	if (sb->version != cpu_to_le32(BITMAP_MAJOR_LOCKLESS)) {
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
+	if (mddev->bitmap_info.space == 0) {
+		int room = le32_to_cpu(sb->sectors_reserved);
+
+		if (room)
+			mddev->bitmap_info.space = room;
+		else
+			mddev->bitmap_info.space = mddev->bitmap_info.default_space;
+	}
+	llbitmap->flags = le32_to_cpu(sb->state);
+	if (test_and_clear_bit(BITMAP_FIRST_USE, &llbitmap->flags)) {
+		ret = llbitmap_init(llbitmap);
+		goto out_put_page;
+	}
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
+	events = le64_to_cpu(sb->events);
+	if (events < mddev->events) {
+		pr_warn("md/llbitmap :%s: bitmap file is out of date (%lu < %llu) -- forcing full recovery",
+			mdname(mddev), events, mddev->events);
+		set_bit(BITMAP_STALE, &llbitmap->flags);
+	}
+
+	sb->sync_size = cpu_to_le64(mddev->resync_max_sectors);
+	mddev->bitmap_info.chunksize = chunksize;
+	mddev->bitmap_info.daemon_sleep = daemon_sleep;
+
+	llbitmap->barrier_idle = DEFAULT_BARRIER_IDLE;
+	llbitmap->chunksize = chunksize;
+	llbitmap->chunks = DIV_ROUND_UP(mddev->resync_max_sectors, chunksize);
+	llbitmap->chunkshift = ffz(~chunksize);
+	ret = llbitmap_cache_pages(llbitmap);
+
+out_put_page:
+	__free_page(sb_page);
+	kunmap_local(sb);
+	return ret;
+}
+
+static void llbitmap_pending_timer_fn(struct timer_list *pending_timer)
+{
+	struct llbitmap *llbitmap =
+		container_of(pending_timer, struct llbitmap, pending_timer);
+
+	if (work_busy(&llbitmap->daemon_work)) {
+		pr_warn("md/llbitmap: %s daemon_work not finished in %lu seconds\n",
+			mdname(llbitmap->mddev),
+			llbitmap->mddev->bitmap_info.daemon_sleep);
+		set_bit(BITMAP_DAEMON_BUSY, &llbitmap->flags);
+		return;
+	}
+
+	queue_work(md_llbitmap_io_wq, &llbitmap->daemon_work);
+}
+
+static void md_llbitmap_daemon_fn(struct work_struct *work)
+{
+	struct llbitmap *llbitmap =
+		container_of(work, struct llbitmap, daemon_work);
+	unsigned long start;
+	unsigned long end;
+	bool restart;
+	int idx;
+
+	if (llbitmap->mddev->degraded)
+		return;
+
+retry:
+	start = 0;
+	end = min(llbitmap->chunks, PAGE_SIZE - BITMAP_DATA_OFFSET) - 1;
+	restart = false;
+
+	for (idx = 0; idx < llbitmap->nr_pages; idx++) {
+		struct llbitmap_page_ctl *pctl = llbitmap->pctl[idx];
+
+		if (idx > 0) {
+			start = end + 1;
+			end = min(end + PAGE_SIZE, llbitmap->chunks - 1);
+		}
+
+		if (!test_bit(LLPageFlush, &pctl->flags) &&
+		    time_before(jiffies, pctl->expire)) {
+			restart = true;
+			continue;
+		}
+
+		if (llbitmap_suspend_timeout(llbitmap, idx) < 0) {
+			pr_warn("md/llbitmap: %s: %s waiting for page %d timeout\n",
+				mdname(llbitmap->mddev), __func__, idx);
+			continue;
+		}
+
+		llbitmap_state_machine(llbitmap, start, end, BitmapActionDaemon);
+		llbitmap_resume(llbitmap, idx);
+	}
+
+	/*
+	 * If the daemon took a long time to finish, retry to prevent missing
+	 * clearing dirty bits.
+	 */
+	if (test_and_clear_bit(BITMAP_DAEMON_BUSY, &llbitmap->flags))
+		goto retry;
+
+	/* If some page is dirty but not expired, setup timer again */
+	if (restart)
+		mod_timer(&llbitmap->pending_timer,
+			  jiffies + llbitmap->mddev->bitmap_info.daemon_sleep * HZ);
+}
+
+static int llbitmap_create(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap;
+	int ret;
+
+	ret = llbitmap_check_support(mddev);
+	if (ret)
+		return ret;
+
+	llbitmap = kzalloc(sizeof(*llbitmap), GFP_KERNEL);
+	if (!llbitmap)
+		return -ENOMEM;
+
+	llbitmap->mddev = mddev;
+	llbitmap->io_size = bdev_logical_block_size(mddev->gendisk->part0);
+	llbitmap->blocks_per_page = PAGE_SIZE / llbitmap->io_size;
+
+	timer_setup(&llbitmap->pending_timer, llbitmap_pending_timer_fn, 0);
+	INIT_WORK(&llbitmap->daemon_work, md_llbitmap_daemon_fn);
+	atomic_set(&llbitmap->behind_writes, 0);
+	init_waitqueue_head(&llbitmap->behind_wait);
+
+	mutex_lock(&mddev->bitmap_info.mutex);
+	mddev->bitmap = llbitmap;
+	ret = llbitmap_read_sb(llbitmap);
+	mutex_unlock(&mddev->bitmap_info.mutex);
+	if (ret)
+		goto err_out;
+
+	return 0;
+
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
+	if (test_and_clear_bit(BITMAP_STALE, &llbitmap->flags))
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
+	mutex_lock(&mddev->bitmap_info.mutex);
+
+	timer_delete_sync(&llbitmap->pending_timer);
+	flush_workqueue(md_llbitmap_io_wq);
+	flush_workqueue(md_llbitmap_unplug_wq);
+
+	mddev->bitmap = NULL;
+	llbitmap_free_pages(llbitmap);
+	kfree(llbitmap);
+	mutex_unlock(&mddev->bitmap_info.mutex);
+}
+
+static void llbitmap_start_write(struct mddev *mddev, sector_t offset,
+				 unsigned long sectors)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long start = offset >> llbitmap->chunkshift;
+	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
+	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+
+	llbitmap_state_machine(llbitmap, start, end, BitmapActionStartwrite);
+
+
+	while (page_start <= page_end) {
+		llbitmap_raise_barrier(llbitmap, page_start);
+		page_start++;
+	}
+}
+
+static void llbitmap_end_write(struct mddev *mddev, sector_t offset,
+			       unsigned long sectors)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long start = offset >> llbitmap->chunkshift;
+	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
+	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+
+	while (page_start <= page_end) {
+		llbitmap_release_barrier(llbitmap, page_start);
+		page_start++;
+	}
+}
+
+static void llbitmap_start_discard(struct mddev *mddev, sector_t offset,
+				   unsigned long sectors)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long start = DIV_ROUND_UP(offset, llbitmap->chunksize);
+	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
+	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+
+	llbitmap_state_machine(llbitmap, start, end, BitmapActionDiscard);
+
+	while (page_start <= page_end) {
+		llbitmap_raise_barrier(llbitmap, page_start);
+		page_start++;
+	}
+}
+
+static void llbitmap_end_discard(struct mddev *mddev, sector_t offset,
+				 unsigned long sectors)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long start = DIV_ROUND_UP(offset, llbitmap->chunksize);
+	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
+	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
+
+	while (page_start <= page_end) {
+		llbitmap_release_barrier(llbitmap, page_start);
+		page_start++;
+	}
+}
+
+static void llbitmap_unplug_fn(struct work_struct *work)
+{
+	struct llbitmap_unplug_work *unplug_work =
+		container_of(work, struct llbitmap_unplug_work, work);
+	struct llbitmap *llbitmap = unplug_work->llbitmap;
+	struct blk_plug plug;
+	int i;
+
+	blk_start_plug(&plug);
+
+	for (i = 0; i < llbitmap->nr_pages; i++) {
+		if (!test_bit(LLPageDirty, &llbitmap->pctl[i]->flags) ||
+		    !test_and_clear_bit(LLPageDirty, &llbitmap->pctl[i]->flags))
+			continue;
+
+		llbitmap_write_page(llbitmap, i);
+	}
+
+	blk_finish_plug(&plug);
+	md_super_wait(llbitmap->mddev);
+	complete(unplug_work->done);
+}
+
+static bool llbitmap_dirty(struct llbitmap *llbitmap)
+{
+	int i;
+
+	for (i = 0; i < llbitmap->nr_pages; i++)
+		if (test_bit(LLPageDirty, &llbitmap->pctl[i]->flags))
+			return true;
+
+	return false;
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
+	if (!llbitmap_dirty(llbitmap))
+		return;
+
+	/*
+	 * Issue new bitmap IO under submit_bio() context will deadlock:
+	 *  - the bio will wait for bitmap bio to be done, before it can be
+	 *  issued;
+	 *  - bitmap bio will be added to current->bio_list and wait for this
+	 *  bio to be issued;
+	 */
+	INIT_WORK_ONSTACK(&unplug_work.work, llbitmap_unplug_fn);
+	queue_work(md_llbitmap_unplug_wq, &unplug_work.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&unplug_work.work);
+}
+
+/*
+ * Force to write all bitmap pages to disk, called when stopping the array, or
+ * every daemon_sleep seconds when sync_thread is running.
+ */
+static void __llbitmap_flush(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	struct blk_plug plug;
+	int i;
+
+	blk_start_plug(&plug);
+	for (i = 0; i < llbitmap->nr_pages; i++) {
+		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
+
+		/* mark all bits as dirty */
+		set_bit(LLPageDirty, &pctl->flags);
+		bitmap_fill(pctl->dirty, llbitmap->blocks_per_page);
+		llbitmap_write_page(llbitmap, i);
+	}
+	blk_finish_plug(&plug);
+	md_super_wait(llbitmap->mddev);
+}
+
+static void llbitmap_flush(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	int i;
+
+	for (i = 0; i < llbitmap->nr_pages; i++)
+		set_bit(LLPageFlush, &llbitmap->pctl[i]->flags);
+
+	timer_delete_sync(&llbitmap->pending_timer);
+	queue_work(md_llbitmap_io_wq, &llbitmap->daemon_work);
+	flush_work(&llbitmap->daemon_work);
+
+	__llbitmap_flush(mddev);
+}
+
+/* This is used for raid5 lazy initial recovery */
+static bool llbitmap_blocks_synced(struct mddev *mddev, sector_t offset)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+	enum llbitmap_state c = llbitmap_read(llbitmap, p);
+
+	return c == BitClean || c == BitDirty;
+}
+
+static sector_t llbitmap_skip_sync_blocks(struct mddev *mddev, sector_t offset)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+	int blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	enum llbitmap_state c = llbitmap_read(llbitmap, p);
+
+	/* always skip unwritten blocks */
+	if (c == BitUnwritten)
+		return blocks;
+
+	/* For resync also skip clean/dirty blocks */
+	if ((c == BitClean || c == BitDirty) &&
+	    test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
+	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
+		return blocks;
+
+	return 0;
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
+	return llbitmap_state_machine(llbitmap, p, p,
+				      BitmapActionStartsync) == BitSyncing;
+}
+
+/* Something is wrong, sync_thread stop at @offset */
+static void llbitmap_end_sync(struct mddev *mddev, sector_t offset,
+			      sector_t *blocks)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+
+	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	llbitmap_state_machine(llbitmap, p, llbitmap->chunks - 1,
+			       BitmapActionAbortsync);
+}
+
+/* A full sync_thread is finished */
+static void llbitmap_close_sync(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	int i;
+
+	for (i = 0; i < llbitmap->nr_pages; i++) {
+		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
+
+		/* let daemon_fn clear dirty bits immediately */
+		WRITE_ONCE(pctl->expire, jiffies);
+	}
+
+	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1,
+			       BitmapActionEndsync);
+}
+
+/*
+ * sync_thread have reached @sector, update metadata every daemon_sleep seconds,
+ * just in case sync_thread have to restart after power failure.
+ */
+static void llbitmap_cond_end_sync(struct mddev *mddev, sector_t sector,
+				   bool force)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	if (sector == 0) {
+		llbitmap->last_end_sync = jiffies;
+		return;
+	}
+
+	if (time_before(jiffies, llbitmap->last_end_sync +
+				 HZ * mddev->bitmap_info.daemon_sleep))
+		return;
+
+	wait_event(mddev->recovery_wait, !atomic_read(&mddev->recovery_active));
+
+	mddev->curr_resync_completed = sector;
+	set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
+	llbitmap_state_machine(llbitmap, 0, sector >> llbitmap->chunkshift,
+			       BitmapActionEndsync);
+	__llbitmap_flush(mddev);
+
+	llbitmap->last_end_sync = jiffies;
+	sysfs_notify_dirent_safe(mddev->sysfs_completed);
+}
+
+static bool llbitmap_enabled(void *data, bool flush)
+{
+	struct llbitmap *llbitmap = data;
+
+	return llbitmap && !test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags);
+}
+
+static void llbitmap_dirty_bits(struct mddev *mddev, unsigned long s,
+				unsigned long e)
+{
+	llbitmap_state_machine(mddev->bitmap, s, e, BitmapActionStartwrite);
+}
+
+static void llbitmap_write_sb(struct llbitmap *llbitmap)
+{
+	int nr_bits = DIV_ROUND_UP(BITMAP_DATA_OFFSET, llbitmap->io_size);
+
+	bitmap_fill(llbitmap->pctl[0]->dirty, nr_bits);
+	llbitmap_write_page(llbitmap, 0);
+	md_super_wait(llbitmap->mddev);
+}
+
+static void llbitmap_update_sb(void *data)
+{
+	struct llbitmap *llbitmap = data;
+	struct mddev *mddev = llbitmap->mddev;
+	struct page *sb_page;
+	bitmap_super_t *sb;
+
+	if (test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags))
+		return;
+
+	sb_page = llbitmap_read_page(llbitmap, 0);
+	if (IS_ERR(sb_page)) {
+		pr_err("%s: %s: read super block failed", __func__,
+		       mdname(mddev));
+		set_bit(BITMAP_WRITE_ERROR, &llbitmap->flags);
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
+	llbitmap_write_sb(llbitmap);
+}
+
+static int llbitmap_get_stats(void *data, struct md_bitmap_stats *stats)
+{
+	struct llbitmap *llbitmap = data;
+
+	memset(stats, 0, sizeof(*stats));
+
+	stats->missing_pages = 0;
+	stats->pages = llbitmap->nr_pages;
+	stats->file_pages = llbitmap->nr_pages;
+
+	stats->behind_writes = atomic_read(&llbitmap->behind_writes);
+	stats->behind_wait = wq_has_sleeper(&llbitmap->behind_wait);
+	stats->events_cleared = llbitmap->events_cleared;
+
+	return 0;
+}
+
+/* just flag all pages as needing to be written */
+static void llbitmap_write_all(struct mddev *mddev)
+{
+	int i;
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	for (i = 0; i < llbitmap->nr_pages; i++) {
+		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
+
+		set_bit(LLPageDirty, &pctl->flags);
+		bitmap_fill(pctl->dirty, llbitmap->blocks_per_page);
+	}
+}
+
+static void llbitmap_start_behind_write(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	atomic_inc(&llbitmap->behind_writes);
+}
+
+static void llbitmap_end_behind_write(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	if (atomic_dec_and_test(&llbitmap->behind_writes))
+		wake_up(&llbitmap->behind_wait);
+}
+
+static void llbitmap_wait_behind_writes(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	if (!llbitmap)
+		return;
+
+	wait_event(llbitmap->behind_wait,
+		   atomic_read(&llbitmap->behind_writes) == 0);
+
+}
+
+static ssize_t bits_show(struct mddev *mddev, char *page)
+{
+	struct llbitmap *llbitmap;
+	int bits[BitStateCount] = {0};
+	loff_t start = 0;
+
+	mutex_lock(&mddev->bitmap_info.mutex);
+	llbitmap = mddev->bitmap;
+	if (!llbitmap || !llbitmap->pctl) {
+		mutex_unlock(&mddev->bitmap_info.mutex);
+		return sprintf(page, "no bitmap\n");
+	}
+
+	if (test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags)) {
+		mutex_unlock(&mddev->bitmap_info.mutex);
+		return sprintf(page, "bitmap io error\n");
+	}
+
+	while (start < llbitmap->chunks) {
+		enum llbitmap_state c = llbitmap_read(llbitmap, start);
+
+		if (c < 0 || c >= BitStateCount)
+			pr_err("%s: invalid bit %llu state %d\n",
+			       __func__, start, c);
+		else
+			bits[c]++;
+		start++;
+	}
+
+	mutex_unlock(&mddev->bitmap_info.mutex);
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
+	struct llbitmap *llbitmap;
+	ssize_t ret;
+
+	mutex_lock(&mddev->bitmap_info.mutex);
+	llbitmap = mddev->bitmap;
+	if (!llbitmap) {
+		mutex_unlock(&mddev->bitmap_info.mutex);
+		return sprintf(page, "no bitmap\n");
+	}
+
+	ret =  sprintf(page, "chunksize %lu\nchunkshift %lu\nchunks %lu\noffset %llu\ndaemon_sleep %lu\n",
+		       llbitmap->chunksize, llbitmap->chunkshift,
+		       llbitmap->chunks, mddev->bitmap_info.offset,
+		       llbitmap->mddev->bitmap_info.daemon_sleep);
+	mutex_unlock(&mddev->bitmap_info.mutex);
+
+	return ret;
+}
+
+static struct md_sysfs_entry llbitmap_metadata =
+__ATTR_RO(metadata);
+
+static ssize_t
+daemon_sleep_show(struct mddev *mddev, char *page)
+{
+	return sprintf(page, "%lu\n", mddev->bitmap_info.daemon_sleep);
+}
+
+static ssize_t
+daemon_sleep_store(struct mddev *mddev, const char *buf, size_t len)
+{
+	unsigned long timeout;
+	int rv = kstrtoul(buf, 10, &timeout);
+
+	if (rv)
+		return rv;
+
+	mddev->bitmap_info.daemon_sleep = timeout;
+	return len;
+}
+
+static struct md_sysfs_entry llbitmap_daemon_sleep =
+__ATTR_RW(daemon_sleep);
+
+static ssize_t
+barrier_idle_show(struct mddev *mddev, char *page)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+
+	return sprintf(page, "%lu\n", llbitmap->barrier_idle);
+}
+
+static ssize_t
+barrier_idle_store(struct mddev *mddev, const char *buf, size_t len)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long timeout;
+	int rv = kstrtoul(buf, 10, &timeout);
+
+	if (rv)
+		return rv;
+
+	llbitmap->barrier_idle = timeout;
+	return len;
+}
+
+static struct md_sysfs_entry llbitmap_barrier_idle =
+__ATTR_RW(barrier_idle);
+
+static struct attribute *md_llbitmap_attrs[] = {
+	&llbitmap_bits.attr,
+	&llbitmap_metadata.attr,
+	&llbitmap_daemon_sleep.attr,
+	&llbitmap_barrier_idle.attr,
+	NULL
+};
+
+static struct attribute_group md_llbitmap_group = {
+	.name = "llbitmap",
+	.attrs = md_llbitmap_attrs,
+};
+
+static struct bitmap_operations llbitmap_ops = {
+	.head = {
+		.type	= MD_BITMAP,
+		.id	= ID_LLBITMAP,
+		.name	= "llbitmap",
+	},
+
+	.enabled		= llbitmap_enabled,
+	.create			= llbitmap_create,
+	.resize			= llbitmap_resize,
+	.load			= llbitmap_load,
+	.destroy		= llbitmap_destroy,
+
+	.start_write		= llbitmap_start_write,
+	.end_write		= llbitmap_end_write,
+	.start_discard		= llbitmap_start_discard,
+	.end_discard		= llbitmap_end_discard,
+	.unplug			= llbitmap_unplug,
+	.flush			= llbitmap_flush,
+
+	.start_behind_write	= llbitmap_start_behind_write,
+	.end_behind_write	= llbitmap_end_behind_write,
+	.wait_behind_writes	= llbitmap_wait_behind_writes,
+
+	.blocks_synced		= llbitmap_blocks_synced,
+	.skip_sync_blocks	= llbitmap_skip_sync_blocks,
+	.start_sync		= llbitmap_start_sync,
+	.end_sync		= llbitmap_end_sync,
+	.close_sync		= llbitmap_close_sync,
+	.cond_end_sync		= llbitmap_cond_end_sync,
+
+	.update_sb		= llbitmap_update_sb,
+	.get_stats		= llbitmap_get_stats,
+	.dirty_bits		= llbitmap_dirty_bits,
+	.write_all		= llbitmap_write_all,
+
+	.group			= &md_llbitmap_group,
+};
+
+int md_llbitmap_init(void)
+{
+	md_llbitmap_io_wq = alloc_workqueue("md_llbitmap_io",
+					 WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!md_llbitmap_io_wq)
+		return -ENOMEM;
+
+	md_llbitmap_unplug_wq = alloc_workqueue("md_llbitmap_unplug",
+					 WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!md_llbitmap_unplug_wq) {
+		destroy_workqueue(md_llbitmap_io_wq);
+		md_llbitmap_io_wq = NULL;
+		return -ENOMEM;
+	}
+
+	return register_md_submodule(&llbitmap_ops.head);
+}
+
+void md_llbitmap_exit(void)
+{
+	destroy_workqueue(md_llbitmap_io_wq);
+	md_llbitmap_io_wq = NULL;
+	destroy_workqueue(md_llbitmap_unplug_wq);
+	md_llbitmap_unplug_wq = NULL;
+	unregister_md_submodule(&llbitmap_ops.head);
+}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 90b8f9a70152..688ba1a58e55 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -10228,6 +10228,10 @@ static int __init md_init(void)
 	if (ret)
 		return ret;
 
+	ret = md_llbitmap_init();
+	if (ret)
+		goto err_bitmap;
+
 	ret = -ENOMEM;
 	md_wq = alloc_workqueue("md", WQ_MEM_RECLAIM, 0);
 	if (!md_wq)
@@ -10259,6 +10263,8 @@ static int __init md_init(void)
 err_misc_wq:
 	destroy_workqueue(md_wq);
 err_wq:
+	md_llbitmap_exit();
+err_bitmap:
 	md_bitmap_exit();
 	return ret;
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 7b6357879a84..1979c2d4fe89 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -26,7 +26,7 @@
 enum md_submodule_type {
 	MD_PERSONALITY = 0,
 	MD_CLUSTER,
-	MD_BITMAP, /* TODO */
+	MD_BITMAP,
 };
 
 enum md_submodule_id {
@@ -39,7 +39,7 @@ enum md_submodule_id {
 	ID_RAID10	= 10,
 	ID_CLUSTER,
 	ID_BITMAP,
-	ID_LLBITMAP,	/* TODO */
+	ID_LLBITMAP,
 	ID_BITMAP_NONE,
 };
 
-- 
2.39.2


