Return-Path: <linux-raid+bounces-3393-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B9A0299D
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2025 16:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD2188689D
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8D1DC9BF;
	Mon,  6 Jan 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rH67Ad9C"
X-Original-To: linux-raid@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54D148838;
	Mon,  6 Jan 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177077; cv=none; b=hMdxoEg45176CkDbJf4W9U02EuzH6p1m2iXJ17k8a7m+J9AdMJFh/oocbWOpgYLTGxZ79wzJsyTxKREWAktN1bh0Ui5xweHIqJWtQ1GPCMoP5bI9u1TpLTU1vPY7JFriK+qjfts6N03Qr9ge1rNg0EulFSiAvedkvhlH4w6insQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177077; c=relaxed/simple;
	bh=M8s24hZfDCjSAu04EiF7Il8mDdOmbxiXkZKkO3l2m1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdF4cj9eqe0fAFGeZWOBGCwX2rkHYqrcfmPYgs27nsQoRv5RZJWvXcfiBDG5wzzcuEeZton2NoTKakK6Naon2rpqklsiumjH9lXODbG/bMQ9iCbeuX41n1u1cUzeA1ZsLFkI8NaLeaEz7FCeRi3ARXWA7ddODI2W1GbKcszxFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rH67Ad9C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8s24hZfDCjSAu04EiF7Il8mDdOmbxiXkZKkO3l2m1Y=; b=rH67Ad9CBMsUnNhmQ3n1OR6LVL
	1Ik8KGyTqheLDz+Drx/E8KSdAIzm/7MpqND6faAMsDVOxXQnVjennO8zQgKXA6Pky0y3zv2BzKBNM
	ghfS1hock5n6ePjNnq/XUqFs9F7nhBcpUufbZhqpH/kB804CyXC0Wwpc6ONbwA0EqEDh70xV1fBpp
	e+irgnw8q5xoMfKqQ+U7RYscs2ibhooTlyW39z8wdDlCU6q7auiI67LlshDBV9k9bqQzhvYvMM43X
	wqRgx7GKZLpum49MFgztfzv6umNRmt+RvGwN9pK3HsHZlH/FBZrwrf4SBqAR5OyTy07pQBpTbD8Kf
	PyzVb8dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoy2-00000001kh2-1Gr7;
	Mon, 06 Jan 2025 15:24:34 +0000
Date: Mon, 6 Jan 2025 07:24:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, xni@redhat.com, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH md-6.14 13/13] md/md-bitmap: support to build md-bitmap
 as kernel module
Message-ID: <Z3v1ss2aMrCI5whs@infradead.org>
References: <20241225111546.1833250-1-yukuai1@huaweicloud.com>
 <20241225111546.1833250-14-yukuai1@huaweicloud.com>
 <Z3u7quGlqJ8fP6R7@infradead.org>
 <dbe17982-bb4f-5c86-8a91-6fe1395070b5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe17982-bb4f-5c86-8a91-6fe1395070b5@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 06, 2025 at 07:35:33PM +0800, Yu Kuai wrote:
> So there are total 6 existed helpers that I have to export, however,
> these are all historical burdens, md_cluster, raid1 slow disk, ...
> And I'm trying to get rid of them for the new md bitmap I'm working on.
> If you really don't like *module*, I can change the config to bool. :)

FYI, I really like your previous cleanups to better encapsulate the
bitmap code, and I'm also perfectly fine with a Kconfig options for it.

Also splitting existing code into modules has a tendency to break
distro initramfs magic frequently even with request_module in place.
So unless there is a really good reason I'd rather not do it.


