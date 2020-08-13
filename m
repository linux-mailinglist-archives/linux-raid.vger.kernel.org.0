Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12CE24341C
	for <lists+linux-raid@lfdr.de>; Thu, 13 Aug 2020 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMGpR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Aug 2020 02:45:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40678 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgHMGpR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 13 Aug 2020 02:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597301115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zP7UUQ7//QleJb/EQllVTkZAnLaZWEwMXnNsWGniw/I=;
        b=Oh/TgniM6xM7zbdzt1iPuuDimd1HSMiIw3yW9GGtz4K++/UIDew+pG13zlirzBgSq8bIP/
        xN44cvLgQq0JDt+HFO1MQvNLkj3tC5vQJEJ+KPB0yL95JKg2v58ck/VrU7RhdaiqourNoX
        csvLlTdGPwrvowSal7OqcmqKR8jQg2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-zuC4BBMOOu2fUI-urju_yg-1; Thu, 13 Aug 2020 02:45:11 -0400
X-MC-Unique: zuC4BBMOOu2fUI-urju_yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307BF8017F4;
        Thu, 13 Aug 2020 06:45:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F14C95FC1B;
        Thu, 13 Aug 2020 06:45:06 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, guoqing.jiang@cloud.ionos.com, heinzm@redhat.com,
        ncroxon@redhat.com
Subject: [md PATCH V3 4/4] Improve discard request for far layout
Date:   Thu, 13 Aug 2020 14:44:47 +0800
Message-Id: <1597301087-6565-5-git-send-email-xni@redhat.com>
In-Reply-To: <1597301087-6565-1-git-send-email-xni@redhat.com>
References: <1597301087-6565-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For far layout, the discard region is not continuous on disks. So it needs
far copies r10bio to cover all regions. It needs a way to know all r10bios
have finish or not. Similar with raid10_sync_request, only the first r10bio
master_bio records the discard bio. Other r10bios master_bio record the first
r10bio. The first r10bio can finish after other r10bios finish and then return
the discard bio.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 89 ++++++++++++++++++++++++++++++++++++++---------------
 drivers/md/raid10.h |  1 +
 2 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5431e1b..97f673a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1582,6 +1582,27 @@ static struct bio *raid10_split_bio(struct r10conf *conf,
 	return bio;
 }
 
+static void raid_end_discard_bio(struct r10bio *r10bio)
+{
+	struct r10conf *conf = r10bio->mddev->private;
+
+	while (atomic_dec_and_test(&r10bio->remaining)) {
+
+		allow_barrier(conf);
+
+		if (test_bit(R10BIO_Discard, &r10bio->state)) {
+			md_write_end(r10bio->mddev);
+			bio_endio(r10bio->master_bio);
+			free_r10bio(r10bio);
+			break;
+		} else {
+			struct r10bio *first_r10bio = (struct r10bio *)r10bio->master_bio;
+			free_r10bio(r10bio);
+			r10bio = first_r10bio;
+		}
+	}
+}
+
 static void raid10_end_discard_request(struct bio *bio)
 {
 	struct r10bio *r10_bio = bio->bi_private;
@@ -1605,10 +1626,7 @@ static void raid10_end_discard_request(struct bio *bio)
 		rdev = conf->mirrors[dev].rdev;
 	}
 
-	if (atomic_dec_and_test(&r10_bio->remaining)) {
-		md_write_end(r10_bio->mddev);
-		raid_end_bio_io(r10_bio);
-	}
+	raid_end_discard_bio(r10_bio);
 
 	rdev_dec_pending(rdev, conf->mddev);
 }
@@ -1622,7 +1640,9 @@ static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r10conf *conf = mddev->private;
 	struct geom geo = conf->geo;
-	struct r10bio *r10_bio;
+	struct r10bio *r10_bio, *first_r10bio;
+	int far_copies = geo.far_copies;
+	bool first_copy = true;
 
 	int disk;
 	sector_t chunk;
@@ -1649,9 +1669,9 @@ static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	bio_end = bio_end_sector(bio);
 
 	/* Maybe one discard bio is smaller than strip size or across one stripe
-	 * and discard region is larger than one stripe size. For far offset layout,
-	 * if the discard region is not aligned with stripe size, there is hole
-	 * when we submit discard bio to member disk. For simplicity, we only
+	 * and discard region is larger than one stripe size. For far and far offset
+	 * layout, if the discard region is not aligned with stripe size, there is
+	 * hole when we submit discard bio to member disk. For simplicity, we only
 	 * handle discard bio which discard region is bigger than stripe_size*2
 	 */
 	if (bio_sectors(bio) < stripe_size*2)
@@ -1662,29 +1682,20 @@ static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		bio_end > conf->reshape_progress)
 		goto out;
 
-	/* For far offset layout, if bio is not aligned with stripe size, it splits
-	 * the part that is not aligned with strip size.
+	/* For far and far offset layout, if bio is not aligned with stripe size,
+	 * it splits the part that is not aligned with strip size.
 	 */
-	if (geo.far_offset && (bio_start & stripe_mask)) {
+	if ((far_copies > 1) && (bio_start & stripe_mask)) {
 		sector_t split_size;
 		split_size = round_up(bio_start, stripe_size) - bio_start;
 		bio = raid10_split_bio(conf, bio, split_size, false);
 	}
-	if (geo.far_offset && (bio_end & stripe_mask)) {
+	if ((far_copies > 1) && (bio_end & stripe_mask)) {
 		sector_t split_size;
 		split_size = bio_sectors(bio) - (bio_end & stripe_mask);
 		bio = raid10_split_bio(conf, bio, split_size, true);
 	}
 
-	r10_bio = mempool_alloc(&conf->r10bio_pool, GFP_NOIO);
-	r10_bio->mddev = mddev;
-	r10_bio->state = 0;
-	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
-
-	wait_blocked_dev(mddev, geo.raid_disks);
-
-	r10_bio->master_bio = bio;
-
 	bio_start = bio->bi_iter.bi_sector;
 	bio_end = bio_end_sector(bio);
 
@@ -1710,6 +1721,28 @@ static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	end_disk_offset = (bio_end & geo.chunk_mask) +
 				(last_stripe_index << geo.chunk_shift);
 
+	wait_blocked_dev(mddev, geo.raid_disks);
+
+retry_discard:
+	r10_bio = mempool_alloc(&conf->r10bio_pool, GFP_NOIO);
+	r10_bio->mddev = mddev;
+	r10_bio->state = 0;
+	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
+
+	/* For far layout it needs more than one r10bio to cover all regions.
+	 * Inspired by raid10_sync_request, we can use the first r10bio->master_bio
+	 * to record the discard bio. Other r10bio->master_bio record the first
+	 * r10bio. The first r10bio only release after all other r10bios finish.
+	 * The discard bio returns only first r10bio finishes
+	 */
+	if (first_copy) {
+		r10_bio->master_bio = bio;
+		set_bit(R10BIO_Discard, &r10_bio->state);
+		first_copy = false;
+		first_r10bio = r10_bio;
+	} else
+		r10_bio->master_bio = (struct bio *)first_r10bio;
+
 	rcu_read_lock();
 	for (disk = 0; disk < geo.raid_disks; disk++) {
 		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
@@ -1796,11 +1829,19 @@ static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		}
 	}
 
-	if (atomic_dec_and_test(&r10_bio->remaining)) {
-		md_write_end(r10_bio->mddev);
-		raid_end_bio_io(r10_bio);
+	if (!geo.far_offset && --far_copies) {
+		first_stripe_index += geo.stride >> geo.chunk_shift;
+		start_disk_offset += geo.stride;
+		last_stripe_index += geo.stride >> geo.chunk_shift;
+		end_disk_offset += geo.stride;
+		atomic_inc(&first_r10bio->remaining);
+		raid_end_discard_bio(r10_bio);
+		wait_barrier(conf);
+		goto retry_discard;
 	}
 
+	raid_end_discard_bio(r10_bio);
+
 	return 0;
 out:
 	allow_barrier(conf);
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 79cd2b7..1461fd5 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -179,5 +179,6 @@ enum r10bio_state {
 	R10BIO_Previous,
 /* failfast devices did receive failfast requests. */
 	R10BIO_FailFast,
+	R10BIO_Discard,
 };
 #endif
-- 
2.7.5

