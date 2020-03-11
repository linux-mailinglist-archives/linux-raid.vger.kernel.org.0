Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6013181B85
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgCKOkS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Mar 2020 10:40:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:39894 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgCKOkS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Mar 2020 10:40:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 07:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="236466575"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2020 07:40:16 -0700
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] imsm: Correct minimal device size.
Date:   Wed, 11 Mar 2020 15:40:13 +0100
Message-Id: <20200311144013.24424-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Check if given size of member drive is not less than 1 MibiByte.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 super-intel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/super-intel.c b/super-intel.c
index c9a1af5b..6680df29 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -7425,7 +7425,10 @@ static int validate_geometry_imsm(struct supertype *st, int level, int layout,
 							verbose);
 	}
 
-	if (size && (size < 1024)) {
+	/*
+	 * Size is given in sectors.
+	 */
+	if (size && (size < 2048)) {
 		pr_err("Given size must be greater than 1M.\n");
 		/* Depends on algorithm in Create.c :
 		 * if container was given (dev == NULL) return -1,
-- 
2.16.4

