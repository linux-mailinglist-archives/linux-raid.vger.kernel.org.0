Return-Path: <linux-raid+bounces-4998-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0DB357E1
	for <lists+linux-raid@lfdr.de>; Tue, 26 Aug 2025 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210EC1B65FAC
	for <lists+linux-raid@lfdr.de>; Tue, 26 Aug 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36614303C91;
	Tue, 26 Aug 2025 09:00:47 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AB3009E5;
	Tue, 26 Aug 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198846; cv=none; b=ltGlGQb+AI5yxVE7UMvxqVBShRhgJMR9Jd8Dul+E/6t6DUDHxFRAaZh5gyJ0e3r4eiEbdBeOJTgAc5Jf2eB61mQWQgop6ws7gU0ukxFg3rKH/cHWWP3chFKAvAAuURr8S+qth4uRBLTjIh0ktDfGFYQTCmqzR1Dd25Gj3oIzbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198846; c=relaxed/simple;
	bh=zKkxTiTvjfz4SNEWg1YdxRreefbnu1jpQsfD/fKdC9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcFiHl/ewMozY9J2efwrhw3l8DwBT/mqzm6Qs7FUZgNwnUj73l4KIIfSN11/iIXVg75wdvr++ACX/dLFAtAhJWUvDKcnlsmbq3S6qYF55SVpAMsvIjJHATcKLdWXRo/GLBoChU+jCUlfjvPxuGw07RtjitCdHUhhFsUJGuXjrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cB1pg52G8zYQvDL;
	Tue, 26 Aug 2025 17:00:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F6B71A1893;
	Tue, 26 Aug 2025 17:00:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIyyd61oPOlgAQ--.7793S11;
	Tue, 26 Aug 2025 17:00:41 +0800 (CST)
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
Subject: [PATCH v6 md-6.18 07/11] md/md-bitmap: add a new method skip_sync_blocks() in bitmap_operations
Date: Tue, 26 Aug 2025 16:52:01 +0800
Message-Id: <20250826085205.1061353-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIyyd61oPOlgAQ--.7793S11
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxtF15Xr1DZw4kJw1kKrg_yoW8Cw43pa
	97JFy3Cry5Xr45Z3W7XFyDuFyFv34ktFy7tFWxu34rWr97JrnxGF4Yga40qa4DCF13AFsx
	Z3W5ArWrZF1Iqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This method is used to check if blocks can be skipped before calling
into pers->sync_request(), llbitmap will use this method to skip
resync for unwritten/clean data blocks, and recovery/check/repair for
unwritten data blocks;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Xiao Ni <xni@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md-bitmap.h | 1 +
 drivers/md/md.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 8616ced49077..95453696c68e 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -89,6 +89,7 @@ struct bitmap_operations {
 	md_bitmap_fn *start_discard;
 	md_bitmap_fn *end_discard;
 
+	sector_t (*skip_sync_blocks)(struct mddev *mddev, sector_t offset);
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6560bd89d0a2..7196e7f6b2a4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9460,6 +9460,12 @@ void md_do_sync(struct md_thread *thread)
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
 			break;
 
+		if (mddev->bitmap_ops && mddev->bitmap_ops->skip_sync_blocks) {
+			sectors = mddev->bitmap_ops->skip_sync_blocks(mddev, j);
+			if (sectors)
+				goto update;
+		}
+
 		sectors = mddev->pers->sync_request(mddev, j, max_sectors,
 						    &skipped);
 		if (sectors == 0) {
@@ -9475,6 +9481,7 @@ void md_do_sync(struct md_thread *thread)
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
 			break;
 
+update:
 		j += sectors;
 		if (j > max_sectors)
 			/* when skipping, extra large numbers can be returned. */
-- 
2.39.2


