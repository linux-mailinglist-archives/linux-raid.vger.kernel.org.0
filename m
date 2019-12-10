Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB011860D
	for <lists+linux-raid@lfdr.de>; Tue, 10 Dec 2019 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLJLTb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Dec 2019 06:19:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:39815 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfLJLTb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Dec 2019 06:19:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 03:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="207248998"
Received: from linux-3rn9.igk.intel.com ([10.102.102.97])
  by orsmga008.jf.intel.com with ESMTP; 10 Dec 2019 03:19:30 -0800
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH, v2] Change warning message
Date:   Tue, 10 Dec 2019 12:21:21 +0100
Message-Id: <20191210112121.20377-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In commit 039b7225e6 ("md: allow creation of mdNNN arrays via
md_mod/parameters/new_array") support for name like mdNNN
was added. Special warning, when kernel is unable to handle
request, was added in commit 7105228e19
("mdadm/mdopen: create new function create_named_array for
writing to new_array"), but it was not adequate enough,
because in this situation mdadm tries to do it in old way.
This commit changes warning to be more relevant when
creating RAID container with "/dev/mdNNN" name and mdadm
back to old approach.

Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
---
 mdopen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mdopen.c b/mdopen.c
index 98c54e4..245be53 100644
--- a/mdopen.c
+++ b/mdopen.c
@@ -120,7 +120,8 @@ int create_named_array(char *devnm)
 		close(fd);
 	}
 	if (fd < 0 || n != (int)strlen(devnm)) {
-		pr_err("Fail create %s when using %s\n", devnm, new_array_file);
+		pr_err("Fail to create %s when using %s, fallback to creation via node\n",
+			devnm, new_array_file);
 		return 0;
 	}
 
-- 
2.16.4

