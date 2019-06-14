Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34946C79
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFNWlm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726373AbfFNWll (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:41 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMam8K010028
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=rGX2zxVQ8dy4tvWkTplsglMMVxKssIJx+Vf6E6BBlPs=;
 b=JgBKeovRtgQ3DSu5+TWB+hWjXxlS1ZFFn/hwAdzuuTZJ0T1Z7FtpnYik2yt1rE4wUa9j
 2W9QjflVb18Ghtcu/37tT7o12PCvu/EoViBm+BVGQDnqbGXNUi43X8O3a+N9NsgsDxGl
 bGbKgwDfUieNmvlu797dfg2u6BBLMJPUV7M= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2t4kf2g6vu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:40 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 14 Jun 2019 15:41:38 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B1B7762E307F; Fri, 14 Jun 2019 15:41:37 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Guoqing Jiang <gqjiang@suse.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 8/8] md/raid10: read balance chooses idlest disk for SSD
Date:   Fri, 14 Jun 2019 15:41:11 -0700
Message-ID: <20190614224111.3485077-9-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614224111.3485077-1-songliubraving@fb.com>
References: <20190614224111.3485077-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <gqjiang@suse.com>

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
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid10.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c9a149b2ec86..8a1354a08a1a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -707,15 +707,19 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 	int sectors = r10_bio->sectors;
 	int best_good_sectors;
 	sector_t new_distance, best_dist;
-	struct md_rdev *best_rdev, *rdev = NULL;
+	struct md_rdev *best_dist_rdev, *best_pending_rdev, *rdev = NULL;
 	int do_balance;
-	int best_slot;
+	int best_dist_slot, best_pending_slot;
+	bool has_nonrot_disk = false;
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
@@ -737,6 +741,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		sector_t first_bad;
 		int bad_sectors;
 		sector_t dev_sector;
+		unsigned int pending;
+		bool nonrot;
 
 		if (r10_bio->devs[slot].bio == IO_BLOCKED)
 			continue;
@@ -773,8 +779,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
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
@@ -787,14 +793,23 @@ static struct md_rdev *read_balance(struct r10conf *conf,
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
@@ -803,15 +818,21 @@ static struct md_rdev *read_balance(struct r10conf *conf,
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
2.17.1

