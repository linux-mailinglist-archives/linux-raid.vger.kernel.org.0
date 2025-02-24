Return-Path: <linux-raid+bounces-3763-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A20A423D5
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2025 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9773A61A7
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC2254874;
	Mon, 24 Feb 2025 14:37:41 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F271925B8;
	Mon, 24 Feb 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407861; cv=none; b=rtfXPHwH6W9gLl8eMRJ8Zr5AqZVSA4wLEjY1d7tyro08ANn7ejVGzE3ByGwgGpX2NkDxdkCALiDgq2j7UUv/wHHIQCOgNhcKTOZ+JoeOyVAHFMP2dhqLqopbdV1rRzz3EhUyqL+bspgGUCh7Kd2g8cbP38fuzSBUJLfG4CLt204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407861; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfrgP+hEv+W9PeUIH3HJjOLPOXZYQioUhOyrWh3dGvCInAkKUWib3taM1FhszhoVhks5eA6kt1VNkb000zpOw8Uebu2e4iW1vUPwLPn3nckTlKhx+dVspi2buRXpeIJVyNN6Xe/zECvQV8qLHX/ETWSk2GUpPoJFatpn4OcHKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09D9A68BFE; Mon, 24 Feb 2025 15:37:35 +0100 (CET)
Date: Mon, 24 Feb 2025 15:37:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, yukuai3@huawei.com, hare@suse.de, axboe@kernel.dk,
	logang@deltatee.com, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, hch@lst.de, guillaume@morinfr.org
Subject: Re: [PATCH v3] md: fix mddev uaf while iterating all_mddevs list
Message-ID: <20250224143734.GD1406@lst.de>
References: <20250220124348.845222-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220124348.845222-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


