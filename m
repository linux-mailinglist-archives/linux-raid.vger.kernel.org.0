Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7641293C3
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWJtQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36305 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLWJtQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so14785957edp.3
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6rErxbWS6HULYMCGuSff76MZMMnS9bm0ajPuFSo9rw=;
        b=HtI6t5FThxoRzm7N1Lyxd1ThY5taKImSfit3SAET1pmIt0qZbZeors/PTRKuIe3L4c
         lvbInOwZNDS1LgOs2x2Im5bDT6zHrhjQyckPWyHaRlUFAQpjnkXoglI36shTcdw/vkLK
         tk/bqNUsGsdhSQ/Fw48SL3GdA7nGs33D4e8ocXo1m1CcPAbCjtEc6WOYLYV+CnzjIP4R
         8Jl4TWQTwet0SJeC73Yrj7unzX5CEwGvjpzoRzQYDRXw6j7f0UWdgEVdsSwkLDtT8HGz
         MglKVKeLCu36bfmVF6DR1uNpJveP3ct3Qu34FrWzj7MrYHAcYy/UrVSinLgzOyMdKYOs
         bODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6rErxbWS6HULYMCGuSff76MZMMnS9bm0ajPuFSo9rw=;
        b=FaydRtAzLtP2O5Drvu+y1Uv0KeqaU+oWiyQchRlZ4lUU3DUSAJmo88JecTWfdjcrAL
         tdXzk23ZIsCsciiYcxXn6VYKgqYIX5KMWFF7CHM5hwoLI5mZob8NaIsRSCkQaJaApZP7
         wBz1zaokDcouUqJADUduOCfMDmDKB+t0Qe0gahEtLgA/z43Y/Y5EGhGRFnWZy49Ewnko
         DedGCf1XGyjHQUFfXPrw46XWAiKBM8VMPO61Gxyt6vseiXwdTkTR3kZoBLPDxbOAbXRR
         GqFw5RUpD1nddWn60/Jcybsktcjqw8DJpg7Xyj5u8lduTrb90rzKRpFFQ1iPhRsvcycl
         wm4A==
X-Gm-Message-State: APjAAAUZI8HHfIauyyxsijyOhuvUuE0TdCUzJOuAm3Yg7/F10CfeV7Lp
        iB2m7qbatoxAr76AO6j9Qd8=
X-Google-Smtp-Source: APXvYqyQJ6bLaPW7MQ8cltszBdl4miyngWavrhuAzYauKng5YrmScHU+tud1K4mAGtSms+gD3VMslA==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr12697407ejr.313.1577094554404;
        Mon, 23 Dec 2019 01:49:14 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:13 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 06/10] raid1: serialize the overlap write
Date:   Mon, 23 Dec 2019 10:48:58 +0100
Message-Id: <20191223094902.12704-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
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
index 0439f674ab14..3ad2f5a59d08 100644
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
 
@@ -1337,6 +1336,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
+	sector_t lo, hi;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1364,6 +1364,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
+	lo = r1_bio->sector;
+	hi = r1_bio->sector + r1_bio->sectors;
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
@@ -1479,6 +1481,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
+		struct md_rdev *rdev = conf->mirrors[i].rdev;
 		if (!r1_bio->bios[i])
 			continue;
 
@@ -1506,19 +1509,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
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

