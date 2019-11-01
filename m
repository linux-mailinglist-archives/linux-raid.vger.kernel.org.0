Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98C4EC493
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKAOXR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45151 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfKAOXQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id y7so7660045edo.12
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EOroPgqxveHYLKeJtP/fW/d5jhXnEks0g2Gc+tkfBBo=;
        b=qLjhBTGe0odl6kKb6ScYRlHkCGKgnlD8z+BccwuTMCM0qmRQ3Hy2FpMyGwNiN3dozV
         um2CjXZPLvxSSGz0PzKaNHxwhlozBJcUKaQ+0q2SuUVFsR6MFLy/tQH4gMO3rDXl/JY1
         kn5Yu/9XEW+h+DZiBUvfaXKxgFzuvwce757t3Xmphjok8oDsDIJ4ugihTBr3ZDfBznKY
         a7OELkg22bTz16JU+B3ghr3u9mU7NnMdBY9hdCXaOM/Nz6Cl/NRFKwSwFopsC/X8Dyau
         1qf4FS7LnHq64dTDLlLiCGN4Y48hnbyfm3Wc63zY06gGEJ86btbn5qwBK9/FWCTkR9c7
         pcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EOroPgqxveHYLKeJtP/fW/d5jhXnEks0g2Gc+tkfBBo=;
        b=K56iT7cbx4joOCvxvgYSVLpqiHFogFswqPEZ2+Jrc4W375kjv+0Z1ytXZXMaRq0YbH
         sgMcS0Dqu2wMQpTdwP/OZsK5GxTv1fE85OWQHgRh9VPANRijUC0qugO+vsZ1xGMMSEPJ
         GXBhtM87xsK/x7QkpDJWrAxGd45A8SblkGAVdZMXfy/hbKQVjW3iJ6ZE32KydjHoxcLo
         tP8Hs5VQdoucCEXAVbsZZTRUZaqt8SAZq8qctlfNhfHzKzAPlVhlAumIMSlhtjroVbwN
         2emdge3KfAF2+45XoRxInFc+djpMSslOLnnr+3uaK+SvhJpXopmoAurswDAa8EMkfiZb
         c3YA==
X-Gm-Message-State: APjAAAWgCPOLFt92q+CAagOQrON0EtRNW8OTG9L1wmolw86fIh/rwJNI
        cjmHL+jXtZXrplwNbGhYS0KRXomd
X-Google-Smtp-Source: APXvYqzCaht1uIG3yDmzqmJB0TpIlXCTCcSs98eq37AQCgA+2SER42Lw4OaWzQTSKTW+vAMdKN+9xA==
X-Received: by 2002:a17:906:aada:: with SMTP id kt26mr10126498ejb.261.1572618193512;
        Fri, 01 Nov 2019 07:23:13 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:12 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 6/8] md: switch from list to rb tree for IO serialization
Date:   Fri,  1 Nov 2019 15:22:29 +0100
Message-Id: <20191101142231.23359-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Obviously, IO serialization could cause the degradation of
performance. In order to reduce the degradation, it is better
to replace link list with rb tree.

And with the inspiration of drbd_interval.c, a simpler
implementation of rb tree is introduced. The rb tree mainly
implements insert/remove rb node, check if bio is overlapped
and get bio related rb node. When a rb node is inserted/deleted,
rb node needs to re-compute the highest end of it's subtree
to search certain range of bio.

Also, rename serial_list_lock to serial_rb_lock since it is
used to protect rb tree now.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c    |   4 +-
 drivers/md/md.h    |  11 ++--
 drivers/md/raid1.c | 152 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 135 insertions(+), 32 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8df94a58512b..6d0e076f8099 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -127,8 +127,8 @@ static inline int speed_max(struct mddev *mddev)
 
 static int rdev_init_serial(struct md_rdev *rdev)
 {
-	spin_lock_init(&rdev->serial_list_lock);
-	INIT_LIST_HEAD(&rdev->serial_list);
+	spin_lock_init(&rdev->serial_rb_lock);
+	rdev->serial_rb = RB_ROOT;
 	init_waitqueue_head(&rdev->serial_io_wait);
 	set_bit(CollisionCheck, &rdev->flags);
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 161772066dab..eeceb79ae226 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -113,8 +113,8 @@ struct md_rdev {
 	/*
 	 * The members for check collision of write behind IOs.
 	 */
-	struct list_head serial_list;
-	spinlock_t serial_list_lock;
+	struct rb_root serial_rb;
+	spinlock_t serial_rb_lock;
 	wait_queue_head_t serial_io_wait;
 
 	struct work_struct del_work;	/* used for delayed sysfs removal */
@@ -266,9 +266,10 @@ enum mddev_sb_flags {
 #define NR_SERIAL_INFOS		8
 /* record current range of serialize IOs */
 struct serial_info {
-	sector_t lo;
-	sector_t hi;
-	struct list_head list;
+	sector_t sector;	/* start sector of IO range */
+	unsigned long size;	/* size in bytes of IO */
+	struct rb_node rb;
+	sector_t end;		/* highest interval end in subtree of rb node */
 };
 
 struct mddev {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4f683a3d44c0..48e7cd8f26a8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
+#include <linux/rbtree_augmented.h>
 
 #include <trace/events/block.h>
 
@@ -50,31 +51,135 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 
 #include "raid1-10.c"
 
+/*
+ * interval_end - return end of rb node
+ */
+static inline sector_t interval_end(struct rb_node *node)
+{
+	struct serial_info *this = rb_entry(node, struct serial_info, rb);
+
+	return this->end;
+}
+
+#define NODE_END(node) ((node)->sector + ((node)->size >> 9))
+RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
+			 struct serial_info, rb, sector_t, end, NODE_END);
+
+/*
+ * insert_interval - insert a new interval into a tree
+ */
+static void insert_interval(struct rb_root *root, struct serial_info *this)
+{
+	struct rb_node **new = &root->rb_node, *parent = NULL;
+	sector_t this_end = this->sector + (this->size >> 9);
+
+	while (*new) {
+		struct serial_info *here =
+			rb_entry(*new, struct serial_info, rb);
+
+		parent = *new;
+		if (here->end < this_end)
+			here->end = this_end;
+
+		if (this->sector < here->sector)
+			new = &(*new)->rb_left;
+		else if (this->sector > here->sector)
+			new = &(*new)->rb_right;
+	}
+
+	this->end = this_end;
+	rb_link_node(&this->rb, parent, new);
+	rb_insert_augmented(&this->rb, root, &augment_callbacks);
+}
+
+/*
+ * contains_interval - check if a tree contains interval [sector, sector + size]
+ *
+ * Returns if the tree contains the node @interval with start sector @start.
+ * or NULL if interval is not in the tree.
+ */
+static struct serial_info *
+contains_interval(struct rb_root *root, sector_t sector, unsigned long size)
+{
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		struct serial_info *here =
+			rb_entry(node, struct serial_info, rb);
+
+		if (sector == here->sector && size == here->size)
+			return here;
+		if (sector < here->sector)
+			node = node->rb_left;
+		else if (sector > here->sector)
+			node = node->rb_right;
+	}
+	return NULL;
+}
+
+/*
+ * remove_interval - remove an interval from a rb tree
+ */
+static void remove_interval(struct rb_root *root, struct serial_info *this)
+{
+	rb_erase_augmented(&this->rb, root, &augment_callbacks);
+}
+
+/*
+ * find_overlap - search an interval overlapping with [sector, sector + size]
+ *
+ * Returns an interval overlapping with the interval or NULL if there is none.
+ */
+static struct serial_info *
+find_overlap(struct rb_root *root, sector_t sector, unsigned long size)
+{
+	struct rb_node *node = root->rb_node;
+	struct serial_info *overlap = NULL;
+	sector_t end = sector + (size >> 9);
+
+	while (node) {
+		struct serial_info *here =
+			rb_entry(node, struct serial_info, rb);
+
+		if (node->rb_left &&
+		    sector < interval_end(node->rb_left)) {
+			/* Overlap if any must be on left side */
+			node = node->rb_left;
+		} else if (here->sector < end &&
+			   sector < here->sector + (here->size >> 9)) {
+			overlap = here;
+			break;
+		} else if (sector >= here->sector) {
+			/* Overlap if any must be on right side */
+			node = node->rb_right;
+		} else
+			break;
+	}
+	return overlap;
+}
+
 static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
-	struct serial_info *wi, *temp_wi;
+	struct serial_info *wi;
 	unsigned long flags;
 	int ret = 0;
+	unsigned long size = (hi - lo) << 9;
 	struct mddev *mddev = rdev->mddev;
 
 	wi = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
 
-	spin_lock_irqsave(&rdev->serial_list_lock, flags);
-	list_for_each_entry(temp_wi, &rdev->serial_list, list) {
-		/* collision happened */
-		if (hi > temp_wi->lo && lo < temp_wi->hi) {
-			ret = -EBUSY;
-			break;
-		}
-	}
+	spin_lock_irqsave(&rdev->serial_rb_lock, flags);
+	/* collision happened */
+	if (find_overlap(&rdev->serial_rb, lo, size))
+		ret = -EBUSY;
 
 	if (!ret) {
-		wi->lo = lo;
-		wi->hi = hi;
-		list_add(&wi->list, &rdev->serial_list);
+		wi->sector = lo;
+		wi->size = size;
+		insert_interval(&rdev->serial_rb, wi);
 	} else
 		mempool_free(wi, mddev->serial_info_pool);
-	spin_unlock_irqrestore(&rdev->serial_list_lock, flags);
+	spin_unlock_irqrestore(&rdev->serial_rb_lock, flags);
 
 	return ret;
 }
@@ -83,21 +188,18 @@ static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
 	struct serial_info *wi;
 	unsigned long flags;
-	int found = 0;
 	struct mddev *mddev = rdev->mddev;
+	unsigned long size = (hi - lo) << 9;
 
-	spin_lock_irqsave(&rdev->serial_list_lock, flags);
-	list_for_each_entry(wi, &rdev->serial_list, list)
-		if (hi == wi->hi && lo == wi->lo) {
-			list_del(&wi->list);
-			mempool_free(wi, mddev->serial_info_pool);
-			found = 1;
-			break;
-		}
-
-	if (!found)
+	spin_lock_irqsave(&rdev->serial_rb_lock, flags);
+	wi = contains_interval(&rdev->serial_rb, lo, size);
+	if (wi) {
+		remove_interval(&rdev->serial_rb, wi);
+		RB_CLEAR_NODE(&wi->rb);
+		mempool_free(wi, mddev->serial_info_pool);
+	} else
 		WARN(1, "The write IO is not recorded for serialization\n");
-	spin_unlock_irqrestore(&rdev->serial_list_lock, flags);
+	spin_unlock_irqrestore(&rdev->serial_rb_lock, flags);
 	wake_up(&rdev->serial_io_wait);
 }
 
-- 
2.17.1

