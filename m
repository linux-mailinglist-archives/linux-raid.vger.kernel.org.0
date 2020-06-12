Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602241F7725
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFLLPC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 12 Jun 2020 07:15:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbgFLLO5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 12 Jun 2020 07:14:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0B2E4DA8C7A09FECF0D5;
        Fri, 12 Jun 2020 19:14:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 19:14:44 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v4 08/15] md/raid5: resize stripes and set correct offset when reshape array
Date:   Fri, 12 Jun 2020 19:42:13 +0800
Message-ID: <20200612114220.13126-9-yuyufen@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612114220.13126-1-yuyufen@huawei.com>
References: <20200612114220.13126-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When reshape array, we try to reuse shared pages of old stripe_head,
and allocate more if needed. Then, set correct offset when call
handle_stripe_expansion().

By the way, we call resize_stripes() only when grow raid array disks,
so that don't worry about memleak for old r5pages.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 51 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 289e7a7eecdf..f8c945645272 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2486,10 +2486,20 @@ static int resize_stripes(struct r5conf *conf, int newsize)
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
@@ -2536,17 +2546,42 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 
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
+		/*
+		 * If we use r5pages, means, pages.size is not zero,
+		 * allocate pages it needed for new stripe_head.
+		 */
+		for (i = 0; i < nsh->pages.size; i++) {
+			if (nsh->pages.page[i] == NULL) {
+				p = alloc_page(GFP_NOIO);
+				if (!p)
+					err = -ENOMEM;
+				nsh->pages.page[i] = p;
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
@@ -4470,7 +4505,9 @@ static void handle_stripe_expansion(struct r5conf *conf, struct stripe_head *sh)
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
2.21.3

