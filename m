Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3893619E7DC
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 00:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDDWBL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Apr 2020 18:01:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33507 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDDWBJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 4 Apr 2020 18:01:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so14035174ede.0
        for <linux-raid@vger.kernel.org>; Sat, 04 Apr 2020 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sasMMxe0Np49aRdJryUE28lhi0ZszWvbk8Y2IfEnVaQ=;
        b=d+b8P9h8hAae2lKOYnvGcUE+CSCM+X0zl5pQGcQhMYhTFIHwehChx7SZiZV/lkk+3s
         0NxmYDye+5l3zKcm96g5BeuSfXVytnM/YyowKScMX2CJh7nR0VBmJzyiwVErK+ye2oEG
         nri0Wt/y5/DsNLne23OQ1ctpF+6kcuS7zqctqj3zKWVHMRpcnobyhgSwXdz7VK2y1nvF
         yanm01/Kd6EjHgrhnT3TP4pHvbQMxzt51NQ6Cq1YbWK0/p/Ix3+rd5srwTNzI3/a0cX9
         Ty5MGMWF8MeDzyWOjuLOk8QS8VKBlStQqV6geXeETKslfjVndK7xns9G3nbkDM+xMOkb
         UN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sasMMxe0Np49aRdJryUE28lhi0ZszWvbk8Y2IfEnVaQ=;
        b=jlpQw4clK8MOsOxGe/100YUTON4+d4uAWDWD/a51762ovy+BYrGioaJ12ZyAc73j/D
         9WJMQPK32o0gWx4zt6viRHL44TVs3bXhmGKL7Bec+a64/UMnOGObmeGqgwyMt1We0tFD
         XZEUp92vCA8Cm5lBArtkNwxtJpRj8EmzX0pjH0J3FmqAVxe4UezoRq9qLF8BHgSWEoKB
         4dN+1SdHXWPPR0cKcRUNzCIkNASI5rp3MT1uZLmFih5vAElEs6oNLU7WN+4PfBEuIL8e
         BCu8D3lP/ll6QSMh1iXtYbQFjvC79mo5DPLtPZP7egoUHPwSgb7hfPTCQo/mGhWuu4RM
         rDYA==
X-Gm-Message-State: AGi0Pua+vkaUdWCbOeQy0BpK5vJqcoDZP6yUM0UBjRd4j7E9NipdylcN
        EuuQ8mtBH8Y4AHIc1+ACRJR4BA==
X-Google-Smtp-Source: APiQypLsOYNUCsSgR/6QMjuHt4viE3Jo4ZSj65xVuot6l3pFBs0QNYxx1zWRRABy7uc8YNwWOsYrLQ==
X-Received: by 2002:a50:f383:: with SMTP id g3mr12854672edm.316.1586037666201;
        Sat, 04 Apr 2020 15:01:06 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:e120:c0df:e1ea:ba3e])
        by smtp.gmail.com with ESMTPSA id oe24sm1718549ejb.47.2020.04.04.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 15:01:05 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 5/5] md: remove the extra line for ->hot_add_disk
Date:   Sat,  4 Apr 2020 23:57:11 +0200
Message-Id: <20200404215711.4272-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It is not not necessary to add a newline for them since they don't exceed
80 characters, and it is not intutive to distinguish ->hot_add_disk() from
hot_add_disk() too.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2bd2d91f2015..a378b6d63fa9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3190,8 +3190,7 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 			rdev->saved_raid_disk = -1;
 		clear_bit(In_sync, &rdev->flags);
 		clear_bit(Bitmap_sync, &rdev->flags);
-		err = rdev->mddev->pers->
-			hot_add_disk(rdev->mddev, rdev);
+		err = rdev->mddev->pers->hot_add_disk(rdev->mddev, rdev);
 		if (err) {
 			rdev->raid_disk = -1;
 			return err;
@@ -9056,8 +9055,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 
 			rdev->recovery_offset = 0;
 		}
-		if (mddev->pers->
-		    hot_add_disk(mddev, rdev) == 0) {
+		if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
 			if (sysfs_link_rdev(mddev, rdev))
 				/* failure here is OK */;
 			if (!test_bit(Journal, &rdev->flags))
-- 
2.17.1

