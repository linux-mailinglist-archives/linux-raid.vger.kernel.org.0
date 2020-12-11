Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3968D2D724B
	for <lists+linux-raid@lfdr.de>; Fri, 11 Dec 2020 09:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbgLKIwp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 11 Dec 2020 03:52:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9162 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392280AbgLKIwJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 11 Dec 2020 03:52:09 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cskyg1PgPz15bRJ;
        Fri, 11 Dec 2020 16:50:51 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:51:16 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] md/raid10: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:51:45 +0800
Message-ID: <20201211085145.2708-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/md/raid10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b7bca6703df8..acf4df3d971f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2459,7 +2459,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 			s = PAGE_SIZE >> 9;
 
 		rdev = conf->mirrors[dr].rdev;
-		addr = r10_bio->devs[0].addr + sect,
+		addr = r10_bio->devs[0].addr + sect;
 		ok = sync_page_io(rdev,
 				  addr,
 				  s << 9,
-- 
2.22.0

