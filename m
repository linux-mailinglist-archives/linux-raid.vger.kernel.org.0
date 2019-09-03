Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01260A7407
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfICTvM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 15:51:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTvM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 15:51:12 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i5Eno-0004so-7b
        for linux-raid@vger.kernel.org; Tue, 03 Sep 2019 19:49:20 +0000
Received: by mail-pg1-f199.google.com with SMTP id u1so11637027pgr.13
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 12:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EKlfWf9Y+qI71jPIGDJy5icLCG3fC1+uYBrLtD5L4E=;
        b=uYfUKx6ElqWXfM/034dQlY6sxpzbpkYvVNpdC+f3hJzZPunof6P6BKPZZb4bW39x8C
         p9r7jh5S93jLeQc3olSRxoGcLWIRLwdmbd6fMxKGoMWs3o6C6QZqbh9RCkJ7E4pArZQJ
         6YiD4q62B5b96bWtcHR5O7UdSeIs0CZmd5ljQW32Hjr4osApvJpQoHvRNaGpVLbrkrRb
         UjlRheSlCuyuUSr8J5T2AhOzzMLqZ7wYnxsnapyuwyAtrnkNcLQi2fOjh35TfzYHUZYM
         y90z8t+IPrPbjMZfUml+QzzRKCdUsYrUh3D1wWyCb3LydNZIXG7owaug7jYaNgbDtgyo
         7EhQ==
X-Gm-Message-State: APjAAAVCptCBc/FNX07yxLqU7Fv6nugkgbEDJemXRRFRf24n+fPeLVeH
        /1fsJMIkSE0G5saqil/Nghx1Uje49tHuz0FD0KX8lAuIxW8XDLwpe/YsDZgZ5Q6LmkSw4mMqpd0
        0+VTs7abSCAK8i65ux1AbKiADTRuXgQ4l1jcMvZc=
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr37442147plt.332.1567540158621;
        Tue, 03 Sep 2019 12:49:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXIOVHS2PXuiVAiDR4azrEPMlnjjXSTpS2s4/8ewq1cNGC0SHWkTPeyG3fNmqqLLshnb149w==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr37442132plt.332.1567540158347;
        Tue, 03 Sep 2019 12:49:18 -0700 (PDT)
Received: from localhost (201-93-37-171.dial-up.telesp.net.br. [201.93.37.171])
        by smtp.gmail.com with ESMTPSA id z189sm30949350pfb.137.2019.09.03.12.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:49:17 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        jay.vosburgh@canonical.com, liu.song.a23@gmail.com,
        nfbrown@suse.com, jes.sorensen@gmail.com, gpiccoli@canonical.com,
        Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.de>
Subject: [PATCH v4 1/2] md raid0/linear: Mark array as 'broken' and fail BIOs if a member is gone
Date:   Tue,  3 Sep 2019 16:49:00 -0300
Message-Id: <20190903194901.13524-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently md raid0/linear are not provided with any mechanism to validate
if an array member got removed or failed. The driver keeps sending BIOs
regardless of the state of array members, and kernel shows state 'clean'
in the 'array_state' sysfs attribute. This leads to the following
situation: if a raid0/linear array member is removed and the array is
mounted, some user writing to this array won't realize that errors are
happening unless they check dmesg or perform one fsync per written file.
Despite udev signaling the member device is gone, 'mdadm' cannot issue the
STOP_ARRAY ioctl successfully, given the array is mounted.

In other words, no -EIO is returned and writes (except direct ones) appear
normal. Meaning the user might think the wrote data is correctly stored in
the array, but instead garbage was written given that raid0 does stripping
(and so, it requires all its members to be working in order to not corrupt
data). For md/linear, writes to the available members will work fine, but
if the writes go to the missing member(s), it'll cause a file corruption
situation, whereas the portion of the writes to the missing devices aren't
written effectively.

This patch changes this behavior: we check if the block device's gendisk
is UP when submitting the BIO to the array member, and if it isn't, we flag
the md device as MD_BROKEN and fail subsequent I/Os to that device; a read
request to the array requiring data from a valid member is still completed.
While flagging the device as MD_BROKEN, we also show a rate-limited warning
in the kernel log.

A new array state 'broken' was added too: it mimics the state 'clean' in
every aspect, being useful only to distinguish if the array has some member
missing. We rely on the MD_BROKEN flag to put the array in the 'broken'
state. This state cannot be written in 'array_state' as it just shows
one or more members of the array are missing but acts like 'clean', it
wouldn't make sense to write it.

With this patch, the filesystem reacts much faster to the event of missing
array member: after some I/O errors, ext4 for instance aborts the journal
and prevents corruption. Without this change, we're able to keep writing
in the disk and after a machine reboot, e2fsck shows some severe fs errors
that demand fixing. This patch was tested in ext4 and xfs filesystems, and
requires a 'mdadm' counterpart to handle the 'broken' state.

Cc: Song Liu <songliubraving@fb.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

v3 -> v4:
* Use helper is_mddev_broken() to simplify the code on raid0/linear
drivers (thanks Song for the suggestion).
* Use test_and_set_bit() and remove a non-critical path "unlikely"
per Neil's suggestion (thanks Neil).

v2 -> v3:
* Rebased against md-next.
* Merged both patches in a single one (thanks Song for the
suggestion); now we fail BIOs and mark array as MD_BROKEN
when a member is missing. We rely in the MD_BROKEN flag
to set array to 'broken' state.
* Function is_missing_dev() was removed due to the above.

v1 -> v2:
* Added handling for md/linear 'broken' state;
* Check for is_missing_dev() instead of personality (thanks Neil for
the suggestion);
* Changed is_missing_dev() handlers to static;
* Print rate-limited warning in case of more members go away, not only
the first.

Cover-letter from v1:
lore.kernel.org/linux-block/20190729203135.12934-1-gpiccoli@canonical.com


 drivers/md/md-linear.c |  5 +++++
 drivers/md/md.c        | 22 ++++++++++++++++++----
 drivers/md/md.h        | 16 ++++++++++++++++
 drivers/md/raid0.c     |  6 ++++++
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 7354466ddc90..c766c559d36d 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -258,6 +258,11 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		     bio_sector < start_sector))
 		goto out_of_bounds;
 
+	if (unlikely(is_mddev_broken(tmp_dev->rdev, "linear"))) {
+		bio_io_error(bio);
+		return true;
+	}
+
 	if (unlikely(bio_end_sector(bio) > end_sector)) {
 		/* This bio crosses a device boundary, so we have to split it */
 		struct bio *split = bio_split(bio, end_sector - bio_sector,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b46bb143e3c5..73d5a1b04022 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -376,6 +376,11 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 	struct mddev *mddev = q->queuedata;
 	unsigned int sectors;
 
+	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
+
 	blk_queue_split(q, &bio);
 
 	if (mddev == NULL || mddev->pers == NULL) {
@@ -4158,12 +4163,17 @@ __ATTR_PREALLOC(resync_start, S_IRUGO|S_IWUSR,
  * active-idle
  *     like active, but no writes have been seen for a while (100msec).
  *
+ * broken
+ *     RAID0/LINEAR-only: same as clean, but array is missing a member.
+ *     It's useful because RAID0/LINEAR mounted-arrays aren't stopped
+ *     when a member is gone, so this state will at least alert the
+ *     user that something is wrong.
  */
 enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
-		   write_pending, active_idle, bad_word};
+		   write_pending, active_idle, broken, bad_word};
 static char *array_states[] = {
 	"clear", "inactive", "suspended", "readonly", "read-auto", "clean", "active",
-	"write-pending", "active-idle", NULL };
+	"write-pending", "active-idle", "broken", NULL };
 
 static int match_word(const char *word, char **list)
 {
@@ -4179,7 +4189,7 @@ array_state_show(struct mddev *mddev, char *page)
 {
 	enum array_state st = inactive;
 
-	if (mddev->pers && !test_bit(MD_NOT_READY, &mddev->flags))
+	if (mddev->pers && !test_bit(MD_NOT_READY, &mddev->flags)) {
 		switch(mddev->ro) {
 		case 1:
 			st = readonly;
@@ -4199,7 +4209,10 @@ array_state_show(struct mddev *mddev, char *page)
 				st = active;
 			spin_unlock(&mddev->lock);
 		}
-	else {
+
+		if (test_bit(MD_BROKEN, &mddev->flags) && st == clean)
+			st = broken;
+	} else {
 		if (list_empty(&mddev->disks) &&
 		    mddev->raid_disks == 0 &&
 		    mddev->dev_sectors == 0)
@@ -4313,6 +4326,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		break;
 	case write_pending:
 	case active_idle:
+	case broken:
 		/* these cannot be set */
 		break;
 	}
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1edcd967eb8e..c5e3ff398b59 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -251,6 +251,9 @@ enum mddev_flags {
 	MD_NOT_READY,		/* do_md_run() is active, so 'array_state'
 				 * must not report that array is ready yet
 				 */
+	MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
+				 * I/O in case an array member is gone/failed.
+				 */
 };
 
 enum mddev_sb_flags {
@@ -739,6 +742,19 @@ extern void mddev_create_wb_pool(struct mddev *mddev, struct md_rdev *rdev,
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
+static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
+{
+	int flags = rdev->bdev->bd_disk->flags;
+
+	if (!(flags & GENHD_FL_UP)) {
+		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
+			pr_warn("md: %s: %s array has a missing/failed member\n",
+				mdname(rdev->mddev), md_type);
+		return true;
+	}
+	return false;
+}
+
 static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *mddev)
 {
 	int faulty = test_bit(Faulty, &rdev->flags);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index bf5cf184a260..bc422eae2c95 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -586,6 +586,12 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 
 	zone = find_zone(mddev->private, &sector);
 	tmp_dev = map_sector(mddev, zone, sector, &sector);
+
+	if (unlikely(is_mddev_broken(tmp_dev, "raid0"))) {
+		bio_io_error(bio);
+		return true;
+	}
+
 	bio_set_dev(bio, tmp_dev->bdev);
 	bio->bi_iter.bi_sector = sector + zone->dev_start +
 		tmp_dev->data_offset;
-- 
2.17.1

