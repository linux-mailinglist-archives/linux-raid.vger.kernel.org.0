Return-Path: <linux-raid+bounces-4793-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79AB19346
	for <lists+linux-raid@lfdr.de>; Sun,  3 Aug 2025 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7A189411B
	for <lists+linux-raid@lfdr.de>; Sun,  3 Aug 2025 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC342877CF;
	Sun,  3 Aug 2025 09:48:37 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41171FDA94;
	Sun,  3 Aug 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754214517; cv=none; b=AS1/XnZbdkZ6AZWsuDJjnNQohchQUftMsyDrncoYpGtXhNK/1NrXe+4NQMCQTwSm7hYonkhTgD3coCf+lM1p+b5OYsxpsWDI2TAFYCn+6ADSuRG2b4ADDKpWO7JlTnkqQ7Tq0ratA5MHt6wNwxCQhjh7J8PatcokDQAyoeDBQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754214517; c=relaxed/simple;
	bh=vTysKUuBKhd077tpR0rQ9hN0FTl7dt5WqeUW5bPObSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR9Ja70wYCFS6Q+hMvAIvs/MMweRYSw3yVxiqYh2qMod8sFMWq+8gvUr71JQdp6XRd1RAo6r1JPnHKTSdPCCMpX7s1OACV30YGr8RCgaGlsnMT2vu3zaNhNcqIGYM4wdWHhwkpdi2KmcKKL+0keCwb4QGf3LG9IBp2M0Wl+Fr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bvvyL6Z1xzYQtJP;
	Sun,  3 Aug 2025 17:48:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F42B1A018C;
	Sun,  3 Aug 2025 17:48:25 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hJnMI9oajGuCQ--.3118S3;
	Sun, 03 Aug 2025 17:48:25 +0800 (CST)
Message-ID: <e6065ccf-4c74-52d3-9f06-7b7cb6499f4e@huaweicloud.com>
Date: Sun, 3 Aug 2025 17:48:23 +0800
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 11/11] md/md-llbitmap: introduce new lockless bitmap
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, corbet@lwn.net,
 song@kernel.org, yukuai3@huawei.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, xni@redhat.com, hare@suse.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250801070346.4127558-1-yukuai1@huaweicloud.com>
 <20250801070346.4127558-12-yukuai1@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20250801070346.4127558-12-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hJnMI9oajGuCQ--.3118S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF48ZFyUuF1DuFykCFW7Arb_yoW8ZF4UpF
	Z7Ar1rA398trs5Ww4UJrZ7Za40yrs8CFn2gr93Z345Jwn09rnakF1kKFs5W3s0g39rAF1k
	Zrs8Kry3Wr95CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiSf
	O3UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/1 15:03, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Redundant data is used to enhance data fault tolerance, and the storage
> method for redundant data vary depending on the RAID levels. And it's
> important to maintain the consistency of redundant data.
> 
> Bitmap is used to record which data blocks have been synchronized and which
> ones need to be resynchronized or recovered. Each bit in the bitmap
> represents a segment of data in the array. When a bit is set, it indicates
> that the multiple redundant copies of that data segment may not be
> consistent. Data synchronization can be performed based on the bitmap after
> power failure or readding a disk. If there is no bitmap, a full disk
> synchronization is required.

This is a large patch, I've found a few minor issues so far.
And I'm still working through it.

[...]

> +	[BitDirty] = {
> +		[BitmapActionStartwrite]	= BitNone,
> +		[BitmapActionStartsync]		= BitNone,
> +		[BitmapActionEndsync]		= BitNone,
> +		[BitmapActionAbortsync]		= BitNone,
> +		[BitmapActionReload]		= BitNeedSync,
> +		[BitmapActionDaemon]		= BitClean,
> +		[BitmapActionDiscard]		= BitUnwritten,
> +		[BitmapActionStale]		= BitNeedSync,
> +	},

Bits becomes BitDirt during degraded remains BitDirty even after recovery 
and re-write. Should we consider adjusting this state transition, or maybe 
trigger the daemon after the recovery is complete?

[...]

> +
> +static int llbitmap_create(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap;
> +	int ret;
> +
> +	ret = llbitmap_check_support(mddev);
> +	if (ret)
> +		return ret;
> +
> +	llbitmap = kzalloc(sizeof(*llbitmap), GFP_KERNEL);
> +	if (!llbitmap)
> +		return -ENOMEM;
> +
> +	llbitmap->mddev = mddev;
> +	llbitmap->io_size = bdev_logical_block_size(mddev->gendisk->part0);
> +	llbitmap->blocks_per_page = PAGE_SIZE / llbitmap->io_size;

logical_block_size can > PAGE_SIZE, blocks_per_page is set to 0 which can
cause issues in later computations.

-- 
Thanks,
Nan


