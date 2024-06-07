Return-Path: <linux-raid+bounces-1712-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E78FFC49
	for <lists+linux-raid@lfdr.de>; Fri,  7 Jun 2024 08:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F161F230BE
	for <lists+linux-raid@lfdr.de>; Fri,  7 Jun 2024 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C44E1527A0;
	Fri,  7 Jun 2024 06:32:27 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD544150985;
	Fri,  7 Jun 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741947; cv=none; b=gELsV+2ksF7cQxqVhscIEiQ2o2CbiQ+7tQMXEYU20zwRXNOuit8qBJE6rErJX562Q3T/0EZmlArZmHmSNy2Emogn5A7u64wO39TrtKqrNNYjejeKXPtzdSPvbjLJhUtuKuk2G5FNbqRqtsZ9J7wLOJqPX2Z/BczOrmXbGL8NKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741947; c=relaxed/simple;
	bh=JhPcVRNwu6QcTpd+nZUQewwtmFb/3TACUQO8IkAzioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH738YeqBbRoZgPlxFgcaiNQk9nzAk5oV0smwo6db+vKEPcVpOoeOnr6JCAAbZdfNia4qgAq/d2DdKnBb5YhD9VUJfx4CrQkMjyYldNAVzyPae0L3BksoDeOvyfOshFm/yX1pN3Xav/QxDFy/bV+VN0iLbTgF6DwKAN0+0Fhe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D57E468B05; Fri,  7 Jun 2024 08:32:21 +0200 (CEST)
Date: Fri, 7 Jun 2024 08:32:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 11/11] block: move integrity information into
 queue_limits
Message-ID: <20240607063221.GB5387@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-12-hch@lst.de> <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

I just found a fullquota.  If you have anthing to say please trim your
reply so that it can be found.


