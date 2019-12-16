Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCA1206AA
	for <lists+linux-raid@lfdr.de>; Mon, 16 Dec 2019 14:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfLPNJx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Dec 2019 08:09:53 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:55757 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfLPNJw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Dec 2019 08:09:52 -0500
X-QQ-mid: bizesmtp18t1576501783tso1dzvr
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 16 Dec 2019 21:09:33 +0800 (CST)
X-QQ-SSF: 00400000002000I0ZH40000A0000000
X-QQ-FEAT: s8YYpWqVDdfeTEqJWWgiCoZA96O8vweNzUylx6fS1ItRh/HRHcGLjfmzgL1s0
        I/j5jX9EGY41tLQSaTzJ/GS4mWICZMfZUuHVtWF5sKRKPS/b+lfxuuNH76ajo4dz7MvBY5J
        sGHyD1UuEVWT9fZoDQTXg55T1iABFdjwIf64Humqvk1ACeLw3kvxVNTF9TTyEonpZYBmYhK
        SIZoSgMNmS9BDEoPoeJH6513CDwE+G0+Q086k+lYwDi2UFOvPG0c3zESkpQXl0A92175EFW
        jVtLy1d5kFPPCsQe6RbaA2WM0J7PGa23oO7P3rnPE06nm4TkpVJ8viHY60xNrqOi2w9hIAP
        oxnulXRcEFEY+GdpAVGVMH2X6JyNuEDFoBdFPMfhH72DKOge9s=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com, hpa@zytor.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH v3 1/2] raid6/test: fix the compilation error and warning
Date:   Mon, 16 Dec 2019 21:09:32 +0800
Message-Id: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The compilation error is redeclaration showed as following:

	In file included from ../../../include/linux/limits.h:6,
	                 from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
	                 from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
	                 from /usr/include/limits.h:183,
	                 from /usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/limits.h:194,
	                 from /usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/syslimits.h:7,
	                 from /usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/limits.h:34,
	                 from ../../../include/linux/raid/pq.h:30,
	                 from algos.c:14:
	../../../include/linux/types.h:114:15: error: conflicting types for ‘int64_t’
	 typedef s64   int64_t;
	               ^~~~~~~
	In file included from /usr/include/stdint.h:34,
	                 from /usr/lib/gcc/x86_64-linux-gnu/8/include/stdint.h:9,
	                 from /usr/include/inttypes.h:27,
	                 from ../../../include/linux/raid/pq.h:29,
	                 from algos.c:14:
	/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous \
	declaration of ‘int64_t’ was here
	 typedef __int64_t int64_t;

The compilation warning is redefination showed as following:

	In file included from tables.c:2:
	../../../include/linux/export.h:180: warning: "EXPORT_SYMBOL" redefined
	 #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")

	In file included from tables.c:1:
	../../../include/linux/raid/pq.h:61: note: this is the location of the previous definition
	 #define EXPORT_SYMBOL(sym)

Fixes: 54d50897d54 ("linux/kernel.h: split *_MAX and *_MIN macros into <linux/limits.h>")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 include/linux/raid/pq.h | 3 ++-
 lib/raid6/mktables.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 0832c9b66852..e0ddb47f4402 100644
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
index 9c485df1308f..f02e10fa6238 100644
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
2.20.1



