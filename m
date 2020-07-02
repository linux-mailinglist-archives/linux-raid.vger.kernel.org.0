Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60A72122ED
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgGBMFf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 08:05:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728890AbgGBMFd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 08:05:33 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2AC0CCFA9887D57E8C82;
        Thu,  2 Jul 2020 20:05:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Jul 2020
 20:05:16 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v5 05/16] md/raid5: allocate and free shared pages of r5pages
Date:   Thu, 2 Jul 2020 08:06:17 -0400
Message-ID: <20200702120628.777303-6-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702120628.777303-1-yuyufen@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When PAGE_SIZE is bigger than stripe_size, try to allocate pages of
r5pages in grow_buffres() and free these pages in shrink_buffers().
Then, set sh->dev[i].page and sh->dev[i].offset as the page in
array. Without enable shared page, we just set offset as value of '0'.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 113 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 694f6713369d..920e1e147e8a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -448,15 +448,72 @@ static struct stripe_head *get_free_stripe(struct r5conf *conf, int hash)
 	return sh;
 }
 
+/*
+ * Try to free all pages in r5pages array.
+ */
+static void free_stripe_pages(struct stripe_head *sh)
+{
+	int i;
+	struct page *p;
+
+	/* Have not allocate page pool */
+	if (!sh->pages.page)
+		return;
+
+	for (i = 0; i < sh->pages.size; i++) {
+		p = sh->pages.page[i];
+		if (p)
+			put_page(p);
+		sh->pages.page[i] = NULL;
+	}
+}
+
+/*
+ * Allocate pages for r5pages.
+ */
+static int alloc_stripe_pages(struct stripe_head *sh, gfp_t gfp)
+{
+	int i;
+	struct page *p;
+
+	for (i = 0; i < sh->pages.size; i++) {
+		/* The page have allocated. */
+		if (sh->pages.page[i])
+			continue;
+
+		p = alloc_page(gfp);
+		if (!p) {
+			free_stripe_pages(sh);
+			return -ENOMEM;
+		}
+		sh->pages.page[i] = p;
+	}
+	return 0;
+}
+
 static void shrink_buffers(struct stripe_head *sh)
 {
 	struct page *p;
 	int i;
 	int num = sh->raid_conf->pool_size;
 
-	for (i = 0; i < num ; i++) {
+	if (raid5_stripe_pages_shared(sh->raid_conf))
+		free_stripe_pages(sh); /* Free pages in r5pages */
+
+	for (i = 0; i < num; i++) {
 		WARN_ON(sh->dev[i].page != sh->dev[i].orig_page);
 		p = sh->dev[i].page;
+
+		/*
+		 * If we use pages in r5pages, these pages have been
+		 * freed in free_stripe_pages().
+		 */
+		if (raid5_stripe_pages_shared(sh->raid_conf)) {
+			if (p)
+				sh->dev[i].page = NULL;
+			continue;
+		}
+
 		if (!p)
 			continue;
 		sh->dev[i].page = NULL;
@@ -469,14 +526,26 @@ static int grow_buffers(struct stripe_head *sh, gfp_t gfp)
 	int i;
 	int num = sh->raid_conf->pool_size;
 
+	if (raid5_stripe_pages_shared(sh->raid_conf) &&
+			alloc_stripe_pages(sh, gfp))
+		return -ENOMEM;
+
 	for (i = 0; i < num; i++) {
 		struct page *page;
+		unsigned int offset;
 
-		if (!(page = alloc_page(gfp))) {
-			return 1;
+		if (raid5_stripe_pages_shared(sh->raid_conf)) {
+			page = raid5_get_dev_page(sh, i);
+			offset = raid5_get_page_offset(sh, i);
+		} else {
+			page = alloc_page(gfp);
+			if (!page)
+				return -ENOMEM;
+			offset = 0;
 		}
 		sh->dev[i].page = page;
 		sh->dev[i].orig_page = page;
+		sh->dev[i].offset = offset;
 	}
 
 	return 0;
@@ -2146,11 +2215,35 @@ static void raid_run_ops(struct stripe_head *sh, unsigned long ops_request)
 
 static void free_stripe(struct kmem_cache *sc, struct stripe_head *sh)
 {
+	kfree(sh->pages.page);
+
 	if (sh->ppl_page)
 		__free_page(sh->ppl_page);
 	kmem_cache_free(sc, sh);
 }
 
+static int
+init_stripe_shared_pages(struct stripe_head *sh, struct r5conf *conf)
+{
+	int nr_page;
+	int cnt;
+
+	BUG_ON(conf->stripe_size > PAGE_SIZE);
+	if (!raid5_stripe_pages_shared(conf) || sh->pages.page)
+		return 0;
+
+	/* Each of the sh->dev[i] need one conf->stripe_size */
+	cnt = PAGE_SIZE / conf->stripe_size;
+	nr_page = (conf->raid_disks + cnt - 1) / cnt;
+
+	sh->pages.page = kcalloc(nr_page, sizeof(struct page *), GFP_KERNEL);
+	if (!sh->pages.page)
+		return -ENOMEM;
+	sh->pages.size = nr_page;
+
+	return 0;
+}
+
 static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 	int disks, struct r5conf *conf)
 {
@@ -2177,14 +2270,20 @@ static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 
 		if (raid5_has_ppl(conf)) {
 			sh->ppl_page = alloc_page(gfp);
-			if (!sh->ppl_page) {
-				free_stripe(sc, sh);
-				sh = NULL;
-			}
+			if (!sh->ppl_page)
+				goto fail;
 		}
+
+		if (init_stripe_shared_pages(sh, conf))
+			goto fail;
 	}
 	return sh;
+
+fail:
+	free_stripe(sc, sh);
+	return NULL;
 }
+
 static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
 {
 	struct stripe_head *sh;
-- 
2.25.4

