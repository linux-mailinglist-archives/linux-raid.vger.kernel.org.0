Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D76D96BA
	for <lists+linux-raid@lfdr.de>; Thu,  6 Apr 2023 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjDFMF0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Apr 2023 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbjDFMFG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Apr 2023 08:05:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C49EEE
        for <linux-raid@vger.kernel.org>; Thu,  6 Apr 2023 05:03:51 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Psfdh0WVyzKwyt;
        Thu,  6 Apr 2023 19:38:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500002.china.huawei.com
 (7.221.188.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 19:41:01 +0800
From:   Guanqin Miao <miaoguanqin@huawei.com>
To:     <jes@trained-monkey.org>, <mariusz.tkaczyk@linux.intel.com>,
        <pmenzel@molgen.mpg.de>, <linux-raid@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <lixiaokeng@huawei.com>,
        <louhongxiang@huawei.com>
Subject: [PATCH 1/4] Fix memory leak in file Assemble
Date:   Thu, 6 Apr 2023 19:40:08 +0800
Message-ID: <20230406114011.3297545-2-miaoguanqin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230406114011.3297545-1-miaoguanqin@huawei.com>
References: <20230406114011.3297545-1-miaoguanqin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When we test mdadm with asan, we found some memory leaks in Assemble.c
We fix these memory leaks based on code logic.

Signed-off-by: Guanqin Miao <miaoguanqin@huawei.com>
Signed-off-by: Li Xiao Keng <lixiaokeng@huawei.com>
---
 Assemble.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Assemble.c b/Assemble.c
index 49804941..574865eb 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -341,8 +341,10 @@ static int select_devices(struct mddev_dev *devlist,
 				st->ss->free_super(st);
 			dev_policy_free(pol);
 			domain_free(domains);
-			if (tst)
+			if (tst) {
 				tst->ss->free_super(tst);
+				free(tst);
+			}
 			return -1;
 		}
 
@@ -417,6 +419,7 @@ static int select_devices(struct mddev_dev *devlist,
 				st->ss->free_super(st);
 				dev_policy_free(pol);
 				domain_free(domains);
+				free(st);
 				return -1;
 			}
 			if (c->verbose > 0)
@@ -425,6 +428,8 @@ static int select_devices(struct mddev_dev *devlist,
 
 			/* make sure we finished the loop */
 			tmpdev = NULL;
+			if (st)
+				free(st);
 			goto loop;
 		} else {
 			content = *contentp;
@@ -533,6 +538,7 @@ static int select_devices(struct mddev_dev *devlist,
 				st->ss->free_super(st);
 				dev_policy_free(pol);
 				domain_free(domains);
+				free(tst);
 				return -1;
 			}
 			tmpdev->used = 1;
@@ -546,8 +552,10 @@ static int select_devices(struct mddev_dev *devlist,
 		}
 		dev_policy_free(pol);
 		pol = NULL;
-		if (tst)
+		if (tst) {
 			tst->ss->free_super(tst);
+			free(tst);
+		}
 	}
 
 	/* Check if we found some imsm spares but no members */
@@ -839,6 +847,7 @@ static int load_devices(struct devs *devices, char *devmap,
 				close(mdfd);
 				free(devices);
 				free(devmap);
+				free(best);
 				*stp = st;
 				return -1;
 			}
@@ -1950,6 +1959,8 @@ out:
 	} else if (mdfd >= 0)
 		close(mdfd);
 
+	if (best)
+		free(best);
 	/* '2' means 'OK, but not started yet' */
 	if (rv == -1) {
 		free(devices);
-- 
2.33.0

