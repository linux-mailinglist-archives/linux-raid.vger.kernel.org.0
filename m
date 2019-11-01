Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B22EC491
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfKAOXN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38234 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKAOXN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id d23so4978068edr.5
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uVksVzHTYxaIk3lbzO52Bd4x9Ao6uQm3oELOTv+4VMg=;
        b=frGhFtC+G7fC8oryAzxvlsWzsJiDq2juH6QxfGBI0s8r46T3LWpxJIWiVUTt14SDKP
         li0b5tyHDQQb9W7B21COaSL73JhA1AQYX1ht/lIyuISRzk51xtD+g7osdooSl7H/GoRa
         Zfk2HsJQmcfvXkXydC66ElBaKzwGd8k4E3/JU6plLIT+G3XXjhKww00rm/zmk19zp742
         DOBl2oRRsZiUG1+FXhFN1r76eK644ZS5S3ukynABNvtufzXHjq1kpA2UTiAtCY2hnZuP
         xMYVtU0zLw0pbaXyI0w4itHjwWHHngJkIxdDQpkyn0IaXI2tebOG4iazkJ1C1VJdLomI
         70Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVksVzHTYxaIk3lbzO52Bd4x9Ao6uQm3oELOTv+4VMg=;
        b=AItHWVYTMXdgR1XvQiJph8bZAoBqKrAUWUsUhIN0KDbwIAoy0aHkW8AGGtzxZdhlSZ
         BVJE5Nxo2ldkNpY4+T3wm8DKhh1gmbAjT1x3U3LoZGgmvcF0e69ywr/FOKki0O8S9Oi8
         NI/tRbuTUNdZMmYGTZr0FP4ydXc95/ZkA9ua0w8sVfpUHHhdCTWSO4KXJ1to3k/RD0ye
         Ce+QXCKgHcB0sRaIk9Ljfycwbk+RHTMNMfs0nnlDnC5AeZi+nx4UGN3SGj28KKZZ5cgi
         OKF6EQmhkad9Kan/cbn522z+5dQ5Gjpr7478JftwiJGF22xgeqDHLeVjlr55h9g3a+md
         NlKA==
X-Gm-Message-State: APjAAAVDezyjm4nRa17QUqgzZX4crjALeTpZUn78hJb9ElvUtafIqa2E
        IP+Q21JgBc0V/1+c0fCxLVA=
X-Google-Smtp-Source: APXvYqw4RvfvIv/ew/DJxWpJ/+OHCuk8w81sY10bUCrG23oxbOiEY+eQja9XYXaxqp7+FPF3Bg4tAA==
X-Received: by 2002:a17:906:2989:: with SMTP id x9mr9927305eje.318.1572618191568;
        Fri, 01 Nov 2019 07:23:11 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:11 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 4/8] raid1: serialize the overlap write
Date:   Fri,  1 Nov 2019 15:22:27 +0100
Message-Id: <20191101142231.23359-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Before dispatch write bio, raid1 array which enables
serialize_policy need to check if overlap exists between
this bio and previous on-flying bios. If there is overlap,
then it has to wait until the collision is disappeared.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid1.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 9d708d0467cc..4f683a3d44c0 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -430,6 +430,8 @@ static void raid1_end_write_request(struct bio *bio)
 	int mirror = find_bio_disk(r1_bio, bio);
 	struct md_rdev *rdev = conf->mirrors[mirror].rdev;
 	bool discard_error;
+	sector_t lo = r1_bio->sector;
+	sector_t hi = r1_bio->sector + r1_bio->sectors;
 
 	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
 
@@ -499,12 +501,8 @@ static void raid1_end_write_request(struct bio *bio)
 	}
 
 	if (behind) {
-		if (test_bit(CollisionCheck, &rdev->flags)) {
-			sector_t lo = r1_bio->sector;
-			sector_t hi = r1_bio->sector + r1_bio->sectors;
-
+		if (test_bit(CollisionCheck, &rdev->flags))
 			remove_serial(rdev, lo, hi);
-		}
 		if (test_bit(WriteMostly, &rdev->flags))
 			atomic_dec(&r1_bio->behind_remaining);
 
@@ -527,7 +525,8 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	}
+	} else if (rdev->mddev->serialize_policy)
+		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
 
@@ -1336,6 +1335,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
+	sector_t lo, hi;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1363,6 +1363,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
+	lo = r1_bio->sector;
+	hi = r1_bio->sector + r1_bio->sectors;
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
@@ -1478,6 +1480,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
+		struct md_rdev *rdev = conf->mirrors[i].rdev;
 		if (!r1_bio->bios[i])
 			continue;
 
@@ -1505,19 +1508,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
 
 		if (r1_bio->behind_master_bio) {
-			struct md_rdev *rdev = conf->mirrors[i].rdev;
-
-			if (test_bit(CollisionCheck, &rdev->flags)) {
-				sector_t lo = r1_bio->sector;
-				sector_t hi = r1_bio->sector + r1_bio->sectors;
-
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_event(rdev->serial_io_wait,
 					   check_and_add_serial(rdev, lo, hi)
 					   == 0);
-			}
 			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
-		}
+		} else if (mddev->serialize_policy)
+			wait_event(rdev->serial_io_wait,
+				   check_and_add_serial(rdev, lo, hi) == 0);
 
 		r1_bio->bios[i] = mbio;
 
-- 
2.17.1

