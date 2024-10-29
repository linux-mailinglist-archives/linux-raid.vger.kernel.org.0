Return-Path: <linux-raid+bounces-3019-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FBF9B415D
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2024 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D851F232C1
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2024 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61101FF612;
	Tue, 29 Oct 2024 03:48:49 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85214D6F9;
	Tue, 29 Oct 2024 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173729; cv=none; b=aXtEpEz21yjsdwm9pQG8Ro4b85QjOJ7HWaD66TQeOGoZ3udM/K+2haPBApGVETcPaJBXdeShuge4C66XgzGtIL5UAx2e8WMl2qgHoOnrkppPHAtAXZvY7k0772k4NJ6KYEOH99SW4Mkdb8ICNdYDznIA4dQyd6nuyswfMlzJ78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173729; c=relaxed/simple;
	bh=USXPNkW1JLvU5U6v4/l83assGNYB7DufPCoszxbbIYE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DMDsEU9sU6pJOZEtEeL9zdDfAJqQynimXcC2A+x+wixNoLbdiMzwfLHOxb24hatWQEESY2ngetreM4jlEdX0JG/GqOVpM7qv2iMQSgnDJxKfwVPwSuSzCuaR6e0HLTjaoGG/J3x/KTgcvaO0Lus1eeoegu9/ghmEA7nH2GBOObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xcx7D2NQYz4f3lV7;
	Tue, 29 Oct 2024 11:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C6C2A1A0568;
	Tue, 29 Oct 2024 11:48:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYYWyBnLln6AA--.41887S3;
	Tue, 29 Oct 2024 11:48:42 +0800 (CST)
Subject: Re: [PATCH v2 6/7] md/raid1: Handle bio_split() errors
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, song@kernel.org,
 hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, hare@suse.de,
 Johannes.Thumshirn@wdc.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241028152730.3377030-1-john.g.garry@oracle.com>
 <20241028152730.3377030-7-john.g.garry@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c79e7bb4-6f53-344e-9651-fc146b12d240@huaweicloud.com>
Date: Tue, 29 Oct 2024 11:48:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241028152730.3377030-7-john.g.garry@oracle.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYYWyBnLln6AA--.41887S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UtrWxtF4xtw13Zw18Zrb_yoW5uFy8pr
	4jga1S9rW3JFWagwnxtFZF9a4F9F4vqFW2krWxJ3s7JFnIqryDKF4UXFWYgry5uFy5ury7
	Aw1kCr4DurW2gFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/10/28 23:27, John Garry д��:
> Add proper bio_split() error handling. For any error, call
> raid_end_bio_io() and return.
> 
> For the case of an in the write path, we need to undo the increment in
> the rdev panding count and NULLify the r1_bio->bios[] pointers.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/md/raid1.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 6c9d24203f39..a10018282629 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1322,7 +1322,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
>   	const enum req_op op = bio_op(bio);
>   	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
>   	int max_sectors;
> -	int rdisk;
> +	int rdisk, error;
>   	bool r1bio_existed = !!r1_bio;
>   
>   	/*
> @@ -1383,6 +1383,11 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
>   	if (max_sectors < bio_sectors(bio)) {
>   		struct bio *split = bio_split(bio, max_sectors,
>   					      gfp, &conf->bio_split);
> +
> +		if (IS_ERR(split)) {
> +			error = PTR_ERR(split);
> +			goto err_handle;
> +		}
>   		bio_chain(split, bio);
>   		submit_bio_noacct(bio);
>   		bio = split;
> @@ -1410,6 +1415,12 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
>   	read_bio->bi_private = r1_bio;
>   	mddev_trace_remap(mddev, read_bio, r1_bio->sector);
>   	submit_bio_noacct(read_bio);
> +	return;
> +
> +err_handle:
> +	bio->bi_status = errno_to_blk_status(error);
> +	set_bit(R1BIO_Uptodate, &r1_bio->state);
> +	raid_end_bio_io(r1_bio);
>   }
>   
>   static void raid1_write_request(struct mddev *mddev, struct bio *bio,
> @@ -1417,7 +1428,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>   {
>   	struct r1conf *conf = mddev->private;
>   	struct r1bio *r1_bio;
> -	int i, disks;
> +	int i, disks, k, error;
>   	unsigned long flags;
>   	struct md_rdev *blocked_rdev;
>   	int first_clone;
> @@ -1576,6 +1587,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>   	if (max_sectors < bio_sectors(bio)) {
>   		struct bio *split = bio_split(bio, max_sectors,
>   					      GFP_NOIO, &conf->bio_split);
> +
> +		if (IS_ERR(split)) {
> +			error = PTR_ERR(split);
> +			goto err_handle;
> +		}
>   		bio_chain(split, bio);
>   		submit_bio_noacct(bio);
>   		bio = split;
> @@ -1660,6 +1676,18 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>   
>   	/* In case raid1d snuck in to freeze_array */
>   	wake_up_barrier(conf);
> +	return;
> +err_handle:
> +	for (k = 0; k < i; k++) {
> +		if (r1_bio->bios[k]) {
> +			rdev_dec_pending(conf->mirrors[k].rdev, mddev);
> +			r1_bio->bios[k] = NULL;
> +		}
> +	}
> +
> +	bio->bi_status = errno_to_blk_status(error);
> +	set_bit(R1BIO_Uptodate, &r1_bio->state);
> +	raid_end_bio_io(r1_bio);

Looks good that error code is passed to orig bio. However,
I really think badblocks should be handled somehow, it just doesn't make
sense to return IO error to filesystems or user if one underlying disk
contain BB, while others are good.

Or is it guaranteed that IO error by atomic write won't hurt anyone,
user will handle this error and retry with non atomic write?

Thanks,
Kuai
>   }
>   
>   static bool raid1_make_request(struct mddev *mddev, struct bio *bio)
> 


