Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB63519E7DB
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDDWBK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Apr 2020 18:01:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33504 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgDDWBI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 4 Apr 2020 18:01:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so14035145ede.0
        for <linux-raid@vger.kernel.org>; Sat, 04 Apr 2020 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ukVj18qwIdySoHjFrnmGPhl4+NtfyAgiY3TqSoi2M8=;
        b=X4uegDy2L1dagQnSaiuHvA0nsuo+jlLs0IHBCl5ecDJO2ACJmBZQR6gIhF2k3BefcK
         voYvXBSc9WzSIdErXGZUIj9ZuDlbMmNGNC6lno6f3oTSd5tg2SoBcXt6lPD+VogdK4kj
         9suBIWCro9PNTadEB+NB+R9PPsjG2nlOnB8abNMTk9QRWViiSCLxFDK+UwNUZCuiBFt9
         13Se6SnHP4ib2Cfqjrh1VQnWGn3oDS2yQrizb0im6G6ByHqO7lxHRM8hENM4Qw+IiWjV
         kTlQrq6DrBBLr8Yc5W2PcTnKUWVWqF69RsYSqnshyOzDEI0kCP8XxwIucSZF+BmUj3iJ
         1a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ukVj18qwIdySoHjFrnmGPhl4+NtfyAgiY3TqSoi2M8=;
        b=S8iRnHi1sBrRw9vByTLzZfKqfjqjKZLUMb1c+2ecQOKVVc2P5SV9R42MmS7E2v3KjE
         1jXHaRL0BEeupLzvvIAHXtD9PZMronb/yMTi3oorAndavQXiPFCe+u/aO+EuFd9En+GV
         b07sWaMpBoEoGVrv/vPSU1vfNuNNzUQR7kT2b/HtWIyajAtW4NcdkmXryOZiHGq5tdH5
         s+sPJz3IOIXmQY4Mv8SzhzUJ9v5EnLQlOi8bCMd7uGq2MYA+f0WEkqHemPTidLc55XpM
         qctugARabwa+cJzXHX6tp+tLhtGLHhIKmSm/IyyC3qFE4KOFbbrehWNM6lh3wNIak6rB
         9LIA==
X-Gm-Message-State: AGi0PuZMBpjiOgFH44pXYoOhjD1AzUfd8jrI7hpd/U3mPQiaRJ3jaXbi
        ZrMDOkMt2y9pu8O1EhhvhhGJkF20DcAx1w==
X-Google-Smtp-Source: APiQypKTUTgCOmlZVIxVppSzZwD/j3b14oEl7bcUPZxrSLaq6CklxBZ4VQoIC2hQH6rFF2ThZ1p1Yw==
X-Received: by 2002:a50:ab42:: with SMTP id t2mr13905954edc.333.1586037665253;
        Sat, 04 Apr 2020 15:01:05 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:e120:c0df:e1ea:ba3e])
        by smtp.gmail.com with ESMTPSA id oe24sm1718549ejb.47.2020.04.04.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 15:01:04 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 4/5] md: flush md_rdev_misc_wq for HOT_ADD_DISK case
Date:   Sat,  4 Apr 2020 23:57:10 +0200
Message-Id: <20200404215711.4272-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Since rdev->kobj is removed asynchronously, it is possible that the
rdev->kobj still exists when try to add the rdev again after rdev
is removed. But this path md_ioctl (HOT_ADD_DISK) -> hot_add_disk
-> bind_rdev_to_array missed it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b4ea0f38ccd8..2bd2d91f2015 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7511,7 +7511,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 
 	}
 
-	if (cmd == ADD_NEW_DISK)
+	if (cmd == ADD_NEW_DISK || cmd == HOT_ADD_DISK)
 		flush_rdev_wq(mddev);
 
 	if (cmd == HOT_REMOVE_DISK)
-- 
2.17.1

