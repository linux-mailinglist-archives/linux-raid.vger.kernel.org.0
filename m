Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77EA43877
	for <lists+linux-raid@lfdr.de>; Thu, 13 Jun 2019 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfFMPGD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Jun 2019 11:06:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:18337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbfFMOKt (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 13 Jun 2019 10:10:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 07:10:48 -0700
X-ExtLoop1: 1
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2019 07:10:47 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     axboe@kernel.dk
Cc:     linux-raid@vger.kernel.org, songliubraving@fb.com
Subject: [PATCH] md: fix for divide error in status_resync
Date:   Thu, 13 Jun 2019 16:11:41 +0200
Message-Id: <20190613141141.15483-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Stopping external metadata arrays during resync/recovery causes
retries, loop of interrupting and starting reconstruction, until it
hit at good moment to stop completely. While these retries
curr_mark_cnt can be small- especially on HDD drives, so subtraction
result can be smaller than 0. However it is casted to uint without
checking. As a result of it the status bar in /proc/mdstat while stopping
is strange (it jumps between 0% and 99%).

The real problem occurs here after commit 72deb455b5ec ("block: remove
CONFIG_LBDAF"). Sector_div() macro has been changed, now the
divisor is casted to uint32. For db = -8 the divisior(db/32-1) becomes 0.

Check if db value can be really counted and replace these macro by
div64_u64() inline.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
---
 drivers/md/md.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 04f4f131f9d6..9a8b258ce1ef 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7607,9 +7607,9 @@ static void status_unused(struct seq_file *seq)
 static int status_resync(struct seq_file *seq, struct mddev *mddev)
 {
 	sector_t max_sectors, resync, res;
-	unsigned long dt, db;
-	sector_t rt;
-	int scale;
+	unsigned long dt, db = 0;
+	sector_t rt, curr_mark_cnt, resync_mark_cnt;
+	int scale, recovery_active;
 	unsigned int per_milli;
 
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
@@ -7709,11 +7709,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	 */
 	dt = ((jiffies - mddev->resync_mark) / HZ);
 	if (!dt) dt++;
-	db = (mddev->curr_mark_cnt - atomic_read(&mddev->recovery_active))
-		- mddev->resync_mark_cnt;
+
+	curr_mark_cnt = mddev->curr_mark_cnt;
+	recovery_active = atomic_read(&mddev->recovery_active);
+	resync_mark_cnt = mddev->resync_mark_cnt;
+
+	if (curr_mark_cnt >= (recovery_active + resync_mark_cnt))
+		db = curr_mark_cnt - (recovery_active + resync_mark_cnt);
 
 	rt = max_sectors - resync;    /* number of remaining sectors */
-	sector_div(rt, db/32+1);
+	rt = div64_u64(rt, db/32+1);
 	rt *= dt;
 	rt >>= 5;
 
-- 
2.16.4

