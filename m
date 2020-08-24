Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30A24F1BD
	for <lists+linux-raid@lfdr.de>; Mon, 24 Aug 2020 06:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHXEME (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Aug 2020 00:12:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36673 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725271AbgHXEME (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 24 Aug 2020 00:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598242322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=PtLoG0S3vzlaRrKzFpcy9t73aqOtBzYImVl0ZfDUaRA=;
        b=E4OtMhxI3f+a8b0r7/RdIug9H+HihTHtS1ABVqwkX4WOI7VM69DLyKc8MPnNA+Yhe3m8X0
        vr15kA1D/c19vaIS0COBWBYvdNOKUE/Rj6xhv8GwPjkf69hHqbGOIG5vj0DDl5UEVrbesM
        Rs2k1QWW5s2Bcizi0YuE7Z6tRlz0cgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-qM3TgJXIP82Se8XzhbirNg-1; Mon, 24 Aug 2020 00:11:58 -0400
X-MC-Unique: qM3TgJXIP82Se8XzhbirNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C1DC1885DA7;
        Mon, 24 Aug 2020 04:11:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4AD11944D;
        Mon, 24 Aug 2020 04:11:53 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org, song@kernel.org
Cc:     heinzm@redhat.com, ncroxon@redhat.com,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de
Subject: [PATCH V4 1/5] md/raid10: move codes related with submitting discard bio into one function
Date:   Mon, 24 Aug 2020 12:11:44 +0800
Message-Id: <1598242308-9619-2-git-send-email-xni@redhat.com>
In-Reply-To: <1598242308-9619-1-git-send-email-xni@redhat.com>
References: <1598242308-9619-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

These codes can be used in raid10. So we can move these codes into
md.c. raid0 and raid10 can share these codes.

Reviewed-by: Coly Li <colyli@suse.de>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c    | 23 +++++++++++++++++++++++
 drivers/md/md.h    |  3 +++
 drivers/md/raid0.c | 15 ++-------------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6072782..10743be 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8583,6 +8583,29 @@ void md_write_end(struct mddev *mddev)
 
 EXPORT_SYMBOL(md_write_end);
 
+/* This is used by raid0 and raid10 */
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
index d9c4e6b..bae3bd5 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -713,6 +713,9 @@ extern void md_write_end(struct mddev *mddev);
 extern void md_done_sync(struct mddev *mddev, int blocks, int ok);
 extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
+extern void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
+				struct bio *bio,
+				sector_t dev_start, sector_t dev_end);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
 extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f54a449..2868294 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -510,7 +510,6 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 
 	for (disk = 0; disk < zone->nb_dev; disk++) {
 		sector_t dev_start, dev_end;
-		struct bio *discard_bio = NULL;
 		struct md_rdev *rdev;
 
 		if (disk < start_disk_index)
@@ -533,18 +532,8 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 
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

