Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7600910B3F6
	for <lists+linux-raid@lfdr.de>; Wed, 27 Nov 2019 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0Q6C (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 Nov 2019 11:58:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43969 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0Q6C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 27 Nov 2019 11:58:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so5298126edb.10
        for <linux-raid@vger.kernel.org>; Wed, 27 Nov 2019 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AqmpVlHZkL6QvsBe3wvYGWc3XBdV6a9oKwNvw0YnCr4=;
        b=fQ9zO13daLNvKwqp/+6anU2oXNnEAfO5Zj+JyfwRQ12YkAg4E9Dg+AN+r6xDuAXSaw
         h/ITBv2YKPK6RIbe1ClAVu7DelIIwNBzOiySD/Hh9msbugso1UfPEgGcfJEtCposI5Es
         IsNqlwdRUn+EgzHS7NIV4A4VmkP0A+/FrQlwMfYAEVS5H7borfQzTkWgC1IjkdGR1f5x
         bdMoT5fFHXiJJK13nMEl3X4GMSHBUFHLC5i+NH6UA3ZZELIb7ERZCkjYdUrpVoU+7A6b
         ACB+21F5YEMOjxWTLc9bIId60tsA8Pb4teIp1DPY02mXut8xnxupBf0L+RMSWkV9ZCiT
         YsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AqmpVlHZkL6QvsBe3wvYGWc3XBdV6a9oKwNvw0YnCr4=;
        b=s0cVSUSflErO2I+HFf7lxml+yB6Npq7Rp+A+XRiAGGPYsMgS+XpY8GM39ZCpjf1UPh
         xNHomLzcfq6wGLSsUdLZBNwF2rigbjUn0ltAr52C10wFghRrwHgmkJko2qLhWE8mEF9g
         fHw85UvH2DPmtI9aBXSzClwMWVD/EsPJIwZ+d0J+abR7X1nAy4JOMhqoXsPr3i7Bppbf
         CGZFePjs7gxFnOaSj/uSXk28uX5I5r3XIqBByDJiECMYkqpXGz86Q0SqFGw/jSPIFFgL
         ct/a46xlo6n0yjO3IozUPow3y5LTiFSajLz21tJdIsHHQCraxg2jRZ3AefqhtuuEU1iB
         55nw==
X-Gm-Message-State: APjAAAUAoG77lVwFbHhqS7PXRmmyGblQDbwg7/knhl7ufOQTmntZa27Y
        sOmipEwjLuMx15OTHauwNcYTKiB2
X-Google-Smtp-Source: APXvYqyJW2XMJ5QHeD+MvicFp55hWNeStGjNlP3l62ePblVuQLb3hY15D3G9aOZ/Dk7t3X1x2Kx8oQ==
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr33367945edr.40.1574873880235;
        Wed, 27 Nov 2019 08:58:00 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:81de:6723:8abb:20dd])
        by smtp.gmail.com with ESMTPSA id u2sm728674edj.94.2019.11.27.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 08:57:59 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     linux-raid@vger.kernel.org
Cc:     liu.song.a23@gmail.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: need to set STRIPE_HANDLE for batch head
Date:   Wed, 27 Nov 2019 17:57:50 +0100
Message-Id: <20191127165750.21317-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

With commit 6ce220dd2f8ea71d6afc29b9a7524c12e39f374a ("raid5: don't set
STRIPE_HANDLE to stripe which is in batch list"), we don't want to set
STRIPE_HANDLE flag for sh which is already in batch list.

However, the stripe which is the head of batch list should set this flag,
otherwise panic could happen inside init_stripe at BUG_ON(sh->batch_head),
it is reproducible with raid5 on top of nvdimm devices per Xiao oberserved.

Thanks for Xiao's effort to verify the change.

Fixes: 6ce220dd2f8ea ("raid5: don't set STRIPE_HANDLE to stripe which is in batch list")
Reported-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f0fc538bfe59..d4d3b67ffbba 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5726,7 +5726,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				do_flush = false;
 			}
 
-			if (!sh->batch_head)
+			if (!sh->batch_head || sh == sh->batch_head)
 				set_bit(STRIPE_HANDLE, &sh->state);
 			clear_bit(STRIPE_DELAYED, &sh->state);
 			if ((!sh->batch_head || sh == sh->batch_head) &&
-- 
2.17.1

