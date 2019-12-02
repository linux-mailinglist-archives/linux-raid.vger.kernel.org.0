Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC310F23D
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 22:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLBVg6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 16:36:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48421 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfLBVg6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Dec 2019 16:36:58 -0500
Received: from [IPv6:2601:646:8600:3281:f10d:70bd:db2c:381] ([IPv6:2601:646:8600:3281:f10d:70bd:db2c:381])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xB2KcvsZ1160546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 2 Dec 2019 12:39:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xB2KcvsZ1160546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019111901; t=1575319140;
        bh=QmDLvxeTzoSmY00XOdeXTcG5soYJtdxquQnN8D04ZNE=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=Pz9A6KJYcCPFGXczfhb7Kzq/JRCkvSmRTOP87+2XEQ0+zP6TL31W5M11vbev8C+Fd
         fquvbBVebAgux2vzqNo8L03QFCT/yu3UcPHIqcGGhv+X4LQi85wzHds9a5aTw35dR/
         yKd4+xo9qVwOO4znLKZKG83GGh9kbvQt48lH1pK+d38swgfNlqc8mhBN6zWKqQ1MLh
         pMEWZEHxtToo8ZToToITcBwq5yML7+J/7B1UoB5qQv2fEZDnOc/rpfo03nBourFLoL
         g5CU2CljwFqh7AKs0S38To0ixyImC0O0MDzJ51EuO0WD3TAVQYkJKGQUhufIcZRXGO
         8X4n2XSV6g4OA==
Date:   Mon, 02 Dec 2019 12:38:48 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <1574759811-11360-1-git-send-email-liuzhengyuan@kylinos.cn>
References: <1574759811-11360-1-git-send-email-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, liu.song.a23@gmail.com,
        linux-raid@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <F24D09C5-8413-479B-93A0-D15E6BEE545A@zytor.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On November 26, 2019 1:16:51 AM PST, Zhengyuan Liu <liuzhengyuan@kylinos=2E=
cn> wrote:
>For raid6, we need at least 4 disks to calculate the best algorithm=2E
>But, currently we assume we are always under 4k PAGE_SIZE, when come
>to larger page size, such as 64K, we may get a wrong xor() and gen()=2E
>
>This patch tries to fix the problem by supporting arbitrarily page
>size=2E
>
>Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos=2Ecn>
>---
> lib/raid6/algos=2Ec | 25 +++++++++++++++----------
> 1 file changed, 15 insertions(+), 10 deletions(-)
>
>diff --git a/lib/raid6/algos=2Ec b/lib/raid6/algos=2Ec
>index 17417ee=2E=2E0df7d99 100644
>--- a/lib/raid6/algos=2Ec
>+++ b/lib/raid6/algos=2Ec
>@@ -118,6 +118,7 @@ const struct raid6_recov_calls *const
>raid6_recov_algos[] =3D {
>=20
> #ifdef __KERNEL__
> #define RAID6_TIME_JIFFIES_LG2	4
>+#define RAID6_DATA_BLOCK_LEN	4096
> #else
> /* Need more time to be stable in userspace */
> #define RAID6_TIME_JIFFIES_LG2	9
>@@ -146,7 +147,7 @@ static inline const struct raid6_recov_calls
>*raid6_choose_recov(void)
> }
>=20
> static inline const struct raid6_calls *raid6_choose_gen(
>-	void *(*const dptrs)[(65536/PAGE_SIZE)+2], const int disks)
>+	void *(*const dptrs)[(65536/RAID6_DATA_BLOCK_LEN)+2], const int
>disks)
> {
> 	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
>	int start =3D (disks>>1)-1, stop =3D disks-3;	/* work on the second half
>of the disks */
>@@ -171,7 +172,7 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
> 				cpu_relax();
> 			while (time_before(jiffies,
> 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
>-				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
>+				(*algo)->gen_syndrome(disks, RAID6_DATA_BLOCK_LEN, *dptrs);
> 				perf++;
> 			}
> 			preempt_enable();
>@@ -181,7 +182,8 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
> 				best =3D *algo;
> 			}
> 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
>-			       (perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
>+			       (perf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) >> \
>+						(20+RAID6_TIME_JIFFIES_LG2));
>=20
> 			if (!(*algo)->xor_syndrome)
> 				continue;
>@@ -195,7 +197,7 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
> 			while (time_before(jiffies,
> 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
> 				(*algo)->xor_syndrome(disks, start, stop,
>-						      PAGE_SIZE, *dptrs);
>+						      RAID6_DATA_BLOCK_LEN, *dptrs);
> 				perf++;
> 			}
> 			preempt_enable();
>@@ -204,17 +206,20 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
> 				bestxorperf =3D perf;
>=20
> 			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
>-				(perf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
>+				(perf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) >> \
>+						(20+RAID6_TIME_JIFFIES_LG2+1));
> 		}
> 	}
>=20
> 	if (best) {
> 		pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
> 		       best->name,
>-		       (bestgenperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
>+		       (bestgenperf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) >> \
>+						(20+RAID6_TIME_JIFFIES_LG2));
> 		if (best->xor_syndrome)
> 			pr_info("raid6: =2E=2E=2E=2E xor() %ld MB/s, rmw enabled\n",
>-			       (bestxorperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2+1));
>+			       (bestxorperf*HZ*RAID6_DATA_BLOCK_LEN*(disks-2)) \
>+						>> (20+RAID6_TIME_JIFFIES_LG2+1));
> 		raid6_call =3D *best;
> 	} else
> 		pr_err("raid6: Yikes!  No algorithm found!\n");
>@@ -228,16 +233,16 @@ static inline const struct raid6_calls
>*raid6_choose_gen(
>=20
> int __init raid6_select_algo(void)
> {
>-	const int disks =3D (65536/PAGE_SIZE)+2;
>+	const int disks =3D (65536/RAID6_DATA_BLOCK_LEN)+2;
>=20
> 	const struct raid6_calls *gen_best;
> 	const struct raid6_recov_calls *rec_best;
> 	char *syndromes;
>-	void *dptrs[(65536/PAGE_SIZE)+2];
>+	void *dptrs[(65536/RAID6_DATA_BLOCK_LEN)+2];
> 	int i;
>=20
> 	for (i =3D 0; i < disks-2; i++)
>-		dptrs[i] =3D ((char *)raid6_gfmul) + PAGE_SIZE*i;
>+		dptrs[i] =3D ((char *)raid6_gfmul) + RAID6_DATA_BLOCK_LEN*i;
>=20
> 	/* Normal code - use a 2-page allocation to avoid D$ conflict */
> 	syndromes =3D (void *) __get_free_pages(GFP_KERNEL, 1);

32K, not 4K; it assumes 64K is enough for at least two "disks"=2E

However, as you point out here, there really isn't any particular reason t=
o not just use a 4K chunk for the benchmark; no need to spend a bunch of ex=
tra time=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
