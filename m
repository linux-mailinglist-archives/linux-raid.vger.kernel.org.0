Return-Path: <linux-raid+bounces-820-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3178619F0
	for <lists+linux-raid@lfdr.de>; Fri, 23 Feb 2024 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B801F246ED
	for <lists+linux-raid@lfdr.de>; Fri, 23 Feb 2024 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BBD1448DE;
	Fri, 23 Feb 2024 17:31:01 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE57143C5F
	for <linux-raid@vger.kernel.org>; Fri, 23 Feb 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709461; cv=none; b=D2SUn/MzlM/kQeV0eqMTblwvtVRwTfAZpECeE37nmChNWs//Vg3e/p/pJY3OHpPkVfUOol+J4F05pSWgA/AFS3W6jtTJZqfNVPwkCC/eXzR5CZqz6xKvfjIfznd9mXI+65Ijb1I90qlJWEY/JczZgyP6JHnjvoAPFNhnIZJKsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709461; c=relaxed/simple;
	bh=kk9USHa3Igm+4RJya8josHopx6Qb1FmJAPmqrV6cP8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfoaO9CIx0h5iiZPUG17BeknV9x5jXBtQ+Vypg5PiBVSew7FPQ8QBhnb1Sce7M72NNeAfyFB1KkIEFPjY3KjnWQkJO4QfFWJSQkopD48cPqNLfyU3j0mKVPER0dXHPnGX/w+AWU0AgK8O0MSAYfTMKPtdHzOfcnV1FYugi61CJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68f63f8d807so4041376d6.0
        for <linux-raid@vger.kernel.org>; Fri, 23 Feb 2024 09:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709458; x=1709314258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVdmESG4PxkwASoqLragfY2GZJ2QdcB8GuhgUXgWRzg=;
        b=IfiuY17oV9UAtpBCN9FOD4ZO9fcNIYFOd6ynXlnzE4X7qr3oO7/AeE6iADForTRaHc
         DAfIXTbnv1UOuvD0ZNHXa29mIiCVB5TBXRKS+P7i/DJQdba7sxPPlctCpb+bQno1MrHo
         5ZE4zdwaqi1ZxkfbyZ+072RBqVy+QzI/diYgZU08SunkZ1YNgYrUlDuCBwfMRSnOzCnq
         kt+SfODuE/TTcdBUtN3XdgPQ7ROfTHGaoKz2WheoiN5Y1L0NB2rLG+mVOdszUPY9Ttni
         QgSiBJSSqFJzl227nKSgsbbM1PMxkhoEIjrcqI7POLd3TGr3lk8QJv6z6bUqkA7t3HQ3
         zIsA==
X-Forwarded-Encrypted: i=1; AJvYcCUmXDSYdEgaltCrJS+vdB3MR5QabrX8swYZ2UcWXOyfvG31RBYTtTqVs6CtTRh6/hYA9XasFTAkWS9SSSjxaAw18n1qJkD7dQ03ug==
X-Gm-Message-State: AOJu0Yzgiut/6aUOjOzG9exlVIwnSvcMCf5fw59WsgYz3f8wdlL9x+HH
	qAqEx6fTlxxrwyFy+jdt3CumjoBURg3ADjNpeKf7moBnOEZfuKWpc3yasQgm1A==
X-Google-Smtp-Source: AGHT+IEiN2DRNfZ9o9l6t4npd0H7WRs0vXB44XzHTTVVeoGiXBOzkyqAnD2/8Y1Y40PYCiOWrBICOg==
X-Received: by 2002:a0c:e113:0:b0:68f:3452:584 with SMTP id w19-20020a0ce113000000b0068f34520584mr377462qvk.59.1708709458689;
        Fri, 23 Feb 2024 09:30:58 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id nw5-20020a0562143a0500b0068d38023e35sm7035400qvb.112.2024.02.23.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:30:58 -0800 (PST)
Date: Fri, 23 Feb 2024 12:30:57 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 3/9] dm: use queue_limits_set
Message-ID: <ZdjWUdwrwmPT0mX1@redhat.com>
References: <20240223161247.3998821-1-hch@lst.de>
 <20240223161247.3998821-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223161247.3998821-4-hch@lst.de>

On Fri, Feb 23 2024 at 11:12P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Use queue_limits_set which validates the limits and takes care of
> updating the readahead settings instead of directly assigning them to
> the queue.  For that make sure all limits are actually updated before
> the assignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

