Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24F61967
	for <lists+linux-raid@lfdr.de>; Mon,  8 Jul 2019 05:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfGHDL3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 7 Jul 2019 23:11:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727745AbfGHDL3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 7 Jul 2019 23:11:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E509E9D8813B73F24A2E;
        Mon,  8 Jul 2019 11:11:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 11:11:08 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <neilb@suse.com>, <liu.song.a23@gmail.com>
CC:     <linux-raid@vger.kernel.org>, Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] md/raid1: remove the unnecessary plug in raid1d()
Date:   Mon, 8 Jul 2019 11:28:04 +0800
Message-ID: <20190708032804.4503-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When raid1d() submits a lot of IO, block plug can improve IO merge
and increase IO throughput. But, after commit 18022a1bd37 ("md/raid1/10:
add missed blk plug"), flush_pending_writes have added start/finish
plug by itself.

Except flush_pending_writes(), other processing in raid1d() would
not submit a lot of IO. They may issue some IO, but these IOs are
synchronous, i.e. submit bio and wait it finish. Plug can increase
io latency, which is not expected.

Thus, we may need to remove the unneceessary start/finish plug.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2aa36e570e04..1c9b501b091a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2490,7 +2490,6 @@ static void raid1d(struct md_thread *thread)
 	unsigned long flags;
 	struct r1conf *conf = mddev->private;
 	struct list_head *head = &conf->retry_list;
-	struct blk_plug plug;
 	int idx;
 
 	md_check_recovery(mddev);
@@ -2516,7 +2515,6 @@ static void raid1d(struct md_thread *thread)
 		}
 	}
 
-	blk_start_plug(&plug);
 	for (;;) {
 
 		flush_pending_writes(conf);
@@ -2552,7 +2550,6 @@ static void raid1d(struct md_thread *thread)
 		if (mddev->sb_flags & ~(1<<MD_SB_CHANGE_PENDING))
 			md_check_recovery(mddev);
 	}
-	blk_finish_plug(&plug);
 }
 
 static int init_resync(struct r1conf *conf)
-- 
2.17.2

