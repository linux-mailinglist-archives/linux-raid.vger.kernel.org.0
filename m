Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75F5441C1
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jun 2022 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiFIDG4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jun 2022 23:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIDGz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jun 2022 23:06:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72126F497
        for <linux-raid@vger.kernel.org>; Wed,  8 Jun 2022 20:06:54 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJTW650zGzjYSt;
        Thu,  9 Jun 2022 11:05:54 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:06:52 +0800
Received: from [10.174.177.211] (10.174.177.211) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:06:52 +0800
Message-ID: <35fd23fc-4f3d-a6fe-c4b1-79a7b09acead@huawei.com>
Date:   Thu, 9 Jun 2022 11:06:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: [PATCH 2/5 v2] Detail: fix memleak
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <jes@trained-monkey.org>, <linux-raid@vger.kernel.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <linfeilong@huawei.com>, <lixiaokeng@huawei.com>
References: <fd86d427-2d3e-b337-6de8-d70dcbbd6ce1@huawei.com>
In-Reply-To: <fd86d427-2d3e-b337-6de8-d70dcbbd6ce1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.211]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

char *sysdev = xstrdup() but not free() in for loop, will cause memory
leak.

Reported-by: Coverity
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 Detail.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Detail.c b/Detail.c
index ce7a8445..4ef26460 100644
--- a/Detail.c
+++ b/Detail.c
@@ -303,6 +303,7 @@ int Detail(char *dev, struct context *c)
                                if (path)
                                        printf("MD_DEVICE_%s_DEV=%s\n",
                                               sysdev, path);
+                               free(sysdev);
                        }
                }
                goto out;
--
2.27.0
