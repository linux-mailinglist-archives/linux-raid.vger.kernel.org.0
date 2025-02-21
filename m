Return-Path: <linux-raid+bounces-3722-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89264A3EFB3
	for <lists+linux-raid@lfdr.de>; Fri, 21 Feb 2025 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBEA1883637
	for <lists+linux-raid@lfdr.de>; Fri, 21 Feb 2025 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791AA202F70;
	Fri, 21 Feb 2025 09:12:56 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793431E9B21;
	Fri, 21 Feb 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129176; cv=none; b=DNde6H7Tz33/kFucat9gGQtiswRSieQQ5kfXuJFEHPPI/gnWdBzcL62g9w4VwIyts8+2LtfYUFh4bLv5aTz0ACOjW1JJKi2y90v5+Sw77/FDillNbvR1M+CSeRy8/et2h3pfa9dkYmZtWCRRTokwU1I8d2ZSReSxCyCpR1Sjoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129176; c=relaxed/simple;
	bh=qBNDGok0ZLX8c5yCRbGm5cdISBhSDit295ASxo2LD70=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mILKsx3IYAYk69Oz3dzZW/mq8aGyzlIyjSVqPYwSrzCf1cGHZ+0PnH6wXE5Rbw0VUgfdg6krBOrZBLhxD/fFaPeOpL3LnCcwMXl3hjOPjoeR1lxm8i+P2Yeb7JG+nilk1kV5mg4iBZ/5X6KeWsfSctB4Ms+gbiWgiK+KKQF4Tsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yzkt32Gq0z4f3lVc;
	Fri, 21 Feb 2025 17:12:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 616171A1A5A;
	Fri, 21 Feb 2025 17:12:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXul6PQ7hnsz_iEQ--.4076S3;
	Fri, 21 Feb 2025 17:12:50 +0800 (CST)
Subject: Re: [PATCH 03/12] badblocks: attempt to merge adjacent badblocks
 during ack_all_badblocks
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk,
 song@kernel.org, colyli@kernel.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 dlemoal@kernel.org, yanjun.zhu@linux.dev, kch@nvidia.com, hare@suse.de,
 zhengqixing@huawei.com, john.g.garry@oracle.com, geliang@kernel.org,
 xni@redhat.com, colyli@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-4-zhengqixing@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <95d0bd33-6142-5b89-bf29-317137db9882@huaweicloud.com>
Date: Fri, 21 Feb 2025 17:12:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250221081109.734170-4-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul6PQ7hnsz_iEQ--.4076S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyDZw4kXF4xWrWUWr1kGrg_yoWkCFc_Z3
	92yFyxJr95AF1fCr1Syr18Jr4SgFn8Cr4xGryUJF1rZ3W7tFZ7JwsYyFn8Wrs8GFyDuwnx
	Ar95Xr1a9ryIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU07PEDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

�� 2025/02/21 16:11, Zheng Qixing д��:
> From: Li Nan <linan122@huawei.com>
> 
> If ack and unack badblocks are adjacent, they will not be merged and will
> remain as two separate badblocks. Even after the bad blocks are written
> to disk and both become ack, they will still remain as two independent
> bad blocks. This is not ideal as it wastes the limited space for
> badblocks. Therefore, during ack_all_badblocks(), attempt to merge
> badblocks if they are adjacent.
> 
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/badblocks.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/badblocks.c b/block/badblocks.c
> index f069c93e986d..ad8652fbe1c8 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -1491,6 +1491,11 @@ void ack_all_badblocks(struct badblocks *bb)
>   				p[i] = BB_MAKE(start, len, 1);
>   			}
>   		}
> +
> +		for (i = 0; i < bb->count ; i++)
> +			while (try_adjacent_combine(bb, i))
> +				;
> +
>   		bb->unacked_exist = 0;
>   	}
>   	write_sequnlock_irq(&bb->lock);
> 


