Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C138FE18
	for <lists+linux-raid@lfdr.de>; Tue, 25 May 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhEYJse (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 25 May 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhEYJsc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 25 May 2021 05:48:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B1C06138A
        for <linux-raid@vger.kernel.org>; Tue, 25 May 2021 02:47:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d78so22304254pfd.10
        for <linux-raid@vger.kernel.org>; Tue, 25 May 2021 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tw4M6gEPQOsixjCUXirsw/W+7GHN6rY65wWBt9QcAj8=;
        b=k4LcO1MJ1S18JJCmy6fAYfS3wu7KNSNuLDs83xdUmFV7uQZuyVv9GiUtgOtgpsgQkV
         EVhUFTKnk8jNuZcpMGD/vLNGarMMEUvYQiJgurcYsDI33Hdt0CUfgGSP/cEdq3Bvm5K9
         03fWEKxD86oUIm8OAib/9s/0ip0LtJGMfx7xnZFfcNK6NFSCRVPbP9D6pBJSidiB15hT
         5wU/02kXNeC+3WPb5WbSnp0Qai/dyIUr+UVPDvng/vaWfEbQgB5RPKJxn9kradJk8l6/
         u6A00RxN47+xg+8AXoji1ZFVdIo+CG9MrZc44AUjIiyFYI1PS+HOFgFX1Jh8os4Ymhjq
         k8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tw4M6gEPQOsixjCUXirsw/W+7GHN6rY65wWBt9QcAj8=;
        b=L8eQ1QmbCRZQZyxb1KyL8ckHXdUm60NbYN0TFaOonmqTJVAj5miYFQHHpcLn3zXeAX
         +nBEW8gt7pzTMxBANHNpNbrYN1dUHiDDEg7958ura6eprqiysuXa7jq1GziEkNhUJDQO
         2DaKCKYWkf3w6VBH5NKTavR6zVuGrIYOcVu8xHFg4ZOiPmCOmccUw2bPDOYdQAmI1+MS
         OAUXZ2hI4o/LulHdJ2z1yL9sTf4ppqGKORbFklRON1Qu7V1P4dM9WqaRThzDPddmYJdT
         UMdHw/WvltIZLD/phRO70Dxirm5DFnvv7rA95aNvtx4U5zYe3PYmJK6grfRhe8Xjo4Fd
         OjYQ==
X-Gm-Message-State: AOAM532HF9yUKS2sp/m2fnyjnPhx4wZc4Sg8tWHUylHmyKASkO1R4yF0
        mfjEMgRuV8yyd2TYg1/S5rk=
X-Google-Smtp-Source: ABdhPJzVxQ6Hd+fFlNh8ILzCX1KwLhPw4JtlDDpbQiL/PFYjS+DDWkPua9xHu0AEoPpBPw49AgLTqw==
X-Received: by 2002:a63:ce4f:: with SMTP id r15mr17968916pgi.387.1621936020574;
        Tue, 25 May 2021 02:47:00 -0700 (PDT)
Received: from localhost.localdomain ([89.187.161.155])
        by smtp.gmail.com with ESMTPSA id r10sm13114437pfl.159.2021.05.25.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:47:00 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <jiangguoqing@kylinos.cn>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, artur.paszkiewicz@intel.com,
        hch@infradead.org
Subject: [PATCH V3 2/8] md: add io accounting for raid0 and raid5
Date:   Tue, 25 May 2021 17:46:17 +0800
Message-Id: <20210525094623.763195-3-jiangguoqing@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525094623.763195-1-jiangguoqing@kylinos.cn>
References: <20210525094623.763195-1-jiangguoqing@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We introduce a new bioset (io_acct_set) for raid0 and raid5 since they
don't own clone infrastructure to accounting io. And the bioset is added
to mddev instead of to raid0 and raid5 layer, because with this way, we
can put common functions to md.h and reuse them in raid0 and raid5.

Also struct md_io_acct is added accordingly which includes io start_time,
the origin bio and cloned bio. Then we can call bio_{start,end}_io_acct
to get related io status.

Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
 drivers/md/md.c    | 44 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/md/md.h    |  8 ++++++++
 drivers/md/raid0.c |  3 +++
 drivers/md/raid5.c |  9 +++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7ba00e4c862d..87786f180525 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2340,7 +2340,8 @@ int md_integrity_register(struct mddev *mddev)
 			       bdev_get_integrity(reference->bdev));
 
 	pr_debug("md: data integrity enabled on %s\n", mdname(mddev));
-	if (bioset_integrity_create(&mddev->bio_set, BIO_POOL_SIZE)) {
+	if (bioset_integrity_create(&mddev->bio_set, BIO_POOL_SIZE) ||
+	    bioset_integrity_create(&mddev->io_acct_set, BIO_POOL_SIZE)) {
 		pr_err("md: failed to create integrity pool for %s\n",
 		       mdname(mddev));
 		return -EINVAL;
@@ -5569,6 +5570,7 @@ static void md_free(struct kobject *ko)
 
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 	kfree(mddev);
 }
 
@@ -5864,6 +5866,12 @@ int md_run(struct mddev *mddev)
 		if (err)
 			return err;
 	}
+	if (!bioset_initialized(&mddev->io_acct_set)) {
+		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
+				  offsetof(struct md_io_acct, bio_clone), 0);
+		if (err)
+			return err;
+	}
 
 	spin_lock(&pers_lock);
 	pers = find_pers(mddev->level, mddev->clevel);
@@ -6041,6 +6049,7 @@ int md_run(struct mddev *mddev)
 abort:
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
@@ -6264,6 +6273,7 @@ void md_stop(struct mddev *mddev)
 	__md_stop(mddev);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 }
 
 EXPORT_SYMBOL_GPL(md_stop);
@@ -8568,6 +8578,38 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
+static void md_end_io_acct(struct bio *bio)
+{
+	struct md_io_acct *md_io_acct = bio->bi_private;
+	struct bio *orig_bio = md_io_acct->orig_bio;
+
+	orig_bio->bi_status = bio->bi_status;
+
+	bio_end_io_acct(orig_bio, md_io_acct->start_time);
+	bio_put(bio);
+	bio_endio(orig_bio);
+}
+
+/* used by personalities (raid0 and raid5) to account io stats */
+void md_account_bio(struct mddev *mddev, struct bio **bio)
+{
+	struct md_io_acct *md_io_acct;
+	struct bio *clone;
+
+	if (!blk_queue_io_stat((*bio)->bi_bdev->bd_disk->queue))
+		return;
+
+	clone = bio_clone_fast(*bio, GFP_NOIO, &mddev->io_acct_set);
+	md_io_acct = container_of(clone, struct md_io_acct, bio_clone);
+	md_io_acct->orig_bio = *bio;
+	md_io_acct->start_time = bio_start_io_acct(*bio);
+
+	clone->bi_end_io = md_end_io_acct;
+	clone->bi_private = md_io_acct;
+	*bio = clone;
+}
+EXPORT_SYMBOL_GPL(md_account_bio);
+
 /* md_allow_write(mddev)
  * Calling this ensures that the array is marked 'active' so that writes
  * may proceed without blocking.  It is important to call this before
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 4da240ffe2c5..4191f22acce4 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -487,6 +487,7 @@ struct mddev {
 	struct bio_set			sync_set; /* for sync operations like
 						   * metadata and bitmap writes
 						   */
+	struct bio_set			io_acct_set; /* for raid0 and raid5 io accounting */
 
 	/* Generic flush handling.
 	 * The last to finish preflush schedules a worker to submit
@@ -683,6 +684,12 @@ struct md_thread {
 	void			*private;
 };
 
+struct md_io_acct {
+	struct bio *orig_bio;
+	unsigned long start_time;
+	struct bio bio_clone;
+};
+
 #define THREAD_WAKEUP  0
 
 static inline void safe_put_page(struct page *p)
@@ -714,6 +721,7 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
 void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 			struct bio *bio, sector_t start, sector_t size);
+void md_account_bio(struct mddev *mddev, struct bio **bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
 extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index e5d7411cba9b..62c8b6adac70 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -546,6 +546,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 		bio = split;
 	}
 
+	if (bio->bi_pool != &mddev->bio_set)
+		md_account_bio(mddev, &bio);
+
 	orig_sector = sector;
 	zone = find_zone(mddev->private, &sector);
 	switch (conf->layout) {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 841e1c1aa5e6..58e9dbc0f683 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5468,6 +5468,7 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 	sector_t sector = raid_bio->bi_iter.bi_sector;
 	unsigned chunk_sects = mddev->chunk_sectors;
 	unsigned sectors = chunk_sects - (sector & (chunk_sects-1));
+	struct r5conf *conf = mddev->private;
 
 	if (sectors < bio_sectors(raid_bio)) {
 		struct r5conf *conf = mddev->private;
@@ -5477,6 +5478,9 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 		raid_bio = split;
 	}
 
+	if (raid_bio->bi_pool != &conf->bio_split)
+		md_account_bio(mddev, &raid_bio);
+
 	if (!raid5_read_one_chunk(mddev, raid_bio))
 		return raid_bio;
 
@@ -5756,6 +5760,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	DEFINE_WAIT(w);
 	bool do_prepare;
 	bool do_flush = false;
+	bool do_clone = false;
 
 	if (unlikely(bi->bi_opf & REQ_PREFLUSH)) {
 		int ret = log_handle_flush_request(conf, bi);
@@ -5784,6 +5789,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	if (rw == READ && mddev->degraded == 0 &&
 	    mddev->reshape_position == MaxSector) {
 		bi = chunk_aligned_read(mddev, bi);
+		do_clone = true;
 		if (!bi)
 			return true;
 	}
@@ -5798,6 +5804,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 
+	if (!do_clone)
+		md_account_bio(mddev, &bi);
+
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
 		int previous;
-- 
2.25.1

