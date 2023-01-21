Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02DC6762C0
	for <lists+linux-raid@lfdr.de>; Sat, 21 Jan 2023 02:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjAUBrk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Jan 2023 20:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUBrk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 20 Jan 2023 20:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4346ACB3
        for <linux-raid@vger.kernel.org>; Fri, 20 Jan 2023 17:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674265612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c20aRnwXS3Yx904nneF3F2amHq6d6YaEJApxGVEn3hc=;
        b=J6ti55raCm3hUv+mdsRBYR/xsYdQ6iOTKRrn0Rx6y4Qej+LkvrPy/z+QGa6N+W68tPaOmU
        MCLjZ83FTVbGCSB8vOpaqqk9AHDkstVgSq2EaBT8Cln/IdVW5Jly2UEH0dj20ZrVu2forv
        BG8pK3uzB/foOxkOzDU0WOe2wTDyvBw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-naCTJAOEMuS2lYXdFW_JRg-1; Fri, 20 Jan 2023 20:46:49 -0500
X-MC-Unique: naCTJAOEMuS2lYXdFW_JRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC28C380663A;
        Sat, 21 Jan 2023 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-10.pek2.redhat.com [10.72.13.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D252940C6EC4;
        Sat, 21 Jan 2023 01:46:35 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, ming.lei@redhat.com,
        ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH 1/1] md/raid0: Add mddev->io_acct_cnt for raid0_quiesce
Date:   Sat, 21 Jan 2023 09:46:33 +0800
Message-Id: <20230121014633.97763-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It has added io_acct_set for raid0/raid5 io accounting and it needs to
alloc md_io_acct in the i/o path. They are free when the bios come back
from member disks. Now we don't have a method to monitor if those bios
are all come back. In the takeover process, it needs to free the raid0
memory resource including the memory pool for md_io_acct. But maybe some
bios are still not returned. When those bios are returned, it can cause
panic bcause of introducing NULL pointer or invalid address.

This patch adds io_acct_cnt. So when stopping raid0, it can use this
to wait until all bios come back. And I did a simple performance test
with fio:

-direct=1 -ioengine=libaio -iodepth=128 -bs=64K -rw=write -numjobs=1
With the patch set: 2676MB/s, without the patch set: 2670MB/s
-direct=1 -ioengine=libaio -iodepth=128 -bs=64K -rw=read -numjobs=1
With the patch set: 4676MB/s, without the patch set: 4654MB/s

Reported-by: Fine Fan <ffan@redhat.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c    | 23 ++++++++++++++++++++++-
 drivers/md/md.h    |  9 ++++++---
 drivers/md/raid0.c |  6 ++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 04c067cf2f53..100c1327e90b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -686,6 +686,7 @@ void mddev_init(struct mddev *mddev)
 	atomic_set(&mddev->flush_pending, 0);
 	init_waitqueue_head(&mddev->sb_wait);
 	init_waitqueue_head(&mddev->recovery_wait);
+	init_waitqueue_head(&mddev->wait_io_acct);
 	mddev->reshape_position = MaxSector;
 	mddev->reshape_backwards = 0;
 	mddev->last_sync_action = "none";
@@ -8607,13 +8608,28 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
+static void io_acct_release(struct percpu_ref *ref)
+{
+	struct mddev *mddev = container_of(ref, struct mddev, io_acct_cnt);
+
+	wake_up(&mddev->wait_io_acct);
+}
+
 int acct_bioset_init(struct mddev *mddev)
 {
 	int err = 0;
 
-	if (!bioset_initialized(&mddev->io_acct_set))
+	if (!bioset_initialized(&mddev->io_acct_set)) {
+		err = percpu_ref_init(&mddev->io_acct_cnt, io_acct_release,
+			PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
+		if (err)
+			return err;
+
 		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
 			offsetof(struct md_io_acct, bio_clone), 0);
+		if (err)
+			percpu_ref_exit(&mddev->io_acct_cnt);
+	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(acct_bioset_init);
@@ -8621,6 +8637,7 @@ EXPORT_SYMBOL_GPL(acct_bioset_init);
 void acct_bioset_exit(struct mddev *mddev)
 {
 	bioset_exit(&mddev->io_acct_set);
+	percpu_ref_exit(&mddev->io_acct_cnt);
 }
 EXPORT_SYMBOL_GPL(acct_bioset_exit);
 
@@ -8628,9 +8645,11 @@ static void md_end_io_acct(struct bio *bio)
 {
 	struct md_io_acct *md_io_acct = bio->bi_private;
 	struct bio *orig_bio = md_io_acct->orig_bio;
+	struct mddev *mddev = md_io_acct->mddev;
 
 	orig_bio->bi_status = bio->bi_status;
 
+	percpu_ref_put(&mddev->io_acct_cnt);
 	bio_end_io_acct(orig_bio, md_io_acct->start_time);
 	bio_put(bio);
 	bio_endio(orig_bio);
@@ -8653,6 +8672,8 @@ void md_account_bio(struct mddev *mddev, struct bio **bio)
 	md_io_acct = container_of(clone, struct md_io_acct, bio_clone);
 	md_io_acct->orig_bio = *bio;
 	md_io_acct->start_time = bio_start_io_acct(*bio);
+	md_io_acct->mddev = mddev;
+	percpu_ref_get(&mddev->io_acct_cnt);
 
 	clone->bi_end_io = md_end_io_acct;
 	clone->bi_private = md_io_acct;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 6335cb86e52e..c0e869bdde42 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -513,6 +513,8 @@ struct mddev {
 						   * metadata and bitmap writes
 						   */
 	struct bio_set			io_acct_set; /* for raid0 and raid5 io accounting */
+	struct percpu_ref		io_acct_cnt;
+	wait_queue_head_t		wait_io_acct;
 
 	/* Generic flush handling.
 	 * The last to finish preflush schedules a worker to submit
@@ -710,9 +712,10 @@ struct md_thread {
 };
 
 struct md_io_acct {
-	struct bio *orig_bio;
-	unsigned long start_time;
-	struct bio bio_clone;
+	struct mddev	*mddev;
+	struct bio	*orig_bio;
+	unsigned long	start_time;
+	struct bio	bio_clone;
 };
 
 #define THREAD_WAKEUP  0
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index b536befd8898..47c394b39503 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -753,6 +753,12 @@ static void *raid0_takeover(struct mddev *mddev)
 
 static void raid0_quiesce(struct mddev *mddev, int quiesce)
 {
+	if (quiesce) {
+		percpu_ref_kill(&mddev->io_acct_cnt);
+		wait_event(mddev->wait_io_acct,
+			percpu_ref_is_zero(&mddev->io_acct_cnt));
+	} else
+		percpu_ref_resurrect(&mddev->io_acct_cnt);
 }
 
 static struct md_personality raid0_personality=
-- 
2.32.0 (Apple Git-132)

