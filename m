Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451D96C5C20
	for <lists+linux-raid@lfdr.de>; Thu, 23 Mar 2023 02:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCWBdb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Mar 2023 21:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCWBd1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Mar 2023 21:33:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD05AC
        for <linux-raid@vger.kernel.org>; Wed, 22 Mar 2023 18:32:55 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PhnnF4ntLzKtCy;
        Thu, 23 Mar 2023 09:29:21 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500002.china.huawei.com
 (7.221.188.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 09:31:38 +0800
From:   miaoguanqin <miaoguanqin@huawei.com>
To:     <jes@trained-monkey.org>, <mariusz.tkaczyk@linux.intel.com>,
        <pmenzel@molgen.mpg.de>, <linux-raid@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <lixiaokeng@huawei.com>,
        <louhongxiang@huawei.com>
Subject: [PATCH 2/4] Fix memory leak in file Kill
Date:   Thu, 23 Mar 2023 09:30:51 +0800
Message-ID: <20230323013053.3238005-3-miaoguanqin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230323013053.3238005-1-miaoguanqin@huawei.com>
References: <20230323013053.3238005-1-miaoguanqin@huawei.com>
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

When we test mdadm with asan,we found some memory leaks in Kill.c
We fix these memory leaks based on code logic.

Signed-off-by: miaoguanqin <miaoguanqin@huawei.com>
Signed-off-by: lixiaokeng <lixiaokeng@huawei.com>
---
 Kill.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Kill.c b/Kill.c
index bfd0efdc..46a1a8a0 100644
--- a/Kill.c
+++ b/Kill.c
@@ -41,6 +41,7 @@ int Kill(char *dev, struct supertype *st, int force, int verbose, int noexcl)
 	 *  4 - failed to find a superblock.
 	 */
 
+	int flags = 0;
 	int fd, rv = 0;
 
 	if (force)
@@ -52,8 +53,10 @@ int Kill(char *dev, struct supertype *st, int force, int verbose, int noexcl)
 				dev);
 		return 2;
 	}
-	if (st == NULL)
+	if (st == NULL) {
 		st = guess_super(fd);
+		flags = 1;
+	}
 	if (st == NULL || st->ss->init_super == NULL) {
 		if (verbose >= 0)
 			pr_err("Unrecognised md component device - %s\n", dev);
@@ -77,6 +80,10 @@ int Kill(char *dev, struct supertype *st, int force, int verbose, int noexcl)
 			rv = 0;
 		}
 	}
+	if (flags == 1 && st) {
+		st->ss->free_super(st);
+		free(st);
+	}
 	close(fd);
 	return rv;
 }
-- 
2.33.0

