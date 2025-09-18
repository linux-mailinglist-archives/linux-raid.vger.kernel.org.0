Return-Path: <linux-raid+bounces-4781-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF9B17D2A
	for <lists+linux-raid@lfdr.de>; Fri,  1 Aug 2025 09:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BD5175E3C
	for <lists+linux-raid@lfdr.de>; Fri,  1 Aug 2025 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BB420298E;
	Fri,  1 Aug 2025 07:10:53 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A51FAC42;
	Fri,  1 Aug 2025 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032252; cv=none; b=dX/MML9AQHQ5GgwkJvevTwyu5Pm0XhDPDqCdoC5srDazZi+noL9yGbrrey8v25AQv7JD7+pLbtWYDqPNH8DO8Wa6F0loNedzrMxxhCYE2jE+qCo1mAzW1xxYSAzZ3yxVO7BKYWVDnxmE7dlA4E7o6RNKklmv2G4GOpdQqbhzfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032252; c=relaxed/simple;
	bh=Vs5AQUXVi/visiZ5I7hdPf8y73lG1DPoEtKBvkTdNhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZztvMpJf3ywkGYqk4ZgpzG2EMXjJdmEpzNpNZW2AnsY4nDDHth2BMDBG24gl6gUOkx6ERihvOQf7GWFeA2TrP05CHOiWpoL4fGln0gAO/UTug4mrQCOFzm2vw8Tq9XIq2FHsB2zkLB+CKl/T0qWQYixHow+qzDlDu76dJzKykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4btcYP4XkhzKHMqP;
	Fri,  1 Aug 2025 15:10:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8B68D1A11D4;
	Fri,  1 Aug 2025 15:10:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxByaIxoqAzACA--.18978S7;
	Fri, 01 Aug 2025 15:10:48 +0800 (CST)
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
Subject: [PATCH v5 03/11] md/md-bitmap: support discard for bitmap ops
Date: Fri,  1 Aug 2025 15:03:38 +0800
Message-Id: <20250801070346.4127558-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHjxByaIxoqAzACA--.18978S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3uFW8KFW5trWDGF13CFg_yoWrWw48pF
	ZFqFy3GrW5XF4Yga47Aa4q9Fyrt34ktrZrtFW7W345WFyIkF9xCF4Fga4qvw1DGFy3uFsx
	Za1Fkry5Cw18XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRiuWl3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Use two new methods {start, end}_discard in bitmap_ops and a new field 'rw'
in struct md_io_clone to handle discard IO, prepare to support new md
bitmap.

Since all bitmap functions to hanlde write IO are the same, also add
typedef to make code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md-bitmap.c |  3 +++
 drivers/md/md-bitmap.h | 12 ++++++++----
 drivers/md/md.c        | 15 +++++++++++----
 drivers/md/md.h        |  1 +
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b157119de123..dc050ff94d5b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -3005,6 +3005,9 @@ static struct bitmap_operations bitmap_ops = {
 
 	.start_write		= bitmap_start_write,
 	.end_write		= bitmap_end_write,
+	.start_discard		= bitmap_start_write,
+	.end_discard		= bitmap_end_write,
+
 	.start_sync		= bitmap_start_sync,
 	.end_sync		= bitmap_end_sync,
 	.cond_end_sync		= bitmap_cond_end_sync,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 42f91755a341..8616ced49077 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -61,6 +61,9 @@ struct md_bitmap_stats {
 	struct file	*file;
 };
 
+typedef void (md_bitmap_fn)(struct mddev *mddev, sector_t offset,
+			    unsigned long sectors);
+
 struct bitmap_operations {
 	struct md_submodule_head head;
 
@@ -81,10 +84,11 @@ struct bitmap_operations {
 	void (*end_behind_write)(struct mddev *mddev);
 	void (*wait_behind_writes)(struct mddev *mddev);
 
-	void (*start_write)(struct mddev *mddev, sector_t offset,
-			    unsigned long sectors);
-	void (*end_write)(struct mddev *mddev, sector_t offset,
-			  unsigned long sectors);
+	md_bitmap_fn *start_write;
+	md_bitmap_fn *end_write;
+	md_bitmap_fn *start_discard;
+	md_bitmap_fn *end_discard;
+
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f1434e5ddb3d..4e90d2143813 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8864,18 +8864,24 @@ EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 static void md_bitmap_start(struct mddev *mddev,
 			    struct md_io_clone *md_io_clone)
 {
+	md_bitmap_fn *fn = unlikely(md_io_clone->rw == STAT_DISCARD) ?
+			   mddev->bitmap_ops->start_discard :
+			   mddev->bitmap_ops->start_write;
+
 	if (mddev->pers->bitmap_sector)
 		mddev->pers->bitmap_sector(mddev, &md_io_clone->offset,
 					   &md_io_clone->sectors);
 
-	mddev->bitmap_ops->start_write(mddev, md_io_clone->offset,
-				       md_io_clone->sectors);
+	fn(mddev, md_io_clone->offset, md_io_clone->sectors);
 }
 
 static void md_bitmap_end(struct mddev *mddev, struct md_io_clone *md_io_clone)
 {
-	mddev->bitmap_ops->end_write(mddev, md_io_clone->offset,
-				     md_io_clone->sectors);
+	md_bitmap_fn *fn = unlikely(md_io_clone->rw == STAT_DISCARD) ?
+			   mddev->bitmap_ops->end_discard :
+			   mddev->bitmap_ops->end_write;
+
+	fn(mddev, md_io_clone->offset, md_io_clone->sectors);
 }
 
 static void md_end_clone_io(struct bio *bio)
@@ -8914,6 +8920,7 @@ static void md_clone_bio(struct mddev *mddev, struct bio **bio)
 	if (bio_data_dir(*bio) == WRITE && md_bitmap_enabled(mddev, false)) {
 		md_io_clone->offset = (*bio)->bi_iter.bi_sector;
 		md_io_clone->sectors = bio_sectors(*bio);
+		md_io_clone->rw = op_stat_group(bio_op(*bio));
 		md_bitmap_start(mddev, md_io_clone);
 	}
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 5ef73109d14d..1b767b5320cf 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -872,6 +872,7 @@ struct md_io_clone {
 	unsigned long	start_time;
 	sector_t	offset;
 	unsigned long	sectors;
+	enum stat_group	rw;
 	struct bio	bio_clone;
 };
 
-- 
2.39.2


