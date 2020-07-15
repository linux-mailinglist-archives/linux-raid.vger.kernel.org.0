Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC51220D2A
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgGOMmK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 08:42:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731075AbgGOMmF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 08:42:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B7B14B58566BE55E0E41;
        Wed, 15 Jul 2020 20:42:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 20:41:55 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v6 15/15] raid6test: adaptation with syndrome function
Date:   Wed, 15 Jul 2020 08:42:57 -0400
Message-ID: <20200715124257.3175816-16-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715124257.3175816-1-yuyufen@huawei.com>
References: <20200715124257.3175816-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

After changing some syndrome and recovery functions to support
different page offsets, we also need to adapt raid6test module.
In this module, pages are allocated by the itself and their offset
are '0'.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 crypto/async_tx/raid6test.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index 14e73dcd7475..66db82e5a3b1 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -18,6 +18,7 @@
 #define NDISKS 64 /* Including P and Q */
 
 static struct page *dataptrs[NDISKS];
+unsigned int dataoffs[NDISKS];
 static addr_conv_t addr_conv[NDISKS];
 static struct page *data[NDISKS+3];
 static struct page *spare;
@@ -38,6 +39,7 @@ static void makedata(int disks)
 	for (i = 0; i < disks; i++) {
 		prandom_bytes(page_address(data[i]), PAGE_SIZE);
 		dataptrs[i] = data[i];
+		dataoffs[i] = 0;
 	}
 }
 
@@ -52,7 +54,8 @@ static char disk_type(int d, int disks)
 }
 
 /* Recover two failed blocks. */
-static void raid6_dual_recov(int disks, size_t bytes, int faila, int failb, struct page **ptrs)
+static void raid6_dual_recov(int disks, size_t bytes, int faila, int failb,
+		struct page **ptrs, unsigned int *offs)
 {
 	struct async_submit_ctl submit;
 	struct completion cmp;
@@ -66,7 +69,8 @@ static void raid6_dual_recov(int disks, size_t bytes, int faila, int failb, stru
 		if (faila == disks-2) {
 			/* P+Q failure.  Just rebuild the syndrome. */
 			init_async_submit(&submit, 0, NULL, NULL, NULL, addr_conv);
-			tx = async_gen_syndrome(ptrs, 0, disks, bytes, &submit);
+			tx = async_gen_syndrome(ptrs, offs,
+					disks, bytes, &submit);
 		} else {
 			struct page *blocks[NDISKS];
 			struct page *dest;
@@ -89,22 +93,26 @@ static void raid6_dual_recov(int disks, size_t bytes, int faila, int failb, stru
 			tx = async_xor(dest, blocks, 0, count, bytes, &submit);
 
 			init_async_submit(&submit, 0, tx, NULL, NULL, addr_conv);
-			tx = async_gen_syndrome(ptrs, 0, disks, bytes, &submit);
+			tx = async_gen_syndrome(ptrs, offs,
+					disks, bytes, &submit);
 		}
 	} else {
 		if (failb == disks-2) {
 			/* data+P failure. */
 			init_async_submit(&submit, 0, NULL, NULL, NULL, addr_conv);
-			tx = async_raid6_datap_recov(disks, bytes, faila, ptrs, &submit);
+			tx = async_raid6_datap_recov(disks, bytes,
+					faila, ptrs, offs, &submit);
 		} else {
 			/* data+data failure. */
 			init_async_submit(&submit, 0, NULL, NULL, NULL, addr_conv);
-			tx = async_raid6_2data_recov(disks, bytes, faila, failb, ptrs, &submit);
+			tx = async_raid6_2data_recov(disks, bytes,
+					faila, failb, ptrs, offs, &submit);
 		}
 	}
 	init_completion(&cmp);
 	init_async_submit(&submit, ASYNC_TX_ACK, tx, callback, &cmp, addr_conv);
-	tx = async_syndrome_val(ptrs, 0, disks, bytes, &result, spare, &submit);
+	tx = async_syndrome_val(ptrs, offs,
+			disks, bytes, &result, spare, 0, &submit);
 	async_tx_issue_pending(tx);
 
 	if (wait_for_completion_timeout(&cmp, msecs_to_jiffies(3000)) == 0)
@@ -126,7 +134,7 @@ static int test_disks(int i, int j, int disks)
 	dataptrs[i] = recovi;
 	dataptrs[j] = recovj;
 
-	raid6_dual_recov(disks, PAGE_SIZE, i, j, dataptrs);
+	raid6_dual_recov(disks, PAGE_SIZE, i, j, dataptrs, dataoffs);
 
 	erra = memcmp(page_address(data[i]), page_address(recovi), PAGE_SIZE);
 	errb = memcmp(page_address(data[j]), page_address(recovj), PAGE_SIZE);
@@ -162,7 +170,7 @@ static int test(int disks, int *tests)
 	/* Generate assumed good syndrome */
 	init_completion(&cmp);
 	init_async_submit(&submit, ASYNC_TX_ACK, NULL, callback, &cmp, addr_conv);
-	tx = async_gen_syndrome(dataptrs, 0, disks, PAGE_SIZE, &submit);
+	tx = async_gen_syndrome(dataptrs, dataoffs, disks, PAGE_SIZE, &submit);
 	async_tx_issue_pending(tx);
 
 	if (wait_for_completion_timeout(&cmp, msecs_to_jiffies(3000)) == 0) {
-- 
2.25.4

