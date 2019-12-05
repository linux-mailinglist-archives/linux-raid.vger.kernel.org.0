Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD8113A3A
	for <lists+linux-raid@lfdr.de>; Thu,  5 Dec 2019 04:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLEDNn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Dec 2019 22:13:43 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:49944 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfLEDNn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 4 Dec 2019 22:13:43 -0500
X-QQ-mid: bizesmtp23t1575515615tmfbz9bp
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Thu, 05 Dec 2019 11:13:34 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZG41000A0000000
X-QQ-FEAT: l6IKqkG+NbmlHpNua9TvAML/ehH8Nh9CAeOZthfxt9shhOfKyj7hORFE0VlSp
        yloQnJE2e1rzTSRmgYF4jyCXicgBzEadwp35Co8KiWS6AYmnQ2gNCzNMr1tWSsG1TytCtRe
        Uw23Hb65AYcWZfT/FT7U7ugaU2FWEhqQX4m3uu+81lQqcJ650YVW/TNMCG3WVz37W8/qrHI
        oGRk8Xv0sdwKWUTdwV3HT/p3rKBu6p6JL3Y31tYVdwWPne6LwUBlLJ+sEgVjVcv5sOdaehY
        fqZ82mNILAqGCv/6QrxC0Nj8dr9c1SsqE1l01mn1TZxUvQv2d/Dxh969w6lodscasQQy2jO
        p26ZXJu+WrYr0wi+aQH3xZxYePg9A==
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org, hpa@zytor.com,
        liuzhengyuang521@gmail.com
Subject: [PATCH v2 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
Date:   Thu,  5 Dec 2019 11:13:18 +0800
Message-Id: <20191205031318.7098-2-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205031318.7098-1-liuzhengyuan@kylinos.cn>
References: <20191205031318.7098-1-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
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

	int __init raid6_select_algo(void)
	{
		const int disks = (65536/PAGE_SIZE) + 2;
		...
	}

So when come to 64K PAGE_SIZE, there is only one data disk plus 2 parity disk,
as a result the chosed algorithm is not reliable. For example, on my arm64
machine with 64K page enabled, it will choose intx32 as the best one, although
the NEON implementation is better.

This patch tries to fix the problem by defining a constant raid6 block size to
supporting arbitrary page size. lib/raid6/test will use this block size too.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 include/linux/raid/pq.h | 16 +++++++++-------
 lib/raid6/algos.c       | 33 ++++++++++++++++++---------------
 lib/raid6/test/test.c   | 28 ++++++++++++++--------------
 3 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index e0ddb47..5b7388c 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -8,6 +8,12 @@
 #ifndef LINUX_RAID_RAID6_H
 #define LINUX_RAID_RAID6_H
 
+/*
+ * Define a constant data block size no matter what real PAGE_SIZE is.
+ * Both lib/raid6/test/test.c and lib/raid6/algo.c will use it.
+ */
+#define RAID6_BLK_SZ	4096
+
 #ifdef __KERNEL__
 
 /* Set to 1 to use kernel-wide empty_zero_page */
@@ -40,10 +46,7 @@ typedef uint16_t u16;
 typedef uint32_t u32;
 typedef uint64_t u64;
 
-#ifndef PAGE_SIZE
-# define PAGE_SIZE 4096
-#endif
-extern const char raid6_empty_zero_page[PAGE_SIZE];
+extern const char raid6_empty_zero_page[RAID6_BLK_SZ];
 
 #define __init
 #define __exit
@@ -168,11 +171,10 @@ void raid6_dual_recov(int disks, size_t bytes, int faila, int failb,
 # define pr_err(format, ...) fprintf(stderr, format, ## __VA_ARGS__)
 # define pr_info(format, ...) fprintf(stdout, format, ## __VA_ARGS__)
 # define GFP_KERNEL	0
-# define __get_free_pages(x, y)	((unsigned long)mmap(NULL, PAGE_SIZE << (y), \
-						     PROT_READ|PROT_WRITE,   \
+# define kmalloc(x, y)		((unsigned long)mmap(NULL, x, PROT_READ|PROT_WRITE,\
 						     MAP_PRIVATE|MAP_ANONYMOUS,\
 						     0, 0))
-# define free_pages(x, y)	munmap((void *)(x), PAGE_SIZE << (y))
+# define kfree(x)	munmap((void *)(x), 2*RAID6_BLK_SZ)
 
 static inline void cpu_relax(void)
 {
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 17417ee..b46be0e 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -146,7 +146,7 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 }
 
 static inline const struct raid6_calls *raid6_choose_gen(
-	void *(*const dptrs)[(65536/PAGE_SIZE)+2], const int disks)
+	void *(*const dptrs)[(65536/RAID6_BLK_SZ)+2], const int disks)
 {
 	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
 	int start = (disks>>1)-1, stop = disks-3;	/* work on the second half of the disks */
@@ -171,7 +171,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				cpu_relax();
 			while (time_before(jiffies,
 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
-				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
+				(*algo)->gen_syndrome(disks, RAID6_BLK_SZ, *dptrs);
 				perf++;
 			}
 			preempt_enable();
@@ -181,7 +181,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				best = *algo;
 			}
 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
-			       (perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
+				(perf*HZ*RAID6_BLK_SZ*(disks-2)) >>
+				(20+RAID6_TIME_JIFFIES_LG2));
 
 			if (!(*algo)->xor_syndrome)
 				continue;
@@ -195,7 +196,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 			while (time_before(jiffies,
 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
 				(*algo)->xor_syndrome(disks, start, stop,
-						      PAGE_SIZE, *dptrs);
+						      RAID6_BLK_SZ, *dptrs);
 				perf++;
 			}
 			preempt_enable();
@@ -204,17 +205,20 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				bestxorperf = perf;
 
 			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
-				(perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
+				(perf*HZ*RAID6_BLK_SZ*(disks-2)) >>
+				(20+RAID6_TIME_JIFFIES_LG2+1));
 		}
 	}
 
 	if (best) {
 		pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
-		       best->name,
-		       (bestgenperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
+		        best->name,
+			(bestgenperf*HZ*RAID6_BLK_SZ*(disks-2)) >>
+			(20+RAID6_TIME_JIFFIES_LG2));
 		if (best->xor_syndrome)
 			pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
-			       (bestxorperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
+				(bestxorperf*HZ*RAID6_BLK_SZ*(disks-2))
+				>> (20+RAID6_TIME_JIFFIES_LG2+1));
 		raid6_call = *best;
 	} else
 		pr_err("raid6: Yikes!  No algorithm found!\n");
@@ -228,19 +232,18 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 int __init raid6_select_algo(void)
 {
-	const int disks = (65536/PAGE_SIZE)+2;
+	const int disks = (65536/RAID6_BLK_SZ)+2;
 
 	const struct raid6_calls *gen_best;
 	const struct raid6_recov_calls *rec_best;
 	char *syndromes;
-	void *dptrs[(65536/PAGE_SIZE)+2];
+	void *dptrs[(65536/RAID6_BLK_SZ)+2];
 	int i;
 
 	for (i = 0; i < disks-2; i++)
-		dptrs[i] = ((char *)raid6_gfmul) + PAGE_SIZE*i;
+		dptrs[i] = ((char *)raid6_gfmul) + RAID6_BLK_SZ*i;
 
-	/* Normal code - use a 2-page allocation to avoid D$ conflict */
-	syndromes = (void *) __get_free_pages(GFP_KERNEL, 1);
+	syndromes = (void *) kmalloc(2*RAID6_BLK_SZ, GFP_KERNEL);
 
 	if (!syndromes) {
 		pr_err("raid6: Yikes!  No memory available.\n");
@@ -248,7 +251,7 @@ int __init raid6_select_algo(void)
 	}
 
 	dptrs[disks-2] = syndromes;
-	dptrs[disks-1] = syndromes + PAGE_SIZE;
+	dptrs[disks-1] = syndromes + RAID6_BLK_SZ;
 
 	/* select raid gen_syndrome function */
 	gen_best = raid6_choose_gen(&dptrs, disks);
@@ -256,7 +259,7 @@ int __init raid6_select_algo(void)
 	/* select raid recover functions */
 	rec_best = raid6_choose_recov();
 
-	free_pages((unsigned long)syndromes, 1);
+	kfree(syndromes);
 
 	return gen_best && rec_best ? 0 : -EINVAL;
 }
diff --git a/lib/raid6/test/test.c b/lib/raid6/test/test.c
index a3cf071..d3d6c6c3 100644
--- a/lib/raid6/test/test.c
+++ b/lib/raid6/test/test.c
@@ -18,20 +18,20 @@
 
 #define NDISKS		16	/* Including P and Q */
 
-const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+const char raid6_empty_zero_page[RAID6_BLK_SZ] __attribute__((aligned(4096)));
 struct raid6_calls raid6_call;
 
 char *dataptrs[NDISKS];
-char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-char recovi[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-char recovj[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+char data[NDISKS][RAID6_BLK_SZ] __attribute__((aligned(4096)));
+char recovi[RAID6_BLK_SZ] __attribute__((aligned(4096)));
+char recovj[RAID6_BLK_SZ] __attribute__((aligned(4096)));
 
 static void makedata(int start, int stop)
 {
 	int i, j;
 
 	for (i = start; i <= stop; i++) {
-		for (j = 0; j < PAGE_SIZE; j++)
+		for (j = 0; j < RAID6_BLK_SZ; j++)
 			data[i][j] = rand();
 
 		dataptrs[i] = data[i];
@@ -54,16 +54,16 @@ static int test_disks(int i, int j)
 {
 	int erra, errb;
 
-	memset(recovi, 0xf0, PAGE_SIZE);
-	memset(recovj, 0xba, PAGE_SIZE);
+	memset(recovi, 0xf0, RAID6_BLK_SZ);
+	memset(recovj, 0xba, RAID6_BLK_SZ);
 
 	dataptrs[i] = recovi;
 	dataptrs[j] = recovj;
 
-	raid6_dual_recov(NDISKS, PAGE_SIZE, i, j, (void **)&dataptrs);
+	raid6_dual_recov(NDISKS, RAID6_BLK_SZ, i, j, (void **)&dataptrs);
 
-	erra = memcmp(data[i], recovi, PAGE_SIZE);
-	errb = memcmp(data[j], recovj, PAGE_SIZE);
+	erra = memcmp(data[i], recovi, RAID6_BLK_SZ);
+	errb = memcmp(data[j], recovj, RAID6_BLK_SZ);
 
 	if (i < NDISKS-2 && j == NDISKS-1) {
 		/* We don't implement the DQ failure scenario, since it's
@@ -110,10 +110,10 @@ int main(int argc, char *argv[])
 			raid6_call = **algo;
 
 			/* Nuke syndromes */
-			memset(data[NDISKS-2], 0xee, 2*PAGE_SIZE);
+			memset(data[NDISKS-2], 0xee, 2*RAID6_BLK_SZ);
 
 			/* Generate assumed good syndrome */
-			raid6_call.gen_syndrome(NDISKS, PAGE_SIZE,
+			raid6_call.gen_syndrome(NDISKS, RAID6_BLK_SZ,
 						(void **)&dataptrs);
 
 			for (i = 0; i < NDISKS-1; i++)
@@ -127,10 +127,10 @@ int main(int argc, char *argv[])
 				for (p2 = p1; p2 < NDISKS-2; p2++) {
 
 					/* Simulate rmw run */
-					raid6_call.xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
+					raid6_call.xor_syndrome(NDISKS, p1, p2, RAID6_BLK_SZ,
 								(void **)&dataptrs);
 					makedata(p1, p2);
-					raid6_call.xor_syndrome(NDISKS, p1, p2, PAGE_SIZE,
+					raid6_call.xor_syndrome(NDISKS, p1, p2, RAID6_BLK_SZ,
                                                                 (void **)&dataptrs);
 
 					for (i = 0; i < NDISKS-1; i++)
-- 
2.7.4



