Return-Path: <linux-raid+bounces-2542-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290AF95AB7D
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE01C25563
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2024 02:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8B1865F4;
	Thu, 22 Aug 2024 02:52:21 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7E18133F;
	Thu, 22 Aug 2024 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295141; cv=none; b=t5XCgcmPeMbA/eG7lT571zGSkZJocxQob0Yj2XhT6hJyUoeSoZJPJzjScsBwwmzz2Ic6YsxRaCDdF/XujmuxBuFo+hQE+mL22gtsFdl1KPo+Yp2A5KXjgw5Cr7zSa/6oqfHr63ah9DI4xE7ykGH2Qgf4zq3kY2JQKY5TT0fP+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295141; c=relaxed/simple;
	bh=vMaJC3oZkt3b8ykWGspDKGV+EpYaAhVC4SUHkwwrW2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrNZopHVLntAgZVzH8lV0sNTnU9u5ZcYtOKl+qZppSJJHUDAMbCCm075qu8ZV0Dg6Nxl2N0uIY+GHBk1z4bHibhpKCldT/p55xNW9OTxj6KpTKGxNpZVnhunKsezL+Fc/glPp7LHYR3IJW+C1czBydCXz5kB7NCpFxvcl1aYOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq75c5tbpz4f3kp6;
	Thu, 22 Aug 2024 10:52:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E8FB1A07BA;
	Thu, 22 Aug 2024 10:52:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTNp8ZmyXl2CQ--.42363S36;
	Thu, 22 Aug 2024 10:52:14 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	mariusz.tkaczyk@linux.intel.com,
	l@damenly.org,
	xni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.12 32/41] md/md-bitmap: merge md_bitmap_daemon_work() into bitmap_operations
Date: Thu, 22 Aug 2024 10:47:09 +0800
Message-Id: <20240822024718.2158259-33-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822024718.2158259-1-yukuai1@huaweicloud.com>
References: <20240822024718.2158259-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoTNp8ZmyXl2CQ--.42363S36
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1xAFy8Jr1Utw1DAr18Krg_yoW5ArWkpF
	W5t3W5Cr45tFWYq3WUAFWDCFyFqrn7trZrKryxC34rWFyrJFnxWFWruFyDtwn5WFy3JFnx
	Zw45try8Ca40qrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VU1zpBDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that the implementation won't be exposed, and it'll be possible
to invent a new bitmap by replacing bitmap_operations.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 9 +++++----
 drivers/md/md-bitmap.h | 2 +-
 drivers/md/md.c        | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 5838366f47aa..51c43dced1e8 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1298,7 +1298,7 @@ static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
  * bitmap daemon -- periodically wakes up to clean bits and flush pages
  *			out to disk
  */
-void md_bitmap_daemon_work(struct mddev *mddev)
+static void bitmap_daemon_work(struct mddev *mddev)
 {
 	struct bitmap *bitmap;
 	unsigned long j;
@@ -1815,11 +1815,11 @@ static void bitmap_flush(struct mddev *mddev)
 	 */
 	sleep = mddev->bitmap_info.daemon_sleep * 2;
 	bitmap->daemon_lastrun -= sleep;
-	md_bitmap_daemon_work(mddev);
+	bitmap_daemon_work(mddev);
 	bitmap->daemon_lastrun -= sleep;
-	md_bitmap_daemon_work(mddev);
+	bitmap_daemon_work(mddev);
 	bitmap->daemon_lastrun -= sleep;
-	md_bitmap_daemon_work(mddev);
+	bitmap_daemon_work(mddev);
 	if (mddev->bitmap_info.external)
 		md_super_wait(mddev);
 	bitmap_update_sb(bitmap);
@@ -2754,6 +2754,7 @@ static struct bitmap_operations bitmap_ops = {
 	.write_all		= bitmap_write_all,
 	.dirty_bits		= bitmap_dirty_bits,
 	.unplug			= bitmap_unplug,
+	.daemon_work		= bitmap_daemon_work,
 
 	.startwrite		= bitmap_startwrite,
 	.endwrite		= bitmap_endwrite,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index dbe9b27091f4..065b36c0c43a 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -255,6 +255,7 @@ struct bitmap_operations {
 	void (*dirty_bits)(struct mddev *mddev, unsigned long s,
 			   unsigned long e);
 	void (*unplug)(struct mddev *mddev, bool sync);
+	void (*daemon_work)(struct mddev *mddev);
 
 	int (*startwrite)(struct mddev *mddev, sector_t offset,
 			  unsigned long sectors, bool behind);
@@ -278,7 +279,6 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are exported */
-void md_bitmap_daemon_work(struct mddev *mddev);
 
 int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		     int chunksize, int init);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6f68f8da0848..4046df5dc33e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9639,7 +9639,7 @@ static void unregister_sync_thread(struct mddev *mddev)
 void md_check_recovery(struct mddev *mddev)
 {
 	if (mddev->bitmap)
-		md_bitmap_daemon_work(mddev);
+		mddev->bitmap_ops->daemon_work(mddev);
 
 	if (signal_pending(current)) {
 		if (mddev->pers->sync_request && !mddev->external) {
-- 
2.39.2


