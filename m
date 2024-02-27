Return-Path: <linux-raid+bounces-918-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC7869A00
	for <lists+linux-raid@lfdr.de>; Tue, 27 Feb 2024 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272BF1C2449C
	for <lists+linux-raid@lfdr.de>; Tue, 27 Feb 2024 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260B41487EB;
	Tue, 27 Feb 2024 15:10:21 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751191487DE;
	Tue, 27 Feb 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046620; cv=none; b=pKf/Une8m7lw1kDWG4nK55HOQE7GVEG+da0b5Mnb1has0NzYT8B6/0RIuW23Xyyv4jD9Co+yZoQOhcMQFkCfVC0VubJNGYSVlpfmlwblJSMjqhB0qJ45okPnq6z/bbVkxRgSCLQGIOWwMwPKBBeJkdpv7rKp44NgCelKkyoyZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046620; c=relaxed/simple;
	bh=sISuJRLnJCzRfoc+uZoNnLYbqsJkIdiRy15/jK82aAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXMPVa8/edoFcdQ4j00Z7RKXWb8g9mUmAas6a//XswTXK+4X3/wOzV8QAuZS7iweJ4isQ0FAXLb/6FCKrzh92omu+wecGFWNhpb74fC5D5rmnrRsw85kvgxDbuo1jKm2UrOyB6vMUNItT3PPZMQBEZ+kz1vXZx037+jhsLBjgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D73C68D07; Tue, 27 Feb 2024 16:10:16 +0100 (CET)
Date: Tue, 27 Feb 2024 16:10:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: atomic queue limit updates for stackable devices
Message-ID: <20240227151016.GC14335@lst.de>
References: <20240223161247.3998821-1-hch@lst.de> <ZdjXsm9jwQlKpM87@redhat.com> <ZdjYJrKCLBF8Gw8D@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdjYJrKCLBF8Gw8D@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 23, 2024 at 12:38:46PM -0500, Mike Snitzer wrote:
> Also, you can use the lvm2 source code's testsuite to get really solid
> DM test coverge (particularly for changes in this patchset which is
> dealing with setting limits at device creation).

And that one runs fine, although even with Jens' tree as a baseline
it hangs in the md code when dm tries to stop it.  Trying mainline
now..


