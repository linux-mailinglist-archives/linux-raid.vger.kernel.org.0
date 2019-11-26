Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD3109AF8
	for <lists+linux-raid@lfdr.de>; Tue, 26 Nov 2019 10:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfKZJRN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 26 Nov 2019 04:17:13 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:34602 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfKZJRN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 26 Nov 2019 04:17:13 -0500
X-QQ-mid: bizesmtp20t1574759822tw1izc12
Received: from lzy-H3050.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 26 Nov 2019 17:16:51 +0800 (CST)
X-QQ-SSF: 01400000000000I0ZG41B00A0000000
X-QQ-FEAT: mAJfWfDYrJMMC/NfIaUsWSj7Y9f7km3wchhEK4oPqLlara9IaEkZRMOEwjAHv
        kZ06Zuv0SqPYPF5Wmmbg1FPZPXnymGKOUg5Iq6TKPp+0AaAnuW2MjMdfby3wKpr1K2L3htf
        ZL1wMqeM/D5hcHDkJsmaEROFBcu3v6feSS0PME0GsIQQBdA4AbRoeKSXe/h9IzSdrRt98Sk
        4xnIiajXmf4hfjgUnxyNvcfv8gtEPN55cEpHSqhWJqMwgOra9dbu9BshTvRlMk2JrwLCf1v
        O+vV5LJu0URFTbhosYrteBA5/g3CuWekfDO/tF/F/+Zn8iijTX9rtSOZtnDJasZ/q8PkCLH
        9sbp6ktsTXytymO2yY=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com, linux-raid@vger.kernel.org
Cc:     hpa@zytor.com
Subject: [PATCH] md/raid6: fix algorithm choice under larger PAGE_SIZE
Date:   Tue, 26 Nov 2019 17:16:51 +0800
Message-Id: <1574759811-11360-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For raid6, we need at least 4 disks to calculate the best algorithm.
But, currently we assume we are always under 4k PAGE_SIZE, when come
to larger page size, such as 64K, we may get a wrong xor() and gen().

This patch tries to fix the problem by supporting arbitrarily page size.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 lib/raid6/algos.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 17417ee..0df7d99 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -118,6 +118,7 @@ const struct raid6_recov_calls *const raid6_recov_algos[] = {
 
 #ifdef __KERNEL__
 #define RAID6_TIME_JIFFIES_LG2	4
+#define RAID6_DATA_BLOCK_LEN	4096
 #else
 /* Need more time to be stable in userspace */
 #define RAID6_TIME_JIFFIES_LG2	9
@@ -146,7 +147,7 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 }
 
 static inline const struct raid6_calls *raid6_choose_gen(
-	void *(*const dptrs)[(65536/PAGE_SIZE)+2], const int disks)
+	void *(*const dptrs)[(65536/RAID6_DATA_BLOCK_LEN)+2], const int disks)
 {
 	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
 	int start = (disks>>1)-1, stop = disks-3;	/* work on the second half of the disks */
@@ -171,7 +172,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				cpu_relax();
 			while (time_before(jiffies,
 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
-				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
+				(*algo)->gen_syndrome(disks, RAID6_DATA_BLOCK_LEN, *dptrs);
 				perf++;
 			}
 			preempt_enable();
@@ -181,7 +182,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				best = *algo;
 			}
 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
-			       (perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
+			       (perf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) >> \
+						(20+RAID6_TIME_JIFFIES_LG2));
 
 			if (!(*algo)->xor_syndrome)
 				continue;
@@ -195,7 +197,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 			while (time_before(jiffies,
 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
 				(*algo)->xor_syndrome(disks, start, stop,
-						      PAGE_SIZE, *dptrs);
+						      RAID6_DATA_BLOCK_LEN, *dptrs);
 				perf++;
 			}
 			preempt_enable();
@@ -204,17 +206,20 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				bestxorperf = perf;
 
 			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
-				(perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
+				(perf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) >> \
+						(20+RAID6_TIME_JIFFIES_LG2+1));
 		}
 	}
 
 	if (best) {
 		pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
 		       best->name,
-		       (bestgenperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
+		       (bestgenperf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) >> \
+						(20+RAID6_TIME_JIFFIES_LG2));
 		if (best->xor_syndrome)
 			pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
-			       (bestxorperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
+			       (bestxorperf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) \
+						>> (20+RAID6_TIME_JIFFIES_LG2+1));
 		raid6_call = *best;
 	} else
 		pr_err("raid6: Yikes!  No algorithm found!\n");
@@ -228,16 +233,16 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 int __init raid6_select_algo(void)
 {
-	const int disks = (65536/PAGE_SIZE)+2;
+	const int disks = (65536/RAID6_DATA_BLOCK_LEN)+2;
 
 	const struct raid6_calls *gen_best;
 	const struct raid6_recov_calls *rec_best;
 	char *syndromes;
-	void *dptrs[(65536/PAGE_SIZE)+2];
+	void *dptrs[(65536/RAID6_DATA_BLOCK_LEN)+2];
 	int i;
 
 	for (i = 0; i < disks-2; i++)
-		dptrs[i] = ((char *)raid6_gfmul) + PAGE_SIZE*i;
+		dptrs[i] = ((char *)raid6_gfmul) + RAID6_DATA_BLOCK_LEN*i;
 
 	/* Normal code - use a 2-page allocation to avoid D$ conflict */
 	syndromes = (void *) __get_free_pages(GFP_KERNEL, 1);
-- 
2.7.4



