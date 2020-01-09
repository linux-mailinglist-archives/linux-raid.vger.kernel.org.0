Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD79135AEA
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2020 15:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgAIOED (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Jan 2020 09:04:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgAIOED (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Jan 2020 09:04:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so7455109wrj.12
        for <linux-raid@vger.kernel.org>; Thu, 09 Jan 2020 06:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zB1gfeRRLAVNXrCteYdscS0btSx1R4gMEFQ5Q+OlqDQ=;
        b=k39FytymIwbch3mTVap1srEERF5iEPijX8QNrOlq3XoXdRTKdbmTs3VwMdqWsSSN4v
         VqP9AmkOInThieLKpA+k6vBAfTybWc5Ejp6MWCOA5kPqaWOyrxeuALRkbHe+ddFWlTz2
         q34Y/W8qDxtkMjl+W5nx/F0jEa14mqwwQty17Ze3GM0gpGszg/fkBph2IGumuY4agKFO
         ELIveH9Ao0kV8ZhivhgGg298wV7Ew+Vo6cIPhpX1/nk65L3Pm1mOLCwdcV5TrqQslHFv
         a9Au9YcK2XqayVh9bLjx8NPpmGW/nlw4FCtXfTTSlZIrkgntMJjvI2AXdR9K0Y2Ao4UR
         9zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zB1gfeRRLAVNXrCteYdscS0btSx1R4gMEFQ5Q+OlqDQ=;
        b=AIv3qrIHJ3ahxnqM1M4EO3UQyDXjs+fb2ExIdotBu/royxtMs8i+WCKeMX4B1nOxWF
         E75hxBND3a6L/qeQM5PI6UIci6dkdDQ4/FzoSRTsQb8yq/zI2ULc5njud2GUnysc3Nua
         9+5THiR14jmDws8WrJk/4h1IsoPYyrd55R1kVlBY1t2H//cUAYmGmYArCwV/06BR1+te
         hcmcrdp2cAdS2xr9N9eqzRI0GsFJUU//lyxD3lRK/BP8rkY8lMAFy5EH8UHnDI6QSx+j
         ac+O5nCe+lwykI3jYiv4Kjxt19XzbL53oouZJ0vp5EX79G9KXERV+TaZoVJ22NSWodNh
         lmag==
X-Gm-Message-State: APjAAAWDQ6/CEboznr7EDGNjh430/tOft1bi77RZceBSNa7rOOt7grX4
        Tq9VjTfaYP3+Avkq80qD0SQ=
X-Google-Smtp-Source: APXvYqyF4kwtyxn/R2TAO0UJT9Swcm9heHZn887HKTNoAAXN4AoKlBo28FcTdkD2ugeHmKW3ka/P7A==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr11315756wrs.92.1578578641507;
        Thu, 09 Jan 2020 06:04:01 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:3044:9fa7:85f1:9686])
        by smtp.gmail.com with ESMTPSA id d16sm8935088wrg.27.2020.01.09.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:04:00 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: update comment in release_stripe_list
Date:   Thu,  9 Jan 2020 15:03:52 +0100
Message-Id: <20200109140352.16263-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

After commit cf170f3fa451 ("raid5: avoid release list until last
reference of the stripe"), we only set STRIPE_ON_RELEASE_LIST bit
when sh->count is 1.

And no need to mention STRIPE_ON_UNPLUG_LIST here since the related
comment is already in raid5_unplug.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7f8504525435..6a8b5112afa9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -368,8 +368,7 @@ static int release_stripe_list(struct r5conf *conf,
 		clear_bit(STRIPE_ON_RELEASE_LIST, &sh->state);
 		/*
 		 * Don't worry the bit is set here, because if the bit is set
-		 * again, the count is always > 1. This is true for
-		 * STRIPE_ON_UNPLUG_LIST bit too.
+		 * again, the count is always 1.
 		 */
 		hash = sh->hash_lock_index;
 		__release_stripe(conf, sh, &temp_inactive_list[hash]);
-- 
2.17.1

