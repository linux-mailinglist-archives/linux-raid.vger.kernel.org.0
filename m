Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6AF7771C
	for <lists+linux-raid@lfdr.de>; Sat, 27 Jul 2019 07:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfG0F5K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 27 Jul 2019 01:57:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfG0F5J (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 27 Jul 2019 01:57:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D2016E93E39642FB5EE3;
        Sat, 27 Jul 2019 13:57:06 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 13:57:04 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <songliubraving@fb.com>, <linux-raid@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] raid1: factor out a common routine to handle the completion of sync write
Date:   Sat, 27 Jul 2019 14:02:58 +0800
Message-ID: <20190727060258.63036-1-houtao1@huawei.com>
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

It's just code clean-up.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/md/raid1.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1755d2233e4d..d73ed94764c1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1904,6 +1904,22 @@ static void abort_sync_write(struct mddev *mddev, struct r1bio *r1_bio)
 	} while (sectors_to_go > 0);
 }
 
+static void put_sync_write_buf(struct r1bio *r1_bio, int uptodate)
+{
+	if (atomic_dec_and_test(&r1_bio->remaining)) {
+		struct mddev *mddev = r1_bio->mddev;
+		int s = r1_bio->sectors;
+
+		if (test_bit(R1BIO_MadeGood, &r1_bio->state) ||
+		    test_bit(R1BIO_WriteError, &r1_bio->state))
+			reschedule_retry(r1_bio);
+		else {
+			put_buf(r1_bio);
+			md_done_sync(mddev, s, uptodate);
+		}
+	}
+}
+
 static void end_sync_write(struct bio *bio)
 {
 	int uptodate = !bio->bi_status;
@@ -1930,16 +1946,7 @@ static void end_sync_write(struct bio *bio)
 		)
 		set_bit(R1BIO_MadeGood, &r1_bio->state);
 
-	if (atomic_dec_and_test(&r1_bio->remaining)) {
-		int s = r1_bio->sectors;
-		if (test_bit(R1BIO_MadeGood, &r1_bio->state) ||
-		    test_bit(R1BIO_WriteError, &r1_bio->state))
-			reschedule_retry(r1_bio);
-		else {
-			put_buf(r1_bio);
-			md_done_sync(mddev, s, uptodate);
-		}
-	}
+	put_sync_write_buf(r1_bio, uptodate);
 }
 
 static int r1_sync_page_io(struct md_rdev *rdev, sector_t sector,
@@ -2222,17 +2229,7 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 		generic_make_request(wbio);
 	}
 
-	if (atomic_dec_and_test(&r1_bio->remaining)) {
-		/* if we're here, all write(s) have completed, so clean up */
-		int s = r1_bio->sectors;
-		if (test_bit(R1BIO_MadeGood, &r1_bio->state) ||
-		    test_bit(R1BIO_WriteError, &r1_bio->state))
-			reschedule_retry(r1_bio);
-		else {
-			put_buf(r1_bio);
-			md_done_sync(mddev, s, 1);
-		}
-	}
+	put_sync_write_buf(r1_bio, 1);
 }
 
 /*
-- 
2.22.0

