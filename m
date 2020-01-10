Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC2136B92
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgAJK7b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jan 2020 05:59:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:27621 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgAJK7b (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 Jan 2020 05:59:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 02:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,416,1571727600"; 
   d="scan'208";a="216626375"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2020 02:59:29 -0800
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] imsm: Disable --dump/--restore options
Date:   Fri, 10 Jan 2020 11:59:27 +0100
Message-Id: <20200110105927.5965-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently --dump/--restore are not working correctly.
Temporarily disable this functionally for IMSM
to avoid unexpected behaviors and side effects.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 super-intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/super-intel.c b/super-intel.c
index 5c1f759f..b2a4528d 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -2130,6 +2130,13 @@ static void export_examine_super_imsm(struct supertype *st)
 
 static int copy_metadata_imsm(struct supertype *st, int from, int to)
 {
+	/*
+	 * Disable this functionality for IMSM,
+	 * since it is not working correctly.
+	 */
+	pr_err("--dump/--restore is not supported for IMSM metadata format.\n");
+	return 1;
+
 	/* The second last sector of the device contains
 	 * the "struct imsm_super" metadata.
 	 * This contains mpb_size which is the size in bytes of the
-- 
2.16.4

