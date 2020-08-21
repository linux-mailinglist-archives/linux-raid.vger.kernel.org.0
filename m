Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2824C988
	for <lists+linux-raid@lfdr.de>; Fri, 21 Aug 2020 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHUB3w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Aug 2020 21:29:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48814 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgHUB3w (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 20 Aug 2020 21:29:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E3870F6F848AB82DB325;
        Fri, 21 Aug 2020 09:29:48 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 09:29:38 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Song Liu <song@kernel.org>, <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] md: Simplify code with existing definition RESYNC_SECTORS in raid10.c
Date:   Fri, 21 Aug 2020 09:29:18 +0800
Message-ID: <20200821012918.3302-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

#define RESYNC_SECTORS (RESYNC_BLOCK_SIZE >> 9)

"RESYNC_BLOCK_SIZE/512" is equal to "RESYNC_BLOCK_SIZE >> 9", replace it
with RESYNC_SECTORS.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/md/raid10.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index e8fa327339171c7..da12e3daf6fa8d9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4466,8 +4466,8 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		last = conf->reshape_progress - 1;
 		sector_nr = last & ~(sector_t)(conf->geo.chunk_mask
 					       & conf->prev.chunk_mask);
-		if (sector_nr + RESYNC_BLOCK_SIZE/512 < last)
-			sector_nr = last + 1 - RESYNC_BLOCK_SIZE/512;
+		if (sector_nr + RESYNC_SECTORS < last)
+			sector_nr = last + 1 - RESYNC_SECTORS;
 	} else {
 		/* 'next' is after the last device address that we
 		 * might write to for this chunk in the new layout
@@ -4489,8 +4489,8 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		last  = sector_nr | (conf->geo.chunk_mask
 				     & conf->prev.chunk_mask);
 
-		if (sector_nr + RESYNC_BLOCK_SIZE/512 <= last)
-			last = sector_nr + RESYNC_BLOCK_SIZE/512 - 1;
+		if (sector_nr + RESYNC_SECTORS <= last)
+			last = sector_nr + RESYNC_SECTORS - 1;
 	}
 
 	if (need_flush ||
-- 
1.8.3


