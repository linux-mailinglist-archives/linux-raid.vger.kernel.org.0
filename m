Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB16675EA5
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jul 2019 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfGZFz0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 26 Jul 2019 01:55:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZFzZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 26 Jul 2019 01:55:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5402A7A4BBD87E1EF24F;
        Fri, 26 Jul 2019 13:55:23 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 13:55:13 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <liu.song.a23@gmail.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <houtao1@huawei.com>, <zou_wei@huawei.com>
Subject: [PATCH] md/raid1: fix a race between removing rdev and access conf->mirrors[i].rdev
Date:   Fri, 26 Jul 2019 14:00:51 +0800
Message-ID: <20190726060051.16630-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We get a NULL pointer dereference oops when test raid1 as follow:

mdadm -CR /dev/md1 -l 1 -n 2 /dev/sd[ab]

mdadm /dev/md1 -f /dev/sda
mdadm /dev/md1 -r /dev/sda
mdadm /dev/md1 -a /dev/sda
sleep 5
mdadm /dev/md1 -f /dev/sdb
mdadm /dev/md1 -r /dev/sdb
mdadm /dev/md1 -a /dev/sdb

After a disk(/dev/sda) has been removed, we add the disk to raid
array again, which would trigger recovery action. Since the rdev
current state is 'spare', read/write bio can be issued to the disk.

Then we set the other disk (/dev/sdb) faulty. Since the raid array
is now in degraded state and /dev/sdb is the only 'In_sync' disk,
raid1_error() will return but without set faulty success.

However, that can interrupt the recovery action and
md_check_recovery will try to call remove_and_add_spares() to
remove the spare disk. And the race condition between
remove_and_add_spares() and raid1_write_request() in follow
can cause NULL pointer dereference for conf->mirrors[i].rdev:

raid1_write_request()   md_check_recovery    raid1_error()
rcu_read_lock()
rdev != NULL
!test_bit(Faulty, &rdev->flags)

                                           conf->recovery_disabled=
                                             mddev->recovery_disabled;
                                            return busy

                        remove_and_add_spares
                        raid1_remove_disk
                        rdev->nr_pending == 0

atomic_inc(&rdev->nr_pending);
rcu_read_unlock()

                        p->rdev=NULL

conf->mirrors[i].rdev->data_offset
NULL pointer deref!!!

                        if (!test_bit(RemoveSynchronized,
                          &rdev->flags))
                         synchronize_rcu();
                         p->rdev=rdev

To fix the race condition, we add a new flag 'WantRemove' for rdev,
which means rdev will be removed from the raid array.
Before access conf->mirrors[i].rdev, we need to ensure the rdev
without 'WantRemove' bit.

Reported-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.h    |  4 ++++
 drivers/md/raid1.c | 28 ++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..ebab9340af11 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -205,6 +205,10 @@ enum flag_bits {
 				 * multiqueue device should check if there
 				 * is collision between write behind bios.
 				 */
+	WantRemove,		/* Before set conf->mirrors[i] as NULL,
+				 * we set the bit first, avoiding access the
+				 * conf->mirrors[i] after it set NULL.
+				 */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 34e26834ad28..838e619cd2d8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -622,7 +622,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		rdev = rcu_dereference(conf->mirrors[disk].rdev);
 		if (r1_bio->bios[disk] == IO_BLOCKED
 		    || rdev == NULL
-		    || test_bit(Faulty, &rdev->flags))
+		    || test_bit(Faulty, &rdev->flags)
+			|| test_bit(WantRemove, &rdev->flags))
 			continue;
 		if (!test_bit(In_sync, &rdev->flags) &&
 		    rdev->recovery_offset < this_sector + sectors)
@@ -751,7 +752,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 
 	if (best_disk >= 0) {
 		rdev = rcu_dereference(conf->mirrors[best_disk].rdev);
-		if (!rdev)
+		if (!rdev || test_bit(Faulty, &rdev->flags)
+				|| test_bit(WantRemove, &rdev->flags))
 			goto retry;
 		atomic_inc(&rdev->nr_pending);
 		sectors = best_good_sectors;
@@ -1389,7 +1391,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			break;
 		}
 		r1_bio->bios[i] = NULL;
-		if (!rdev || test_bit(Faulty, &rdev->flags)) {
+		if (!rdev || test_bit(Faulty, &rdev->flags)
+				|| test_bit(WantRemove, &rdev->flags)) {
 			if (i < conf->raid_disks)
 				set_bit(R1BIO_Degraded, &r1_bio->state);
 			continue;
@@ -1772,6 +1775,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 			p->head_position = 0;
 			rdev->raid_disk = mirror;
+			clear_bit(WantRemove, &rdev->flags);
 			err = 0;
 			/* As all devices are equivalent, we don't need a full recovery
 			 * if this was recently any drive of the array
@@ -1786,6 +1790,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			/* Add this device as a replacement */
 			clear_bit(In_sync, &rdev->flags);
 			set_bit(Replacement, &rdev->flags);
+			clear_bit(WantRemove, &rdev->flags);
 			rdev->raid_disk = mirror;
 			err = 0;
 			conf->fullsync = 1;
@@ -1825,16 +1830,26 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 			err = -EBUSY;
 			goto abort;
 		}
-		p->rdev = NULL;
+
+		/*
+		 * Before set p->rdev = NULL, we set WantRemove bit avoiding
+		 * race between rdev remove and issue bio, which can cause
+		 * NULL pointer deference of rdev by conf->mirrors[i].rdev.
+		 */
+		set_bit(WantRemove, &rdev->flags);
+
 		if (!test_bit(RemoveSynchronized, &rdev->flags)) {
 			synchronize_rcu();
 			if (atomic_read(&rdev->nr_pending)) {
 				/* lost the race, try later */
 				err = -EBUSY;
-				p->rdev = rdev;
+				clear_bit(WantRemove, &rdev->flags);
 				goto abort;
 			}
 		}
+
+		p->rdev = NULL;
+
 		if (conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
@@ -2732,7 +2747,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 
 		rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev == NULL ||
-		    test_bit(Faulty, &rdev->flags)) {
+		    test_bit(Faulty, &rdev->flags) ||
+			test_bit(WantRemove, &rdev->flags)) {
 			if (i < conf->raid_disks)
 				still_degraded = 1;
 		} else if (!test_bit(In_sync, &rdev->flags)) {
-- 
2.16.2.dirty

