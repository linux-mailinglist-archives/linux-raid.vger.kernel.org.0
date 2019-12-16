Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AAA1206A9
	for <lists+linux-raid@lfdr.de>; Mon, 16 Dec 2019 14:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfLPNJw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Dec 2019 08:09:52 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:54865 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfLPNJw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 16 Dec 2019 08:09:52 -0500
X-QQ-mid: bizesmtp18t1576501785trg6zphj
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 16 Dec 2019 21:09:44 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZH40000A0000000
X-QQ-FEAT: mJep2VbaKxZs2ozNbT7c2psYSSM6iinCCv2sp8EFXuZl+1GnUd4REdthyPc5R
        vyOKNSVWteDJkpWrr6lOHZFrfUN+SZHOD3dIuxJ9cCfC+6boe6758lbH88uzXMWsyIWRgqf
        +d8h+v99gFBP6aWcHCfBMlzMJj5WmF+6M06Kw4uXQPKzj5vfuYjD2Jd+yKMp/xRnwoNbf4E
        GuhcTdZtInYa1SDqp2Qdb0fW1zdIWxAQexEjLqF5lL++6IvQNr7y/1qRmtEr7uSCLofkL0V
        bSsZHYukDKKURm9HtP0CocS61wZiaHyxs01iJUXFCCK4aJRN0hY/eFuyb8qMfQ/M85492vJ
        ZUl9Z0WJhJYogGX0quf+AZjtSH8ljaw+9eBkcfq
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com, hpa@zytor.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH v3 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
Date:   Mon, 16 Dec 2019 21:09:33 +0800
Message-Id: <20191216130933.13254-2-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
References: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
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
 include/linux/raid/pq.h | 17 +++++++---
 lib/raid6/algos.c       | 71 +++++++++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index e0ddb47f4402..6b68b9590a6b 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -8,6 +8,8 @@
 #ifndef LINUX_RAID_RAID6_H
 #define LINUX_RAID_RAID6_H
 
+#define RAID6_DISKS 8
+
 #ifdef __KERNEL__
 
 /* Set to 1 to use kernel-wide empty_zero_page */
@@ -31,6 +33,7 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <string.h>
 
 /* Not standard, but glibc defines it */
 #define BITS_PER_LONG __WORDSIZE
@@ -43,6 +46,9 @@ typedef uint64_t u64;
 #ifndef PAGE_SIZE
 # define PAGE_SIZE 4096
 #endif
+#ifndef PAGE_SHIFT
+# define PAGE_SHIFT 12
+#endif
 extern const char raid6_empty_zero_page[PAGE_SIZE];
 
 #define __init
@@ -168,11 +174,12 @@ void raid6_dual_recov(int disks, size_t bytes, int faila, int failb,
 # define pr_err(format, ...) fprintf(stderr, format, ## __VA_ARGS__)
 # define pr_info(format, ...) fprintf(stdout, format, ## __VA_ARGS__)
 # define GFP_KERNEL	0
-# define __get_free_pages(x, y)	((unsigned long)mmap(NULL, PAGE_SIZE << (y), \
-						     PROT_READ|PROT_WRITE,   \
-						     MAP_PRIVATE|MAP_ANONYMOUS,\
-						     0, 0))
-# define free_pages(x, y)	munmap((void *)(x), PAGE_SIZE << (y))
+# define kmalloc(x, y)	((unsigned long)mmap(NULL, (x), PROT_READ|PROT_WRITE, \
+						 MAP_PRIVATE|MAP_ANONYMOUS,   \
+						 0, 0))
+# define kfree(x)	munmap((void *)(x), (RAID6_DISKS - 2) * PAGE_SIZE     \
+						<= 65536 ? 2 * PAGE_SIZE :    \
+						(RAID6_DISKS - 2) * PAGE_SIZE)
 
 static inline void cpu_relax(void)
 {
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 17417eee0866..959e6e23aa5f 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -146,7 +146,7 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 }
 
 static inline const struct raid6_calls *raid6_choose_gen(
-	void *(*const dptrs)[(65536/PAGE_SIZE)+2], const int disks)
+	void *(*const dptrs)[RAID6_DISKS], const int disks)
 {
 	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
 	int start = (disks>>1)-1, stop = disks-3;	/* work on the second half of the disks */
@@ -181,7 +181,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				best = *algo;
 			}
 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
-			       (perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
+				(perf * HZ * (disks-2)) >>
+				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
 
 			if (!(*algo)->xor_syndrome)
 				continue;
@@ -204,17 +205,24 @@ static inline const struct raid6_calls *raid6_choose_gen(
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
@@ -228,27 +236,42 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 int __init raid6_select_algo(void)
 {
-	const int disks = (65536/PAGE_SIZE)+2;
+	const int disks = RAID6_DISKS;
 
 	const struct raid6_calls *gen_best;
 	const struct raid6_recov_calls *rec_best;
-	char *syndromes;
-	void *dptrs[(65536/PAGE_SIZE)+2];
-	int i;
-
-	for (i = 0; i < disks-2; i++)
-		dptrs[i] = ((char *)raid6_gfmul) + PAGE_SIZE*i;
+	char *alloc_ptr, *p;
+	void *dptrs[RAID6_DISKS];
+	int i, cycle;
+
+	/*
+	 * use raid6_gfmul table to fill the RAID6_DISKS-2 page-sized data disks
+	 * if the total disk size is less then raid6_gfmul, just make dptrs point
+	 * to it, otherwise do a dynamic allocation and copy the table circularly
+	 */
+	if ((disks - 2) * PAGE_SIZE <= 65536 ) {
+		for (i = 0; i < disks - 2; i++)
+			dptrs[i] = (char *)raid6_gfmul + PAGE_SIZE * i;
+
+		alloc_ptr = (char *)kmalloc(2 * PAGE_SIZE, GFP_KERNEL | __GFP_NOFAIL);
+		dptrs[disks-2] = alloc_ptr;
+		dptrs[disks-1] = alloc_ptr + PAGE_SIZE;
+	} else {
+		alloc_ptr = (char *)kmalloc(disks * PAGE_SIZE, GFP_KERNEL | __GFP_NOFAIL);
+		p = alloc_ptr;
+		cycle = ((disks - 2) * PAGE_SIZE) / 65536;
+		for (i = 0; i < cycle; i++) {
+			memcpy(p, raid6_gfmul, 65536);
+			p += 65536;
+		}
 
-	/* Normal code - use a 2-page allocation to avoid D$ conflict */
-	syndromes = (void *) __get_free_pages(GFP_KERNEL, 1);
+		if ((disks - 2) * PAGE_SIZE % 65536)
+			memcpy(p, raid6_gfmul, (disks - 2) * PAGE_SIZE % 65536);
 
-	if (!syndromes) {
-		pr_err("raid6: Yikes!  No memory available.\n");
-		return -ENOMEM;
+		for (i=0; i < disks; i++)
+			dptrs[i] = alloc_ptr + PAGE_SIZE * i;
 	}
 
-	dptrs[disks-2] = syndromes;
-	dptrs[disks-1] = syndromes + PAGE_SIZE;
 
 	/* select raid gen_syndrome function */
 	gen_best = raid6_choose_gen(&dptrs, disks);
@@ -256,7 +279,7 @@ int __init raid6_select_algo(void)
 	/* select raid recover functions */
 	rec_best = raid6_choose_recov();
 
-	free_pages((unsigned long)syndromes, 1);
+	kfree(alloc_ptr);
 
 	return gen_best && rec_best ? 0 : -EINVAL;
 }
-- 
2.20.1



