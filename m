Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9D2429B5
	for <lists+linux-raid@lfdr.de>; Wed, 12 Aug 2020 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHLMtE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Aug 2020 08:49:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbgHLMtA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 12 Aug 2020 08:49:00 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E6B781BC4D8EDF2BF5F;
        Wed, 12 Aug 2020 20:48:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 20:48:51 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH 11/12] md/raid5: resize stripe_head when reshape array
Date:   Wed, 12 Aug 2020 08:49:30 -0400
Message-ID: <20200812124931.2584743-12-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812124931.2584743-1-yuyufen@huawei.com>
References: <20200812124931.2584743-1-yuyufen@huawei.com>
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
and allocate more for the new one if needed.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 189ef51e853a..265d1c22309b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2533,6 +2533,12 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 		osh = get_free_stripe(conf, hash);
 		unlock_device_hash_lock(conf, hash);
 
+#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
+	for (i = 0; i < osh->nr_pages; i++) {
+		nsh->pages[i] = osh->pages[i];
+		osh->pages[i] = NULL;
+	}
+#endif
 		for(i=0; i<conf->pool_size; i++) {
 			nsh->dev[i].page = osh->dev[i].page;
 			nsh->dev[i].orig_page = osh->dev[i].page;
@@ -2587,6 +2593,23 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 		nsh = list_entry(newstripes.next, struct stripe_head, lru);
 		list_del_init(&nsh->lru);
 
+#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
+		for (i = 0; i < nsh->nr_pages; i++) {
+			if (nsh->pages[i])
+				continue;
+			nsh->pages[i] = alloc_page(GFP_NOIO);
+			if (!nsh->pages[i])
+				err = -ENOMEM;
+		}
+
+		for (i = conf->raid_disks; i < newsize; i++) {
+			if (nsh->dev[i].page)
+				continue;
+			nsh->dev[i].page = raid5_get_dev_page(nsh, i);
+			nsh->dev[i].orig_page = nsh->dev[i].page;
+			nsh->dev[i].offset = raid5_get_page_offset(nsh, i);
+		}
+#else
 		for (i=conf->raid_disks; i < newsize; i++)
 			if (nsh->dev[i].page == NULL) {
 				struct page *p = alloc_page(GFP_NOIO);
@@ -2596,6 +2619,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 				if (!p)
 					err = -ENOMEM;
 			}
+#endif
 		raid5_release_stripe(nsh);
 	}
 	/* critical section pass, GFP_NOIO no longer needed */
-- 
2.25.4

