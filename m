Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9CEC494
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfKAOXS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44913 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKAOXR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id b18so7659131edr.11
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F0U4PFvKZb/yjORrfhpidHQkuvI11s+zyZ1RW+HCHVM=;
        b=HhkhfXG7oScfVfuda018Am1wjDMiSkeENdmY6naX9wrWW9VLP0Byx6LHSryk8cqBaf
         3gP+IQgG/wdDHHs9pstBH8r8cSIoxtPIxOYkx5Y/opH8xOvptakGYHsL85AD9JvPQwzf
         FfzEU8l61MwgoG/I9ZGQBBQMHT5EbNwLzfk0+nekg5Ksy0sT0u9vB0kLoU3ncfrQe7Fj
         5pQsUN7y4aWRg5tTN08Y30rifUiXZNHtEvp2ZCwS1QZw9GeXLHHtG8mbSelwVeDBNrOY
         znUBCP9yzvYGN6yiBxWwvatsUClnga5pdB7hixnyK02DCRqvyttt82zrUzExADy0fBjd
         0tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F0U4PFvKZb/yjORrfhpidHQkuvI11s+zyZ1RW+HCHVM=;
        b=FwobYMmahSliejyroDa3aOyrbo/kvzp8gyrjFkiIAwjpSksD4Zor80zTz9U4I99RjG
         Lc1VUPPm6DdwqZDrhZEZO3W3y5P+WNaki5lzpJHzgmIAMZYd3isjWNFZsfjqCKIZg6/S
         /272m5Kj9ur8UIttri7BYfCO79wZB3l5xg6Rj/a4HCrfQe7cox5ic0B0d99RCXsAtcAS
         xnviw4SaBDdOI9vM+wuZHWQTEhMpUrzDjK71KFJmEE5UL6lj+jFUSzC5jjFZ2yaSBiP9
         AkwUP5DQ6DSa0R+Xrv9vbGayIipwjLBLtJD9Rho7Qkdvl50Ryne5N+JVGeghDR4uJTU+
         mP7w==
X-Gm-Message-State: APjAAAX8LCFv5d/9B9vm+KfNuUNBHAsrpuA98pas5aUsFldyEU80+653
        TKlyRG0cU/D/O2FI8ZvBySk=
X-Google-Smtp-Source: APXvYqxR30TZAPa4edvKAN/BzJClDjI+4wpVeyM7zjth09qcjzwB7enPuTdi9oNeuqYwWh17vvKz3g==
X-Received: by 2002:aa7:dc1a:: with SMTP id b26mr12933225edu.139.1572618195767;
        Fri, 01 Nov 2019 07:23:15 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:14 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 8/8] md/raid1: introduce wait_for_serialization
Date:   Fri,  1 Nov 2019 15:22:31 +0100
Message-Id: <20191101142231.23359-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Previously, we call check_and_add_serial when serialization is
enabled for write IO, but it could allocate and free memory
back and forth.

Now, let's just get an element from memory pool with the new
function, then insert node to rb tree if no collision happens.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid1.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 08568edc1c5d..b1760930c73a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -158,33 +158,41 @@ find_overlap(struct rb_root *root, sector_t sector, unsigned long size)
 	return overlap;
 }
 
-static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
+static int check_and_add_serial(struct md_rdev *rdev, struct r1bio *r1_bio,
+				struct serial_info *wi, int idx)
 {
-	struct serial_info *wi;
 	unsigned long flags;
 	int ret = 0;
-	unsigned long size = (hi - lo) << 9;
-	struct mddev *mddev = rdev->mddev;
-	int idx = sector_to_idx(lo);
-
-	wi = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
+	sector_t lo = r1_bio->sector;
+	unsigned int size = r1_bio->sectors << 9;
 
 	spin_lock_irqsave(&rdev->serial_rb_lock[idx], flags);
 	/* collision happened */
 	if (find_overlap(&rdev->serial_rb[idx], lo, size))
 		ret = -EBUSY;
-
-	if (!ret) {
+	else {
 		wi->sector = lo;
 		wi->size = size;
 		insert_interval(&rdev->serial_rb[idx], wi);
-	} else
-		mempool_free(wi, mddev->serial_info_pool);
+	}
 	spin_unlock_irqrestore(&rdev->serial_rb_lock[idx], flags);
 
 	return ret;
 }
 
+static void wait_for_serialization(struct md_rdev *rdev, struct r1bio *r1_bio)
+{
+	struct mddev *mddev = rdev->mddev;
+	struct serial_info *wi;
+	int idx = sector_to_idx(r1_bio->sector);
+
+	if (WARN_ON(!mddev->serial_info_pool))
+		return;
+	wi = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
+	wait_event(rdev->serial_io_wait[idx],
+		   check_and_add_serial(rdev, r1_bio, wi, idx) == 0);
+}
+
 static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
 	struct serial_info *wi;
@@ -1439,8 +1447,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
-	sector_t lo, hi;
-	int idx = sector_to_idx(bio->bi_iter.bi_sector);
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1468,8 +1474,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
-	lo = r1_bio->sector;
-	hi = r1_bio->sector + r1_bio->sectors;
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
@@ -1614,14 +1618,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 		if (r1_bio->behind_master_bio) {
 			if (test_bit(CollisionCheck, &rdev->flags))
-				wait_event(rdev->serial_io_wait[idx],
-					   check_and_add_serial(rdev, lo, hi)
-					   == 0);
+				wait_for_serialization(rdev, r1_bio);
 			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
 		} else if (mddev->serialize_policy)
-			wait_event(rdev->serial_io_wait[idx],
-				   check_and_add_serial(rdev, lo, hi) == 0);
+			wait_for_serialization(rdev, r1_bio);
 
 		r1_bio->bios[i] = mbio;
 
-- 
2.17.1

