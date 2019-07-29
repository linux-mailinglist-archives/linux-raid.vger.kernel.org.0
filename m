Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56D798D0
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfG2UKc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 16:10:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41997 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbfG2TeZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 15:34:25 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsBPc-00072L-5o
        for linux-raid@vger.kernel.org; Mon, 29 Jul 2019 19:34:24 +0000
Received: by mail-pg1-f197.google.com with SMTP id z14so31850227pgr.22
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 12:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A55J61QpsVvab7TmtGxzd7FgTJSRQiuBNgN4th6hVbE=;
        b=sBltORtjyrB622itDZdWPolBZ8JecYDnoQGHxeXnAyAXGTurCpoLNMK5J3HE9HZ4Bj
         XUDdmxXxyGaHxtO2zAtEH9ibxKvMu67/V+cHrTlf0UcemT27CkQ0Z7lexT3hS8/DgrWm
         41DeZrqSRQeOHKUx2bq0gUNDQtFsg0ndc6SqGdIGp9FcpQfvLitIX0sIiuv60rY8ek4o
         dBIkeIB/ub3TPNbw3WptpRUMMgXy8+peMMs6C+zBHpvEzFQHPYoUZHTsxirNqUPkjjFC
         3SOOq9WZAviTV8VjvkRUfYLK3ikmUl/g6luIY1yJyo8xZz0CpsQ/OTb8wBqCKQJr4ib3
         JBTg==
X-Gm-Message-State: APjAAAVP2dWJ3ITc+3F+tf3ZllLzQhDvI/zfIduxOWeN8tEoVbtXlDIQ
        TT+3HHQj3Ibd0PYNCenG5bBtYPCMuIAcGqluSSC1pJ/KrGdE1triPIuN6adUgmQnneb9IgMXcqs
        8qKRvi6gY5dlwXneZs3c0cbQsksMBTSmqSui6hzg=
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr37050759pld.41.1564428862305;
        Mon, 29 Jul 2019 12:34:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxWECzCbAQxIwnmjYqImcSoYKsv3xNBRik3H0+WMu4EiUmnsmLVWTPudi9tpYcExfXGMrtDXg==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr37050736pld.41.1564428862083;
        Mon, 29 Jul 2019 12:34:22 -0700 (PDT)
Received: from localhost ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id m9sm106222912pgr.24.2019.07.29.12.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 12:34:21 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH] md/raid0: Fail BIOs if their underlying block device is gone
Date:   Mon, 29 Jul 2019 16:33:59 -0300
Message-Id: <20190729193359.11040-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently md/raid0 is not provided with any mechanism to validate if
an array member got removed or failed. The driver keeps sending BIOs
regardless of the state of array members. This leads to the following
situation: if a raid0 array member is removed and the array is mounted,
some user writing to this array won't realize that errors are happening
unless they check kernel log or perform one fsync per written file.

In other words, no -EIO is returned and writes (except direct ones) appear
normal. Meaning the user might think the wrote data is correctly stored in
the array, but instead garbage was written given that raid0 does stripping
(and so, it requires all its members to be working in order to not corrupt
data).

This patch proposes a small change in this behavior: we check if the block
device's gendisk is UP when submitting the BIO to the array member, and if
it isn't, we flag the md device as broken and fail subsequent I/Os. In case
the array is restored (i.e., the missing array member is back), the flag is
cleared and we can submit BIOs normally.

With this patch, the filesystem reacts much faster to the event of missing
array member: after some I/O errors, ext4 for instance aborts the journal
and prevents corruption. Without this change, we're able to keep writing
in the disk and after a machine reboot, e2fsck shows some severe fs errors
that demand fixing. This patch was tested in both ext4 and xfs
filesystems.

Cc: NeilBrown <neilb@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

After an attempt to change the way md/raid0 fails in case one of its
members gets removed (see [0]), we got not so great feedback from the
community and also, the change was complex and had corner cases.
One of the points which seemed to be a consensus in that attempt was
that raid0 could benefit from a way of failing faster in case a member
gets removed. This patch aims for that, in a simpler way than earlier
proposed. Any feedbacks are welcome, thanks in advance!


Guilherme


[0] lore.kernel.org/linux-block/20190418220448.7219-1-gpiccoli@canonical.com


 drivers/md/md.c    | 5 +++++
 drivers/md/md.h    | 3 +++
 drivers/md/raid0.c | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..fba49918d591 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -376,6 +376,11 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 	struct mddev *mddev = q->queuedata;
 	unsigned int sectors;
 
+	if (unlikely(test_bit(MD_BROKEN, &mddev->flags))) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
+
 	blk_queue_split(q, &bio);
 
 	if (mddev == NULL || mddev->pers == NULL) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..41552e615c4c 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -248,6 +248,9 @@ enum mddev_flags {
 	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
 				 * without explicitly holding reconfig_mutex.
 				 */
+	MD_BROKEN,              /* This is used in RAID-0 only, to stop I/O
+				 * in case an array member is gone/failed.
+				 */
 };
 
 enum mddev_sb_flags {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index bf5cf184a260..58a9cc5193bf 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -586,6 +586,14 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 
 	zone = find_zone(mddev->private, &sector);
 	tmp_dev = map_sector(mddev, zone, sector, &sector);
+
+	if (unlikely(!(tmp_dev->bdev->bd_disk->flags & GENHD_FL_UP))) {
+		set_bit(MD_BROKEN, &mddev->flags);
+		bio_io_error(bio);
+		return true;
+	}
+
+	clear_bit(MD_BROKEN, &mddev->flags);
 	bio_set_dev(bio, tmp_dev->bdev);
 	bio->bi_iter.bi_sector = sector + zone->dev_start +
 		tmp_dev->data_offset;
-- 
2.22.0

