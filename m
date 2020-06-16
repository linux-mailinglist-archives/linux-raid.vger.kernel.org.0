Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12BD1FAC52
	for <lists+linux-raid@lfdr.de>; Tue, 16 Jun 2020 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPJ0A (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Jun 2020 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPJ0A (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 16 Jun 2020 05:26:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8919C05BD43
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 02:25:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so20726648eja.7
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nOHYjwVU0ADUNFgkxHs2GTlHKchbTgepPHFMHCXk98c=;
        b=WDgjCZYOnHBjU63zrFtKTlqBIx1NkUcx6UEgnMngfBWC9HixOou7y5g3IdltWhHpRq
         plJIwJrPQ4gX8ss5lz2wScRP+biTUB+eLC7C+qrOX5/q5hrpChKC9iFqPG0jpbBGuwKI
         mBjfNuAh3PFk8pMCAwnOM/C1qMRzw9mtMQwyeODsKZp6c3U+uUc0ARkN5GyRFTmTggrZ
         asr2PDHYo4b+hgP21u/JCHhokGmErDQDpYdiEPAFP4WyMNTPMrKH3+ZhHGNc/SA0zosX
         L+aw5Kr/bQIgjCoFsCMnh4V5CLwmsIp2bH8mSMrr+9Y45WZwxV05VMECU9eTGGY/tTl7
         F17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nOHYjwVU0ADUNFgkxHs2GTlHKchbTgepPHFMHCXk98c=;
        b=XWAeveopRPJmlOiO3vVPxYhVnhz4RGD7HyTpLRs7ZhvX/9xqlQY+xPbf3WMfAYwo1s
         9a1AsAl8efuO/yBOOxhOOO2Ot7JAu4hEqqB22bmtwS9Jl4ByjMeUqgrOrP7Lc8UrE+Ei
         UORos0jRyRZD7pYcuAZulhcVPfGY4aan/qG3HwWgMrO+ZivrdjA5UJJ9BRJj/dPT4Iif
         BkvEyhPUVJ8aMeDG7DWZ+HtYZRxTNyA7h4zfTBMQxHj/Gib29FbCGIfaLT/CMHIPZh+T
         W8dvqYaauKo2pZ7OJqCMQx0k8SoFDO688Ijhd2pCQIZAslBthwybkFTUieSZ03fgo594
         mngA==
X-Gm-Message-State: AOAM531oOxRc5Cpg+30ICAmNJg/WQe7UurhJAKXo885/bMlqc+2EEBCS
        3U+qVt+uyCBWsFvMSmEpIHTq2qepRzdSwA==
X-Google-Smtp-Source: ABdhPJzs4bMZ5h9t3UtSUxBbSUpx62yJ2RfVAkywVMBM9BVA9C40zabMm0hhs3rqF/hzIV+/jaJX3A==
X-Received: by 2002:a17:906:48d8:: with SMTP id d24mr1839612ejt.369.1592299557394;
        Tue, 16 Jun 2020 02:25:57 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48b1:7500:b0c1:1cd:44ba:a39f])
        by smtp.gmail.com with ESMTPSA id o4sm9801521edt.15.2020.06.16.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:25:56 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/3] raid5: put the comment of clear_batch_ready to the right place
Date:   Tue, 16 Jun 2020 11:25:51 +0200
Message-Id: <20200616092552.1754-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

To make people understand the function well, let's put the comment to
the right place.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index a35332364f07..45398b9b0a46 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4573,12 +4573,12 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 	rcu_read_unlock();
 }
 
+/*
+ * Return '1' if this is a member of batch, or '0' if it is a lone stripe or
+ * a head which can now be handled.
+ */
 static int clear_batch_ready(struct stripe_head *sh)
 {
-	/* Return '1' if this is a member of batch, or
-	 * '0' if it is a lone stripe or a head which can now be
-	 * handled.
-	 */
 	struct stripe_head *tmp;
 	if (!test_and_clear_bit(STRIPE_BATCH_READY, &sh->state))
 		return (sh->batch_head && sh->batch_head != sh);
-- 
2.17.1

