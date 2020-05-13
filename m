Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D2B1D1065
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 13:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgEMLAq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 07:00:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:37779 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMLAp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 07:00:45 -0400
IronPort-SDR: Q+Qo+cUjYtQFZwD0iDP03Ee+t0ZdF7O08yxTQrRaWggcemwacO/s8Ych1fs+xZnV0tQKllsI70
 +dD0cAK9vpLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 04:00:45 -0700
IronPort-SDR: ooe/2VvdsclV196QIdfLcGXzxDeG92Ji0tCLFCxUnjU7cg4Wj6j/s5eUPUG0nHCkO6p3f/6IXx
 aAEGiU3l2N3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="297630139"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2020 04:00:44 -0700
From:   Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] Makefile: add LABEL support
Date:   Wed, 13 May 2020 13:00:36 +0200
Message-Id: <20200513110036.19724-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Add optional LABEL parameter to Makefile and allow to mark version
by user friendly label. It might be useful when creating custom
spins of mdadm, or labeling some instance in between major releases.

Signed-off-by: Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
---
 Makefile | 3 ++-
 ReadMe.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a33319a8..9c129c54 100644
--- a/Makefile
+++ b/Makefile
@@ -105,7 +105,8 @@ VERSION = $(shell [ -d .git ] && git describe HEAD | sed 's/mdadm-//')
 VERS_DATE = $(shell [ -d .git ] && date --iso-8601 --date="`git log -n1 --format=format:%cd --date=iso --date=short`")
 DVERS = $(if $(VERSION),-DVERSION=\"$(VERSION)\",)
 DDATE = $(if $(VERS_DATE),-DVERS_DATE="\"$(VERS_DATE)\"",)
-CFLAGS += $(DVERS) $(DDATE)
+DLABEL = $(if $(LABEL),-DLABEL="\" - $(LABEL)\"",)
+CFLAGS += $(DVERS) $(DDATE) $(DLABEL)
 
 # The glibc TLS ABI requires applications that call clone(2) to set up
 # TLS data structures, use pthreads until mdmon implements this support
diff --git a/ReadMe.c b/ReadMe.c
index eaf10423..883136df 100644
--- a/ReadMe.c
+++ b/ReadMe.c
@@ -33,7 +33,10 @@
 #ifndef VERS_DATE
 #define VERS_DATE "2018-10-01"
 #endif
-char Version[] = "mdadm - v" VERSION " - " VERS_DATE "\n";
+#ifndef LABEL
+#define LABEL ""
+#endif
+char Version[] = "mdadm - v" VERSION " - " VERS_DATE LABEL "\n";
 
 /*
  * File: ReadMe.c
-- 
2.25.0

