Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A475D1C2
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jul 2019 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfGBOaJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jul 2019 10:30:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfGBOaI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jul 2019 10:30:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7981A1CC68EC19C4B931;
        Tue,  2 Jul 2019 22:30:06 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 22:30:04 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-raid@vger.kernel.org>, <songliubraving@fb.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] raid1: use an int as the return value of raise_barrier()
Date:   Tue, 2 Jul 2019 22:35:48 +0800
Message-ID: <20190702143548.133020-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Using a sector_t as the return value is misleading, because
raise_barrier() only return 0 or -EINTR.

Also add comments for the return values of raise_barrier().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/md/raid1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index da06bb47195b..c1ea5e0c3cf6 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -846,8 +846,10 @@ static void flush_pending_writes(struct r1conf *conf)
  * backgroup IO calls must call raise_barrier.  Once that returns
  *    there is no normal IO happeing.  It must arrange to call
  *    lower_barrier when the particular background IO completes.
+ *
+ * Will return -EINTR if resync/recovery is interrupted, else return 0.
  */
-static sector_t raise_barrier(struct r1conf *conf, sector_t sector_nr)
+static int raise_barrier(struct r1conf *conf, sector_t sector_nr)
 {
 	int idx = sector_to_idx(sector_nr);
 
-- 
2.22.0

