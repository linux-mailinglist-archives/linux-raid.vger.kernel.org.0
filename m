Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F681A3153
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDIIz4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 04:55:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIIz4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 04:55:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 644F0354B5BE8CDD8761;
        Thu,  9 Apr 2020 16:55:53 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:55:42 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <song@kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] md/r5cache: remove set but not used 'offset'
Date:   Thu, 9 Apr 2020 16:54:16 +0800
Message-ID: <20200409085416.47724-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Fix the following gcc warning:

drivers/md/raid5-cache.c:198:11: warning: variable ‘offset’ set but not
used [-Wunused-but-set-variable]
  sector_t offset;
           ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/md/raid5-cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 9b6da759dca2..eea14fa9e59b 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -195,9 +195,7 @@ struct r5l_log {
 static inline sector_t r5c_tree_index(struct r5conf *conf,
 				      sector_t sect)
 {
-	sector_t offset;
-
-	offset = sector_div(sect, conf->chunk_sectors);
+	sector_div(sect, conf->chunk_sectors);
 	return sect;
 }
 
-- 
2.17.2

