Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C21293BE
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLWJtM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39278 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLWJtM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so14778467eds.6
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=smfkjiS4CEWqmtq0fbbZDwaMjl4amSPJHrRVb/cZwms=;
        b=ui1s9MsfVeDHmroXeNB3D59SOIkqyJMmAVDk64EgbkNvIlyAS4R6To390kxbyp1Vsi
         D/Se1JhryMBKYI/D9doiAvdqI/5EANvzczZwEoDNQq+fWC5JM2pBxRJsiMOnSBdPXKWJ
         jSDoCobRm9Br4Fpbe1f/bJHK40ZjAHBfJIdwebK49lGrQI4mV5CG7G5IizBldY+QBmVJ
         znSIpOtFbbwbETwYpCpzBeCOThxRfGPv1M9j+EzYFz276zQxP24AUdrUlLmfmB+GyU9r
         jBov7OKypP6y4bCCw5IfyW+QB4tAetrAxCAATHDn968w/lRA/3/60GVFYtGwGSFvHHKz
         N8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=smfkjiS4CEWqmtq0fbbZDwaMjl4amSPJHrRVb/cZwms=;
        b=DMi8Vox5vxAAid0zmLCPMrUnv80E/7UICwKWXzDnhBu3kIERaDlKhIiALiqQlEtyHi
         gfTP20gBwU4dcExk1br25CZVKOBlBn2HCgqbm+9WXBtasptTTBkAza3LLOZOCFMZtMKu
         JVSmLMinSzMml1hf/3+aSQxKU5BMm9kx1sgDr1NUbe5GPfzBFSjKWXy2lVZI34fxBdyA
         G/0FYRdEbxta72ZGRhBkk92Kdd6XJdldFxavrY2BhuXLyF6tuiVvF2d8z4FMhMHLUktT
         AyXwj2a+7uQO9kbXl+vHH8qFF6aSFV+kXvpmtiqssaaitQtNvbq9j//XhwtvGrYo7aXn
         ALJg==
X-Gm-Message-State: APjAAAWFzLseq3+MtLVizjtJrh6eEW5JaSQrksEDnJyLsdlC6xqqWC55
        F/fyYsbKYeQQbHh3AIcP2fc=
X-Google-Smtp-Source: APXvYqxPAOMNWnhhH3Sl9yp+TQEXMBrg2bCoL8/dlJqHuGE3yDEAXcisPAv2JI24edgbm4SwAIQwPA==
X-Received: by 2002:a17:906:3cea:: with SMTP id d10mr31196760ejh.32.1577094550904;
        Mon, 23 Dec 2019 01:49:10 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:10 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 02/10] md: fix a typo s/creat/create
Date:   Mon, 23 Dec 2019 10:48:54 +0100
Message-Id: <20191223094902.12704-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It actually means create here, so fix the typo.

Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ea37bfacb6fb..8f5def0cb60a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5771,14 +5771,14 @@ int md_run(struct mddev *mddev)
 		goto bitmap_abort;
 
 	if (mddev->bitmap_info.max_write_behind > 0) {
-		bool creat_pool = false;
+		bool create_pool = false;
 
 		rdev_for_each(rdev, mddev) {
 			if (test_bit(WriteMostly, &rdev->flags) &&
 			    rdev_init_serial(rdev))
-				creat_pool = true;
+				create_pool = true;
 		}
-		if (creat_pool && mddev->serial_info_pool == NULL) {
+		if (create_pool && mddev->serial_info_pool == NULL) {
 			mddev->serial_info_pool =
 				mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
 						    sizeof(struct serial_info));
-- 
2.17.1

