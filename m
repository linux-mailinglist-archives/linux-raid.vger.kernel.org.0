Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D93457E3
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFNIv2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 04:51:28 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:50052 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFNIv0 (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Fri, 14 Jun 2019 04:51:26 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 14 Jun 2019 02:51:16 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH 3/5] md-bitmap: create and destroy wb_info_pool with the change of backlog
Date:   Fri, 14 Jun 2019 17:10:37 +0800
Message-Id: <20190614091039.32461-4-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190614091039.32461-1-gqjiang@suse.com>
References: <20190614091039.32461-1-gqjiang@suse.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Since we can enable write-behind mode by write backlog node,
so create wb_info_pool if the mode is just enabled, also call
call md_bitmap_update_sb to make user aware the write-behind
mode is enabled. Conversely, wb_info_pool should be destroyed
when write-behind mode is disabled.

Beside above, it is better to update bitmap sb if we change
the number of max_write_behind.

Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 drivers/md/md-bitmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 3a62a46b75c7..e3403092c238 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2461,12 +2461,26 @@ static ssize_t
 backlog_store(struct mddev *mddev, const char *buf, size_t len)
 {
 	unsigned long backlog;
+	unsigned long old_mwb = mddev->bitmap_info.max_write_behind;
 	int rv = kstrtoul(buf, 10, &backlog);
 	if (rv)
 		return rv;
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
 	mddev->bitmap_info.max_write_behind = backlog;
+	if (!backlog && mddev->wb_info_pool) {
+		/* wb_info_pool is not needed if backlog is zero */
+		mempool_destroy(mddev->wb_info_pool);
+		mddev->wb_info_pool = NULL;
+	} else if (backlog && !mddev->wb_info_pool) {
+		/* wb_info_pool is needed since backlog is not zero */
+		struct md_rdev *rdev;
+
+		rdev_for_each(rdev, mddev)
+			mddev_create_wb_pool(mddev, rdev, false);
+	}
+	if (old_mwb != backlog)
+		md_bitmap_update_sb(mddev->bitmap);
 	return len;
 }
 
-- 
2.12.3

