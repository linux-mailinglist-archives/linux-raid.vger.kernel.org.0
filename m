Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDCA65D7
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICJlU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 05:41:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36520 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICJlU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 05:41:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so17914810edu.3
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f0AHviueCngogcidgZX4n+1PeUWOF3mugU2WIfzKer4=;
        b=NeeQHZgZQacbtvZl/q6jRXnjYOKRIRDxaHbMDUywPy0/jNzh1pksFZwGDtCcqjBodt
         On4gWGa+HCX6GZaY4PWCsVI+wuIQXHkL/CLcvO6o9UqsJpCuZkbjztGm9wTe+CN0/de7
         qu8yJog/1I0BX4JAF6dnTvbQTYhvP2ADzthHnUkjXCGNEvCnylAjJlV5xmMY0D+aMEK2
         FG9hlLGf/SVcrogMfxeEY1h+QA8TK9OPg3F6bbpwx7r6tmYJfBT6cOV6FgXlzHWDJmhT
         DPcDjk62ntHUTPLxCJbMWuddmw6tAkfsNKf425zrg1dWSjJPPHiYmYlibhOJG2qSBUIh
         noag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f0AHviueCngogcidgZX4n+1PeUWOF3mugU2WIfzKer4=;
        b=fSzdL3hkfD8Hn89lcxZFHXpHECWqO+s+5MXrYgNNxttK6vgAmPhfHo9J+40kDfwbmc
         xZfnGDCKDA8O04vCHekaStPVLUgVHgzSRNq1MLSSztPNeI+9aPzUeQKrvWGD+DXgXeau
         a/1+L/7eEtR8zAJYRZOGtqnmK5T+56SMcvLqXOz21/j/CUiLbaBzyx/LNbyRjhEkZOvY
         bLwb/gceaBT5BguCj42+i8i4lYbP6YzYo19bGaK3t2giv/F8kz75wx5Tl73/lrUbrORZ
         gqKCa2zhQAyU8cB3t8UmLd2Nhm4meZWUc1rGJ7fqkYILB9Nnsg5lhWqvoN85usyrF0PQ
         jhNg==
X-Gm-Message-State: APjAAAXwJ2OETAWYxyhvI11d921kiAe01oy6Yo84FBl0omvzrbmSYWbY
        5gOpmlUH/ukcDu45mhuQtM8=
X-Google-Smtp-Source: APXvYqwPrBQ0SwFazB7L8BKbRQF4PtSrNZ2iOgSYp6xdZc/p3vQuS+7VwE9UD1N8JALz+FupNCuqOA==
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr34818795edy.119.1567503678719;
        Tue, 03 Sep 2019 02:41:18 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7db7:e288:8c6b:8735])
        by smtp.gmail.com with ESMTPSA id k20sm188007edq.17.2019.09.03.02.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 02:41:17 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] md/raid5: use bio_end_sector to calculate last_sector
Date:   Tue,  3 Sep 2019 11:41:03 +0200
Message-Id: <20190903094103.25151-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Use the common way to get last_sector.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 88e56ee98976..da6a86e28318 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5499,7 +5499,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		return;
 
 	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
-	last_sector = bi->bi_iter.bi_sector + (bi->bi_iter.bi_size>>9);
+	last_sector = bio_end_sector(bi);
 
 	bi->bi_next = NULL;
 
-- 
2.17.1

