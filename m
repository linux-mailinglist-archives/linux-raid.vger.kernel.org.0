Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6865B113A3F
	for <lists+linux-raid@lfdr.de>; Thu,  5 Dec 2019 04:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLEDO2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Dec 2019 22:14:28 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:50493 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfLEDO2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 4 Dec 2019 22:14:28 -0500
X-QQ-mid: bizesmtp23t1575515613teackr2p
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Thu, 05 Dec 2019 11:13:19 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZG41000A0000000
X-QQ-FEAT: vRxJyNZKtn5KODKFc32lUA8PB6i0f+bnXVHN1XgR7lxiafTFYLcyw1X9/NXoC
        gjgdG8Lnmon/CWCfZWr8V3iDiht/TytCl1iy4EcFsI5dK33LgcYDR9ydzstMZ6/Lt608ier
        1XHyyItr1ZgDMHo8CtzWpIqmjuNfgvVh8pnn1lkMiX/OMpYGjfDZmJ5QNS6zGZaYudefHtx
        +llqJhIbdQLHO/j35GZHmpOesqlyeFqvCq/FYiw1m4WGdL3LLLBapo9SnrwR0e3R2Ncisly
        HCM3vZGJwehI1NVJDoG/NiFisxEkHF7PxqyjJHIB0eyH+aerAYEGqt9lkUy8SwxpLIlKv69
        BvJwuPAOj+tblEl0x+BYBh+Xz5j6w==
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org, hpa@zytor.com,
        liuzhengyuang521@gmail.com
Subject: [PATCH v2 1/2] raid6/test: fix the compilation error and warning
Date:   Thu,  5 Dec 2019 11:13:17 +0800
Message-Id: <20191205031318.7098-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The compilation error of redeclaration was indroduced by commit 54d50897d54
("linux/kernel.h: split *_MAX and *_MIN macros into <linux/limits.h>"). Fix
it by removing useless header limit.h.

The compilation warning was redefination of macro EXPORT_SYMBOL*.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 include/linux/raid/pq.h | 3 ++-
 lib/raid6/mktables.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 0832c9b..e0ddb47 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -27,7 +27,6 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
 
 #include <errno.h>
 #include <inttypes.h>
-#include <limits.h>
 #include <stddef.h>
 #include <sys/mman.h>
 #include <sys/time.h>
@@ -59,7 +58,9 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
 #define enable_kernel_altivec()
 #define disable_kernel_altivec()
 
+#undef	EXPORT_SYMBOL
 #define EXPORT_SYMBOL(sym)
+#undef	EXPORT_SYMBOL_GPL
 #define EXPORT_SYMBOL_GPL(sym)
 #define MODULE_LICENSE(licence)
 #define MODULE_DESCRIPTION(desc)
diff --git a/lib/raid6/mktables.c b/lib/raid6/mktables.c
index 9c485df..f02e10f 100644
--- a/lib/raid6/mktables.c
+++ b/lib/raid6/mktables.c
@@ -56,8 +56,8 @@ int main(int argc, char *argv[])
 	uint8_t v;
 	uint8_t exptbl[256], invtbl[256];
 
-	printf("#include <linux/raid/pq.h>\n");
 	printf("#include <linux/export.h>\n");
+	printf("#include <linux/raid/pq.h>\n");
 
 	/* Compute multiplication table */
 	printf("\nconst u8  __attribute__((aligned(256)))\n"
-- 
2.7.4



