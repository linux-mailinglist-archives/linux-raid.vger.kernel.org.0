Return-Path: <linux-raid+bounces-4167-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B67AB2E7E
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 06:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D6A3B30B3
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DF254AE5;
	Mon, 12 May 2025 04:53:12 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E92576;
	Mon, 12 May 2025 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747025592; cv=none; b=lxV+NmV6AzImLJS45jJky+GwS+4v6D7qqoSh9/vXXjV0wbKb8mvJLg/ihdyxCO5kfX5swDG8PIDdyGp+Rr6Ei/ZF2u64TFS2Er7Qy3AcF/V4KZLvb90NIOF36Lp/XDuGPb6n+oj3N8PZqQayXIcz9WjH8mApkyx4p3sYzNbyIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747025592; c=relaxed/simple;
	bh=chHQpT1jXvvo2kZTPmgo7wv8RxYhHr1NxQIh72EGnX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI7jotRfXt9sfveBtDzfBsL5DJJrvWUVOtHbH+68nQ5p4a53hJHWu36TCkM7Dzr83QMz5irUdIwbfo2Wxhh54uRc19BiVr6WAAUOKgLn7ZeA9IJl66IX+PxMjMdHrRqHbZBa/iagUvYT/sWWnnv3VIQGGg7vRW/tmShEmc1CibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F41D968AA6; Mon, 12 May 2025 06:53:06 +0200 (CEST)
Date: Mon, 12 May 2025 06:53:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, xni@redhat.com, colyli@kernel.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
	yukuai3@huawei.com, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC md-6.16 v3 05/19] md: delay registration of
 bitmap_ops until creating bitmap
Message-ID: <20250512045306.GE868@lst.de>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com> <20250512011927.2809400-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512011927.2809400-6-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	head = xa_load(&md_submodule, mddev->bitmap_id);
>  	xa_unlock(&md_submodule);
> -	if (!mddev->bitmap_ops)
> -		pr_warn_once("md: can't find bitmap id %d\n", mddev->bitmap_id);
> +
> +	if (WARN_ON_ONCE(!head || head->type != MD_BITMAP)) {
> +		pr_err("md: can't find bitmap id %d\n", mddev->bitmap_id);
> +		return;
> +	}

This needs a real error return, doesn't it?


