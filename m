Return-Path: <linux-raid+bounces-2601-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00395EB0A
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 09:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5931F241E2
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FC18756A;
	Mon, 26 Aug 2024 07:50:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBED1779AB;
	Mon, 26 Aug 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658606; cv=none; b=ssHAFsZFdSCidmyiPHb3yTwuSl8P7W67W+BnHl3TL/GplZzonEzq05HS+TuX4pItRrIMU635sOxjUx4TCq2eiOF3funxqCQUryfq8iD4BDMolq2MJ0NgyimkLoVjf1pvSCuL/vtWoBYFSYQ3E8YUqk7jM+dPr8jDTXvAc1sbyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658606; c=relaxed/simple;
	bh=2PBFvOnyi8+Qa1JAltAEw/qJKcdvaniXo0xudRKspy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k86RnHWxuCl+eIt8x/8aMlYPSe7RtmN7sclKzg4b7QBg6s1n2CbAAPn9mMVgbfb9t5avUHPKjw9muefIlTK0QAaXJAWxxqrs3O54Ae3LQ63YY85n+1q7GKUwMuGWDf5LmEiQOhbtxap4QrLX1rzOmFkWvULoZYNHjfae+6rZwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WsjWM3frVz4f3jZQ;
	Mon, 26 Aug 2024 15:49:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 612BB1A07B6;
	Mon, 26 Aug 2024 15:50:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WaM8xmWWIECw--.13849S35;
	Mon, 26 Aug 2024 15:50:01 +0800 (CST)
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
Subject: [PATCH md-6.12 v2 31/42] md/md-bitmap: merge md_bitmap_unplug_async() into md_bitmap_unplug()
Date: Mon, 26 Aug 2024 15:44:41 +0800
Message-Id: <20240826074452.1490072-32-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAHL4WaM8xmWWIECw--.13849S35
X-Coremail-Antispam: 1UD129KBjvJXoW3JF4DZF4DZF4DJr1kCryUZFb_yoWxtrykpr
	W5t345Gr45JFW5Xw1UArW2kF1Fq3WvqF9rtryfCwn5uFy3XF9xGF4rGFyUtw1DArnxGFs8
	Zw15tryDGF1rWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPC7UUU
	UUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Add a parameter 'bool sync' to distinguish them, and
md_bitmap_unplug_async() won't be exported anymore, hence
bitmap_operations only need one op to cover them.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 28 ++++++++++++++++++++--------
 drivers/md/md-bitmap.h |  3 +--
 drivers/md/md.c        |  2 +-
 drivers/md/raid1-10.c  |  7 ++-----
 drivers/md/raid1.c     |  2 +-
 drivers/md/raid10.c    |  4 ++--
 drivers/md/raid5.c     |  2 +-
 7 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9fe97f14a719..ecfc3a02a976 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1026,7 +1026,7 @@ static int md_bitmap_file_test_bit(struct bitmap *bitmap, sector_t block)
 /* this gets called when the md device is ready to unplug its underlying
  * (slave) device queues -- before we let any writes go down, we need to
  * sync the dirty pages of the bitmap file to disk */
-void md_bitmap_unplug(struct bitmap *bitmap)
+static void __bitmap_unplug(struct bitmap *bitmap)
 {
 	unsigned long i;
 	int dirty, need_write;
@@ -1058,7 +1058,6 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 	if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags))
 		md_bitmap_file_kick(bitmap);
 }
-EXPORT_SYMBOL(md_bitmap_unplug);
 
 struct bitmap_unplug_work {
 	struct work_struct work;
@@ -1071,11 +1070,11 @@ static void md_bitmap_unplug_fn(struct work_struct *work)
 	struct bitmap_unplug_work *unplug_work =
 		container_of(work, struct bitmap_unplug_work, work);
 
-	md_bitmap_unplug(unplug_work->bitmap);
+	__bitmap_unplug(unplug_work->bitmap);
 	complete(unplug_work->done);
 }
 
-void md_bitmap_unplug_async(struct bitmap *bitmap)
+static void bitmap_unplug_async(struct bitmap *bitmap)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	struct bitmap_unplug_work unplug_work;
@@ -1087,7 +1086,20 @@ void md_bitmap_unplug_async(struct bitmap *bitmap)
 	queue_work(md_bitmap_wq, &unplug_work.work);
 	wait_for_completion(&done);
 }
-EXPORT_SYMBOL(md_bitmap_unplug_async);
+
+void md_bitmap_unplug(struct mddev *mddev, bool sync)
+{
+	struct bitmap *bitmap = mddev->bitmap;
+
+	if (!bitmap)
+		return;
+
+	if (sync)
+		__bitmap_unplug(bitmap);
+	else
+		bitmap_unplug_async(bitmap);
+}
+EXPORT_SYMBOL_GPL(md_bitmap_unplug);
 
 static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, int needed);
 
@@ -2108,9 +2120,9 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
 		for (i = 0; i < bitmap->storage.file_pages; i++)
 			if (test_page_attr(bitmap, i, BITMAP_PAGE_PENDING))
 				set_page_attr(bitmap, i, BITMAP_PAGE_NEEDWRITE);
-		md_bitmap_unplug(bitmap);
+		__bitmap_unplug(bitmap);
 	}
-	md_bitmap_unplug(mddev->bitmap);
+	__bitmap_unplug(mddev->bitmap);
 	*low = lo;
 	*high = hi;
 	md_bitmap_free(bitmap);
@@ -2351,7 +2363,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 	spin_unlock_irq(&bitmap->counts.lock);
 
 	if (!init) {
-		md_bitmap_unplug(bitmap);
+		__bitmap_unplug(bitmap);
 		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
 	}
 	ret = 0;
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 0953ac73735c..ba8ba7e49ef9 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -277,8 +277,7 @@ struct bitmap_operations {
 void mddev_set_bitmap_ops(struct mddev *mddev);
 
 /* these are exported */
-void md_bitmap_unplug(struct bitmap *bitmap);
-void md_bitmap_unplug_async(struct bitmap *bitmap);
+void md_bitmap_unplug(struct mddev *mddev, bool sync);
 void md_bitmap_daemon_work(struct mddev *mddev);
 
 int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6cf0131b9b81..8e3f753ee035 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4715,7 +4715,7 @@ bitmap_store(struct mddev *mddev, const char *buf, size_t len)
 		mddev->bitmap_ops->dirty_bits(mddev, chunk, end_chunk);
 		buf = skip_spaces(end);
 	}
-	md_bitmap_unplug(mddev->bitmap); /* flush the bits to disk */
+	md_bitmap_unplug(mddev, true); /* flush the bits to disk */
 out:
 	mddev_unlock(mddev);
 	return len;
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 2ea1710a3b70..45b30f08f3a5 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -166,12 +166,9 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
  * while current io submission must wait for bitmap io to be done. In order to
  * avoid such deadlock, submit bitmap io asynchronously.
  */
-static inline void raid1_prepare_flush_writes(struct bitmap *bitmap)
+static inline void raid1_prepare_flush_writes(struct mddev *mddev)
 {
-	if (current->bio_list)
-		md_bitmap_unplug_async(bitmap);
-	else
-		md_bitmap_unplug(bitmap);
+	md_bitmap_unplug(mddev, current->bio_list == NULL);
 }
 
 /*
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 00174cacb1f4..fe893bdd2c0a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -896,7 +896,7 @@ static void wake_up_barrier(struct r1conf *conf)
 static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 {
 	/* flush any pending bitmap writes to disk before proceeding w/ I/O */
-	raid1_prepare_flush_writes(conf->mddev->bitmap);
+	raid1_prepare_flush_writes(conf->mddev);
 	wake_up_barrier(conf);
 
 	while (bio) { /* submit pending writes */
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5a7b19f48c45..c79f374668dd 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -885,7 +885,7 @@ static void flush_pending_writes(struct r10conf *conf)
 		__set_current_state(TASK_RUNNING);
 
 		blk_start_plug(&plug);
-		raid1_prepare_flush_writes(conf->mddev->bitmap);
+		raid1_prepare_flush_writes(conf->mddev);
 		wake_up(&conf->wait_barrier);
 
 		while (bio) { /* submit pending writes */
@@ -1101,7 +1101,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
-	raid1_prepare_flush_writes(mddev->bitmap);
+	raid1_prepare_flush_writes(mddev);
 	wake_up_barrier(conf);
 
 	while (bio) { /* submit pending writes */
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 87b8d19ab601..e98061c01b44 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6768,7 +6768,7 @@ static void raid5d(struct md_thread *thread)
 			/* Now is a good time to flush some bitmap updates */
 			conf->seq_flush++;
 			spin_unlock_irq(&conf->device_lock);
-			md_bitmap_unplug(mddev->bitmap);
+			md_bitmap_unplug(mddev, true);
 			spin_lock_irq(&conf->device_lock);
 			conf->seq_write = conf->seq_flush;
 			activate_bit_delay(conf, conf->temp_inactive_list);
-- 
2.39.2


