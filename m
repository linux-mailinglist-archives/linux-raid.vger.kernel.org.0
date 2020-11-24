Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D082C25D8
	for <lists+linux-raid@lfdr.de>; Tue, 24 Nov 2020 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbgKXMkD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Nov 2020 07:40:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:13924 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbgKXMkC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 24 Nov 2020 07:40:02 -0500
IronPort-SDR: 5w8BFWv3KBSKOmbYcQW5jZ1O9iG1gXMiVXpKiBEpDUkfk4kmlEa/P2pcy03mzs8M01TuTH1AXX
 5umfQTDPq6NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172033344"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172033344"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 04:40:02 -0800
IronPort-SDR: 5b0ZneHoSJpKSjLk7u3LjcO3huxs4mGqiZ6egrGM/MJdQox7yHXkpzS5AJBSFQHJsbmzL8ewAB
 O5G7hMi7sYeA==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546818289"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 04:40:01 -0800
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] Create.c: close mdfd and generate uevent
Date:   Tue, 24 Nov 2020 13:39:49 +0100
Message-Id: <20201124123949.792-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

During mdfd closing change event is not generated because open() is
called before start watching mddevice by udev.
Device is ready at this stage. Unblock device, close fd and
generate event to give a chance next layers to work.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 Create.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Create.c b/Create.c
index 0efa19c..51f8826 100644
--- a/Create.c
+++ b/Create.c
@@ -1083,12 +1083,9 @@ int Create(struct supertype *st, char *mddev,
 	} else {
 		pr_err("not starting array - not enough devices.\n");
 	}
-	close(mdfd);
-	/* Give udev a moment to process the Change event caused
-	 * by the close.
-	 */
-	usleep(100*1000);
 	udev_unblock();
+	close(mdfd);
+	sysfs_uevent(&info, "change");
 	return 0;
 
  abort:
-- 
2.25.0

