Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE3F454A
	for <lists+linux-raid@lfdr.de>; Fri,  8 Nov 2019 12:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfKHLDl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Nov 2019 06:03:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:27248 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHLDl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 8 Nov 2019 06:03:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 03:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="403042449"
Received: from linux-qgmk.igk.intel.com ([10.102.102.210])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2019 03:03:39 -0800
From:   Krzysztof Smolinski <krzysztof.smolinski@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: [PATCH] imsm: allow to specify second volume size
Date:   Fri,  8 Nov 2019 11:59:11 +0100
Message-Id: <20191108105911.13963-1-krzysztof.smolinski@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Removed checks which limited second volume size only to max value (the
largest size that fits on all current drives). It is now permitted
to create second volume with size lower then maximum possible.

Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
---
 super-intel.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/super-intel.c b/super-intel.c
index 2ba045aa..746f6b6a 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -7298,11 +7298,8 @@ static int validate_geometry_imsm_volume(struct supertype *st, int level,
 
 	maxsize = merge_extents(super, i);
 
-	if (!check_env("IMSM_NO_PLATFORM") &&
-	    mpb->num_raid_devs > 0 && size && size != maxsize) {
-		pr_err("attempting to create a second volume with size less then remaining space. Aborting...\n");
-		return 0;
-	}
+	if (mpb->num_raid_devs > 0 && size && size != maxsize)
+		pr_err("attempting to create a second volume with size less then remaining space.\n");
 
 	if (maxsize < size || maxsize == 0) {
 		if (verbose) {
@@ -7393,11 +7390,8 @@ static int imsm_get_free_size(struct supertype *st, int raiddisks,
 		}
 		maxsize = size;
 	}
-	if (!check_env("IMSM_NO_PLATFORM") &&
-	    mpb->num_raid_devs > 0 && size && size != maxsize) {
-		pr_err("attempting to create a second volume with size less then remaining space. Aborting...\n");
-		return 0;
-	}
+	if (mpb->num_raid_devs > 0 && size && size != maxsize)
+		pr_err("attempting to create a second volume with size less then remaining space.\n");
 	cnt = 0;
 	for (dl = super->disks; dl; dl = dl->next)
 		if (dl->e)
-- 
2.16.4

