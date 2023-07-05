Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C87486FE
	for <lists+linux-raid@lfdr.de>; Wed,  5 Jul 2023 16:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGEO44 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 5 Jul 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGEO4z (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 5 Jul 2023 10:56:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE32171D
        for <linux-raid@vger.kernel.org>; Wed,  5 Jul 2023 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688569013; x=1720105013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sqd3ZUN1KfIFcIA0xOnsdsU4ZELdWd3zciAmvk+FloA=;
  b=bm5kmXfzKroGn5buuqihCUQgChBFI8PidF90zlF/BZwG5nr85bYESq9n
   2yfKGOx24N3VuKaOSdLaUvswD8qZ3OOLtjDpeSMCwlQFxvQNirHE7Z+nW
   ZsFOp1hKahkftF/mZiwVlAhlqqV3+8QLoQOw8MtvaQTWFqkXHgPnDk0eL
   t5HMbJS7080O3M9wIP6WoiuCbzrjXK513R87rEuGjVf+tIxgAs0dzwpGT
   culk25G7MuHACpeKy3HWKew7oe/DYYJWBQ6baWfE7tbV7Lug49DfFcWiT
   wFbvmvH7+EfR1Pm3yRe5yELbTbStPQrXxbR0PVcnr8YymA0JLFGplGgvs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343690041"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="343690041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 07:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="832579558"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="832579558"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.104.85])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2023 07:56:33 -0700
From:   Mateusz Grzonka <mateusz.grzonka@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH] imsm: Fix possible segfault in check_no_platform()
Date:   Wed,  5 Jul 2023 16:34:56 +0200
Message-Id: <20230705143456.20462-1-mateusz.grzonka@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

conf_line() may return NULL, which is not handled and might cause
segfault.

Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
---
 super-intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/super-intel.c b/super-intel.c
index ae0f4a8c..4ef33d31 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -650,6 +650,11 @@ static int check_no_platform(void)
 		char *l = conf_line(fp);
 		char *w = l;
 
+		if (l == NULL) {
+			fclose(fp);
+			return 0;
+		}
+
 		do {
 			if (strcmp(w, search) == 0)
 				no_platform = 1;
-- 
2.26.2

