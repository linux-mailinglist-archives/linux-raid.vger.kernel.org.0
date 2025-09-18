Return-Path: <linux-raid+bounces-5055-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B1B3C688
	for <lists+linux-raid@lfdr.de>; Sat, 30 Aug 2025 02:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B437B1A5C
	for <lists+linux-raid@lfdr.de>; Sat, 30 Aug 2025 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A881D54FE;
	Sat, 30 Aug 2025 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVhF40ak"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AB26281;
	Sat, 30 Aug 2025 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514585; cv=none; b=ez2B4R9XPF++4bJC7NnzLNdZwZFRRsYNiBJztMePpSfKpb5Zv/PUMYyizDfNwh0k/kjyjTxOWzFnScEd2L0pM2dw7QKB1GV5DAu69gCXD/xdOUhFhzsOgQre+l0+dqqP2A7elePQ4frOKuL2EhJz9Eb3Osk2VK/16YikdaWRp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514585; c=relaxed/simple;
	bh=DD4FzY9kB732yl8oAeAaz9W64KNMbY6VOB2+l+zLDBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfW2l8I0jDWY6IlrYTbxRLf5da0UcTeMpCVfc9IRyB/2QqWxu1Du2UGGPDdipElKzMCIK3tjm6pzv53SfqU0LqeXJJvCs7TWe5UFvO02nVzUk3EK4OHsHXZY9wTac7OWuEdxJbWH5+z7amq/RcDNA10rBF49ivROpbQLFCfRvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVhF40ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9282EC4CEF0;
	Sat, 30 Aug 2025 00:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756514585;
	bh=DD4FzY9kB732yl8oAeAaz9W64KNMbY6VOB2+l+zLDBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mVhF40akOX/ftOmlglOqo9DnF92DgSJz/GWKFlUmWIk5GyK30/bAvJi93bDbxUcEY
	 bLcZ/rKJASvlJl2jtavo7mRnvXgpePv6UfTjwE4V/BoywQwV/5v/EiCggf1X7eSsYD
	 ESh9FdgvdQe/zv0N3YAkSQwZA7BZSx69lvQ2L2UGK0sujwUkVRKfLkk1E5T3yqBKbD
	 Lt0K0aWXCvJbqqRsbHlb1rzVL2NQS29CPMdCh0TWMnJ93kvxfH7zCFBL5y70I9Egj6
	 wIZ6v346jt4c7fI0KCwBq0Az3oL6PXcw8rz+utxAvYhsL9TSdHkrA8dXKYmWjXGo5D
	 9LMGjSok2cmtA==
Message-ID: <4d1d0689-d2f6-4034-8549-ac700776112b@kernel.org>
Date: Sat, 30 Aug 2025 09:43:01 +0900
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 03/10] md/raid1: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 15:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> On the one hand unify bio split code, prepare to fix disordered split
> IO; On the other hand fix missing blkcg_bio_issue_init() and
> trace_block_split() for split IO.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
> index d236ef179cfb..64548057583b 100644
> --- a/drivers/md/raid1.h
> +++ b/drivers/md/raid1.h
> @@ -178,7 +178,9 @@ enum r1bio_state {
>   * any write was successful.  Otherwise we call when
>   * any write-behind write succeeds, otherwise we call
>   * with failure when last write completes (and all failed).
> - * Record that bi_end_io was called with this flag...
> + *
> + * And for bio_split errors, record that bi_end_io was called with
> + * this flag...

Nit: s/.../.

>   */
>  	R1BIO_Returned,
>  /* If a write for this request means we can clear some


-- 
Damien Le Moal
Western Digital Research

