Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36F97ABD
	for <lists+linux-raid@lfdr.de>; Wed, 21 Aug 2019 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfHUN1K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 09:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfHUN1J (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 21 Aug 2019 09:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC2F810C0216;
        Wed, 21 Aug 2019 13:27:09 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B97C10016E8;
        Wed, 21 Aug 2019 13:27:09 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     liu.song.a23@gmail.com, linux-raid@vger.kernel.org, neilb@suse.com,
        heinzm@redhat.com, xni@redhat.com
Subject: [PATCH] raid5 improve too many read errors msg by adding limits
Date:   Wed, 21 Aug 2019 09:27:08 -0400
Message-Id: <20190821132708.31378-1-ncroxon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 21 Aug 2019 13:27:09 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Often limits can be changed by admin. When discussing such things
it helps if you can provide "self-sustained" facts. Also
sometimes the admin thinks he changed a limit, but it did not
take effect for some reason or he changed the wrong thing.

V3: Only pr_warn when Faulty is 0.
V2: Add read_errors value to pr_warn.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 drivers/md/raid5.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 59cafafd5a5d..88e56ee98976 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2549,10 +2549,16 @@ static void raid5_end_read_request(struct bio * bi)
 				(unsigned long long)s,
 				bdn);
 		} else if (atomic_read(&rdev->read_errors)
-			 > conf->max_nr_stripes)
-			pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
-			       mdname(conf->mddev), bdn);
-		else
+			 > conf->max_nr_stripes) {
+			if (!test_bit(Faulty, &rdev->flags)) {
+				pr_warn("md/raid:%s: %d read_errors > %d stripes\n",
+				    mdname(conf->mddev),
+				    atomic_read(&rdev->read_errors),
+				    conf->max_nr_stripes);
+				pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
+				    mdname(conf->mddev), bdn);
+			}
+		} else
 			retry = 1;
 		if (set_bad && test_bit(In_sync, &rdev->flags)
 		    && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
-- 
2.20.1

