Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5894C481BC0
	for <lists+linux-raid@lfdr.de>; Thu, 30 Dec 2021 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhL3LdW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Dec 2021 06:33:22 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35505 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239049AbhL3LdW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 Dec 2021 06:33:22 -0500
Received: from [192.168.0.3] (ip5f5aeaad.dynamic.kabel-deutschland.de [95.90.234.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C9BDD61E6478B;
        Thu, 30 Dec 2021 12:33:20 +0100 (CET)
Message-ID: <71f0f9ea-1431-a10c-084b-a956a5b9de2f@molgen.mpg.de>
Date:   Thu, 30 Dec 2021 12:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] Skip benchmarking of non-best xor_syndrome functions
Content-Language: en-US
To:     =?UTF-8?Q?Dirk_M=c3=bcller?= <dmueller@suse.de>
References: <20211229223407.11647-1-dmueller@suse.de>
Cc:     linux-raid@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211229223407.11647-1-dmueller@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Dirk,


Am 29.12.21 um 23:34 schrieb Dirk Müller:
> In commit fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
> a xor_syndrome() has been added for optimized syndrome calculation and

was added

> being added also to to the raid6_choose_gen() function. However, the > result of the xor_syndrome() benchmarking was intentionally discarded

s/to to/to/

> and did not influence the choice.
> 
> We can optimize raid6_choose_gen() without changing its behavior by
> only benchmarking the chosen xor_syndrome() variant and printing it

it*s*

> output, rather than benchmarking also the ones that are discarded and
> never influence the outcome.
> 
> For x86_64, this removes 8 out of 18 benchmark loops which each take
> 16 jiffies, so up to 160 jiffies saved on module load (640ms on a 250HZ
> kernel).

On what system?

The new message below is logged?

     raid6: skipped pq benchmark and selected …

I am booting my non-RAID systems with `cryptomgr.notests` to avoid this 
boot time penalty.

> Signed-off-by: Dirk Müller <dmueller@suse.de>
> ---
>   lib/raid6/algos.c | 76 +++++++++++++++++++++++------------------------
>   1 file changed, 37 insertions(+), 39 deletions(-)
> 
> diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
> index 6d5e5000fdd7..889033b7fc0d 100644
> --- a/lib/raid6/algos.c
> +++ b/lib/raid6/algos.c
> @@ -145,12 +145,12 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
>   static inline const struct raid6_calls *raid6_choose_gen(
>   	void *(*const dptrs)[RAID6_TEST_DISKS], const int disks)
>   {
> -	unsigned long perf, bestgenperf, bestxorperf, j0, j1;
> +	unsigned long perf, bestgenperf, j0, j1;
>   	int start = (disks>>1)-1, stop = disks-3;	/* work on the second half of the disks */
>   	const struct raid6_calls *const *algo;
>   	const struct raid6_calls *best;
>   
> -	for (bestgenperf = 0, bestxorperf = 0, best = NULL, algo = raid6_algos; *algo; algo++) {
> +	for (bestgenperf = 0, best = NULL, algo = raid6_algos; *algo; algo++) {
>   		if (!best || (*algo)->prefer >= best->prefer) {
>   			if ((*algo)->valid && !(*algo)->valid())
>   				continue;
> @@ -180,50 +180,48 @@ static inline const struct raid6_calls *raid6_choose_gen(
>   			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
>   				(perf * HZ * (disks-2)) >>
>   				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
> +		}

In the diff, I do not see the corresponding removed }.

> +	}
>   
> -			if (!(*algo)->xor_syndrome)
> -				continue;
> +	if (best == NULL) {
> +		pr_err("raid6: Yikes! No algorithm found!\n");
> +		goto out;
> +	}
>   
> -			perf = 0;
> +	raid6_call = *best;
>   
> -			preempt_disable();
> -			j0 = jiffies;
> -			while ((j1 = jiffies) == j0)
> -				cpu_relax();
> -			while (time_before(jiffies,
> -					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
> -				(*algo)->xor_syndrome(disks, start, stop,
> -						      PAGE_SIZE, *dptrs);
> -				perf++;
> -			}
> -			preempt_enable();
> -
> -			if (best == *algo)
> -				bestxorperf = perf;
> +	if (!IS_ENABLED(CONFIG_RAID6_PQ_BENCHMARK)) {
> +		pr_info("raid6: skipped pq benchmark and selected %s\n",
> +			best->name);
> +		goto out;
> +	}
>   
> -			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
> -				(perf * HZ * (disks-2)) >>
> -				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
> +	pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
> +		best->name,
> +		(bestgenperf * HZ * (disks-2)) >>
> +		(20 - PAGE_SHIFT+RAID6_TIME_JIFFIES_LG2));
> +
> +	if (best->xor_syndrome) {
> +		perf = 0;
> +
> +		preempt_disable();
> +		j0 = jiffies;
> +		while ((j1 = jiffies) == j0)
> +			cpu_relax();
> +		while (time_before(jiffies,
> +				   j1 + (1 << RAID6_TIME_JIFFIES_LG2))) {
> +			best->xor_syndrome(disks, start, stop,
> +					   PAGE_SIZE, *dptrs);
> +			perf++;
>   		}
> -	}
> +		preempt_enable();
>   
> -	if (best) {
> -		if (IS_ENABLED(CONFIG_RAID6_PQ_BENCHMARK)) {
> -			pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
> -				best->name,
> -				(bestgenperf * HZ * (disks-2)) >>
> -				(20 - PAGE_SHIFT+RAID6_TIME_JIFFIES_LG2));
> -			if (best->xor_syndrome)
> -				pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
> -					(bestxorperf * HZ * (disks-2)) >>
> -					(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
> -		} else
> -			pr_info("raid6: skip pq benchmark and using algorithm %s\n",
> -				best->name);
> -		raid6_call = *best;
> -	} else
> -		pr_err("raid6: Yikes!  No algorithm found!\n");
> +		pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
> +			(perf * HZ * (disks-2)) >>
> +			(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
> +	}
>   
> +out:
>   	return best;
>   }
>   


Kind regards,

Paul
