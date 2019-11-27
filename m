Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4010A953
	for <lists+linux-raid@lfdr.de>; Wed, 27 Nov 2019 05:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfK0EQ3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 26 Nov 2019 23:16:29 -0500
Received: from m12-17.163.com ([220.181.12.17]:55833 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfK0EQ3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 26 Nov 2019 23:16:29 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 23:16:27 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wQ2sJ
        G7a9Jr6SbC7AwDDZFf2aVHOyNyTZhCY4mygsU4=; b=p0LY/t4PqFdwq5Yf9GwGC
        NhKu5fyFjdMcEWYC2H6utXNXOWSH4K5TsR7ak16p1GYwafr0UGOc/bJIR/XnLKwS
        vzFZhlqZzHGZKGSoLZFbVk7hUiGOZNQem0ojZ1h3WhXFXXCd7ZcR6dhLYnG6Fsm9
        rH8/wRH7U7QFo8WzeDbySo=
Received: from localhost.localdomain (unknown [112.25.212.39])
        by smtp13 (Coremail) with SMTP id EcCowABnc8Wk9N1dpiIWWA--.7593S2;
        Wed, 27 Nov 2019 11:59:36 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     jsorensen@fb.com, Jes.Sorensen@gmail.com
Cc:     neilb@suse.de, gqjiang@suse.com, linux-raid@vger.kernel.org,
        Xiao Yang <ice_yangxiao@163.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] Manage: Remove the legacy code for md driver prior to 0.90.03
Date:   Wed, 27 Nov 2019 11:59:24 +0800
Message-Id: <20191127035924.12734-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABnc8Wk9N1dpiIWWA--.7593S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryDXr15tr1fGw4kKr15urg_yoW8GFWUpr
        W3JFnrGrZ7Jr4jq3WDJFZ5Aas0yws5Jr18trnxXw1xZr1akw1jvrWjgr1FqryYvryUAr15
        C3y5tFyj9F4UGF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQo7_UUUUU=
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMwV6XlXl0n01XQAAsl
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Previous re-add operation only calls ioctl(HOT_ADD_DISK) for array without
metadata(e.g. mdadm -B/--build) when md driver is less than 0.90.02, but
commit 091e8e6 breaks the logic and current re-add operation can call
ioctl(HOT_ADD_DISK) even if md driver is 0.90.03.

This issue is reproduced by 05r1-re-add-nosuper:
------------------------------------------------
++ die 'resync or recovery is happening!'
++ echo -e '\n\tERROR: resync or recovery is happening! \n'
ERROR: resync or recovery is happening!
------------------------------------------------

Fixes: 091e8e6("Manage: Remove all references to md_get_version()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 Manage.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Manage.c b/Manage.c
index 21536f5..ffe55f8 100644
--- a/Manage.c
+++ b/Manage.c
@@ -741,18 +741,6 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
 		       "       Adding anyway as --force was given.\n",
 		       dv->devname, devname);
 	}
-	if (!tst->ss->external && array->major_version == 0) {
-		if (ioctl(fd, HOT_ADD_DISK, rdev)==0) {
-			if (verbose >= 0)
-				pr_err("hot added %s\n",
-				       dv->devname);
-			return 1;
-		}
-
-		pr_err("hot add failed for %s: %s\n",
-		       dv->devname, strerror(errno));
-		return -1;
-	}
 
 	if (array->not_persistent == 0 || tst->ss->external) {
 
-- 
2.21.0


