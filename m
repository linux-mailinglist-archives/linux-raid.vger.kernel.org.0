Return-Path: <linux-raid+bounces-5159-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BDBB427F3
	for <lists+linux-raid@lfdr.de>; Wed,  3 Sep 2025 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE28B3A7987
	for <lists+linux-raid@lfdr.de>; Wed,  3 Sep 2025 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF92F83D4;
	Wed,  3 Sep 2025 17:28:16 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5142F29
	for <linux-raid@vger.kernel.org>; Wed,  3 Sep 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920495; cv=none; b=dTwAvNZifYXAENM+ZXZgt2wjhdgSYovb0EI7hoymFDOctILvpWXQegQfP8ipioaS/LrrAIderzenPySDxhICFFt0wdMPhDdDuhbiUPVgbolFrM/LfuF3lzM8heME2oYAB7VxP88jwJqZUI8rV20THRftaRYfVuPul0VlwMQgYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920495; c=relaxed/simple;
	bh=QG9gsAznqp+Us7KIrD1kkQZEEM+GR8z2DvtATqiAKSs=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNusUQUyA5vH7EfnerkL5GqQ/FE3EfPF1dPRwIlwOxiBJQi0uajHmAdHkaQcXjLqggG9FR5ZaglXdleJiT7XLG96Ji15Euks7RJsJjQi3T+GQDEVYv2AZIOHzqOFtOFC0u6vdgeNc1HRz7par5nhpc8jYR/aMGIZvsSAdEtNmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.0.romanrm.net [IPv6:fd39:ade8:5a17:b555:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 0F8C940984
	for <linux-raid@vger.kernel.org>; Wed,  3 Sep 2025 17:28:08 +0000 (UTC)
Date: Wed, 3 Sep 2025 22:28:08 +0500
From: Roman Mamedov <rm@romanrm.net>
To: linux-raid@vger.kernel.org
Subject: Re: RAID 1 | Changing HDs
Message-ID: <20250903222808.4047e5bc@nvm>
In-Reply-To: <dcf4249e30d6a56821ac4cead431ebd4d5650056.camel@reinelt.co.at>
References: <5c8e3075-e45a-410e-a23a-cbf0e86bdfa6@peter-speer.de>
 <20250903204521.44e91df1@nvm>
 <dcf4249e30d6a56821ac4cead431ebd4d5650056.camel@reinelt.co.at>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Sep 2025 18:58:10 +0200
Michael Reinelt <michael@reinelt.co.at> wrote:

> This minimizes the time the array would otherwise run degraded and thus reduces the risk of a second
> failure during a rebuild.

Good point for RAID5/6, but in this case growing RAID1 from 2 to 3 mirrors
doesn't introduce any risk compared to what it was before the operation.

-- 
With respect,
Roman

