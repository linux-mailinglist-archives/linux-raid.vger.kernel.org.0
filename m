Return-Path: <linux-raid+bounces-4994-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715F1B357CD
	for <lists+linux-raid@lfdr.de>; Tue, 26 Aug 2025 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921101B658AF
	for <lists+linux-raid@lfdr.de>; Tue, 26 Aug 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F202FFDF4;
	Tue, 26 Aug 2025 09:00:43 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7F299AAB;
	Tue, 26 Aug 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198843; cv=none; b=ug7o9397RMN2m8bM1nPUVNcaWhjySDPgS8DibPIA2Zkhd5cnsPwDL2FFOC07GW/qDVr3cgjGko6M9ZPfpEZNnwew5umYI0LX9GPnJpCjmN1fXaBo6rg8eNgKYdMT050v9HEZKZINCuDWfP5/m2PlvqiQRjqPo08jC7hTPbTR68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198843; c=relaxed/simple;
	bh=RGBZynnur4cyQENYoo2wIGzEb5x7LlBsw6RCRwlfddk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMaYMqgFQV4DzUW2nLfrPAQo5rIHhGvhD/RwkP9n6V1KOGWu6gPgfGSoX2uTM28uRZz/KwLosDpr62jjjowfBQtErTBXK+pE1z650HTg1bT26DSdxDz0Eqf7O+W5UvDtwHwbyH1eULQIxTb2rnd1QuiLg3XbUlmg02ymmZ+SCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cB1pb10G0zKHMdG;
	Tue, 26 Aug 2025 17:00:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B745F1A0F16;
	Tue, 26 Aug 2025 17:00:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIyyd61oPOlgAQ--.7793S6;
	Tue, 26 Aug 2025 17:00:38 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	corbet@lwn.net,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	xni@redhat.com,
	hare@suse.de,
	linan122@huawei.com,
	colyli@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v6 md-6.18 02/11] md: factor out a helper raid_is_456()
Date: Tue, 26 Aug 2025 16:51:56 +0800
Message-Id: <20250826085205.1061353-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250826085205.1061353-1-yukuai1@huaweicloud.com>
References: <20250826085205.1061353-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIyyd61oPOlgAQ--.7793S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr4fZw1xCF4UJwb_yoW8Ar4fpa
	1fXFy3ZryUXFW3tw1DX3WkZa4Fgw1ftryqyrWxZ395XF1UJr1DKF1SqFZ2qryDWayrAFsI
	qa1jyr48C3W0gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRREfO5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, the helper will be used by llbitmap in
following patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 9 +--------
 drivers/md/md.h | 6 ++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 74f876497c09..86cf97c0a77b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9121,19 +9121,12 @@ static sector_t md_sync_position(struct mddev *mddev, enum sync_action action)
 
 static bool sync_io_within_limit(struct mddev *mddev)
 {
-	int io_sectors;
-
 	/*
 	 * For raid456, sync IO is stripe(4k) per IO, for other levels, it's
 	 * RESYNC_PAGES(64k) per IO.
 	 */
-	if (mddev->level == 4 || mddev->level == 5 || mddev->level == 6)
-		io_sectors = 8;
-	else
-		io_sectors = 128;
-
 	return atomic_read(&mddev->recovery_active) <
-		io_sectors * sync_io_depth(mddev);
+	       (raid_is_456(mddev) ? 8 : 128) * sync_io_depth(mddev);
 }
 
 #define SYNC_MARKS	10
diff --git a/drivers/md/md.h b/drivers/md/md.h
index cadd9bc99938..5ef73109d14d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -1033,6 +1033,12 @@ static inline bool mddev_is_dm(struct mddev *mddev)
 	return !mddev->gendisk;
 }
 
+static inline bool raid_is_456(struct mddev *mddev)
+{
+	return mddev->level == ID_RAID4 || mddev->level == ID_RAID5 ||
+	       mddev->level == ID_RAID6;
+}
+
 static inline void mddev_trace_remap(struct mddev *mddev, struct bio *bio,
 		sector_t sector)
 {
-- 
2.39.2


