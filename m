Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0341A35B8
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgDIOSE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 10:18:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDIOSE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 10:18:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 059F2AF92;
        Thu,  9 Apr 2020 14:18:02 +0000 (UTC)
From:   colyli@suse.de
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     mhocko@suse.com, kent.overstreet@gmail.com,
        guoqing.jiang@cloud.ionos.com, Coly Li <colyli@suse.de>
Subject: [PATCH v3 3/4] raid5: update code comment of scribble_alloc()
Date:   Thu,  9 Apr 2020 22:17:22 +0800
Message-Id: <20200409141723.24447-4-colyli@suse.de>
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

Code comments of scribble_alloc() is outdated for a while. This patch
update the comments in function header for the new parameter list.

Suggested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/raid5.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 190dd70db514..ab8067f9ce8c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2215,10 +2215,13 @@ static int grow_stripes(struct r5conf *conf, int num)
 }
 
 /**
- * scribble_len - return the required size of the scribble region
+ * scribble_alloc - allocate percpu scribble buffer for required size
+ *		    of the scribble region
+ * @percpu - from for_each_present_cpu() of the caller
  * @num - total number of disks in the array
+ * @cnt - scribble objs count for required size of the scribble region
  *
- * The size must be enough to contain:
+ * The scribble buffer size must be enough to contain:
  * 1/ a struct page pointer for each device in the array +2
  * 2/ room to convert each entry in (1) to its corresponding dma
  *    (dma_map_page()) or page (page_address()) address.
-- 
2.25.0

