Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB171050A1
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKUKhn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43202 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfKUKhm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id w6so2325895edx.10
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=roWfbNWsj8OVX0t/0ZCCpy0Q0fQcbcQgGTW/H9V1mss=;
        b=uz14/k/Tno6jDEvnpwTVUuogkYcZ0w7/zFwywKrsWHjtmiLxTJ7bCbJNU6Gq7WfVXP
         +PNtoJMv4d10JBZr3luhU+sqWAxhs7NwJdJ/9NZojHNBQSvtjm1l2z7JCJw1gu9LKQdA
         61ndWAq7Hkxfb61uFN5I0QzB6PjEAbdMr2n9qlkxJk4nk51PQruaFRLtgtLz7/e4G3f6
         UuVOAtX8A9BrrzF7D42HapYXLtbYYZAn3CB1EHTs+5jRz36S5NfSv7HHihQYbZ9Hr9xP
         R3u2HU4aBWFag6Zka+XnZPdl/1YOQ/d9zLjIg71G4GdQfl8+vbtWEtwotDxfN+ycQAw1
         CO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=roWfbNWsj8OVX0t/0ZCCpy0Q0fQcbcQgGTW/H9V1mss=;
        b=PKGp53jE2GkJUQV1RkEX695Q2bWcPewbT9MRmN+uOZt5RO9qn6F9UR0eS19A885dMl
         aKoF6qD0VzGtC1LeZXdYrwgT1/h8vlLQLxxMlzdvM28D97H+MHziCYpmOAKLQcbU2klz
         BU5tlTYNSa5AItmXJNBnc7CkRCBURb/VQJs98KRumabFmIIVkBDH9wsZVJco9uv5DTJp
         Vv7LQULNmMYnig3gahvbEwROdd9dQxnbZHA3tHfhaN/UQuqVTT+GTUBurkJoANZbD0Kq
         oI6N+PQM1hIoNNtL/SzuTshugUF2frzsr0yDj38tkkChobtWA21RmXb7ol5FoaLR79us
         PsTQ==
X-Gm-Message-State: APjAAAVS8MvDeLZvqF+xG8vQGxg0coR6hi5NuVCXZEls9UpdA4yHrZPd
        Jn9+v+UerfNnZvV8gk6RCw0=
X-Google-Smtp-Source: APXvYqyay5bAoMU+Z0VidaNRsw3wx3er0/u+XrRNXZKg3yJcQ2TXpOxK2yJsB2j37OpsWH2WOH4uZw==
X-Received: by 2002:a17:906:e087:: with SMTP id gh7mr12807249ejb.278.1574332660128;
        Thu, 21 Nov 2019 02:37:40 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:39 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 2/9] md: prepare for enable raid1 io serialization
Date:   Thu, 21 Nov 2019 11:37:21 +0100
Message-Id: <20191121103728.18919-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

1. The related resources (spin_lock, list and waitqueue) are needed for
address raid1 reorder overlap issue too, so add "is_force" parameter to
funcs (mddev_create/destroy_serial_pool). The parameter is set to true
if we want to enable or disable raid1 io serialization in later patch.

And also add "is_suspend" to mddev_destroy_serial_pool since it will
be called under suspended situation, which also makes both create and
destroy pool have same arguments.

2. Introduce rdevs_init_serial which is called if raid1 io serialization
is enabled since all rdevs need to init related stuffs.

3. rdev_init_serial and clear_bit(CollisionCheck, &rdev->flags) should
be called between suspend and resume.

No need to export mddev_create_serial_pool since it is only called in
md-mod module.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c |  4 +--
 drivers/md/md.c        | 70 +++++++++++++++++++++++++++++-------------
 drivers/md/md.h        |  2 +-
 3 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 5058716918ef..eff297cf5a81 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1908,7 +1908,7 @@ int md_bitmap_load(struct mddev *mddev)
 		goto out;
 
 	rdev_for_each(rdev, mddev)
-		mddev_create_serial_pool(mddev, rdev, true);
+		mddev_create_serial_pool(mddev, rdev, true, false);
 
 	if (mddev_is_clustered(mddev))
 		md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
@@ -2484,7 +2484,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 		struct md_rdev *rdev;
 
 		rdev_for_each(rdev, mddev)
-			mddev_create_serial_pool(mddev, rdev, false);
+			mddev_create_serial_pool(mddev, rdev, false, false);
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2a44c1db9061..d3619aa39b89 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -127,9 +127,6 @@ static inline int speed_max(struct mddev *mddev)
 
 static int rdev_init_serial(struct md_rdev *rdev)
 {
-	if (rdev->bdev->bd_queue->nr_hw_queues == 1)
-		return 0;
-
 	spin_lock_init(&rdev->serial_list_lock);
 	INIT_LIST_HEAD(&rdev->serial_list);
 	init_waitqueue_head(&rdev->serial_io_wait);
@@ -138,17 +135,30 @@ static int rdev_init_serial(struct md_rdev *rdev)
 	return 1;
 }
 
+static void rdevs_init_serial(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		if (test_bit(CollisionCheck, &rdev->flags))
+			continue;
+		rdev_init_serial(rdev);
+	}
+}
+
 /*
- * Create serial_info_pool if rdev is the first multi-queue device flaged
- * with writemostly, also write-behind mode is enabled.
+ * Create serial_info_pool for raid1 under conditions:
+ * 1. rdev is the first multi-queue device flaged with writemostly,
+ *    also write-behind mode is enabled.
+ * 2. is_force is true which means we want to enable serialization
+ *    for normal raid1 array.
  */
 void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			  bool is_suspend)
+			      bool is_suspend, bool is_force)
 {
-	if (mddev->bitmap_info.max_write_behind == 0)
-		return;
-
-	if (!test_bit(WriteMostly, &rdev->flags) || !rdev_init_serial(rdev))
+	if (!is_force && (mddev->bitmap_info.max_write_behind == 0 ||
+			  (rdev && (rdev->bdev->bd_queue->nr_hw_queues == 1 ||
+				    !test_bit(WriteMostly, &rdev->flags)))))
 		return;
 
 	if (mddev->serial_info_pool == NULL) {
@@ -156,6 +166,10 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 
 		if (!is_suspend)
 			mddev_suspend(mddev);
+		if (is_force)
+			rdevs_init_serial(mddev);
+		if (!is_force && rdev)
+			rdev_init_serial(rdev);
 		noio_flag = memalloc_noio_save();
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
@@ -167,15 +181,16 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mddev_resume(mddev);
 	}
 }
-EXPORT_SYMBOL_GPL(mddev_create_serial_pool);
 
 /*
  * Destroy serial_info_pool if rdev is the last device flaged with
- * CollisionCheck.
+ * CollisionCheck, or is_force is true when we disable serialization
+ * for normal raid1.
  */
-static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
+static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
+				      bool is_suspend, bool is_force)
 {
-	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
+	if (!(is_force || test_bit(CollisionCheck, &rdev->flags)))
 		return;
 
 	if (mddev->serial_info_pool) {
@@ -185,16 +200,27 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 		/*
 		 * Check if other rdevs need serial_info_pool.
 		 */
-		rdev_for_each(temp, mddev)
+		if (!is_suspend)
+			mddev_suspend(mddev);
+		rdev_for_each(temp, mddev) {
+			if (is_force) {
+				clear_bit(CollisionCheck, &temp->flags);
+				continue;
+			}
+
 			if (temp != rdev &&
 			    test_bit(CollisionCheck, &temp->flags))
 				num++;
-		if (!num) {
-			mddev_suspend(rdev->mddev);
+		}
+
+		if (!is_force)
+			clear_bit(CollisionCheck, &rdev->flags);
+		if (is_force || !num) {
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
-			mddev_resume(rdev->mddev);
 		}
+		if (!is_suspend)
+			mddev_resume(mddev);
 	}
 }
 
@@ -2307,7 +2333,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, false);
+		mddev_create_serial_pool(mddev, rdev, false, false);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -2345,7 +2371,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
-	mddev_destroy_serial_pool(rdev->mddev, rdev);
+	mddev_destroy_serial_pool(rdev->mddev, rdev, false, false);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2858,10 +2884,10 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		}
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
-		mddev_create_serial_pool(rdev->mddev, rdev, false);
+		mddev_create_serial_pool(rdev->mddev, rdev, false, false);
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev);
+		mddev_destroy_serial_pool(rdev->mddev, rdev, false, false);
 		clear_bit(WriteMostly, &rdev->flags);
 		err = 0;
 	} else if (cmd_match(buf, "blocked")) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 218950b88af6..3ca0c3ac4640 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -738,7 +738,7 @@ extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
 extern void md_kick_rdev_from_array(struct md_rdev * rdev);
 extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				 bool is_suspend);
+				     bool is_suspend, bool is_force);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-- 
2.17.1

