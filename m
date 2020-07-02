Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93627212648
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgGBO3s (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 10:29:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:9999 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgGBO3r (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 10:29:47 -0400
IronPort-SDR: sqQ3PM2lttpm2jx6aXhfEUjqkd9vHtAthTXQvhVF/8atpKgUrv7/ihd1FdctSkPaaslpoIcdn+
 lX/sz16CpmCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="211955153"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="211955153"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 07:29:34 -0700
IronPort-SDR: bmAgLmNR+wM9Sk7df7aK7BGwQeitI/CpImrAwXcfHrF/3AIxz4gN0fSTB15qJ40gVNJn6lQSTg
 dwt1Ho4lOkMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="278138601"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 07:29:29 -0700
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, guoqing.jiang@cloud.ionos.com,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: [PATCH v3] md: improve io stats accounting
Date:   Thu,  2 Jul 2020 16:29:26 +0200
Message-Id: <20200702142926.4419-1-artur.paszkiewicz@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Use generic io accounting functions to manage io stats. There was an
attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
stats accounting functions to simplify io stat accounting"), but it did
not include a call to generic_end_io_acct() and caused issues with
tracking in-flight IOs, so it was later removed in commit 74672d069b29
("md: fix md io stats accounting broken").

This patch attempts to fix this by using both bio_start_io_acct() and
bio_end_io_acct(). To make it possible, a struct md_io is allocated for
every new md bio, which includes the io start_time. A new mempool is
introduced for this purpose. We override bio->bi_end_io with our own
callback and call bio_start_io_acct() before passing the bio to
md_handle_request(). When it completes, we call bio_end_io_acct() and
the original bi_end_io callback.

This adds correct statistics about in-flight IOs and IO processing time,
interpreted e.g. in iostat as await, svctm, aqu-sz and %util.

It also fixes a situation where too many IOs where reported if a bio was
re-submitted to the mddev, because io accounting is now performed only
on newly arriving bios.

Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
---
v3:
- Use bio_start_io_acct() return value for md_io->start_time (thanks
  Guoqing!)

v2:
- Just override the bi_end_io without having to clone the original bio.
- Rebased onto latest md-next.

 drivers/md/md.c | 55 ++++++++++++++++++++++++++++++++++++++-----------
 drivers/md/md.h |  1 +
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8bb69c61afe0..dfbb63f38ad9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -463,12 +463,33 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 }
 EXPORT_SYMBOL(md_handle_request);
 
+struct md_io {
+	struct mddev *mddev;
+	bio_end_io_t *orig_bi_end_io;
+	void *orig_bi_private;
+	unsigned long start_time;
+};
+
+static void md_end_io(struct bio *bio)
+{
+	struct md_io *md_io = bio->bi_private;
+	struct mddev *mddev = md_io->mddev;
+
+	bio_end_io_acct(bio, md_io->start_time);
+
+	bio->bi_end_io = md_io->orig_bi_end_io;
+	bio->bi_private = md_io->orig_bi_private;
+
+	mempool_free(md_io, &mddev->md_io_pool);
+
+	if (bio->bi_end_io)
+		bio->bi_end_io(bio);
+}
+
 static blk_qc_t md_submit_bio(struct bio *bio)
 {
 	const int rw = bio_data_dir(bio);
-	const int sgrp = op_stat_group(bio_op(bio));
 	struct mddev *mddev = bio->bi_disk->private_data;
-	unsigned int sectors;
 
 	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
 		bio_io_error(bio);
@@ -488,21 +509,25 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	/*
-	 * save the sectors now since our bio can
-	 * go away inside make_request
-	 */
-	sectors = bio_sectors(bio);
+	if (bio->bi_end_io != md_end_io) {
+		struct md_io *md_io;
+
+		md_io = mempool_alloc(&mddev->md_io_pool, GFP_NOIO);
+		md_io->mddev = mddev;
+		md_io->orig_bi_end_io = bio->bi_end_io;
+		md_io->orig_bi_private = bio->bi_private;
+
+		bio->bi_end_io = md_end_io;
+		bio->bi_private = md_io;
+
+		md_io->start_time = bio_start_io_acct(bio);
+	}
+
 	/* bio could be mergeable after passing to underlayer */
 	bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 
-	part_stat_lock();
-	part_stat_inc(&mddev->gendisk->part0, ios[sgrp]);
-	part_stat_add(&mddev->gendisk->part0, sectors[sgrp], sectors);
-	part_stat_unlock();
-
 	return BLK_QC_T_NONE;
 }
 
@@ -5545,6 +5570,7 @@ static void md_free(struct kobject *ko)
 
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	mempool_exit(&mddev->md_io_pool);
 	kfree(mddev);
 }
 
@@ -5640,6 +5666,11 @@ static int md_alloc(dev_t dev, char *name)
 		 */
 		mddev->hold_active = UNTIL_STOP;
 
+	error = mempool_init_kmalloc_pool(&mddev->md_io_pool, BIO_POOL_SIZE,
+					  sizeof(struct md_io));
+	if (error)
+		goto abort;
+
 	error = -ENOMEM;
 	mddev->queue = blk_alloc_queue(NUMA_NO_NODE);
 	if (!mddev->queue)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 612814d07d35..c26fa8bd41e7 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -481,6 +481,7 @@ struct mddev {
 	struct bio_set			sync_set; /* for sync operations like
 						   * metadata and bitmap writes
 						   */
+	mempool_t			md_io_pool;
 
 	/* Generic flush handling.
 	 * The last to finish preflush schedules a worker to submit
-- 
2.26.0

