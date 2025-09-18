Return-Path: <linux-raid+bounces-5177-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF90B436E5
	for <lists+linux-raid@lfdr.de>; Thu,  4 Sep 2025 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EF7189B5D0
	for <lists+linux-raid@lfdr.de>; Thu,  4 Sep 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067C2EE601;
	Thu,  4 Sep 2025 09:19:57 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049362DFA26;
	Thu,  4 Sep 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977597; cv=none; b=IbyI0DfUtkjJo3TJhaPXsHbbAHCi320mdsZhh0QCru580OH78sdzS8z6qv1bPe0lHgCKYRKBoA4jnbYnjqGNqJQIVHs56oB4DVpN/pUU3CiT61ZPpPizR8wVtmXhSqbYQmCyoJvKAVanXgOZLAjSFuLWh9Kj/2OUj3Nv+tqwJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977597; c=relaxed/simple;
	bh=gcxK35ct7x68sSLxRnUL8USHJPcYxUnjSbIyvrRLSPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPUt/gJ1i9GLbFNTcrU8r964OJRsNqr0MQ5fktj1KZxuCyPtzkbn+WHKQV2ZBuxe7EqNmsPLGTrVviLZRmfzFfdZ7eu9Gna6wg2wyT2rP+fxmvINILq185+i4Mqxsla10ZXTGWa8T2yazlFvrjem9MwUJcGq9wqtLgiT2w1X/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cHYpX5x5dzYQvHT;
	Thu,  4 Sep 2025 17:19:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4FAC11A058E;
	Thu,  4 Sep 2025 17:19:47 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY2xWblocc9nBQ--.16239S3;
	Thu, 04 Sep 2025 17:19:47 +0800 (CST)
Message-ID: <e4da9027-abb4-76d1-04df-fff9798baae1@huaweicloud.com>
Date: Thu, 4 Sep 2025 17:19:45 +0800
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 md-6.18 11/11] md/md-llbitmap: introduce new lockless
 bitmap
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, xni@redhat.com,
 colyli@kernel.org, corbet@lwn.net, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com, hare@suse.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com, hailan@yukuai.org.cn
References: <20250829080426.1441678-1-yukuai1@huaweicloud.com>
 <20250829080426.1441678-12-yukuai1@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20250829080426.1441678-12-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY2xWblocc9nBQ--.16239S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF48ZFyUuF1DuFykCFW7Arb_yoW8JFWkpF
	Z7K398CrZ8Ar4fuw1xJrWxZa4rZrWkZr1fKrWrt347Zr98Grn3WF1xKa1FgFyvyryxWF9I
	vr4UKryrGr90kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRB
	Vb9UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/29 16:04, Yu Kuai 写道:
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
> 
> Due to known performance issues with md-bitmap and the unreasonable
> implementations:
> 
>   - self-managed IO submitting like filemap_write_page();
>   - global spin_lock
> 
> I have decided not to continue optimizing based on the current bitmap
> implementation, this new bitmap is invented without locking from IO fast
> path and can be used with fast disks.
> 
> For designs and details, see the comments in drivers/md-llbitmap.c.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

LGTM

Reviewed-by: Li Nan <linan122@huawei.com>

-- 
Thanks,
Nan


