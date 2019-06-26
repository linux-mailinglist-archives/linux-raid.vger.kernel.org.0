Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C727F565CE
	for <lists+linux-raid@lfdr.de>; Wed, 26 Jun 2019 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZJnE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 Jun 2019 05:43:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53796 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJnE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 26 Jun 2019 05:43:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q9ceKM154906;
        Wed, 26 Jun 2019 09:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=e0/xG0ASUy2uBBmUc3dT86zM2Bmv/dOFSKkp/z9o+f0=;
 b=Yj+WnGELfWbi3KFPbp2P2HQK6VvfnqUuZUAeYd2Yzb/r7zEb9NJVtpBPIRFBQsxdlhcH
 yDto95da4ai5jXKSPnl2BegplFj0ESVQy26ajR+3wiSJxrqpY63ykLpvWRdpMNPfgAe2
 VE4w+OcOJVabulO3e7nUfmUcjm+8d5Eb515EVmzZikOvfqe1Qfc9g1XH5S0WeBHdGTT/
 mX0BHRcsdNVBwWR6EfIrGd6fZbDvowzyQDDSCSHaefnBjO5HYyjD6Da2Q/FdiEFcftpb
 AbUPDGRsFZxKn05333t4a+tx0GMv+p1KJ/goHFtUjSeVq8WjA+4GPu07QoJVFfjaUrQ+ fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9ps8k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 09:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q9fVsa111026;
        Wed, 26 Jun 2019 09:42:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acckwb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 09:42:58 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q9gvot024087;
        Wed, 26 Jun 2019 09:42:57 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 02:42:57 -0700
Date:   Wed, 26 Jun 2019 12:42:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shaohua Li <shli@kernel.org>, Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] md/raid1: Fix a warning message in remove_wb()
Message-ID: <20190626094251.GA3242@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260116
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The WARN_ON() macro doesn't take an error message, it just takes a
condition.  I've changed this to use WARN(1, "...") instead.

Fixes: 3e148a320979 ("md/raid1: fix potential data inconsistency issue with write behind device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I also considered changing it to:

	WARN(!found, "...");

but I decided this way was more clear.  It's to have the error path
indented an extra tab.

---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3d44da663797..34e26834ad28 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -96,7 +96,7 @@ static void remove_wb(struct md_rdev *rdev, sector_t lo, sector_t hi)
 		}
 
 	if (!found)
-		WARN_ON("The write behind IO is not recorded\n");
+		WARN(1, "The write behind IO is not recorded\n");
 	spin_unlock_irqrestore(&rdev->wb_list_lock, flags);
 	wake_up(&rdev->wb_io_wait);
 }
-- 
2.20.1

