Return-Path: <linux-raid+bounces-5049-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E01B3B5BC
	for <lists+linux-raid@lfdr.de>; Fri, 29 Aug 2025 10:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C66F56514E
	for <lists+linux-raid@lfdr.de>; Fri, 29 Aug 2025 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D82D8DC4;
	Fri, 29 Aug 2025 08:13:27 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD52C3272;
	Fri, 29 Aug 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455206; cv=none; b=T/G5M8w4aeEgrtFd8jNv3HVKPhp/P01/SdNuG/7btQVkcGb0hn8vg/g/Q12Qhc+8rd9slYMPXaptJZZoayTQ4nWTnmqgXePuJWkYOD1SgWmPZxi4115yn8g1unVuXL3ea6soGi5LoSQs4oCaYpO+TOjqUmNmrzLdGgbFXpmOGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455206; c=relaxed/simple;
	bh=Fw9O4rb+oqsolIGn5yCfjkcLO2+Wkqxnh+0O3jhUmi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EN2WpX0w+l3L942qEfxHKM5ywSUuPosASfbIqGqKHh26NAATslKwi/BAzDNcf6yhbmLTui61B0brvwGZGciCuWQUnMXHYVAs0GFNhuQ6yH0gb0lgaRsjYNTHhepp/ljxCTVjUV0Y+5rVAK1JycYdCcZywneK11cVpz9TJ+1U9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCrcX4wCQzKHNHt;
	Fri, 29 Aug 2025 16:13:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 623C11A1679;
	Fri, 29 Aug 2025 16:13:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0RYbFohAO2Ag--.45648S12;
	Fri, 29 Aug 2025 16:13:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	xni@redhat.com,
	colyli@kernel.org,
	linan122@huawei.com,
	corbet@lwn.net,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com,
	hare@suse.de
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com,
	hailan@yukuai.org.cn
Subject: [PATCH v7 md-6.18 08/11] md/md-bitmap: add a new method blocks_synced() in bitmap_operations
Date: Fri, 29 Aug 2025 16:04:23 +0800
Message-Id: <20250829080426.1441678-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250829080426.1441678-1-yukuai1@huaweicloud.com>
References: <20250829080426.1441678-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0RYbFohAO2Ag--.45648S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48ZFWxJr1kWr15AFW7XFb_yoW5uFWfp3
	9rXasxG3yYgrZ3XFy7Z3yDuFyFv34DXryUtFyfuw1ruF9Ygwn8WF4Sga4jyFy5Ga4rZFy3
	Zwn8trW5Cr10qrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, raid456 must perform a whole array initial recovery to build
initail xor data, then IO to the array won't have to read all the blocks
in underlying disks.

This behavior will affect IO performance a lot, and nowadays there are
huge disks and the initial recovery can take a long time. Hence llbitmap
will support lazy initial recovery in following patches. This method is
used to check if data blocks is synced or not, if not then IO will still
have to read all blocks for raid456.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.h |  1 +
 drivers/md/raid5.c     | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 95453696c68e..5f41724cbcd8 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -90,6 +90,7 @@ struct bitmap_operations {
 	md_bitmap_fn *end_discard;
 
 	sector_t (*skip_sync_blocks)(struct mddev *mddev, sector_t offset);
+	bool (*blocks_synced)(struct mddev *mddev, sector_t offset);
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5285e72341a2..672ab226e43c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4097,7 +4097,8 @@ static int handle_stripe_dirtying(struct r5conf *conf,
 				  int disks)
 {
 	int rmw = 0, rcw = 0, i;
-	sector_t resync_offset = conf->mddev->resync_offset;
+	struct mddev *mddev = conf->mddev;
+	sector_t resync_offset = mddev->resync_offset;
 
 	/* Check whether resync is now happening or should start.
 	 * If yes, then the array is dirty (after unclean shutdown or
@@ -4116,6 +4117,12 @@ static int handle_stripe_dirtying(struct r5conf *conf,
 		pr_debug("force RCW rmw_level=%u, resync_offset=%llu sh->sector=%llu\n",
 			 conf->rmw_level, (unsigned long long)resync_offset,
 			 (unsigned long long)sh->sector);
+	} else if (mddev->bitmap_ops && mddev->bitmap_ops->blocks_synced &&
+		   !mddev->bitmap_ops->blocks_synced(mddev, sh->sector)) {
+		/* The initial recover is not done, must read everything */
+		rcw = 1; rmw = 2;
+		pr_debug("force RCW by lazy recovery, sh->sector=%llu\n",
+			 sh->sector);
 	} else for (i = disks; i--; ) {
 		/* would I have to read this buffer for read_modify_write */
 		struct r5dev *dev = &sh->dev[i];
@@ -4148,7 +4155,7 @@ static int handle_stripe_dirtying(struct r5conf *conf,
 	set_bit(STRIPE_HANDLE, &sh->state);
 	if ((rmw < rcw || (rmw == rcw && conf->rmw_level == PARITY_PREFER_RMW)) && rmw > 0) {
 		/* prefer read-modify-write, but need to get some data */
-		mddev_add_trace_msg(conf->mddev, "raid5 rmw %llu %d",
+		mddev_add_trace_msg(mddev, "raid5 rmw %llu %d",
 				sh->sector, rmw);
 
 		for (i = disks; i--; ) {
@@ -4227,8 +4234,8 @@ static int handle_stripe_dirtying(struct r5conf *conf,
 					set_bit(STRIPE_DELAYED, &sh->state);
 			}
 		}
-		if (rcw && !mddev_is_dm(conf->mddev))
-			blk_add_trace_msg(conf->mddev->gendisk->queue,
+		if (rcw && !mddev_is_dm(mddev))
+			blk_add_trace_msg(mddev->gendisk->queue,
 				"raid5 rcw %llu %d %d %d",
 				(unsigned long long)sh->sector, rcw, qread,
 				test_bit(STRIPE_DELAYED, &sh->state));
-- 
2.39.2


