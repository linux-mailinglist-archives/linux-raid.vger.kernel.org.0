Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150921050A9
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUKhv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46904 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKUKhq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id t11so2304627eds.13
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZAvyt+TFMfm315aXvcn0HZ1bI8SKoEVLsMGjQ9TSc40=;
        b=naOhRJcQeUJjzGZkBbxQ5FuGumUsL0QNAsH+g2hUwvty+PEQRB7c5aPESdTuezJgnD
         dYjslYEbqEwR0fVNTQo60osrlSP/0x7Oe3QFmEXecyJ9qZXD5cp5oEPznFS7mnKCN6gt
         I6RM3Kn+cp/UPrcqfAVbUk5Qs+hOno2pRdXM7kBV6Y7rZVSSsM2XNmKq420XC4w8qJKD
         MOhhbuCi/LhL85CWLz9m63HT5INGcdD2hQgFbKNiiFNPrWXSBVdUtVkYyLVVSzO1h9a2
         ecRosHEILi0OWP8lswYyIETx5tjlzWFzCnVBvwobl7HoQufiHpugae5Xs2eDVFidgkbq
         w/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZAvyt+TFMfm315aXvcn0HZ1bI8SKoEVLsMGjQ9TSc40=;
        b=jzSrt3NPYhmXoi6HICoUrBAr9M6JKxh/gFtdFAMHc3XOFVZVTD6p2nRBy4tnw1DeKq
         fCBzfltYOfWXNwFwqIFXjlp+BnBqihdTZimkeLCwmo7agdKi6bpVx4aHh0qrFKTxbPSI
         9v+IxaVUubin7P2p4MA+PI8z89kivk9VDYsmSMenr6VPKL+nsowrD2Og/rL3+BpkSYDV
         RfPIY2pKeMjl9X8EQCks6ugLTRnBI4NJBKEjJO6WX2WD9siMOlAuCwVW0eDxxthds6mI
         Sp9BIons8p3f0KB2OUDTvGRzg3b1uwwzyNQ3B+KOb3u4usPDDT+FLLJdFGiZog0EcHMi
         8kbw==
X-Gm-Message-State: APjAAAXAGz0nIDOQ4H+ET3eQeOuVnLffge8q5wO+v5ictEUFgh7VxzlV
        oo5u7lYxzUdqQxfI912EKeJ/VOf8
X-Google-Smtp-Source: APXvYqwx0leH+FWbJrVbAQ6PY6xLnKN3LJKz++M8Qs/tOcnWb88lxBWYEp/8gGjiqVxOiS66Xg2zsg==
X-Received: by 2002:a17:906:c44f:: with SMTP id ck15mr12801274ejb.7.1574332665196;
        Thu, 21 Nov 2019 02:37:45 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:44 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 8/9] md/raid1: use bucket based mechanism for IO serialization
Date:   Thu, 21 Nov 2019 11:37:27 +0100
Message-Id: <20191121103728.18919-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
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
index 4eb4b4c99248..ccb137066d78 100644
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
index 50d767240c8b..e5b2336febfe 100644
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
@@ -1485,7 +1487,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
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

