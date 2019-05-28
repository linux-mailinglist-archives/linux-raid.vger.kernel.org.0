Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3E2C6C9
	for <lists+linux-raid@lfdr.de>; Tue, 28 May 2019 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE1MmC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 May 2019 08:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfE1MmC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 May 2019 08:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99C42301D680;
        Tue, 28 May 2019 12:42:01 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3D0A60BE2;
        Tue, 28 May 2019 12:41:56 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     liu.song.a23@gmail.com, soltys@ziu.info, heinzm@redhat.com,
        ncroxon@redhat.com
Subject: [PATCH 1/1] raid5-cache: Need to do start() part job after adding journal device
Date:   Tue, 28 May 2019 20:41:54 +0800
Message-Id: <1559047314-8460-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 28 May 2019 12:42:02 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In d5d885fd(md: introduce new personality funciton start()) it splits the init
job to two parts. The first part run() does the jobs that do not require the
md threads. The second part start() does the jobs that require the md threads.

Now it just does run() in adding new journal device. It needs to do the second
part start() too.

Fixes: f6b6ec5cfac(raid5-cache: add journal hot add/remove support)
Reported-by: Michal Soltys <soltys@ziu.info>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid5.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7fde645..0e52f1d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7680,7 +7680,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r5conf *conf = mddev->private;
-	int err = -EEXIST;
+	int ret, err = -EEXIST;
 	int disk;
 	struct disk_info *p;
 	int first = 0;
@@ -7695,7 +7695,14 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		 * The array is in readonly mode if journal is missing, so no
 		 * write requests running. We should be safe
 		 */
-		log_init(conf, rdev, false);
+		ret = log_init(conf, rdev, false);
+		if (ret)
+			return ret;
+
+		ret = r5l_start(conf->log);
+		if (ret)
+			return ret;
+
 		return 0;
 	}
 	if (mddev->recovery_disabled == conf->recovery_disabled)
-- 
2.7.5

