Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9939A72B29
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jul 2019 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfGXJJv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Jul 2019 05:09:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44959 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGXJJu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 Jul 2019 05:09:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so46427102edr.11
        for <linux-raid@vger.kernel.org>; Wed, 24 Jul 2019 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uKGw00/EyGDwCBJB0zqmKSmhbqqlL+sFqJV8R0jR8lo=;
        b=nrm1X0iTkeFbAgylQbnpZx5B3TyVzclDm9up5IyNdKOfnWM8PUzY9mYkDGoNuE5pOj
         Lc7+Pirku2ibLyr11gViI4VHO+ATGY8h7qt0vPK4SjKVIyrvCliQXTbSgJUfM3/7gdWD
         gxpg80R9ZqfpfarSxeDGIpy8Zq4lF/+Q2Gq+vuMd05aeIBZn5om9eQ/vj9R3VTyIXIVS
         mMXs30Zi9Vt9OnatvYLzqB2pvDrSR0CnjGW0SgSi6Jcdl10OjXD7+VWk3h0sc46Boxqo
         lo/05r1gTCQjPCOjWWTSr2OWOV/QCdlLnQ1LHPwrFv6xj6i/E2RyhKWLxJZTQZqW9pw5
         PRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uKGw00/EyGDwCBJB0zqmKSmhbqqlL+sFqJV8R0jR8lo=;
        b=U24kYtyH+RKtSIpO2CUA3hvYy6MTti7ShrHF3cQU5+pOrRwfR7ZxCL2WBrH8P/jjwO
         qjwGy/MR5qoEavbP6Ti0OZkYz7uy+jSy9H4P8HR+q+KJBjfYOQei+TWyiYtigyTsPvdw
         uJF6+hqczh9EbjiHQU7jvM13PSgrzOMcIboKgKOpMwXjCIzFbUlaE3DsRFM7/qCfSkSW
         1sBc23wiBU/bHRW8cWjLPIhF8lazKtAXsK97SgloAb8RX/x88lk/SSSjnO6RMJI3Xvxq
         5MYTMf40zS4z8MNhaxAuG6OivDx2MjGRH9vDGQ5bsT0lYlEFUJ9GM3ewH8l34cbdJWFa
         ztEw==
X-Gm-Message-State: APjAAAX0av7Zn5jHUWFSr9MOlBpfqXkLfHhB9PEi3yldt1n6IhZu59ce
        Z7m/bBs1KXCsqld5LB5E1rU=
X-Google-Smtp-Source: APXvYqw5LJUrccq219snRslvx7uXsB7gyW49MH0qU4lsHDLfx2vVUXs5c0C2oPSTEdJibAUwpNrQaA==
X-Received: by 2002:a50:9177:: with SMTP id f52mr70387852eda.294.1563959388978;
        Wed, 24 Jul 2019 02:09:48 -0700 (PDT)
Received: from nb01257.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id nw21sm3927709ejb.15.2019.07.24.02.09.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 02:09:48 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/3] md: don't call spare_active in md_reap_sync_thread if all member devices can't work
Date:   Wed, 24 Jul 2019 11:09:21 +0200
Message-Id: <20190724090921.13296-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
References: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When add one disk to array, the md_reap_sync_thread is responsible
to activate the spare and set In_sync flag for the new member in
spare_active().

But if raid1 has one member disk A, and disk B is added to the array.
Then we offline A before all the datas are synchronized from A to B,
obviously B doesn't have the latest data as A, but B is still marked
with In_sync flag.

So let's not call spare_active under the condition, otherwise B is
still showed with 'U' state which is not correct.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d0223316064d..58015001417d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9079,7 +9079,8 @@ void md_reap_sync_thread(struct mddev *mddev)
 	/* resync has finished, collect result */
 	md_unregister_thread(&mddev->sync_thread);
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
-	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
+	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
+	    mddev->degraded != mddev->raid_disks) {
 		/* success...*/
 		/* activate any spares */
 		if (mddev->pers->spare_active(mddev)) {
-- 
2.17.1

