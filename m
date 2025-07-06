Return-Path: <linux-raid+bounces-4523-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50EAF1004
	for <lists+linux-raid@lfdr.de>; Wed,  2 Jul 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B30B1C26ACA
	for <lists+linux-raid@lfdr.de>; Wed,  2 Jul 2025 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DEE2459D1;
	Wed,  2 Jul 2025 09:33:34 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02E19E81F;
	Wed,  2 Jul 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448813; cv=none; b=KpakJe1F3tN7yt32t9JctmJNSrbuON6iBKzEObfmShRBCrwPa9R6u6jaE+J/qJ8CkLxWFbzQKqv5Tp/mgHpvqiQWMQhfRCdcTJP/RMyW+nsQTpvfUafnWM+vGWZKgF0z5CkQnfM9lN8E2XKE5bBd2g0xn5w0sJ89CuM0pcTSYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448813; c=relaxed/simple;
	bh=pRXeGSm5U8t6McKHv4FJUjNRqcN1PJC9D1NoG+rE8nk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VpEtV5lNHWwQHhyb3JfOausA6cqIFbrRD8PkjW5EjRzj8ScG9cTsqDCb7N5CDBRXdibNhAl2/5mZmtq5cKFOZQk2Lt7wj/x4yolKMVzslMx5LqMEtzM2o1/YSQfvg6UBFRb0xTP8LgCJmZ0HF04GEpFJmICNCzFXFqSN3dpRoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bXF7m5jzmzYQtqL;
	Wed,  2 Jul 2025 17:33:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A57D01A0E2C;
	Wed,  2 Jul 2025 17:33:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgBXuSbh_GRoMzehAQ--.48711S3;
	Wed, 02 Jul 2025 17:33:23 +0800 (CST)
Subject: Re: [PATCH v2 2/5] md/raid0: set chunk_sectors limit
To: John Garry <john.g.garry@oracle.com>, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, hch@lst.de, nilay@linux.ibm.com,
 axboe@kernel.dk
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 ojaswin@linux.ibm.com, martin.petersen@oracle.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250618083737.4084373-1-john.g.garry@oracle.com>
 <20250618083737.4084373-3-john.g.garry@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d6191575-8fd8-9f46-081a-6dddd44818c1@huaweicloud.com>
Date: Wed, 2 Jul 2025 17:33:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250618083737.4084373-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXuSbh_GRoMzehAQ--.48711S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4UWFy7AF1DZF1xWFWDCFg_yoW8Gr1fpw
	43XFy2vryUJayxu3WDX39rCF4Fq34kGrW29Fy3Zry0gr9rWr1IgrW3JF98XF9Fy3W3Jw17
	X3W0kF9rG3WjgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

�� 2025/06/18 16:37, John Garry д��:
> Currently we use min io size as the chunk size when deciding on the
> atomic write size limits - see blk_stack_atomic_writes_head().
> 
> The limit min_io size is not a reliable value to store the chunk size, as
> this may be mutated by the block stacking code. Such an example would be
> for the min io size less than the physical block size, and the min io size
> is raised to the physical block size - see blk_stack_limits().
> 
> The block stacking limits will rely on chunk_sectors in future,
> so set this value (to the chunk size).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/md/raid0.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Sorry about the delay.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index d8f639f4ae12..cbe2a9054cb9 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -384,6 +384,7 @@ static int raid0_set_limits(struct mddev *mddev)
>   	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
>   	lim.io_min = mddev->chunk_sectors << 9;
>   	lim.io_opt = lim.io_min * mddev->raid_disks;
> +	lim.chunk_sectors = mddev->chunk_sectors;
>   	lim.features |= BLK_FEAT_ATOMIC_WRITES;
>   	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
>   	if (err)
> 


