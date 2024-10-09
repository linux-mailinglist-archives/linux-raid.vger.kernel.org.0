Return-Path: <linux-raid+bounces-2879-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7EA9960FD
	for <lists+linux-raid@lfdr.de>; Wed,  9 Oct 2024 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE63B1C22341
	for <lists+linux-raid@lfdr.de>; Wed,  9 Oct 2024 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFEA17CA1B;
	Wed,  9 Oct 2024 07:36:06 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA984E18;
	Wed,  9 Oct 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459366; cv=none; b=sxzG7JHcMf+nJIQMYlUJwNUjGEEXtTA5kmbfexogt0ZMouWjreaRSOzWS3GHIq0PaUyNdBGbiYcQlNrLXoxDYjBDZghBdYe1GLhOvhrRW6iI9dfuIVogSHYOf/L4S4rMEK7nhSC5HtSWyYBkeqAyugjuJ7JZ74eu9SC2nsJg8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459366; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgz9W3Of2YHaKYEE7kcq+olH7xKNriDtUJmWPyV9cao2kof71B9P6bTabwPTEbwqqI20Pq3KeOuW3wKlp2rMkqP29UoUycDlkh80fMpU6+xQ7Byn6FhMNU7aREpj9hOUjxbpbaBZDXnnnn1LcxCJBqPsx3alL4hv1CnB/6pdu5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5860227A8E; Wed,  9 Oct 2024 09:36:00 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:36:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, hch@lst.de, iam@valdikss.org.ru,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] md/raid10: fix null ptr dereference in raid10_size()
Message-ID: <20241009073600.GB15983@lst.de>
References: <20241009014914.1682037-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009014914.1682037-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

