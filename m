Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F76115ACF
	for <lists+linux-raid@lfdr.de>; Sat,  7 Dec 2019 04:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLGDAU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Dec 2019 22:00:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfLGDAU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 6 Dec 2019 22:00:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE6586CB9A2199F5C4AC;
        Sat,  7 Dec 2019 11:00:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Dec 2019
 11:00:08 +0800
To:     <songliubraving@fb.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        <linux-raid@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>, <guiyao@huawei.com>
From:   "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>
Subject: [PATCH] md-bitmap: small cleanups
Message-ID: <b0701f30-5df9-059e-95f1-74a887782528@huawei.com>
Date:   Sat, 7 Dec 2019 11:00:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


In md_bitmap_unplug, bitmap->storage.filemap is double checked.

In md_bitmap_daemon_work, bitmap->storage.filemap should be checked
before reference.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/md/md-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 3ad18246fcb3..9860062bdc1e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1019,8 +1019,6 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 	/* look at each page to see if there are any set bits that need to be
 	 * flushed out to disk */
 	for (i = 0; i < bitmap->storage.file_pages; i++) {
-		if (!bitmap->storage.filemap)
-			return;
 		dirty = test_and_clear_page_attr(bitmap, i, BITMAP_PAGE_DIRTY);
 		need_write = test_and_clear_page_attr(bitmap, i,
 						      BITMAP_PAGE_NEEDWRITE);
@@ -1338,7 +1336,8 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 				   BITMAP_PAGE_DIRTY))
 			/* bitmap_unplug will handle the rest */
 			break;
-		if (test_and_clear_page_attr(bitmap, j,
+		if (bitmap->storage.filemap &&
+		    test_and_clear_page_attr(bitmap, j,
 					     BITMAP_PAGE_NEEDWRITE)) {
 			write_page(bitmap, bitmap->storage.filemap[j], 0);
 		}
-- 
2.24.0.windows.2

