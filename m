Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E8372B28
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jul 2019 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfGXJJu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Jul 2019 05:09:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43780 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfGXJJt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 Jul 2019 05:09:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so46462414edr.10
        for <linux-raid@vger.kernel.org>; Wed, 24 Jul 2019 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DN2ta65s70UIRir+DhOXQKnpc3+Ijh7Wptb9K6O1gKQ=;
        b=NBCfq4owTUnUKUxaZVRKD2qAqouv36KFhiAXJZUPsH4KfprUSo8FF1yk7uX56NLsJo
         eGSm6FVBdhLJNCYfw0pUTyQnPdpSuM5qjFpaDjxRRocNuyjcyN1/N0R9VRvpembPp5/5
         fql6kUqLGRqWeBQDmZWtpbZei99PXWktMmFEhYLaJzdlKes60bza4pqLILyAlLpA2AjM
         JCzz+OyjFGOiQ/9bgk/6LSF0rR9c9VPELwXE4MeDVKdPvvts8nm+DTvNlraiKUSk2xnb
         Hz+FuS8/blLAxrkaYtFF+H7Z1CazD85HGUY5EfvbxHGvH01I5RsB8v19DyNTim2Tqsv/
         RU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DN2ta65s70UIRir+DhOXQKnpc3+Ijh7Wptb9K6O1gKQ=;
        b=ei7O0ALlr1f3rqBae+c/icvnLxGB08EzlaGyWSJCgeCHE48330eZ5Bk+fVncukPzZr
         GBfh8BpNDogTqvFa0uznQb0Ft77suinFWa5bVzuxYwu/11OoFF4vMZj7Sn7zOH5AM55w
         TDGKT9jNdtO6n6teo0zY1Znqbj/gF0w+ecgfwfDi4us4kmfkryGLxZTSdjUCGxX3yC8l
         ylq4CRHeiePIN+jer55/wS+DdlcC48iwtYLe6zA7ZLEOltOBeqtSBwf/y46kAPwlFqv6
         fXcjrhpInb4TCPxK3BnozUYsqq5lGTzYpB+vJRIk3d92FA+H/8yFqBfkL8IFnarFUOxO
         V1cg==
X-Gm-Message-State: APjAAAX46Ng5bF8IGGGADPSzcAeZBb7u7PlyTYQ9ree2dauFQ56V8Y15
        0pl8Gb9bWH2krFGESRud9ce9C6nB
X-Google-Smtp-Source: APXvYqysq58WSaQuX6lSEl6LyvQ/hD6pdWO28YWDaHKPJhYx1FrFPqm1dfOiF5fCd4f7zu00ntb9tA==
X-Received: by 2002:a17:906:ad82:: with SMTP id la2mr63066284ejb.123.1563959388175;
        Wed, 24 Jul 2019 02:09:48 -0700 (PDT)
Received: from nb01257.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id nw21sm3927709ejb.15.2019.07.24.02.09.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 02:09:47 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/3] md: don't set In_sync if array is frozen
Date:   Wed, 24 Jul 2019 11:09:20 +0200
Message-Id: <20190724090921.13296-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
References: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When a disk is added to array, the following path is called in mdadm.

Manage_subdevs -> sysfs_freeze_array
               -> Manage_add
               -> sysfs_set_str(&info, NULL, "sync_action","idle")

Then from kernel side, Manage_add invokes the path (add_new_disk ->
validate_super = super_1_validate) to set In_sync flag.

Since In_sync means "device is in_sync with rest of array", and the new
added disk need to resync thread to help the synchronization of data.
And md_reap_sync_thread would call spare_active to set In_sync for the
new added disk finally. So don't set In_sync if array is in frozen.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0ced0933d246..d0223316064d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1826,8 +1826,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 				if (!(le32_to_cpu(sb->feature_map) &
 				      MD_FEATURE_RECOVERY_BITMAP))
 					rdev->saved_raid_disk = -1;
-			} else
-				set_bit(In_sync, &rdev->flags);
+			} else {
+				/*
+				 * If the array is FROZEN, then the device can't
+				 * be in_sync with rest of array.
+				 */
+				if (!test_bit(MD_RECOVERY_FROZEN,
+					      &mddev->recovery))
+					set_bit(In_sync, &rdev->flags);
+			}
 			rdev->raid_disk = role;
 			break;
 		}
-- 
2.17.1

