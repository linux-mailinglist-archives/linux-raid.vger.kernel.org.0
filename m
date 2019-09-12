Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9BB0C4D
	for <lists+linux-raid@lfdr.de>; Thu, 12 Sep 2019 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfILKK1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Sep 2019 06:10:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37823 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfILKK1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Sep 2019 06:10:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id i1so23468876edv.4
        for <linux-raid@vger.kernel.org>; Thu, 12 Sep 2019 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+RV815PnOSxrWm/8w7jXfBXrm1MhMX+Jmj6hNyGVxE=;
        b=eaaeXnAfRfUont7lXbfEEFZjjd5lmLEs4EGYyjlPM/DmUxUnuNp4oAqanjQrrpKzof
         79FlkRAsyx4U4Hyx7sZK1/QHWXvmMNyjzTK+u1i702+nANdoNSB6Q3YCqu2lh6oT8rAg
         P7WELdHXD3rPZ59861oM5oynwF+ohrx1G3I3DlMsmuT75TBfTYdU7QQ6W9MHOxVC1LT5
         W6aT2Y1XJA4eceOfpJXmDkaExDE1Bb0qJ79dIllJ/HYf49o1XaD2TZAjYklHVBHblwtA
         z37dWM2E3hJ8p2ca1mUA06y11K/kAXpaRU8Vc/kjsbqqTvYHbkpVvZMH7QUtXhKLy4FY
         hk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+RV815PnOSxrWm/8w7jXfBXrm1MhMX+Jmj6hNyGVxE=;
        b=HsALuA6XEZZDIWNyeh12wywGq0mcvEpnXDpGXpDd8l6Wf5w0uhebwlarHyJ26o5ROg
         fhzLav9gVuLmF5jXNLifNzXtw5BCSMKNciTw2jbPT4wW28Jj1bvtdvcajtngUSujH2yY
         gPLthbzPWxE42AU7T71dGhDFzSwGJVny/xtCI47ef5zuAWrX3mNHE/ZWsezfMNOV3ElJ
         lXbv7SUj8790oW/QH4q4krmGNt3Gtwms8/ObyUErQ6RQEU1tVo08Yqx4GZrhP0TawbaC
         VSFaBO1YWdlPt81FkhJjmK59h7Osx/1AuAgJ8+f2Qncz23Lz8yz7sfXCjQKT7UtLvq58
         fSkA==
X-Gm-Message-State: APjAAAXli1FJfSmoNZN5/19nisfjpCdgsSQ2ZGVqk0vqsRh/Asx52SMD
        qvfW6GNDWgXOY4A3ELfO+aw=
X-Google-Smtp-Source: APXvYqz2zy7nOEP8u6jtGJWKFqomJes4j6DYYDjDDpFoiS3LMmWc1ES4UwkshTbGJxzqtk6jgj6kKw==
X-Received: by 2002:a50:acc1:: with SMTP id x59mr8973239edc.278.1568283025811;
        Thu, 12 Sep 2019 03:10:25 -0700 (PDT)
Received: from nb01257.pb.local ([2001:1438:4010:2540:98a7:dd7f:3b50:48c5])
        by smtp.gmail.com with ESMTPSA id z39sm4709367edd.46.2019.09.12.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 03:10:25 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/2] raid5: remove STRIPE_OPS_REQ_PENDING
Date:   Thu, 12 Sep 2019 12:10:15 +0200
Message-Id: <20190912101016.3700-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
References: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

This stripe state is not used anymore after commit 51acbcec6c42b24
("md: remove CONFIG_MULTICORE_RAID456"), so remove the obsoleted
state.

gjiang@nb01257:~/md$ grep STRIPE_OPS_REQ_PENDING drivers/md/ -r
drivers/md/raid5.c:					  (1 << STRIPE_OPS_REQ_PENDING) |
drivers/md/raid5.h:	STRIPE_OPS_REQ_PENDING,

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 1 -
 drivers/md/raid5.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9fc6737e9713..223e97ab27e6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4621,7 +4621,6 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 					  (1 << STRIPE_FULL_WRITE) |
 					  (1 << STRIPE_BIOFILL_RUN) |
 					  (1 << STRIPE_COMPUTE_RUN)  |
-					  (1 << STRIPE_OPS_REQ_PENDING) |
 					  (1 << STRIPE_DISCARD) |
 					  (1 << STRIPE_BATCH_READY) |
 					  (1 << STRIPE_BATCH_ERR) |
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index cf991f13403e..877e7d3f4bd1 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -357,7 +357,6 @@ enum {
 	STRIPE_FULL_WRITE,	/* all blocks are set to be overwritten */
 	STRIPE_BIOFILL_RUN,
 	STRIPE_COMPUTE_RUN,
-	STRIPE_OPS_REQ_PENDING,
 	STRIPE_ON_UNPLUG_LIST,
 	STRIPE_DISCARD,
 	STRIPE_ON_RELEASE_LIST,
-- 
2.17.1

