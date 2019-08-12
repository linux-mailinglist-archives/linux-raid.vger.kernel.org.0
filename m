Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD58A254
	for <lists+linux-raid@lfdr.de>; Mon, 12 Aug 2019 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfHLPak (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Aug 2019 11:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37745 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfHLPak (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 12 Aug 2019 11:30:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 247B5300DA78
        for <linux-raid@vger.kernel.org>; Mon, 12 Aug 2019 15:30:40 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA05460BEE;
        Mon, 12 Aug 2019 15:30:39 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     linux-raid@vger.kernel.org, xni@redhat.com, heinzm@redhat.com
Subject: [PATCH] raid5 improve too many read errors msg by adding limits
Date:   Mon, 12 Aug 2019 11:30:39 -0400
Message-Id: <20190812153039.13604-1-ncroxon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 12 Aug 2019 15:30:40 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Often limits can be changed by admin. When discussing such things
it helps if you can provide "self-sustained" facts. Also
sometimes the admin thinks he changed a limit, but it did not
take effect for some reason or he changed the wrong thing.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 522398f61eea..e2b58b58018b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2566,8 +2566,8 @@ static void raid5_end_read_request(struct bio * bi, int error)
 				bdn);
 		} else if (atomic_read(&rdev->read_errors)
 			 > conf->max_nr_stripes)
-			pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
-			       mdname(conf->mddev), bdn);
+			pr_warn("md/raid:%s: Too many read errors (%d), failing device %s.\n",
+			       mdname(conf->mddev), conf->max_nr_stripes, bdn);
 		else
 			retry = 1;
 		if (set_bad && test_bit(In_sync, &rdev->flags)
-- 
2.20.1

