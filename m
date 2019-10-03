Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC028C993A
	for <lists+linux-raid@lfdr.de>; Thu,  3 Oct 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfJCHwc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Oct 2019 03:52:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:47799 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJCHwc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 3 Oct 2019 03:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 00:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="275629540"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2019 00:52:31 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] imsm: save current_vol number
Date:   Thu,  3 Oct 2019 09:52:25 +0200
Message-Id: <20191003075225.22840-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The imsm container_content routine will set curr_volume index in super
for getting volume information. This flag has never been restored to
original value, later other function may rely on it.

Restore this flag to original value.
---
 super-intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/super-intel.c b/super-intel.c
index d7e8a65f..39264bef 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -7826,6 +7826,7 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
 	int sb_errors = 0;
 	struct dl *d;
 	int spare_disks = 0;
+	int current_vol = super->current_vol;
 
 	/* do not assemble arrays when not all attributes are supported */
 	if (imsm_check_attributes(mpb->attributes) == 0) {
@@ -7993,6 +7994,7 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
 		rest = this;
 	}
 
+	super->current_vol = current_vol;
 	return rest;
 }
 
-- 
2.16.4

