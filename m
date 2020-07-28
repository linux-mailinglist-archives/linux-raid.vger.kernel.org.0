Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848F12303C0
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgG1HSl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 03:18:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727858AbgG1HSl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 03:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595920720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ai44TO0alBst3dmeZtXw5rVbLHgY1Tu3eMACwm5mbHg=;
        b=gHrHRQDaUkiJqfiPmBVMF1X7I5owVRkQkIkoQXlbshwFOIpLO6/vKCcPvBWHG8qC4dqk6S
        sWZrAFOO3Wuz6jNJTr975rPrjppxkFAOgrm9rPRCcJ8w516++fEksZO1micbtY3L85MA+2
        Ur6sJTX0b3ZxXT7RDGy3aFY+23b6LVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-sAS0jDQkPSKM5Dr8sR53Mw-1; Tue, 28 Jul 2020 03:18:35 -0400
X-MC-Unique: sAS0jDQkPSKM5Dr8sR53Mw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7303800470;
        Tue, 28 Jul 2020 07:18:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3FA90E70;
        Tue, 28 Jul 2020 07:18:29 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH V2 1/3] Move codes related with submitting discard bio into one function
Date:   Tue, 28 Jul 2020 15:18:21 +0800
Message-Id: <1595920703-6125-2-git-send-email-xni@redhat.com>
In-Reply-To: <1595920703-6125-1-git-send-email-xni@redhat.com>
References: <1595920703-6125-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

These codes can be used in raid10. So we can move these codes into
md.c. raid0 and raid10 can share these codes.

Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c    | 22 ++++++++++++++++++++++
 drivers/md/md.h    |  3 +++
 drivers/md/raid0.c | 15 ++-------------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 07e5b67..2b8f654 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8559,6 +8559,28 @@ void md_write_end(struct mddev *mddev)
 
 EXPORT_SYMBOL(md_write_end);
 
+void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
+				struct bio *bio,
+				sector_t dev_start, sector_t dev_end)
+{
+	struct bio *discard_bio = NULL;
+
+	if (__blkdev_issue_discard(rdev->bdev,
+	    dev_start + rdev->data_offset,
+	    dev_end - dev_start, GFP_NOIO, 0, &discard_bio) ||
+	    !discard_bio)
+		return;
+
+	bio_chain(discard_bio, bio);
+	bio_clone_blkg_association(discard_bio, bio);
+	if (mddev->gendisk)
+		trace_block_bio_remap(bdev_get_queue(rdev->bdev),
+			discard_bio, disk_devt(mddev->gendisk),
+			bio->bi_iter.bi_sector);
+	submit_bio_noacct(discard_bio);
+}
+EXPORT_SYMBOL(md_submit_discard_bio);
+
 /* md_allow_write(mddev)
  * Calling this ensures that the array is marked 'active' so that writes
  * may proceed without blocking.  It is important to call this before
diff --git a/drivers/md/md.h b/drivers/md/md.h
index c26fa8b..83ae77e 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -710,6 +710,9 @@ extern void md_write_end(struct mddev *mddev);
 extern void md_done_sync(struct mddev *mddev, int blocks, int ok);
 extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
+extern void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
+				struct bio *bio,
+				sector_t dev_start, sector_t dev_end);
 
 extern int mddev_congested(struct mddev *mddev, int bits);
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index e9e91c8..e37fe8a 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -525,7 +525,6 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 
 	for (disk = 0; disk < zone->nb_dev; disk++) {
 		sector_t dev_start, dev_end;
-		struct bio *discard_bio = NULL;
 		struct md_rdev *rdev;
 
 		if (disk < start_disk_index)
@@ -548,18 +547,8 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 
 		rdev = conf->devlist[(zone - conf->strip_zone) *
 			conf->strip_zone[0].nb_dev + disk];
-		if (__blkdev_issue_discard(rdev->bdev,
-			dev_start + zone->dev_start + rdev->data_offset,
-			dev_end - dev_start, GFP_NOIO, 0, &discard_bio) ||
-		    !discard_bio)
-			continue;
-		bio_chain(discard_bio, bio);
-		bio_clone_blkg_association(discard_bio, bio);
-		if (mddev->gendisk)
-			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
-				discard_bio, disk_devt(mddev->gendisk),
-				bio->bi_iter.bi_sector);
-		submit_bio_noacct(discard_bio);
+		dev_start += zone->dev_start;
+		md_submit_discard_bio(mddev, rdev, bio, dev_start, dev_end);
 	}
 	bio_endio(bio);
 }
-- 
2.7.5

