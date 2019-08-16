Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C084B9031E
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHPNfB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 09:35:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54664 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfHPNfB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 09:35:01 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hycNf-0000oG-9j
        for linux-raid@vger.kernel.org; Fri, 16 Aug 2019 13:34:59 +0000
Received: by mail-qk1-f199.google.com with SMTP id j81so5267040qke.23
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 06:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMgyJz5cP/cLZxpMyAQ6fwneZ+H/SLqNfT4XWYL3XWk=;
        b=oQMMRdxbON+FbDyCDBPgmmxHAoKwRYJvyvWTFMUzrdJv834oY0gQNYMHMuqQwqyb15
         l3dtj66F2D8IS+NnpKaN1g3oXSdFxOues85Z6uvQZA5dgrcol+2xVQUBANY6y5Fy1TgV
         8bKQCHKp9O2Jh3LTGusxEpmfohYIULOJrpVd0Ni5HDgmt7TucyAqL2YiJ+93H/BHfaKf
         bwHmmDAJBgWKxLZtvdmlYW/svCrva5cIn9T9YjJz4ZiY+/sHtEkeNUGCgeNLpOkGkdoJ
         sxBMzesXj42W1qznqpVoegO79UeV4wdBuvGU53gEePhG0XOBK55cOYLgA6r9urBagGjQ
         VojQ==
X-Gm-Message-State: APjAAAVGv0aWd7uvACcvSp2yAFmNYV355Wb4zK4/ucNu7OrWFR5loh0A
        pJp03bGyCvEINlOwmCoPHDY8T3rIn9YZJWN4uVOeQm0m6DJQEWJO+SKqPNCzkyQFC7p+yOeNwrf
        5jjHMtOmZ3Zpc2e5cA/H9B3rupXc2+SrWHC2hAWs=
X-Received: by 2002:a05:620a:144d:: with SMTP id i13mr8878218qkl.197.1565962497839;
        Fri, 16 Aug 2019 06:34:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpFpAst8B+U+sLZCTK4ARWCT9s7fD0hENh/Bq14SHpaUS2p14lDyvzy6EjpLCi0vDpur/xFg==
X-Received: by 2002:a05:620a:144d:: with SMTP id i13mr8878192qkl.197.1565962497556;
        Fri, 16 Aug 2019 06:34:57 -0700 (PDT)
Received: from localhost ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id q62sm3226982qkb.69.2019.08.16.06.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:34:56 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2] md raid0/linear: Fail BIOs if their underlying block device is gone
Date:   Fri, 16 Aug 2019 10:34:41 -0300
Message-Id: <20190816133441.29350-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently md raid0/linear are not provided with any mechanism to validate
if an array member got removed or failed. The driver keeps sending BIOs
regardless of the state of array members. This leads to the following
situation: if a raid0/linear array member is removed and the array is
mounted, some user writing to this array won't realize that errors are
happening unless they check dmesg or perform one fsync per written file.

In other words, no -EIO is returned and writes (except direct ones) appear
normal. Meaning the user might think the wrote data is correctly stored in
the array, but instead garbage was written given that raid0 does stripping
(and so, it requires all its members to be working in order to not corrupt
data). For md/linear, writes to the available members will work fine, but
if the writes go to the missing member(s), it'll cause a file corruption
situation, whereas the portion of the writes to the missing device aren't
written effectively.

This patch proposes a small change in this behavior: we check if the block
device's gendisk is UP when submitting the BIO to the array member, and if
it isn't, we flag the md device as broken and fail subsequent write I/Os.
If the array is restored (i.e., the missing array members are back) and
the array is restarted, the flag is cleared and we can submit BIOs normally.

With this patch, the filesystem reacts much faster to the event of missing
array member: after some I/O errors, ext4 for instance aborts the journal
and prevents corruption. Without this change, we're able to keep writing
in the disk and after a machine reboot, e2fsck shows some severe fs errors
that demand fixing. This patch was tested in ext4 and xfs filesystems.

Cc: NeilBrown <neilb@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

v1 -> v2:
* Fail only WRITE requests (thanks Neil for the suggestion);
* Added handling for md-linear failures too (thanks Song for
the suggestion).


 drivers/md/md-linear.c | 6 ++++++
 drivers/md/md.c        | 5 +++++
 drivers/md/md.h        | 3 +++
 drivers/md/raid0.c     | 7 +++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 7354466ddc90..ed2297541414 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -258,6 +258,12 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		     bio_sector < start_sector))
 		goto out_of_bounds;
 
+	if (unlikely(!(tmp_dev->rdev->bdev->bd_disk->flags & GENHD_FL_UP))) {
+		set_bit(MD_BROKEN, &mddev->flags);
+		bio_io_error(bio);
+		return true;
+	}
+
 	if (unlikely(bio_end_sector(bio) > end_sector)) {
 		/* This bio crosses a device boundary, so we have to split it */
 		struct bio *split = bio_split(bio, end_sector - bio_sector,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..ba4de55eea13 100644
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
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..5d7c1cad4946 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -248,6 +248,9 @@ enum mddev_flags {
 	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
 				 * without explicitly holding reconfig_mutex.
 				 */
+	MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
+				 * I/O in case an array member is gone/failed.
+				 */
 };
 
 enum mddev_sb_flags {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index bf5cf184a260..ef896ee7198b 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -586,6 +586,13 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 
 	zone = find_zone(mddev->private, &sector);
 	tmp_dev = map_sector(mddev, zone, sector, &sector);
+
+	if (unlikely(!(tmp_dev->bdev->bd_disk->flags & GENHD_FL_UP))) {
+		set_bit(MD_BROKEN, &mddev->flags);
+		bio_io_error(bio);
+		return true;
+	}
+
 	bio_set_dev(bio, tmp_dev->bdev);
 	bio->bi_iter.bi_sector = sector + zone->dev_start +
 		tmp_dev->data_offset;
-- 
2.22.0

