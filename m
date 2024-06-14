Return-Path: <linux-raid+bounces-1941-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10837908FD7
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3611C20A8B
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263716FF5E;
	Fri, 14 Jun 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gqQ2NMhY"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F316C692
	for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381766; cv=none; b=iI+jDC+C70zLECiKcRu4k4zGTS0WzjA/PH7Vrk5aukkiQxWtCNUoENxw4wytkT0wnD/Dv6T1Gn7l2sqFgoINWXNmaeolXp0v+ofg/BAxJEsaZTw8ncvJtjYtqPB+6Twasaua6dSEShbiBolh5KBEoTAm1bWg9HgmN7HJQGEHILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381766; c=relaxed/simple;
	bh=Aad19hIjxSUfEbYh1/pSP2sHGv1iCwO+UAJvrB+cZ08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiUXIXLIrjLYBvF/mcgFp+bzTHGCAweMkb9BJsvfQczwM+zmLk6qmpopYliqR3i4Igs3Az2ZHQrYM0WYJkcQTe0lelhHc9eCedZw7u8WvVSm2AAKKSlru7AVqETKcE4bT9Hq2DI+9PgY5QOHYRSybCf6CB8NpMQt0yS+dxAyajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gqQ2NMhY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7043684628cso61154b3a.0
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2024 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718381764; x=1718986564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDixbra1HnV5DPgXv78teb+z8r3TOra1wJTUjH08YD4=;
        b=gqQ2NMhYISubpA/O2zIDXj7REGCxPKs4R/Rde+ilKBlHNlj2PmjMPcpzq+17MEyRVe
         IXc9gw+SrQ5Qxq6CbfSwf+KWf7KgvKBM9EpAAPrq4HhVhOyv98il/gX65LCRG2iL8H+D
         vW05aaiimr1Pv6Cwo0NLKS2M/Uesj4UcctnZp5IigCyN95IAhb1VuyWt5RL41KpiG42d
         vM/wwiYb2D+x0FuhVUhDmFLo90AxEkzwLxUSmEEs9nCgxq7tUQyoHSp/eg5x3NJK8g49
         zk6+FGx/M/t+QDE1+M8/tj/qiVAtDYBXE7bcKVpSj8Jm24Z0f0UIFEFOChdO1Z2mgoDc
         WPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718381764; x=1718986564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDixbra1HnV5DPgXv78teb+z8r3TOra1wJTUjH08YD4=;
        b=PMQ5NednHG2jGX+20HggJS5S+hxjGBUQ206Qw0ZBWky/ssIAX9kTrlsdUUs9gRxjln
         wNzpDXcdO9l3mCmsbhqBAMZvDEUOxw1jjBdLnHv2oDFOp/rsziOLlUOaq12ypCUvCsJF
         cKcuI2h5jqGMMfKcItJnsNMtYcFkGFgtRApO/6sSX72goRAjvugmg/uNmz9PDZXN7DK6
         n8axKfqNtpSKcl3TpaOCKSJ/u1vtxJtHFW82/WEP1SKhi9DKNAeCJbmywfy0ONV07DAJ
         5y5rvUydvgzH5pYWGQHJUcW34ubsL7SYjluywZtWkWtiWeGyZ8+nkbHLpL4xvzVvUJSM
         W/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVitFbCPYA9s+ExPL2lRupgsElgAhamS3XSoJFnGgyQ5806WVcJX4J49uIvxF6YcGC7dBn5CwybJEdqYndtUCP++sXNrecAkqjucw==
X-Gm-Message-State: AOJu0Yx0VHyP+4CPHptxJi6N7N611pkWBz+tUe555BKHhUO8mEUOrPms
	NlBlcheB8s4lMzGMAfpunzMKUGWBwDOgJ2642QD+dD8O0DPseXw4f5ymdwuLPfc=
X-Google-Smtp-Source: AGHT+IHcxyIgaaVTPfM4bd/lwoK3Ws05v5eakEhv+baleiJUj4MZMdoqwGuHfLvaj6ML51yAKT62Sg==
X-Received: by 2002:a05:6a21:6d98:b0:1b4:e10c:62bd with SMTP id adf61e73a8af0-1bae7ed3e48mr3699835637.2.1718381764289;
        Fri, 14 Jun 2024 09:16:04 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8d98bsm3224419b3a.191.2024.06.14.09.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:16:03 -0700 (PDT)
Message-ID: <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk>
Date: Fri, 14 Jun 2024 10:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move integrity settings to queue_limits v3
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240613084839.1044015-1-hch@lst.de>
 <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
 <20240614160322.GA16649@lst.de>
 <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
 <20240614160708.GA17171@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240614160708.GA17171@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/24 10:07 AM, Christoph Hellwig wrote:
> On Fri, Jun 14, 2024 at 10:04:28AM -0600, Jens Axboe wrote:
>>> That sounds like you didn't apply the above mentioned
>>> "convert the SCSI ULDs to the atomic queue limits API v2" series before?
>>
>> That might indeed explain it... Surprising it applied without.
> 
> Also as mentioned a couple weeks ago and again earlier this week,
> can we please have a shared branch for the SCSI tree to pull in for
> the limits conversions (including the flags series I need to resend
> next week) so that Martin can pull it in?

For some reason, lore is missing 12-14 of that series, which makes applying
it a bit more difficult... But I can setup a for-6.11/block-limits branch
off 6.10-rc3 and apply both series, then both scsi and block can pull that
in.

-- 
Jens Axboe



