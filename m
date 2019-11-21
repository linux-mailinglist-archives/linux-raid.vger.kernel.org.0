Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4378A1050A5
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKUKhr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39271 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKUKho (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id n26so2344978edw.6
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BG2dfBSKCwW+7qUP+G/e8V07PMTxJMO2aOOBLOt1W4g=;
        b=o7BM2AuYm1D9T26izrg9RBNt9sYdW6yBe42x0c7qnZ7zO1estF300smIqK/ybWPeNO
         QgpAePXAchH+zRdCW8qP3h/OkP1416MS4Ws5oqoJEENuNj4cgyekaowk/lhr5SecjfE+
         paQqmI0vjyqbhAe37FKtKo6xGOlhcy5eSIh1CrLxtDu9x/EfjrswCds0mIvd5EK7NP8c
         g9584EsI53u+W52+sunUpkacke9CixyPGQkuTf9UMnNdrZm2uz8rIpWgk3wlBcJMVVXZ
         dmFj/yRBy7HtV4HRGS+VhMIyh37RUf3Bs9AYe8jIVALTMQCSiKdidrghatDxQtPza0XN
         cyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BG2dfBSKCwW+7qUP+G/e8V07PMTxJMO2aOOBLOt1W4g=;
        b=VMeJ4uO61kZBSltZXSN0G/STh3WcIvFQfdMBPNvEBdrGse/CKqLI3YsWG5XlpJDhdA
         qC24Ym32nhiwJTCz9H36gxkK11m523c7HhFswi2hZFIM631A4tXynOh58aHUn5Ce0m77
         mx7I7zBfXnba+lJkQ2NKTzrCJjlr4ytb6/A0Fu4MNYuipIS3jbLdyY2jbjgvcCSe1eIR
         n2cL7uuOzOZ/298eV5CWINzOVX37JXtzo6kCp5KX/4Znh4+SZqu7YlHEfdB70zajmxpB
         zmtiKmkZEAX2ln+UL1woSORbTsE7HN7KJyMfKXfGzJzS6TYiRe/gLrAoGwGvQeSPw76o
         n51g==
X-Gm-Message-State: APjAAAVd+ZT7cqjUevxHQapr9oQnUX22KJu1vMWkjSSEeeoQ4QhFNP1q
        gDHTJ1rITRlAx+FjU1VlS+jPrdQM
X-Google-Smtp-Source: APXvYqy0Sd8M2bIpfJLWVRBLfvvU2b0rY/ZNo+LGyinu29r85Rw0bF6QxVI7lkOTSby38hvS8il++g==
X-Received: by 2002:a17:906:48b:: with SMTP id f11mr12894487eja.225.1574332662597;
        Thu, 21 Nov 2019 02:37:42 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:42 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 5/9] raid1: serialize the overlap write
Date:   Thu, 21 Nov 2019 11:37:24 +0100
Message-Id: <20191121103728.18919-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Before dispatch write bio, raid1 array which enables serialize_policy
need to check if overlap exists between this bio and previous on-flying
bios. If there is overlap, then it has to wait until the collision is
disappeared.

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

