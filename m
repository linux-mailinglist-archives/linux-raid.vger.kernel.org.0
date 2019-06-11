Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3794A3C4BD
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbfFKHPy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 03:15:54 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:39378 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbfFKHPy (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Tue, 11 Jun 2019 03:15:54 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 11 Jun 2019 01:15:48 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH] md/raid10: read balance chooses idlest disk for SSD
Date:   Tue, 11 Jun 2019 15:33:11 +0800
Message-Id: <20190611073311.14120-1-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Andy reported that raid10 array with SSD disks has poor
read performance. Compared with raid1, RAID-1 can be 3x
faster than RAID-10 sometimes [1].

The thing is that raid10 chooses the low distance disk
for read request, however, the approach doesn't work
well for SSD device since it doesn't have spindle like
HDD, we should just read from the SSD which has less
pending IO like commit 9dedf60313fa4 ("md/raid1: read
balance chooses idlest disk for SSD").

So this commit selects the idlest SSD disk for read if
array has none rotational disk, otherwise, read_balance
uses the previous distance priority algorithm. With the
change, the performance of raid10 gets increased largely
per Andy's test [2].

[1]. https://marc.info/?l=linux-raid&m=155915890004761&w=2
[2]. https://marc.info/?l=linux-raid&m=155990654223786&w=2

Tested-by: Andy Smith <andy@strugglers.net>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 drivers/md/raid10.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index aea11476fee6..6e5721f2a074 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -737,15 +737,19 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 	int sectors = r10_bio->sectors;
 	int best_good_sectors;
 	sector_t new_distance, best_dist;
-	struct md_rdev *best_rdev, *rdev = NULL;
+	struct md_rdev *best_dist_rdev, *best_pending_rdev, *rdev = NULL;
 	int do_balance;
-	int best_slot;
+	int best_dist_slot, best_pending_slot;
+	int has_nonrot_disk = 0;
+	unsigned int min_pending;
 	struct geom *geo = &conf->geo;
 
 	raid10_find_phys(conf, r10_bio);
 	rcu_read_lock();
-	best_slot = -1;
-	best_rdev = NULL;
+	best_dist_slot = -1;
+	min_pending = UINT_MAX;
+	best_dist_rdev = NULL;
+	best_pending_rdev = NULL;
 	best_dist = MaxSector;
 	best_good_sectors = 0;
 	do_balance = 1;
@@ -767,6 +771,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		sector_t first_bad;
 		int bad_sectors;
 		sector_t dev_sector;
+		unsigned int pending;
+		bool nonrot;
 
 		if (r10_bio->devs[slot].bio == IO_BLOCKED)
 			continue;
@@ -803,8 +809,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 					first_bad - dev_sector;
 				if (good_sectors > best_good_sectors) {
 					best_good_sectors = good_sectors;
-					best_slot = slot;
-					best_rdev = rdev;
+					best_dist_slot = slot;
+					best_dist_rdev = rdev;
 				}
 				if (!do_balance)
 					/* Must read from here */
@@ -817,14 +823,23 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		if (!do_balance)
 			break;
 
-		if (best_slot >= 0)
+		nonrot = blk_queue_nonrot(bdev_get_queue(rdev->bdev));
+		has_nonrot_disk |= nonrot;
+		pending = atomic_read(&rdev->nr_pending);
+		if (min_pending > pending && nonrot) {
+			min_pending = pending;
+			best_pending_slot = slot;
+			best_pending_rdev = rdev;
+		}
+
+		if (best_dist_slot >= 0)
 			/* At least 2 disks to choose from so failfast is OK */
 			set_bit(R10BIO_FailFast, &r10_bio->state);
 		/* This optimisation is debatable, and completely destroys
 		 * sequential read speed for 'far copies' arrays.  So only
 		 * keep it for 'near' arrays, and review those later.
 		 */
-		if (geo->near_copies > 1 && !atomic_read(&rdev->nr_pending))
+		if (geo->near_copies > 1 && !pending)
 			new_distance = 0;
 
 		/* for far > 1 always use the lowest address */
@@ -833,15 +848,21 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		else
 			new_distance = abs(r10_bio->devs[slot].addr -
 					   conf->mirrors[disk].head_position);
+
 		if (new_distance < best_dist) {
 			best_dist = new_distance;
-			best_slot = slot;
-			best_rdev = rdev;
+			best_dist_slot = slot;
+			best_dist_rdev = rdev;
 		}
 	}
 	if (slot >= conf->copies) {
-		slot = best_slot;
-		rdev = best_rdev;
+		if (has_nonrot_disk) {
+			slot = best_pending_slot;
+			rdev = best_pending_rdev;
+		} else {
+			slot = best_dist_slot;
+			rdev = best_dist_rdev;
+		}
 	}
 
 	if (slot >= 0) {
-- 
2.12.3

