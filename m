Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B210EC492
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKAOXQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33241 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKAOXO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so7702653edl.0
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CjY7ShvGR5Dn/0uQvmEFew6emi/ye6CQ+YsV9/JRew=;
        b=czv9QZ43UsZCREjpw/0bUmrEdC3lpnUYH4Z6zOnaHoHyxb3xtt2jPBMroG/RDK+XbI
         5+KIUUi2VTjJsDpGxHNL9TElRN4QQknQUEJTLwQJjCeXu5Uy1aHDrim1L8C5p6rTPFkN
         QAUKoTqTVLp0zuXrVeTUA0/MBoB/inR9LwzQJBK9j2taReHaRtnrtAsAnDsHRlOPjVZi
         l4A31i/ZUKFvqD7QPzKM7wHYzA37Pmg93v5alFbc/yubiKBF8TXgMVAhNPwDvQwlSNbp
         URcP9/cySFuJvgBN48s2OpOJGrJP2g7aRQw+jp7wG7NNjkzfXr5R8YwinGwHpklCnVsb
         ANeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CjY7ShvGR5Dn/0uQvmEFew6emi/ye6CQ+YsV9/JRew=;
        b=DfnlsSres81WarzBkk+E6I6ez3O3KeyL9UgL5GgX/nB0a11x0ZR4x9hDi8Uws10t29
         GKWFhLEHs/fbJbNAKu9HuKSwBWokOFd0vaQs5m5rv6vQbUUNm4jLeOOSxWF4H4ATkum0
         5Ij7LUpBr04gIIonsxrctrCsj7WyX1tMIU+0eIOApKbs6K/wKEWEnvZwBnWzWaQnn6mc
         g2Vni0/G1QQCOZX6a/q6jfmaIRviO9BIBwiCaRtALX9VphD+n2swODUb+r8TwJNdSv16
         Wzk7GD6nlTh0uKsJDKmA8aCI2Zgll75g/YtLqOvRKhUJftfYRlioJeOKx89R+E+kaHQh
         PjqQ==
X-Gm-Message-State: APjAAAXWboLNWJOmZzt+WKD5ea47XamMHx0my7t+inXozB79FikEyP1d
        xxS1bY+8z3MfU8nGKBb02Dk=
X-Google-Smtp-Source: APXvYqzEygVY698PqyBpl28mcEaiQlFfm5Lr99aIWuQl2VPJDdOkI8ZD7Usq0kp8vLlFSqCzMyN2RQ==
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr10576100edx.105.1572618192484;
        Fri, 01 Nov 2019 07:23:12 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:11 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 5/8] md: don't destroy serial_info_pool if serialize_policy is true
Date:   Fri,  1 Nov 2019 15:22:28 +0100
Message-Id: <20191101142231.23359-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The serial_info_pool is needed if array sets serialize_policy to
true, so don't destroy it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index eff297cf5a81..63f819de2361 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1790,8 +1790,10 @@ void md_bitmap_destroy(struct mddev *mddev)
 		return;
 
 	md_bitmap_wait_behind_writes(mddev);
-	mempool_destroy(mddev->serial_info_pool);
-	mddev->serial_info_pool = NULL;
+	if (!mddev->serialize_policy) {
+		mempool_destroy(mddev->serial_info_pool);
+		mddev->serial_info_pool = NULL;
+	}
 
 	mutex_lock(&mddev->bitmap_info.mutex);
 	spin_lock(&mddev->lock);
@@ -2477,8 +2479,10 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	mddev->bitmap_info.max_write_behind = backlog;
 	if (!backlog && mddev->serial_info_pool) {
 		/* serial_info_pool is not needed if backlog is zero */
-		mempool_destroy(mddev->serial_info_pool);
-		mddev->serial_info_pool = NULL;
+		if (!mddev->serialize_policy) {
+			mempool_destroy(mddev->serial_info_pool);
+			mddev->serial_info_pool = NULL;
+		}
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
 		struct md_rdev *rdev;
-- 
2.17.1

