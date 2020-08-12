Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359592429B0
	for <lists+linux-raid@lfdr.de>; Wed, 12 Aug 2020 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHLMtB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Aug 2020 08:49:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbgHLMs7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 12 Aug 2020 08:48:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EFA7043B6DFE55BFF3AC;
        Wed, 12 Aug 2020 20:48:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 20:48:47 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH 03/12] md/raid5: make async_copy_data() to support different page offset
Date:   Wed, 12 Aug 2020 08:49:22 -0400
Message-ID: <20200812124931.2584743-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812124931.2584743-1-yuyufen@huawei.com>
References: <20200812124931.2584743-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

ops_run_biofill() and ops_run_biodrain() will call async_copy_data()
to copy sh->dev[i].page from or to bio page. For now, it implies the
offset of dev[i].page is 0. But we want to support different page offset
in the following.

Thus, pass page offset to these functions and replace 'page_offset'
with 'page_offset + poff'.

No functional change.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 508dceafa533..4757d1b8f90d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1227,7 +1227,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 
 static struct dma_async_tx_descriptor *
 async_copy_data(int frombio, struct bio *bio, struct page **page,
-	sector_t sector, struct dma_async_tx_descriptor *tx,
+	unsigned int poff, sector_t sector, struct dma_async_tx_descriptor *tx,
 	struct stripe_head *sh, int no_skipcopy)
 {
 	struct bio_vec bvl;
@@ -1273,11 +1273,11 @@ async_copy_data(int frombio, struct bio *bio, struct page **page,
 				    !no_skipcopy)
 					*page = bio_page;
 				else
-					tx = async_memcpy(*page, bio_page, page_offset,
+					tx = async_memcpy(*page, bio_page, page_offset + poff,
 						  b_offset, clen, &submit);
 			} else
 				tx = async_memcpy(bio_page, *page, b_offset,
-						  page_offset, clen, &submit);
+						  page_offset + poff, clen, &submit);
 		}
 		/* chain the operations */
 		submit.depend_tx = tx;
@@ -1350,6 +1350,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + RAID5_STRIPE_SECTORS(conf)) {
 				tx = async_copy_data(0, rbi, &dev->page,
+						     dev->offset,
 						     dev->sector, tx, sh, 0);
 				rbi = r5_next_bio(conf, rbi, dev->sector);
 			}
@@ -1790,6 +1791,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 					set_bit(R5_Discard, &dev->flags);
 				else {
 					tx = async_copy_data(1, wbi, &dev->page,
+							     dev->offset,
 							     dev->sector, tx, sh,
 							     r5c_is_writeback(conf->log));
 					if (dev->page != dev->orig_page &&
-- 
2.25.4

