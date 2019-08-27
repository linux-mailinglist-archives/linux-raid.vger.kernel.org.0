Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97509DBEB
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 05:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfH0DNk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 26 Aug 2019 23:13:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfH0DNk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 26 Aug 2019 23:13:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R39Hem037971
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=p9kDwWhfXxE64Pqad4UaNk1Eq/hJJ1lZorE7yie7JFU=;
 b=EXoK/CHW4fAOb6VzivXOUCysKsZNVibl3dF+89kxcqpHad5IBYs9rAkDOAogq182gCr/
 OeTnDIcYIxjX7buxgmLBTVIL/OxVkRHXYKjLmPsNsJY6NwykKAe3legKWvRCLvj09izY
 jc/UQmxJT/n7AzQduzt74Nx1JGxAHhCoT4fa8RvnL11DdrtziiXGQn21XE2SvVNGSYOA
 ib3xhJZqNjKWUUdRymSrcpSKrjmYG9iy6CHAOSpH2ZUeOqpxe0+tfbJydcKONGzn2Z/P
 ikwb2N8nRXskZ1Z1Kvr3YFbMgAwKmDRTCVF5SaOS0IcH4eZr2uJXZbFr/B18xTZH3eDj og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2umuga87uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:13:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R37au2155241
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:12:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2umj1txunx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:12:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R3CXja014087
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:12:33 GMT
Received: from ol6u9ext3.cn.oracle.com (/10.182.71.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 20:12:33 -0700
From:   Shuning Zhang <sunny.s.zhang@oracle.com>
To:     linux-raid@vger.kernel.org
Subject: [PATCH] raid5: fix spelling mistake \"bion\" -> \"bios\"
Date:   Tue, 27 Aug 2019 11:12:00 +0800
Message-Id: <1566875520-5340-1-git-send-email-sunny.s.zhang@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=895
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=972 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270033
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

There is apelling mistake in raid5, fix it.

Signed-off-by: Shuning Zhang <sunny.s.zhang@oracle.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3de4e13..2a33b13 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3189,7 +3189,7 @@ schedule_reconstruction(struct stripe_head *sh, struct stripe_head_state *s,
 }
 
 /*
- * Each stripe/dev can have one or more bion attached.
+ * Each stripe/dev can have one or more bios attached.
  * toread/towrite point to the first in a chain.
  * The bi_next chain must be in order.
  */
-- 
2.7.4

