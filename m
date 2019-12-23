Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3F1293C5
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLWJtT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35557 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLWJtS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so14795727edv.2
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0J5+zOePJYxdIfoyV2Igq8v7+PFhVXxcLC3T2JxwEPM=;
        b=AQEyG/YbQzWwCytvjZzpHQnNjGm5A1D+CbpmmaNVX9KOe7uiZDxxamo7NfoCVvrcwp
         vRlZ1oai+Bk2tS5kyhuYrPWcPeyNKGtqnSNQ0FcPWaaj3bzESFej5uCSiR00zCcBRZ9l
         YgFow5BDTtjb+OPNFZqFvnIL9Re1IRKn0RngAs4AdY2hk96kpTBhM9SXcM8xdP+PhBFx
         M0idtSBWytqGcKy/Y4o1s12znUJk9BT88qHdq33a47a4sF9JczGBjmluxza8/n5SlI4z
         G/7wUTsdLkd5KUgMXITlhX/C6SPB62z0EeWkoQaOg4m3ez2eOm1vvuTBXl2Oxhdr1E5z
         JODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0J5+zOePJYxdIfoyV2Igq8v7+PFhVXxcLC3T2JxwEPM=;
        b=U9epLARGjwi6/Qo2Yf5HSP7lzFqA9TkIIwB9JpDt/YUGR7D1cH+KrefMgKmKrZ6YtK
         n9XG0iG4lv6hct8tCvSFLERRUsufaUh4HoX3lx4exJIbb+Ru8suCLFDgHnZrxKmEIKdp
         +FJ117DbWnOPc/l2GJ3QEP48ld5GlTuizJmQyw/s4/Td0HPYYinwIDFG7P0cpQ7Io7V5
         Oa4j+R2XYtQqEc8lIQ57FG1gPGIJgZCy/JmwmXRtDFq+ubrK2YTWUdzZO8q2pOuIYlYK
         odoTRiviBwZy2kxV+eIEeSoQwTls9YZR4YKLkGEYapSzeliPlFJ49i1OMDrYBDW/wPVo
         JyeA==
X-Gm-Message-State: APjAAAUtH7Luxnu0zCKp4lC8Vy+JjMvq2DVmE1AT0g8Ial4nq3EtoVwc
        NtefraOu4hNW42vj+3w+LKA=
X-Google-Smtp-Source: APXvYqzKqGz3GfbwyCemBvEAdB9vTZrmEcut3tRb+Q+p2BpuIbKgdZBWfghv3cIpDrUrKp1XXRyOdg==
X-Received: by 2002:a17:906:3793:: with SMTP id n19mr30499190ejc.85.1577094557084;
        Mon, 23 Dec 2019 01:49:17 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:16 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 09/10] md/raid1: use bucket based mechanism for IO serialization
Date:   Mon, 23 Dec 2019 10:49:01 +0100
Message-Id: <20191223094902.12704-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since raid1 had already used bucket based mechanism to reduce
the conflict between write IO and resync IO, it is possible to
speed up performance for io serialization with refer to the
same mechanism.

To align with the barrier bucket mechanism, we created arrays
(with the same number of BARRIER_BUCKETS_NR) for spinlock, rb
tree and waitqueue. Then we can reduce lock competition with
multiple spinlocks, boost search performance with multiple rb
trees and also reduce thundering herd problem with multiple
waitqueues.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c    | 18 +++++++++++++-----
 drivers/md/raid1.c |  9 ++++++---
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9c4e61c988ac..4824d50526fa 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -130,7 +130,7 @@ static void rdev_uninit_serial(struct md_rdev *rdev)
 	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
 		return;
 
-	kfree(rdev->serial);
+	kvfree(rdev->serial);
 	rdev->serial = NULL;
 }
 
@@ -144,18 +144,26 @@ static void rdevs_uninit_serial(struct mddev *mddev)
 
 static int rdev_init_serial(struct md_rdev *rdev)
 {
+	/* serial_nums equals with BARRIER_BUCKETS_NR */
+	int i, serial_nums = 1 << ((PAGE_SHIFT - ilog2(sizeof(atomic_t))));
 	struct serial_in_rdev *serial = NULL;
 
 	if (test_bit(CollisionCheck, &rdev->flags))
 		return 0;
 
-	serial = kmalloc(sizeof(struct serial_in_rdev), GFP_KERNEL);
+	serial = kvmalloc(sizeof(struct serial_in_rdev) * serial_nums,
+			  GFP_KERNEL);
 	if (!serial)
 		return -ENOMEM;
 
-	spin_lock_init(&serial->serial_lock);
-	serial->serial_rb = RB_ROOT_CACHED;
-	init_waitqueue_head(&serial->serial_io_wait);
+	for (i = 0; i < serial_nums; i++) {
+		struct serial_in_rdev *serial_tmp = &serial[i];
+
+		spin_lock_init(&serial_tmp->serial_lock);
+		serial_tmp->serial_rb = RB_ROOT_CACHED;
+		init_waitqueue_head(&serial_tmp->serial_io_wait);
+	}
+
 	rdev->serial = serial;
 	set_bit(CollisionCheck, &rdev->flags);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 5c6a03747448..48d553d7989a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -62,7 +62,8 @@ static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 	unsigned long flags;
 	int ret = 0;
 	struct mddev *mddev = rdev->mddev;
-	struct serial_in_rdev *serial = rdev->serial;
+	int idx = sector_to_idx(lo);
+	struct serial_in_rdev *serial = &rdev->serial[idx];
 
 	si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
 
@@ -87,7 +88,8 @@ static void remove_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
 	unsigned long flags;
 	int found = 0;
 	struct mddev *mddev = rdev->mddev;
-	struct serial_in_rdev *serial = rdev->serial;
+	int idx = sector_to_idx(lo);
+	struct serial_in_rdev *serial = &rdev->serial[idx];
 
 	spin_lock_irqsave(&serial->serial_lock, flags);
 	for (si = raid1_rb_iter_first(&serial->serial_rb, lo, hi);
@@ -1486,7 +1488,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
 		struct md_rdev *rdev = conf->mirrors[i].rdev;
-		struct serial_in_rdev *serial = rdev->serial;
+		int idx = sector_to_idx(lo);
+		struct serial_in_rdev *serial = &rdev->serial[idx];
 		if (!r1_bio->bios[i])
 			continue;
 
-- 
2.17.1

