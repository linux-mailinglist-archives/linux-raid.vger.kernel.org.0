Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C21A35B7
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgDIOSD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 10:18:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:40202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDIOSD (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 10:18:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EF5DAD93;
        Thu,  9 Apr 2020 14:18:01 +0000 (UTC)
From:   colyli@suse.de
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     mhocko@suse.com, kent.overstreet@gmail.com,
        guoqing.jiang@cloud.ionos.com, Coly Li <colyli@suse.de>
Subject: [PATCH v3 2/4] raid5: remove gfp flags from scribble_alloc()
Date:   Thu,  9 Apr 2020 22:17:21 +0800
Message-Id: <20200409141723.24447-3-colyli@suse.de>
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

Using GFP_NOIO flag to call scribble_alloc() from resize_chunk() does
not have the expected behavior. kvmalloc_array() inside scribble_alloc()
which receives the GFP_NOIO flag will eventually call kmalloc_node() to
allocate physically continuous pages.

Now we have memalloc scope APIs in mddev_suspend()/mddev_resume() to
prevent memory reclaim I/Os during raid array suspend context, calling
to kvmalloc_array() with GFP_KERNEL flag may avoid deadlock of recursive
I/O as expected.

This patch removes the useless gfp flags from parameters list of
scribble_alloc(), and call kvmalloc_array() with GFP_KERNEL flag. The
incorrect GFP_NOIO flag does not exist anymore.

Fixes: b330e6a49dc3 ("md: convert to kvmalloc")
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/raid5.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ba00e9877f02..190dd70db514 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2228,14 +2228,19 @@ static int grow_stripes(struct r5conf *conf, int num)
  * of the P and Q blocks.
  */
 static int scribble_alloc(struct raid5_percpu *percpu,
-			  int num, int cnt, gfp_t flags)
+			  int num, int cnt)
 {
 	size_t obj_size =
 		sizeof(struct page *) * (num+2) +
 		sizeof(addr_conv_t) * (num+2);
 	void *scribble;
 
-	scribble = kvmalloc_array(cnt, obj_size, flags);
+	/*
+	 * If here is in raid array suspend context, it is in memalloc noio
+	 * context as well, there is no potential recursive memory reclaim
+	 * I/Os with the GFP_KERNEL flag.
+	 */
+	scribble = kvmalloc_array(cnt, obj_size, GFP_KERNEL);
 	if (!scribble)
 		return -ENOMEM;
 
@@ -2267,8 +2272,7 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 
 		percpu = per_cpu_ptr(conf->percpu, cpu);
 		err = scribble_alloc(percpu, new_disks,
-				     new_sectors / STRIPE_SECTORS,
-				     GFP_NOIO);
+				     new_sectors / STRIPE_SECTORS);
 		if (err)
 			break;
 	}
@@ -6759,8 +6763,7 @@ static int alloc_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu
 			       conf->previous_raid_disks),
 			   max(conf->chunk_sectors,
 			       conf->prev_chunk_sectors)
-			   / STRIPE_SECTORS,
-			   GFP_KERNEL)) {
+			   / STRIPE_SECTORS)) {
 		free_scratch_buffer(conf, percpu);
 		return -ENOMEM;
 	}
-- 
2.25.0

