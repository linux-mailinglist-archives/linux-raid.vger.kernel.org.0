Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C123B899
	for <lists+linux-raid@lfdr.de>; Tue,  4 Aug 2020 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHDKRB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 4 Aug 2020 06:17:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45622 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgHDKRB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 4 Aug 2020 06:17:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074ADAgq014255;
        Tue, 4 Aug 2020 10:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XOIfojSUm+edzQDLt7k9cZn3ULbuKEfol6bpoJBym7c=;
 b=xPwRD+7NFkQs4hrSn4UhMP/yvbirQshzDNxOnAktaJdC9JzFg6a901V6uujeTFkj2XmY
 6UHPlhKa/gZmy1tfytf/FBnVewr3T4XqhWS/dxUDp217iTTZ3i/KLAmvlgw4ScMtB8EJ
 SM0JcALubxsxO8YiMlaPGbVj5Gx1Xl5amrYNLwDmxdiSi4qAEAb+QGExZJTPnXkP6BdC
 o4BR88+RphtOoAx8bw+3YcR9kQuCSHkIBMN2kqVBSGFgZgBsHYcTwPHtVsJ7eparid2m
 GnRAF3HCV9Ps6Y81rTuGHMuoZpyh6jtoZJa9T5HjWbgaUlXJGT+RClGBJBk8XofLLpfQ 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnq6q6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 10:16:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074ACqnZ090000;
        Tue, 4 Aug 2020 10:16:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32pdnptfjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 10:16:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074AGp5E011202;
        Tue, 4 Aug 2020 10:16:52 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 03:16:51 -0700
Date:   Tue, 4 Aug 2020 13:16:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Song Liu <song@kernel.org>, Guoqing Jiang <gqjiang@suse.com>
Cc:     Shaohua Li <shli@fb.com>, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] md-cluster: Fix potential error pointer dereference in
 resize_bitmaps()
Message-ID: <20200804101645.GB392148@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=2 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040076
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The error handling calls md_bitmap_free(bitmap) which checks for NULL
but will Oops if we pass an error pointer.  Let's set "bitmap" to NULL
on this error path.

Fixes: afd756286083 ("md-cluster/raid10: resize all the bitmaps before start reshape")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/md/md-cluster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 73fd50e77975..d50737ec4039 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1139,6 +1139,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
 		bitmap = get_bitmap_from_slot(mddev, i);
 		if (IS_ERR(bitmap)) {
 			pr_err("can't get bitmap from slot %d\n", i);
+			bitmap = NULL;
 			goto out;
 		}
 		counts = &bitmap->counts;
-- 
2.27.0

