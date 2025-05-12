Return-Path: <linux-raid+bounces-4194-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB8AB3931
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E195A86405F
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82772295D9D;
	Mon, 12 May 2025 13:27:57 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0E2951DE;
	Mon, 12 May 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056477; cv=none; b=mkKeeA7ARWrxzd0mPsawuR9OJVQv6p7yi9ORnQWjcUWYsahKJbPlOUDeieN4QNismVVETArTRZn5NoB2rUtqTN+ikfsEOxJDDAbKHsTIuLBXM+oAupw8y4tYgxA7Fkg3/2Xwn21HQ337Shfxtx6ZoSS8Ol10u72PmveFqrnPbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056477; c=relaxed/simple;
	bh=pFkVtGA8tP5NHa+hnHRPJU5wW1TUgmdbF1IQlpwGv2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myLToahoukjEo+s1rB9sqSUMvc69DCgdm6NZLYbFnbACDDEarLYu5gb6Dq/NGQPhV0WLgA0kJJbENFgK8lL09YCU8hf6v97qsuy6QKAcV5AR+gtbW965r/bzNUS/QB1EMDD19/WzOpYG3Ci94H9ojwBHGAPT4tITiv0wzXqMSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16D8F68B05; Mon, 12 May 2025 15:27:52 +0200 (CEST)
Date: Mon, 12 May 2025 15:27:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, xni@redhat.com, colyli@kernel.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC md-6.16 v3 00/19] md: introduce a new lockless
 bitmap
Message-ID: <20250512132750.GD31781@lst.de>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com> <20250512052118.GA1796@lst.de> <6aeecf3e-2f24-7d30-8462-c8d30b197740@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aeecf3e-2f24-7d30-8462-c8d30b197740@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 12, 2025 at 04:40:02PM +0800, Yu Kuai wrote:
> I don't have such plan for now, actually I tend to remove bitmap file,
> once llbitmap is ready with lightweight overhead, I expect perforamce
> can be better than old bitmap with bitmap file.
>
> If there are cases that llbitmap performace is still much worse than
> none bitmap, and bitmap file can reduce the gap, we'll probable think
> about bitmap file again.

I'd really love to see this replace the old code as soon as possible.
But can we simply drop support for users with the bitmap in a file
in the file system (no matter how much I dislike that use case..)?


