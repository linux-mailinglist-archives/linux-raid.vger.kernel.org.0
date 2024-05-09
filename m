Return-Path: <linux-raid+bounces-1447-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7068C0929
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2024 03:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95A128244A
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2024 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229713D261;
	Thu,  9 May 2024 01:29:13 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC113C9A0;
	Thu,  9 May 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218153; cv=none; b=alJgyrJwG5fDUXbyflq2oif9JSEcibqP/2dvnTZouuUzonpgcSeczCj8o3GRXWRgTsbgRIJKx81PsZaNiQSs058X1eQc8evhBin0NKE2JZ/30SbDzY0rWPSzHKObRef5xicbnxg1qr0kZ0UtF9vSGwgDO0URi7+IZszJheY91BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218153; c=relaxed/simple;
	bh=bAXNs+MafqLh6UEtkbloHDsJqX7fuUMCLpWoqj7mDZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbmbbSFYRsdak3wRnSepBWWqbOTiU8cnaqPuisC3vpopql72IPfJMIAAqZpFHjTeNEunAzzip6X1LAJPvvcbzk50V2OWzZ/CLtHjBsDqqzn17RVVk8rzc9Eu2wyJjFrP75hWoFPO7HnO6atam1/25nG/3UaEVViMovqtzw7Ksd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZZDC6fGqz4f3jcr;
	Thu,  9 May 2024 09:28:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 439BE1A09EC;
	Thu,  9 May 2024 09:29:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDeJjxm5MuXMA--.59814S13;
	Thu, 09 May 2024 09:29:08 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	xni@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.10 9/9] md: pass in max_sectors for pers->sync_request()
Date: Thu,  9 May 2024 09:19:00 +0800
Message-Id: <20240509011900.2694291-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDeJjxm5MuXMA--.59814S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4fJF1kGrW3XrWDZrW5KFg_yoWrKF4kpa
	18tFy3ZrW7XrW5Jwn8AryDua4Fva4ftrWjkryfu3s3WFn3Kr9rAF1rXayUXFyDWa4rJr4Y
	qw1Utr45u3Z2grJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For different sync_action, sync_thread will use different max_sectors,
see details in md_sync_max_sectors(), currently both md_do_sync() and
pers->sync_request() in eatch iteration have to get the same
max_sectors. Hence pass in max_sectors for pers->sync_request() to
prevent redundant code.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c     | 5 +++--
 drivers/md/md.h     | 3 ++-
 drivers/md/raid1.c  | 5 ++---
 drivers/md/raid10.c | 8 ++------
 drivers/md/raid5.c  | 3 +--
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 42db128b82d9..95b0f9642137 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9200,7 +9200,8 @@ void md_do_sync(struct md_thread *thread)
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
 			break;
 
-		sectors = mddev->pers->sync_request(mddev, j, &skipped);
+		sectors = mddev->pers->sync_request(mddev, j, max_sectors,
+						    &skipped);
 		if (sectors == 0) {
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 			break;
@@ -9290,7 +9291,7 @@ void md_do_sync(struct md_thread *thread)
 		mddev->curr_resync_completed = mddev->curr_resync;
 		sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	}
-	mddev->pers->sync_request(mddev, max_sectors, &skipped);
+	mddev->pers->sync_request(mddev, max_sectors, max_sectors, &skipped);
 
 	if (!test_bit(MD_RECOVERY_CHECK, &mddev->recovery) &&
 	    mddev->curr_resync > MD_RESYNC_ACTIVE) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 883b147a2c52..d03e11fff79a 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -731,7 +731,8 @@ struct md_personality
 	int (*hot_add_disk) (struct mddev *mddev, struct md_rdev *rdev);
 	int (*hot_remove_disk) (struct mddev *mddev, struct md_rdev *rdev);
 	int (*spare_active) (struct mddev *mddev);
-	sector_t (*sync_request)(struct mddev *mddev, sector_t sector_nr, int *skipped);
+	sector_t (*sync_request)(struct mddev *mddev, sector_t sector_nr,
+				 sector_t max_sector, int *skipped);
 	int (*resize) (struct mddev *mddev, sector_t sectors);
 	sector_t (*size) (struct mddev *mddev, sector_t sectors, int raid_disks);
 	int (*check_reshape) (struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index be8ac24f50b6..1f6dffada912 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2757,12 +2757,12 @@ static struct r1bio *raid1_alloc_init_r1buf(struct r1conf *conf)
  */
 
 static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
-				   int *skipped)
+				   sector_t max_sector, int *skipped)
 {
 	struct r1conf *conf = mddev->private;
 	struct r1bio *r1_bio;
 	struct bio *bio;
-	sector_t max_sector, nr_sectors;
+	sector_t nr_sectors;
 	int disk = -1;
 	int i;
 	int wonly = -1;
@@ -2778,7 +2778,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (init_resync(conf))
 			return 0;
 
-	max_sector = mddev->dev_sectors;
 	if (sector_nr >= max_sector) {
 		/* If we aborted, we need to abort the
 		 * sync on the 'current' bitmap chunk (there will
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a4556d2e46bf..af54ac30a667 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3140,12 +3140,12 @@ static void raid10_set_cluster_sync_high(struct r10conf *conf)
  */
 
 static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
-			     int *skipped)
+				    sector_t max_sector, int *skipped)
 {
 	struct r10conf *conf = mddev->private;
 	struct r10bio *r10_bio;
 	struct bio *biolist = NULL, *bio;
-	sector_t max_sector, nr_sectors;
+	sector_t nr_sectors;
 	int i;
 	int max_sync;
 	sector_t sync_blocks;
@@ -3175,10 +3175,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			return 0;
 
  skipped:
-	max_sector = mddev->dev_sectors;
-	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
-	    test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
-		max_sector = mddev->resync_max_sectors;
 	if (sector_nr >= max_sector) {
 		conf->cluster_sync_low = 0;
 		conf->cluster_sync_high = 0;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2bd1ce9b3922..69a083ca41a3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6458,11 +6458,10 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 }
 
 static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_nr,
-					  int *skipped)
+					  sector_t max_sector, int *skipped)
 {
 	struct r5conf *conf = mddev->private;
 	struct stripe_head *sh;
-	sector_t max_sector = mddev->dev_sectors;
 	sector_t sync_blocks;
 	int still_degraded = 0;
 	int i;
-- 
2.39.2


