Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8256B720FD
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfGWUl7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jul 2019 16:41:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:44782 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfGWUl7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jul 2019 16:41:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 13:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="160331147"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Jul 2019 13:41:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D3D6481; Tue, 23 Jul 2019 23:41:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] md: Convert to use int_pow()
Date:   Tue, 23 Jul 2019 23:41:55 +0300
Message-Id: <20190723204155.71531-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Instead of linear approach to calculate power of 10, use generic int_pow()
which does it better.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/md/md.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..3f1252440ad0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3664,11 +3664,7 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
 		return -EINVAL;
 	if (decimals < 0)
 		decimals = 0;
-	while (decimals < scale) {
-		result *= 10;
-		decimals ++;
-	}
-	*res = result;
+	*res = result * int_pow(10, scale - decimals);
 	return 0;
 }
 
-- 
2.20.1

