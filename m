Return-Path: <linux-raid+bounces-4524-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D722AF1006
	for <lists+linux-raid@lfdr.de>; Wed,  2 Jul 2025 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E396E17E1BC
	for <lists+linux-raid@lfdr.de>; Wed,  2 Jul 2025 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113A246BB3;
	Wed,  2 Jul 2025 09:33:45 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF824466C;
	Wed,  2 Jul 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448824; cv=none; b=fGdn67jXXkZQ6/SvedL/OQ/vynX2lZgYDAoCNCgAnt56SEppxcsqKJru+fjwomuaA9ck50Pyw14HiTSucKp5d8FVmh1Cwd9ttb6iIWj2i3+dkAsU8O3byFJciPGje0EMBxUOVkSeNrjLfAI93fNVFMMmQRGp+2eLCgPkd91H/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448824; c=relaxed/simple;
	bh=b9CRuRPjH8bn+fiDF02AF7R2oNXbNMiUBSe4EfhH6DA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QwW+lZV8JBjLXmoaMM5DBZg7fP+RbeTNPLVLPzJcMTvXEyx1A5t0YyZ5uyvjfBr96SKSW6MQlNgsGa39rYAHPdvxKuKn64+sfFrglwePdsCZprDre78cAJL3r6fzqt0NwS4JqjJjXYbhTKGI9xR1bY4ETrhJhQnq6ysIdXYAyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXF8675DMzKHMx3;
	Wed,  2 Jul 2025 17:33:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 63E8F1A083E;
	Wed,  2 Jul 2025 17:33:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyT0_GRoOT2hAQ--.44744S3;
	Wed, 02 Jul 2025 17:33:41 +0800 (CST)
Subject: Re: [PATCH v2 3/5] md/raid10: set chunk_sectors limit
To: John Garry <john.g.garry@oracle.com>, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, hch@lst.de, nilay@linux.ibm.com,
 axboe@kernel.dk
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 ojaswin@linux.ibm.com, martin.petersen@oracle.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250618083737.4084373-1-john.g.garry@oracle.com>
 <20250618083737.4084373-4-john.g.garry@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <13b0be8a-298d-e2eb-aae4-f37273ab2ee2@huaweicloud.com>
Date: Wed, 2 Jul 2025 17:33:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250618083737.4084373-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyT0_GRoOT2hAQ--.44744S3
X-Coremail-Antispam: 1UD129KBjvdXoWruFy8WFWxKr1rAFWUGr4rXwb_yoWfZrcEga
	4fZF13Xr1I9r1I9w1jkF1SkrW5X348WFn7ZFy3Kr45X3WrWF18CFyj934rCa1YyFy2qF1q
	yrs7ua1FyF1kZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

�� 2025/06/18 16:37, John Garry д��:
> Same as done for raid0, set chunk_sectors limit to appropriately set the
> atomic write size limit.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/md/raid10.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index b74780af4c22..97065bb26f43 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4004,6 +4004,7 @@ static int raid10_set_queue_limits(struct mddev *mddev)
>   	md_init_stacking_limits(&lim);
>   	lim.max_write_zeroes_sectors = 0;
>   	lim.io_min = mddev->chunk_sectors << 9;
> +	lim.chunk_sectors = mddev->chunk_sectors;
>   	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
>   	lim.features |= BLK_FEAT_ATOMIC_WRITES;
>   	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
> 


