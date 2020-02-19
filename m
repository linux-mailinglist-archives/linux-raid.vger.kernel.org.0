Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637781640DF
	for <lists+linux-raid@lfdr.de>; Wed, 19 Feb 2020 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSJy5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Feb 2020 04:54:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:37148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSJy5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 19 Feb 2020 04:54:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 01:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="235844149"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2020 01:54:55 -0800
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] imsm: pass subarray id to kill_subarray function
Date:   Wed, 19 Feb 2020 10:54:49 +0100
Message-Id: <20200219095449.29443-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

After patch b6180160f ("imsm: save current_vol number")
current_vol for imsm is not set and kill_subarray()
cannot determine which volume has to be deleted.
Volume has to be passed as "subarray_id".
The parameter affects only IMSM metadata.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 Kill.c        | 2 +-
 mdadm.h       | 3 ++-
 super-ddf.c   | 2 +-
 super-intel.c | 9 ++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Kill.c b/Kill.c
index d4767e29..bfd0efdc 100644
--- a/Kill.c
+++ b/Kill.c
@@ -119,7 +119,7 @@ int Kill_subarray(char *dev, char *subarray, int verbose)
 		st->update_tail = &st->updates;
 
 	/* ok we've found our victim, drop the axe */
-	rv = st->ss->kill_subarray(st);
+	rv = st->ss->kill_subarray(st, subarray);
 	if (rv) {
 		if (verbose >= 0)
 			pr_err("Failed to delete subarray-%s from %s\n",
diff --git a/mdadm.h b/mdadm.h
index 9e987789..d94569f9 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1038,7 +1038,8 @@ extern struct superswitch {
 	/* query the supertype for default geometry */
 	void (*default_geometry)(struct supertype *st, int *level, int *layout, int *chunk); /* optional */
 	/* Permit subarray's to be deleted from inactive containers */
-	int (*kill_subarray)(struct supertype *st); /* optional */
+	int (*kill_subarray)(struct supertype *st,
+			     char *subarray_id); /* optional */
 	/* Permit subarray's to be modified */
 	int (*update_subarray)(struct supertype *st, char *subarray,
 			       char *update, struct mddev_ident *ident); /* optional */
diff --git a/super-ddf.c b/super-ddf.c
index 78020634..7cd5702d 100644
--- a/super-ddf.c
+++ b/super-ddf.c
@@ -4446,7 +4446,7 @@ static int _kill_subarray_ddf(struct ddf_super *ddf, const char *guid)
 	return 0;
 }
 
-static int kill_subarray_ddf(struct supertype *st)
+static int kill_subarray_ddf(struct supertype *st, char *subarray_id)
 {
 	struct ddf_super *ddf = st->sb;
 	/*
diff --git a/super-intel.c b/super-intel.c
index 5c1f759f..9f6fa90a 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -7600,18 +7600,17 @@ static void default_geometry_imsm(struct supertype *st, int *level, int *layout,
 
 static void handle_missing(struct intel_super *super, struct imsm_dev *dev);
 
-static int kill_subarray_imsm(struct supertype *st)
+static int kill_subarray_imsm(struct supertype *st, char *subarray_id)
 {
-	/* remove the subarray currently referenced by ->current_vol */
+	/* remove the subarray currently referenced by subarray_id */
 	__u8 i;
 	struct intel_dev **dp;
 	struct intel_super *super = st->sb;
-	__u8 current_vol = super->current_vol;
+	__u8 current_vol = strtoul(subarray_id, NULL, 10);
 	struct imsm_super *mpb = super->anchor;
 
-	if (super->current_vol < 0)
+	if (mpb->num_raid_devs == 0)
 		return 2;
-	super->current_vol = -1; /* invalidate subarray cursor */
 
 	/* block deletions that would change the uuid of active subarrays
 	 *
-- 
2.16.4

