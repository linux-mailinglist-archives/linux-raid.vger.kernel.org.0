Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B535B59969C
	for <lists+linux-raid@lfdr.de>; Fri, 19 Aug 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbiHSIBr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Aug 2022 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347357AbiHSIBi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 19 Aug 2022 04:01:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD84E42F1
        for <linux-raid@vger.kernel.org>; Fri, 19 Aug 2022 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660896097; x=1692432097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8q/EG3e+YZD+2ViwIvgzZnFSxL2L20MLea6+q65R8w=;
  b=LTtRdbOUVNc58SUGVkORtN8iFg3icVXzX6a5RSvpD5p8UJ2MsqjkiGRN
   ujj0myxctS0PoOK24F7WTiW0E2kqpmsAO9OA7jaeuJYjfnO7cDx1vqfsV
   P5hNIEZvcSbVUtyJ2x62IkqAFjeU/owNjkxrr8Syd+ZygzPRCYFsbNlcL
   2vjUD/6clm3SpoDQ7J/qSUBdBV1ux2Y+nRFSlMdeA3Fb/krr2v7MLWP8o
   HY53lcG9uUjVeEjy1krnb5H8T/FIMqB3FLOxMqQN1A0ksXIHVfpczIsgW
   UOxv1AHEwXJHwCOA7HcfsWmUKIrPOU6nvW6r4Zx3YuhdYd/l2XEpzlDF8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="292958961"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="292958961"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="668478540"
Received: from unknown (HELO unbrick.amr.corp.intel.com) ([10.102.92.203])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2022 00:55:34 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH v3 1/2] Assemble: check if device is container before scheduling force-clean update
Date:   Fri, 19 Aug 2022 02:55:46 +0200
Message-Id: <20220819005547.17343-2-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220819005547.17343-1-kinga.tanska@intel.com>
References: <20220819005547.17343-1-kinga.tanska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Up to now using assemble with force flag making each array as clean.
Force-clean should not be done for the container. This commit add
check if device is different than container before cleaning.

Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
---
 Assemble.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Assemble.c b/Assemble.c
index 704b8293..f31372db 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -1813,10 +1813,9 @@ try_again:
 		}
 #endif
 	}
-	if (c->force && !clean &&
+	if (c->force && !clean && content->array.level != LEVEL_CONTAINER &&
 	    !enough(content->array.level, content->array.raid_disks,
-		    content->array.layout, clean,
-		    avail)) {
+		    content->array.layout, clean, avail)) {
 		change += st->ss->update_super(st, content, "force-array",
 					       devices[chosen_drive].devname, c->verbose,
 					       0, NULL);
-- 
2.26.2

