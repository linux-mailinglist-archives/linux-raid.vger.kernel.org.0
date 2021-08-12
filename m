Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7406E3EA22A
	for <lists+linux-raid@lfdr.de>; Thu, 12 Aug 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhHLJia (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Aug 2021 05:38:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:13237 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhHLJi3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 12 Aug 2021 05:38:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="215345655"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="215345655"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 02:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="517367745"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.52])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2021 02:38:03 -0700
From:   Mateusz Kusiak <mateusz.kusiak@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH] Utils: Change sprintf to snprintf
Date:   Thu, 12 Aug 2021 13:48:48 +0200
Message-Id: <20210812114848.17341-1-mateusz.kusiak@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Using sprintf can cause segmentation fault by exceeding the size of buffer array.

Signed-off-by: Mateusz Kusiak <mateusz.kusiak@intel.com>
---
 util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util.c b/util.c
index cdf1da24..ea07277c 100644
--- a/util.c
+++ b/util.c
@@ -947,12 +947,12 @@ dev_t devnm2devid(char *devnm)
 	/* First look in /sys/block/$DEVNM/dev for %d:%d
 	 * If that fails, try parsing out a number
 	 */
-	char path[100];
+	char path[PATH_MAX];
 	char *ep;
 	int fd;
 	int mjr,mnr;
 
-	sprintf(path, "/sys/block/%s/dev", devnm);
+	snprintf(path, sizeof(path), "/sys/block/%s/dev", devnm);
 	fd = open(path, O_RDONLY);
 	if (fd >= 0) {
 		char buf[20];
-- 
2.26.2

