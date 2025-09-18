Return-Path: <linux-raid+bounces-5013-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DFBB37EFF
	for <lists+linux-raid@lfdr.de>; Wed, 27 Aug 2025 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BFA1BA4807
	for <lists+linux-raid@lfdr.de>; Wed, 27 Aug 2025 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCD343D98;
	Wed, 27 Aug 2025 09:39:25 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F133EAFC;
	Wed, 27 Aug 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287565; cv=none; b=UdHIcXyQ2o8pgzR0kL86dVJDr2ribz4KrnIQzM70wN0RsotxYlFUzRoU/OrEGb3wVFNO65zOCPDL4pOuh6+B0sVtPGjFjXVt5Lqri6rCicVY5NMlSAMzWUgpwk8usEvokYcB3zh5yp2xAM/VS8qTO8JKjhyHvujCVEqL98F6c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287565; c=relaxed/simple;
	bh=zw1PL8xJM48vbCdedO5ZOOTHVWK08Kl6Hj6+CfL5B2I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IYMpoSogZtJyT4fm/Ye81sLgMQQYglaUdnsmCN3Pg63WuIFfHFJ3ZxGCV6swXHfHlvw5CeQ4mvT/WJd9GT2Nz3xjL/Cd9TPke85zGf70KUuPvRH8y3dIfQVWt1OOn1v1ScFIfbSLKjqFcvq4VfDEkLxaQru8OZTzX5vb/sGLAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cBfcm6SqvzYQvgM;
	Wed, 27 Aug 2025 17:39:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6BF7E1A1160;
	Wed, 27 Aug 2025 17:39:19 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY1F0q5oArvWAQ--.55265S3;
	Wed, 27 Aug 2025 17:39:19 +0800 (CST)
Subject: Re: [PATCH v3 2/2] md: allow configuring logical_block_size
To: linan666@huaweicloud.com, song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.petersen@oracle.com, bvanassche@acm.org, hch@infradead.org,
 filipe.c.maia@gmail.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250825075924.2696723-1-linan666@huaweicloud.com>
 <20250825075924.2696723-3-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9bf88741-9fdb-6061-8518-ab460e89985e@huaweicloud.com>
Date: Wed, 27 Aug 2025 17:39:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250825075924.2696723-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY1F0q5oArvWAQ--.55265S3
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWfGw4DAF47Aw4fKFWDtwb_yoWkGr48pa
	97ZFyfu34UXayYya9rXa4ku3WrW3yUGFWqkryagw40vr9I9r17GF4fWFW5Xryqqwn8AwnF
	q3WDKrWDu3Z2grDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/08/25 15:59, linan666@huaweicloud.com д��:
> From: Li Nan <linan122@huawei.com>
> 
> Previously, raid array used the maximum logical_block_size (LBS) of
> all member disks. Adding a larger LBS during disk at runtime could
> unexpectedly increase RAID's LBS, risking corruption of existing
> partitions.
> Simply restricting larger-LBS disks is inflexible. In some scenarios,
> only disks with 512 LBS are available currently, but later, disks with
> 4k LBS may be added to the array.
> 
> Making LBS configurable is the best way to solve this scenario.
> After this patch, the raid will:
>    - stores LBS in disk metadata.
>    - add a read-write sysfs 'mdX/logical_block_size'.
> 
> Future mdadm should support setting LBS via metadata field during RAID
> creation and the new sysfs. Though the kernel allows runtime LBS changes,
> users should avoid modifying it after creating partitions or filesystems
> to prevent compatibility issues.
> 
> Note that many RAID paths rely on PAGE_SIZE alignment, including for
> metadata I/O. A logical_block_size larger than PAGE_SIZE will result in
> metadata reads/writes failures. So this config should be prevented.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.h                |  1 +
>   include/uapi/linux/raid/md_p.h |  6 ++-
>   drivers/md/md-linear.c         |  1 +
>   drivers/md/md.c                | 75 ++++++++++++++++++++++++++++++++++
>   drivers/md/raid0.c             |  1 +
>   drivers/md/raid1.c             |  1 +
>   drivers/md/raid10.c            |  1 +
>   drivers/md/raid5.c             |  1 +
>   8 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 1979c2d4fe89..0202f6feedea 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -432,6 +432,7 @@ struct mddev {
>   	sector_t			array_sectors; /* exported array size */
>   	int				external_size; /* size managed
>   							* externally */
> +	unsigned int			logical_block_size;
>   	__u64				events;
>   	/* If the last 'event' was simply a clean->dirty transition, and
>   	 * we didn't write it to the spares, then it is safe and simple
> diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md_p.h
> index ac74133a4768..190d493044a8 100644
> --- a/include/uapi/linux/raid/md_p.h
> +++ b/include/uapi/linux/raid/md_p.h
> @@ -180,7 +180,8 @@ typedef struct mdp_superblock_s {
>   	__u32 delta_disks;	/* 15 change in number of raid_disks	      */
>   	__u32 new_layout;	/* 16 new layout			      */
>   	__u32 new_chunk;	/* 17 new chunk size (bytes)		      */
> -	__u32 gstate_sreserved[MD_SB_GENERIC_STATE_WORDS - 18];
> +	__u32 logical_block_size;	/* same as q->limits->logical_block_size */
> +	__u32 gstate_sreserved[MD_SB_GENERIC_STATE_WORDS - 19];
>   
>   	/*
>   	 * Personality information
> @@ -291,7 +292,8 @@ struct mdp_superblock_1 {
>   	__le64	resync_offset;	/* data before this offset (from data_offset) known to be in sync */
>   	__le32	sb_csum;	/* checksum up to devs[max_dev] */
>   	__le32	max_dev;	/* size of devs[] array to consider */
> -	__u8	pad3[64-32];	/* set to 0 when writing */
> +	__le32  logical_block_size;	/* same as q->limits->logical_block_size */
> +	__u8	pad3[64-36];	/* set to 0 when writing */
>   
>   	/* device state information. Indexed by dev_number.
>   	 * 2 bytes per device
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 5d9b08115375..da8babb8da59 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -72,6 +72,7 @@ static int linear_set_limits(struct mddev *mddev)
>   
>   	md_init_stacking_limits(&lim);
>   	lim.max_hw_sectors = mddev->chunk_sectors;
> +	lim.logical_block_size = mddev->logical_block_size;
>   	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
>   	lim.io_min = mddev->chunk_sectors << 9;
>   	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 206434591b97..e78f80d39271 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1467,6 +1467,7 @@ static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, stru
>   		mddev->bitmap_info.default_offset = MD_SB_BYTES >> 9;
>   		mddev->bitmap_info.default_space = 64*2 - (MD_SB_BYTES >> 9);
>   		mddev->reshape_backwards = 0;
> +		mddev->logical_block_size = sb->logical_block_size;
>   
>   		if (mddev->minor_version >= 91) {
>   			mddev->reshape_position = sb->reshape_position;
> @@ -1629,6 +1630,7 @@ static void super_90_sync(struct mddev *mddev, struct md_rdev *rdev)
>   
>   	sb->layout = mddev->layout;
>   	sb->chunk_size = mddev->chunk_sectors << 9;
> +	sb->logical_block_size = mddev->logical_block_size;
>   
>   	if (mddev->bitmap && mddev->bitmap_info.file == NULL)
>   		sb->state |= (1<<MD_SB_BITMAP_PRESENT);
> @@ -1963,6 +1965,7 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struc
>   		mddev->layout = le32_to_cpu(sb->layout);
>   		mddev->raid_disks = le32_to_cpu(sb->raid_disks);
>   		mddev->dev_sectors = le64_to_cpu(sb->size);
> +		mddev->logical_block_size = le32_to_cpu(sb->logical_block_size);
>   		mddev->events = ev1;
>   		mddev->bitmap_info.offset = 0;
>   		mddev->bitmap_info.space = 0;
> @@ -2172,6 +2175,7 @@ static void super_1_sync(struct mddev *mddev, struct md_rdev *rdev)
>   	sb->chunksize = cpu_to_le32(mddev->chunk_sectors);
>   	sb->level = cpu_to_le32(mddev->level);
>   	sb->layout = cpu_to_le32(mddev->layout);
> +	sb->logical_block_size = cpu_to_le32(mddev->logical_block_size);
>   	if (test_bit(FailFast, &rdev->flags))
>   		sb->devflags |= FailFast1;
>   	else
> @@ -5900,6 +5904,64 @@ static struct md_sysfs_entry md_serialize_policy =
>   __ATTR(serialize_policy, S_IRUGO | S_IWUSR, serialize_policy_show,
>          serialize_policy_store);
>   

I'll prefer we only support to configre it in super 1, because super 90
support autodetect where all fields looks like have to be the default
value.

> +static int mddev_set_logical_block_size(struct mddev *mddev,
> +				unsigned int lbs)
> +{
> +	int err = 0;
> +	struct queue_limits lim;
> +
> +	if (queue_logical_block_size(mddev->gendisk->queue) >= lbs) {

I think this sysfs entry to configure lbs is useful only if user want to
build new array manually without user tools like mdadm, hence the
condition should be array is not running. And I feel it doesn't make
sense to change lbs with running array.

BTW, please add documentations about this new attribute.

Thanks,
Kuai

> +		pr_err("%s: incompatible logical_block_size %u, can not set\n",
> +		       mdname(mddev), lbs);
> +		return -EINVAL;
> +	}
> +
> +	lim = queue_limits_start_update(mddev->gendisk->queue);
> +	lim.logical_block_size = lbs;
> +	pr_info("%s: logical_block_size is changed, data may be lost\n",
> +		mdname(mddev));
> +	err = queue_limits_commit_update(mddev->gendisk->queue, &lim);
> +	if (err)
> +		return err;
> +
> +	mddev->logical_block_size = lbs;
> +	md_update_sb(mddev, 1);
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +lbs_show(struct mddev *mddev, char *page)
> +{
> +	return sprintf(page, "%u\n", mddev->logical_block_size);
> +}
> +
> +static ssize_t
> +lbs_store(struct mddev *mddev, const char *buf, size_t len)
> +{
> +	unsigned int lbs;
> +	int err = -EBUSY;
> +
> +	if (mddev->pers)
> +		goto unlock;
> +
> +	err = kstrtouint(buf, 10, &lbs);
> +	if (err < 0)
> +		return err;
> +
> +	err = mddev_lock(mddev);
> +	if (err)
> +		return err;
> +
> +	err = mddev_set_logical_block_size(mddev, lbs);
> +
> +unlock:
> +	mddev_unlock(mddev);
> +	return err ?: len;
> +}
> +
> +static struct md_sysfs_entry md_logical_block_size =
> +__ATTR(logical_block_size, S_IRUGO|S_IWUSR, lbs_show, lbs_store);
>   
>   static struct attribute *md_default_attrs[] = {
>   	&md_level.attr,
> @@ -5933,6 +5995,7 @@ static struct attribute *md_redundancy_attrs[] = {
>   	&md_scan_mode.attr,
>   	&md_last_scan_mode.attr,
>   	&md_mismatches.attr,
> +	&md_logical_block_size.attr,
>   	&md_sync_min.attr,
>   	&md_sync_max.attr,
>   	&md_sync_io_depth.attr,
> @@ -6052,6 +6115,17 @@ int mddev_stack_rdev_limits(struct mddev *mddev, struct queue_limits *lim,
>   			return -EINVAL;
>   	}
>   
> +	/*
> +	 * Before RAID adding folio support, the logical_block_size
> +	 * should be smaller than the page size.
> +	 */
> +	if (lim->logical_block_size > PAGE_SIZE) {
> +		pr_err("%s: logical_block_size must not larger than PAGE_SIZE\n",
> +			mdname(mddev));
> +		return -EINVAL;
> +	}
> +	mddev->logical_block_size = lim->logical_block_size;
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(mddev_stack_rdev_limits);
> @@ -6690,6 +6764,7 @@ static void md_clean(struct mddev *mddev)
>   	mddev->chunk_sectors = 0;
>   	mddev->ctime = mddev->utime = 0;
>   	mddev->layout = 0;
> +	mddev->logical_block_size = 0;
>   	mddev->max_disks = 0;
>   	mddev->events = 0;
>   	mddev->can_decrease_events = 0;
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f1d8811a542a..705889a09fc1 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -382,6 +382,7 @@ static int raid0_set_limits(struct mddev *mddev)
>   	md_init_stacking_limits(&lim);
>   	lim.max_hw_sectors = mddev->chunk_sectors;
>   	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
> +	lim.logical_block_size = mddev->logical_block_size;
>   	lim.io_min = mddev->chunk_sectors << 9;
>   	lim.io_opt = lim.io_min * mddev->raid_disks;
>   	lim.chunk_sectors = mddev->chunk_sectors;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 0e792b9bfff8..3e422854cafb 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3224,6 +3224,7 @@ static int raid1_set_limits(struct mddev *mddev)
>   
>   	md_init_stacking_limits(&lim);
>   	lim.max_write_zeroes_sectors = 0;
> +	lim.logical_block_size = mddev->logical_block_size;
>   	lim.features |= BLK_FEAT_ATOMIC_WRITES;
>   	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
>   	if (err)
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 2411399a7352..2dfff3f9ec8e 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4005,6 +4005,7 @@ static int raid10_set_queue_limits(struct mddev *mddev)
>   
>   	md_init_stacking_limits(&lim);
>   	lim.max_write_zeroes_sectors = 0;
> +	lim.logical_block_size = mddev->logical_block_size;
>   	lim.io_min = mddev->chunk_sectors << 9;
>   	lim.chunk_sectors = mddev->chunk_sectors;
>   	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 2121f0ff5e30..c6bd6d2e4438 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7733,6 +7733,7 @@ static int raid5_set_limits(struct mddev *mddev)
>   	stripe = roundup_pow_of_two(data_disks * (mddev->chunk_sectors << 9));
>   
>   	md_init_stacking_limits(&lim);
> +	lim.logical_block_size = mddev->logical_block_size;
>   	lim.io_min = mddev->chunk_sectors << 9;
>   	lim.io_opt = lim.io_min * (conf->raid_disks - conf->max_degraded);
>   	lim.features |= BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
> 


