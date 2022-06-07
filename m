Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113CA53F3B2
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jun 2022 04:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiFGCE7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jun 2022 22:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiFGCE5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jun 2022 22:04:57 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B7B8BC5
        for <linux-raid@vger.kernel.org>; Mon,  6 Jun 2022 19:04:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654567486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxWrsHg4sk5slNmau8zIJxW+cr6IUp9Z4ri0Z4od9UQ=;
        b=BAYF+jcnmt92GANi6wIsK91BsHnUJiSemfYRefQA4ljnm9U1LXI/cBiBJ/2s0HTx0n11y1
        UgJ4bj3pDjnlK+SUv5Z2kIe9F+umYOgHYp7zt+AkzupMnMwQ6/mT6Gy0LKr9LUNWusODll
        +FqTwj7+BJu7B5qxaYc+IiVfJf2vh08=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     song@kernel.org
Cc:     buczek@molgen.mpg.de, logang@deltatee.com,
        linux-raid@vger.kernel.org
Subject: [PATCH 2/2] md: unlock mddev before reap sync_thread in action_store
Date:   Tue,  7 Jun 2022 10:03:57 +0800
Message-Id: <20220607020357.14831-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220607020357.14831-1-guoqing.jiang@linux.dev>
References: <20220607020357.14831-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Since the bug which commit 8b48ec23cc51a ("md: don't unregister sync_thread
with reconfig_mutex held") fixed is related with action_store path, other
callers which reap sync_thread didn't need to be changed.

Let's pull md_unregister_thread from md_reap_sync_thread, then fix previous
bug with belows.

1. unlock mddev before md_reap_sync_thread in action_store.
2. save reshape_position before unlock, then restore it to ensure position
   not changed accidentally by others.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/md/dm-raid.c |  1 +
 drivers/md/md.c      | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9526ccbedafb..d43b8075c055 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3725,6 +3725,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
 		if (mddev->sync_thread) {
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_unregister_thread(&mddev->sync_thread);
 			md_reap_sync_thread(mddev);
 		}
 	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2e83a19e3aba..4d70672f8ea8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4830,6 +4830,12 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			if (work_pending(&mddev->del_work))
 				flush_workqueue(md_misc_wq);
 			if (mddev->sync_thread) {
+				sector_t save_rp = mddev->reshape_position;
+
+				mddev_unlock(mddev);
+				md_unregister_thread(&mddev->sync_thread);
+				mddev_lock_nointr(mddev);
+				mddev->reshape_position = save_rp;
 				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 				md_reap_sync_thread(mddev);
 			}
@@ -6197,6 +6203,7 @@ static void __md_stop_writes(struct mddev *mddev)
 		flush_workqueue(md_misc_wq);
 	if (mddev->sync_thread) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		md_unregister_thread(&mddev->sync_thread);
 		md_reap_sync_thread(mddev);
 	}
 
@@ -9303,6 +9310,7 @@ void md_check_recovery(struct mddev *mddev)
 			 * ->spare_active and clear saved_raid_disk
 			 */
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_unregister_thread(&mddev->sync_thread);
 			md_reap_sync_thread(mddev);
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -9338,6 +9346,7 @@ void md_check_recovery(struct mddev *mddev)
 			goto unlock;
 		}
 		if (mddev->sync_thread) {
+			md_unregister_thread(&mddev->sync_thread);
 			md_reap_sync_thread(mddev);
 			goto unlock;
 		}
@@ -9417,8 +9426,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 	sector_t old_dev_sectors = mddev->dev_sectors;
 	bool is_reshaped = false;
 
-	/* resync has finished, collect result */
-	md_unregister_thread(&mddev->sync_thread);
+	/* sync_thread should be unregistered, collect result */
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
 	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    mddev->degraded != mddev->raid_disks) {
-- 
2.31.1

