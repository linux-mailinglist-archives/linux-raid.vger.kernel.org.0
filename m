Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CAE230727
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgG1KCO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgG1KCN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 06:02:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB52C0619D2
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d6so6201971ejr.5
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7gX/iljWlVMAq+ctXkOZxewE0+JVKdgYHvakjRbLxQA=;
        b=PM7LMICo8igg1OFq21bHnjb4C8CTvdSQNk6sUoQISyPxfcHPtxYADaJ2yI0in7GzoN
         xxHxd2NTQCVL/VvGk59IIrdjCAystyAK5hZTidO6k98G6ULTcB9uijFxc//PXi0cYFHw
         Fg1TciWc+ml6bg4TDXHLy/XRtMjFkfbUmoYfILZatacC+/j429UKyERTYFYOC6FO1Ddk
         Dy2y+fd5J9cqHtlz7KaIVOSR0C3g7ca6lwx6KT0LpsB/AqS+U8xB4i2SykWLhRphxaIN
         5uZkPt86lzo0kyPwgSZ14V96cf6H3UN1uQE5VFyzbYD6dWHAxL8JHk7chrJ7zUOTNKwh
         /5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7gX/iljWlVMAq+ctXkOZxewE0+JVKdgYHvakjRbLxQA=;
        b=qzqlQ01gdfLEx5PHK475sn2GXr7u6DPjPhphPa7zgAVkym4Nes2OOf18T8MUHJUq34
         lWf+2l45AkT+ORaBMCq4UyNoxGI73o/d78ElKzIfXF82f/OxFpfhmbWgdbbdVTft0px9
         HI6eYLpc0kLvIZmdIuYHrlMx29xifYUuGZ+GeYylgw7bBxisnPb0mBEPypLqwTAtqizb
         RQFs1zeb2fWrD74fCh2cM/QdU2HGaR/OjsCU6FTDhse3jEuG/xmXKxNOTAS7de3PCOae
         Ls3kTg0mAUW0tsVjTw+lmWKGYtDBdxELwJapK3WlhpKnTp2zCkhXi4me/yvM8FfG0T6R
         TkEg==
X-Gm-Message-State: AOAM530oke75a3rFqX2IYHXPDoeqPvzzXynlvep9jv/aGS/QJk5M6LD2
        S3z/X1vgK/WPGOycZFB/mlGX9vDaJa3HIA==
X-Google-Smtp-Source: ABdhPJzqcUaR9Gvrov9/0HA/sNp2FzEu2WOZtaBlb5LCyYIZW5S5kIykdRyhQ70uSJO0CXunHI8Jfw==
X-Received: by 2002:a17:906:40d3:: with SMTP id a19mr16749786ejk.474.1595930531221;
        Tue, 28 Jul 2020 03:02:11 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id b24sm9929530edn.33.2020.07.28.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:02:10 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/5] md/raid5: remove the redundant setting of STRIPE_HANDLE
Date:   Tue, 28 Jul 2020 12:01:40 +0200
Message-Id: <20200728100143.17813-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
References: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The flag is already set before compare rcw with rmw, so it is
not necessary to do it again.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index a6ff6e1e039b..790d91aa5f40 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3995,10 +3995,8 @@ static int handle_stripe_dirtying(struct r5conf *conf,
 					set_bit(R5_LOCKED, &dev->flags);
 					set_bit(R5_Wantread, &dev->flags);
 					s->locked++;
-				} else {
+				} else
 					set_bit(STRIPE_DELAYED, &sh->state);
-					set_bit(STRIPE_HANDLE, &sh->state);
-				}
 			}
 		}
 	}
@@ -4023,10 +4021,8 @@ static int handle_stripe_dirtying(struct r5conf *conf,
 					set_bit(R5_Wantread, &dev->flags);
 					s->locked++;
 					qread++;
-				} else {
+				} else
 					set_bit(STRIPE_DELAYED, &sh->state);
-					set_bit(STRIPE_HANDLE, &sh->state);
-				}
 			}
 		}
 		if (rcw && conf->mddev->queue)
-- 
2.17.1

