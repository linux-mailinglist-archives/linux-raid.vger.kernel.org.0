Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F425AE8F1
	for <lists+linux-raid@lfdr.de>; Tue,  6 Sep 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiIFM7x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 6 Sep 2022 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiIFM7s (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 6 Sep 2022 08:59:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077CDF35
        for <linux-raid@vger.kernel.org>; Tue,  6 Sep 2022 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662469187; x=1694005187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCd6RrDnu6v6qq6qKsYGLYToZtNQ5omoqSiVRaxPSnI=;
  b=PRoTof2AN5WRkiNxQLZud5qNPrgM3Qnl/GCHxKMdExycdLJuQxzOk0dc
   NkTq+P5SC/cyqyzC3ypYHSUyIGwqSMAnvhx4NQoeH8m9vCkkKZj94PXxK
   YPxt7PELpJqV0EeeChkYkC7zH++3y3rwC7+kUw9CEcCxnCFXtR39NU6sf
   keiSccIox3D0gJGDl/g3CwSDpFDYttF4OiABeMneCDMuamhaeYVa/oQP+
   OsIYfqjnvijd5w/jF/7e4NHosEaC4Z3zIsinO5kk2xB9nPjNxUwg273Cg
   QUZ4SjPtLhqNVfhMxVEP7XEOitil7TWvyJe8BJWbPlSEUn1B7UP2H65dy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296585145"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296585145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:59:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675679197"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:59:46 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     jes@trained-monkey.org, colyli@suse.de
Cc:     linux-raid@vger.kernel.org, felix.lechner@lease-up.com
Subject: [PATCH 2/2] ReadMe: fix command-line help
Date:   Tue,  6 Sep 2022 14:59:32 +0200
Message-Id: <20220906125932.15214-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220906125932.15214-1-mariusz.tkaczyk@linux.intel.com>
References: <20220906125932.15214-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Make command-line help consistent with manual page.
Copied from Debian.

Cc: Felix Lechner <felix.lechner@lease-up.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 ReadMe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ReadMe.c b/ReadMe.c
index 7f94847e..50a5e36d 100644
--- a/ReadMe.c
+++ b/ReadMe.c
@@ -477,7 +477,7 @@ char Help_assemble[] =
 ;
 
 char Help_manage[] =
-"Usage: mdadm arraydevice options component devices...\n"
+"Usage: mdadm [mode] arraydevice [options] <component devices...>\n"
 "\n"
 "This usage is for managing the component devices within an array.\n"
 "The --manage option is not needed and is assumed if the first argument\n"
-- 
2.26.2

