Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA932E791
	for <lists+linux-raid@lfdr.de>; Fri,  5 Mar 2021 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCEMC0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Mar 2021 07:02:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:35709 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhCEMBy (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 5 Mar 2021 07:01:54 -0500
IronPort-SDR: jYxlOm6uy5RohTKIpqSyrLXXV95KKpsCO81zfXXrxW+yHSLCvH5rp7xPZrtkZXx9H8D1IZIUi5
 IBLj6Zpk6f3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="185230230"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="185230230"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 04:01:53 -0800
IronPort-SDR: rVyS9a4+82vDN/9hX/k0l+KSKaotiZmUvCDmuFX+LWC07gehTZcvbUce66Zx5o6TTwPsXtVzKY
 Ej028Vrvvoog==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="401656594"
Received: from unknown (HELO localhost.igk.intel.com) ([10.237.126.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 04:01:51 -0800
From:   Jakub Radtke <jakub.radtke@linux.intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 2/8] Enable bitmap support for external metadata
Date:   Thu, 24 Sep 2020 20:02:58 -0400
Message-Id: <20200925000304.169728-3-jakub.radtke@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925000304.169728-1-jakub.radtke@linux.intel.com>
References: <20200925000304.169728-1-jakub.radtke@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Jakub Radtke <jakub.radtke@intel.com>

The patch enables the implementation of a write-intent bitmap for external
metadata.
Configuration of the internal bitmaps for non-native metadata requires the
extension in superswitch to perform an additional sysfs setup before the
array is activated.

Change-Id: I77be689b9f4f815dd00bb14ef52267686b273fb5
Signed-off-by: Jakub Radtke <jakub.radtke@intel.com>
---
 Assemble.c |  6 ++++++
 Create.c   | 10 ++++++++++
 mdadm.h    |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/Assemble.c b/Assemble.c
index ed0ddfb1..479ff5ec 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -2094,6 +2094,12 @@ int assemble_container_content(struct supertype *st, int mdfd,
 		}
 	}
 
+	/* Before activating the array, perform extra steps required to configure the internal
+	 * write-intent bitmap.
+	 */
+	if (content->consistency_policy == CONSISTENCY_POLICY_BITMAP &&
+	    st->ss->set_bitmap)
+		st->ss->set_bitmap(st, content);
 
 	if (start_reshape) {
 		int spare = content->array.raid_disks + expansion;
diff --git a/Create.c b/Create.c
index 51f8826b..751f18c1 100644
--- a/Create.c
+++ b/Create.c
@@ -989,6 +989,16 @@ int Create(struct supertype *st, char *mddev,
 				st->ss->free_super(st);
 				goto abort_locked;
 			}
+			/* Before activating the array, perform extra steps required
+			 * to configure the internal write-intent bitmap.
+			 */
+			if (info_new.consistency_policy ==
+				    CONSISTENCY_POLICY_BITMAP &&
+			    st->ss->set_bitmap &&
+			    st->ss->set_bitmap(st, &info)) {
+				st->ss->free_super(st);
+				goto abort_locked;
+			}
 
 			/* update parent container uuid */
 			if (me) {
diff --git a/mdadm.h b/mdadm.h
index 1ee6c92e..0cf94239 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1006,6 +1006,9 @@ extern struct superswitch {
 	int (*add_internal_bitmap)(struct supertype *st, int *chunkp,
 				   int delay, int write_behind,
 				   unsigned long long size, int may_change, int major);
+	/* Perform additional setup required to activate a bitmap.
+	 */
+	int (*set_bitmap)(struct supertype *st, struct mdinfo *info);
 	/* Seek 'fd' to start of write-intent-bitmap.  Must be an
 	 * md-native format bitmap
 	 */
-- 
2.26.2

