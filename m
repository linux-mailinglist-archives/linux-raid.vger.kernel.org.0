Return-Path: <linux-raid+bounces-4164-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5190AB2E65
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 06:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22503B16A1
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 04:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA925486F;
	Mon, 12 May 2025 04:41:32 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394A19994F;
	Mon, 12 May 2025 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747024892; cv=none; b=Op8p7iLKPYA0KrHk4RgoZhAzMVimvOSCxC1Yr75Vd1XEEUg3XJM4aam+LA2/YI8OXsm27EJlB36H6vi2txFT/zterhEovzWtzFEqld5AYbOLiA2fT/JgwFsA9FFTendL/frCGhy3ewtJTupa7V+EdKPXL9kx1BMSB/YsYy9cAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747024892; c=relaxed/simple;
	bh=CLWRvYmr8i5bmmD42vYBLHjNSn3G/RUEV0znpj+CkE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCPTOEHQADtvB9f8V0oXG8lST3LPQPOvuBQneNPFHbldlhKfdN1sK67mUZJ7fCtkpSDMNvWEzQsfjaFqhoJdzsJ46q6PIuZh2eMUhlH/s6utP1+xEQAnNV5IOYcZtL4EiMRP72OH//XB7gLLD99OPfMoaU+JS/y1fp7DslFq/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1A4A68AA6; Mon, 12 May 2025 06:41:25 +0200 (CEST)
Date: Mon, 12 May 2025 06:41:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, xni@redhat.com, colyli@kernel.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
	yukuai3@huawei.com, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC md-6.16 v3 02/19] md: support discard for bitmap ops
Message-ID: <20250512044125.GB868@lst.de>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com> <20250512011927.2809400-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512011927.2809400-3-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 12, 2025 at 09:19:10AM +0800, Yu Kuai wrote:
> +++ b/drivers/md/md.c
> @@ -8849,14 +8849,24 @@ static void md_bitmap_start(struct mddev *mddev,
>  		mddev->pers->bitmap_sector(mddev, &md_io_clone->offset,
>  					   &md_io_clone->sectors);
>  
> -	mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
> -				      md_io_clone->sectors);
> +	if (unlikely(md_io_clone->rw == STAT_DISCARD) &&
> +	    mddev->bitmap_ops->start_discard)
> +		mddev->bitmap_ops->start_discard(mddev, md_io_clone->offset,
> +						 md_io_clone->sectors);
> +	else
> +		mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
> +					      md_io_clone->sectors);
>  }

This interface feels weird, as it would still call into the write
interfaces when the discard ones are not defined instead of doing
nothing.  Also shouldn't discard also use a different interface
than md_bitmap_start in the caller?

I'd also expect the final version of this to be merged with the
previous patch, as adding an interface without the only user is a
bit odd.

