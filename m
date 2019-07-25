Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6174FEF
	for <lists+linux-raid@lfdr.de>; Thu, 25 Jul 2019 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfGYNpg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 25 Jul 2019 09:45:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728133AbfGYNpg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 25 Jul 2019 09:45:36 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C97B31AA2DBEFB430B2;
        Thu, 25 Jul 2019 21:45:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 21:45:24 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <liu.song.a23@gmail.com>
CC:     <neilb@suse.com>, <linux-raid@vger.kernel.org>,
        <yuyufen@huawei.com>
Subject: [PATCH] md: do not set suspend_hi when ->quiesce is null
Date:   Thu, 25 Jul 2019 21:51:08 +0800
Message-ID: <20190725135108.108064-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Only when md personality have defined ->sync_request,
suspend_lo and suspend_hi can be created in md sysfs
directory. For now, all the personality which have
defined ->sync_request also have defined ->quiesce.
Thus, it will not cause any error in suspend_hi_store().

But, we may need to add the condition to avoid potential
NULL pointer error, as same as suspend_lo_store().

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a114b05e3db4..5c30e598e19c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4977,7 +4977,8 @@ suspend_hi_store(struct mddev *mddev, const char *buf, size_t len)
 	if (err)
 		return err;
 	err = -EINVAL;
-	if (mddev->pers == NULL)
+	if (mddev->pers == NULL ||
+			mddev->pers->quiesce == NULL)
 		goto unlock;
 
 	mddev_suspend(mddev);
-- 
2.16.2.dirty

