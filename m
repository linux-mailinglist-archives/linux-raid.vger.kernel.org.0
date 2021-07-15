Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6F3C9CCD
	for <lists+linux-raid@lfdr.de>; Thu, 15 Jul 2021 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhGOKi3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 15 Jul 2021 06:38:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:12824 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238409AbhGOKi3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 15 Jul 2021 06:38:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="207499041"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="207499041"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 03:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="430786166"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.57])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2021 03:35:32 -0700
From:   Mateusz Grzonka <mateusz.grzonka@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH] Add error handling for chunk size in RAID1
Date:   Thu, 15 Jul 2021 12:25:23 +0200
Message-Id: <20210715102523.28298-1-mateusz.grzonka@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Print error if chunk size is set as it is not supported.

Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
---
 Create.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Create.c b/Create.c
index 18b5e646..f5d57f8c 100644
--- a/Create.c
+++ b/Create.c
@@ -254,9 +254,8 @@ int Create(struct supertype *st, char *mddev,
 	case LEVEL_MULTIPATH:
 	case LEVEL_CONTAINER:
 		if (s->chunk) {
-			s->chunk = 0;
-			if (c->verbose > 0)
-				pr_err("chunk size ignored for this level\n");
+			pr_err("specifying chunk size is forbidden for this level\n");
+			return 1;
 		}
 		break;
 	default:
-- 
2.26.2

