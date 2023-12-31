Return-Path: <linux-raid+bounces-280-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7C820CA2
	for <lists+linux-raid@lfdr.de>; Sun, 31 Dec 2023 20:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF4F1C215F6
	for <lists+linux-raid@lfdr.de>; Sun, 31 Dec 2023 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57499B667;
	Sun, 31 Dec 2023 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkDyMq9V"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E9B64C
	for <linux-raid@vger.kernel.org>; Sun, 31 Dec 2023 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704049887; x=1735585887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u3q7yWvJAedRsdJcroMWjnADpn7M2DZkSyKU7rcRiV8=;
  b=GkDyMq9VAYQViR/GJPUN8ZZ9vCgT7cUfdesDNw0JzVtgi1wXDaDViSd3
   ey3A9XrsuXgItC5I7ItcwrDru27a/degIg1PqF8/u4/EqhDJ+3wlelMoI
   Mc59R/Iuzi8PuL59PWttYUprMJDZt/ZYk1JBjqRYzTH5AiLc3Anmh+dEB
   Ko/3wQEpfAvcuaEXMD4S2HVGUHv8STiCezI60ev4+JLcyF+w2o65kR3zM
   JOQKCnGci6RYLsly/qk5xxvgCO/4muYUY8ZjKodHqAZ+Pwa0BIIw/DWdc
   oljp1WZumY1NQoN8Zr5O9MQHaKmKyO3LPKxXkC9H44vnPNrAqlMlv3Z+W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="396494997"
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="396494997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 11:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="27658600"
Received: from abjones1-mobl.amr.corp.intel.com (HELO peluse-desk5.intel.com) ([10.209.128.206])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 11:11:26 -0800
From: paul luse <paul.e.luse@linux.intel.com>
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	paul luse <paul.e.luse@linux.intel.com>
Subject: [PATCH] md/raid1: round robin disk selection for large sequential reads
Date: Sat, 16 Dec 2023 23:48:14 -0800
Message-ID: <20231217074814.122713-1-paul.e.luse@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Everyone,

I’m sending this out as an RFC with some comments below.  Hope
that’s OK, note that this is my first patch for mdraid but the
first time I’ve ever even looked at any of the code so please
keep that in mind :) Would be great if others had a chance to
test on their setups with their favorite disks or if you have
disk manufacturer/model suggestions please me know.

Quick background: A colleague of mine ran a short test with
biotop running random reads on a 2 disk array and noticed an
approximate 70/30 distribution of reads between the 2 drives.
He asked me if the was normal and, not knowing this RAID stack,
I said I don’t know but I’ll have a look.  As a quick hack I
threw out pretty much the whole function and forced a 50/50
distribution on got impressive gains on large sequential IO, it
was enough that I decided to start working on it for real.

This RFC patch adds more complexity to an already fairly complex
function I think but I don’t see a simple refactor and most of
the additions are compartmentalized at the end.  The concept is
simple, round robin the available disks on sequential reads
(doesn’t work well for non-sequential) switching to the next disk
after a specified number of bytes have been read from the current
disk (empirically determined).  To reduce testing the patch only
supports doing round robin selection for 2 mirror sets or less.
More could be supported likely adjusting the threshold for moving
to the next disk based on the number of mirrors.

Additionally, I think I can optimize the read/write mix cases as
well but didn’t want to hold off any longer on getting the RFC out.

I am also gathering more performance data on other drivs.  Here is
what I have available now on Google Photos:

Kioxia CM7: https://photos.app.goo.gl/TpS8wH1rCtnwLVLw9
Intel P5520: https://photos.app.goo.gl/zGBPFT7mJCXdoU8h6

Comments:

* There a subtle bug fix in here that if everyone agrees on the
patch direction I’ll break it out into a separate patch.  We used
to set R1BIO_FailFast without really knowing if there is more than
1 available disks.  Discussed this on slack, it’s fairly clear. To
fix this, there are no more breaks in the loop, we always loop
through all disks counting available ones and storing key parameters
that were set to their last value as a result of the break.

* This patch also needs the “loop through all disks” fix above
because we can’t round robin unless we know we have enough disks

* There’s a potential bug in the sequential condition, I removed the
entire block of code as it’s no longer relevant with the round robin
logic (the section about choose_next_idle).  This was discussed a
bit on slack, there was a questionable comparison
`mirror->next_seq_sect > opt_iosize`

* There’s nothing really tricky going on here, the one thing that
might not be super obvious is how we round robin, we start on the
current disk and store it’s index in the mirrors[] array so that we
can find the next one on the next call to read_balance.  We have to
select the index into the array as opposed to `best_disk` as that can
be at any position in the array depending on the state of the array.

thanks,
Paul

Signed-off-by: paul luse <paul.e.luse@linux.intel.com>
---
 drivers/md/raid1.c | 107 +++++++++++++++++++++++++++++++--------------
 drivers/md/raid1.h |   6 +++
 2 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index aaa434f0c175..3ecb90a29053 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -596,6 +596,9 @@ static sector_t align_to_barrier_unit_end(sector_t start_sector,
  *
  * The rdev for the device selected will have nr_pending incremented.
  */
+#define MAX_RR_DISKS 3
+#define RR_16K_IN_SECS 0x20
+#define RR_128K_IN_SECS 0x100
 static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sectors)
 {
 	const sector_t this_sector = r1_bio->sector;
@@ -608,7 +611,9 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	unsigned int min_pending;
 	struct md_rdev *rdev;
 	int choose_first;
-	int choose_next_idle;
+	int avail_disk[MAX_RR_DISKS * 2];
+	int avail_disks, choose_first_disk, any_pending, best_index;
+	bool sequential;
 
 	/*
 	 * Check if we can balance. We can balance on the whole
@@ -624,7 +629,10 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
 	has_nonrot_disk = 0;
-	choose_next_idle = 0;
+	avail_disks = 0;
+	any_pending = 0;
+	choose_first_disk = -1;
+	sequential = false;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
 	if ((conf->mddev->recovery_cp < this_sector + sectors) ||
@@ -664,6 +672,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 					best_good_sectors = sectors;
 				best_dist_disk = disk;
 				best_pending_disk = disk;
+				avail_disk[avail_disks++] = disk;
 			}
 			continue;
 		}
@@ -692,8 +701,16 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 					best_good_sectors = good_sectors;
 					best_disk = disk;
 				}
-				if (choose_first)
-					break;
+				if (choose_first) {
+					/* As we need to loop through all disks and in some cases
+					 * we know we want to use the first, set it so that
+					 * best_disk doesn't get updated in subsequent loop
+					 * iterations.
+					 */
+					if (choose_first_disk == -1)
+						choose_first_disk = best_disk;
+					continue;
+				}
 			}
 			continue;
 		} else {
@@ -709,44 +726,30 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		nonrot = bdev_nonrot(rdev->bdev);
 		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
+		any_pending |= pending;
+		avail_disk[avail_disks++] = disk;
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
 		if (choose_first) {
 			best_disk = disk;
-			break;
+			if (choose_first_disk == -1)
+				choose_first_disk = best_disk;
+			continue;
 		}
-		/* Don't change to another disk for sequential reads */
+		/* For sequential reads, we round robin available disks assuming
+		 * all other conditions are met to make this viable. See below for
+		 * more info.
+		 */
 		if (conf->mirrors[disk].next_seq_sect == this_sector
 		    || dist == 0) {
-			int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
-			struct raid1_info *mirror = &conf->mirrors[disk];
 
+			sequential = true;
+			best_index = avail_disks - 1;
 			best_disk = disk;
-			/*
-			 * If buffered sequential IO size exceeds optimal
-			 * iosize, check if there is idle disk. If yes, choose
-			 * the idle disk. read_balance could already choose an
-			 * idle disk before noticing it's a sequential IO in
-			 * this disk. This doesn't matter because this disk
-			 * will idle, next time it will be utilized after the
-			 * first disk has IO size exceeds optimal iosize. In
-			 * this way, iosize of the first disk will be optimal
-			 * iosize at least. iosize of the second disk might be
-			 * small, but not a big deal since when the second disk
-			 * starts IO, the first disk is likely still busy.
-			 */
-			if (nonrot && opt_iosize > 0 &&
-			    mirror->seq_start != MaxSector &&
-			    mirror->next_seq_sect > opt_iosize &&
-			    mirror->next_seq_sect - opt_iosize >=
-			    mirror->seq_start) {
-				choose_next_idle = 1;
-				continue;
-			}
-			break;
-		}
 
-		if (choose_next_idle)
+			if (choose_first_disk == -1)
+				choose_first_disk = best_disk;
 			continue;
+		}
 
 		if (min_pending > pending) {
 			min_pending = pending;
@@ -763,7 +766,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	 * If all disks are rotational, choose the closest disk. If any disk is
 	 * non-rotational, choose the disk with less pending request even the
 	 * disk is rotational, which might/might not be optimal for raids with
-	 * mixed ratation/non-rotational disks depending on workload.
+	 * mixed rotation/non-rotational disks depending on workload.
 	 */
 	if (best_disk == -1) {
 		if (has_nonrot_disk || min_pending == 0)
@@ -772,8 +775,44 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			best_disk = best_dist_disk;
 	}
 
+	if (choose_first_disk >= 0)
+		best_disk = choose_first_disk;
+
 	if (best_disk >= 0) {
-		rdev = conf->mirrors[best_disk].rdev;
+		if (avail_disks > 1) {
+
+			/* Only set Failfast if we have at least 2 available disks. */
+			set_bit(R1BIO_FailFast, &r1_bio->state);
+
+			/* There are many reasons why round robin might not be the best
+			 * choice...
+			 */
+			if (has_nonrot_disk && !choose_first && avail_disks <= MAX_RR_DISKS
+				&& sectors > RR_16K_IN_SECS && sequential == true) {
+
+				conf->mirrors->read_thresh += sectors;
+				conf->mirrors->rr_index = best_index;
+				/* Only switch over after a certain transfer threshold per
+				 * disk, based on empirical data for non rotational media.
+				 */
+				if (conf->mirrors->read_thresh >= RR_128K_IN_SECS) {
+					conf->mirrors->read_thresh = 0;
+
+					if (any_pending > 1) {
+						/* We store the index into the mirrors array that
+						 * represents the N available disks and round robin
+						 * that index into the array to get the next disk
+						 * number to use.
+						 */
+						best_index = (best_index + 1) % avail_disks;
+						conf->mirrors->rr_index = best_index;
+						best_disk = avail_disk[best_index];
+					}
+				}
+			}
+		}
+
+		rdev = rcu_dereference(conf->mirrors[best_disk].rdev);
 		if (!rdev)
 			goto retry;
 		atomic_inc(&rdev->nr_pending);
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 14d4211a123a..e7c3a3334d2f 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -42,6 +42,12 @@ struct raid1_info {
 	struct md_rdev	*rdev;
 	sector_t	head_position;
 
+	/* The round robin trasnfer (sectors) threshold before we move to the next
+	 * disk, and the mirrors[] index of the last used disk for round robin.
+	 */
+	int read_thresh;
+	int rr_index;
+
 	/* When choose the best device for a read (read_balance())
 	 * we try to keep sequential reads one the same device
 	 */
-- 
2.41.0


