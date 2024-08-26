Return-Path: <linux-raid+bounces-2585-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61295EAEA
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 09:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EBD1F22D34
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375F149C64;
	Mon, 26 Aug 2024 07:49:59 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7F14535E;
	Mon, 26 Aug 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658599; cv=none; b=QUMu4S5/lZFKdfuDzWdZmUZGCJzSegKXkjQk/MpOiX4/jj4ficgr7sQOdADx3fcC8URb6BblOjiTMcPRwZKzxtPAVljHGmYqbKrgvGGXWwgRXBBhAdubKklFQ7vEkPTPXjalgRyF66Aod6BblHFnbC8DMzDmSO6RmObf5XIX320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658599; c=relaxed/simple;
	bh=tUV/dtXheZxn9/GsB7uzet0G0i5PWfCz+PQGL6826kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rm9sBgkYj6JiuLt0g1CoIhLVKxf00+R5Wjm3k3xBMLtAAzpIHOB9u9sgPvfZkXA/LoOSDw9OW7Uzrv7i3RTXmJNX80x1rOJbpJKrIJPp4mdDp4vQY+y4HBdljSyJkvstVl5DLIN31gFhtaOsxva2CWjoUoZLXk37CFN5t3DOGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WsjW81qL1z4f3jMP;
	Mon, 26 Aug 2024 15:49:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B23CD1A19F3;
	Mon, 26 Aug 2024 15:49:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WaM8xmWWIECw--.13849S19;
	Mon, 26 Aug 2024 15:49:54 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mariusz.tkaczyk@linux.intel.com,
	xni@redhat.com,
	song@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.12 v2 15/42] md/md-bitmap: merge md_bitmap_destroy() into bitmap_operations
Date: Mon, 26 Aug 2024 15:44:25 +0800
Message-Id: <20240826074452.1490072-16-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826074452.1490072-1-yukuai1@huaweicloud.com>
References: <20240826074452.1490072-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4WaM8xmWWIECw--.13849S19
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5ArW5tw4DGw13KryUKFg_yoWrArW5pa
	yxt3Z8Kr15trW3Wr4UAFWq9a4FvF1ktr9xKryxWw1rCFn3JrnxWF4rWFyUtw1fWa45AFs0
	qw45tr1rXr17WFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r
	43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPC7UUU
	UUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that the implementation won't be exposed, and it'll be possible
to invent a new bitmap by replacing bitmap_operations.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  7 ++++---
 drivers/md/md-bitmap.h |  2 +-
 drivers/md/md.c        | 15 ++++++++-------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index c236754df66e..dc898db266d0 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1853,7 +1853,7 @@ void md_bitmap_wait_behind_writes(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(md_bitmap_wait_behind_writes);
 
-void md_bitmap_destroy(struct mddev *mddev)
+static void bitmap_destroy(struct mddev *mddev)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
@@ -2384,7 +2384,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			goto out;
 		}
 
-		md_bitmap_destroy(mddev);
+		bitmap_destroy(mddev);
 		mddev->bitmap_info.offset = 0;
 		if (mddev->bitmap_info.file) {
 			struct file *f = mddev->bitmap_info.file;
@@ -2427,7 +2427,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			rv = bitmap_load(mddev);
 			if (rv) {
 				mddev->bitmap_info.offset = 0;
-				md_bitmap_destroy(mddev);
+				bitmap_destroy(mddev);
 				goto out;
 			}
 		}
@@ -2724,6 +2724,7 @@ const struct attribute_group md_bitmap_group = {
 static struct bitmap_operations bitmap_ops = {
 	.create			= bitmap_create,
 	.load			= bitmap_load,
+	.destroy		= bitmap_destroy,
 };
 
 void mddev_set_bitmap_ops(struct mddev *mddev)
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index f5b04b61d9e9..c8d27b91241b 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -249,6 +249,7 @@ struct md_bitmap_stats {
 struct bitmap_operations {
 	int (*create)(struct mddev *mddev, int slot);
 	int (*load)(struct mddev *mddev);
+	void (*destroy)(struct mddev *mddev);
 };
 
 /* the bitmap API */
@@ -256,7 +257,6 @@ void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are used only by md/bitmap */
 void md_bitmap_flush(struct mddev *mddev);
-void md_bitmap_destroy(struct mddev *mddev);
 
 void md_bitmap_print_sb(struct bitmap *bitmap);
 void md_bitmap_update_sb(struct bitmap *bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ff59826aa192..15e830641c0c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6297,7 +6297,7 @@ int md_run(struct mddev *mddev)
 		pers->free(mddev, mddev->private);
 	mddev->private = NULL;
 	module_put(pers->owner);
-	md_bitmap_destroy(mddev);
+	mddev->bitmap_ops->destroy(mddev);
 abort:
 	bioset_exit(&mddev->io_clone_set);
 exit_sync_set:
@@ -6319,7 +6319,7 @@ int do_md_run(struct mddev *mddev)
 
 	err = mddev->bitmap_ops->load(mddev);
 	if (err) {
-		md_bitmap_destroy(mddev);
+		mddev->bitmap_ops->destroy(mddev);
 		goto out;
 	}
 
@@ -6505,7 +6505,8 @@ static void mddev_detach(struct mddev *mddev)
 static void __md_stop(struct mddev *mddev)
 {
 	struct md_personality *pers = mddev->pers;
-	md_bitmap_destroy(mddev);
+
+	mddev->bitmap_ops->destroy(mddev);
 	mddev_detach(mddev);
 	spin_lock(&mddev->lock);
 	mddev->pers = NULL;
@@ -7288,11 +7289,11 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 				err = mddev->bitmap_ops->load(mddev);
 
 			if (err) {
-				md_bitmap_destroy(mddev);
+				mddev->bitmap_ops->destroy(mddev);
 				fd = -1;
 			}
 		} else if (fd < 0) {
-			md_bitmap_destroy(mddev);
+			mddev->bitmap_ops->destroy(mddev);
 		}
 	}
 
@@ -7582,7 +7583,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				rv = mddev->bitmap_ops->load(mddev);
 
 			if (rv)
-				md_bitmap_destroy(mddev);
+				mddev->bitmap_ops->destroy(mddev);
 		} else {
 			struct md_bitmap_stats stats;
 
@@ -7609,7 +7610,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				module_put(md_cluster_mod);
 				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 			}
-			md_bitmap_destroy(mddev);
+			mddev->bitmap_ops->destroy(mddev);
 			mddev->bitmap_info.offset = 0;
 		}
 	}
-- 
2.39.2


