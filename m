Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B21050A4
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUKhr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38656 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfKUKhp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id s10so2351261edi.5
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CjY7ShvGR5Dn/0uQvmEFew6emi/ye6CQ+YsV9/JRew=;
        b=CjKHJSLAeCwjCiRIKByKaJL/X4Y8pnuyCoXV0M5sRE5Yg5zUyq6LeZp4CVBXipQhAr
         9dhz8mV5erX/tNlwSZzOU3JXvIeG3NkiPEi84LQ442MxkrcR6rWYe9L2y2YcKwMAv1ou
         EFg7jGMRIgs3qd7bHKyfu/vnJA4LcV32Hr3FBccZSmGbLLBxzCMAbof8PCd8sTMfsTlq
         //x2TMLKmWBbR8GPfVDGCeSy5qEabeCYrRseVAMpmt2Fq9pC6Wnx2uE2QyCbJBtBSKcs
         2+26Hb8oVTxHxlsau6VAgPGbeSrYEbkmM9hFFR/win3dPJ/ZX7klMaRTl8y5isGIY0Ss
         Fg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CjY7ShvGR5Dn/0uQvmEFew6emi/ye6CQ+YsV9/JRew=;
        b=I3VsCpr2clVZvyqmLCYrQbcWTAPuAbw+EYTDwoN80+lrnigxgbXmMAthhOGuxBhoI8
         X5BOylR9C7vpRDTC2VI7B9O23N46klsu0dlR3O6ANRp7JwvrQV/FKTUBpDVNq79w/Xg1
         tN7CyE3xwgMXs9E4nbJ4MqxBre1GhOo7/1Vkk4/c6PCGxG2OZ2cGMOtR0NnP9MP0lAdc
         B+A662mgBKdl1AqVJjCwVUsDziVxj1BOxYDvURVAE6GpCYaeEywraMh6K/sOuGa3mc9O
         aWD2xPb5gslI7JUYDMeLo9K1TUQQrzP8/al0tbbJPwgFh3hAXnS+gmKHUiKKG+mOWbSE
         SJow==
X-Gm-Message-State: APjAAAWrDmDdJe6aUdhBZax9egFjj3/k8eB9iZeTxqqUuYv0RTcU4YHH
        nVDynt+lz9r2VMvAWEo7Nhm2nq4K
X-Google-Smtp-Source: APXvYqxJG0PShYpW4C31SiZVUq+KIgvJqje11r8bgOzxCvsty1fLL8WPP5HuC4V3U8oW5qSIDPzoMw==
X-Received: by 2002:a17:907:1102:: with SMTP id qu2mr12867951ejb.300.1574332663419;
        Thu, 21 Nov 2019 02:37:43 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:42 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 6/9] md: don't destroy serial_info_pool if serialize_policy is true
Date:   Thu, 21 Nov 2019 11:37:25 +0100
Message-Id: <20191121103728.18919-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
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

