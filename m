Return-Path: <linux-raid+bounces-4154-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3C3AB2CE6
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 03:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFC03BA1AD
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1711F03CF;
	Mon, 12 May 2025 01:28:15 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FE1E834A;
	Mon, 12 May 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013295; cv=none; b=UKH4b+iNky9EI6YKz8d1My2HCEMSt+/JNC/FVIKHs71uJGZzntqhgg454rQGx1JxSFsucfmvaT9WPK+kf6/4xGDn7X8wliqrfrGp8cEjXY9vl5AHUlm8zocsRS77PJUVuxkNYrkPTzwY7Y+iqauJ48b30XyBEhfIEaRtoY7k6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013295; c=relaxed/simple;
	bh=cUklt6u9HRLvdv51EjrnOmOQXl8kpjw+uv3yoeOSjI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eavDYDiccCv14hUuy0xeku4m/F4EG0U9rX9vtTei9y/lDfSZyuhDcb4bwTK2HBJP07oVE0QRq1lwwEMOyIWCrqzMLrlsFWzTpAQXhIvnK99hwrkp6icEstY6mBv59F1IwvmpR8caZobOSAuvrwASD4GZjQm2mN0cDAddswtVC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zwhmt2SMJz4f3lVX;
	Mon, 12 May 2025 09:27:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E36E1A0359;
	Mon, 12 May 2025 09:28:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CdTiFoNFCWMA--.55093S15;
	Mon, 12 May 2025 09:28:08 +0800 (CST)
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
Subject: [PATCH RFC md-6.16 v3 11/19] md/md-llbitmap: implement bitmap IO
Date: Mon, 12 May 2025 09:19:19 +0800
Message-Id: <20250512011927.2809400-12-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnC2CdTiFoNFCWMA--.55093S15
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4xJry7Zr4xJw48WrWrGrg_yoW7Kw15pF
	sxZFy7Cr45Jw1fXw43Jr97AFy5tr4kJanFqryxC34rC34ayrZIgFn7GFy8G3s8Wry5JFn8
	Jan8Gw4rCr18WFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

READ

While creating bitmap, all pages will be allocated and read for llbitmap,
there won't be read afterwards

WRITE

WRITE IO is ievided into logical_block_size of the array, the dirty state
of each block is tracked independently, for example:

each page is 4k, contain 8 blocks; each block is 512 bytes contain 512 bit;

| page0 | page1 | ... | page 31 |
|       |
|        \-----------------------\
|                                |
| block0 | block1 | ... | block 8|
|        |
|         \-----------------\
|                            |
| bit0 | bit1 | ... | bit511 |

From IO path, if one bit is changed to Dirty or NeedSync, the corresponding
block will be marked dirty, such block must write first before the IO is
issued. This behaviour will affect IO performance, to reduce the impact, if
multiple bits are changed in the same block in a short time, all bits in
this block will be changed to Dirty/NeedSync, so that there won't be any
overhead until daemon clears dirty bits.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-llbitmap.c | 183 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/drivers/md/md-llbitmap.c b/drivers/md/md-llbitmap.c
index 8ab4c77abd32..b27d10661387 100644
--- a/drivers/md/md-llbitmap.c
+++ b/drivers/md/md-llbitmap.c
@@ -279,3 +279,186 @@ static char state_machine[nr_llbitmap_state][nr_llbitmap_action] = {
 	[BitNeedSync] = {BitNone, BitSyncing, BitNone, BitNone, BitNone, BitNone, BitUnwritten, BitNone},
 	[BitSyncing] = {BitNone, BitSyncing, BitDirty, BitNeedSync, BitNeedSync, BitNone, BitUnwritten, BitNeedSync},
 };
+
+static bool is_raid456(struct mddev *mddev)
+{
+	return (mddev->level == 4 || mddev->level == 5 || mddev->level == 6);
+}
+
+static int llbitmap_read(struct llbitmap *llbitmap, enum llbitmap_state *state,
+			 loff_t pos)
+{
+	pos += BITMAP_SB_SIZE;
+	*state = llbitmap->barrier[pos >> PAGE_SHIFT].data[offset_in_page(pos)];
+	return 0;
+}
+
+static void llbitmap_set_page_dirty(struct llbitmap *llbitmap, int idx, int offset)
+{
+	struct llbitmap_barrier *barrier = &llbitmap->barrier[idx];
+	bool level_456 = is_raid456(llbitmap->mddev);
+	int io_size = llbitmap->io_size;
+	int bit = offset / io_size;
+	bool infectious = false;
+	int pos;
+
+	if (!test_bit(LLPageDirty, &barrier->flags))
+		set_bit(LLPageDirty, &barrier->flags);
+
+	/*
+	 * if the bit is already dirty, or other page bytes is the same bit is
+	 * already BitDirty, then mark the whole bytes in the bit as dirty
+	 */
+	if (test_and_set_bit(bit, barrier->dirty)) {
+		infectious = true;
+	} else {
+		for (pos = bit * io_size; pos < (bit + 1) * io_size - 1;
+		     pos++) {
+			if (pos == offset)
+				continue;
+			if (barrier->data[pos] == BitDirty ||
+			    barrier->data[pos] == BitNeedSync) {
+				infectious = true;
+				break;
+			}
+		}
+
+	}
+
+	if (!infectious)
+		return;
+
+	for (pos = bit * io_size; pos < (bit + 1) * io_size - 1; pos++) {
+		if (pos == offset)
+			continue;
+
+		switch (barrier->data[pos]) {
+		case BitUnwritten:
+			barrier->data[pos] = level_456 ? BitNeedSync : BitDirty;
+			break;
+		case BitClean:
+			barrier->data[pos] = BitDirty;
+			break;
+		};
+	}
+}
+
+static int llbitmap_write(struct llbitmap *llbitmap, enum llbitmap_state state,
+			  loff_t pos)
+{
+	int idx;
+	int offset;
+
+	pos += BITMAP_SB_SIZE;
+	idx = pos >> PAGE_SHIFT;
+	offset = offset_in_page(pos);
+
+	llbitmap->barrier[idx].data[offset] = state;
+	if (state == BitDirty || state == BitNeedSync)
+		llbitmap_set_page_dirty(llbitmap, idx, offset);
+	return 0;
+}
+
+static void llbitmap_free_pages(struct llbitmap *llbitmap)
+{
+	int i;
+
+	for (i = 0; i < BITMAP_MAX_PAGES; i++) {
+		struct page *page = llbitmap->pages[i];
+
+		if (!page)
+			return;
+
+		llbitmap->pages[i] = NULL;
+		__free_page(page);
+		percpu_ref_exit(&llbitmap->barrier[i].active);
+	}
+}
+
+static struct page *llbitmap_read_page(struct llbitmap *llbitmap, int idx)
+{
+	struct page *page = llbitmap->pages[idx];
+	struct mddev *mddev = llbitmap->mddev;
+	struct md_rdev *rdev;
+
+	if (page)
+		return page;
+
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	rdev_for_each(rdev, mddev) {
+		sector_t sector;
+
+		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+			continue;
+
+		sector = mddev->bitmap_info.offset + (idx << PAGE_SECTORS_SHIFT);
+
+		if (sync_page_io(rdev, sector, PAGE_SIZE, page, REQ_OP_READ, true))
+			return page;
+
+		md_error(mddev, rdev);
+	}
+
+	__free_page(page);
+	return ERR_PTR(-EIO);
+}
+
+static void llbitmap_write_page(struct llbitmap *llbitmap, int idx)
+{
+	struct page *page = llbitmap->pages[idx];
+	struct mddev *mddev = llbitmap->mddev;
+	struct md_rdev *rdev;
+	int bit;
+
+	for (bit = 0; bit < llbitmap->bits_per_page; bit++) {
+		struct llbitmap_barrier *barrier = &llbitmap->barrier[idx];
+
+		if (!test_and_clear_bit(bit, barrier->dirty))
+			continue;
+
+		rdev_for_each(rdev, mddev) {
+			sector_t sector;
+			sector_t bit_sector = llbitmap->io_size >> SECTOR_SHIFT;
+
+			if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+				continue;
+
+			sector = mddev->bitmap_info.offset + rdev->sb_start +
+				 (idx << PAGE_SECTORS_SHIFT) +
+				 bit * bit_sector;
+			md_super_write(mddev, rdev, sector, llbitmap->io_size,
+				       page, bit * llbitmap->io_size);
+		}
+	}
+}
+
+static int llbitmap_cache_pages(struct llbitmap *llbitmap)
+{
+	int nr_pages = (llbitmap->chunks + BITMAP_SB_SIZE + PAGE_SIZE - 1) / PAGE_SIZE;
+	struct page *page;
+	int i = 0;
+
+	llbitmap->nr_pages = nr_pages;
+	while (i < nr_pages) {
+		page = llbitmap_read_page(llbitmap, i);
+		if (IS_ERR(page)) {
+			llbitmap_free_pages(llbitmap);
+			return PTR_ERR(page);
+		}
+
+		if (percpu_ref_init(&llbitmap->barrier[i].active, active_release,
+				    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
+			__free_page(page);
+			return -ENOMEM;
+		}
+
+		init_waitqueue_head(&llbitmap->barrier[i].wait);
+		llbitmap->barrier[i].data = page_address(page);
+		llbitmap->pages[i++] = page;
+	}
+
+	return 0;
+}
-- 
2.39.2


