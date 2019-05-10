Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362C51992A
	for <lists+linux-raid@lfdr.de>; Fri, 10 May 2019 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEJHpq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 May 2019 03:45:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfEJHpp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 May 2019 03:45:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96F24308339A;
        Fri, 10 May 2019 07:45:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1147210027BB;
        Fri, 10 May 2019 07:45:41 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     heinzm@redhat.com, ncroxon@redhat.com, songliubraving@fb.com
Subject: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to r5l_flush_stripe_to_journal
Date:   Fri, 10 May 2019 15:45:39 +0800
Message-Id: <1557474339-18962-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 10 May 2019 07:45:45 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When journal device supports volatile write cache, it needs to flush to make sure data is settled
down in journal device. It's the usage of function r5l_flush_stripe_to_raid. The data is flushed
from stripe cache to journal device. Rename the function name to make it more proper.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid5-cache.c | 2 +-
 drivers/md/raid5.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index cbbe6b6..689a59e 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1294,7 +1294,7 @@ static void r5l_log_flush_endio(struct bio *bio)
  * only write stripes of an io_unit to raid disks till the io_unit is the first
  * one whose data/parity is in log.
  */
-void r5l_flush_stripe_to_raid(struct r5l_log *log)
+void r5l_flush_stripe_to_journal(struct r5l_log *log)
 {
 	bool do_flush;
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7fde645..56d9e6e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6206,7 +6206,7 @@ static int handle_active_stripes(struct r5conf *conf, int group,
 	release_inactive_stripe_list(conf, temp_inactive_list,
 				     NR_STRIPE_HASH_LOCKS);
 
-	r5l_flush_stripe_to_raid(conf->log);
+	r5l_flush_stripe_to_journal(conf->log);
 	if (release_inactive) {
 		spin_lock_irq(&conf->device_lock);
 		return 0;
@@ -6262,7 +6262,7 @@ static void raid5_do_work(struct work_struct *work)
 
 	flush_deferred_bios(conf);
 
-	r5l_flush_stripe_to_raid(conf->log);
+	r5l_flush_stripe_to_journal(conf->log);
 
 	async_tx_issue_pending_all();
 	blk_finish_plug(&plug);
@@ -6349,7 +6349,7 @@ static void raid5d(struct md_thread *thread)
 
 	flush_deferred_bios(conf);
 
-	r5l_flush_stripe_to_raid(conf->log);
+	r5l_flush_stripe_to_journal(conf->log);
 
 	async_tx_issue_pending_all();
 	blk_finish_plug(&plug);
-- 
2.7.5

