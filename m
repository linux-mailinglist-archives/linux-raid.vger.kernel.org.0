Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD9B0C4E
	for <lists+linux-raid@lfdr.de>; Thu, 12 Sep 2019 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfILKK3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Sep 2019 06:10:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45254 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfILKK3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Sep 2019 06:10:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id f19so23382149eds.12
        for <linux-raid@vger.kernel.org>; Thu, 12 Sep 2019 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0gN+4k870SjHayza/nh7X47fIsUZBa7HaVtcZLP/RHE=;
        b=rn7pSIjcwP0pgbu1sN0ytyRKYaK8lnhjKoASpthTgSlrxYczONe++PUCjSLYq3T4IU
         qozSRXQL6mmAabs1HyGGxlVr9PjLteqxP0Hy5/MWbeq3nCxbPTUBT0YKGbE0Mbq5O8AC
         QYuR69K6FPl5ce+tidYPRVAnYocnZu+AF8p7x+pQUiI7x9LxM3F+vZARTr5Fo3EK6WK5
         Py5IbFOOWTOClnY5BSuhoCxFYr/xOEcutynKBPLTupCydGp+v16QsF47kF8Aw7d0Kyqk
         7H+VPBR3l2VbqS+COIG1xsSHeHyrO9eeESHouEmAUdM76n95KNbjZ992N9YFzVe+0F21
         Y3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0gN+4k870SjHayza/nh7X47fIsUZBa7HaVtcZLP/RHE=;
        b=Dh902J78Dp+juKTkOUmEH6D85I0fC8+B+g2TndiBYI8GmD8aaJYUvvGkIhqmXpFVmw
         Yf7IqRcmThKjeq6Xe4xvBD7K3O+xw+mWDpcJIw9/BUWiBgqILJFhQsy0ywHudYFaLxD3
         G3NdYiPxwfhKP0KDXOBrPA18K/jBvTgdyw78ZVpaNQGvIotkMxTwWHhfM/BdfCz3iGLq
         TEPSYg1R+zP4eCyXRn1qnXxCMuHG+m61QStPOly6pQhVNeVdHvHBY8F97FaXYTp5WIgb
         y9M4rXPbsUC8/eXYxysXuQJIUDDvVzs3KqtL4BABOK0YxBcIO7//gkGPrTHw2xsw+N4/
         Twyg==
X-Gm-Message-State: APjAAAUkzFoxuy2Z6dki70abdn3BvWfC0YK9Q2ksnSD8ebTubptVIC2T
        jW9uQh+ccPBHSJ2cvEhRf99WHoYS
X-Google-Smtp-Source: APXvYqzIevMwpzwa0DE++FKmSaLf98umSRHVbr6wRvtjphZi9QOJHjuXTjXdmBQz2wOBjnz2lMHnxQ==
X-Received: by 2002:a50:e804:: with SMTP id e4mr36718313edn.91.1568283026697;
        Thu, 12 Sep 2019 03:10:26 -0700 (PDT)
Received: from nb01257.pb.local ([2001:1438:4010:2540:98a7:dd7f:3b50:48c5])
        by smtp.gmail.com with ESMTPSA id z39sm4709367edd.46.2019.09.12.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 03:10:26 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/2] raid5: use bio_end_sector in r5_next_bio
Date:   Thu, 12 Sep 2019 12:10:16 +0200
Message-Id: <20190912101016.3700-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
References: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Actually, we calculate bio's end sector here, so use the common
way for the purpose.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 877e7d3f4bd1..f90e0704bed9 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -492,9 +492,7 @@ struct disk_info {
  */
 static inline struct bio *r5_next_bio(struct bio *bio, sector_t sector)
 {
-	int sectors = bio_sectors(bio);
-
-	if (bio->bi_iter.bi_sector + sectors < sector + STRIPE_SECTORS)
+	if (bio_end_sector(bio) < sector + STRIPE_SECTORS)
 		return bio->bi_next;
 	else
 		return NULL;
-- 
2.17.1

