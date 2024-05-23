Return-Path: <linux-raid+bounces-1562-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BA8CD8F1
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2024 19:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFC91C21580
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2024 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696E76034;
	Thu, 23 May 2024 17:05:35 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F576D1B5;
	Thu, 23 May 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483935; cv=none; b=ZbcJwZG2vIdXIvGZegxMMhReuCg3FsN0apjQikrX/Cw3WYfKMFb8NRfM9u+k3RZ2UWdehxHfbYFfTh8FlmvZB3zWIjfRCpnZkadDT3tOB+nXZOtv6fybJlRj04EgMjxuTo81SEvaW7wRUJQsG8YRZ+hhNImKM5Y+Dx261Aa/sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483935; c=relaxed/simple;
	bh=V+ajwrZpAjGMixKD8KhvRcYQlKvuiaulYx/KIWISh6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP6xlZz1wxNZG93Sf7w7YA1PF0x9MR8SqriUfgGw9WXi8HgDIJyY4PcaLhl2s662qmCbfHARamtI8jzqWqzpN7szsP5CR8/u8gHqLC8Gb5itf4bqQaFWdi/uX44w73HQDWFFBrn7YkCIWGvmxoYCN76pgHSpUj+I5+qBBh/Bpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFF1968BFE; Thu, 23 May 2024 19:05:29 +0200 (CEST)
Date: Thu, 23 May 2024 19:05:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	axboe@kernel.dk, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH for-6.10-rc1] block: fix blk_validate_limits() to
 properly handle stacked devices
Message-ID: <20240523170529.GB5736@lst.de>
References: <20240522025117.75568-1-snitzer@kernel.org> <20240522142458.GB7502@lst.de> <Zk4h-6f2M0XmraJV@kernel.org> <Zk6haNVa5JXxlOf1@fedora> <Zk9i7V2GRoHxBPRu@kernel.org> <20240523154435.GA1783@lst.de> <Zk9lYpthswuegMhn@kernel.org> <20240523155217.GA2346@lst.de> <Zk9xAJur96MVX0cy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9xAJur96MVX0cy@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 23, 2024 at 12:38:24PM -0400, Mike Snitzer wrote:
> Happy to see mptest get folded into blktests (its just bash code) --
> but it doesn't reproduce for you so not a reliable safeguard.

It is a lot better than not running it.  And I'll look into why
it doesn't reproduce.  Right now the only thing I can think of is
different kernel configs, maybe related to schedulers.  Can you send
me your .config?

Is adding mptests something you want to do, or you'd prefer outhers
to take care of?


