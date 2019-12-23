Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613701293C4
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWJtS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33272 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLWJtR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so14786865edq.0
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDRLDd3R+vyE6gh0CVIWO8nEUt6PldtTkxeQiLykTiw=;
        b=RxiJj29+fGfoBxWr3UKdPmrgVQqcGvmNBl7hi4ZCmHZyKbvFzcNcYvcSgyn2DP1WH5
         cvmoSgw08gDv9CdcIA0eF97WLsWmZ4YNeXVNAwrE6ZD6pcMsWwjHo8shUNc+S12HcwD8
         ewnXCoFvcKfmODNwSCJ7ud4nn3EK+Si1ggYNN4tVSmVcMmXCKJo2GbosnMDETkBqso2E
         WErL8csKIUiT/edZAM6/xmeO9yOyA8wSyHbSqNLbLI9sThtT87jfS/4DU0/UYwkbJLBi
         QaLZX6QFcDP4F7e/Fq9tDbRuM6GsOjy1f3Q3K0j5fNNXDfzmlPng3Zbu2ihdOsSbvS9V
         17wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDRLDd3R+vyE6gh0CVIWO8nEUt6PldtTkxeQiLykTiw=;
        b=ikS9+3xaPkiDniZVKGMli+1wNDunOeV3AFpRFP+eh4I7Q49egBkdfI7t9sgBqPdPst
         GMiUVwkwphHvChsjJ3TbgwOwTEDxIbvAxX9/CL3cgU9eKTg+Se6aa/cmRlOPG/OzN/iB
         wQt9v29ewo8xI2KO1zBmYYES8ap55KQKmBvGQXfesAwHhtymdaoCJfBZjD4Cq3gAP5Is
         CFazF6h+YEFEwfuSoD5une7fFzPwuwwZpfGkylPsXew0x1Bx/OQ+nuAy0yT9NzsBGYfP
         dLqEU4khCpIEMZIKqnG70AIm0XF0ji1RlAhDwvWWDN27wxkUrqJ5y2KsQ6tTblIogv1f
         3eSQ==
X-Gm-Message-State: APjAAAVPeuu1Up79FZl+Cv9pDqa9mMdeI4RxRC8gHHttCqxXEUxQhYEo
        x9/1UYA9esbQjvyOYw0SMMQ=
X-Google-Smtp-Source: APXvYqy97YAgQTt5jhOWJbY5eNP1mfVA1LtYeuFFxcbgTv6P8TjQwgEbRzqldFPgIz9JKMoz7z/Wsw==
X-Received: by 2002:a17:906:4681:: with SMTP id a1mr31364514ejr.256.1577094555291;
        Mon, 23 Dec 2019 01:49:15 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:14 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 07/10] md: don't destroy serial_info_pool if serialize_policy is true
Date:   Mon, 23 Dec 2019 10:48:59 +0100
Message-Id: <20191223094902.12704-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
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
index 87d3b5ef877c..5dcf23837f1b 100644
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

