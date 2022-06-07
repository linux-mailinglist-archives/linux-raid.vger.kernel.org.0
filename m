Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6142538B90
	for <lists+linux-raid@lfdr.de>; Tue, 31 May 2022 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiEaGus (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 May 2022 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbiEaGur (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 May 2022 02:50:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3757093E
        for <linux-raid@vger.kernel.org>; Mon, 30 May 2022 23:50:46 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LC2tp5Dk3zgYCj;
        Tue, 31 May 2022 14:49:06 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 14:50:45 +0800
Received: from [10.174.177.211] (10.174.177.211) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 14:50:44 +0800
Message-ID: <12e34ddf-6e60-ab5f-020d-bd004fbbef06@huawei.com>
Date:   Tue, 31 May 2022 14:50:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: [PATCH 4/5] find_disk_attached_hba: fix memleak
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <jes@trained-monkey.org>, <linux-raid@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <lixiaokeng@huawei.com>
References: <00992179-9572-ceb4-eb49-492c42e67695@huawei.com>
In-Reply-To: <00992179-9572-ceb4-eb49-492c42e67695@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.211]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

If disk_path = diskfd_to_devpath(), we need free(disk_path) before
return, otherwise there will be a memory leak

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 super-intel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/super-intel.c b/super-intel.c
index ef21ffba..98fb63d5 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -700,8 +700,11 @@ static struct sys_dev* find_disk_attached_hba(int fd, const char *devname)
 		return 0;

 	for (elem = list; elem; elem = elem->next)
-		if (path_attached_to_hba(disk_path, elem->path))
+		if (path_attached_to_hba(disk_path, elem->path)) {
+			if (disk_path != devname)
+				free(disk_path);
 			return elem;
+		}

 	if (disk_path != devname)
 		free(disk_path);
-- 
2.27.0
