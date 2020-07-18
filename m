Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6F224A42
	for <lists+linux-raid@lfdr.de>; Sat, 18 Jul 2020 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgGRJ2T (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 18 Jul 2020 05:28:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbgGRJ2S (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 18 Jul 2020 05:28:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2772A3F505D95F4FE8AD;
        Sat, 18 Jul 2020 17:28:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Jul 2020
 17:28:03 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v7 1/3] md/raid456: convert macro STRIPE_* to RAID5_STRIPE_*
Date:   Sat, 18 Jul 2020 05:29:07 -0400
Message-ID: <20200718092909.4020424-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200718092909.4020424-1-yuyufen@huawei.com>
References: <20200718092909.4020424-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Convert macro STRIPE_SIZE, STRIPE_SECTORS and STRIPE_SHIFT to
RAID5_STRIPE_SIZE(), RAID5_STRIPE_SECTORS() and RAID5_STRIPE_SHIFT().

This patch is prepare for the following adjustable stripe_size.
It will not change any existing functionality.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5-cache.c |   8 +-
 drivers/md/raid5-ppl.c   |  11 +-
 drivers/md/raid5.c       | 225 +++++++++++++++++++++------------------
 drivers/md/raid5.h       |  37 ++++---
 4 files changed, 153 insertions(+), 128 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 34fd942dad83..82eb4a906e31 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -296,8 +296,8 @@ r5c_return_dev_pending_writes(struct r5conf *conf, struct r5dev *dev)
 	wbi = dev->written;
 	dev->written = NULL;
 	while (wbi && wbi->bi_iter.bi_sector <
-	       dev->sector + STRIPE_SECTORS) {
-		wbi2 = r5_next_bio(wbi, dev->sector);
+	       dev->sector + RAID5_STRIPE_SECTORS(conf)) {
+		wbi2 = r5_next_bio(conf, wbi, dev->sector);
 		md_write_end(conf->mddev);
 		bio_endio(wbi);
 		wbi = wbi2;
@@ -314,7 +314,7 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
 			set_bit(R5_UPTODATE, &sh->dev[i].flags);
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
 			md_bitmap_endwrite(conf->mddev->bitmap, sh->sector,
-					   STRIPE_SECTORS,
+					   RAID5_STRIPE_SECTORS(conf),
 					   !test_bit(STRIPE_DEGRADED, &sh->state),
 					   0);
 		}
@@ -362,7 +362,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
 	 */
 	if (atomic_read(&conf->r5c_cached_full_stripes) >=
 	    min(R5C_FULL_STRIPE_FLUSH_BATCH(conf),
-		conf->chunk_sectors >> STRIPE_SHIFT))
+		conf->chunk_sectors >> RAID5_STRIPE_SHIFT(conf)))
 		r5l_wake_reclaim(conf->log, 0);
 }
 
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index a750f4bbb5d9..d0f540296fe9 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -324,7 +324,7 @@ static int ppl_log_stripe(struct ppl_log *log, struct stripe_head *sh)
 		 * be just after the last logged stripe and write to the same
 		 * disks. Use bit shift and logarithm to avoid 64-bit division.
 		 */
-		if ((sh->sector == sh_last->sector + STRIPE_SECTORS) &&
+		if ((sh->sector == sh_last->sector + RAID5_STRIPE_SECTORS(conf)) &&
 		    (data_sector >> ilog2(conf->chunk_sectors) ==
 		     data_sector_last >> ilog2(conf->chunk_sectors)) &&
 		    ((data_sector - data_sector_last) * data_disks ==
@@ -844,9 +844,9 @@ static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
 
 	/* if start and end is 4k aligned, use a 4k block */
 	if (block_size == 512 &&
-	    (r_sector_first & (STRIPE_SECTORS - 1)) == 0 &&
-	    (r_sector_last & (STRIPE_SECTORS - 1)) == 0)
-		block_size = STRIPE_SIZE;
+	    (r_sector_first & (RAID5_STRIPE_SECTORS(conf) - 1)) == 0 &&
+	    (r_sector_last & (RAID5_STRIPE_SECTORS(conf) - 1)) == 0)
+		block_size = RAID5_STRIPE_SIZE(conf);
 
 	/* iterate through blocks in strip */
 	for (i = 0; i < strip_sectors; i += (block_size >> 9)) {
@@ -1274,7 +1274,8 @@ static int ppl_validate_rdev(struct md_rdev *rdev)
 	ppl_data_sectors = rdev->ppl.size - (PPL_HEADER_SIZE >> 9);
 
 	if (ppl_data_sectors > 0)
-		ppl_data_sectors = rounddown(ppl_data_sectors, STRIPE_SECTORS);
+		ppl_data_sectors = rounddown(ppl_data_sectors,
+				RAID5_STRIPE_SECTORS((struct r5conf *)rdev->mddev->private));
 
 	if (ppl_data_sectors <= 0) {
 		pr_warn("md/raid:%s: PPL space too small on %s\n",
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 73128f46924c..18f20f3d9664 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -69,13 +69,13 @@ static struct workqueue_struct *raid5_wq;
 
 static inline struct hlist_head *stripe_hash(struct r5conf *conf, sector_t sect)
 {
-	int hash = (sect >> STRIPE_SHIFT) & HASH_MASK;
+	int hash = (sect >> RAID5_STRIPE_SHIFT(conf)) & HASH_MASK;
 	return &conf->stripe_hashtbl[hash];
 }
 
-static inline int stripe_hash_locks_hash(sector_t sect)
+static inline int stripe_hash_locks_hash(struct r5conf *conf, sector_t sect)
 {
-	return (sect >> STRIPE_SHIFT) & STRIPE_HASH_LOCKS_MASK;
+	return (sect >> RAID5_STRIPE_SHIFT(conf)) & STRIPE_HASH_LOCKS_MASK;
 }
 
 static inline void lock_device_hash_lock(struct r5conf *conf, int hash)
@@ -627,7 +627,7 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 			int previous, int noblock, int noquiesce)
 {
 	struct stripe_head *sh;
-	int hash = stripe_hash_locks_hash(sector);
+	int hash = stripe_hash_locks_hash(conf, sector);
 	int inc_empty_inactive_list_flag;
 
 	pr_debug("get_stripe, sector %llu\n", (unsigned long long)sector);
@@ -748,9 +748,9 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 	tmp_sec = sh->sector;
 	if (!sector_div(tmp_sec, conf->chunk_sectors))
 		return;
-	head_sector = sh->sector - STRIPE_SECTORS;
+	head_sector = sh->sector - RAID5_STRIPE_SECTORS(conf);
 
-	hash = stripe_hash_locks_hash(head_sector);
+	hash = stripe_hash_locks_hash(conf, head_sector);
 	spin_lock_irq(conf->hash_locks + hash);
 	head = __find_stripe(conf, head_sector, conf->generation);
 	if (head && !atomic_inc_not_zero(&head->count)) {
@@ -1057,7 +1057,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		       test_bit(WriteErrorSeen, &rdev->flags)) {
 			sector_t first_bad;
 			int bad_sectors;
-			int bad = is_badblock(rdev, sh->sector, STRIPE_SECTORS,
+			int bad = is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
 					      &first_bad, &bad_sectors);
 			if (!bad)
 				break;
@@ -1089,7 +1089,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		if (rdev) {
 			if (s->syncing || s->expanding || s->expanded
 			    || s->replacing)
-				md_sync_acct(rdev->bdev, STRIPE_SECTORS);
+				md_sync_acct(rdev->bdev, RAID5_STRIPE_SECTORS(conf));
 
 			set_bit(STRIPE_IO_STARTED, &sh->state);
 
@@ -1129,9 +1129,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			else
 				sh->dev[i].vec.bv_page = sh->dev[i].page;
 			bi->bi_vcnt = 1;
-			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
+			bi->bi_io_vec[0].bv_len = RAID5_STRIPE_SIZE(conf);
 			bi->bi_io_vec[0].bv_offset = 0;
-			bi->bi_iter.bi_size = STRIPE_SIZE;
+			bi->bi_iter.bi_size = RAID5_STRIPE_SIZE(conf);
 			bi->bi_write_hint = sh->dev[i].write_hint;
 			if (!rrdev)
 				sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
@@ -1156,7 +1156,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		if (rrdev) {
 			if (s->syncing || s->expanding || s->expanded
 			    || s->replacing)
-				md_sync_acct(rrdev->bdev, STRIPE_SECTORS);
+				md_sync_acct(rrdev->bdev, RAID5_STRIPE_SECTORS(conf));
 
 			set_bit(STRIPE_IO_STARTED, &sh->state);
 
@@ -1183,9 +1183,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				WARN_ON(test_bit(R5_UPTODATE, &sh->dev[i].flags));
 			sh->dev[i].rvec.bv_page = sh->dev[i].page;
 			rbi->bi_vcnt = 1;
-			rbi->bi_io_vec[0].bv_len = STRIPE_SIZE;
+			rbi->bi_io_vec[0].bv_len = RAID5_STRIPE_SIZE(conf);
 			rbi->bi_io_vec[0].bv_offset = 0;
-			rbi->bi_iter.bi_size = STRIPE_SIZE;
+			rbi->bi_iter.bi_size = RAID5_STRIPE_SIZE(conf);
 			rbi->bi_write_hint = sh->dev[i].write_hint;
 			sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
 			/*
@@ -1235,6 +1235,7 @@ async_copy_data(int frombio, struct bio *bio, struct page **page,
 	int page_offset;
 	struct async_submit_ctl submit;
 	enum async_tx_flags flags = 0;
+	struct r5conf *conf = sh->raid_conf;
 
 	if (bio->bi_iter.bi_sector >= sector)
 		page_offset = (signed)(bio->bi_iter.bi_sector - sector) * 512;
@@ -1256,8 +1257,8 @@ async_copy_data(int frombio, struct bio *bio, struct page **page,
 			len -= b_offset;
 		}
 
-		if (len > 0 && page_offset + len > STRIPE_SIZE)
-			clen = STRIPE_SIZE - page_offset;
+		if (len > 0 && page_offset + len > RAID5_STRIPE_SIZE(conf))
+			clen = RAID5_STRIPE_SIZE(conf) - page_offset;
 		else
 			clen = len;
 
@@ -1265,9 +1266,9 @@ async_copy_data(int frombio, struct bio *bio, struct page **page,
 			b_offset += bvl.bv_offset;
 			bio_page = bvl.bv_page;
 			if (frombio) {
-				if (sh->raid_conf->skip_copy &&
+				if (conf->skip_copy &&
 				    b_offset == 0 && page_offset == 0 &&
-				    clen == STRIPE_SIZE &&
+				    clen == RAID5_STRIPE_SIZE(conf) &&
 				    !no_skipcopy)
 					*page = bio_page;
 				else
@@ -1292,6 +1293,7 @@ static void ops_complete_biofill(void *stripe_head_ref)
 {
 	struct stripe_head *sh = stripe_head_ref;
 	int i;
+	struct r5conf *conf = sh->raid_conf;
 
 	pr_debug("%s: stripe %llu\n", __func__,
 		(unsigned long long)sh->sector);
@@ -1312,8 +1314,8 @@ static void ops_complete_biofill(void *stripe_head_ref)
 			rbi = dev->read;
 			dev->read = NULL;
 			while (rbi && rbi->bi_iter.bi_sector <
-				dev->sector + STRIPE_SECTORS) {
-				rbi2 = r5_next_bio(rbi, dev->sector);
+				dev->sector + RAID5_STRIPE_SECTORS(conf)) {
+				rbi2 = r5_next_bio(conf, rbi, dev->sector);
 				bio_endio(rbi);
 				rbi = rbi2;
 			}
@@ -1330,6 +1332,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 	struct dma_async_tx_descriptor *tx = NULL;
 	struct async_submit_ctl submit;
 	int i;
+	struct r5conf *conf = sh->raid_conf;
 
 	BUG_ON(sh->batch_head);
 	pr_debug("%s: stripe %llu\n", __func__,
@@ -1344,10 +1347,10 @@ static void ops_run_biofill(struct stripe_head *sh)
 			dev->toread = NULL;
 			spin_unlock_irq(&sh->stripe_lock);
 			while (rbi && rbi->bi_iter.bi_sector <
-				dev->sector + STRIPE_SECTORS) {
+				dev->sector + RAID5_STRIPE_SECTORS(conf)) {
 				tx = async_copy_data(0, rbi, &dev->page,
 						     dev->sector, tx, sh, 0);
-				rbi = r5_next_bio(rbi, dev->sector);
+				rbi = r5_next_bio(conf, rbi, dev->sector);
 			}
 		}
 	}
@@ -1429,9 +1432,11 @@ ops_run_compute5(struct stripe_head *sh, struct raid5_percpu *percpu)
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, NULL,
 			  ops_complete_compute, sh, to_addr_conv(sh, percpu, 0));
 	if (unlikely(count == 1))
-		tx = async_memcpy(xor_dest, xor_srcs[0], 0, 0, STRIPE_SIZE, &submit);
+		tx = async_memcpy(xor_dest, xor_srcs[0], 0, 0,
+				RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 	else
-		tx = async_xor(xor_dest, xor_srcs, 0, count, STRIPE_SIZE, &submit);
+		tx = async_xor(xor_dest, xor_srcs, 0, count,
+				RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 
 	return tx;
 }
@@ -1522,7 +1527,8 @@ ops_run_compute6_1(struct stripe_head *sh, struct raid5_percpu *percpu)
 		init_async_submit(&submit, ASYNC_TX_FENCE, NULL,
 				  ops_complete_compute, sh,
 				  to_addr_conv(sh, percpu, 0));
-		tx = async_gen_syndrome(blocks, 0, count+2, STRIPE_SIZE, &submit);
+		tx = async_gen_syndrome(blocks, 0, count+2,
+				RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 	} else {
 		/* Compute any data- or p-drive using XOR */
 		count = 0;
@@ -1535,7 +1541,8 @@ ops_run_compute6_1(struct stripe_head *sh, struct raid5_percpu *percpu)
 		init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST,
 				  NULL, ops_complete_compute, sh,
 				  to_addr_conv(sh, percpu, 0));
-		tx = async_xor(dest, blocks, 0, count, STRIPE_SIZE, &submit);
+		tx = async_xor(dest, blocks, 0, count,
+				RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 	}
 
 	return tx;
@@ -1598,7 +1605,8 @@ ops_run_compute6_2(struct stripe_head *sh, struct raid5_percpu *percpu)
 					  ops_complete_compute, sh,
 					  to_addr_conv(sh, percpu, 0));
 			return async_gen_syndrome(blocks, 0, syndrome_disks+2,
-						  STRIPE_SIZE, &submit);
+						  RAID5_STRIPE_SIZE(sh->raid_conf),
+						  &submit);
 		} else {
 			struct page *dest;
 			int data_target;
@@ -1621,7 +1629,8 @@ ops_run_compute6_2(struct stripe_head *sh, struct raid5_percpu *percpu)
 					  ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST,
 					  NULL, NULL, NULL,
 					  to_addr_conv(sh, percpu, 0));
-			tx = async_xor(dest, blocks, 0, count, STRIPE_SIZE,
+			tx = async_xor(dest, blocks, 0, count,
+				       RAID5_STRIPE_SIZE(sh->raid_conf),
 				       &submit);
 
 			count = set_syndrome_sources(blocks, sh, SYNDROME_SRC_ALL);
@@ -1629,7 +1638,8 @@ ops_run_compute6_2(struct stripe_head *sh, struct raid5_percpu *percpu)
 					  ops_complete_compute, sh,
 					  to_addr_conv(sh, percpu, 0));
 			return async_gen_syndrome(blocks, 0, count+2,
-						  STRIPE_SIZE, &submit);
+						  RAID5_STRIPE_SIZE(sh->raid_conf),
+						  &submit);
 		}
 	} else {
 		init_async_submit(&submit, ASYNC_TX_FENCE, NULL,
@@ -1638,13 +1648,15 @@ ops_run_compute6_2(struct stripe_head *sh, struct raid5_percpu *percpu)
 		if (failb == syndrome_disks) {
 			/* We're missing D+P. */
 			return async_raid6_datap_recov(syndrome_disks+2,
-						       STRIPE_SIZE, faila,
-						       blocks, &submit);
+						RAID5_STRIPE_SIZE(sh->raid_conf),
+						faila,
+						blocks, &submit);
 		} else {
 			/* We're missing D+D. */
 			return async_raid6_2data_recov(syndrome_disks+2,
-						       STRIPE_SIZE, faila, failb,
-						       blocks, &submit);
+						RAID5_STRIPE_SIZE(sh->raid_conf),
+						faila, failb,
+						blocks, &submit);
 		}
 	}
 }
@@ -1691,7 +1703,8 @@ ops_run_prexor5(struct stripe_head *sh, struct raid5_percpu *percpu,
 
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_DROP_DST, tx,
 			  ops_complete_prexor, sh, to_addr_conv(sh, percpu, 0));
-	tx = async_xor(xor_dest, xor_srcs, 0, count, STRIPE_SIZE, &submit);
+	tx = async_xor(xor_dest, xor_srcs, 0, count,
+			RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 
 	return tx;
 }
@@ -1711,7 +1724,8 @@ ops_run_prexor6(struct stripe_head *sh, struct raid5_percpu *percpu,
 
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_PQ_XOR_DST, tx,
 			  ops_complete_prexor, sh, to_addr_conv(sh, percpu, 0));
-	tx = async_gen_syndrome(blocks, 0, count+2, STRIPE_SIZE,  &submit);
+	tx = async_gen_syndrome(blocks, 0, count+2,
+			RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 
 	return tx;
 }
@@ -1752,7 +1766,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 			WARN_ON(dev->page != dev->orig_page);
 
 			while (wbi && wbi->bi_iter.bi_sector <
-				dev->sector + STRIPE_SECTORS) {
+				dev->sector + RAID5_STRIPE_SECTORS(conf)) {
 				if (wbi->bi_opf & REQ_FUA)
 					set_bit(R5_WantFUA, &dev->flags);
 				if (wbi->bi_opf & REQ_SYNC)
@@ -1770,7 +1784,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 						clear_bit(R5_OVERWRITE, &dev->flags);
 					}
 				}
-				wbi = r5_next_bio(wbi, dev->sector);
+				wbi = r5_next_bio(conf, wbi, dev->sector);
 			}
 
 			if (head_sh->batch_head) {
@@ -1910,9 +1924,11 @@ ops_run_reconstruct5(struct stripe_head *sh, struct raid5_percpu *percpu,
 	}
 
 	if (unlikely(count == 1))
-		tx = async_memcpy(xor_dest, xor_srcs[0], 0, 0, STRIPE_SIZE, &submit);
+		tx = async_memcpy(xor_dest, xor_srcs[0], 0, 0,
+				RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 	else
-		tx = async_xor(xor_dest, xor_srcs, 0, count, STRIPE_SIZE, &submit);
+		tx = async_xor(xor_dest, xor_srcs, 0, count,
+				RAID5_STRIPE_SIZE(sh->raid_conf), &submit);
 	if (!last_stripe) {
 		j++;
 		sh = list_first_entry(&sh->batch_list, struct stripe_head,
@@ -1972,7 +1988,8 @@ ops_run_reconstruct6(struct stripe_head *sh, struct raid5_percpu *percpu,
 	} else
 		init_async_submit(&submit, 0, tx, NULL, NULL,
 				  to_addr_conv(sh, percpu, j));
-	tx = async_gen_syndrome(blocks, 0, count+2, STRIPE_SIZE,  &submit);
+	tx = async_gen_syndrome(blocks, 0, count+2,
+			RAID5_STRIPE_SIZE(sh->raid_conf),  &submit);
 	if (!last_stripe) {
 		j++;
 		sh = list_first_entry(&sh->batch_list, struct stripe_head,
@@ -2020,7 +2037,8 @@ static void ops_run_check_p(struct stripe_head *sh, struct raid5_percpu *percpu)
 
 	init_async_submit(&submit, 0, NULL, NULL, NULL,
 			  to_addr_conv(sh, percpu, 0));
-	tx = async_xor_val(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
+	tx = async_xor_val(xor_dest, xor_srcs, 0, count,
+			   RAID5_STRIPE_SIZE(sh->raid_conf),
 			   &sh->ops.zero_sum_result, &submit);
 
 	atomic_inc(&sh->count);
@@ -2045,7 +2063,8 @@ static void ops_run_check_pq(struct stripe_head *sh, struct raid5_percpu *percpu
 	atomic_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, NULL, ops_complete_check,
 			  sh, to_addr_conv(sh, percpu, 0));
-	async_syndrome_val(srcs, 0, count+2, STRIPE_SIZE,
+	async_syndrome_val(srcs, 0, count+2,
+			   RAID5_STRIPE_SIZE(sh->raid_conf),
 			   &sh->ops.zero_sum_result, percpu->spare_page, &submit);
 }
 
@@ -2275,7 +2294,7 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 
 		percpu = per_cpu_ptr(conf->percpu, cpu);
 		err = scribble_alloc(percpu, new_disks,
-				     new_sectors / STRIPE_SECTORS);
+				     new_sectors / RAID5_STRIPE_SECTORS(conf));
 		if (err)
 			break;
 	}
@@ -2509,10 +2528,10 @@ static void raid5_end_read_request(struct bio * bi)
 			 */
 			pr_info_ratelimited(
 				"md/raid:%s: read error corrected (%lu sectors at %llu on %s)\n",
-				mdname(conf->mddev), STRIPE_SECTORS,
+				mdname(conf->mddev), RAID5_STRIPE_SECTORS(conf),
 				(unsigned long long)s,
 				bdevname(rdev->bdev, b));
-			atomic_add(STRIPE_SECTORS, &rdev->corrected_errors);
+			atomic_add(RAID5_STRIPE_SECTORS(conf), &rdev->corrected_errors);
 			clear_bit(R5_ReadError, &sh->dev[i].flags);
 			clear_bit(R5_ReWrite, &sh->dev[i].flags);
 		} else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
@@ -2585,7 +2604,7 @@ static void raid5_end_read_request(struct bio * bi)
 			if (!(set_bad
 			      && test_bit(In_sync, &rdev->flags)
 			      && rdev_set_badblocks(
-				      rdev, sh->sector, STRIPE_SECTORS, 0)))
+				      rdev, sh->sector, RAID5_STRIPE_SECTORS(conf), 0)))
 				md_error(conf->mddev, rdev);
 		}
 	}
@@ -2637,7 +2656,7 @@ static void raid5_end_write_request(struct bio *bi)
 		if (bi->bi_status)
 			md_error(conf->mddev, rdev);
 		else if (is_badblock(rdev, sh->sector,
-				     STRIPE_SECTORS,
+				     RAID5_STRIPE_SECTORS(conf),
 				     &first_bad, &bad_sectors))
 			set_bit(R5_MadeGoodRepl, &sh->dev[i].flags);
 	} else {
@@ -2649,7 +2668,7 @@ static void raid5_end_write_request(struct bio *bi)
 				set_bit(MD_RECOVERY_NEEDED,
 					&rdev->mddev->recovery);
 		} else if (is_badblock(rdev, sh->sector,
-				       STRIPE_SECTORS,
+				       RAID5_STRIPE_SECTORS(conf),
 				       &first_bad, &bad_sectors)) {
 			set_bit(R5_MadeGood, &sh->dev[i].flags);
 			if (test_bit(R5_ReadError, &sh->dev[i].flags))
@@ -3283,13 +3302,13 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 		/* check if page is covered */
 		sector_t sector = sh->dev[dd_idx].sector;
 		for (bi=sh->dev[dd_idx].towrite;
-		     sector < sh->dev[dd_idx].sector + STRIPE_SECTORS &&
+		     sector < sh->dev[dd_idx].sector + RAID5_STRIPE_SECTORS(conf) &&
 			     bi && bi->bi_iter.bi_sector <= sector;
-		     bi = r5_next_bio(bi, sh->dev[dd_idx].sector)) {
+		     bi = r5_next_bio(conf, bi, sh->dev[dd_idx].sector)) {
 			if (bio_end_sector(bi) >= sector)
 				sector = bio_end_sector(bi);
 		}
-		if (sector >= sh->dev[dd_idx].sector + STRIPE_SECTORS)
+		if (sector >= sh->dev[dd_idx].sector + RAID5_STRIPE_SECTORS(conf))
 			if (!test_and_set_bit(R5_OVERWRITE, &sh->dev[dd_idx].flags))
 				sh->overwrite_disks++;
 	}
@@ -3314,7 +3333,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		spin_unlock_irq(&sh->stripe_lock);
 		md_bitmap_startwrite(conf->mddev->bitmap, sh->sector,
-				     STRIPE_SECTORS, 0);
+				     RAID5_STRIPE_SECTORS(conf), 0);
 		spin_lock_irq(&sh->stripe_lock);
 		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		if (!sh->batch_head) {
@@ -3376,7 +3395,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 				if (!rdev_set_badblocks(
 					    rdev,
 					    sh->sector,
-					    STRIPE_SECTORS, 0))
+					    RAID5_STRIPE_SECTORS(conf), 0))
 					md_error(conf->mddev, rdev);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
@@ -3396,8 +3415,8 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			wake_up(&conf->wait_for_overlap);
 
 		while (bi && bi->bi_iter.bi_sector <
-			sh->dev[i].sector + STRIPE_SECTORS) {
-			struct bio *nextbi = r5_next_bio(bi, sh->dev[i].sector);
+			sh->dev[i].sector + RAID5_STRIPE_SECTORS(conf)) {
+			struct bio *nextbi = r5_next_bio(conf, bi, sh->dev[i].sector);
 
 			md_write_end(conf->mddev);
 			bio_io_error(bi);
@@ -3405,7 +3424,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		}
 		if (bitmap_end)
 			md_bitmap_endwrite(conf->mddev->bitmap, sh->sector,
-					   STRIPE_SECTORS, 0, 0);
+					   RAID5_STRIPE_SECTORS(conf), 0, 0);
 		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
@@ -3417,8 +3436,8 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 
 		if (bi) bitmap_end = 1;
 		while (bi && bi->bi_iter.bi_sector <
-		       sh->dev[i].sector + STRIPE_SECTORS) {
-			struct bio *bi2 = r5_next_bio(bi, sh->dev[i].sector);
+		       sh->dev[i].sector + RAID5_STRIPE_SECTORS(conf)) {
+			struct bio *bi2 = r5_next_bio(conf, bi, sh->dev[i].sector);
 
 			md_write_end(conf->mddev);
 			bio_io_error(bi);
@@ -3441,9 +3460,9 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			if (bi)
 				s->to_read--;
 			while (bi && bi->bi_iter.bi_sector <
-			       sh->dev[i].sector + STRIPE_SECTORS) {
+			       sh->dev[i].sector + RAID5_STRIPE_SECTORS(conf)) {
 				struct bio *nextbi =
-					r5_next_bio(bi, sh->dev[i].sector);
+					r5_next_bio(conf, bi, sh->dev[i].sector);
 
 				bio_io_error(bi);
 				bi = nextbi;
@@ -3451,7 +3470,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		}
 		if (bitmap_end)
 			md_bitmap_endwrite(conf->mddev->bitmap, sh->sector,
-					   STRIPE_SECTORS, 0, 0);
+					   RAID5_STRIPE_SECTORS(conf), 0, 0);
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -3496,14 +3515,14 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
 			    && !test_bit(Faulty, &rdev->flags)
 			    && !test_bit(In_sync, &rdev->flags)
 			    && !rdev_set_badblocks(rdev, sh->sector,
-						   STRIPE_SECTORS, 0))
+						   RAID5_STRIPE_SECTORS(conf), 0))
 				abort = 1;
 			rdev = rcu_dereference(conf->disks[i].replacement);
 			if (rdev
 			    && !test_bit(Faulty, &rdev->flags)
 			    && !test_bit(In_sync, &rdev->flags)
 			    && !rdev_set_badblocks(rdev, sh->sector,
-						   STRIPE_SECTORS, 0))
+						   RAID5_STRIPE_SECTORS(conf), 0))
 				abort = 1;
 		}
 		rcu_read_unlock();
@@ -3511,7 +3530,7 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
 			conf->recovery_disabled =
 				conf->mddev->recovery_disabled;
 	}
-	md_done_sync(conf->mddev, STRIPE_SECTORS, !abort);
+	md_done_sync(conf->mddev, RAID5_STRIPE_SECTORS(conf), !abort);
 }
 
 static int want_replace(struct stripe_head *sh, int disk_idx)
@@ -3785,14 +3804,14 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 				wbi = dev->written;
 				dev->written = NULL;
 				while (wbi && wbi->bi_iter.bi_sector <
-					dev->sector + STRIPE_SECTORS) {
-					wbi2 = r5_next_bio(wbi, dev->sector);
+					dev->sector + RAID5_STRIPE_SECTORS(conf)) {
+					wbi2 = r5_next_bio(conf, wbi, dev->sector);
 					md_write_end(conf->mddev);
 					bio_endio(wbi);
 					wbi = wbi2;
 				}
 				md_bitmap_endwrite(conf->mddev->bitmap, sh->sector,
-						   STRIPE_SECTORS,
+						   RAID5_STRIPE_SECTORS(conf),
 						   !test_bit(STRIPE_DEGRADED, &sh->state),
 						   0);
 				if (head_sh->batch_head) {
@@ -4099,7 +4118,7 @@ static void handle_parity_checks5(struct r5conf *conf, struct stripe_head *sh,
 			 */
 			set_bit(STRIPE_INSYNC, &sh->state);
 		else {
-			atomic64_add(STRIPE_SECTORS, &conf->mddev->resync_mismatches);
+			atomic64_add(RAID5_STRIPE_SECTORS(conf), &conf->mddev->resync_mismatches);
 			if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery)) {
 				/* don't try to repair!! */
 				set_bit(STRIPE_INSYNC, &sh->state);
@@ -4107,7 +4126,7 @@ static void handle_parity_checks5(struct r5conf *conf, struct stripe_head *sh,
 						    "%llu-%llu\n", mdname(conf->mddev),
 						    (unsigned long long) sh->sector,
 						    (unsigned long long) sh->sector +
-						    STRIPE_SECTORS);
+						    RAID5_STRIPE_SECTORS(conf));
 			} else {
 				sh->check_state = check_state_compute_run;
 				set_bit(STRIPE_COMPUTE_RUN, &sh->state);
@@ -4264,7 +4283,7 @@ static void handle_parity_checks6(struct r5conf *conf, struct stripe_head *sh,
 				 */
 			}
 		} else {
-			atomic64_add(STRIPE_SECTORS, &conf->mddev->resync_mismatches);
+			atomic64_add(RAID5_STRIPE_SECTORS(conf), &conf->mddev->resync_mismatches);
 			if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery)) {
 				/* don't try to repair!! */
 				set_bit(STRIPE_INSYNC, &sh->state);
@@ -4272,7 +4291,7 @@ static void handle_parity_checks6(struct r5conf *conf, struct stripe_head *sh,
 						    "%llu-%llu\n", mdname(conf->mddev),
 						    (unsigned long long) sh->sector,
 						    (unsigned long long) sh->sector +
-						    STRIPE_SECTORS);
+						    RAID5_STRIPE_SECTORS(conf));
 			} else {
 				int *target = &sh->ops.target;
 
@@ -4343,7 +4362,7 @@ static void handle_stripe_expansion(struct r5conf *conf, struct stripe_head *sh)
 			/* place all the copies on one channel */
 			init_async_submit(&submit, 0, tx, NULL, NULL, NULL);
 			tx = async_memcpy(sh2->dev[dd_idx].page,
-					  sh->dev[i].page, 0, 0, STRIPE_SIZE,
+					  sh->dev[i].page, 0, 0, RAID5_STRIPE_SIZE(conf),
 					  &submit);
 
 			set_bit(R5_Expanded, &sh2->dev[dd_idx].flags);
@@ -4442,8 +4461,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		 */
 		rdev = rcu_dereference(conf->disks[i].replacement);
 		if (rdev && !test_bit(Faulty, &rdev->flags) &&
-		    rdev->recovery_offset >= sh->sector + STRIPE_SECTORS &&
-		    !is_badblock(rdev, sh->sector, STRIPE_SECTORS,
+		    rdev->recovery_offset >= sh->sector + RAID5_STRIPE_SECTORS(conf) &&
+		    !is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
 				 &first_bad, &bad_sectors))
 			set_bit(R5_ReadRepl, &dev->flags);
 		else {
@@ -4457,7 +4476,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		if (rdev && test_bit(Faulty, &rdev->flags))
 			rdev = NULL;
 		if (rdev) {
-			is_bad = is_badblock(rdev, sh->sector, STRIPE_SECTORS,
+			is_bad = is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
 					     &first_bad, &bad_sectors);
 			if (s->blocked_rdev == NULL
 			    && (test_bit(Blocked, &rdev->flags)
@@ -4484,7 +4503,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 			}
 		} else if (test_bit(In_sync, &rdev->flags))
 			set_bit(R5_Insync, &dev->flags);
-		else if (sh->sector + STRIPE_SECTORS <= rdev->recovery_offset)
+		else if (sh->sector + RAID5_STRIPE_SECTORS(conf) <= rdev->recovery_offset)
 			/* in sync if before recovery_offset */
 			set_bit(R5_Insync, &dev->flags);
 		else if (test_bit(R5_UPTODATE, &dev->flags) &&
@@ -4932,7 +4951,7 @@ static void handle_stripe(struct stripe_head *sh)
 	if ((s.syncing || s.replacing) && s.locked == 0 &&
 	    !test_bit(STRIPE_COMPUTE_RUN, &sh->state) &&
 	    test_bit(STRIPE_INSYNC, &sh->state)) {
-		md_done_sync(conf->mddev, STRIPE_SECTORS, 1);
+		md_done_sync(conf->mddev, RAID5_STRIPE_SECTORS(conf), 1);
 		clear_bit(STRIPE_SYNCING, &sh->state);
 		if (test_and_clear_bit(R5_Overlap, &sh->dev[sh->pd_idx].flags))
 			wake_up(&conf->wait_for_overlap);
@@ -5000,7 +5019,7 @@ static void handle_stripe(struct stripe_head *sh)
 		clear_bit(STRIPE_EXPAND_READY, &sh->state);
 		atomic_dec(&conf->reshape_stripes);
 		wake_up(&conf->wait_for_overlap);
-		md_done_sync(conf->mddev, STRIPE_SECTORS, 1);
+		md_done_sync(conf->mddev, RAID5_STRIPE_SECTORS(conf), 1);
 	}
 
 	if (s.expanding && s.locked == 0 &&
@@ -5030,14 +5049,14 @@ static void handle_stripe(struct stripe_head *sh)
 				/* We own a safe reference to the rdev */
 				rdev = conf->disks[i].rdev;
 				if (!rdev_set_badblocks(rdev, sh->sector,
-							STRIPE_SECTORS, 0))
+							RAID5_STRIPE_SECTORS(conf), 0))
 					md_error(conf->mddev, rdev);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			if (test_and_clear_bit(R5_MadeGood, &dev->flags)) {
 				rdev = conf->disks[i].rdev;
 				rdev_clear_badblocks(rdev, sh->sector,
-						     STRIPE_SECTORS, 0);
+						     RAID5_STRIPE_SECTORS(conf), 0);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			if (test_and_clear_bit(R5_MadeGoodRepl, &dev->flags)) {
@@ -5046,7 +5065,7 @@ static void handle_stripe(struct stripe_head *sh)
 					/* rdev have been moved down */
 					rdev = conf->disks[i].rdev;
 				rdev_clear_badblocks(rdev, sh->sector,
-						     STRIPE_SECTORS, 0);
+						     RAID5_STRIPE_SECTORS(conf), 0);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 		}
@@ -5510,7 +5529,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		/* Skip discard while reshape is happening */
 		return;
 
-	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
 	last_sector = bio_end_sector(bi);
 
 	bi->bi_next = NULL;
@@ -5525,7 +5544,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 	last_sector *= conf->chunk_sectors;
 
 	for (; logical_sector < last_sector;
-	     logical_sector += STRIPE_SECTORS) {
+	     logical_sector += RAID5_STRIPE_SECTORS(conf)) {
 		DEFINE_WAIT(w);
 		int d;
 	again:
@@ -5570,7 +5589,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 			     d++)
 				md_bitmap_startwrite(mddev->bitmap,
 						     sh->sector,
-						     STRIPE_SECTORS,
+						     RAID5_STRIPE_SECTORS(conf),
 						     0);
 			sh->bm_seq = conf->seq_flush + 1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
@@ -5635,12 +5654,12 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		return true;
 	}
 
-	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
 	last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
-	for (;logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
+	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
 		int previous;
 		int seq;
 
@@ -5921,7 +5940,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	}
 
 	INIT_LIST_HEAD(&stripes);
-	for (i = 0; i < reshape_sectors; i += STRIPE_SECTORS) {
+	for (i = 0; i < reshape_sectors; i += RAID5_STRIPE_SECTORS(conf)) {
 		int j;
 		int skipped_disk = 0;
 		sh = raid5_get_active_stripe(conf, stripe_addr+i, 0, 0, 1);
@@ -5942,7 +5961,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 				skipped_disk = 1;
 				continue;
 			}
-			memset(page_address(sh->dev[j].page), 0, STRIPE_SIZE);
+			memset(page_address(sh->dev[j].page), 0, RAID5_STRIPE_SIZE(conf));
 			set_bit(R5_Expanded, &sh->dev[j].flags);
 			set_bit(R5_UPTODATE, &sh->dev[j].flags);
 		}
@@ -5977,7 +5996,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 		set_bit(STRIPE_EXPAND_SOURCE, &sh->state);
 		set_bit(STRIPE_HANDLE, &sh->state);
 		raid5_release_stripe(sh);
-		first_sector += STRIPE_SECTORS;
+		first_sector += RAID5_STRIPE_SECTORS(conf);
 	}
 	/* Now that the sources are clearly marked, we can release
 	 * the destination stripes
@@ -6083,11 +6102,12 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	if (!test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    !conf->fullsync &&
 	    !md_bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
-	    sync_blocks >= STRIPE_SECTORS) {
+	    sync_blocks >= RAID5_STRIPE_SECTORS(conf)) {
 		/* we can skip this block, and probably more */
-		sync_blocks /= STRIPE_SECTORS;
+		sync_blocks /= RAID5_STRIPE_SECTORS(conf);
 		*skipped = 1;
-		return sync_blocks * STRIPE_SECTORS; /* keep things rounded to whole stripes */
+		/* keep things rounded to whole stripes */
+		return sync_blocks * RAID5_STRIPE_SECTORS(conf);
 	}
 
 	md_bitmap_cond_end_sync(mddev->bitmap, sector_nr, false);
@@ -6120,7 +6140,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 
 	raid5_release_stripe(sh);
 
-	return STRIPE_SECTORS;
+	return RAID5_STRIPE_SECTORS(conf);
 }
 
 static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio,
@@ -6143,14 +6163,14 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio,
 	int handled = 0;
 
 	logical_sector = raid_bio->bi_iter.bi_sector &
-		~((sector_t)STRIPE_SECTORS-1);
+		~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
 	sector = raid5_compute_sector(conf, logical_sector,
 				      0, &dd_idx, NULL);
 	last_sector = bio_end_sector(raid_bio);
 
 	for (; logical_sector < last_sector;
-	     logical_sector += STRIPE_SECTORS,
-		     sector += STRIPE_SECTORS,
+	     logical_sector += RAID5_STRIPE_SECTORS(conf),
+		     sector += RAID5_STRIPE_SECTORS(conf),
 		     scnt++) {
 
 		if (scnt < offset)
@@ -6770,7 +6790,7 @@ static int alloc_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu
 			       conf->previous_raid_disks),
 			   max(conf->chunk_sectors,
 			       conf->prev_chunk_sectors)
-			   / STRIPE_SECTORS)) {
+			   / RAID5_STRIPE_SECTORS(conf))) {
 		free_scratch_buffer(conf, percpu);
 		return -ENOMEM;
 	}
@@ -6922,6 +6942,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	conf = kzalloc(sizeof(struct r5conf), GFP_KERNEL);
 	if (conf == NULL)
 		goto abort;
+
 	INIT_LIST_HEAD(&conf->free_list);
 	INIT_LIST_HEAD(&conf->pending_list);
 	conf->pending_data = kcalloc(PENDING_IO_MAX,
@@ -7073,8 +7094,8 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	conf->min_nr_stripes = NR_STRIPES;
 	if (mddev->reshape_position != MaxSector) {
 		int stripes = max_t(int,
-			((mddev->chunk_sectors << 9) / STRIPE_SIZE) * 4,
-			((mddev->new_chunk_sectors << 9) / STRIPE_SIZE) * 4);
+			((mddev->chunk_sectors << 9) / RAID5_STRIPE_SIZE(conf)) * 4,
+			((mddev->new_chunk_sectors << 9) / RAID5_STRIPE_SIZE(conf)) * 4);
 		conf->min_nr_stripes = max(NR_STRIPES, stripes);
 		if (conf->min_nr_stripes != NR_STRIPES)
 			pr_info("md/raid:%s: force stripe size %d for reshape\n",
@@ -7805,14 +7826,14 @@ static int check_stripe_cache(struct mddev *mddev)
 	 * stripe_heads first.
 	 */
 	struct r5conf *conf = mddev->private;
-	if (((mddev->chunk_sectors << 9) / STRIPE_SIZE) * 4
+	if (((mddev->chunk_sectors << 9) / RAID5_STRIPE_SIZE(conf)) * 4
 	    > conf->min_nr_stripes ||
-	    ((mddev->new_chunk_sectors << 9) / STRIPE_SIZE) * 4
+	    ((mddev->new_chunk_sectors << 9) / RAID5_STRIPE_SIZE(conf)) * 4
 	    > conf->min_nr_stripes) {
 		pr_warn("md/raid:%s: reshape: not enough stripes.  Needed %lu\n",
 			mdname(mddev),
 			((max(mddev->chunk_sectors, mddev->new_chunk_sectors) << 9)
-			 / STRIPE_SIZE)*4);
+			 / RAID5_STRIPE_SIZE(conf))*4);
 		return 0;
 	}
 	return 1;
@@ -8144,7 +8165,7 @@ static void *raid5_takeover_raid1(struct mddev *mddev)
 	while (chunksect && (mddev->array_sectors & (chunksect-1)))
 		chunksect >>= 1;
 
-	if ((chunksect<<9) < STRIPE_SIZE)
+	if ((chunksect<<9) < RAID5_STRIPE_SIZE((struct r5conf *)mddev->private))
 		/* array size does not allow a suitable chunk size */
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index f90e0704bed9..ca21f30e31da 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -481,23 +481,6 @@ struct disk_info {
 #define HASH_MASK		(NR_HASH - 1)
 #define MAX_STRIPE_BATCH	8
 
-/* bio's attached to a stripe+device for I/O are linked together in bi_sector
- * order without overlap.  There may be several bio's per stripe+device, and
- * a bio could span several devices.
- * When walking this list for a particular stripe+device, we must never proceed
- * beyond a bio that extends past this device, as the next bio might no longer
- * be valid.
- * This function is used to determine the 'next' bio in the list, given the
- * sector of the current stripe+device
- */
-static inline struct bio *r5_next_bio(struct bio *bio, sector_t sector)
-{
-	if (bio_end_sector(bio) < sector + STRIPE_SECTORS)
-		return bio->bi_next;
-	else
-		return NULL;
-}
-
 /* NOTE NR_STRIPE_HASH_LOCKS must remain below 64.
  * This is because we sometimes take all the spinlocks
  * and creating that much locking depth can cause
@@ -690,6 +673,26 @@ struct r5conf {
 	struct r5pending_data	*next_pending_data;
 };
 
+#define RAID5_STRIPE_SIZE(conf)       STRIPE_SIZE
+#define RAID5_STRIPE_SHIFT(conf)      STRIPE_SHIFT
+#define RAID5_STRIPE_SECTORS(conf)    STRIPE_SECTORS
+
+/* bio's attached to a stripe+device for I/O are linked together in bi_sector
+ * order without overlap.  There may be several bio's per stripe+device, and
+ * a bio could span several devices.
+ * When walking this list for a particular stripe+device, we must never proceed
+ * beyond a bio that extends past this device, as the next bio might no longer
+ * be valid.
+ * This function is used to determine the 'next' bio in the list, given the
+ * sector of the current stripe+device
+ */
+static inline struct bio *r5_next_bio(struct r5conf *conf, struct bio *bio, sector_t sector)
+{
+	if (bio_end_sector(bio) < sector + RAID5_STRIPE_SECTORS(conf))
+		return bio->bi_next;
+	else
+		return NULL;
+}
 
 /*
  * Our supported algorithms
-- 
2.25.4

