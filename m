Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD781FAC53
	for <lists+linux-raid@lfdr.de>; Tue, 16 Jun 2020 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFPJ0C (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Jun 2020 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPJ0B (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 16 Jun 2020 05:26:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C8C03E96A
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 02:25:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dp18so2522714ejc.8
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oVYXpOU0qi+X0VkvnY89NnbVbFWY8hE81phUIBnDKtM=;
        b=Z6itbyOdsLcJUprqgSZNFSO4bR+W5r/O4x8kli7Hd9Mg+0Bsb5stWe6642/G7hNUzc
         utGN5lMjhArOnsJqoNxUkWAVeigNOK/uJrKaZ74NOy52ez0cYNQ+VuQG2zBWYjuyBdbZ
         YdYENTld9/XZ3jRfFl/NAm6RfiIWyirgkpFcqpR4bnDkWnegRGy5guM36PlLXoVQ1V2D
         BTjk/wzUkmzcAEecKgPJQXd847XzLVC3joIyfPkNOOtbhxp7TeeLo70uitJKTnHNAPMo
         DZPXdi3MKin3/i4EjMcqJi6Ob0bRDmcBd+bp/yIslZCyc7Q62VMoh5u81NWV6q5x/zHO
         q24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oVYXpOU0qi+X0VkvnY89NnbVbFWY8hE81phUIBnDKtM=;
        b=fzCx9w+IIq+roRbnGRlgdyTnBvDhgPCiZWcXZlPGrhE2BOyOLVsQdkAot35KyGGkyL
         ex1HyAvZIjP2lZVz1FW4Puc3cQKxa+df3Y096qP1hFO5gm0iTDxZA+JhLVqmSaVgcq/P
         vQ8bkpFRYDq6Ba9UHsYLnuooWe7Q0Y0vvml1Lrc3xWRH6JBhsa4nTeCeFbUQabmZU1eJ
         blF4yklEAQkgtamMaR7vOf2SGtlOoYjjnO42zia6xSY5ZeG/6rWo8T03GR84NzeIa3TJ
         GWbrjyhsVzU3veFkZswsfyKXzncGZTY1raBsfCkmcKlUrp378XsbpTlINghyWcm2yU9m
         sMDA==
X-Gm-Message-State: AOAM531HVkPg70oo64KuKq76vG3AT/J3zo2CMjoboiz9CfBcFRPomv8H
        ACIIvCwRq0J3l9PQz0j3qzvt6tFKrXSG8A==
X-Google-Smtp-Source: ABdhPJwPQPGiTMiQwDoyHR5U493R8LifnAI7fjGmRrRDCDzKvJ6g8XnoZnWozrnlAWaBPUIgIeJD6Q==
X-Received: by 2002:a17:906:d973:: with SMTP id rp19mr1783219ejb.475.1592299558353;
        Tue, 16 Jun 2020 02:25:58 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48b1:7500:b0c1:1cd:44ba:a39f])
        by smtp.gmail.com with ESMTPSA id o4sm9801521edt.15.2020.06.16.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:25:57 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/3] raid5: remove the meaningless check in raid5_make_request
Date:   Tue, 16 Jun 2020 11:25:52 +0200
Message-Id: <20200616092552.1754-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We can't guarntee the batched stripe to be set with STRIPE_HANDLE since
there are lots of functions could set the flag, such as sync_request,
ops_complete_* and end_{read,write}_request etc.

Also clear_batch_ready called in handle_stripe ensures the batched list
can't continue to be handled by handle_stripe.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 45398b9b0a46..bd010835332a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5738,8 +5738,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				do_flush = false;
 			}
 
-			if (!sh->batch_head || sh == sh->batch_head)
-				set_bit(STRIPE_HANDLE, &sh->state);
+			set_bit(STRIPE_HANDLE, &sh->state);
 			clear_bit(STRIPE_DELAYED, &sh->state);
 			if ((!sh->batch_head || sh == sh->batch_head) &&
 			    (bi->bi_opf & REQ_SYNC) &&
-- 
2.17.1

