Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8432457E2
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFNIv0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 04:51:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:35882 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFNIv0 (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Fri, 14 Jun 2019 04:51:26 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 14 Jun 2019 02:51:18 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH 4/5] md-bitmap: create and destroy wb_info_pool with the change of bitmap
Date:   Fri, 14 Jun 2019 17:10:38 +0800
Message-Id: <20190614091039.32461-5-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190614091039.32461-1-gqjiang@suse.com>
References: <20190614091039.32461-1-gqjiang@suse.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The write-behind attribute is part of bitmap, since bitmap
can be added/removed dynamically with the followings.

1. mdadm --grow /dev/md0 --bitmap=none
2. mdadm --grow /dev/md0 --bitmap=internal --write-behind

So we need to destroy wb_info_pool in md_bitmap_destroy,
and create the pool before load bitmap.

Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 drivers/md/md-bitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e3403092c238..a6e260010682 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1789,6 +1789,8 @@ void md_bitmap_destroy(struct mddev *mddev)
 		return;
 
 	md_bitmap_wait_behind_writes(mddev);
+	mempool_destroy(mddev->wb_info_pool);
+	mddev->wb_info_pool = NULL;
 
 	mutex_lock(&mddev->bitmap_info.mutex);
 	spin_lock(&mddev->lock);
@@ -1899,10 +1901,14 @@ int md_bitmap_load(struct mddev *mddev)
 	sector_t start = 0;
 	sector_t sector = 0;
 	struct bitmap *bitmap = mddev->bitmap;
+	struct md_rdev *rdev;
 
 	if (!bitmap)
 		goto out;
 
+	rdev_for_each(rdev, mddev)
+		mddev_create_wb_pool(mddev, rdev, true);
+
 	if (mddev_is_clustered(mddev))
 		md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
 
-- 
2.12.3

