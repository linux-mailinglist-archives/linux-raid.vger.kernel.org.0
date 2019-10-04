Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E713BCB7E4
	for <lists+linux-raid@lfdr.de>; Fri,  4 Oct 2019 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfJDKIM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 4 Oct 2019 06:08:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:37029 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbfJDKIL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 4 Oct 2019 06:08:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 03:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="393494667"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2019 03:08:10 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH v2] imsm: save current_vol number
Date:   Fri,  4 Oct 2019 12:07:28 +0200
Message-Id: <20191004100728.22471-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The imsm container_content routine will set curr_volume index in super
for getting volume information. This flag has never been restored to
original value, later other function may rely on it.

Restore this flag to original value.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
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

