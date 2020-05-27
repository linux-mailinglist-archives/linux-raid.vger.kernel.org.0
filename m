Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CBB1E3A0E
	for <lists+linux-raid@lfdr.de>; Wed, 27 May 2020 09:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgE0HOo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 May 2020 03:14:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:58456 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgE0HOo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 27 May 2020 03:14:44 -0400
IronPort-SDR: v6JO80L8xwTZ3fUZXQmcUzuaOGQYwUvPANzAUZaJXiFaS1gzGWZ4kRl+mQ96CWWA6KTYA+CjXu
 Kp5dNVqC0aaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 00:14:44 -0700
IronPort-SDR: 1Adx25Kg62iNDw7RcwtJNO5DBJALrQ7+Rl++9561AyHD9jcMeRFGvMVCF6P9Xoxlk0MJSJCcEf
 U7ngRhamPThw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="284709613"
Received: from linux-3rn9.igk.intel.com ([10.102.102.97])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2020 00:14:43 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] Block overwriting existing links while manual assembly
Date:   Wed, 27 May 2020 09:14:43 +0200
Message-Id: <20200527071443.20998-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Manual assembly with existing link caused overwriting
this link. Add checking link and block this situation.

Change-Id: I29ef58636e8fd8583bcaef1b28b6cf2edec385ef
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

