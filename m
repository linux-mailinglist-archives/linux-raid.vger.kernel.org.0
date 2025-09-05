Return-Path: <linux-raid+bounces-5186-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015DB44CC3
	for <lists+linux-raid@lfdr.de>; Fri,  5 Sep 2025 06:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694F748603D
	for <lists+linux-raid@lfdr.de>; Fri,  5 Sep 2025 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92E223DF6;
	Fri,  5 Sep 2025 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjsa.com header.i=@cjsa.com header.b="EQxbzjGd"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail1.g17.pair.com (mail1.g17.pair.com [216.92.2.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999628E0F
	for <linux-raid@vger.kernel.org>; Fri,  5 Sep 2025 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.2.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047237; cv=none; b=El0cp6f9q7A4jgt7X0bsCp50b5hfYrHhq4eWWrdRrD+Cgkp6c8icGEN4kKwdh4SipRfC0MgozHd59LwQIxsN0rUQ50+7QxSscQ/lL52OUePXxCxxmmD0iApOdo/O2jCutIv/xpQQAJgP/JYY4+iLUztnRksZpHb2VkAlVOhcPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047237; c=relaxed/simple;
	bh=XluYRMgFLp5zndwQ5ma/Kp8J0zZd6AHZHwiSC4Q9BC8=;
	h=To:From:Subject:Date:Message-ID:References; b=eVzyjpks1rqUSarE7Q+3OWRtV1BwyeOvBLytT98Gz2NBxnkGAXWkeGziCra5yc66+9rYDhqRqrGPUhRJHj3nvfqrDLCQpz8nSFQwTPBlnq+unSFhgwaFGUL9QJLK78ONJ5SPu8JEIzEMhwh3SjFCH4Z3kutAeGrU1B7Snw6sim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cjsa.com; spf=pass smtp.mailfrom=cjsa.com; dkim=pass (2048-bit key) header.d=cjsa.com header.i=@cjsa.com header.b=EQxbzjGd; arc=none smtp.client-ip=216.92.2.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cjsa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjsa.com
Received: from mail1.g17.pair.com (localhost [127.0.0.1])
	by mail1.g17.pair.com (Postfix) with ESMTP id 6C1DD164890
	for <linux-raid@vger.kernel.org>; Fri,  5 Sep 2025 00:40:28 -0400 (EDT)
Received: from dymaxion.cjsa2.com (c-67-168-59-2.hsd1.wa.comcast.net [67.168.59.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail1.g17.pair.com (Postfix) with ESMTPSA id 1FF0D168322
	for <linux-raid@vger.kernel.org>; Fri,  5 Sep 2025 00:40:28 -0400 (EDT)
Received: from dymaxion.cjsa2.com (localhost.cjsa2.com [127.0.0.1])
	by dymaxion.cjsa2.com (8.18.1/8.18.1/Debian-2) with ESMTPS id 5854eQJR2876078
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-raid@vger.kernel.org>; Thu, 4 Sep 2025 21:40:26 -0700
Received: (from news@localhost)
	by dymaxion.cjsa2.com (8.18.1/8.18.1/Submit) id 5854eQDw2876053
	for linux-raid@vger.kernel.org; Thu, 4 Sep 2025 21:40:26 -0700
To: linux-raid@vger.kernel.org
Path: jeff
From: Jeffery Small <jeff@cjsa.com>
Newsgroups: local.linux.raid
Subject: Re: What is the best way to set up RAID-1 on new Ubuntu install
Date: Fri, 5 Sep 2025 04:40:26 -0000 (UTC)
Organization: CJSA LLC
Distribution: local
Message-ID: <109dpjq$2kn76$1@dymaxion.cjsa2.com>
References: <109aahg$34jlp$1@dymaxion.cjsa2.com>     <37f99719-4bb1-489c-8246-e6dffc8b0bf9@youngman.org.uk>     <109b62i$e2l$1@dymaxion.cjsa2.com>     <d8fdc2a3-ef96-4e18-a0de-f962f6dfca57@youngman.org.uk> <9f66f430-bddb-467a-9156-df91252586be@thelounge.net>
User-Agent: nn/6.7.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjsa.com; h=to:from:subject:date:message-id:references; s=pair-202402141545; bh=J+e6JY2irkxGYVOk/gc6fkD1PsPZqVNaABjtZ75Gu/o=; b=EQxbzjGdDLqC4JCPpH5yyJ+zQgMPsPEI87uoWAPYhwnPLXzVINByscx0Lmp4iPPY4riTFKFFyiLKVJJpJWKC3/79i/Cpc45Tll4BHrfbCD4ljYQQl387+Y/I2XUb6u7nTbj/cIVxrNUVATC3xBrdLZz8wV3mkQBorrcnAIGVhkJp2z3UwF9MKuICfOunUXDe+m9ihwpYzqKPUjv0NhnB/DvgsHECUc9KzCJJh0ziVcRMcGkdKja+Z7Xaaqb3/i4Ua1OsxCiGHjy4oxzGWmeZU2Q8U/uETPtmrjuNW1AHwWT2leOCQsS/C0ibLWc+3H6DLgi2J9kEdM8YSNDfiIvhxw==
X-Scanned-By: mailmunge 3.10 on 216.92.2.65
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>

Reindl Harald <h.reindl@thelounge.net> writes:

>the UEFI partition must be FAT and can't be a RAID partition becaus eof 
>the limitations of UEFI

Good point.

