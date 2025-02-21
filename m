Return-Path: <linux-raid+bounces-3727-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9CA3F188
	for <lists+linux-raid@lfdr.de>; Fri, 21 Feb 2025 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B7F423C54
	for <lists+linux-raid@lfdr.de>; Fri, 21 Feb 2025 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECF204F8E;
	Fri, 21 Feb 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="g482ex5v"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail94.out.titan.email (mail94.out.titan.email [54.235.81.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFA204C02
	for <linux-raid@vger.kernel.org>; Fri, 21 Feb 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.235.81.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132658; cv=none; b=f75qT/Em/nmjmTEAhCDMOvI/K6atrfoGmrJftPJ/MXrd0Vo+4ytOtPmWxO4jjCm17OvYiU3Mg8niCt4/nWFVbkbH1iFrR8oDMGMQeaDxCo84tsox9lJm0vdl1swiXUt7tL606GHrFicNKUHThAz92R05qin5ptBmNJfgn0kb+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132658; c=relaxed/simple;
	bh=liz61iMC2dN+NGZ2MuvcUbLugzJeLLt6ts5YA7v4yfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NypQcuYkXYNx5xNHnstjPcsoDrjZ9L1P6MT5Pa63txf8MjUlDNDx8RL/tXzMKnYTDaFDHVvB5Hq9l/WRQyJRy75sm78bvZJN75UZR1yAxqChKG+kNcbTcBjeCiTO9wEDKXGTVV9BIhWRr4jniKpF3T6t3POAfcSjgfp53v84ILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=g482ex5v; arc=none smtp.client-ip=54.235.81.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
DKIM-Signature: a=rsa-sha256; bh=NJF/4Q5i/hO0u3nwWRv/Ok82S5dpU6jme2vhYIxvsto=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:subject:references:to:message-id:in-reply-to:date:from:cc:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1740131535; v=1;
	b=g482ex5vnAdoSbH9pyNapbsiini2QP+277DSiMoYx65/+O86FCpgXdSI6GgmNvPMd3fPzJ5s
	CYSX69rkl4j5YlLV5f95lxM7mCeFjAGCFBPgToVHLUhdgqr1o8ZjMaxN/sNULmRocT2lTnIlmln
	HII4VrcIvGtPZ/GI+2koJu4A=
Received: from studio.local (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id E3D87100156;
	Fri, 21 Feb 2025 09:52:07 +0000 (UTC)
Date: Fri, 21 Feb 2025 17:52:05 +0800
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, song@kernel.org, colyli@kernel.org, 
	yukuai3@huawei.com, dan.j.williams@intel.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, ira.weiny@intel.com, dlemoal@kernel.org, yanjun.zhu@linux.dev, 
	kch@nvidia.com, hare@suse.de, zhengqixing@huawei.com, john.g.garry@oracle.com, 
	geliang@kernel.org, xni@redhat.com, colyli@suse.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 05/12] badblocks: return error if any badblock set fails
Message-ID: <4qo5qliidycbjmauq22tqgv6nbw2dus2xlhg2qvfss7nawdr27@arztxmrwdhzb>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-6-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221081109.734170-6-zhengqixing@huaweicloud.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1740131535703117256.29396.5359946764536724318@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=bq22BFai c=1 sm=1 tr=0 ts=67b84ccf
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=i0EeH86SAAAA:8
	a=7AGAggHtapFrYZIn-HwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Fri, Feb 21, 2025 at 04:11:02PM +0800, Zheng Qixing wrote:
> From: Li Nan <linan122@huawei.com>
> 
> _badblocks_set() returns success if at least one badblock is set
> successfully, even if others fail. This can lead to data inconsistencies
> in raid, where a failed badblock set should trigger the disk to be kicked
> out to prevent future reads from failed write areas.
> 
> _badblocks_set() should return error if any badblock set fails. Instead
> of relying on 'rv', directly returning 'sectors' for clearer logic. If all
> badblocks are successfully set, 'sectors' will be 0, otherwise it
> indicates the number of badblocks that have not been set yet, thus
> signaling failure.
> 
> By the way, it can also fix an issue: when a newly set unack badblock is
> included in an existing ack badblock, the setting will return an error.
> ···
>   echo "0 100" /sys/block/md0/md/dev-loop1/bad_blocks
>   echo "0 100" /sys/block/md0/md/dev-loop1/unacknowledged_bad_blocks
>   -bash: echo: write error: No space left on device
> ```
> After fix, it will return success.
> 
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/badblocks.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>

NACK.   Such modification will break current API.

Current API doesn’t handle partial success/fail condition, if any bad block range is set it should return true.

It is not about correct or wrong, just current fragile design. A new API is necessary to handle such thing. This is why I leave the return value as int other than bool.

Thanks.

Coly Li


 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 1c8b8f65f6df..a953d2e9417f 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -843,7 +843,6 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  	struct badblocks_context bad;
>  	int prev = -1, hint = -1;
>  	unsigned long flags;
> -	int rv = 0;
>  	u64 *p;
>  
>  	if (bb->shift < 0)
> @@ -873,10 +872,8 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  	bad.len = sectors;
>  	len = 0;
>  
> -	if (badblocks_full(bb)) {
> -		rv = 1;
> +	if (badblocks_full(bb))
>  		goto out;
> -	}
>  
>  	if (badblocks_empty(bb)) {
>  		len = insert_at(bb, 0, &bad);
> @@ -916,10 +913,8 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  			int extra = 0;
>  
>  			if (!can_front_overwrite(bb, prev, &bad, &extra)) {
> -				if (extra > 0) {
> -					rv = 1;
> +				if (extra > 0)
>  					goto out;
> -				}
>  
>  				len = min_t(sector_t,
>  					    BB_END(p[prev]) - s, sectors);
> @@ -986,10 +981,7 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  
>  	write_sequnlock_irqrestore(&bb->lock, flags);
>  
> -	if (!added)
> -		rv = 1;
> -
> -	return rv;
> +	return sectors;
>  }
>  
>  /*
> @@ -1353,7 +1345,7 @@ EXPORT_SYMBOL_GPL(badblocks_check);
>   *
>   * Return:
>   *  0: success
> - *  1: failed to set badblocks (out of space)
> + *  other: failed to set badblocks (out of space)
>   */
>  int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  			int acknowledged)
> -- 
> 2.39.2
> 

-- 
Coly Li

