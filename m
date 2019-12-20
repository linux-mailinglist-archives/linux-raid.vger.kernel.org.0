Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11269127370
	for <lists+linux-raid@lfdr.de>; Fri, 20 Dec 2019 03:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLTCVv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Dec 2019 21:21:51 -0500
Received: from smtpbguseast1.qq.com ([54.204.34.129]:35735 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfLTCVv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Dec 2019 21:21:51 -0500
X-Greylist: delayed 170758 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 21:21:50 EST
X-QQ-mid: bizesmtp24t1576808498tuvdaoml
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 20 Dec 2019 10:21:38 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZH40B00A0000000
X-QQ-FEAT: 2HIwkBI2/exbvfq2EZNM6oTeQl/NbAjrIIiraQmfK60QlM0y9kZtWz3GkHenQ
        TNCgI73IDscKdHySeVMcbWq8dELjjz9Fk+M6msJmxVW+YAzttTmJsL9ArucwFUZ1I7pFSrC
        Rz2Jjv04JOYEJsLwZLdBIeAipKfDcAsSbck3cnBvLV16mQfWN2LWNhZcPskp/lb0Oc+zu8Q
        OQBrlJbcZImjTrjnVyyKVAwFJPsj4hAa4LGPvsiT2zSjoj8AyvafWdsISNxew3hbECJxAdK
        ETOLqiMFrkaSrrRTbbff8wUNOdauI3kUyaBQtClhn449i5SuTJCboBYlo7c/418N+CQ7fJy
        W7mQtcoo84jbyWYoySw42PBW0pGOA==
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com, hpa@zytor.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH v4 2/3] raid6/test: fix a compilation warning
Date:   Fri, 20 Dec 2019 10:21:27 +0800
Message-Id: <20191220022128.23296-2-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220022128.23296-1-liuzhengyuan@kylinos.cn>
References: <20191220022128.23296-1-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The compilation warning is redefination showed as following:

        In file included from tables.c:2:
        ../../../include/linux/export.h:180: warning: "EXPORT_SYMBOL" redefined
         #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")

        In file included from tables.c:1:
        ../../../include/linux/raid/pq.h:61: note: this is the location of the previous definition
         #define EXPORT_SYMBOL(sym)

Fixes: 69a94abb82ee ("export.h, genksyms: do not make genksyms calculate CRC of trimmed symbols")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 include/linux/raid/pq.h | 2 ++
 lib/raid6/mktables.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 0b6e7ad9cd2a..e0ddb47f4402 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -58,7 +58,9 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
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



