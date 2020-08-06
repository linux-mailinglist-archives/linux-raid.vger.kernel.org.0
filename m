Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8D23DCC6
	for <lists+linux-raid@lfdr.de>; Thu,  6 Aug 2020 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgHFQz6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Aug 2020 12:55:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:32727 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgHFQz5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 Aug 2020 12:55:57 -0400
IronPort-SDR: BcyKSHQ7/i8eT/M6fjJpd6qSf8lVdIN9tuDxgxBxqS+cjilXX5v3uGJo7iHvIpvoIY7/mratyM
 HzkFvXqHj/lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="217117418"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="217117418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 04:57:56 -0700
IronPort-SDR: aMQ9fJe7ahsrYodBksGRjsub1e9SJjoVa8IliZ+1Rbz7b2cEk79dQtw/dvB37JPWhKp8DC0Ovl
 YvjcrZPbWH1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="367560112"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2020 04:57:55 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] manual: update --examine-badblocks
Date:   Thu,  6 Aug 2020 13:57:50 +0200
Message-Id: <20200806115750.19647-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

IMSM also supports it.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
---
 mdadm.8.in | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 1474602..ab832e8 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -1695,9 +1695,11 @@ does not report the bitmap for that array.
 .TP
 .B \-\-examine\-badblocks
 List the bad-blocks recorded for the device, if a bad-blocks list has
-been configured.  Currently only
+been configured. Currently only
 .B 1.x
-metadata supports bad-blocks lists.
+and
+.B IMSM
+metadata support bad-blocks lists.
 
 .TP
 .BI \-\-dump= directory
-- 
2.25.0

