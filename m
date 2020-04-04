Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE519E7D9
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 00:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDDWBG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Apr 2020 18:01:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44392 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgDDWBF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 4 Apr 2020 18:01:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so13921562edy.11
        for <linux-raid@vger.kernel.org>; Sat, 04 Apr 2020 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xe87WQKWCMk/aESjyrvf68aI8ixzVnVe48T3ILH1BmQ=;
        b=MhOfqtbZYO2SuKUj7ylHxFYVbuqLTVab/fSbRxMjGZO+8BcnB1yxYWbujaTpox9m4u
         MYzoj5WdItXFH3Wot8vNcCOb/rG7YNN4tho4BDsU+MUr1chdyEHmvXIA8T+pxT0eK2K8
         G0+Xh9F4d0Z8ja9KwamtRcqTSNBuPqYXAhK2siHuwjjlylJ/w/3w6olSVGN5iLXGFscn
         NB+erFKEed7tJC9+peMa5YAFT/DGVmU2mKfiTpVTBQLioQiW8nLDg5vXDryqZ3/bDH+7
         BxTKV1BIBrn8ZX0/KrK7xnmGlpku32ObraeAAU/kxVVHrMHLkRfkOqZeRniLVsH++hx/
         g7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xe87WQKWCMk/aESjyrvf68aI8ixzVnVe48T3ILH1BmQ=;
        b=HszrGB/zXzYVlcbj1g+v3iiywJ5TiSgFYgQu06aLGshR4iS2H/LL5asl8Wj7JXLcm0
         5qoM2QDg4x7xCbn/XI2P9DiHoeOLq/OfvvqTcV2xl/OKP1DDBN26/mzIKVbnooS3KwZ3
         xJxgADqKmBdKWOt6nsp0uPzsHYrJ2nlQH9+3eGcHrsOT61KKuyfkjUNug/5P+9dXdb0t
         HsIFLuekwIfCkyybEsflouX+TSqvIf3lY6bA7/2a18D9dIJzhvGE9+8JeAEiTk9Rg7nB
         LYUKmUZ6JEBn00VtVsUi4ZH0eBTidhLDNfno7L7P0Y/gm2dzb1yDtpGBB33KdQ64KkBL
         COIw==
X-Gm-Message-State: AGi0PuYCXqrBhfq0viep5lqx6abaRUI9223ob1lywQhwA1d/ZoGhige+
        8CoHplVH2WeTWkh15su6NQu9VA==
X-Google-Smtp-Source: APiQypIdtj2KYcguXQNm0EPcrf2pz3olhrBm+/IeNRDbuyKyz/i0U7xHtL6M/yRpgJjiHwpmsEBtfg==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr13163854edq.93.1586037663689;
        Sat, 04 Apr 2020 15:01:03 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:e120:c0df:e1ea:ba3e])
        by smtp.gmail.com with ESMTPSA id oe24sm1718549ejb.47.2020.04.04.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 15:01:03 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/5] md: add new workqueue for delete rdev
Date:   Sat,  4 Apr 2020 23:57:08 +0200
Message-Id: <20200404215711.4272-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Since the purpose of call flush_workqueue in new_dev_store is to ensure
md_delayed_delete() has completed, so we should check rdev->del_work is
pending or not.

To suppress lockdep warning, we have to check mddev->del_work while
md_delayed_delete is attached to rdev->del_work, so it is not aligned
to the purpose of flush workquee. So a new workqueue is needed to avoid
the awkward situation, and introduce a new func flush_rdev_wq to flush
the new workqueue after check if there was pending work.

Also like new_dev_store, ADD_NEW_DISK ioctl has the same purpose to flush
workqueue while it holds bdev->bd_mutex, so make the same change applies
to the ioctl to avoid similar lock issue.

And md_delayed_delete actually wants to delete rdev, so rename the function
to rdev_delayed_delete.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2c23046fca57..2202074ea98f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -87,6 +87,7 @@ static struct module *md_cluster_mod;
 static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
 static struct workqueue_struct *md_wq;
 static struct workqueue_struct *md_misc_wq;
+static struct workqueue_struct *md_rdev_misc_wq;
 
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
@@ -2452,7 +2453,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	return err;
 }
 
-static void md_delayed_delete(struct work_struct *ws)
+static void rdev_delayed_delete(struct work_struct *ws)
 {
 	struct md_rdev *rdev = container_of(ws, struct md_rdev, del_work);
 	kobject_del(&rdev->kobj);
@@ -2477,9 +2478,9 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	 * to delay it due to rcu usage.
 	 */
 	synchronize_rcu();
-	INIT_WORK(&rdev->del_work, md_delayed_delete);
+	INIT_WORK(&rdev->del_work, rdev_delayed_delete);
 	kobject_get(&rdev->kobj);
-	queue_work(md_misc_wq, &rdev->del_work);
+	queue_work(md_rdev_misc_wq, &rdev->del_work);
 }
 
 /*
@@ -4512,6 +4513,20 @@ null_show(struct mddev *mddev, char *page)
 	return -EINVAL;
 }
 
+/* need to ensure rdev_delayed_delete() has completed */
+static void flush_rdev_wq(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rcu_read_lock();
+	rdev_for_each_rcu(rdev, mddev)
+		if (work_pending(&rdev->del_work)) {
+			flush_workqueue(md_rdev_misc_wq);
+			break;
+		}
+	rcu_read_unlock();
+}
+
 static ssize_t
 new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 {
@@ -4539,8 +4554,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	    minor != MINOR(dev))
 		return -EOVERFLOW;
 
-	flush_workqueue(md_misc_wq);
-
+	flush_rdev_wq(mddev);
 	err = mddev_lock(mddev);
 	if (err)
 		return err;
@@ -4778,7 +4792,8 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
 		    mddev_lock(mddev) == 0) {
-			flush_workqueue(md_misc_wq);
+			if (work_pending(&mddev->del_work))
+				flush_workqueue(md_misc_wq);
 			if (mddev->sync_thread) {
 				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 				md_reap_sync_thread(mddev);
@@ -7497,8 +7512,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	}
 
 	if (cmd == ADD_NEW_DISK)
-		/* need to ensure md_delayed_delete() has completed */
-		flush_workqueue(md_misc_wq);
+		flush_rdev_wq(mddev);
 
 	if (cmd == HOT_REMOVE_DISK)
 		/* need to ensure recovery thread has run */
@@ -9470,6 +9484,10 @@ static int __init md_init(void)
 	if (!md_misc_wq)
 		goto err_misc_wq;
 
+	md_rdev_misc_wq = alloc_workqueue("md_rdev_misc", 0, 0);
+	if (!md_misc_wq)
+		goto err_rdev_misc_wq;
+
 	if ((ret = register_blkdev(MD_MAJOR, "md")) < 0)
 		goto err_md;
 
@@ -9491,6 +9509,8 @@ static int __init md_init(void)
 err_mdp:
 	unregister_blkdev(MD_MAJOR, "md");
 err_md:
+	destroy_workqueue(md_rdev_misc_wq);
+err_rdev_misc_wq:
 	destroy_workqueue(md_misc_wq);
 err_misc_wq:
 	destroy_workqueue(md_wq);
@@ -9777,6 +9797,7 @@ static __exit void md_exit(void)
 		 * destroy_workqueue() below will wait for that to complete.
 		 */
 	}
+	destroy_workqueue(md_rdev_misc_wq);
 	destroy_workqueue(md_misc_wq);
 	destroy_workqueue(md_wq);
 }
-- 
2.17.1

