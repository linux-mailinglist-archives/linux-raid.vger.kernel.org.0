Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB6220D2D
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgGOMmN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 08:42:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728975AbgGOMmF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 08:42:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC9CDAE6A19EA226AA00;
        Wed, 15 Jul 2020 20:42:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 20:41:51 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v6 07/15] md/raid5: resize stripes and set correct offset when reshape array
Date:   Wed, 15 Jul 2020 08:42:49 -0400
Message-ID: <20200715124257.3175816-8-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715124257.3175816-1-yuyufen@huawei.com>
References: <20200715124257.3175816-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When reshape array, we try to reuse shared pages of old stripe_head,
and allocate more for the new one if needed. At the same time, set
correct offset when call handle_stripe_expansion().

By the way, we call resize_stripes() only when grow raid array disks,
so that don't worry about memleak for old r5pages.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 50 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6f13ac9502a5..2702a1cb2281 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2492,10 +2492,20 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 		osh = get_free_stripe(conf, hash);
 		unlock_device_hash_lock(conf, hash);
 
-		for(i=0; i<conf->pool_size; i++) {
+		if (raid5_stripe_pages_shared(conf)) {
+			/* We reuse pages in r5pages of old stripe head */
+			for (i = 0; i < osh->pages.size; i++) {
+				nsh->pages.page[i] = osh->pages.page[i];
+				osh->pages.page[i] = NULL;
+			}
+		}
+
+		for (i = 0; i < conf->pool_size; i++) {
 			nsh->dev[i].page = osh->dev[i].page;
 			nsh->dev[i].orig_page = osh->dev[i].page;
+			nsh->dev[i].offset = osh->dev[i].offset;
 		}
+
 		nsh->hash_lock_index = hash;
 		free_stripe(conf->slab_cache, osh);
 		cnt++;
@@ -2542,17 +2552,41 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 
 	/* Step 4, return new stripes to service */
 	while(!list_empty(&newstripes)) {
+		struct page *p;
+		unsigned int offset;
 		nsh = list_entry(newstripes.next, struct stripe_head, lru);
 		list_del_init(&nsh->lru);
 
-		for (i=conf->raid_disks; i < newsize; i++)
-			if (nsh->dev[i].page == NULL) {
-				struct page *p = alloc_page(GFP_NOIO);
-				nsh->dev[i].page = p;
-				nsh->dev[i].orig_page = p;
+		 /* allocate shared pages it needed for new stripe_head */
+		if (raid5_stripe_pages_shared(conf)) {
+			for (i = 0; i < nsh->pages.size; i++) {
+				if (nsh->pages.page[i] == NULL) {
+					p = alloc_page(GFP_NOIO);
+					if (!p)
+						err = -ENOMEM;
+					nsh->pages.page[i] = p;
+				}
+			}
+		}
+
+		for (i = conf->raid_disks; i < newsize; i++) {
+			if (nsh->dev[i].page)
+				continue;
+
+			if (raid5_stripe_pages_shared(conf)) {
+				p = raid5_get_dev_page(nsh, i);
+				offset = raid5_get_page_offset(nsh, i);
+			} else {
+				p = alloc_page(GFP_NOIO);
 				if (!p)
 					err = -ENOMEM;
+				offset = 0;
 			}
+
+			nsh->dev[i].page = p;
+			nsh->dev[i].orig_page = p;
+			nsh->dev[i].offset = offset;
+		}
 		raid5_release_stripe(nsh);
 	}
 	/* critical section pass, GFP_NOIO no longer needed */
@@ -4475,7 +4509,9 @@ static void handle_stripe_expansion(struct r5conf *conf, struct stripe_head *sh)
 			/* place all the copies on one channel */
 			init_async_submit(&submit, 0, tx, NULL, NULL, NULL);
 			tx = async_memcpy(sh2->dev[dd_idx].page,
-					  sh->dev[i].page, 0, 0,
+					  sh->dev[i].page,
+					  sh2->dev[dd_idx].offset,
+					  sh->dev[i].offset,
 					  conf->stripe_size,
 					  &submit);
 
-- 
2.25.4

