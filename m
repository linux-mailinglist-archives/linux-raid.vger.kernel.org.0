Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52398554416
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jun 2022 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353245AbiFVHjA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jun 2022 03:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353725AbiFVHi6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jun 2022 03:38:58 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24C37A1F
        for <linux-raid@vger.kernel.org>; Wed, 22 Jun 2022 00:38:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655883532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ms8uXQq2ucOha144S/uO33YSzWIdauQr2gJwT7AwRKM=;
        b=ggdiyp/cIyX7MqaxxFmrVNa++XYa76Rv3G97XVMagQb4tkhRPD5xBjScAMUNyYNN2TNFIu
        jHQxtQWn3laeDWi/84qnQ/BsuVZ7HZAA+i5GWHRtyu3/3NMcrewsaPjFvO9cY429AeTiuI
        XeFfg8F8k3pz+fGEDdYisl01bPqwVQc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] md: add patchwork URL
Date:   Wed, 22 Jun 2022 15:38:38 +0800
Message-Id: <20220622073838.8295-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Finally, md has it's own patch tracking system, let's reflect it here.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..450159ded532 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18492,6 +18492,7 @@ SOFTWARE RAID (Multiple Disks) SUPPORT
 M:	Song Liu <song@kernel.org>
 L:	linux-raid@vger.kernel.org
 S:	Supported
+Q:	http://patchwork.kernel.org/project/linux-raid/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git
 F:	drivers/md/Kconfig
 F:	drivers/md/Makefile
-- 
2.31.1

