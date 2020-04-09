Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2A1A35B9
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgDIOSG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 10:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:40250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDIOSG (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 10:18:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE759AF90;
        Thu,  9 Apr 2020 14:18:04 +0000 (UTC)
From:   colyli@suse.de
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     mhocko@suse.com, kent.overstreet@gmail.com,
        guoqing.jiang@cloud.ionos.com, Coly Li <colyli@suse.de>
Subject: [PATCH v3 4/4] md: remove redundant memalloc scope API usage
Date:   Thu,  9 Apr 2020 22:17:23 +0800
Message-Id: <20200409141723.24447-5-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200409141723.24447-1-colyli@suse.de>
References: <20200409141723.24447-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Coly Li <colyli@suse.de>

In mddev_create_serial_pool(), memalloc scope APIs memalloc_noio_save()
and memalloc_noio_restore() are used when allocating memory by calling
mempool_create_kmalloc_pool(). After adding the memalloc scope APIs in
raid array suspend context, it is unncessary to explict call them around
mempool_create_kmalloc_pool() any longer.

This patch removes the redundant memalloc scope APIs in
mddev_create_serial_pool().

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1a8e1bb3a7f4..76ecf7b8cfc8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -227,13 +227,13 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		goto abort;
 
 	if (mddev->serial_info_pool == NULL) {
-		unsigned int noio_flag;
-
-		noio_flag = memalloc_noio_save();
+		/*
+		 * already in memalloc noio context by
+		 * mddev_suspend()
+		 */
 		mddev->serial_info_pool =
 			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
 						sizeof(struct serial_info));
-		memalloc_noio_restore(noio_flag);
 		if (!mddev->serial_info_pool) {
 			rdevs_uninit_serial(mddev);
 			pr_err("can't alloc memory pool for serialization\n");
-- 
2.25.0

