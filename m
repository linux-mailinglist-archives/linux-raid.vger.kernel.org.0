Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED35277BB3
	for <lists+linux-raid@lfdr.de>; Fri, 25 Sep 2020 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIXWmb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Sep 2020 18:42:31 -0400
Received: from smtp1.wiktel.com ([69.89.207.151]:33536 "EHLO smtp1.wiktel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIXWmb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 24 Sep 2020 18:42:31 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 18:42:30 EDT
Received: from watermelon.coderich.net (thief-pool-117-74.mncable.net [24.225.117.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp1.wiktel.com (Postfix) with ESMTPSA id 4By8zg30xKzxhv;
        Thu, 24 Sep 2020 17:36:47 -0500 (CDT)
From:   rlaager@wiktel.com
To:     linux-raid@vger.kernel.org
Cc:     rlaager@wiktel.com
Subject: [PATCH 1/2] mdcheck: Prefix pause message with mdcheck
Date:   Thu, 24 Sep 2020 17:36:38 -0500
Message-Id: <20200924223639.23087-1-rlaager@wiktel.com>
X-Mailer: git-send-email 2.17.1
X-bounce-key: wiktel.com-1;rlaager@wiktel.com;1600987007;uV5pzyiOhEAsRpsMZJAb2l7Hd88;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=wiktel.com; h=from:to:cc
        :subject:date:message-id; s=wiktel1; bh=nEla7JMixCG4zy6aBWTRoJI/
        SSlRWRu6xZL4jXR1XcI=; b=jD5veVEa2MW04JKH5WrlzjpIqJ/b0plUBELbaGbH
        LaxBM3CcWU70JQS8Ip6TGdbNPDbJBsNuxDt36c8rc2bf2pYPtJVJAhOgQbEAQpE+
        lBDKuZdZa2+PWNbfJWD03lhaNWnLgqpuictm7CXTi7ofbw3TsovUVFQOe/iunQrB
        z8Fko1qwLSjnO/tiSbjgxnPDaeQ8Aw6//hL5mrutHqrr+gcPYkP2yTfAPM7K14ub
        XkpHWRcebIrah/GjFI9DY/aO2H22N4fJTM48r/eUiX7teEOglT1PgY3AIwkAZ4Xz
        COyr47Ti+cehxX/6w0ni38AAJLV61QyOsec7NHbItTie2w==
X-Spam-Level: 
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Richard Laager <rlaager@wiktel.com>

This makes it consistent with the other messages.

Signed-off-by: Richard Laager <rlaager@wiktel.com>
---
 misc/mdcheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/mdcheck b/misc/mdcheck
index 700c3e2..299cf10 100644
--- a/misc/mdcheck
+++ b/misc/mdcheck
@@ -162,5 +162,5 @@ do
 	fi
 	echo idle > $sys/md/sync_action
 	cat $sys/md/sync_min > $fl
-	logger -p daemon.info pause checking $dev at `cat $fl`
+	logger -p daemon.info mdcheck pause checking $dev at `cat $fl`
 done
-- 
2.17.1

