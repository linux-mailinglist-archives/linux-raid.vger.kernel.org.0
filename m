Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6C1B265E
	for <lists+linux-raid@lfdr.de>; Tue, 21 Apr 2020 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgDUMk5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 08:40:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728899AbgDUMk4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 08:40:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 777B773DE9CD120007F8;
        Tue, 21 Apr 2020 20:40:51 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 20:40:43 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <colyli@suse.de>,
        <xni@redhat.com>, <houtao1@huawei.com>, <yuyufen@huawei.com>
Subject: [PATCH RFC v2 4/8] md/raid5: set correct page offset for bi_io_vec in ops_run_io()
Date:   Tue, 21 Apr 2020 20:39:48 +0800
Message-ID: <20200421123952.49025-5-yuyufen@huawei.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421123952.49025-1-yuyufen@huawei.com>
References: <20200421123952.49025-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

After using r5pages for each sh->dev[i], we need to set correct offset
of that page for bi_io_vec when issue bio. The value of offset is zero
without using r5pages.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0d1e5bf4e5f2..87c3bbfadf54 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1194,7 +1194,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				sh->dev[i].vec.bv_page = sh->dev[i].page;
 			bi->bi_vcnt = 1;
 			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
-			bi->bi_io_vec[0].bv_offset = 0;
+			bi->bi_io_vec[0].bv_offset = sh->dev[i].offset;
 			bi->bi_iter.bi_size = STRIPE_SIZE;
 			bi->bi_write_hint = sh->dev[i].write_hint;
 			if (!rrdev)
@@ -1248,7 +1248,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			sh->dev[i].rvec.bv_page = sh->dev[i].page;
 			rbi->bi_vcnt = 1;
 			rbi->bi_io_vec[0].bv_len = STRIPE_SIZE;
-			rbi->bi_io_vec[0].bv_offset = 0;
+			rbi->bi_io_vec[0].bv_offset = sh->dev[i].offset;
 			rbi->bi_iter.bi_size = STRIPE_SIZE;
 			rbi->bi_write_hint = sh->dev[i].write_hint;
 			sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
-- 
2.21.1

