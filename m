Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84226127371
	for <lists+linux-raid@lfdr.de>; Fri, 20 Dec 2019 03:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLTCVw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Dec 2019 21:21:52 -0500
Received: from smtpbg701.qq.com ([203.205.195.86]:59396 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbfLTCVw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Dec 2019 21:21:52 -0500
X-QQ-mid: bizesmtp24t1576808500tiwvhd1v
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 20 Dec 2019 10:21:40 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZH40B00A0000000
X-QQ-FEAT: kuhMzgBNbeK0S98LWoqtTNPbsu43ko0cGSPWMMsGSiPSYgb/VKi95L2ZqbJds
        GntTfXXxWUBCuuNWs56q4Szt2YfyGxJSx/VRyyernY9lfFKQbjNP9/NZ4jcs0PzLQ/xpvQ9
        qK0IHmXuAaiRlblvCCVuweM3mfWUvhHm9uGlXGknRVHVdNMU7Zn7dXDCykhEGckC+0pdGzV
        oxl1NoqUgZy1w8qQsi+SZS9TZCscuGUz1PKpKYV01Plf+d4izW/4zRl+YMB5Bur/cLqJuu3
        DXvb7sbOaEeco1T3AdkpIykS3taEdCZxVom08p6eIIxCM5h/1ZnxPpe+An/kfwChaB6Tl4u
        9LGJ49VEa4vZAJBYORvGOpDvnxhJQ==
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com, hpa@zytor.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH v4 3/3] md/raid6: fix algorithm choice under larger PAGE_SIZE
Date:   Fri, 20 Dec 2019 10:21:28 +0800
Message-Id: <20191220022128.23296-3-liuzhengyuan@kylinos.cn>
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

There are several algorithms available for raid6 to generate xor and syndrome
parity, including basic int1, int2 ... int32 and SIMD optimized implementation
like sse and neon.  To test and choose the best algorithms at the initial
stage, we need provide enough disk data to feed the algorithms. However, the
disk number we provided depends on page size and gfmul table, seeing bellow:

    const int disks = (65536/PAGE_SIZE) + 2;

So when come to 64K PAGE_SIZE, there is only one data disk plus 2 parity disk,
as a result the chosed algorithm is not reliable. For example, on my arm64
machine with 64K page enabled, it will choose intx32 as the best one, although
the NEON implementation is better.

This patch tries to fix the problem by defining a constant raid6 disk number to
supporting arbitrary page size.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 include/linux/raid/pq.h |  4 +++
 lib/raid6/algos.c       | 63 ++++++++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index e0ddb47f4402..154e954b711d 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -28,6 +28,7 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
 #include <errno.h>
 #include <inttypes.h>
 #include <stddef.h>
+#include <string.h>
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -43,6 +44,9 @@ typedef uint64_t u64;
 #ifndef PAGE_SIZE
 # define PAGE_SIZE 4096
 #endif
+#ifndef PAGE_SHIFT
+# define PAGE_SHIFT 12
+#endif
 extern const char raid6_empty_zero_page[PAGE_SIZE];
 
 #define __init
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 17417eee0866..bf1b4765c8f6 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -124,6 +124,9 @@ const struct raid6_recov_calls *const raid6_recov_algos[] = {
 #define time_before(x, y) ((x) < (y))
 #endif
 
+#define RAID6_TEST_DISKS	8
+#define RAID6_TEST_DISKS_ORDER	3
+
 static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 {
 	const struct raid6_recov_calls *const *algo;
@@ -146,7 +149,7 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 }
 
 static inline const struct raid6_calls *raid6_choose_gen(
-	void *(*const dptrs)[(65536/PAGE_SIZE)+2], const int disks)
+	void *(*const dptrs)[RAID6_TEST_DISKS], const int disks)
 {
 	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
 	int start = (disks>>1)-1, stop = disks-3;	/* work on the second half of the disks */
@@ -181,7 +184,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				best = *algo;
 			}
 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
-			       (perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
+				(perf * HZ * (disks-2)) >>
+				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
 
 			if (!(*algo)->xor_syndrome)
 				continue;
@@ -204,17 +208,24 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				bestxorperf = perf;
 
 			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
-				(perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
+				(perf * HZ * (disks-2)) >>
+				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
 		}
 	}
 
 	if (best) {
-		pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
-		       best->name,
-		       (bestgenperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
-		if (best->xor_syndrome)
-			pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
-			       (bestxorperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
+		if (IS_ENABLED(CONFIG_RAID6_PQ_BENCHMARK)) {
+			pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
+				best->name,
+				(bestgenperf * HZ * (disks-2)) >>
+				(20 - PAGE_SHIFT+RAID6_TIME_JIFFIES_LG2));
+			if (best->xor_syndrome)
+				pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
+					(bestxorperf * HZ * (disks-2)) >>
+					(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
+		} else
+			pr_info("raid6: skip pq benchmark and using algorithm %s\n",
+				best->name);
 		raid6_call = *best;
 	} else
 		pr_err("raid6: Yikes!  No algorithm found!\n");
@@ -228,27 +239,33 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 int __init raid6_select_algo(void)
 {
-	const int disks = (65536/PAGE_SIZE)+2;
+	const int disks = RAID6_TEST_DISKS;
 
 	const struct raid6_calls *gen_best;
 	const struct raid6_recov_calls *rec_best;
-	char *syndromes;
-	void *dptrs[(65536/PAGE_SIZE)+2];
-	int i;
-
-	for (i = 0; i < disks-2; i++)
-		dptrs[i] = ((char *)raid6_gfmul) + PAGE_SIZE*i;
-
-	/* Normal code - use a 2-page allocation to avoid D$ conflict */
-	syndromes = (void *) __get_free_pages(GFP_KERNEL, 1);
+	char *disk_ptr, *p;
+	void *dptrs[RAID6_TEST_DISKS];
+	int i, cycle;
 
-	if (!syndromes) {
+	/* prepare the buffer and fill it circularly with gfmul table */
+	disk_ptr = (char *)__get_free_pages(GFP_KERNEL, RAID6_TEST_DISKS_ORDER);
+	if (!disk_ptr) {
 		pr_err("raid6: Yikes!  No memory available.\n");
 		return -ENOMEM;
 	}
 
-	dptrs[disks-2] = syndromes;
-	dptrs[disks-1] = syndromes + PAGE_SIZE;
+	p = disk_ptr;
+	for (i = 0; i < disks; i++)
+		dptrs[i] = p + PAGE_SIZE * i;
+
+	cycle = ((disks - 2) * PAGE_SIZE) / 65536;
+	for (i = 0; i < cycle; i++) {
+		memcpy(p, raid6_gfmul, 65536);
+		p += 65536;
+	}
+
+	if ((disks - 2) * PAGE_SIZE % 65536)
+		memcpy(p, raid6_gfmul, (disks - 2) * PAGE_SIZE % 65536);
 
 	/* select raid gen_syndrome function */
 	gen_best = raid6_choose_gen(&dptrs, disks);
@@ -256,7 +273,7 @@ int __init raid6_select_algo(void)
 	/* select raid recover functions */
 	rec_best = raid6_choose_recov();
 
-	free_pages((unsigned long)syndromes, 1);
+	free_pages((unsigned long)disk_ptr, RAID6_TEST_DISKS_ORDER);
 
 	return gen_best && rec_best ? 0 : -EINVAL;
 }
-- 
2.20.1



