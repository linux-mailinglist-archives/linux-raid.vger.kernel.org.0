Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6783444E04
	for <lists+linux-raid@lfdr.de>; Thu,  4 Nov 2021 05:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhKDEym (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 4 Nov 2021 00:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhKDEym (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 4 Nov 2021 00:54:42 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E04C061714
        for <linux-raid@vger.kernel.org>; Wed,  3 Nov 2021 21:52:04 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f9so5484880ioo.11
        for <linux-raid@vger.kernel.org>; Wed, 03 Nov 2021 21:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQXa0CcJYdNtKDoWt9VtW+ZVAC6iWwgFax1FcRMthH0=;
        b=KhuEyShanMbolXKrnWMSHegcy8pUtNx0yb6LrWlyKrbqh7wL5chRp+riiVi4WjKN2J
         BqrA9mj6D9qCzqL3qocW/T4p53UoqA8pvRAMEcu2G6I+LEzfXPgR5ssxzzjNYutPrGgX
         7adwinOWK8GYQGn9NpeikIZH6nI0HqloywyXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQXa0CcJYdNtKDoWt9VtW+ZVAC6iWwgFax1FcRMthH0=;
        b=rvgICFR5Hf8GCBljbmeV2HdRt+nLBl4Nm/2sofeu5/fkEdvbYSceUgVPmJFbvb+T+E
         hK0+tRYBcWUCQ/IlMSovYZ/F0K8JgVedT+b5qXdwxxO2UwCH6Jke+K48L/PlLsD3xnW2
         XSNbHgmWPh1Rt7yJW00v9YwuxLRZwQvtfqOybUSQWrKHyYs97G3Xky/jM0FbwhBbD/0b
         GLiFka25Cb4jT/nYIHOC3nUgHYhTB/uOcFkbD2Gl1KwQfvqVZI5aTwqEIljBhfDh7lJG
         PQnpN1Un7lJgKu8xRazUHbXw/7rjFgAi8nd7VmtzjOe8wkz+mucxLkeDhisty6RF8nB/
         Jzqw==
X-Gm-Message-State: AOAM533AMSSYVgZLqoMsncocPxWb8lirlk2o0lsx7a5efsl9NLR2hiVm
        mB/OlDui1yuNgwB8FW4uxMdY7Q==
X-Google-Smtp-Source: ABdhPJxbqyZ6tQ7Q3p+9aH2bizQOyH+RfD+SmcboxYUM+SfA8Y+WPAjt9GNGEmj4eUpxFwBy0HZ02Q==
X-Received: by 2002:a02:9609:: with SMTP id c9mr2118151jai.118.1636001523567;
        Wed, 03 Nov 2021 21:52:03 -0700 (PDT)
Received: from vverma-s2-cbrunner ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id g13sm2150444ilc.54.2021.11.03.21.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 21:52:03 -0700 (PDT)
From:   Vishal Verma <vverma@digitalocean.com>
To:     song@kernel.org, linux-raid@vger.kernel.org, rgoldwyn@suse.de
Cc:     axboe@kernel.dk, Vishal Verma <vverma@digitalocean.com>
Subject: [PATCH v3 2/2] md: raid1 add nowait support
Date:   Thu,  4 Nov 2021 04:51:48 +0000
Message-Id: <20211104045149.9599-1-vverma@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPhsuW5rGPP_6CZWC+W93dRHS6b3HJ7Yz4KR=r7ghhuZov2vfQ@mail.gmail.com>
References: <CAPhsuW5rGPP_6CZWC+W93dRHS6b3HJ7Yz4KR=r7ghhuZov2vfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This adds nowait support to the RAID1 driver. It makes RAID1 driver
return with EAGAIN for situations where it could wait for eg:

  - Waiting for the barrier,
  - Array got frozen,
  - Too many pending I/Os to be queued.

wait_barrier() fn is modified to return bool to support error for
wait barriers. It returns true in case of wait or if wait is not
required and returns false if wait was required but not performed
to support nowait.

Signed-off-by: Vishal Verma <vverma@digitalocean.com>
---
 drivers/md/raid1.c | 74 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7dc8026cf6ee..2e191fc2147b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -929,8 +929,9 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr)
 	wake_up(&conf->wait_barrier);
 }
 
-static void _wait_barrier(struct r1conf *conf, int idx)
+static bool _wait_barrier(struct r1conf *conf, int idx, bool nowait)
 {
+	bool ret = true;
 	/*
 	 * We need to increase conf->nr_pending[idx] very early here,
 	 * then raise_barrier() can be blocked when it waits for
@@ -961,7 +962,7 @@ static void _wait_barrier(struct r1conf *conf, int idx)
 	 */
 	if (!READ_ONCE(conf->array_frozen) &&
 	    !atomic_read(&conf->barrier[idx]))
-		return;
+		return ret;
 
 	/*
 	 * After holding conf->resync_lock, conf->nr_pending[idx]
@@ -979,18 +980,27 @@ static void _wait_barrier(struct r1conf *conf, int idx)
 	 */
 	wake_up(&conf->wait_barrier);
 	/* Wait for the barrier in same barrier unit bucket to drop. */
-	wait_event_lock_irq(conf->wait_barrier,
-			    !conf->array_frozen &&
-			     !atomic_read(&conf->barrier[idx]),
-			    conf->resync_lock);
+	if (conf->array_frozen || atomic_read(&conf->barrier[idx])) {
+		/* Return false when nowait flag is set */
+		if (nowait)
+			ret = false;
+		else {
+			wait_event_lock_irq(conf->wait_barrier,
+					!conf->array_frozen &&
+					!atomic_read(&conf->barrier[idx]),
+					conf->resync_lock);
+		}
+	}
 	atomic_inc(&conf->nr_pending[idx]);
 	atomic_dec(&conf->nr_waiting[idx]);
 	spin_unlock_irq(&conf->resync_lock);
+	return ret;
 }
 
-static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
+static bool wait_read_barrier(struct r1conf *conf, sector_t sector_nr, bool nowait)
 {
 	int idx = sector_to_idx(sector_nr);
+	bool ret = true;
 
 	/*
 	 * Very similar to _wait_barrier(). The difference is, for read
@@ -1002,7 +1012,7 @@ static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
 	atomic_inc(&conf->nr_pending[idx]);
 
 	if (!READ_ONCE(conf->array_frozen))
-		return;
+		return ret;
 
 	spin_lock_irq(&conf->resync_lock);
 	atomic_inc(&conf->nr_waiting[idx]);
@@ -1013,19 +1023,27 @@ static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
 	 */
 	wake_up(&conf->wait_barrier);
 	/* Wait for array to be unfrozen */
-	wait_event_lock_irq(conf->wait_barrier,
-			    !conf->array_frozen,
-			    conf->resync_lock);
+	if (conf->array_frozen || atomic_read(&conf->barrier[idx])) {
+		if (nowait)
+			/* Return false when nowait flag is set */
+			ret = false;
+		else {
+			wait_event_lock_irq(conf->wait_barrier,
+					!conf->array_frozen,
+					conf->resync_lock);
+		}
+	}
 	atomic_inc(&conf->nr_pending[idx]);
 	atomic_dec(&conf->nr_waiting[idx]);
 	spin_unlock_irq(&conf->resync_lock);
+	return ret;
 }
 
-static void wait_barrier(struct r1conf *conf, sector_t sector_nr)
+static bool wait_barrier(struct r1conf *conf, sector_t sector_nr, bool nowait)
 {
 	int idx = sector_to_idx(sector_nr);
 
-	_wait_barrier(conf, idx);
+	return _wait_barrier(conf, idx, nowait);
 }
 
 static void _allow_barrier(struct r1conf *conf, int idx)
@@ -1236,7 +1254,11 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	 * Still need barrier for READ in case that whole
 	 * array is frozen.
 	 */
-	wait_read_barrier(conf, bio->bi_iter.bi_sector);
+	if (!wait_read_barrier(conf, bio->bi_iter.bi_sector,
+				bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return;
+	}
 
 	if (!r1_bio)
 		r1_bio = alloc_r1bio(mddev, bio);
@@ -1336,6 +1358,10 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		     bio->bi_iter.bi_sector, bio_end_sector(bio))) {
 
 		DEFINE_WAIT(w);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		for (;;) {
 			prepare_to_wait(&conf->wait_barrier,
 					&w, TASK_IDLE);
@@ -1353,17 +1379,26 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	 * thread has put up a bar for new requests.
 	 * Continue immediately if no resync is active currently.
 	 */
-	wait_barrier(conf, bio->bi_iter.bi_sector);
+	if (!wait_read_barrier(conf, bio->bi_iter.bi_sector,
+				bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return;
+	}
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid1_log(mddev, "wait queued");
 		wait_event(conf->wait_barrier,
 			   conf->pending_count < max_queued_requests);
 	}
+
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
@@ -1458,9 +1493,14 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				rdev_dec_pending(conf->mirrors[j].rdev, mddev);
 		r1_bio->state = 0;
 		allow_barrier(conf, bio->bi_iter.bi_sector);
+
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid1_log(mddev, "wait rdev %d blocked", blocked_rdev->raid_disk);
 		md_wait_for_blocked_rdev(blocked_rdev, mddev);
-		wait_barrier(conf, bio->bi_iter.bi_sector);
+		wait_barrier(conf, bio->bi_iter.bi_sector, false);
 		goto retry_write;
 	}
 
@@ -1687,7 +1727,7 @@ static void close_sync(struct r1conf *conf)
 	int idx;
 
 	for (idx = 0; idx < BARRIER_BUCKETS_NR; idx++) {
-		_wait_barrier(conf, idx);
+		_wait_barrier(conf, idx, false);
 		_allow_barrier(conf, idx);
 	}
 
-- 
2.17.1

