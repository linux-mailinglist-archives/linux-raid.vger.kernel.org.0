Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65831E75EE
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgE2Gb3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 02:31:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:18669 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2Gb3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 02:31:29 -0400
IronPort-SDR: oc6Ea7xWc+uVD+mNBgb0ZHIijXcB6wKtX9t2TmqBjgv0tIGrDgT4Hl+DL/O7glTUmi/KR/wktv
 BY+yFM24aMKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:31:28 -0700
IronPort-SDR: yRcIZPdCKpc4StfoxzLZWAXjSOoIUE5nI+97pO9ORCR9TXQx0DHx7kKVQQNc7Ps9X+ZyKyn9PX
 RCqij35WwmMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="469403469"
Received: from linux-3rn9.igk.intel.com ([10.102.102.97])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2020 23:31:27 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH,v2] Block overwriting existing links while manual assembly
Date:   Fri, 29 May 2020 08:31:36 +0200
Message-Id: <20200529063136.8177-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Manual assembly with existing link caused overwriting
this link. Add checking link and block this situation.

Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
---
 Assemble.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Assemble.c b/Assemble.c
index 6b5a7c8e..92616251 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -1482,6 +1482,10 @@ try_again:
 				name = content->name;
 			break;
 		}
+		if (mddev && map_by_name(&map, mddev) != NULL) {
+			pr_err("Cannot create device with %s because is in use\n", mddev);
+			goto out;
+		}
 		if (!auto_assem)
 			/* If the array is listed in mdadm.conf or on
 			 * command line, then we trust the name
-- 
2.16.4

