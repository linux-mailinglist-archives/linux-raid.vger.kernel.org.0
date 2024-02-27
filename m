Return-Path: <linux-raid+bounces-916-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6F08699FC
	for <lists+linux-raid@lfdr.de>; Tue, 27 Feb 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7F81F24619
	for <lists+linux-raid@lfdr.de>; Tue, 27 Feb 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56B146013;
	Tue, 27 Feb 2024 15:09:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4ED145324;
	Tue, 27 Feb 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046557; cv=none; b=aNxv2dkhLKjDnHh8Uv6wf0ZUGgTbBAoqDmsgLuFjEWoAeYEd29SFV/lc7Lu1dtlcKzGHSiHlDQg4dOGKOJD6m1CRJY8X63Q94G5Iua1OL6i0k4i4FEFeJLzwuWDD8ob5N6AWzHFwQ/Ho6Ax3YUjGRZ75hGJIVG0fKaDaBToMt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046557; c=relaxed/simple;
	bh=MHMTrmsLhSbsCBPLimtBa7ZtGYxVQ9CB5nwleCXfuAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEZ3tpJtlH6uZsg3pAHmHpA+MJJTIgCWpU22WBxkhUGvO+tCUqSzoaEZhyL7CUOK/qvFLYf/rTM5rHz7UDTMfTi9o6AjcsZV3exh5/yGIOBY5RcBHXU4fM6OQiU6oTAC7OyZGc2uo7FHM0KV6hB9XQLbRG4dRADpv9dOO4MITgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2203E68D05; Tue, 27 Feb 2024 16:09:11 +0100 (CET)
Date: Tue, 27 Feb 2024 16:09:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	Joe Thornber <ejt@redhat.com>
Subject: Re: atomic queue limit updates for stackable devices
Message-ID: <20240227150910.GB14335@lst.de>
References: <20240223161247.3998821-1-hch@lst.de> <ZdjXsm9jwQlKpM87@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdjXsm9jwQlKpM87@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 23, 2024 at 12:36:50PM -0500, Mike Snitzer wrote:
> Which DM testsuite are you trying?  There is the old ruby-based
> "device-mapper-test-suite", and a newer one written in python which
> should hopefully be less hassle to setup and run, see:
> https://github.com/jthornber/dmtest-python

I gave this a spin on the plane yesterday, but it seems to want
pip based dependencies, which the pip packaged on Debian refuses
with a refereence to the python PEP 668.

I'll see if the dependencies are properly packaged, and can send
patches to improve the documentation. 

> 
> Mike
---end quoted text---

