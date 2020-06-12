Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6E1F771C
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLLOv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 12 Jun 2020 07:14:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbgFLLOv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 12 Jun 2020 07:14:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EBB32B495758755D9B24;
        Fri, 12 Jun 2020 19:14:48 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 19:14:42 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v4 06/15] md/raid5: set correct page offset for bi_io_vec in ops_run_io()
Date:   Fri, 12 Jun 2020 19:42:11 +0800
Message-ID: <20200612114220.13126-7-yuyufen@huawei.com>
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

After using r5pages for each sh->dev[i], we need to set correct offset
of that page for bi_io_vec when issue bio. The value of offset is zero
without using r5pages.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3ae2cc8cd1ea..9ab7f99406d6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1200,7 +1200,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				sh->dev[i].vec.bv_page = sh->dev[i].page;
 			bi->bi_vcnt = 1;
 			bi->bi_io_vec[0].bv_len = conf->stripe_size;
-			bi->bi_io_vec[0].bv_offset = 0;
+			bi->bi_io_vec[0].bv_offset = sh->dev[i].offset;
 			bi->bi_iter.bi_size = conf->stripe_size;
 			bi->bi_write_hint = sh->dev[i].write_hint;
 			if (!rrdev)
@@ -1254,7 +1254,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			sh->dev[i].rvec.bv_page = sh->dev[i].page;
 			rbi->bi_vcnt = 1;
 			rbi->bi_io_vec[0].bv_len = conf->stripe_size;
-			rbi->bi_io_vec[0].bv_offset = 0;
+			rbi->bi_io_vec[0].bv_offset = sh->dev[i].offset;
 			rbi->bi_iter.bi_size = conf->stripe_size;
 			rbi->bi_write_hint = sh->dev[i].write_hint;
 			sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
-- 
2.21.3

