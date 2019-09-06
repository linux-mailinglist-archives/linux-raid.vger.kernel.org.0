Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B36AB925
	for <lists+linux-raid@lfdr.de>; Fri,  6 Sep 2019 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393268AbfIFNVf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Sep 2019 09:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfIFNVe (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 6 Sep 2019 09:21:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9269C3084031;
        Fri,  6 Sep 2019 13:21:34 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F955608A5;
        Fri,  6 Sep 2019 13:21:34 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     linux-raid@vger.kernel.org, songliubraving@fb.com
Cc:     neilb@suse.de, xni@redhat.com, mpatocka@redhat.com
Subject: [PATCH] raid5: don't increment read_errors on EILSEQ return
Date:   Fri,  6 Sep 2019 09:21:33 -0400
Message-Id: <20190906132133.22771-1-ncroxon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 06 Sep 2019 13:21:34 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

While MD continues to count read errors returned by the lower layer.
If those errors are -EILSEQ, instead of -EIO, it should NOT increase
the read_errors count.

When RAID6 is set up on dm-integrity target that detects massive
corruption, the leg will be ejected from the array.  Even if the
issue is correctable with a sector re-write and the array has
necessary redundancy to correct it.

The leg is ejected because it runs up the rdev->read_errors beyond
conf->max_nr_stripes.  The return status in dm-drypt when there is
a data integrity error is -EILSEQ (BLK_STS_PROTECTION).

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 88e56ee98976..993a2a6ebc92 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2526,7 +2526,8 @@ static void raid5_end_read_request(struct bio * bi)
 		int set_bad = 0;
 
 		clear_bit(R5_UPTODATE, &sh->dev[i].flags);
-		atomic_inc(&rdev->read_errors);
+		if (!(bi->bi_status == BLK_STS_PROTECTION))
+			atomic_inc(&rdev->read_errors);
 		if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
 			pr_warn_ratelimited(
 				"md/raid:%s: read error on replacement device (sector %llu on %s).\n",
-- 
2.20.1

