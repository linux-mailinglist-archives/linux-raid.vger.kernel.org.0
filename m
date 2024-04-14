Return-Path: <linux-raid+bounces-1259-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F5789BAD3
	for <lists+linux-raid@lfdr.de>; Mon,  8 Apr 2024 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780E62813AF
	for <lists+linux-raid@lfdr.de>; Mon,  8 Apr 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4D38FB9;
	Mon,  8 Apr 2024 08:47:45 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851383A8D0;
	Mon,  8 Apr 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566065; cv=none; b=lh2/vPO+d7MhbTGLC2suZSGnRxlPAQvh4zaTi44fmEQtryp7treXzlqr3PSY53fyJAR44r0XcfluLcMGFp4KEaqsC91H/aPcE0VK0udnWIoA5uAo+xTyCYS4p5Tx3vuB88NHwvLbUFCOkSuXI/Re+e3EJpVy7wbm9Uhu427s7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566065; c=relaxed/simple;
	bh=EG5Qh33XnWG8sBga4neJsOEyn5ZwoQ65oB2l+dt0hMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8wFyq1mIJ0Z6F8BhlbItIGEZLbMQ/nZJVr3NE95POzPkNiE+b1Hji4UVfolrAd9QdoqgbjxK758MxQJTHpgr3WklBLaMkE1r0Z05U/3BTxYVlTwakswN/ptHWzp7mqkbkM6ezWz9kM1zBeViZuWC+4rV5K92RiPg9/UfAjmLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F41F68BFE; Mon,  8 Apr 2024 10:47:39 +0200 (CEST)
Date: Mon, 8 Apr 2024 10:47:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, janpieter.sollie@edpnet.be,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: [PATCH] block: allow device to have both virt_boundary_mask
 and max segment size
Message-ID: <20240408084739.GA26968@lst.de>
References: <20240407131931.4055231-1-ming.lei@redhat.com> <20240408055542.GA15653@lst.de> <ZhOekuZdwlwNSiZV@fedora>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhOekuZdwlwNSiZV@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 08, 2024 at 03:36:50PM +0800, Ming Lei wrote:
> It isn't now we put the limit, and this way has been done for stacking device
> since beginning, it is actually added by commit d690cb8ae14b in v6.9-rc1.
> 
> If max segment size isn't aligned with virt_boundary_mask, bio_split_rw()
> will split the bio with max segment size, this way still works, just not
> efficiently. And in reality, the two are often aligned.

We've had real bugs due to this, which is why we have the check.  We also
had a warning before the commit, it's just it got skipped for
stacking.  So even if we want to return to the broken pre-6.9-rc behavior
it should only be for stacking.  I don't think that is a good outcome,
though.


