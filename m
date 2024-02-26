Return-Path: <linux-raid+bounces-871-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6A8673E1
	for <lists+linux-raid@lfdr.de>; Mon, 26 Feb 2024 12:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00283B28663
	for <lists+linux-raid@lfdr.de>; Mon, 26 Feb 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880331DA20;
	Mon, 26 Feb 2024 11:29:18 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4631D535;
	Mon, 26 Feb 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946958; cv=none; b=VuWqEqm43v+cZn4G7BpV16yprzFDAFYTyivfWWnqrI40UpsWNVFWBBAzpMhaDFuh+Uo9iFk7kg2gPMyzJ3nC1zfxbnsp5gwsoByvWJpkvxX6IgvU9HSjxsE2jHLJeBB0qOzoCqHf2kuZmHu2Bh72iMdYkniCWFxgVMRvVhxl8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946958; c=relaxed/simple;
	bh=pJe2OMLYkfL5IjTUWrlWBKDjsjcYJ0V4uwUsGj39Zbs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AAOhn1iO3YZ/P4NIjpV1bIWyPET6GyMSesBFvTNXmCd9mimo7LE5zuSCX8sOb9glBQUOUKKDu2GSaM1uZPSxSjIUEjV2hiK/DTkifFLkTw4btVVOYBqkCtpbwdKI84AgHlell8tkwtr2o97MlUimIZnvCnLFMjXGIb/VRla2fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tjz0K6L4pz4f3jsN;
	Mon, 26 Feb 2024 19:29:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 143A11A0232;
	Mon, 26 Feb 2024 19:29:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBEFdtxlmJrWFA--.41964S3;
	Mon, 26 Feb 2024 19:29:10 +0800 (CST)
Subject: Re: [PATCH 06/16] md/raid1: use the atomic queue limit update APIs
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240226103004.281412-1-hch@lst.de>
 <20240226103004.281412-7-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b4828284-87ec-693b-e2c3-84bdafcbda65@huaweicloud.com>
Date: Mon, 26 Feb 2024 19:29:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240226103004.281412-7-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBEFdtxlmJrWFA--.41964S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5Kw47ZFy5Zw47Zr1fWFg_yoW8uF1Up3
	92qFy3Kr48JFyagryUJw4DWF1Fvws7KrWkKFyxJws2qr4Sqry5Wa1F9r45WryfA3s5Zw13
	Jw4UCrZrGF12gFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/02/26 18:29, Christoph Hellwig д��:
> Build the queue limits outside the queue and apply them using
> queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
> checks in the are while touching it.

The checking of mddev->gendisk can't be removed, because this is used to
distinguish dm-raid and md/raid. And the same for following patches.

Thanks,
Kuai

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/raid1.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 286f8b16c7bde7..752ff99736a636 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1791,10 +1791,9 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	for (mirror = first; mirror <= last; mirror++) {
>   		p = conf->mirrors + mirror;
>   		if (!p->rdev) {
> -			if (mddev->gendisk)
> -				disk_stack_limits(mddev->gendisk, rdev->bdev,
> -						  rdev->data_offset << 9);
> -
> +			err = mddev_stack_new_rdev(mddev, rdev);
> +			if (err)
> +				return err;
>   			p->head_position = 0;
>   			rdev->raid_disk = mirror;
>   			err = 0;
> @@ -3089,9 +3088,9 @@ static struct r1conf *setup_conf(struct mddev *mddev)
>   static void raid1_free(struct mddev *mddev, void *priv);
>   static int raid1_run(struct mddev *mddev)
>   {
> +	struct queue_limits lim;
>   	struct r1conf *conf;
>   	int i;
> -	struct md_rdev *rdev;
>   	int ret;
>   
>   	if (mddev->level != 1) {
> @@ -3118,15 +3117,12 @@ static int raid1_run(struct mddev *mddev)
>   	if (IS_ERR(conf))
>   		return PTR_ERR(conf);
>   
> -	if (mddev->queue)
> -		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
> -
> -	rdev_for_each(rdev, mddev) {
> -		if (!mddev->gendisk)
> -			continue;
> -		disk_stack_limits(mddev->gendisk, rdev->bdev,
> -				  rdev->data_offset << 9);
> -	}
> +	blk_set_stacking_limits(&lim);
> +	lim.max_write_zeroes_sectors = 0;
> +	mddev_stack_rdev_limits(mddev, &lim);
> +	ret = queue_limits_set(mddev->queue, &lim);
> +	if (ret)
> +		goto abort;
>   
>   	mddev->degraded = 0;
>   	for (i = 0; i < conf->raid_disks; i++)
> 


