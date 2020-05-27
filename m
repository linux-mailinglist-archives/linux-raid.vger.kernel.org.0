Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC31E436C
	for <lists+linux-raid@lfdr.de>; Wed, 27 May 2020 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgE0NUl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 May 2020 09:20:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730280AbgE0NUk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 27 May 2020 09:20:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 24A5495E9346789E0291;
        Wed, 27 May 2020 21:20:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 27 May 2020
 21:20:30 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <colyli@suse.de>,
        <xni@redhat.com>, <houtao1@huawei.com>, <yuyufen@huawei.com>
Subject: [PATCH v3 06/11] md/raid5: add new xor function to support different page offset
Date:   Wed, 27 May 2020 21:19:28 +0800
Message-ID: <20200527131933.34400-7-yuyufen@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200527131933.34400-1-yuyufen@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

RAID5 will call async_xor() and async_xor_val() to compute xor.
However, both of them require common src/dst page offset. After
introducing shared pages of r5pages, we want these xor computer
function to support different src/dst page offset.

Here, we add two new functions async_xor_offsets() and
async_xor_val_offsets() respectively for async_xor() and async_xor_val().

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 crypto/async_tx/async_xor.c | 120 +++++++++++++++++++++++++++++++-----
 include/linux/async_tx.h    |  11 ++++
 2 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index 4e5eebe52e6a..29a979358332 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -97,7 +97,8 @@ do_async_xor(struct dma_chan *chan, struct dmaengine_unmap_data *unmap,
 }
 
 static void
-do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
+do_sync_xor_offsets(struct page *dest, unsigned int offset,
+		struct page **src_list, unsigned int *src_offset,
 	    int src_cnt, size_t len, struct async_submit_ctl *submit)
 {
 	int i;
@@ -114,7 +115,8 @@ do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
 	/* convert to buffer pointers */
 	for (i = 0; i < src_cnt; i++)
 		if (src_list[i])
-			srcs[xor_src_cnt++] = page_address(src_list[i]) + offset;
+			srcs[xor_src_cnt++] = page_address(src_list[i]) +
+				(src_offset ? src_offset[i] : offset);
 	src_cnt = xor_src_cnt;
 	/* set destination address */
 	dest_buf = page_address(dest) + offset;
@@ -135,11 +137,31 @@ do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
 	async_tx_sync_epilog(submit);
 }
 
+static inline bool
+dma_xor_aligned_offsets(struct dma_device *device, unsigned int offset,
+		unsigned int *src_offset, int src_cnt, int len)
+{
+	int i;
+
+	if (!is_dma_xor_aligned(device, offset, 0, len))
+		return false;
+
+	if (!src_offset)
+		return true;
+
+	for (i = 0; i < src_cnt; i++) {
+		if (!is_dma_xor_aligned(device, src_offset[i], 0, len))
+			return false;
+	}
+	return true;
+}
+
 /**
- * async_xor - attempt to xor a set of blocks with a dma engine.
+ * async_xor_offsets - attempt to xor a set of blocks with a dma engine.
  * @dest: destination page
+ * @offset: dst offset to start transaction
  * @src_list: array of source pages
- * @offset: common src/dst offset to start transaction
+ * @src_offset: array of source pages offset, NULL means common src/dst offset
  * @src_cnt: number of source pages
  * @len: length in bytes
  * @submit: submission / completion modifiers
@@ -157,8 +179,9 @@ do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
  * is not specified.
  */
 struct dma_async_tx_descriptor *
-async_xor(struct page *dest, struct page **src_list, unsigned int offset,
-	  int src_cnt, size_t len, struct async_submit_ctl *submit)
+async_xor_offsets(struct page *dest, unsigned int offset,
+		struct page **src_list, unsigned int *src_offset,
+		int src_cnt, size_t len, struct async_submit_ctl *submit)
 {
 	struct dma_chan *chan = async_tx_find_channel(submit, DMA_XOR,
 						      &dest, 1, src_list,
@@ -171,7 +194,8 @@ async_xor(struct page *dest, struct page **src_list, unsigned int offset,
 	if (device)
 		unmap = dmaengine_get_unmap_data(device->dev, src_cnt+1, GFP_NOWAIT);
 
-	if (unmap && is_dma_xor_aligned(device, offset, 0, len)) {
+	if (unmap && dma_xor_aligned_offsets(device, offset,
+				src_offset, src_cnt, len)) {
 		struct dma_async_tx_descriptor *tx;
 		int i, j;
 
@@ -184,7 +208,8 @@ async_xor(struct page *dest, struct page **src_list, unsigned int offset,
 				continue;
 			unmap->to_cnt++;
 			unmap->addr[j++] = dma_map_page(device->dev, src_list[i],
-							offset, len, DMA_TO_DEVICE);
+							(src_offset ? src_offset[i] : offset),
+							len, DMA_TO_DEVICE);
 		}
 
 		/* map it bidirectional as it may be re-used as a source */
@@ -213,11 +238,42 @@ async_xor(struct page *dest, struct page **src_list, unsigned int offset,
 		/* wait for any prerequisite operations */
 		async_tx_quiesce(&submit->depend_tx);
 
-		do_sync_xor(dest, src_list, offset, src_cnt, len, submit);
+		do_sync_xor_offsets(dest, offset, src_list, src_offset,
+				src_cnt, len, submit);
 
 		return NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(async_xor_offsets);
+
+/**
+ * async_xor - attempt to xor a set of blocks with a dma engine.
+ * @dest: destination page
+ * @src_list: array of source pages
+ * @offset: common src/dst offset to start transaction
+ * @src_cnt: number of source pages
+ * @len: length in bytes
+ * @submit: submission / completion modifiers
+ *
+ * honored flags: ASYNC_TX_ACK, ASYNC_TX_XOR_ZERO_DST, ASYNC_TX_XOR_DROP_DST
+ *
+ * xor_blocks always uses the dest as a source so the
+ * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
+ * the calculation.  The assumption with dma eninges is that they only
+ * use the destination buffer as a source when it is explicity specified
+ * in the source list.
+ *
+ * src_list note: if the dest is also a source it must be at index zero.
+ * The contents of this array will be overwritten if a scribble region
+ * is not specified.
+ */
+struct dma_async_tx_descriptor *
+async_xor(struct page *dest, struct page **src_list, unsigned int offset,
+	  int src_cnt, size_t len, struct async_submit_ctl *submit)
+{
+	return async_xor_offsets(dest, offset, src_list, NULL,
+			src_cnt, len, submit);
+}
 EXPORT_SYMBOL_GPL(async_xor);
 
 static int page_is_zero(struct page *p, unsigned int offset, size_t len)
@@ -237,10 +293,11 @@ xor_val_chan(struct async_submit_ctl *submit, struct page *dest,
 }
 
 /**
- * async_xor_val - attempt a xor parity check with a dma engine.
+ * async_xor_val_offsets - attempt a xor parity check with a dma engine.
  * @dest: destination page used if the xor is performed synchronously
+ * @offset: des offset in pages to start transaction
  * @src_list: array of source pages
- * @offset: offset in pages to start transaction
+ * @src_offset: array of source pages offset, NULL means common src/det offset
  * @src_cnt: number of source pages
  * @len: length in bytes
  * @result: 0 if sum == 0 else non-zero
@@ -253,9 +310,10 @@ xor_val_chan(struct async_submit_ctl *submit, struct page *dest,
  * is not specified.
  */
 struct dma_async_tx_descriptor *
-async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
-	      int src_cnt, size_t len, enum sum_check_flags *result,
-	      struct async_submit_ctl *submit)
+async_xor_val_offsets(struct page *dest, unsigned int offset,
+		struct page **src_list, unsigned int *src_offset,
+		int src_cnt, size_t len, enum sum_check_flags *result,
+		struct async_submit_ctl *submit)
 {
 	struct dma_chan *chan = xor_val_chan(submit, dest, src_list, src_cnt, len);
 	struct dma_device *device = chan ? chan->device : NULL;
@@ -268,7 +326,7 @@ async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 		unmap = dmaengine_get_unmap_data(device->dev, src_cnt, GFP_NOWAIT);
 
 	if (unmap && src_cnt <= device->max_xor &&
-	    is_dma_xor_aligned(device, offset, 0, len)) {
+	    dma_xor_aligned_offsets(device, offset, src_offset, src_cnt, len)) {
 		unsigned long dma_prep_flags = 0;
 		int i;
 
@@ -281,7 +339,8 @@ async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 
 		for (i = 0; i < src_cnt; i++) {
 			unmap->addr[i] = dma_map_page(device->dev, src_list[i],
-						      offset, len, DMA_TO_DEVICE);
+						(src_offset ? src_offset[i] : offset),
+						len, DMA_TO_DEVICE);
 			unmap->to_cnt++;
 		}
 		unmap->len = len;
@@ -312,7 +371,8 @@ async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 		submit->flags |= ASYNC_TX_XOR_DROP_DST;
 		submit->flags &= ~ASYNC_TX_ACK;
 
-		tx = async_xor(dest, src_list, offset, src_cnt, len, submit);
+		tx = async_xor_offsets(dest, offset, src_list, src_offset,
+				src_cnt, len, submit);
 
 		async_tx_quiesce(&tx);
 
@@ -325,6 +385,32 @@ async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 
 	return tx;
 }
+EXPORT_SYMBOL_GPL(async_xor_val_offsets);
+
+/**
+ * async_xor_val - attempt a xor parity check with a dma engine.
+ * @dest: destination page used if the xor is performed synchronously
+ * @src_list: array of source pages
+ * @offset: offset in pages to start transaction
+ * @src_cnt: number of source pages
+ * @len: length in bytes
+ * @result: 0 if sum == 0 else non-zero
+ * @submit: submission / completion modifiers
+ *
+ * honored flags: ASYNC_TX_ACK
+ *
+ * src_list note: if the dest is also a source it must be at index zero.
+ * The contents of this array will be overwritten if a scribble region
+ * is not specified.
+ */
+struct dma_async_tx_descriptor *
+async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
+	      int src_cnt, size_t len, enum sum_check_flags *result,
+	      struct async_submit_ctl *submit)
+{
+	return async_xor_val_offsets(dest, offset, src_list, NULL, src_cnt,
+			len, result, submit);
+}
 EXPORT_SYMBOL_GPL(async_xor_val);
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/async_tx.h b/include/linux/async_tx.h
index 75e582b8d2d9..8d79e2de06bd 100644
--- a/include/linux/async_tx.h
+++ b/include/linux/async_tx.h
@@ -162,11 +162,22 @@ struct dma_async_tx_descriptor *
 async_xor(struct page *dest, struct page **src_list, unsigned int offset,
 	  int src_cnt, size_t len, struct async_submit_ctl *submit);
 
+struct dma_async_tx_descriptor *
+async_xor_offsets(struct page *dest, unsigned int offset,
+		struct page **src_list, unsigned int *src_offset,
+		int src_cnt, size_t len, struct async_submit_ctl *submit);
+
 struct dma_async_tx_descriptor *
 async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 	      int src_cnt, size_t len, enum sum_check_flags *result,
 	      struct async_submit_ctl *submit);
 
+struct dma_async_tx_descriptor *
+async_xor_val_offsets(struct page *dest, unsigned int offset,
+		struct page **src_list, unsigned int *src_offset,
+		int src_cnt, size_t len, enum sum_check_flags *result,
+		struct async_submit_ctl *submit);
+
 struct dma_async_tx_descriptor *
 async_memcpy(struct page *dest, struct page *src, unsigned int dest_offset,
 	     unsigned int src_offset, size_t len,
-- 
2.21.3

