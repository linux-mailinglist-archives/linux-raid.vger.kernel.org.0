Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37C230729
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgG1KCR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgG1KCP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 06:02:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A2C061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so11126934edv.13
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8p6KxgEWLFqJrbDYZOZTj3GBppWuXRTTB1HoRo+02Q=;
        b=VCkgYmSw3Q7e5hJA2us8oVdU7CXfMDqcYRr+PKWR/oITXgNeHZBJ5U2yxziBfnuT2/
         h/NOZCh2FEF3PAS9CaNgJvLT2oMxJU5W6yqI7ztLLk7vpte2T19FOKwYGq9C5XWwawWP
         LVsSpGejs++tm+QSFi0BRSVVu/zqVYj5yOKm9Z/ZhBx8lGgLSnSk6qr0HwqzxF/4R7R8
         TvInKHT66lGXomON7zraNFG8gmkuyJSFP0UKAycwf150i+7GNqbrf6dKYESzNKvZyOns
         3ABl6rbqMq6AwGooPxuGc1Avpmd2apiDdMNGnNqp47fcMSdBb0xlev2+uajFLyEsQ18f
         QDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8p6KxgEWLFqJrbDYZOZTj3GBppWuXRTTB1HoRo+02Q=;
        b=NH5TEjqVYJqVExl+AFX5scGtMmv3CkeamgpFXH0ul4MaryZ/3F5RZ9U23TxmgT5NFj
         sK4WAKU2Ox0Kn/CEuLrsjK4anXhGqO3lFZl/sHxNpI6Vv7xDIsQWpzrBifidAkk0FKLE
         OHAUJXP4oJ6G2eR/kWwZYD5iyMPfl7B1nO+DZQKpjLon+OVMBxw5Aez6TPBCK2xX13oj
         0G2SuNDUIUwBc/zxpt5HEgMVHU24e5PCd1/JYwyDloeDi+vdStng+ZLmCENqNwry3Ggc
         nXm7WiCHhvKXxj7LzH90OJRglPTmB4DrFlB/NUif+dLth8baqu08OPpNg6lzTXd1W8sq
         vLLA==
X-Gm-Message-State: AOAM531BlBLrkoHmD/u3wE67E83KtJy8v+shnaQrK3djlTVfQnapN5xe
        piS7Sion94f7yTxs3LutEGpELA==
X-Google-Smtp-Source: ABdhPJxw8zFvKTAPxZZBr1a0saJyQVdmAHAQhPVTOBJggYa9wCmj2KvdguG2o+Zj9QE8o8kIa/rKng==
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr19170457edb.48.1595930533625;
        Tue, 28 Jul 2020 03:02:13 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id b24sm9929530edn.33.2020.07.28.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:02:13 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 5/5] raid5: don't duplicate code for different paths in handle_stripe
Date:   Tue, 28 Jul 2020 12:01:43 +0200
Message-Id: <20200728100143.17813-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
References: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

As we can see, R5_LOCKED is set and s.locked is increased whether
R5_ReWrite is set or not, so move it to common path.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 790d91aa5f40..b06edfaa73b0 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4966,14 +4966,11 @@ static void handle_stripe(struct stripe_head *sh)
 				if (!test_bit(R5_ReWrite, &dev->flags)) {
 					set_bit(R5_Wantwrite, &dev->flags);
 					set_bit(R5_ReWrite, &dev->flags);
-					set_bit(R5_LOCKED, &dev->flags);
-					s.locked++;
-				} else {
+				} else
 					/* let's read it back */
 					set_bit(R5_Wantread, &dev->flags);
-					set_bit(R5_LOCKED, &dev->flags);
-					s.locked++;
-				}
+				set_bit(R5_LOCKED, &dev->flags);
+				s.locked++;
 			}
 		}
 
-- 
2.17.1

