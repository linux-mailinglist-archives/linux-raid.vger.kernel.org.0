Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BE14A72C
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jan 2020 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgA0P01 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jan 2020 10:26:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729146AbgA0P00 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Jan 2020 10:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580138786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3MHwEnmX+Xgwqww0FNEQ1SuxG06m7GkK77ivzDYVq+Q=;
        b=ftNn5sJCKa5PAJrQJi0RQlCLpMFEDPsT7NQ6GzmMoC2tP4QseeK/xC74OsL+6niTXeD88J
        v3uaxdruOV5uEJdRFbkbWxHRtnWUBpXFiPIdTg3JbCzO4mOTvNimTeul5v1vkpir5xR3o9
        Ha9T650dWeXlP+6n/vHhqnqBw4/bzg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-tNky1pSuM3Ge8B4ZKHs8Yg-1; Mon, 27 Jan 2020 10:26:22 -0500
X-MC-Unique: tNky1pSuM3Ge8B4ZKHs8Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C2D7A62A;
        Mon, 27 Jan 2020 15:26:21 +0000 (UTC)
Received: from redhat (ovpn-123-160.rdu2.redhat.com [10.10.123.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73D875DA66;
        Mon, 27 Jan 2020 15:26:21 +0000 (UTC)
Date:   Mon, 27 Jan 2020 10:26:19 -0500
From:   David Jeffery <djeffery@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     Song Liu <song@kernel.org>
Subject: [PATCH] md/raid1: release pending accounting for an I/O only after
 write-behind is also finished
Message-ID: <20200127152619.GA3596@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When using RAID1 and write-behind, md can deadlock when errors occur. With
write-behind, r1bio structs can be accounted by raid1 as queued but not
counted as pending. The pending count is dropped when the original bio is
returned complete but write-behind for the r1bio may still be active.

This breaks the accounting used in some conditions to know when the raid1
md device has reached an idle state. It can result in calls to
freeze_array deadlocking. freeze_array will never complete from a negative
"unqueued" value being calculated due to a queued count larger than the
pending count.

To properly account for write-behind, move the call to allow_barrier from
call_bio_endio to raid_end_bio_io. When using write-behind, md can call
call_bio_endio before all write-behind I/O is complete. Using
raid_end_bio_io for the point to call allow_barrier will release the
pending count at a point where all I/O for an r1bio, even write-behind, is
done.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---

 raid1.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)


diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 201fd8aec59a..0196a9d9f7e9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
 static void call_bio_endio(struct r1bio *r1_bio)
 {
 	struct bio *bio = r1_bio->master_bio;
-	struct r1conf *conf = r1_bio->mddev->private;
 
 	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
 		bio->bi_status = BLK_STS_IOERR;
 
 	bio_endio(bio);
-	/*
-	 * Wake up any possible resync thread that waits for the device
-	 * to go idle.
-	 */
-	allow_barrier(conf, r1_bio->sector);
 }
 
 static void raid_end_bio_io(struct r1bio *r1_bio)
 {
 	struct bio *bio = r1_bio->master_bio;
+	struct r1conf *conf = r1_bio->mddev->private;
 
 	/* if nobody has done the final endio yet, do it now */
 	if (!test_and_set_bit(R1BIO_Returned, &r1_bio->state)) {
@@ -305,6 +300,12 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
 
 		call_bio_endio(r1_bio);
 	}
+	/*
+	 * Wake up any possible resync thread that waits for the device
+	 * to go idle.  All I/Os, even write-behind writes, are done.
+	 */
+	allow_barrier(conf, r1_bio->sector);
+
 	free_r1bio(r1_bio);
 }
 

