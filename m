Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32A21375D
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCJNN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jul 2020 05:13:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:58660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCJNN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 3 Jul 2020 05:13:13 -0400
IronPort-SDR: f5LQcPGtbJM2QuKZiBSULnIDJqXDpfA4M9n1c4Xp4Bo7zmXwk/Er8wLrBuHpXLmEUF9iGcH7Mr
 Bc6GhnMy63ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144643077"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="144643077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 02:13:12 -0700
IronPort-SDR: vkjYZm5cT6gDHfq8s4cjm06CeY/ipR4m5ZbltJhDFEN+Ol8mxw/9+b4qXo4SUq9KSzgmt0ITFM
 t03eAhn5bi0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="322368047"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2020 02:13:11 -0700
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, guoqing.jiang@cloud.ionos.com,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: [PATCH v4] md: improve io stats accounting
Date:   Fri,  3 Jul 2020 11:13:09 +0200
Message-Id: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
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

This patch attempts to fix this by using both disk_start_io_acct() and
disk_end_io_acct(). To make it possible, a struct md_io is allocated for
every new md bio, which includes the io start_time. A new mempool is
introduced for this purpose. We override bio->bi_end_io with our own
callback and call disk_start_io_acct() before passing the bio to
md_handle_request(). When it completes, we call disk_end_io_acct() and
the original bi_end_io callback.

This adds correct statistics about in-flight IOs and IO processing time,
interpreted e.g. in iostat as await, svctm, aqu-sz and %util.

It also fixes a situation where too many IOs where reported if a bio was
re-submitted to the mddev, because io accounting is now performed only
on newly arriving bios.

Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
---
v4:
- Use disk_{start,end}_io_acct() instead of bio_{start,end}_io_acct() to
  pass mddev->gendisk directly, not bio->bi_disk which gets modified by
  some personalities.

v3:
- Use bio_start_io_acct() return value for md_io->start_time (thanks
  Guoqing!)

v2:
- Just override the bi_end_io without having to clone the original bio.
- Rebased onto latest md-next.

 drivers/md/md.c | 57 ++++++++++++++++++++++++++++++++++++++-----------
 drivers/md/md.h |  1 +
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8bb69c61afe0..63aeebd9266b 100644
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
+	disk_end_io_acct(mddev->gendisk, bio_op(bio), md_io->start_time);
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
@@ -488,21 +509,27 @@ static blk_qc_t md_submit_bio(struct bio *bio)
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
+		md_io->start_time = disk_start_io_acct(mddev->gendisk,
+						       bio_sectors(bio),
+						       bio_op(bio));
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
 
@@ -5545,6 +5572,7 @@ static void md_free(struct kobject *ko)
 
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	mempool_exit(&mddev->md_io_pool);
 	kfree(mddev);
 }
 
@@ -5640,6 +5668,11 @@ static int md_alloc(dev_t dev, char *name)
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

