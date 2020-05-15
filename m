Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8AD1D4964
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgEOJXY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 05:23:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:12108 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEOJXX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 15 May 2020 05:23:23 -0400
IronPort-SDR: cDxWvGnZpLHjVIkTDshgGOHCrFhflZQOKf91BPjYtVAJXPMrUfu3/o6w3lwawS0CQhmMu/Bm+u
 cjKdTX5TTC0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 02:23:23 -0700
IronPort-SDR: JH25hyCZ0qyBG7V+Ph3jC7aDR6LBkT8XMESvOMU2kIBwShHnI0e4E8Rl9MqQjbQmPHCz421yN9
 pYXNPnY6DWBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="298992356"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2020 02:23:22 -0700
From:   Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH, v2] Makefile: add EXTRAVERSION support
Date:   Fri, 15 May 2020 11:23:14 +0200
Message-Id: <20200515092314.2711-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Add optional EXTRAVERSION parameter to Makefile and allow to mark version
by user friendly label. It might be useful when creating custom
spins of mdadm, or labeling some instance in between major releases.

Signed-off-by: Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
---

V2: rename LABEL to EXTRAVERSION.

 Makefile | 3 ++-
 ReadMe.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a33319a8..0a20b758 100644
--- a/Makefile
+++ b/Makefile
@@ -105,7 +105,8 @@ VERSION = $(shell [ -d .git ] && git describe HEAD | sed 's/mdadm-//')
 VERS_DATE = $(shell [ -d .git ] && date --iso-8601 --date="`git log -n1 --format=format:%cd --date=iso --date=short`")
 DVERS = $(if $(VERSION),-DVERSION=\"$(VERSION)\",)
 DDATE = $(if $(VERS_DATE),-DVERS_DATE="\"$(VERS_DATE)\"",)
-CFLAGS += $(DVERS) $(DDATE)
+DEXTRAVERSION = $(if $(EXTRAVERSION),-DEXTRAVERSION="\" - $(EXTRAVERSION)\"",)
+CFLAGS += $(DVERS) $(DDATE) $(DEXTRAVERSION)
 
 # The glibc TLS ABI requires applications that call clone(2) to set up
 # TLS data structures, use pthreads until mdmon implements this support
diff --git a/ReadMe.c b/ReadMe.c
index eaf10423..06b8f7ee 100644
--- a/ReadMe.c
+++ b/ReadMe.c
@@ -33,7 +33,10 @@
 #ifndef VERS_DATE
 #define VERS_DATE "2018-10-01"
 #endif
-char Version[] = "mdadm - v" VERSION " - " VERS_DATE "\n";
+#ifndef EXTRAVERSION
+#define EXTRAVERSION ""
+#endif
+char Version[] = "mdadm - v" VERSION " - " VERS_DATE EXTRAVERSION "\n";
 
 /*
  * File: ReadMe.c
-- 
2.25.0

