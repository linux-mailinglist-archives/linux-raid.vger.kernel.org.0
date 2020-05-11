Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D61CD3E6
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEKI3f (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 04:29:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbgEKI3e (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 04:29:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6C974235951EAA2CC910;
        Mon, 11 May 2020 16:29:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 16:29:25 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] md: add a newline when printing parameter 'start_ro' by sysfs
Date:   Mon, 11 May 2020 16:23:25 +0800
Message-ID: <1589185405-39519-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Add a missing newline when printing module parameter 'start_ro' by
sysfs.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 271e8a5..acffcc0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9785,7 +9785,7 @@ static __exit void md_exit(void)
 
 static int get_ro(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%d", start_readonly);
+	return sprintf(buffer, "%d\n", start_readonly);
 }
 static int set_ro(const char *val, const struct kernel_param *kp)
 {
-- 
1.7.12.4

