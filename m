Return-Path: <linux-raid+bounces-146-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45E809144
	for <lists+linux-raid@lfdr.de>; Thu,  7 Dec 2023 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE19B20BF1
	for <lists+linux-raid@lfdr.de>; Thu,  7 Dec 2023 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4C4F616;
	Thu,  7 Dec 2023 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="nsmcUvce";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="OZroOCkb"
X-Original-To: linux-raid@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765610DE;
	Thu,  7 Dec 2023 11:27:51 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 47B23480A23;
	Thu,  7 Dec 2023 14:27:50 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701977270;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=4i5/9nfQlV86kED7DPbGdfTM4TOhi8BGyriw3fEKRNA=;
 b=nsmcUvcednOtnZcix5iWPyvr8GhxzsRzqIMaynSOxvlg+fsWJ5oA0Wy8EvPmBF240k2j8
 MpC7iqswngF0o3xCQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701977270;
	cv=none; b=P4CZnLPt7agcjZA6ksJSOkd788ExUGmhoea2VPyU+mmHi209L/djcI4YRaRSjKkilmLOtmOrVLwsv3FHNWl0sBPch+AYevmcEUryrK976hL0mKQPE3Rtmyq9NhzN8reEgU4I3ZtPNu+zgyl0v78xk2sb9SRXrxPL+wNG6zGVPUESytYYuwKUUGQezq7/dQdEyZz2nf6YV3ncYS3hsOwcqyuwNyl8CrU9GJeWHuEZRICc+jCw1IVwVvEYMQyg02utJmj7qNXOpb5gIUvhBV73B2dSqERWz3mm67twLCRGI/FXS3JhrEogDpMe1Ud1Dxl8Eu5SNVz6G4ligh+wIXEB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1701977270; c=relaxed/simple;
	bh=uGVR9oLUFneRcPGITBY+3/IWza7Q5SPIxmo3ZH6tRWU=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=aR2LUlKGrMyvv6l4KEY1sAkVmptAqziW0Epj3vVyss2o3wkS0s1KcF0Jhd6jhjhmP1ZY2GEabWeUTd0FLfd1DPmse24QCyge8OQnxGuupY+voS831FFiZg6HsSjqxXawsS73F+lDtJYQpCDWoMiEOMlcXCwYuozRfymFfT0Ad7tMgAVt/mYJ1QNEQ34t+4+9f/G9ikNIDQPiU9YMmO2EMEJq5j0J0wgkoNQ216MmW2+Yc1egvomHusZ/QHnk2f/8liBBO2snGsQPfJMZtp/89mv0CC9y0hwchncMG3Xc71aT7/4jbRJVyBbnKw8ewt6iwYr5mEJRwXLqeYNB3W+FlQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701977270;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=4i5/9nfQlV86kED7DPbGdfTM4TOhi8BGyriw3fEKRNA=;
 b=OZroOCkbxsKBs41pkXaYgQdZHBhhY6Nh9kCkgLhvm8p/g5jSoZwSDE4CKHNFz/5T2dee4
 0j+5jCHFcDVsRZyqsXp0FXxyRzlOc81pAIktlEia2GMwwPniSeADYM+5Ly0h0QyYb5wSHyk
 3MwzRAfdtkSd4tp8726XlV4cRl2zxM/d9GXtdBYVIHz9VpXv5J5VDwA+skP39HJ57m3T2Qm
 wW3hSfYyJupvFtTOUE0u7GiPrP8fVLP9A4RR4IZUSzMQ8RjpXpWtznInZA1BXpVGHJhZRtD
 Axgp+5W2djtzE2mTKNASOVqFkIE8vBFuUPNXXUfF5u4JR2q4wDY4Ql/X96dA==
Message-ID: <673230ba-61d7-4c7f-aaf4-d5e2fc54944e@sapience.com>
Date: Thu, 7 Dec 2023 14:27:49 -0500
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: md raid6 oops in 6.6.4 stable
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>,
 Bagas Sanjaya <bagasdotme@gmail.com>, snitzer@kernel.org,
 yukuai3@huawei.com, axboe@kernel.dk, mpatocka@redhat.com, heinzm@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux RAID <linux-raid@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Bhanu Victor DiCara <00bvd0+linux@gmail.com>, Xiao Ni <xni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me>
 <be56b5df-fef8-4dbe-bb98-f6370a692d6e@sapience.com>
 <714b22c7-b8dd-008d-a1ea-a184dc8ec1cf@linux.dev>
 <c866bcfa-85cc-44fb-9b54-bb4840f588e6@sapience.com>
 <CAPhsuW4Cu5DdxZtZDbwLJ85oUpN9prS78Rr9UeFtgx88OGxUcA@mail.gmail.com>
From: Genes Lists <lists@sapience.com>
In-Reply-To: <CAPhsuW4Cu5DdxZtZDbwLJ85oUpN9prS78Rr9UeFtgx88OGxUcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/23 12:37, Song Liu wrote:
...
>    kernel:  md_end_clone_io+0x75/0xa0     <<< change in md_end_clone_io
> 
> The commit only changes how we update bi_status. But bi_status was not
> used/checked at all between md_end_clone_io and the trap (lock cmpxchg).
> Did I miss something?
> 
> Given the issue takes very long to reproduce. Maybe we have the issue
> before 6.6.4?
> 
> Thanks,
> Song

Thanks for clarifying that point.

In meantime I rebooted server (shutdown was a struggle) - finally I 
fsck'd the filesystem (ext4) sitting on the raid6 - and manually ran the 
triggering rsync. This of course completed normally. That's either good 
or bad depending on your perspective :)

If I can get it to crash again, I will either start a git bisect (from 
6.6.3) or see if 6.7rc4 shows same issue.

thanks,

gene



