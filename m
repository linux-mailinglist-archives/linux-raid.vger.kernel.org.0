Return-Path: <linux-raid+bounces-4646-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED817B06E5A
	for <lists+linux-raid@lfdr.de>; Wed, 16 Jul 2025 08:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EE417CE96
	for <lists+linux-raid@lfdr.de>; Wed, 16 Jul 2025 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248AD28934A;
	Wed, 16 Jul 2025 06:58:28 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549817B50A;
	Wed, 16 Jul 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649107; cv=none; b=kWqixdtfMN/pvi9kG8gQ6jkHS5RZCpfUJQOGliM2c0xP6sym6d7LKNpgkm/5kyoSPDA4owmNS1rDATwNZqd3qPlMRMcIMMvOp+iD5G0EkTZucC/qcud06V7dDUoGu3jnCyxLCc8GtRTKupKhPM9oypm7R4u8iDk6nOJHgraMMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649107; c=relaxed/simple;
	bh=iPzTt+OMPWwkamxpAELM4nzzWwGX+4YWjNi7kAVYOeA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tIejvhVw/P2dt1p77ocvKAJ8nH8jKj+nNFile1AvCW61pxwGYS36C5nqimvldpvbWzSZfoMSIdgNhv92SNM2Ag2JRnizSzcw9ALPliHmuVX3mW4uWbVlsJmaEtxWsW3tMIkxNrElWP0Bza0OBmK4zHDmre+pzjESihLVk6rqhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bhn2K3q13zYQv46;
	Wed, 16 Jul 2025 14:58:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 478541A0CC9;
	Wed, 16 Jul 2025 14:58:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3MxSFTXdo+La8AQ--.3154S3;
	Wed, 16 Jul 2025 14:58:14 +0800 (CST)
Subject: Re: [RFC PATCH] md: split bio by io_opt size in md_submit_bio()
To: colyli@kernel.org, linux-raid@vger.kernel.org
Cc: linux-block@vger.kernel.org, Xiao Ni <xni@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250715180241.29731-1-colyli@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f158675c-7bbe-45d4-413b-3e984589d08f@huaweicloud.com>
Date: Wed, 16 Jul 2025 14:58:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250715180241.29731-1-colyli@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3MxSFTXdo+La8AQ--.3154S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1DXrWUCF4rKFy3Ww17ZFb_yoW7Ary7pr
	WUWr9avrWkJFsF9wnxJ3W2kFnY93yrXry5ArW7Z3yUCrsIgwnFkFWxWw1rZF13Cr1rCw1U
	tw4FvFyYk3WqkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/07/16 2:02, colyli@kernel.org д��:
> From: Coly Li <colyli@kernel.org>
> 
> Currently in md_submit_bio() the incoming request bio is split by
> bio_split_to_limits() which makes sure the bio won't exceed
> max_hw_sectors of a specific raid level before senting into its
> .make_request method.
> 
> For raid level 4/5/6 such split method might be problematic and hurt
> large read/write perforamnce. Because limits.max_hw_sectors are not
> always aligned to limits.io_opt size, the split bio won't be full
> stripes covered on all data disks, and will introduce extra read-in I/O.
> Even the bio's bi_sector is aligned to limits.io_opt size and large
> enough, the resulted split bio is not size-friendly to corresponding
> raid456 level.
> 
> This patch introduces bio_split_by_io_opt() to solve the above issue,
> 1, If the incoming bio is not limits.io_opt aligned, split the non-
>     aligned head part. Then the next one will be aligned.
> 2, If the imcoming bio is limits.io_opt aligned, and split is necessary,
>     then try to split a by multiple of limits.io_opt but not exceed
>     limits.max_hw_sectors.
> 
> Then for large bio, the sligned split part will be full-stripes covered
> to all data disks, no extra read-in I/Os when rmw_level is 0. And for
> rmw_level > 0 condistions, the limits.io_opt aligned bios are welcomed
> for performace as well.
> 
> This RFC patch only tests on 8 disks raid5 array with 64KiB chunk size.
> By this patch, 64KiB chunk size for a 8 disks raid5 array, sequential
> write performance increases from 900MiB/s to 1.1GiB/s by fio bs=10M.
> If fio bs=488K (exact limits.io_opt size) the peak sequential write
> throughput can reach 1.51GiB/s.
> 
> (Resend to include Christoph and Keith in CC list.)
> 
> Signed-off-by: Coly Li <colyli@kernel.org>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Xiao Ni <xni@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/md/md.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0f03b21e66e4..363cff633af3 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -426,6 +426,67 @@ bool md_handle_request(struct mddev *mddev, struct bio *bio)
>   }
>   EXPORT_SYMBOL(md_handle_request);
>   
> +static struct bio *bio_split_by_io_opt(struct bio *bio)
> +{
> +	sector_t io_opt_sectors, sectors, n;
> +	struct queue_limits lim;
> +	struct mddev *mddev;
> +	struct bio *split;
> +	int level;
> +
> +	mddev = bio->bi_bdev->bd_disk->private_data;
> +	level = mddev->level;
> +	if (level == 1 || level == 10 || level == 0 || level == LEVEL_LINEAR)
> +		return bio_split_to_limits(bio);

There is another patch that provide a helper raid_is_456()
https://lore.kernel.org/all/20250707165202.11073-3-yukuai@kernel.org/

You might want to use it here.
> +
> +	lim = mddev->gendisk->queue->limits;
> +	io_opt_sectors = min3(bio_sectors(bio), lim.io_opt >> SECTOR_SHIFT,
> +			      lim.max_hw_sectors);

You might want to use max_sectors here, to honor user setting.

And max_hw_sectors is just for normal read and write, for other IO like
discard, atomic write, write zero, the limit is different.

> +
> +	/* No need to split */
> +	if (bio_sectors(bio) == io_opt_sectors)
> +		return bio;
> +

If the bio happend to accross two io_opt, do you think it's better to
split it here? For example:

io_opt is 64k(chunk size) * 7 = 448k, issue an IO start from 444k with
len = 8k. raid5 will have to use 2 stripes to handle such IO.

> +	n = bio->bi_iter.bi_sector;
> +	sectors = do_div(n, io_opt_sectors);
> +	/* Aligned to io_opt size and no need to split for radi456 */
> +	if (!sectors && (bio_sectors(bio) <=  lim.max_hw_sectors))
> +		return bio;

I'm confused here, do_div doesn't mean aligned, should bio_offset() be
taken into consideration? For example, issue an IO start from 4k with
len = 448 * 2 k, if I read the code correctly, the result is:

4 + 896 -> 4 + 896 (not split if within max_sectors)

What we really expect is:

4 + 896 -> 4 + 444, 448 + 448, 892 + 4
> +
> +	if (sectors) {
> +		/**
> +		 * Not aligned to io_opt, split
> +		 * non-aligned head part.
> +		 */
> +		sectors = io_opt_sectors - sectors;
> +	} else {
> +		/**
> +		 * Aligned to io_opt, split to the largest multiple
> +		 * of io_opt within max_hw_sectors, to make full
> +		 * stripe write/read for underlying raid456 levels.
> +		 */
> +		n = lim.max_hw_sectors;
> +		do_div(n, io_opt_sectors);
> +		sectors = n * io_opt_sectors;

roundown() ?
> +	}
> +
> +	/* Almost won't happen */
> +	if (unlikely(sectors >= bio_sectors(bio))) {
> +		pr_warn("%s raid level %d: sectors %llu >= bio_sectors %u, not split\n",
> +			__func__, level, sectors, bio_sectors(bio));
> +		return bio;
> +	}
> +
> +	split = bio_split(bio, sectors, GFP_NOIO,
> +			  &bio->bi_bdev->bd_disk->bio_split);
> +	if (!split)
> +		return bio;
> +	split->bi_opf |= REQ_NOMERGE;
> +	bio_chain(split, bio);
> +	submit_bio_noacct(bio);
> +	return split;
> +}
> +
>   static void md_submit_bio(struct bio *bio)
>   {
>   	const int rw = bio_data_dir(bio);
> @@ -441,7 +502,7 @@ static void md_submit_bio(struct bio *bio)
>   		return;
>   	}
>   
> -	bio = bio_split_to_limits(bio);
> +	bio = bio_split_by_io_opt(bio);
>   	if (!bio)
>   		return;
>   
> 

Thanks,
Kuai


