Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD572122EB
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgGBMFd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 08:05:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728864AbgGBMFa (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 08:05:30 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 16787AFA1ED6DC0456E5;
        Thu,  2 Jul 2020 20:05:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Jul 2020
 20:05:17 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v5 07/16] md/raid5: set correct page offset for async_copy_data()
Date:   Thu, 2 Jul 2020 08:06:19 -0400
Message-ID: <20200702120628.777303-8-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702120628.777303-1-yuyufen@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
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
to copy sh->dev[i].page from or to bio. It also need to set correct
page offset for dev->page when use r5pages.

Without modifying original code logic, we replace 'page_offset' with
'page_offset + poff' simplify. In case of that wihtout using r5pages,
poff is zero.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0f6ec27cf620..e554d073113b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1296,7 +1296,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 
 static struct dma_async_tx_descriptor *
 async_copy_data(int frombio, struct bio *bio, struct page **page,
-	sector_t sector, struct dma_async_tx_descriptor *tx,
+	unsigned int poff, sector_t sector, struct dma_async_tx_descriptor *tx,
 	struct stripe_head *sh, int no_skipcopy)
 {
 	struct bio_vec bvl;
@@ -1342,11 +1342,13 @@ async_copy_data(int frombio, struct bio *bio, struct page **page,
 				    !no_skipcopy)
 					*page = bio_page;
 				else
-					tx = async_memcpy(*page, bio_page, page_offset,
-						  b_offset, clen, &submit);
+					tx = async_memcpy(*page, bio_page,
+						  page_offset + poff, b_offset,
+						  clen, &submit);
 			} else
 				tx = async_memcpy(bio_page, *page, b_offset,
-						  page_offset, clen, &submit);
+						page_offset + poff,
+						clen, &submit);
 		}
 		/* chain the operations */
 		submit.depend_tx = tx;
@@ -1418,7 +1420,8 @@ static void ops_run_biofill(struct stripe_head *sh)
 			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + sh->raid_conf->stripe_sectors) {
 				tx = async_copy_data(0, rbi, &dev->page,
-						     dev->sector, tx, sh, 0);
+						dev->offset,
+						dev->sector, tx, sh, 0);
 				rbi = r5_next_bio(sh->raid_conf, rbi,
 						dev->sector);
 			}
@@ -1846,6 +1849,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 					set_bit(R5_Discard, &dev->flags);
 				else {
 					tx = async_copy_data(1, wbi, &dev->page,
+							     dev->offset,
 							     dev->sector, tx, sh,
 							     r5c_is_writeback(conf->log));
 					if (dev->page != dev->orig_page &&
-- 
2.25.4

