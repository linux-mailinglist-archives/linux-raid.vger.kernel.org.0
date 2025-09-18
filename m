Return-Path: <linux-raid+bounces-4969-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4F5B33D5C
	for <lists+linux-raid@lfdr.de>; Mon, 25 Aug 2025 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E724864BF
	for <lists+linux-raid@lfdr.de>; Mon, 25 Aug 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D02DE71B;
	Mon, 25 Aug 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WwxLz0LK"
X-Original-To: linux-raid@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77B259CB2;
	Mon, 25 Aug 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119461; cv=none; b=S3uhOWkm8uQJxT6prOElmOh9xNTSNWiJbS4tAHi7oQkyMrQHDWooIqtA6FiEstbTN590Dm+gtgs3XabukiSMZ4Y1dNIjH6agkpVgKT4VXHqHqIFv4KsimCuo125J1bDI5fWSuHH4TeSnpi8+b+QJsyNtcQ6U9DfrE3Nj5MFuF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119461; c=relaxed/simple;
	bh=WgGDMoQK00MOeG+GfUSTUHBXTdOXSYqjQSIT4vXcCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTvDdsVPvE4q3OFl7sySdWxlBlNRDpoqdjtq3RgHCM/YzHmeX8wOjSstJTpfqRP1FMdqKmrD8tMCtFRoU9Nqi+6Gt0JXc7bKFz4Z+FddEI5v4Qz2B8EpKQoRcez/TBS9EABu4fgOCS4duIOfllqOrebl+G6ezLuP3wuwzngb34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WwxLz0LK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0XlqgX1qTtnay/sIqvCZ0ztMxkwDAInFpANYmM9mMQU=; b=WwxLz0LK1ppFz01+O8wNw6m1gr
	6DTEgFx0CPjGiOb1O6VdIx1UvFlKY0cjor1yph+FzqIfG6aozv/cnR4Upb7NCxunXSv+P2oRbcXsV
	pv+GKBxwk1ohdTXtkeP3Aiq01GRz1wU7TcvoXbKUhTSPGRWsHNvhgiJ+J6yTHqHuPSRCTE7lUPQgN
	SXRvj4lzVcwQ1bkPfjbXnF0iu9mQCavLlMSYhg4yfkiLizwRpNhVFGYxtO+AFEwvl0qBrHgHSarwU
	n5Wn/REKu/WJ8MGDgGeIJ7DwmwjRcQ3ByAIzyEMfmT1WEsAAeb3vrSEv6+z6vLN0YAaK2x5r9agSP
	Y/jpEabQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUtM-00000007gzQ-3OZs;
	Mon, 25 Aug 2025 10:57:36 +0000
Date: Mon, 25 Aug 2025 03:57:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
	axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	song@kernel.org, yukuai3@huawei.com, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC 3/7] md/raid1: convert to use bio_submit_split()
Message-ID: <aKxBoHcYyCn9unRp@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093700.3731633-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:36:56PM +0800, Yu Kuai wrote:
> +		bio = bio_submit_split(bio, max_sectors,&conf->bio_split);

missing whitespace after the comma.


