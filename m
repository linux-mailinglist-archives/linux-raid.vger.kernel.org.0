Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E62511A6
	for <lists+linux-raid@lfdr.de>; Tue, 25 Aug 2020 07:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgHYFnZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 25 Aug 2020 01:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbgHYFnZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 25 Aug 2020 01:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598334202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=fIYxD3jhscH2D6SrHGKkIhWl7EP4DjfhqkMFwBHKYUw=;
        b=A9jG30chrT2tz4ufS4OEFWbciZmg4+eFEtjEaOZu73PdKOke5RrqXnSVDDijFG6NCBZnAb
        TiRIvfeExzyDk/cDz7WRSjnCV+4jyagAYIH7XkqYrlqnjA5ZavB5RejRQDUE4DlJENAVBW
        ZKJkKvK0ZIGwH2YpLrFkUFn3BeCs0Jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-BCDruXlHO2q4RK5u_v6wKA-1; Tue, 25 Aug 2020 01:43:20 -0400
X-MC-Unique: BCDruXlHO2q4RK5u_v6wKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 391631888AB8;
        Tue, 25 Aug 2020 05:43:19 +0000 (UTC)
Received: from xiao.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7702F1014161;
        Tue, 25 Aug 2020 05:43:16 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org, song@kernel.org
Cc:     heinzm@redhat.com, ncroxon@redhat.com,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de
Subject: [PATCH V5 3/5] md/raid10: pull codes that wait for blocked dev into one function
Date:   Tue, 25 Aug 2020 13:43:01 +0800
Message-Id: <1598334183-25301-4-git-send-email-xni@redhat.com>
In-Reply-To: <1598334183-25301-1-git-send-email-xni@redhat.com>
References: <1598334183-25301-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The following patch will do the same job. So pull the same codes
into one function.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 118 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 51 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c4c8477..05e7f8d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1275,12 +1275,75 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	}
 }
 
+static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
+{
+	int i;
+	struct r10conf *conf = mddev->private;
+	struct md_rdev *blocked_rdev;
+
+retry_wait:
+	blocked_rdev = NULL;
+	rcu_read_lock();
+	for (i = 0; i < conf->copies; i++) {
+		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rrdev = rcu_dereference(
+			conf->mirrors[i].replacement);
+		if (rdev == rrdev)
+			rrdev = NULL;
+		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
+			atomic_inc(&rdev->nr_pending);
+			blocked_rdev = rdev;
+			break;
+		}
+		if (rrdev && unlikely(test_bit(Blocked, &rrdev->flags))) {
+			atomic_inc(&rrdev->nr_pending);
+			blocked_rdev = rrdev;
+			break;
+		}
+
+		if (rdev && test_bit(WriteErrorSeen, &rdev->flags)) {
+			sector_t first_bad;
+			sector_t dev_sector = r10_bio->devs[i].addr;
+			int bad_sectors;
+			int is_bad;
+
+			/* Discard request doesn't care the write result
+			 * so it doesn't need to wait blocked disk here.
+			 */
+			if (!r10_bio->sectors)
+				continue;
+
+			is_bad = is_badblock(rdev, dev_sector, r10_bio->sectors,
+					     &first_bad, &bad_sectors);
+			if (is_bad < 0) {
+				/* Mustn't write here until the bad block
+				 * is acknowledged
+				 */
+				atomic_inc(&rdev->nr_pending);
+				set_bit(BlockedBadBlocks, &rdev->flags);
+				blocked_rdev = rdev;
+				break;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	if (unlikely(blocked_rdev)) {
+		/* Have to wait for this device to get unblocked, then retry */
+		allow_barrier(conf);
+		raid10_log(conf->mddev, "%s wait rdev %d blocked",
+				__func__, blocked_rdev->raid_disk);
+		md_wait_for_blocked_rdev(blocked_rdev, mddev);
+		wait_barrier(conf);
+		goto retry_wait;
+	}
+}
+
 static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 				 struct r10bio *r10_bio)
 {
 	struct r10conf *conf = mddev->private;
 	int i;
-	struct md_rdev *blocked_rdev;
 	sector_t sectors;
 	int max_sectors;
 
@@ -1338,8 +1401,9 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 	r10_bio->read_slot = -1; /* make sure repl_bio gets freed */
 	raid10_find_phys(conf, r10_bio);
-retry_write:
-	blocked_rdev = NULL;
+
+	wait_blocked_dev(mddev, r10_bio);
+
 	rcu_read_lock();
 	max_sectors = r10_bio->sectors;
 
@@ -1350,16 +1414,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			conf->mirrors[d].replacement);
 		if (rdev == rrdev)
 			rrdev = NULL;
-		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
-			atomic_inc(&rdev->nr_pending);
-			blocked_rdev = rdev;
-			break;
-		}
-		if (rrdev && unlikely(test_bit(Blocked, &rrdev->flags))) {
-			atomic_inc(&rrdev->nr_pending);
-			blocked_rdev = rrdev;
-			break;
-		}
 		if (rdev && (test_bit(Faulty, &rdev->flags)))
 			rdev = NULL;
 		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
@@ -1380,15 +1434,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 			is_bad = is_badblock(rdev, dev_sector, max_sectors,
 					     &first_bad, &bad_sectors);
-			if (is_bad < 0) {
-				/* Mustn't write here until the bad block
-				 * is acknowledged
-				 */
-				atomic_inc(&rdev->nr_pending);
-				set_bit(BlockedBadBlocks, &rdev->flags);
-				blocked_rdev = rdev;
-				break;
-			}
 			if (is_bad && first_bad <= dev_sector) {
 				/* Cannot write here at all */
 				bad_sectors -= (dev_sector - first_bad);
@@ -1424,35 +1469,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	}
 	rcu_read_unlock();
 
-	if (unlikely(blocked_rdev)) {
-		/* Have to wait for this device to get unblocked, then retry */
-		int j;
-		int d;
-
-		for (j = 0; j < i; j++) {
-			if (r10_bio->devs[j].bio) {
-				d = r10_bio->devs[j].devnum;
-				rdev_dec_pending(conf->mirrors[d].rdev, mddev);
-			}
-			if (r10_bio->devs[j].repl_bio) {
-				struct md_rdev *rdev;
-				d = r10_bio->devs[j].devnum;
-				rdev = conf->mirrors[d].replacement;
-				if (!rdev) {
-					/* Race with remove_disk */
-					smp_mb();
-					rdev = conf->mirrors[d].rdev;
-				}
-				rdev_dec_pending(rdev, mddev);
-			}
-		}
-		allow_barrier(conf);
-		raid10_log(conf->mddev, "wait rdev %d blocked", blocked_rdev->raid_disk);
-		md_wait_for_blocked_rdev(blocked_rdev, mddev);
-		wait_barrier(conf);
-		goto retry_write;
-	}
-
 	if (max_sectors < r10_bio->sectors)
 		r10_bio->sectors = max_sectors;
 
-- 
2.7.5

