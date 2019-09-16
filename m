Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29356B3F7D
	for <lists+linux-raid@lfdr.de>; Mon, 16 Sep 2019 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfIPRPX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Sep 2019 13:15:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIPRPX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Sep 2019 13:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93CA18A1C8A;
        Mon, 16 Sep 2019 17:15:22 +0000 (UTC)
Received: from redhat (ovpn-117-73.phx2.redhat.com [10.3.117.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 049655D9E5;
        Mon, 16 Sep 2019 17:15:18 +0000 (UTC)
Date:   Mon, 16 Sep 2019 13:15:14 -0400
From:   David Jeffery <djeffery@redhat.com>
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid@vger.kernel.org, ncroxon@redhat.com, heinzm@redhat.com,
        neilb@suse.de, songliubraving@fb.com
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
Message-ID: <20190916171514.GA1970@redhat>
References: <1568627145-14210-1-git-send-email-xni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568627145-14210-1-git-send-email-xni@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Mon, 16 Sep 2019 17:15:22 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Calling md_handle_request is certainly the simplest way to fix the issue,
but after more thought I don't think it's the best way.  When the code gets
to md_flush_request, the code already has md_handle_request and the raid
driver's make_request function in the stack.

To fix the lost I/O, instead of recursing back into md_handle_request we
can pass back a bool to indicate if the original make_request call should
continue to handle the I/O and instead of assuming the flush logic will
push it to completion.

This patch converts md_flush_request to return a bool and no longer calls
the raid driver's make_request function.  If the return is true, then the
md flush logic has or will complete the bio and the md make_request call
is done.  If false, then the md make_request function needs to keep
processing like it is a normal I/O carrying bio. Let the original call to
md_handle_request handle any need to retry sending the bio to the raid
driver's make_request function should it be needed.

This also marks md_flush_request and the make_request function pointer as
__must_check to issue warnings should these critical return values be
ignored.


Signed-of-by: David Jeffery <djeffery@redhat.com>


diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 7354466ddc90..afcf1d388300 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -244,10 +244,9 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 	sector_t start_sector, end_sector, data_offset;
 	sector_t bio_sector = bio->bi_iter.bi_sector;
 
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
-		md_flush_request(mddev, bio);
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
 		return true;
-	}
 
 	tmp_dev = which_dev(mddev, bio_sector);
 	start_sector = tmp_dev->end_sector - tmp_dev->rdev->sectors;
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 6780938d2991..152f9e65a226 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -104,10 +104,9 @@ static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
 	struct multipath_bh * mp_bh;
 	struct multipath_info *multipath;
 
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
-		md_flush_request(mddev, bio);
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
 		return true;
-	}
 
 	mp_bh = mempool_alloc(&conf->pool, GFP_NOIO);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..d2c23f7b1008 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -545,7 +545,13 @@ static void md_submit_flush_data(struct work_struct *ws)
 	}
 }
 
-void md_flush_request(struct mddev *mddev, struct bio *bio)
+/*
+ * Manages consolidation of flushes and submitting any flushes needed for
+ * a bio with REQ_PREFLUSH.  Returns true if the bio is finished or is
+ * being finished in another context.  Returns false if the flushing is
+ * complete but still needs the I/O portion of the bio to be processed.
+ */
+bool md_flush_request(struct mddev *mddev, struct bio *bio)
 {
 	ktime_t start = ktime_get_boottime();
 	spin_lock_irq(&mddev->lock);
@@ -570,9 +576,10 @@ void md_flush_request(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 		else {
 			bio->bi_opf &= ~REQ_PREFLUSH;
-			mddev->pers->make_request(mddev, bio);
+			return false;
 		}
 	}
+	return true;
 }
 EXPORT_SYMBOL(md_flush_request);
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..70d1dddf410b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -543,7 +543,7 @@ struct md_personality
 	int level;
 	struct list_head list;
 	struct module *owner;
-	bool (*make_request)(struct mddev *mddev, struct bio *bio);
+	bool __must_check (*make_request)(struct mddev *mddev, struct bio *bio);
 	/*
 	 * start up works that do NOT require md_thread. tasks that
 	 * requires md_thread should go into start()
@@ -696,7 +696,7 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
 
 extern int mddev_congested(struct mddev *mddev, int bits);
-extern void md_flush_request(struct mddev *mddev, struct bio *bio);
+extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
 extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 			   sector_t sector, int size, struct page *page);
 extern int md_super_wait(struct mddev *mddev);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index bf5cf184a260..2071437b80ca 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -554,10 +554,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 	unsigned chunk_sects;
 	unsigned sectors;
 
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
-		md_flush_request(mddev, bio);
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
 		return true;
-	}
 
 	if (unlikely((bio_op(bio) == REQ_OP_DISCARD))) {
 		raid0_handle_discard(mddev, bio);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 34e26834ad28..576c02eae286 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1562,10 +1562,9 @@ static bool raid1_make_request(struct mddev *mddev, struct bio *bio)
 {
 	sector_t sectors;
 
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
-		md_flush_request(mddev, bio);
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
 		return true;
-	}
 
 	/*
 	 * There is a limit to the maximum size, but
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8a1354a08a1a..c5c134b3868b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1523,10 +1523,9 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
 	int chunk_sects = chunk_mask + 1;
 	int sectors = bio_sectors(bio);
 
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
-		md_flush_request(mddev, bio);
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
 		return true;
-	}
 
 	if (!md_write_start(mddev, bio))
 		return false;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3de4e13bde98..ce935e95e32f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5584,8 +5584,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		if (ret == 0)
 			return true;
 		if (ret == -ENODEV) {
-			md_flush_request(mddev, bi);
-			return true;
+			if (md_flush_request(mddev, bi))
+				return true;
 		}
 		/* ret == -EAGAIN, fallback */
 		/*

