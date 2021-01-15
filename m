Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B82F7C8E
	for <lists+linux-raid@lfdr.de>; Fri, 15 Jan 2021 14:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbhAON0f (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 Jan 2021 08:26:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:10827 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbhAON0e (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 15 Jan 2021 08:26:34 -0500
IronPort-SDR: H4jupvLop+cTg61lMqacI93rWemPR4wA9nEoIjTqM8HDXUmnTsjGaSycReXzsmNPHq+yqqigG7
 e8bkZK5jk9UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166216131"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166216131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 05:25:23 -0800
IronPort-SDR: LYesy/IuP1vSKmC6KccjoXXZ9P/QG7JXNWGCJ6TjH0Ih77dXA7fWtPWcMOHltvyYuBmPAlokyn
 jegnfQPLTlQw==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="425312394"
Received: from unknown (HELO localhost.igk.intel.com) ([10.237.126.111])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 05:25:22 -0800
From:   Jakub Radtke <jakub.radtke@linux.intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 1/8] Modify mdstat parsing for volumes with the bitmap
Date:   Fri, 15 Jan 2021 00:46:54 -0500
Message-Id: <20210115054701.92064-2-jakub.radtke@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115054701.92064-1-jakub.radtke@linux.intel.com>
References: <20210115054701.92064-1-jakub.radtke@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Jakub Radtke <jakub.radtke@intel.com>

Current mdstat read functionality is not working correctly
for the volumes with the write-intent bitmap.
It affects rebuild and reshape use cases.

Signed-off-by: Jakub Radtke <jakub.radtke@intel.com>
Change-Id: I5288fbfb7d6a85b2aa8452675a6e3559bf4fe934
---
 mdstat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mdstat.c b/mdstat.c
index dd96cca7..2fd792c5 100644
--- a/mdstat.c
+++ b/mdstat.c
@@ -191,6 +191,12 @@ struct mdstat_ent *mdstat_read(int hold, int start)
 			else if (strcmp(w, "inactive") == 0) {
 				ent->active = 0;
 				in_devs = 1;
+			} else if (strcmp(w, "bitmap:") == 0) {
+				/* We need to stop parsing here;
+				 * otherwise, ent->raid_disks will be
+				 * overwritten by the wrong value.
+				 */
+				break;
 			} else if (ent->active > 0 &&
 				 ent->level == NULL &&
 				 w[0] != '(' /*readonly*/) {
-- 
2.26.2

