Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3E3FB28F
	for <lists+linux-raid@lfdr.de>; Mon, 30 Aug 2021 10:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhH3IhN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Aug 2021 04:37:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:37910 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234514AbhH3IhM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Aug 2021 04:37:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="197797939"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="197797939"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 01:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="687101833"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.57])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2021 01:36:11 -0700
From:   Mateusz Grzonka <mateusz.grzonka@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH] Fix error message when creating raid 4, 5 and 10
Date:   Mon, 30 Aug 2021 10:25:17 +0200
Message-Id: <20210830082517.9109-1-mateusz.grzonka@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Change inappropriate error message "at least 2 raid-devices needed for
level 4 or 5" to only mention relevant raid level.

Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
---
 Create.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Create.c b/Create.c
index f5d57f8c..2c0b17e9 100644
--- a/Create.c
+++ b/Create.c
@@ -153,7 +153,7 @@ int Create(struct supertype *st, char *mddev,
 		return 1;
 	}
 	if (s->raiddisks < 2 && s->level >= 4) {
-		pr_err("at least 2 raid-devices needed for level 4 or 5\n");
+		pr_err("at least 2 raid-devices needed for level %d\n", s->level);
 		return 1;
 	}
 	if (s->level <= 0 && s->sparedisks) {
-- 
2.26.2

