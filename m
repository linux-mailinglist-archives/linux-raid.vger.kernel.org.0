Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCD9DBF9
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 05:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfH0DXk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 26 Aug 2019 23:23:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfH0DXj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 26 Aug 2019 23:23:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R3Ncf4075710
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=RTtT5QqJgSTmJ22taEhyKYsKmeHHS5ZOB57F3uqTVNo=;
 b=V0if+5xLhhEqV7YITLTvFEtC0qvxlQiFaFiyCcRRPPsubOHEkTLTkL94PqZhMRnSW1l2
 GmrpHLcduTk8OhnLAeI/gR8tUEoDEogjW2JouZ2fBAyFs1oBlRerGSszmUskn7muemT7
 tf8IHq1ghmZ8TMHMMPO5krlHU2R1/Aa0C/6A6BRTmgQV7+0Qj3iGhlmUEl0l3jeWbb0p
 PWwchK/KIMUbsO1FyZmm5aAiNRW+u8UvoQpJOAmM8I0hFHOg99BoJMaMNiKtbeTUi/Ds
 OWpQ/Bm4X4kVnvu1/slTCP0CrIpNJwiAok9H0igovhkrLf2pDcYv2yu29PzVWEeIDQj0 HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2umv7j8349-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:23:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R3IWJA173885
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:18:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2umj1ty075-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:18:38 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R3IG2u024559
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 03:18:16 GMT
Received: from ol6u9ext3.cn.oracle.com (/10.182.71.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 20:18:16 -0700
From:   Shuning Zhang <sunny.s.zhang@oracle.com>
To:     linux-raid@vger.kernel.org
Subject: [PATCH] raid5: fix spelling mistake \"bion\" -> \"bios\"
Date:   Tue, 27 Aug 2019 11:17:44 +0800
Message-Id: <1566875864-5386-1-git-send-email-sunny.s.zhang@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270036
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

There is a spelling mistake in raid5, fix it.

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

