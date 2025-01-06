Return-Path: <linux-raid+bounces-3391-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75491A02414
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2025 12:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8001885610
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2025 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1F1DDC37;
	Mon,  6 Jan 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ftPzsmj+"
X-Original-To: linux-raid@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCB1DD9A6;
	Mon,  6 Jan 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162226; cv=none; b=sGD2HgeadeAyOKU7+J5JwazNcJ8SgqTfWgkL65pz33iM74jQYuRtFGvlGEBqB2fyEFTDv5cEftgO70YWINfIr3mHTLlB5o/pk9YS14wDqpSRmSOzZZ8IveL+oKR62nsS2K35yHoPN97NeeZFlGsoIVI+neveOJGSSLWg9Con+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162226; c=relaxed/simple;
	bh=4pemDhMXWsVvwFAYqjnT8SfWPGMeAmBwfbELzkFre0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6SneBOl6incO4ew63Uls3UKV91NMdMtoFK9VFb582Btl7g77lxoBCEbCJm+LloOsCdakXo4uqBLiQ6MqRFvPsC2MikTuRr64LoF4JBHkxTM2gRxCkWd2SuLdy4UVaB+0fqMkeLAmUh34Vv9LnzFwEhYGhwYvLD3PtPe47MhilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ftPzsmj+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DqlqsivbtD6uRyva9IfwKzvuj+vh8YfU/SxNPPw+tE8=; b=ftPzsmj+CCvLIRLtbZU6xzdWet
	UlZ1l4hVgCGoUANWoinXbeWe5GXEjxbnmtEjLnyAIaj6UCjBTPd3B9OcP2fSKnEau/CUHeVL6dXJX
	ReL7fwF26TnaWH6rz0flYqI0tDpt00yX3Q69jaf5cjkacmr2Uf+fUqGi+XoUjlBe4j5zq4OfD8YW6
	s4aQBtYfrw7G3Ff39LtbXGGVL9uOFz6RL5BqasAvHEt5pjklSlrBr7IKZQY/dKB1FAB9p6lZxm3BT
	lVeEqN0aomslduBZkpTJ2NYYLXuaFOPpI7eKwYNvPd4kzHni7Ig/HQEXSylWo0Lc+uGI6mxt9g+4T
	neEzjCLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUl6Q-000000010lN-2DbK;
	Mon, 06 Jan 2025 11:16:58 +0000
Date: Mon, 6 Jan 2025 03:16:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai3@huawei.com, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH md-6.14 13/13] md/md-bitmap: support to build md-bitmap
 as kernel module
Message-ID: <Z3u7quGlqJ8fP6R7@infradead.org>
References: <20241225111546.1833250-1-yukuai1@huaweicloud.com>
 <20241225111546.1833250-14-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225111546.1833250-14-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 25, 2024 at 07:15:46PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all implementations are internal, it's sensible to build it as
> kernel module now.

Why is it sensible?  You need tons of exports for a small piece of
code that doesn't really feel like it is a sensible module.


