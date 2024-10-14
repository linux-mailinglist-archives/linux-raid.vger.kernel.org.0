Return-Path: <linux-raid+bounces-2905-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D0299D1E2
	for <lists+linux-raid@lfdr.de>; Mon, 14 Oct 2024 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63416285AF6
	for <lists+linux-raid@lfdr.de>; Mon, 14 Oct 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1A1CCB24;
	Mon, 14 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tU33M0Ra"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE41AD3F6
	for <linux-raid@vger.kernel.org>; Mon, 14 Oct 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919038; cv=none; b=MJ7j6cuGEVxIrjrJ4avt/3sUBabebYHI5GM8K0wwSuAGf7ygVMJkNiE4B+gF+Kmhuir0d6GJJVlyTxMTcGEy0qTDhFJsTCOewnyfzn5S1p8EKRGo5b/OvaH/vpQoYnfj3LXuL6s9DCuPyXLxj9nmKdaEvB2dWYCwirGRUEV27qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919038; c=relaxed/simple;
	bh=qZjZkJC8TvuLicHKx/g9ilkvy1AyBGceBizbkfzAbO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ji9paFJccTAKSyYr5/bJd3eM/q0vyhppFrRDRhyiaQVaT6zJxRfcNxs05V+Y0rj/isMlFuzrOD+aEysXxInRS1Usa5ktFjJxMpvhTvkRQMU3Uoi1Rass9RILHUeSUIX/J3XY+Y7pgefRKUv/m1JHcRifJPJSYvGJ1EtWQF4hRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tU33M0Ra; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b450320aso10530975ab.3
        for <linux-raid@vger.kernel.org>; Mon, 14 Oct 2024 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728919035; x=1729523835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1f6tWVkVeZpuD6W55vu43bMEka9Bgfs26D5vnHOkHNk=;
        b=tU33M0Rahq/DFoQ8n35d3IL/6Y99T6eYx0Bf27IqHZR6BWtkWyd7NS6+uul80JaDjj
         02QjP/izz1S7iySm0Ypi6rUb5wvjNgVnWchI7Qq43wGXyAE+5Qxc16YawmaQadlPYqTD
         eZaRPeKtuXEmSySL3MoCYVQ90xm0xhCqQB1cio6a4QyueTGnKkBIIjdo2rsLq1nLeRJB
         OwCUY/PF75NuK3niHI9riTJ2wpqk3QNqje9RMBQEDWl41T4pNsaXqx1b1ALFseJZvo+b
         D7V2pwcs3MRBxawWOYAmmK0IxvML24ztVlrhmNGHIU9WpexAc4UowY5a1OmW56p9bBuQ
         UqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919035; x=1729523835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f6tWVkVeZpuD6W55vu43bMEka9Bgfs26D5vnHOkHNk=;
        b=Ta3N9MTyvpJeEHLpXEFSX5zbLQDbtrTaLTP4D0Krrw3FHEbgTyAVsLeqJP3tsjwF+F
         +UhZJrW/mXK46vNmjhuPsexHhs/J9wZLTnmOlGijzFlc07cQc8J+onKjfTErC41+shEo
         V+ZfLDVHsKB3f0TEMA5IAzLftH1n4W1u21qQFWOT4J0heCIdbdnkwhu+AGHdLc7up0/9
         GlejhL2yhjT7kqk+gFtat9soxrBHjdA5J5dTzy6zwCm5kb987O4We6iCNzqgQyo34qvn
         Rg1s49ZnxIKNh0Fd/l7uHESKodyDAU5fgzPggLlI1nNHCpApqypETpB8Te8/K8tZyECd
         kxYA==
X-Forwarded-Encrypted: i=1; AJvYcCVRhomiTbkdUlu/g4kROV99urzusym+qCVxbQ8BrECXaNPfyv5MfmQdQ0Y5fVLr4auW2uaEwHKW9lho@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sTmwiPMfdB3fj5FhrF/e6o/x3zzWPp/E2OQn+bcCQp/bxQUz
	kuCUieuhBgV3W9a2DsEYnDOiykhS+nG5Tpj8OSImSmy0m7P+sdoXrBmEZ8hjJhA=
X-Google-Smtp-Source: AGHT+IFxU+6iK4vm/BjVbsnxaxXdxk8G3H1g9vd9g5QB1bRM6/lXrHOk9SFlCvgoUX4Lt8bWzNOpnA==
X-Received: by 2002:a05:6e02:2192:b0:3a0:7687:8c2d with SMTP id e9e14a558f8ab-3a3b6019b61mr78076955ab.26.1728919034952;
        Mon, 14 Oct 2024 08:17:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afde8cb4sm56162565ab.76.2024.10.14.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:17:14 -0700 (PDT)
Message-ID: <a9fcd235-18b5-4b17-bd4f-75dc2d228e17@kernel.dk>
Date: Mon, 14 Oct 2024 09:17:13 -0600
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
To: Ming Lei <ming.lei@redhat.com>,
 Hamza Mahfooz <someguy@effective-light.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 linux-raid@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZwxzdWmYcBK27mUs@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwxzdWmYcBK27mUs@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/24 7:27 PM, Ming Lei wrote:
> Hello Guys,
> 
> I got more and more reports on DMA debug warning "cacheline tracking EEXIST,
> overlapping mappings aren't supported" in storage related tests:

This is easily triggerable with dio and reusing a buffer. But it looks
like this will only trigger if CONFIG_DMA_API_DEBUG is set, so should
not be a prod issue? If so, I'd say that debug printk should be killed.

Maybe turn it into a pr_warn_once() or something?

-- 
Jens Axboe


