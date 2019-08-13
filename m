Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7658B4B2
	for <lists+linux-raid@lfdr.de>; Tue, 13 Aug 2019 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfHMJ4M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Aug 2019 05:56:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:59089 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfHMJ4M (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 13 Aug 2019 05:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 02:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="205032365"
Received: from unknown (HELO linux-spw6.igk.intel.com) ([10.102.102.170])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2019 02:56:10 -0700
From:   Mariusz Dabrowski <mariusz.dabrowski@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: [PATCH] mdadm: fixed mdadm compilation on gcc8
Date:   Tue, 13 Aug 2019 11:55:52 +0200
Message-Id: <20190813095552.32445-1-mariusz.dabrowski@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Krzysztof Smolinski <krzysztof.smolinski@intel.com>

GCC8 make more strict checks of possible truncation during snprintf
calls than GCC7 which cause compilation errors. This patch
fixes compilation of mdadm on GCC8 compiler.

Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
---
 sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index c3137818..2bf9793d 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -1019,7 +1019,7 @@ int sysfs_rules_apply_check(const struct mdinfo *sra,
 	/* Check whether parameter is regular file,
 	 * exists and is under specified directory.
 	 */
-	char fname[MAX_SYSFS_PATH_LEN];
+	char fname[PATH_MAX];
 	char dname[MAX_SYSFS_PATH_LEN];
 	char resolved_path[PATH_MAX];
 	char resolved_dir[PATH_MAX];
@@ -1028,7 +1028,7 @@ int sysfs_rules_apply_check(const struct mdinfo *sra,
 		return -1;
 
 	snprintf(dname, MAX_SYSFS_PATH_LEN, "/sys/block/%s/md/", sra->sys_name);
-	snprintf(fname, MAX_SYSFS_PATH_LEN, "%s/%s", dname, ent->name);
+	snprintf(fname, PATH_MAX, "%s/%s", dname, ent->name);
 
 	if (realpath(fname, resolved_path) == NULL ||
 	    realpath(dname, resolved_dir) == NULL)
-- 
2.16.4

