Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9C121CB2
	for <lists+linux-raid@lfdr.de>; Mon, 16 Dec 2019 23:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLPWWl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Dec 2019 17:22:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52111 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLPWWk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Dec 2019 17:22:40 -0500
Received: from [IPv6:2601:646:8600:3281:712b:f1e1:9bde:f93a] ([IPv6:2601:646:8600:3281:712b:f1e1:9bde:f93a])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xBGMMQZs3145404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 16 Dec 2019 14:22:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xBGMMQZs3145404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019111901; t=1576534951;
        bh=Q/x5Honx2iNmbzLmlKpzL+FUqwg+1Ew4FQ7B/PYfbX0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=v8WzNO2hT91tCqhU95rVpQoWOMtQ9PT+cgKUMRK1CIXqwW6WACva270RimBXzYCcS
         PrvxTWMsAiM45ylkjtsj00YYKbSf9PmsupRuwD+K58rElqk3K4i3rn5r71V0zEI3V7
         IVHZ5nzwFkkV7iLrCwRg7iRLdsEm+7Y+xjxPbiia2UTIb7O7i/BtsRW1e/PCJfcfE2
         Yue9CEXVB3EVgRqL99GJ7qfwDa7wpRb1zb/Yt2T+nBVbqi17ygs5wGxHFBK9Edgodw
         UMD2JcqGM+RYM01Y7hMVtu7US+L6EouCcqzPL03lhkXcs2Sg39QcCSfi1UcCGtqbOR
         WF0syetUHRQHQ==
Date:   Mon, 16 Dec 2019 14:22:18 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20191216130933.13254-2-liuzhengyuan@kylinos.cn>
References: <20191216130933.13254-1-liuzhengyuan@kylinos.cn> <20191216130933.13254-2-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, liu.song.a23@gmail.com
CC:     linux-raid@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <752598FD-FD01-430A-AB93-D83B94333198@zytor.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On December 16, 2019 5:09:33 AM PST, Zhengyuan Liu <liuzhengyuan@kylinos=2E=
cn> wrote:
>There are several algorithms available for raid6 to generate xor and
>syndrome
>parity, including basic int1, int2 =2E=2E=2E int32 and SIMD optimized
>implementation
>like sse and neon=2E  To test and choose the best algorithms at the
>initial
>stage, we need provide enough disk data to feed the algorithms=2E
>However, the
>disk number we provided depends on page size and gfmul table, seeing
>bellow:
>
>    const int disks =3D (65536/PAGE_SIZE) + 2;
>
>So when come to 64K PAGE_SIZE, there is only one data disk plus 2
>parity disk,
>as a result the chosed algorithm is not reliable=2E For example, on my
>arm64
>machine with 64K page enabled, it will choose intx32 as the best one,
>although
>the NEON implementation is better=2E
>
>This patch tries to fix the problem by defining a constant raid6 disk
>number to
>supporting arbitrary page size=2E
>
>Suggested-by: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos=2Ecn>
>---
> include/linux/raid/pq=2Eh | 17 +++++++---
> lib/raid6/algos=2Ec       | 71 +++++++++++++++++++++++++++--------------
> 2 files changed, 59 insertions(+), 29 deletions(-)
>
>diff --git a/include/linux/raid/pq=2Eh b/include/linux/raid/pq=2Eh
>index e0ddb47f4402=2E=2E6b68b9590a6b 100644
>--- a/include/linux/raid/pq=2Eh
>+++ b/include/linux/raid/pq=2Eh
>@@ -8,6 +8,8 @@
> #ifndef LINUX_RAID_RAID6_H
> #define LINUX_RAID_RAID6_H
>=20
>+#define RAID6_DISKS 8
>+
> #ifdef __KERNEL__
>=20
> /* Set to 1 to use kernel-wide empty_zero_page */
>@@ -31,6 +33,7 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
> #include <sys/mman=2Eh>
> #include <sys/time=2Eh>
> #include <sys/types=2Eh>
>+#include <string=2Eh>
>=20
> /* Not standard, but glibc defines it */
> #define BITS_PER_LONG __WORDSIZE
>@@ -43,6 +46,9 @@ typedef uint64_t u64;
> #ifndef PAGE_SIZE
> # define PAGE_SIZE 4096
> #endif
>+#ifndef PAGE_SHIFT
>+# define PAGE_SHIFT 12
>+#endif
> extern const char raid6_empty_zero_page[PAGE_SIZE];
>=20
> #define __init
>@@ -168,11 +174,12 @@ void raid6_dual_recov(int disks, size_t bytes,
>int faila, int failb,
> # define pr_err(format, =2E=2E=2E) fprintf(stderr, format, ## __VA_ARGS_=
_)
> # define pr_info(format, =2E=2E=2E) fprintf(stdout, format, ## __VA_ARGS=
__)
> # define GFP_KERNEL	0
>-# define __get_free_pages(x, y)	((unsigned long)mmap(NULL, PAGE_SIZE
><< (y), \
>-						     PROT_READ|PROT_WRITE,   \
>-						     MAP_PRIVATE|MAP_ANONYMOUS,\
>-						     0, 0))
>-# define free_pages(x, y)	munmap((void *)(x), PAGE_SIZE << (y))
>+# define kmalloc(x, y)	((unsigned long)mmap(NULL, (x),
>PROT_READ|PROT_WRITE, \
>+						 MAP_PRIVATE|MAP_ANONYMOUS,   \
>+						 0, 0))
>+# define kfree(x)	munmap((void *)(x), (RAID6_DISKS - 2) * PAGE_SIZE  =20
> \
>+						<=3D 65536 ? 2 * PAGE_SIZE :    \
>+						(RAID6_DISKS - 2) * PAGE_SIZE)
>=20
> static inline void cpu_relax(void)
> {
>diff --git a/lib/raid6/algos=2Ec b/lib/raid6/algos=2Ec
>index 17417eee0866=2E=2E959e6e23aa5f 100644
>--- a/lib/raid6/algos=2Ec
>+++ b/lib/raid6/algos=2Ec
>@@ -146,7 +146,7 @@ static inline const struct raid6_recov_calls
>*raid6_choose_recov(void)
> }
>=20
> static inline const struct raid6_calls *raid6_choose_gen(
>-	void *(*const dptrs)[(65536/PAGE_SIZE)+2], const int disks)
>+	void *(*const dptrs)[RAID6_DISKS], const int disks)
> {
> 	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
>	int start =3D (disks>>1)-1, stop =3D disks-3;	/* work on the second half
>of the disks */
>@@ -181,7 +181,8 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
> 				best =3D *algo;
> 			}
> 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
>-			       (perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
>+				(perf * HZ * (disks-2)) >>
>+				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
>=20
> 			if (!(*algo)->xor_syndrome)
> 				continue;
>@@ -204,17 +205,24 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
> 				bestxorperf =3D perf;
>=20
> 			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
>-				(perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
>+				(perf * HZ * (disks-2)) >>
>+				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
> 		}
> 	}
>=20
> 	if (best) {
>-		pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
>-		       best->name,
>-		       (bestgenperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
>-		if (best->xor_syndrome)
>-			pr_info("raid6: =2E=2E=2E=2E xor() %ld MB/s, rmw enabled\n",
>-			       (bestxorperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
>+		if (IS_ENABLED(CONFIG_RAID6_PQ_BENCHMARK)) {
>+			pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
>+				best->name,
>+				(bestgenperf * HZ * (disks-2)) >>
>+				(20 - PAGE_SHIFT+RAID6_TIME_JIFFIES_LG2));
>+			if (best->xor_syndrome)
>+				pr_info("raid6: =2E=2E=2E=2E xor() %ld MB/s, rmw enabled\n",
>+					(bestxorperf * HZ * (disks-2)) >>
>+					(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
>+		} else
>+			pr_info("raid6: skip pq benchmark and using algorithm %s\n",
>+				best->name);
> 		raid6_call =3D *best;
> 	} else
> 		pr_err("raid6: Yikes!  No algorithm found!\n");
>@@ -228,27 +236,42 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
>=20
> int __init raid6_select_algo(void)
> {
>-	const int disks =3D (65536/PAGE_SIZE)+2;
>+	const int disks =3D RAID6_DISKS;
>=20
> 	const struct raid6_calls *gen_best;
> 	const struct raid6_recov_calls *rec_best;
>-	char *syndromes;
>-	void *dptrs[(65536/PAGE_SIZE)+2];
>-	int i;
>-
>-	for (i =3D 0; i < disks-2; i++)
>-		dptrs[i] =3D ((char *)raid6_gfmul) + PAGE_SIZE*i;
>+	char *alloc_ptr, *p;
>+	void *dptrs[RAID6_DISKS];
>+	int i, cycle;
>+
>+	/*
>+	 * use raid6_gfmul table to fill the RAID6_DISKS-2 page-sized data
>disks
>+	 * if the total disk size is less then raid6_gfmul, just make dptrs
>point
>+	 * to it, otherwise do a dynamic allocation and copy the table
>circularly
>+	 */
>+	if ((disks - 2) * PAGE_SIZE <=3D 65536 ) {
>+		for (i =3D 0; i < disks - 2; i++)
>+			dptrs[i] =3D (char *)raid6_gfmul + PAGE_SIZE * i;
>+
>+		alloc_ptr =3D (char *)kmalloc(2 * PAGE_SIZE, GFP_KERNEL |
>__GFP_NOFAIL);
>+		dptrs[disks-2] =3D alloc_ptr;
>+		dptrs[disks-1] =3D alloc_ptr + PAGE_SIZE;
>+	} else {
>+		alloc_ptr =3D (char *)kmalloc(disks * PAGE_SIZE, GFP_KERNEL |
>__GFP_NOFAIL);
>+		p =3D alloc_ptr;
>+		cycle =3D ((disks - 2) * PAGE_SIZE) / 65536;
>+		for (i =3D 0; i < cycle; i++) {
>+			memcpy(p, raid6_gfmul, 65536);
>+			p +=3D 65536;
>+		}
>=20
>-	/* Normal code - use a 2-page allocation to avoid D$ conflict */
>-	syndromes =3D (void *) __get_free_pages(GFP_KERNEL, 1);
>+		if ((disks - 2) * PAGE_SIZE % 65536)
>+			memcpy(p, raid6_gfmul, (disks - 2) * PAGE_SIZE % 65536);
>=20
>-	if (!syndromes) {
>-		pr_err("raid6: Yikes!  No memory available=2E\n");
>-		return -ENOMEM;
>+		for (i=3D0; i < disks; i++)
>+			dptrs[i] =3D alloc_ptr + PAGE_SIZE * i;
> 	}
>=20
>-	dptrs[disks-2] =3D syndromes;
>-	dptrs[disks-1] =3D syndromes + PAGE_SIZE;
>=20
> 	/* select raid gen_syndrome function */
> 	gen_best =3D raid6_choose_gen(&dptrs, disks);
>@@ -256,7 +279,7 @@ int __init raid6_select_algo(void)
> 	/* select raid recover functions */
> 	rec_best =3D raid6_choose_recov();
>=20
>-	free_pages((unsigned long)syndromes, 1);
>+	kfree(alloc_ptr);
>=20
> 	return gen_best && rec_best ? 0 : -EINVAL;
> }

Don't bother making this two cases=2E The order-3 allocation is actually b=
etter for measurement purposes in all cases, as it had the most predictable=
 cache effects and therefore should be the most deterministic=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
