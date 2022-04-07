Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798D4F8198
	for <lists+linux-raid@lfdr.de>; Thu,  7 Apr 2022 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiDGOag (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Apr 2022 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiDGOaf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Apr 2022 10:30:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804E194FE0
        for <linux-raid@vger.kernel.org>; Thu,  7 Apr 2022 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649341702; x=1680877702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bFSwCxUWmWNOmPGUiaBw8GfGwFDQlJ1DVzag47UhEuU=;
  b=Y549kZ/pzUdN4VLZCRaecQHujwimzZgJ1N6J6Xiq1BxtuJFWof5rYTbj
   6kCbBXZ1vVlu+YzJZgWLfnbLqdqut++fjCrtEtUHVamJa6+ZYvpnVF2GR
   k3sMJNg48iKtB/otcmG2OZarBYtTsvnlEbpHY2r8jrvusLmgz+jQOWdN+
   E3qV9GZetv5n6SjrBKEMwem/dLMJPO7jzdnDg2SBlOq/du0JtzronozUe
   jW/u+8vl7ccbrrRBGdPYRCQNAuBwyu0vgsaKXAKC6Z2NvY/YNo6dSwSdI
   vnfxqGYgvuVY46ISgmgkl/I6XTaNPT40eUiS/Y/vvh1VWGEEzx2yVYGLt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="261513371"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261513371"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 07:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659077521"
Received: from unknown (HELO gklab-109-9.igk.intel.com) ([10.102.109.9])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2022 07:28:20 -0700
From:   Lukasz Florczak <lukasz.florczak@linux.intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de, pmenzel@molgen.mpg.de
Subject: [PATCH 1/2] mdadm: Fix array size mismatch after grow
Date:   Thu,  7 Apr 2022 16:27:38 +0200
Message-Id: <20220407142739.60198-2-lukasz.florczak@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407142739.60198-1-lukasz.florczak@linux.intel.com>
References: <20220407142739.60198-1-lukasz.florczak@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

imsm_fix_size_mismatch() is invoked to fix the problem, but it couldn't
proceed due to migration check. This patch allows for intended behavior.

Signed-off-by: Lukasz Florczak <lukasz.florczak@linux.intel.com>
---
 super-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/super-intel.c b/super-intel.c
index d5fad102..102689bc 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -11757,7 +11757,7 @@ static int imsm_fix_size_mismatch(struct supertype *st, int subarray_index)
 		unsigned long long d_size = imsm_dev_size(dev);
 		int u_size;
 
-		if (calc_size == d_size || dev->vol.migr_type == MIGR_GEN_MIGR)
+		if (calc_size == d_size)
 			continue;
 
 		/* There is a difference, confirm that imsm_dev_size is
-- 
2.27.0

