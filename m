Return-Path: <linux-raid+bounces-4535-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B0AF75BA
	for <lists+linux-raid@lfdr.de>; Thu,  3 Jul 2025 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A403A6FFD
	for <lists+linux-raid@lfdr.de>; Thu,  3 Jul 2025 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEB2E11C8;
	Thu,  3 Jul 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4GLa+z6"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10B13B284
	for <linux-raid@vger.kernel.org>; Thu,  3 Jul 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549523; cv=none; b=Sro/hgEyYml8hCdHuR8NrrVDoFzY0AoxVoDETFjM/HbuRUHkOcxKpc4jgV3gAYVlLFlRdHOSDHgzRSAj/owGD+wIdhCUngRUqxombkz0OcQOHsNf7Ggv5uYSMOHHNmfvwm75Q/+4ReSrV5IFE0/kHxk947Oy1faMRDkkAegvds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549523; c=relaxed/simple;
	bh=E3zl3JlTcUvkMOfQKaAv3OEvjsXihZEQPL6HCN5dX4Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TVNPyBraEzIMC2xZGofgz+/wnGT1dcBM1s3nT+F/jtneUX5eytVRcQJz8BGVdx+ZQAuJZdPnISi+ORpAM0wYRyeqGMnXbn9+b+73aZilho6d9ESQ1l5EAkAyGA9DP0E31cPHBJWeTbbcpDabJK/XRzWoly31Nudw440J9VVU8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4GLa+z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751549520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eb9rq/dtwcKs6bXZz1FoAbty3bM70V3VKzsjZ5KCP6k=;
	b=i4GLa+z6bG6N2O6NVUWyDBW+0EW5KEE+m+be1nJNuabj5bfWjSs2zrGI69LVYsZTN7QSyz
	qyEyzsWO360/jArDsEbTzCi5RosDbHYaRZeyZbcb3E+3tv1coXNFmRgHNP9SoFTVZlOWpc
	QJ6h9U9PpIZJN3LPVvs5nzGQ4gkg0ow=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-6804ib-WNCu0eoN3qdyCUQ-1; Thu,
 03 Jul 2025 09:31:56 -0400
X-MC-Unique: 6804ib-WNCu0eoN3qdyCUQ-1
X-Mimecast-MFC-AGG-ID: 6804ib-WNCu0eoN3qdyCUQ_1751549511
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A05D719560B9;
	Thu,  3 Jul 2025 13:31:50 +0000 (UTC)
Received: from [10.22.80.10] (unknown [10.22.80.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DC6B3000218;
	Thu,  3 Jul 2025 13:31:45 +0000 (UTC)
Date: Thu, 3 Jul 2025 15:31:38 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: John Garry <john.g.garry@oracle.com>
cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, song@kernel.org, 
    yukuai3@huawei.com, hch@lst.de, nilay@linux.ibm.com, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
    ojaswin@linux.ibm.com, martin.petersen@oracle.com
Subject: Re: [PATCH v3 5/5] block: use chunk_sectors when evaluating stacked
 atomic write limits
In-Reply-To: <20250703114613.9124-6-john.g.garry@oracle.com>
Message-ID: <b7bd63a0-7aa6-2fb3-0a2b-23285b9fc5fc@redhat.com>
References: <20250703114613.9124-1-john.g.garry@oracle.com> <20250703114613.9124-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Thu, 3 Jul 2025, John Garry wrote:

> The atomic write unit max value is limited by any stacked device stripe
> size.
> 
> It is required that the atomic write unit is a power-of-2 factor of the
> stripe size.
> 
> Currently we use io_min limit to hold the stripe size, and check for a
> io_min <= SECTOR_SIZE when deciding if we have a striped stacked device.
> 
> Nilay reports that this causes a problem when the physical block size is
> greater than SECTOR_SIZE [0].
> 
> Furthermore, io_min may be mutated when stacking devices, and this makes
> it a poor candidate to hold the stripe size. Such an example (of when
> io_min may change) would be when the io_min is less than the physical
> block size.
> 
> Use chunk_sectors to hold the stripe size, which is more appropriate.
> 
> [0] https://lore.kernel.org/linux-block/888f3b1d-7817-4007-b3b3-1a2ea04df771@linux.ibm.com/T/#mecca17129f72811137d3c2f1e477634e77f06781
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-settings.c | 51 +++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 7ca21fb32598..20d3563f5d3f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -596,41 +596,47 @@ static bool blk_stack_atomic_writes_boundary_head(struct queue_limits *t,
>  	return true;
>  }
>  
> +static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
> +{
> +	return 1 << (ffs(nr) - 1);

This could be changed to "nr & -nr".

> +}
>  
> -/* Check stacking of first bottom device */
> -static bool blk_stack_atomic_writes_head(struct queue_limits *t,
> -				struct queue_limits *b)
> +static void blk_stack_atomic_writes_chunk_sectors(struct queue_limits *t)
>  {
> -	if (b->atomic_write_hw_boundary &&
> -	    !blk_stack_atomic_writes_boundary_head(t, b))
> -		return false;
> +	unsigned int chunk_bytes = t->chunk_sectors << SECTOR_SHIFT;

What about integer overflow?

> -	if (t->io_min <= SECTOR_SIZE) {
> -		/* No chunk sectors, so use bottom device values directly */
> -		t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
> -		t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
> -		t->atomic_write_hw_max = b->atomic_write_hw_max;
> -		return true;
> -	}
> +	if (!t->chunk_sectors)
> +		return;
>  
>  	/*
>  	 * Find values for limits which work for chunk size.
>  	 * b->atomic_write_hw_unit_{min, max} may not be aligned with chunk
> -	 * size (t->io_min), as chunk size is not restricted to a power-of-2.
> +	 * size, as the chunk size is not restricted to a power-of-2.
>  	 * So we need to find highest power-of-2 which works for the chunk
>  	 * size.
> -	 * As an example scenario, we could have b->unit_max = 16K and
> -	 * t->io_min = 24K. For this case, reduce t->unit_max to a value
> -	 * aligned with both limits, i.e. 8K in this example.
> +	 * As an example scenario, we could have t->unit_max = 16K and
> +	 * t->chunk_sectors = 24KB. For this case, reduce t->unit_max to a
> +	 * value aligned with both limits, i.e. 8K in this example.
>  	 */
> -	t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
> -	while (t->io_min % t->atomic_write_hw_unit_max)
> -		t->atomic_write_hw_unit_max /= 2;
> +	t->atomic_write_hw_unit_max = min(t->atomic_write_hw_unit_max,
> +					max_pow_of_two_factor(chunk_bytes));
>  
> -	t->atomic_write_hw_unit_min = min(b->atomic_write_hw_unit_min,
> +	t->atomic_write_hw_unit_min = min(t->atomic_write_hw_unit_min,
>  					  t->atomic_write_hw_unit_max);
> -	t->atomic_write_hw_max = min(b->atomic_write_hw_max, t->io_min);
> +	t->atomic_write_hw_max = min(t->atomic_write_hw_max, chunk_bytes);
> +}
>  
> +/* Check stacking of first bottom device */
> +static bool blk_stack_atomic_writes_head(struct queue_limits *t,
> +				struct queue_limits *b)
> +{
> +	if (b->atomic_write_hw_boundary &&
> +	    !blk_stack_atomic_writes_boundary_head(t, b))
> +		return false;
> +
> +	t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
> +	t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
> +	t->atomic_write_hw_max = b->atomic_write_hw_max;
>  	return true;
>  }
>  
> @@ -658,6 +664,7 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
>  
>  	if (!blk_stack_atomic_writes_head(t, b))
>  		goto unsupported;
> +	blk_stack_atomic_writes_chunk_sectors(t);
>  	return;
>  
>  unsupported:
> -- 
> 2.43.5
> 


