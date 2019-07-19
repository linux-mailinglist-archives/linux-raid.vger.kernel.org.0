Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3554C6E0AD
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2019 07:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGSFnQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jul 2019 01:43:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfGSFnQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jul 2019 01:43:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B76A73A05838AD83FEF8;
        Fri, 19 Jul 2019 13:43:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 19 Jul 2019
 13:43:05 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <neilb@suse.com>, <liu.song.a23@gmail.com>
CC:     <axboe@kernel.dk>, <linux-raid@vger.kernel.org>,
        <houtao1@huawei.com>
Subject: [PATCH 2/2] md/raid10: end bio when the device faulty
Date:   Fri, 19 Jul 2019 13:48:47 +0800
Message-ID: <20190719054847.140905-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190719054847.140905-1-yuyufen@huawei.com>
References: <20190719054847.140905-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Just like raid1, we do not queue write error bio to retry write
and acknowlege badblocks, when the device is faulty.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid10.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8a1354a08a1a..a982e040b609 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -465,19 +465,21 @@ static void raid10_end_write_request(struct bio *bio)
 			if (test_bit(FailFast, &rdev->flags) &&
 			    (bio->bi_opf & MD_FAILFAST)) {
 				md_error(rdev->mddev, rdev);
-				if (!test_bit(Faulty, &rdev->flags))
-					/* This is the only remaining device,
-					 * We need to retry the write without
-					 * FailFast
-					 */
-					set_bit(R10BIO_WriteError, &r10_bio->state);
-				else {
-					r10_bio->devs[slot].bio = NULL;
-					to_put = bio;
-					dec_rdev = 1;
-				}
-			} else
+			}
+
+			/*
+			 * When the device is faulty, it is not necessary to
+			 * handle write error.
+			 * For failfast, this is the only remaining device,
+			 * We need to retry the write without FailFast.
+			 */
+			if (!test_bit(Faulty, &rdev->flags))
 				set_bit(R10BIO_WriteError, &r10_bio->state);
+			else {
+				r10_bio->devs[slot].bio = NULL;
+				to_put = bio;
+				dec_rdev = 1;
+			}
 		}
 	} else {
 		/*
-- 
2.16.2.dirty

