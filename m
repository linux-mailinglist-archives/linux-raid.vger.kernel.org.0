Return-Path: <linux-raid+bounces-5287-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B1B52894
	for <lists+linux-raid@lfdr.de>; Thu, 11 Sep 2025 08:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC541C243ED
	for <lists+linux-raid@lfdr.de>; Thu, 11 Sep 2025 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B4F1AF0BB;
	Thu, 11 Sep 2025 06:16:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FDF4FA;
	Thu, 11 Sep 2025 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571377; cv=none; b=on9w1RWmR0wAmodZCnLAx0iXkW4nymhyM6W48RJ5I3fkra6H+jAs1y8H7vHzDpT/ONxl1Y2CixmJWlVhg1F3UAZQHYrJq0n5punc2r8w0rBcj3R97Q9mdJGDx/X4zkzyBUI5Nq1Qv4RHDsRWsxRIqiO95zTF0FmrPnj7HkkzKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571377; c=relaxed/simple;
	bh=6tT/sMbOlPZXTXG48em4wrGVHsB3PzPKyQqADoF2tJ8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cl3ezCg3KiLgSrRQQB16GWrVYaEuyXrCMafdEyVgSS4B1bF/tHCVZ7R5P/AyyRq/EPJY0Yl4kHJtmeKwnpF2W5DEnTieeyDAGijlqLTkpc+60AMy0b1WgfL+lvJJLgdkGgJvfFSHRYt4sjMEF0xHFeC2dgxtSh2dH5y5+E78p2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMnPT37wNzYQv9V;
	Thu, 11 Sep 2025 14:16:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA2801A181A;
	Thu, 11 Sep 2025 14:16:11 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IwracJolbd5CA--.11817S3;
	Thu, 11 Sep 2025 14:16:11 +0800 (CST)
Subject: Re: [PATCH 3/3] md: factor out sync completion update into helper
To: linan666@huaweicloud.com, song@kernel.org, neil@brown.name,
 namhyung@gmail.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250911020441.2858174-1-linan666@huaweicloud.com>
 <20250911020441.2858174-3-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d380b0c4-7d2c-0f3a-5f69-c5cd1c3832c3@huaweicloud.com>
Date: Thu, 11 Sep 2025 14:16:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250911020441.2858174-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IwracJolbd5CA--.11817S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4UAryfKFWUAF45tr4UXFb_yoW7Jr4xp3
	yftF9xGr1UXFWaqFW7J3WDAFWruryUtrZrtryag34xJr1fKrnrGFyY9w1xJryDA34vyr4F
	q3y5Wrs8u3Wjg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/09/11 10:04, linan666@huaweicloud.com д��:
> From: Li Nan <linan122@huawei.com>
> 
> Repeatedly reading 'mddev->recovery' flags in md_do_sync() may introduce
> potential risk if this flag is modified during sync, leading to incorrect
> offset updates. Therefore, replace direct 'mddev->recovery' checks with
> 'action'.
> 
> Move sync completion update logic into helper md_finish_sync(), which
> improves readability and maintainability.
> 
> The reshape completion update remains safe as it only updated after
> successful reshape when MD_RECOVERY_INTR is not set and 'curr_resync'
> equals 'max_sectors'.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 80 +++++++++++++++++++++++++++----------------------
>   1 file changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f3abfc140481..a77c59527d4c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9298,6 +9298,49 @@ static bool sync_io_within_limit(struct mddev *mddev)
>   	       (raid_is_456(mddev) ? 8 : 128) * sync_io_depth(mddev);
>   }
>   
> +/*
> + * Update sync offset and mddev status when sync completes
> + */
> +static void md_finish_sync(struct mddev *mddev, enum sync_action action)
> +{
> +	struct md_rdev *rdev;
> +
> +	switch (action) {
> +	case ACTION_RESYNC:
> +	case ACTION_REPAIR:
And check?

> +		if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> +			mddev->curr_resync_completed = MaxSector;
> +		mddev->resync_offset = mddev->curr_resync_completed;
> +		break;
> +	case ACTION_RECOVER:
> +		if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> +			mddev->curr_resync_completed = MaxSector;
> +		rcu_read_lock();
> +		rdev_for_each_rcu(rdev, mddev)
> +			if (mddev->delta_disks >= 0 &&
> +			    rdev_needs_recovery(rdev, mddev->curr_resync_completed))
> +				rdev->recovery_offset = mddev->curr_resync_completed;
> +		rcu_read_unlock();
> +		break;
> +	case ACTION_RESHAPE:
> +		if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
> +		    mddev->delta_disks > 0 &&
> +		    mddev->pers->finish_reshape &&
> +		    mddev->pers->size &&
> +		    !mddev_is_dm(mddev)) {
> +			mddev_lock_nointr(mddev);
> +			md_set_array_sectors(mddev, mddev->pers->size(mddev, 0, 0));
> +			mddev_unlock(mddev);
> +			if (!mddev_is_clustered(mddev))
> +				set_capacity_and_notify(mddev->gendisk,
> +							mddev->array_sectors);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   #define SYNC_MARKS	10
>   #define	SYNC_MARK_STEP	(3*HZ)
>   #define UPDATE_FREQUENCY (5*60*HZ)
> @@ -9313,7 +9356,6 @@ void md_do_sync(struct md_thread *thread)
>   	int last_mark,m;
>   	sector_t last_check;
>   	int skipped = 0;
> -	struct md_rdev *rdev;
>   	enum sync_action action;
>   	const char *desc;
>   	struct blk_plug plug;
> @@ -9603,46 +9645,14 @@ void md_do_sync(struct md_thread *thread)
>   	}
>   	mddev->pers->sync_request(mddev, max_sectors, max_sectors, &skipped);
>   
> -	if (!test_bit(MD_RECOVERY_CHECK, &mddev->recovery) &&
> -	    mddev->curr_resync_completed > MD_RESYNC_ACTIVE) {
> -		if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> -			mddev->curr_resync_completed = MaxSector;
> -
> -		if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
> -			mddev->resync_offset = mddev->curr_resync_completed;
> -		} else {
> -			if (!test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
> -			    test_bit(MD_RECOVERY_RECOVER, &mddev->recovery)) {
> -				rcu_read_lock();
> -				rdev_for_each_rcu(rdev, mddev)
> -					if (mddev->delta_disks >= 0 &&
> -					    rdev_needs_recovery(rdev, mddev->curr_resync_completed))
> -						rdev->recovery_offset = mddev->curr_resync_completed;
> -				rcu_read_unlock();
> -			}
> -		}
> -	}
> +	if (mddev->curr_resync > MD_RESYNC_ACTIVE)
> +		md_finish_sync(mddev, action);
>    skip:
>   	/* set CHANGE_PENDING here since maybe another update is needed,
>   	 * so other nodes are informed. It should be harmless for normal
>   	 * raid */
>   	set_mask_bits(&mddev->sb_flags, 0,
>   		      BIT(MD_SB_CHANGE_PENDING) | BIT(MD_SB_CHANGE_DEVS));
> -
> -	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
> -			!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
> -			mddev->delta_disks > 0 &&
> -			mddev->pers->finish_reshape &&
> -			mddev->pers->size &&
> -			!mddev_is_dm(mddev)) {
> -		mddev_lock_nointr(mddev);
> -		md_set_array_sectors(mddev, mddev->pers->size(mddev, 0, 0));
> -		mddev_unlock(mddev);
> -		if (!mddev_is_clustered(mddev))
> -			set_capacity_and_notify(mddev->gendisk,
> -						mddev->array_sectors);
> -	}
> -
>   	spin_lock(&mddev->lock);
>   	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
>   		/* We completed so min/max setting can be forgotten if used. */
> 

I like this patch, and I feel we can also passin the action to to
pers->sync_request as well, and convert personality to switch case
as well.

Thanks,
Kuai


