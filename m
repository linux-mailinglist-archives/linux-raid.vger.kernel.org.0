Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACF1C83F3
	for <lists+linux-raid@lfdr.de>; Thu,  7 May 2020 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgEGH4V (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 03:56:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbgEGH4B (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 May 2020 03:56:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7689DCDF2CE26A1BADFD;
        Thu,  7 May 2020 15:55:58 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Alasdair Kergon" <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 09/10] md: use existing definition RESYNC_SECTORS
Date:   Thu, 7 May 2020 15:50:59 +0800
Message-ID: <20200507075100.1779-10-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200507075100.1779-1-thunder.leizhen@huawei.com>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

"RESYNC_BLOCK_SIZE/512" is equal to "RESYNC_BLOCK_SIZE >> 9", replace it
with RESYNC_SECTORS.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/md/raid10.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 948afe720fca..ac4273f804e8 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4483,8 +4483,8 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
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
@@ -4506,8 +4506,8 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		last  = sector_nr | (conf->geo.chunk_mask
 				     & conf->prev.chunk_mask);
 
-		if (sector_nr + RESYNC_BLOCK_SIZE/512 <= last)
-			last = sector_nr + RESYNC_BLOCK_SIZE/512 - 1;
+		if (sector_nr + RESYNC_SECTORS <= last)
+			last = sector_nr + RESYNC_SECTORS - 1;
 	}
 
 	if (need_flush ||
-- 
2.26.0.106.g9fadedd


