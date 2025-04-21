Return-Path: <linux-raid+bounces-4017-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DFA9516C
	for <lists+linux-raid@lfdr.de>; Mon, 21 Apr 2025 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832A27A77CB
	for <lists+linux-raid@lfdr.de>; Mon, 21 Apr 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D3265CA8;
	Mon, 21 Apr 2025 13:14:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D32586EC;
	Mon, 21 Apr 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241247; cv=none; b=g2g31h18BfjZAVVtrP+DjJ6rrX2anHG8bem9IrxTumDCbRylex+BK1wrWfyQCF4Duqyrzd7Ktfi5TrzKuDDdCZ/B9BTCiXszcyBVTZPq0yB71Lw2Uy2WyU8IA77kt3WlnrCprL+mAvS+zZtkrEa95TfTFUQY5nP2moQWL43XUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241247; c=relaxed/simple;
	bh=IdQbmGzuuQ6dFSsgC24zxtxhDHuKqzcmqcVagXyTWp0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S83tyb8E4FDbHsNe40ANce5wyuj75Ez0JKGsvDSBi6oQnk8/sHQv9nyS2+wshrUHkNyo+Y/GEVop6e3D8K6ll8u5XKqCtGh62cJAfuj7UfNaOzvK+2pRzoOO5W+ZNFwQGFWOIeIxab7vlwXJxFhjAEMZ8xc18cl2cBUoTpS3pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zh5R3727tz4f3jY8;
	Mon, 21 Apr 2025 21:13:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D61191A06D7;
	Mon, 21 Apr 2025 21:13:59 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1+VRAZoJ06RKA--.64775S3;
	Mon, 21 Apr 2025 21:13:59 +0800 (CST)
Subject: Re: [PATCH v2 1/5] block: cleanup and export bdev IO inflight APIs
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, nadav.amit@gmail.com, ubizjak@gmail.com,
 cl@linux.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250418010941.667138-1-yukuai1@huaweicloud.com>
 <20250418010941.667138-2-yukuai1@huaweicloud.com>
 <aAYzPYGR_eF7qveO@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f01cb2d7-d69c-1565-d3e4-09c4b70856f6@huaweicloud.com>
Date: Mon, 21 Apr 2025 21:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAYzPYGR_eF7qveO@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1+VRAZoJ06RKA--.64775S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrtrW5Xw1rXF1UAryfCrg_yoW8KrW5pF
	4UKa98trWDGr1xur1Iqws7ZFySyws8GryS9r1Sy3sI9r1DJr1fur4xtrsrCF4xtrZ2kFnr
	u3WYyFyxuFsYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/04/21 19:59, Christoph Hellwig д��:
> On Fri, Apr 18, 2025 at 09:09:37AM +0800, Yu Kuai wrote:
>> - remove unused blk_mq_in_flight
> 
> That should probably be a separate patch.
ok

> 
>> - rename blk_mq_in_flight_rw to blk_mq_count_in_driver_rw, to distinguish
>>    from bdev_count_inflight_rw.
> 
> I'm not sure why this is needed or related, or even what additional
> distinction is added here.

Because for rq-based device, there are two different stage,
blk_account_io_start() while allocating new rq, and
blk_mq_start_request() while issuing the rq to driver.

When will we think the reqeust is inflight? For iostat, my anser is the
former one, because rq->start_time_ns is set here as well. And noted in
iostats api diskstats_show��/proc/diskstats) and part_stat_show
(/sys/block/sda/stat), inflight is get by part_in_flight, which is
different from disk sysfs api(/sys/block/sda/inflight).

> 
>> -
>> -void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
>> -		unsigned int inflight[2])
>> +void blk_mq_count_in_driver_rw(struct request_queue *q,
>> +			       struct block_device *part,
>> +			       unsigned int inflight[2])
> 
> Any reason to move away from two tab indents for the prototype
> continuations in various places in this patch?
> 
>> + * Noted, for rq-based block device, use blk_mq_count_in_driver_rw() to get the
>> + * number of requests issued to driver.
> 
> I'd just change this helper to call blk_mq_count_in_driver_rw for
> blk-mq devices and remove the conditional from the sysfs code instead.
> That gives us a much more robust and easier to understand API.

Ok, and another separate patch, right?
> 
>> +void bdev_count_inflight_rw(struct block_device *bdev, unsigned int inflight[2]);
> 
> Overly long line.
> 
>> +static inline unsigned int bdev_count_inflight(struct block_device *bdev)
>> +{
>> +	unsigned int inflight[2];
>> +
>> +	bdev_count_inflight_rw(bdev, inflight);
>> +
>> +	return inflight[0] + inflight[1];
>> +}
>>   #endif /* _LINUX_PART_STAT_H */
> 
> Maybe keep this inside of block as it should not not be used by
> drivers?  Also the reimplementation should probably be a separate
> patch from the public API change and exporting.

ok, and I should probably send the first set just related to this patch
first.

Thanks,
Kuai

> 
> .
> 


