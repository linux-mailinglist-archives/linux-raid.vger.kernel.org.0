Return-Path: <linux-raid+bounces-4158-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8CAB2CFA
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9743A7F0A
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541811F2C34;
	Mon, 12 May 2025 01:28:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F011EE7C6;
	Mon, 12 May 2025 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013296; cv=none; b=BAEAzJfIsQ94GQiFI7cIiyLZSF/JVSeqKpU01MrU5TjBbsXP44QbYYU49VlR8llz8+Aq86V645hF+rBxzXwz2Gw2b4FuYyKCID4EhIulBVUn270+K3Aezs5V7wkzMh41pa5poYoflVrf1QuUTkx6WdA0lDGMs6Hf7dqAlFIXjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013296; c=relaxed/simple;
	bh=0IvTBzWZKFcrsB6nAPprxdcFl8beEnwLfIdCqrsDtG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFgbEpHVrpF4pTh1Dz/rVb0Ry5kqCDZnOnu4Nkud6O9UdXM1KYk/xSkqouy8KvUepdupDAG9fo9/HUYcWGPENU73+uKUnVrd/U5r21unA8fOizOCPW3xsAFR4IDybsswnNFSbaweuZ079uNqpcmzPH1T/LQSnA/R33AOrQAvMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zwhn36ch1z4f3jtT;
	Mon, 12 May 2025 09:27:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6337C1A0B15;
	Mon, 12 May 2025 09:28:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CdTiFoNFCWMA--.55093S20;
	Mon, 12 May 2025 09:28:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	xni@redhat.com,
	colyli@kernel.org,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC md-6.16 v3 16/19] md/md-llbitmap: implement APIs for sync_thread
Date: Mon, 12 May 2025 09:19:24 +0800
Message-Id: <20250512011927.2809400-17-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2CdTiFoNFCWMA--.55093S20
X-Coremail-Antispam: 1UD129KBjvJXoWxWFykGw45uw4DGw4kJw43Wrg_yoW5ZrW8pF
	47Xw15Gr45X34fX3y3Jr97Aa4Fqr4ktr9FqF93A34rGF1Yyrs8KFWkGFyUXa1jgr1rGF1D
	X3Z8GrW5Cr1rXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Include following APIs:
 - llbitmap_blocks_synced
 - llbitmap_skip_sync_blocks
 - llbitmap_start_sync
 - llbitmap_end_sync
 - llbitmap_close_sync

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-llbitmap.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/md/md-llbitmap.c b/drivers/md/md-llbitmap.c
index 71234c0ae160..3169ae8b72be 100644
--- a/drivers/md/md-llbitmap.c
+++ b/drivers/md/md-llbitmap.c
@@ -1076,3 +1076,86 @@ static void llbitmap_flush(struct mddev *mddev)
 	blk_finish_plug(&plug);
 	md_super_wait(llbitmap->mddev);
 }
+
+/* This is used for raid5 lazy initial recovery */
+static bool llbitmap_blocks_synced(struct mddev *mddev, sector_t offset)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+	enum llbitmap_state c;
+	int ret;
+
+	ret = llbitmap_read(llbitmap, &c, p);
+	if (ret < 0) {
+		set_bit(BITMAP_WRITE_ERROR, &llbitmap->flags);
+		return false;
+	}
+
+	return c == BitClean || c == BitDirty;
+}
+
+static sector_t llbitmap_skip_sync_blocks(struct mddev *mddev, sector_t offset)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+	int blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	enum llbitmap_state c;
+	int ret;
+
+	ret = llbitmap_read(llbitmap, &c, p);
+	if (ret < 0) {
+		set_bit(BITMAP_WRITE_ERROR, &llbitmap->flags);
+		return 0;
+	}
+
+	/* always skip unwritten blocks */
+	if (c == BitUnwritten)
+		return blocks;
+
+	/* For resync also skip clean/dirty blocks */
+	if ((c == BitClean || c == BitDirty) &&
+	    test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
+	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
+		return blocks;
+
+	return 0;
+}
+
+static bool llbitmap_start_sync(struct mddev *mddev, sector_t offset,
+				sector_t *blocks, bool degraded)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+
+	/*
+	 * Handle one bit at a time, this is much simpler. And it doesn't matter
+	 * if md_do_sync() loop more times.
+	 */
+	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	return llbitmap_state_machine(llbitmap, p, p, BitmapActionStartsync) == BitSyncing;
+}
+
+static void llbitmap_end_sync(struct mddev *mddev, sector_t offset,
+			      sector_t *blocks)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	unsigned long p = offset >> llbitmap->chunkshift;
+
+	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
+	llbitmap_state_machine(llbitmap, p, llbitmap->chunks - 1, BitmapActionAbortsync);
+}
+
+static void llbitmap_close_sync(struct mddev *mddev)
+{
+	struct llbitmap *llbitmap = mddev->bitmap;
+	int i;
+
+	for (i = 0; i < llbitmap->nr_pages; i++) {
+		struct llbitmap_barrier *barrier = &llbitmap->barrier[i];
+
+		/* let daemon_fn clear dirty bits immediately */
+		WRITE_ONCE(barrier->expire, jiffies);
+	}
+
+	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1, BitmapActionEndsync);
+}
-- 
2.39.2


