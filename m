Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF48573579
	for <lists+linux-raid@lfdr.de>; Wed, 13 Jul 2022 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiGMLb6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 Jul 2022 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiGMLbt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 Jul 2022 07:31:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022E10272D;
        Wed, 13 Jul 2022 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=knSIqFo/SrgbF+0BNSi9jf07y509Gse6Gydnoplpxg8=; b=KAjG50uPOti2LkZUxXnJUiBcyC
        V0OCay57avOPnTHG43lbQvz6BDn/woNcn1E8jtyRkpFI6OPk8Jx5BcykFTOcK6Fs4clQZfG1I7V1m
        SQTEMS/uLv68rH4KmSjH/AQuoS6stP3Pas9vr6RJ1YOFBJqqCLSTlEqqutpn8doR7O1DSHoAR6xJU
        yzukm7IlvXiJW/eEIZ6AMDp/krU4310NpcpReAKRpYzxPUITsjoKbpW/FdDsmlp2Tw4qOlViQflZH
        +wN0xiHXiWZVPCavnO0/BJVdPOegOJ6YRqWnRTBFLvHVz3KsMLYuK7gTrTkksQftZWY/OUqZpHL9m
        mfA3gP8g==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBaao-003A9m-82; Wed, 13 Jul 2022 11:31:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 8/9] md: only delete entries from all_mddevs when the disk is freed
Date:   Wed, 13 Jul 2022 13:31:24 +0200
Message-Id: <20220713113125.2232975-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713113125.2232975-1-hch@lst.de>
References: <20220713113125.2232975-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This ensures device names don't get prematurely reused.  Instead add a
deleted flag to skip already deleted devices in mddev_get and other
places that only want to see live mddevs.

Reported-by; Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 56 +++++++++++++++++++++++++++++++++----------------
 drivers/md/md.h |  1 +
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index df99a16892bce..f3ff61e540ee0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -625,6 +625,10 @@ EXPORT_SYMBOL(md_flush_request);
 
 static inline struct mddev *mddev_get(struct mddev *mddev)
 {
+	lockdep_assert_held(&all_mddevs_lock);
+
+	if (mddev->deleted)
+		return NULL;
 	atomic_inc(&mddev->active);
 	return mddev;
 }
@@ -639,7 +643,7 @@ static void mddev_put(struct mddev *mddev)
 	    mddev->ctime == 0 && !mddev->hold_active) {
 		/* Array is not configured at all, and not held active,
 		 * so destroy it */
-		list_del_init(&mddev->all_mddevs);
+		mddev->deleted = true;
 
 		/*
 		 * Call queue_work inside the spinlock so that
@@ -720,8 +724,8 @@ static struct mddev *mddev_find(dev_t unit)
 
 	spin_lock(&all_mddevs_lock);
 	mddev = mddev_find_locked(unit);
-	if (mddev)
-		mddev_get(mddev);
+	if (mddev && !mddev_get(mddev))
+		mddev = NULL;
 	spin_unlock(&all_mddevs_lock);
 
 	return mddev;
@@ -3339,6 +3343,8 @@ static bool md_rdev_overlaps(struct md_rdev *rdev)
 
 	spin_lock(&all_mddevs_lock);
 	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
+		if (mddev->deleted)
+			continue;
 		rdev_for_each(rdev2, mddev) {
 			if (rdev != rdev2 && rdev->bdev == rdev2->bdev &&
 			    md_rdevs_overlap(rdev, rdev2)) {
@@ -5526,11 +5532,10 @@ md_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	spin_lock(&all_mddevs_lock);
-	if (list_empty(&mddev->all_mddevs)) {
+	if (!mddev_get(mddev)) {
 		spin_unlock(&all_mddevs_lock);
 		return -EBUSY;
 	}
-	mddev_get(mddev);
 	spin_unlock(&all_mddevs_lock);
 
 	rv = entry->show(mddev, page);
@@ -5551,11 +5556,10 @@ md_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	spin_lock(&all_mddevs_lock);
-	if (list_empty(&mddev->all_mddevs)) {
+	if (!mddev_get(mddev)) {
 		spin_unlock(&all_mddevs_lock);
 		return -EBUSY;
 	}
-	mddev_get(mddev);
 	spin_unlock(&all_mddevs_lock);
 	rv = entry->store(mddev, page, length);
 	mddev_put(mddev);
@@ -7852,7 +7856,7 @@ static void md_free_disk(struct gendisk *disk)
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 
-	kfree(mddev);
+	mddev_free(mddev);
 }
 
 const struct block_device_operations md_fops =
@@ -8174,6 +8178,8 @@ static void *md_seq_start(struct seq_file *seq, loff_t *pos)
 		if (!l--) {
 			mddev = list_entry(tmp, struct mddev, all_mddevs);
 			mddev_get(mddev);
+			if (!mddev_get(mddev))
+				continue;
 			spin_unlock(&all_mddevs_lock);
 			return mddev;
 		}
@@ -8187,25 +8193,35 @@ static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct list_head *tmp;
 	struct mddev *next_mddev, *mddev = v;
+	struct mddev *to_put = NULL;
 
 	++*pos;
 	if (v == (void*)2)
 		return NULL;
 
 	spin_lock(&all_mddevs_lock);
-	if (v == (void*)1)
+	if (v == (void*)1) {
 		tmp = all_mddevs.next;
-	else
+	} else {
+		to_put = mddev;
 		tmp = mddev->all_mddevs.next;
-	if (tmp != &all_mddevs)
-		next_mddev = mddev_get(list_entry(tmp,struct mddev,all_mddevs));
-	else {
-		next_mddev = (void*)2;
-		*pos = 0x10000;
 	}
+
+	for (;;) {
+		if (tmp == &all_mddevs) {
+			next_mddev = (void*)2;
+			*pos = 0x10000;
+			break;
+		}
+		next_mddev = list_entry(tmp, struct mddev, all_mddevs);
+		if (mddev_get(next_mddev))
+			break;
+		mddev = next_mddev;
+		tmp = mddev->all_mddevs.next;
+	};
 	spin_unlock(&all_mddevs_lock);
 
-	if (v != (void*)1)
+	if (to_put)
 		mddev_put(mddev);
 	return next_mddev;
 
@@ -8769,6 +8785,8 @@ void md_do_sync(struct md_thread *thread)
 			goto skip;
 		spin_lock(&all_mddevs_lock);
 		list_for_each_entry(mddev2, &all_mddevs, all_mddevs) {
+			if (mddev2->deleted)
+				continue;
 			if (mddev2 == mddev)
 				continue;
 			if (!mddev->parallel_resync
@@ -9571,7 +9589,8 @@ static int md_notify_reboot(struct notifier_block *this,
 
 	spin_lock(&all_mddevs_lock);
 	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
-		mddev_get(mddev);
+		if (!mddev_get(mddev))
+			continue;
 		spin_unlock(&all_mddevs_lock);
 		if (mddev_trylock(mddev)) {
 			if (mddev->pers)
@@ -9926,7 +9945,8 @@ static __exit void md_exit(void)
 
 	spin_lock(&all_mddevs_lock);
 	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
-		mddev_get(mddev);
+		if (!mddev_get(mddev))
+			continue;
 		spin_unlock(&all_mddevs_lock);
 		export_array(mddev);
 		mddev->ctime = 0;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1a85dbe78a71c..bc870e1f1e8c2 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -503,6 +503,7 @@ struct mddev {
 
 	atomic_t			max_corr_read_errors; /* max read retries */
 	struct list_head		all_mddevs;
+	bool				deleted;
 
 	const struct attribute_group	*to_remove;
 
-- 
2.30.2

