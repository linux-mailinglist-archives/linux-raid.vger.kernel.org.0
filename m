Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3F3A8325
	for <lists+linux-raid@lfdr.de>; Tue, 15 Jun 2021 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFOOrr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Jun 2021 10:47:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:10246 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhFOOrr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Jun 2021 10:47:47 -0400
IronPort-SDR: iuCDYO/g4Hdq8Pb3vawDNDrkHOVBScMTTi9D00OjbWG4vau87WLIspnEkdwUnk3sJ5iVLrWgaW
 OyK5A3+WHMNA==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="267152088"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="267152088"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:45:42 -0700
IronPort-SDR: t4JyC0nbXUOrA7LZ6ruDRURS4QC35bK5HbpPM2OiO08JgAQxXbJG4b9WpTOoFu7Fdxnzg72yws
 zOV1uZPLmIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="487799536"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2021 07:45:41 -0700
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH] Use dev_open in validate geometry container
Date:   Tue, 15 Jun 2021 16:45:39 +0200
Message-Id: <20210615144539.16504-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Fix regression caused by the patch 1f5d54a06
("Manage: Call validate_geometry when adding drive to external container")
- mdmonitor passes to Manage() routine dev name as min:mjr.
The open() used in validate_geometry_container()
in both ddf and imsm requires path, replace open calls by dev_open,
which allows to use dev path and min:mjr.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 super-ddf.c   | 2 +-
 super-intel.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/super-ddf.c b/super-ddf.c
index 80a40f84..dc8e512f 100644
--- a/super-ddf.c
+++ b/super-ddf.c
@@ -3463,7 +3463,7 @@ validate_geometry_ddf_container(struct supertype *st,
 	if (!dev)
 		return 1;
 
-	fd = open(dev, O_RDONLY|O_EXCL, 0);
+	fd = dev_open(dev, O_RDONLY|O_EXCL);
 	if (fd < 0) {
 		if (verbose)
 			pr_err("ddf: Cannot open %s: %s\n",
diff --git a/super-intel.c b/super-intel.c
index fe45d933..5356ca51 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -6668,7 +6668,7 @@ static int validate_geometry_imsm_container(struct supertype *st, int level,
 	if (!dev)
 		return 1;
 
-	fd = open(dev, O_RDONLY|O_EXCL, 0);
+	fd = dev_open(dev, O_RDONLY|O_EXCL);
 	if (fd < 0) {
 		if (verbose > 0)
 			pr_err("imsm: Cannot open %s: %s\n",
-- 
2.16.4

