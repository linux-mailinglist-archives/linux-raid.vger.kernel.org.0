Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74ED1293C7
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLWJtV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34514 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfLWJtT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so14790712edw.1
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YB+4Wmjirrf/jTSCsi95xK6jfisK5mzF/9pdwqbk58o=;
        b=TUj+rRiX7S8muGWGKWyF2PdNfLBPfbBH6ODKFTBozSK98IgYgVjuDyTaul6H0Brfk/
         6vkg4tx4OmsFFiq5TcokTs5ZEfFthRpJyg5KyEeXQ9CJyGdnIxSxN2RNV5vUc1wAbJ88
         2C5+hzVloyo6+rneANX3zDAoB0fzqBIwp1HUSX4YjvuM5hd7+RJeO+oflIgr5gpzH03v
         KnCAzFVHq3r16TlISioDlluTtiR3lxbhS45xgJikK7tnmGmYSc6t4bqYv1lhadcBf2IV
         dIBhVcxoIdP3nMs6m5gFtQTj2BM7l3zI1FvvBM4urJlqYlg02TdIaSvdVDMsMUS9FBw8
         F6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YB+4Wmjirrf/jTSCsi95xK6jfisK5mzF/9pdwqbk58o=;
        b=jgm7V3ygK7qXRKrnFcy0o26sXYDl+FRLhu7Tc8YbUiw63Pjrc3A8dyrSdD2AHCff/4
         oJp6a2bdM6E8ei8HSLTS1Cz6I701o7732+divHPzmCt4mIk5jhaeHU10SblbKAx3HjPn
         Mv+8RHlMZbg57DMHxvRTXnLvyeTAb0CdOic0mPeH26P4tKQnzghoijg3lrAK1zPZrb2X
         eUZcT1p7pkVPN9brVtQfKmpjYS01O+V/QksiIlA7se4VpevHImql8ntoYTKENJRk4zLI
         4aUlhqVfI24By4brWcURgm6M/UsdNd3xeLChHgCzT8zr4m9DFnamnUNf1lTcDVLZJoIH
         q/HQ==
X-Gm-Message-State: APjAAAU+637IX7scmQDoQPSb2CC8O6dMdgwFyPoQmraEVsAK1naz3eFT
        NcTEvug2X0PTViGx0+Sn4MY=
X-Google-Smtp-Source: APXvYqzVPRylkymVliKa/DDJKXgOmuL9rxrve6qT2+XTgo3YouyV4Tr6yRTeoKIrAV5I7DqL+1YjVw==
X-Received: by 2002:a17:906:1b07:: with SMTP id o7mr31725186ejg.131.1577094557834;
        Mon, 23 Dec 2019 01:49:17 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:17 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 10/10] md/raid1: introduce wait_for_serialization
Date:   Mon, 23 Dec 2019 10:49:02 +0100
Message-Id: <20191223094902.12704-11-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
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
index 48d553d7989a..cd810e195086 100644
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
@@ -1342,7 +1353,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
-	sector_t lo, hi;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1370,8 +1380,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
-	lo = r1_bio->sector;
-	hi = r1_bio->sector + r1_bio->sectors;
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
@@ -1488,8 +1496,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
 		struct md_rdev *rdev = conf->mirrors[i].rdev;
-		int idx = sector_to_idx(lo);
-		struct serial_in_rdev *serial = &rdev->serial[idx];
 		if (!r1_bio->bios[i])
 			continue;
 
@@ -1518,14 +1524,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
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

