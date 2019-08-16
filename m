Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65C58FEB5
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfHPJIs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 05:08:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:63753 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfHPJIs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 16 Aug 2019 05:08:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 02:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="177130031"
Received: from linux-qgmk.igk.intel.com ([10.102.102.210])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2019 02:08:46 -0700
From:   Krzysztof Smolinski <krzysztof.smolinski@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: [PATCH,v2] mdadm: check value returned by snprintf against errors
Date:   Fri, 16 Aug 2019 11:06:17 +0200
Message-Id: <20190816090617.12679-1-krzysztof.smolinski@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

GCC 8 checks possible truncation during snprintf more strictly
than GCC 7 which result in compilation errors. To fix this
problem checking result of snprintf against errors has been added.

Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
---
 sysfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index c3137818..2995713d 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -1023,12 +1023,20 @@ int sysfs_rules_apply_check(const struct mdinfo *sra,
 	char dname[MAX_SYSFS_PATH_LEN];
 	char resolved_path[PATH_MAX];
 	char resolved_dir[PATH_MAX];
+	int result;
 
 	if (sra == NULL || ent == NULL)
 		return -1;
 
-	snprintf(dname, MAX_SYSFS_PATH_LEN, "/sys/block/%s/md/", sra->sys_name);
-	snprintf(fname, MAX_SYSFS_PATH_LEN, "%s/%s", dname, ent->name);
+	result = snprintf(dname, MAX_SYSFS_PATH_LEN,
+			  "/sys/block/%s/md/", sra->sys_name);
+	if (result < 0 || result >= MAX_SYSFS_PATH_LEN)
+		return -1;
+
+	result = snprintf(fname, MAX_SYSFS_PATH_LEN,
+			  "%s/%s", dname, ent->name);
+	if (result < 0 || result >= MAX_SYSFS_PATH_LEN)
+		return -1;
 
 	if (realpath(fname, resolved_path) == NULL ||
 	    realpath(dname, resolved_dir) == NULL)
-- 
2.16.4

