Return-Path: <linux-raid+bounces-1559-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4978CD7BD
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2024 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF821C209AC
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2024 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C4812E75;
	Thu, 23 May 2024 15:52:22 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B8125C1;
	Thu, 23 May 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479542; cv=none; b=DBqLrU14TE1IFFelb8GY5M9O7KDzrXMDxpA3LtUG30Cg3O+LcnynbD9da8PcBgrYUd/tjOfTfVvbDkMaoBedUQnIG1ZZL9TlFmG3XWv7NVdKrXrSCeiVKXbbe8KdAbc63qjuv/JvsfD/vL+OgeS3sUpiveuhkGOvECSmk+20MAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479542; c=relaxed/simple;
	bh=6adARbXkaUFv1ZdR8DILk1zhUXrwohs8dunN2MUuRcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV/VVvanRmqTJGFb/v5Fa3aYeIQtC163g8l7KkoF1PI4bhGWs2R7teGNAN1uAZTEoIQIMn7yLPuTZIAz4TypP7bhXw7WFYsnft22IHO9mFObBl37C4AmrtT2Wqc2z5lu1VNyHqVs49/EPNv/BO1svooUVBqohuQdLpUlIEfWHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9CF368BFE; Thu, 23 May 2024 17:52:17 +0200 (CEST)
Date: Thu, 23 May 2024 17:52:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	axboe@kernel.dk, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH for-6.10-rc1] block: fix blk_validate_limits() to
 properly handle stacked devices
Message-ID: <20240523155217.GA2346@lst.de>
References: <20240522025117.75568-1-snitzer@kernel.org> <20240522142458.GB7502@lst.de> <Zk4h-6f2M0XmraJV@kernel.org> <Zk6haNVa5JXxlOf1@fedora> <Zk9i7V2GRoHxBPRu@kernel.org> <20240523154435.GA1783@lst.de> <Zk9lYpthswuegMhn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9lYpthswuegMhn@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 23, 2024 at 11:48:50AM -0400, Mike Snitzer wrote:
> 
> Reality is, we have stacking block devices that regularly are _not_
> accounted for when people make changes to block core queue_limits
> code.  That is a serious problem.

Well, maybe we need to sure blktests covers this instead of either
impossible to run on a stock distro (device_mapper tests) or always
somehow hanging (lvm2 testsuite) separate tests..

> Happy to see the need for the 'stacking' flag to go away in time but I
> fail to see why it is "fundamentally wrong".

Because stacking limits should not in any way be built different.
Both the stacking flag and your restoring of the value just hack
around the problem instead of trying to address it.  Let's use a
little time to sort this out properly instead of piling up hacks.


