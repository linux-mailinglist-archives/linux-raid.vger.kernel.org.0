Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521C7230728
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgG1KCO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgG1KCO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 06:02:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E0C061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so14348261edr.5
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tFZLAisceZUJmnPwIqJ0HNmC00HRURzPKwfSsnL6ZYY=;
        b=G35ubIzTsRUOvYDwD+LIpTCOXt9bJow9gEBl1JKWZuJdXCdIdV6K+VrmS0p0q8SPAi
         jBwf0qPp8EUpRoxqLQsPohMWxLzFqSbZ5z1ezs96/VlUx8nDOCwM4BeWml79zNSwbJDW
         3CMAqDJ4SqHJ9ytzWSGZh22WXwI0Mo8bfzkbIe1nsZNoGWWtwh1hYaAmUtt9q3TkXTBe
         970r1Kezd2ctwreazThWxCsbnjt8USSOUI8ixMGTO/nqAoIwhyRJj8F400MYmUlGmLUr
         o47Wz1yxdp82TM17pQhGo4s2MheSDbwjT4bSBXUuH6qw5izstEB1v8Sq8Co8a8c5Tg43
         +g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tFZLAisceZUJmnPwIqJ0HNmC00HRURzPKwfSsnL6ZYY=;
        b=cqIe4QbfdNw3Vlx+FU9YfmYkUOQXliBQFQUfVCMwsG+9rDBRT6Kj7K6xfG5mgFzlsE
         shy2b+H43B3vj39F6oswYUvItm+A7P/9WhUGaZBgPh8YC1ofDe2lhIXouoc+fTYOrWFF
         vnC/brCkoCzh1nsj28atzS7ru8O2r9bJONlBSX5Wn3t4LmhYl+k25FJWrcdkHef2t47e
         RcN1o3TgZJMKEeKtXSf8rp2KpuAqoT3TsLY8wCl3x5p8WZqIe5xWJnbqMjsu8/a1/KCq
         MBBhhuz7Qp8RBix8uZxVyo3xlsW3INlT35ZdzlbzHOV1oN69TRBaJgnUdGCg+Izr1LnR
         wDHQ==
X-Gm-Message-State: AOAM531u+2nZULMmPGXjCmmJ1a1HehUV/R/xqxsv88HHFyL0fv/31w5r
        jArBWQzbz/iQ093Kc6B8KNkT+A==
X-Google-Smtp-Source: ABdhPJzoI9uMsqTd+qH5mmXevbBWcDVjwp8o2Hd43LWr0jSH4KAuhVjl+7DtuIqN7czAaSQ4RKGILg==
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr24657801edr.164.1595930532734;
        Tue, 28 Jul 2020 03:02:12 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id b24sm9929530edn.33.2020.07.28.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:02:12 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 4/5] raid5-cache: hold spinlock instead of mutex in r5c_journal_mode_show
Date:   Tue, 28 Jul 2020 12:01:42 +0200
Message-Id: <20200728100143.17813-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
References: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Replace mddev_lock with spin_lock to align with other show methods in
raid5_attrs.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5-cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 82eb4a906e31..4337ae0e6af2 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2537,13 +2537,10 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 	struct r5conf *conf;
 	int ret;
 
-	ret = mddev_lock(mddev);
-	if (ret)
-		return ret;
-
+	spin_lock(&mddev->lock);
 	conf = mddev->private;
 	if (!conf || !conf->log) {
-		mddev_unlock(mddev);
+		spin_unlock(&mddev->lock);
 		return 0;
 	}
 
@@ -2563,7 +2560,7 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 	default:
 		ret = 0;
 	}
-	mddev_unlock(mddev);
+	spin_unlock(&mddev->lock);
 	return ret;
 }
 
-- 
2.17.1

