Return-Path: <linux-raid+bounces-4177-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC6AB2EF4
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 07:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7037F178991
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 05:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA092550B6;
	Mon, 12 May 2025 05:21:26 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7A254AF1;
	Mon, 12 May 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027286; cv=none; b=hr0qSCQUJ0mtjfSEwOpL5DZSQKPJgXyFmHUXLb/MCKjuFkq8Bl2MK2Aij9A6sDjkrhSkvLB/ylXcLzNTYbK3WRwwLyODR/4r8m6cT+uxYNgbY7UG2utxvRANpBlJndDt/6W/8VU9J1PJqhLgwSlFt8BE55yCGLL+ZlfC2WpyOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027286; c=relaxed/simple;
	bh=NJ3NzSHbZhErwutlec7VW+MC9Lms4/4peSUDpDF/lww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfdlxG3x7QsTFlAiHLNmE77YMSUpsJ8lq6q4fKgWIJcIkLuWXi5amOE7jEc55nNfZsbz38iiyrkYGDG7sdKz+h3+dI2tJI165oOWUamJVWLQ0hhRnDfpjiXxs+aN76zzl4aqFMOgjF41DsxVIYwk51G1YtV3Kz6f044CjEmp850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2489968AA6; Mon, 12 May 2025 07:21:19 +0200 (CEST)
Date: Mon, 12 May 2025 07:21:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, xni@redhat.com, colyli@kernel.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
	yukuai3@huawei.com, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC md-6.16 v3 00/19] md: introduce a new lockless
 bitmap
Message-ID: <20250512052118.GA1796@lst.de>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

From looking over the patches this entirely dropped support for bitmap
files for now.  Do you plan to get back to those?


