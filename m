Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD811050A8
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUKht (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45551 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKUKhr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id b5so2308322eds.12
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oSxf5ZuS0CB1reY7S02uGY+o4tw4NpliMs1HHxE6Y0w=;
        b=q/AnXhD+/p+MDC8wT0hOE8fHCxf1YshtSC6WTsJIR8Q/fJ493McrZx9EaxEvC1q8tS
         H/BikgU8WVDag5bT/PpPpF+G8yuK8K5h9eopaMoBIhGdx0nQyirjRQclW37j4vcCkAJV
         +PxIkgdpm2hMZjsq2krel68brDbCaO19R6ep744cQ7EIYs8kqm9UwYzd4Nw2QIw1hPJy
         fRtklCkL1rtfiIhuoaikXDZ92yTO+qw2cbchC5juRvQiydacEf4tzOIuGm/g3FRfo8hx
         ZdueW66K56iNXAeriU/1Aa5dI3kUbGZMC9HlJ0ID/Bt//1wcSrHvDTAIp4Vm0W+bfDZj
         od4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oSxf5ZuS0CB1reY7S02uGY+o4tw4NpliMs1HHxE6Y0w=;
        b=bDUR80XzFT9+0tijdZIuPCqgMm4KOTAD5cAK9ryxVfiXqwRDxLVS0KWJSJRDanWe0F
         MsoLdtNB629AiPdm5wXZdodfrIk9ibhcx+NvHYZWeyVIFT2dUrog9PmIHQ2PYqkyeNW4
         B7uNrx02e0he4bx+FRnfAsAf3v8qeJFWHfXY/og+mozeuEhp0gTC+9SMYAeRzqvQa1t3
         aUvbo7JgFcUw56c1BWlikw4Wm/OmHyiEgZe4d9bSVyN1rhZeBPUNLmkfwiqIrL0UtxAd
         2ZambfHreiYgZM7d43omjGAN9h6Hw0QXz1aNgdt9vV8B5qFWzTRt5/vCfOH8Zb7gWFJx
         HuPQ==
X-Gm-Message-State: APjAAAUZSbBFRQ9u6hBP7kA9fekVJTuO5gjBnovQKr13zhTpknzbs0up
        7JF4YGU46Pz5QD34Eet1f+s=
X-Google-Smtp-Source: APXvYqyt6Hn0yBhTtX5hz9hBh2lQYnIkWSQwOVMIMsPvqGXMmR+6nNMQ5eeqoyndFMP66fc0F3ImYw==
X-Received: by 2002:a17:906:6006:: with SMTP id o6mr12760958ejj.51.1574332665964;
        Thu, 21 Nov 2019 02:37:45 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:45 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 9/9] md/raid1: introduce wait_for_serialization
Date:   Thu, 21 Nov 2019 11:37:28 +0100
Message-Id: <20191121103728.18919-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
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
 drivers/md/raid1.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e5b2336febfe..2e602dbc921a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -56,32 +56,43 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, _subtree_last,
 		     START, LAST, static inline, raid1_rb);
 
-static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
+static int check_and_add_serial(struct md_rdev *rdev, struct r1bio *r1_bio,
+				struct serial_info *si, int idx)
 {
-	struct serial_info *si;
 	unsigned long flags;
 	int ret = 0;
-	struct mddev *mddev = rdev->mddev;
-	int idx = sector_to_idx(lo);
+	sector_t lo = r1_bio->sector;
+	sector_t hi = lo + r1_bio->sectors;
 	struct serial_in_rdev *serial = &rdev->serial[idx];
 
-	si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
-
 	spin_lock_irqsave(&serial->serial_lock, flags);
 	/* collision happened */
 	if (raid1_rb_iter_first(&serial->serial_rb, lo, hi))
 		ret = -EBUSY;
-	if (!ret) {
+	else {
 		si->start = lo;
 		si->last = hi;
 		raid1_rb_insert(si, &serial->serial_rb);
-	} else
-		mempool_free(si, mddev->serial_info_pool);
+	}
 	spin_unlock_irqrestore(&serial->serial_lock, flags);
 
 	return ret;
 }
 
+static void wait_for_serialization(struct md_rdev *rdev, struct r1bio *r1_bio)
+{
+	struct mddev *mddev = rdev->mddev;
+	struct serial_info *si;
+	int idx = sector_to_idx(r1_bio->sector);
+	struct serial_in_rdev *serial = &rdev->serial[idx];
+
+	if (WARN_ON(!mddev->serial_info_pool))
+		return;
+	si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
+	wait_event(serial->serial_io_wait,
+		   check_and_add_serial(rdev, r1_bio, si, idx) == 0);
+}
+
 static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 {
 	struct serial_info *si;
@@ -1341,7 +1352,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
-	sector_t lo, hi;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1369,8 +1379,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
-	lo = r1_bio->sector;
-	hi = r1_bio->sector + r1_bio->sectors;
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
@@ -1487,8 +1495,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
 		struct md_rdev *rdev = conf->mirrors[i].rdev;
-		int idx = sector_to_idx(lo);
-		struct serial_in_rdev *serial = &rdev->serial[idx];
 		if (!r1_bio->bios[i])
 			continue;
 
@@ -1517,14 +1523,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 		if (r1_bio->behind_master_bio) {
 			if (test_bit(CollisionCheck, &rdev->flags))
-				wait_event(serial->serial_io_wait,
-					   check_and_add_serial(rdev, lo, hi)
-					   == 0);
+				wait_for_serialization(rdev, r1_bio);
 			if (test_bit(WriteMostly, &rdev->flags))
 				atomic_inc(&r1_bio->behind_remaining);
 		} else if (mddev->serialize_policy)
-			wait_event(serial->serial_io_wait,
-				   check_and_add_serial(rdev, lo, hi) == 0);
+			wait_for_serialization(rdev, r1_bio);
 
 		r1_bio->bios[i] = mbio;
 
-- 
2.17.1

