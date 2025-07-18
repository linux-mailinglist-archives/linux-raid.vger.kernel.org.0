Return-Path: <linux-raid+bounces-4708-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEBB0AF2D
	for <lists+linux-raid@lfdr.de>; Sat, 19 Jul 2025 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA067AC865
	for <lists+linux-raid@lfdr.de>; Sat, 19 Jul 2025 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F934236424;
	Sat, 19 Jul 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDL1Gi8X"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10320E70B;
	Sat, 19 Jul 2025 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752918670; cv=none; b=V3pQQ2cyLx07/v/BL3uCdw0MaMwgPbAYy8oViTw+OKsTTFoFf3w70xVqx0iL+xWU9b2cL+//c86/Y8wyRamvizLY2B0oGY1Eo9Eg/P3Q1jM+P3AmHiO4s9JrO2qA1KGdUGmNHVhkFjQaky+torEehb/mfrlhDJTdn4dEfFRh4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752918670; c=relaxed/simple;
	bh=jvNcLRIVh0KZyMzhnyq3hyIJ1JRtDr3XM6sGp36mC8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke+wU5lpsi+kKneCMLNBki6wBrXc2wMZr44Yu/ir23/97I7TETB8ErkBcUPh85UfQLt/CvQEsNuq3loKIPQqMB5Ew83PUgDeonLFHRBZn/GhPZiPs5UplhTvxG9+VKPa2lyEZVKCa9Kc+m9NqPli0yUzVGUvBYEhDMu8u8wmWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDL1Gi8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98F6C4CEE3;
	Sat, 19 Jul 2025 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752918669;
	bh=jvNcLRIVh0KZyMzhnyq3hyIJ1JRtDr3XM6sGp36mC8s=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gDL1Gi8XwdwQqPHI/hN0v+fa/CGpZLRQJN728tFP24luP+2NOiRw+KmSFal7PCjqD
	 kJeCNu0F75dYk6AsEtMyaWBUm7eorDIfyNnM7gXT52QNAO4XWB2pCPEe1Yem9mq8cj
	 YDUFMHu95GrNxFthgxM1dHnyRf8TKR/HxOqb3GwVZsTD/j3nKAu7dtAiorVNlWAFmF
	 fr5AMhU2K2lbVIA5yR5/7Jqmm69NdGQD/clB2ZNw505owCXkIceO+IGAQMQAp+1h12
	 m1gvtKboE/Sd65iMZ3/kMRfPK8EDN+kRP7d5HDDFlxqF3y4og7FVSC40wdxU0oBa2Q
	 cOhWHxoIZmcEQ==
Message-ID: <6739a04b-6c52-4796-97c0-bca0a9f6b5cc@kernel.org>
Date: Sat, 19 Jul 2025 17:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH] md: rename recovery_cp to resync_offset
To: linan666@huaweicloud.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
References: <20250719083507.1083756-1-linan666@huaweicloud.com>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <20250719083507.1083756-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/19 16:35, linan666@huaweicloud.com 写道:
> From: Li Nan <linan122@huawei.com>
>
> 'recovery_cp' was used to represent the progress of sync, but its name
> contains recovery, which can cause confusion. Replaces 'recovery_cp'
> with 'resync_offset' for clarity.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.h                |  2 +-
>   include/uapi/linux/raid/md_p.h |  2 +-
>   drivers/md/dm-raid.c           | 42 ++++++++++++++--------------
>   drivers/md/md-bitmap.c         |  8 +++---
>   drivers/md/md-cluster.c        | 16 +++++------
>   drivers/md/md.c                | 50 +++++++++++++++++-----------------
>   drivers/md/raid0.c             |  6 ++--
>   drivers/md/raid1-10.c          |  2 +-
>   drivers/md/raid1.c             | 10 +++----
>   drivers/md/raid10.c            | 16 +++++------
>   drivers/md/raid5-ppl.c         |  6 ++--
>   drivers/md/raid5.c             | 30 ++++++++++----------
>   12 files changed, 95 insertions(+), 95 deletions(-)
Please cook your patch on the top of md-6.17 branch.

Thanks,
Kuai

> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index d45a9e6ead80..43ae2d03faa1 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -523,7 +523,7 @@ struct mddev {
>   	unsigned long			normal_io_events; /* IO event timestamp */
>   	atomic_t			recovery_active; /* blocks scheduled, but not written */
>   	wait_queue_head_t		recovery_wait;
> -	sector_t			recovery_cp;
> +	sector_t			resync_offset;
>   	sector_t			resync_min;	/* user requested sync
>   							 * starts here */
>   	sector_t			resync_max;	/* resync should pause
> diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md_p.h
> index ff47b6f0ba0f..b13946287277 100644
> --- a/include/uapi/linux/raid/md_p.h
> +++ b/include/uapi/linux/raid/md_p.h
> @@ -173,7 +173,7 @@ typedef struct mdp_superblock_s {
>   #else
>   #error unspecified endianness
>   #endif
> -	__u32 recovery_cp;	/* 11 recovery checkpoint sector count	      */
> +	__u32 resync_offset;	/* 11 resync checkpoint sector count	      */
>   	/* There are only valid for minor_version > 90 */
>   	__u64 reshape_position;	/* 12,13 next address in array-space for reshape */
>   	__u32 new_level;	/* 14 new level we are reshaping to	      */
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index e8c0a8c6fb51..9835f2fe26e9 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -439,7 +439,7 @@ static bool rs_is_reshapable(struct raid_set *rs)
>   /* Return true, if raid set in @rs is recovering */
>   static bool rs_is_recovering(struct raid_set *rs)
>   {
> -	return rs->md.recovery_cp < rs->md.dev_sectors;
> +	return rs->md.resync_offset < rs->md.dev_sectors;
>   }
>   
>   /* Return true, if raid set in @rs is reshaping */
> @@ -769,7 +769,7 @@ static struct raid_set *raid_set_alloc(struct dm_target *ti, struct raid_type *r
>   	rs->md.layout = raid_type->algorithm;
>   	rs->md.new_layout = rs->md.layout;
>   	rs->md.delta_disks = 0;
> -	rs->md.recovery_cp = MaxSector;
> +	rs->md.resync_offset = MaxSector;
>   
>   	for (i = 0; i < raid_devs; i++)
>   		md_rdev_init(&rs->dev[i].rdev);
> @@ -913,7 +913,7 @@ static int parse_dev_params(struct raid_set *rs, struct dm_arg_set *as)
>   		rs->md.external = 0;
>   		rs->md.persistent = 1;
>   		rs->md.major_version = 2;
> -	} else if (rebuild && !rs->md.recovery_cp) {
> +	} else if (rebuild && !rs->md.resync_offset) {
>   		/*
>   		 * Without metadata, we will not be able to tell if the array
>   		 * is in-sync or not - we must assume it is not.  Therefore,
> @@ -1696,20 +1696,20 @@ static void rs_setup_recovery(struct raid_set *rs, sector_t dev_sectors)
>   {
>   	/* raid0 does not recover */
>   	if (rs_is_raid0(rs))
> -		rs->md.recovery_cp = MaxSector;
> +		rs->md.resync_offset = MaxSector;
>   	/*
>   	 * A raid6 set has to be recovered either
>   	 * completely or for the grown part to
>   	 * ensure proper parity and Q-Syndrome
>   	 */
>   	else if (rs_is_raid6(rs))
> -		rs->md.recovery_cp = dev_sectors;
> +		rs->md.resync_offset = dev_sectors;
>   	/*
>   	 * Other raid set types may skip recovery
>   	 * depending on the 'nosync' flag.
>   	 */
>   	else
> -		rs->md.recovery_cp = test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags)
> +		rs->md.resync_offset = test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags)
>   				     ? MaxSector : dev_sectors;
>   }
>   
> @@ -2144,7 +2144,7 @@ static void super_sync(struct mddev *mddev, struct md_rdev *rdev)
>   	sb->events = cpu_to_le64(mddev->events);
>   
>   	sb->disk_recovery_offset = cpu_to_le64(rdev->recovery_offset);
> -	sb->array_resync_offset = cpu_to_le64(mddev->recovery_cp);
> +	sb->array_resync_offset = cpu_to_le64(mddev->resync_offset);
>   
>   	sb->level = cpu_to_le32(mddev->level);
>   	sb->layout = cpu_to_le32(mddev->layout);
> @@ -2335,18 +2335,18 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
>   	}
>   
>   	if (!test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags))
> -		mddev->recovery_cp = le64_to_cpu(sb->array_resync_offset);
> +		mddev->resync_offset = le64_to_cpu(sb->array_resync_offset);
>   
>   	/*
>   	 * During load, we set FirstUse if a new superblock was written.
>   	 * There are two reasons we might not have a superblock:
>   	 * 1) The raid set is brand new - in which case, all of the
>   	 *    devices must have their In_sync bit set.	Also,
> -	 *    recovery_cp must be 0, unless forced.
> +	 *    resync_offset must be 0, unless forced.
>   	 * 2) This is a new device being added to an old raid set
>   	 *    and the new device needs to be rebuilt - in which
>   	 *    case the In_sync bit will /not/ be set and
> -	 *    recovery_cp must be MaxSector.
> +	 *    resync_offset must be MaxSector.
>   	 * 3) This is/are a new device(s) being added to an old
>   	 *    raid set during takeover to a higher raid level
>   	 *    to provide capacity for redundancy or during reshape
> @@ -2391,8 +2391,8 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
>   			      new_devs > 1 ? "s" : "");
>   			return -EINVAL;
>   		} else if (!test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags) && rs_is_recovering(rs)) {
> -			DMERR("'rebuild' specified while raid set is not in-sync (recovery_cp=%llu)",
> -			      (unsigned long long) mddev->recovery_cp);
> +			DMERR("'rebuild' specified while raid set is not in-sync (resync_offset=%llu)",
> +			      (unsigned long long) mddev->resync_offset);
>   			return -EINVAL;
>   		} else if (rs_is_reshaping(rs)) {
>   			DMERR("'rebuild' specified while raid set is being reshaped (reshape_position=%llu)",
> @@ -2697,11 +2697,11 @@ static int rs_adjust_data_offsets(struct raid_set *rs)
>   	}
>   out:
>   	/*
> -	 * Raise recovery_cp in case data_offset != 0 to
> +	 * Raise resync_offset in case data_offset != 0 to
>   	 * avoid false recovery positives in the constructor.
>   	 */
> -	if (rs->md.recovery_cp < rs->md.dev_sectors)
> -		rs->md.recovery_cp += rs->dev[0].rdev.data_offset;
> +	if (rs->md.resync_offset < rs->md.dev_sectors)
> +		rs->md.resync_offset += rs->dev[0].rdev.data_offset;
>   
>   	/* Adjust data offsets on all rdevs but on any raid4/5/6 journal device */
>   	rdev_for_each(rdev, &rs->md) {
> @@ -2756,7 +2756,7 @@ static int rs_setup_takeover(struct raid_set *rs)
>   	}
>   
>   	clear_bit(MD_ARRAY_FIRST_USE, &mddev->flags);
> -	mddev->recovery_cp = MaxSector;
> +	mddev->resync_offset = MaxSector;
>   
>   	while (d--) {
>   		rdev = &rs->dev[d].rdev;
> @@ -2764,7 +2764,7 @@ static int rs_setup_takeover(struct raid_set *rs)
>   		if (test_bit(d, (void *) rs->rebuild_disks)) {
>   			clear_bit(In_sync, &rdev->flags);
>   			clear_bit(Faulty, &rdev->flags);
> -			mddev->recovery_cp = rdev->recovery_offset = 0;
> +			mddev->resync_offset = rdev->recovery_offset = 0;
>   			/* Bitmap has to be created when we do an "up" takeover */
>   			set_bit(MD_ARRAY_FIRST_USE, &mddev->flags);
>   		}
> @@ -3222,7 +3222,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>   			if (r)
>   				goto bad;
>   
> -			rs_setup_recovery(rs, rs->md.recovery_cp < rs->md.dev_sectors ? rs->md.recovery_cp : rs->md.dev_sectors);
> +			rs_setup_recovery(rs, rs->md.resync_offset < rs->md.dev_sectors ? rs->md.resync_offset : rs->md.dev_sectors);
>   		} else {
>   			/* This is no size change or it is shrinking, update size and record in superblocks */
>   			r = rs_set_dev_and_array_sectors(rs, rs->ti->len, false);
> @@ -3446,7 +3446,7 @@ static sector_t rs_get_progress(struct raid_set *rs, unsigned long recovery,
>   
>   	} else {
>   		if (state == st_idle && !test_bit(MD_RECOVERY_INTR, &recovery))
> -			r = mddev->recovery_cp;
> +			r = mddev->resync_offset;
>   		else
>   			r = mddev->curr_resync_completed;
>   
> @@ -4074,9 +4074,9 @@ static int raid_preresume(struct dm_target *ti)
>   	}
>   
>   	/* Check for any resize/reshape on @rs and adjust/initiate */
> -	if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
> +	if (mddev->resync_offset && mddev->resync_offset < MaxSector) {
>   		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> -		mddev->resync_min = mddev->recovery_cp;
> +		mddev->resync_min = mddev->resync_offset;
>   		if (test_bit(RT_FLAG_RS_GROW, &rs->runtime_flags))
>   			mddev->resync_max_sectors = mddev->dev_sectors;
>   	}
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 7f524a26cebc..334b71404930 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1987,12 +1987,12 @@ static void bitmap_dirty_bits(struct mddev *mddev, unsigned long s,
>   
>   		md_bitmap_set_memory_bits(bitmap, sec, 1);
>   		md_bitmap_file_set_bit(bitmap, sec);
> -		if (sec < bitmap->mddev->recovery_cp)
> +		if (sec < bitmap->mddev->resync_offset)
>   			/* We are asserting that the array is dirty,
> -			 * so move the recovery_cp address back so
> +			 * so move the resync_offset address back so
>   			 * that it is obvious that it is dirty
>   			 */
> -			bitmap->mddev->recovery_cp = sec;
> +			bitmap->mddev->resync_offset = sec;
>   	}
>   }
>   
> @@ -2258,7 +2258,7 @@ static int bitmap_load(struct mddev *mddev)
>   	    || bitmap->events_cleared == mddev->events)
>   		/* no need to keep dirty bits to optimise a
>   		 * re-add of a missing device */
> -		start = mddev->recovery_cp;
> +		start = mddev->resync_offset;
>   
>   	mutex_lock(&mddev->bitmap_info.mutex);
>   	err = md_bitmap_init_from_disk(bitmap, start);
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 94221d964d4f..5497eaee96e7 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -337,11 +337,11 @@ static void recover_bitmaps(struct md_thread *thread)
>   			md_wakeup_thread(mddev->sync_thread);
>   
>   		if (hi > 0) {
> -			if (lo < mddev->recovery_cp)
> -				mddev->recovery_cp = lo;
> +			if (lo < mddev->resync_offset)
> +				mddev->resync_offset = lo;
>   			/* wake up thread to continue resync in case resync
>   			 * is not finished */
> -			if (mddev->recovery_cp != MaxSector) {
> +			if (mddev->resync_offset != MaxSector) {
>   				/*
>   				 * clear the REMOTE flag since we will launch
>   				 * resync thread in current node.
> @@ -863,9 +863,9 @@ static int gather_all_resync_info(struct mddev *mddev, int total_slots)
>   			lockres_free(bm_lockres);
>   			continue;
>   		}
> -		if ((hi > 0) && (lo < mddev->recovery_cp)) {
> +		if ((hi > 0) && (lo < mddev->resync_offset)) {
>   			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> -			mddev->recovery_cp = lo;
> +			mddev->resync_offset = lo;
>   			md_check_recovery(mddev);
>   		}
>   
> @@ -1027,7 +1027,7 @@ static int leave(struct mddev *mddev)
>   	 * Also, we should send BITMAP_NEEDS_SYNC message in
>   	 * case reshaping is interrupted.
>   	 */
> -	if ((cinfo->slot_number > 0 && mddev->recovery_cp != MaxSector) ||
> +	if ((cinfo->slot_number > 0 && mddev->resync_offset != MaxSector) ||
>   	    (mddev->reshape_position != MaxSector &&
>   	     test_bit(MD_CLOSING, &mddev->flags)))
>   		resync_bitmap(mddev);
> @@ -1605,8 +1605,8 @@ static int gather_bitmaps(struct md_rdev *rdev)
>   			pr_warn("md-cluster: Could not gather bitmaps from slot %d", sn);
>   			goto out;
>   		}
> -		if ((hi > 0) && (lo < mddev->recovery_cp))
> -			mddev->recovery_cp = lo;
> +		if ((hi > 0) && (lo < mddev->resync_offset))
> +			mddev->resync_offset = lo;
>   	}
>   out:
>   	return err;
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0f03b21e66e4..388aad728001 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1402,13 +1402,13 @@ static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, stru
>   			mddev->layout = -1;
>   
>   		if (sb->state & (1<<MD_SB_CLEAN))
> -			mddev->recovery_cp = MaxSector;
> +			mddev->resync_offset = MaxSector;
>   		else {
>   			if (sb->events_hi == sb->cp_events_hi &&
>   				sb->events_lo == sb->cp_events_lo) {
> -				mddev->recovery_cp = sb->recovery_cp;
> +				mddev->resync_offset = sb->resync_offset;
>   			} else
> -				mddev->recovery_cp = 0;
> +				mddev->resync_offset = 0;
>   		}
>   
>   		memcpy(mddev->uuid+0, &sb->set_uuid0, 4);
> @@ -1534,13 +1534,13 @@ static void super_90_sync(struct mddev *mddev, struct md_rdev *rdev)
>   	mddev->minor_version = sb->minor_version;
>   	if (mddev->in_sync)
>   	{
> -		sb->recovery_cp = mddev->recovery_cp;
> +		sb->resync_offset = mddev->resync_offset;
>   		sb->cp_events_hi = (mddev->events>>32);
>   		sb->cp_events_lo = (u32)mddev->events;
> -		if (mddev->recovery_cp == MaxSector)
> +		if (mddev->resync_offset == MaxSector)
>   			sb->state = (1<< MD_SB_CLEAN);
>   	} else
> -		sb->recovery_cp = 0;
> +		sb->resync_offset = 0;
>   
>   	sb->layout = mddev->layout;
>   	sb->chunk_size = mddev->chunk_sectors << 9;
> @@ -1888,7 +1888,7 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struc
>   		mddev->bitmap_info.default_space = (4096-1024) >> 9;
>   		mddev->reshape_backwards = 0;
>   
> -		mddev->recovery_cp = le64_to_cpu(sb->resync_offset);
> +		mddev->resync_offset = le64_to_cpu(sb->resync_offset);
>   		memcpy(mddev->uuid, sb->set_uuid, 16);
>   
>   		mddev->max_disks =  (4096-256)/2;
> @@ -2074,7 +2074,7 @@ static void super_1_sync(struct mddev *mddev, struct md_rdev *rdev)
>   	sb->utime = cpu_to_le64((__u64)mddev->utime);
>   	sb->events = cpu_to_le64(mddev->events);
>   	if (mddev->in_sync)
> -		sb->resync_offset = cpu_to_le64(mddev->recovery_cp);
> +		sb->resync_offset = cpu_to_le64(mddev->resync_offset);
>   	else if (test_bit(MD_JOURNAL_CLEAN, &mddev->flags))
>   		sb->resync_offset = cpu_to_le64(MaxSector);
>   	else
> @@ -2754,7 +2754,7 @@ void md_update_sb(struct mddev *mddev, int force_change)
>   	/* If this is just a dirty<->clean transition, and the array is clean
>   	 * and 'events' is odd, we can roll back to the previous clean state */
>   	if (nospares
> -	    && (mddev->in_sync && mddev->recovery_cp == MaxSector)
> +	    && (mddev->in_sync && mddev->resync_offset == MaxSector)
>   	    && mddev->can_decrease_events
>   	    && mddev->events != 1) {
>   		mddev->events--;
> @@ -4290,9 +4290,9 @@ __ATTR(chunk_size, S_IRUGO|S_IWUSR, chunk_size_show, chunk_size_store);
>   static ssize_t
>   resync_start_show(struct mddev *mddev, char *page)
>   {
> -	if (mddev->recovery_cp == MaxSector)
> +	if (mddev->resync_offset == MaxSector)
>   		return sprintf(page, "none\n");
> -	return sprintf(page, "%llu\n", (unsigned long long)mddev->recovery_cp);
> +	return sprintf(page, "%llu\n", (unsigned long long)mddev->resync_offset);
>   }
>   
>   static ssize_t
> @@ -4318,7 +4318,7 @@ resync_start_store(struct mddev *mddev, const char *buf, size_t len)
>   		err = -EBUSY;
>   
>   	if (!err) {
> -		mddev->recovery_cp = n;
> +		mddev->resync_offset = n;
>   		if (mddev->pers)
>   			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
>   	}
> @@ -6405,7 +6405,7 @@ static void md_clean(struct mddev *mddev)
>   	mddev->external_size = 0;
>   	mddev->dev_sectors = 0;
>   	mddev->raid_disks = 0;
> -	mddev->recovery_cp = 0;
> +	mddev->resync_offset = 0;
>   	mddev->resync_min = 0;
>   	mddev->resync_max = MaxSector;
>   	mddev->reshape_position = MaxSector;
> @@ -7359,9 +7359,9 @@ int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info)
>   	 * openned
>   	 */
>   	if (info->state & (1<<MD_SB_CLEAN))
> -		mddev->recovery_cp = MaxSector;
> +		mddev->resync_offset = MaxSector;
>   	else
> -		mddev->recovery_cp = 0;
> +		mddev->resync_offset = 0;
>   	mddev->persistent    = ! info->not_persistent;
>   	mddev->external	     = 0;
>   
> @@ -8300,7 +8300,7 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
>   				seq_printf(seq, "\tresync=REMOTE");
>   			return 1;
>   		}
> -		if (mddev->recovery_cp < MaxSector) {
> +		if (mddev->resync_offset < MaxSector) {
>   			seq_printf(seq, "\tresync=PENDING");
>   			return 1;
>   		}
> @@ -8943,7 +8943,7 @@ static sector_t md_sync_position(struct mddev *mddev, enum sync_action action)
>   		return mddev->resync_min;
>   	case ACTION_RESYNC:
>   		if (!mddev->bitmap)
> -			return mddev->recovery_cp;
> +			return mddev->resync_offset;
>   		return 0;
>   	case ACTION_RESHAPE:
>   		/*
> @@ -9181,8 +9181,8 @@ void md_do_sync(struct md_thread *thread)
>   				   atomic_read(&mddev->recovery_active) == 0);
>   			mddev->curr_resync_completed = j;
>   			if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
> -			    j > mddev->recovery_cp)
> -				mddev->recovery_cp = j;
> +			    j > mddev->resync_offset)
> +				mddev->resync_offset = j;
>   			update_time = jiffies;
>   			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
>   			sysfs_notify_dirent_safe(mddev->sysfs_completed);
> @@ -9302,19 +9302,19 @@ void md_do_sync(struct md_thread *thread)
>   	    mddev->curr_resync > MD_RESYNC_ACTIVE) {
>   		if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
>   			if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
> -				if (mddev->curr_resync >= mddev->recovery_cp) {
> +				if (mddev->curr_resync >= mddev->resync_offset) {
>   					pr_debug("md: checkpointing %s of %s.\n",
>   						 desc, mdname(mddev));
>   					if (test_bit(MD_RECOVERY_ERROR,
>   						&mddev->recovery))
> -						mddev->recovery_cp =
> +						mddev->resync_offset =
>   							mddev->curr_resync_completed;
>   					else
> -						mddev->recovery_cp =
> +						mddev->resync_offset =
>   							mddev->curr_resync;
>   				}
>   			} else
> -				mddev->recovery_cp = MaxSector;
> +				mddev->resync_offset = MaxSector;
>   		} else {
>   			if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
>   				mddev->curr_resync = MaxSector;
> @@ -9521,7 +9521,7 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
>   	}
>   
>   	/* Check if resync is in progress. */
> -	if (mddev->recovery_cp < MaxSector) {
> +	if (mddev->resync_offset < MaxSector) {
>   		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>   		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
>   		return true;
> @@ -9701,7 +9701,7 @@ void md_check_recovery(struct mddev *mddev)
>   		test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
>   		(mddev->external == 0 && mddev->safemode == 1) ||
>   		(mddev->safemode == 2
> -		 && !mddev->in_sync && mddev->recovery_cp == MaxSector)
> +		 && !mddev->in_sync && mddev->resync_offset == MaxSector)
>   		))
>   		return;
>   
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index d8f639f4ae12..613f4fab83b2 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -673,7 +673,7 @@ static void *raid0_takeover_raid45(struct mddev *mddev)
>   	mddev->raid_disks--;
>   	mddev->delta_disks = -1;
>   	/* make sure it will be not marked as dirty */
> -	mddev->recovery_cp = MaxSector;
> +	mddev->resync_offset = MaxSector;
>   	mddev_clear_unsupported_flags(mddev, UNSUPPORTED_MDDEV_FLAGS);
>   
>   	create_strip_zones(mddev, &priv_conf);
> @@ -716,7 +716,7 @@ static void *raid0_takeover_raid10(struct mddev *mddev)
>   	mddev->raid_disks += mddev->delta_disks;
>   	mddev->degraded = 0;
>   	/* make sure it will be not marked as dirty */
> -	mddev->recovery_cp = MaxSector;
> +	mddev->resync_offset = MaxSector;
>   	mddev_clear_unsupported_flags(mddev, UNSUPPORTED_MDDEV_FLAGS);
>   
>   	create_strip_zones(mddev, &priv_conf);
> @@ -759,7 +759,7 @@ static void *raid0_takeover_raid1(struct mddev *mddev)
>   	mddev->delta_disks = 1 - mddev->raid_disks;
>   	mddev->raid_disks = 1;
>   	/* make sure it will be not marked as dirty */
> -	mddev->recovery_cp = MaxSector;
> +	mddev->resync_offset = MaxSector;
>   	mddev_clear_unsupported_flags(mddev, UNSUPPORTED_MDDEV_FLAGS);
>   
>   	create_strip_zones(mddev, &priv_conf);
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index b8b3a9069701..52881e6032da 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -283,7 +283,7 @@ static inline int raid1_check_read_range(struct md_rdev *rdev,
>   static inline bool raid1_should_read_first(struct mddev *mddev,
>   					   sector_t this_sector, int len)
>   {
> -	if ((mddev->recovery_cp < this_sector + len))
> +	if ((mddev->resync_offset < this_sector + len))
>   		return true;
>   
>   	if (mddev_is_clustered(mddev) &&
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 64b8176907a9..6cee738a645f 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2822,7 +2822,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>   	}
>   
>   	if (mddev->bitmap == NULL &&
> -	    mddev->recovery_cp == MaxSector &&
> +	    mddev->resync_offset == MaxSector &&
>   	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
>   	    conf->fullsync == 0) {
>   		*skipped = 1;
> @@ -3282,9 +3282,9 @@ static int raid1_run(struct mddev *mddev)
>   	}
>   
>   	if (conf->raid_disks - mddev->degraded == 1)
> -		mddev->recovery_cp = MaxSector;
> +		mddev->resync_offset = MaxSector;
>   
> -	if (mddev->recovery_cp != MaxSector)
> +	if (mddev->resync_offset != MaxSector)
>   		pr_info("md/raid1:%s: not clean -- starting background reconstruction\n",
>   			mdname(mddev));
>   	pr_info("md/raid1:%s: active with %d out of %d mirrors\n",
> @@ -3345,8 +3345,8 @@ static int raid1_resize(struct mddev *mddev, sector_t sectors)
>   
>   	md_set_array_sectors(mddev, newsize);
>   	if (sectors > mddev->dev_sectors &&
> -	    mddev->recovery_cp > mddev->dev_sectors) {
> -		mddev->recovery_cp = mddev->dev_sectors;
> +	    mddev->resync_offset > mddev->dev_sectors) {
> +		mddev->resync_offset = mddev->dev_sectors;
>   		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   	mddev->dev_sectors = sectors;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index c9bd2005bfd0..e889c982fc77 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2117,7 +2117,7 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	int last = conf->geo.raid_disks - 1;
>   	struct raid10_info *p;
>   
> -	if (mddev->recovery_cp < MaxSector)
> +	if (mddev->resync_offset < MaxSector)
>   		/* only hot-add to in-sync arrays, as recovery is
>   		 * very different from resync
>   		 */
> @@ -3188,7 +3188,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   	 * of a clean array, like RAID1 does.
>   	 */
>   	if (mddev->bitmap == NULL &&
> -	    mddev->recovery_cp == MaxSector &&
> +	    mddev->resync_offset == MaxSector &&
>   	    mddev->reshape_position == MaxSector &&
>   	    !test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
>   	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
> @@ -4147,7 +4147,7 @@ static int raid10_run(struct mddev *mddev)
>   		disk->recovery_disabled = mddev->recovery_disabled - 1;
>   	}
>   
> -	if (mddev->recovery_cp != MaxSector)
> +	if (mddev->resync_offset != MaxSector)
>   		pr_notice("md/raid10:%s: not clean -- starting background reconstruction\n",
>   			  mdname(mddev));
>   	pr_info("md/raid10:%s: active with %d out of %d devices\n",
> @@ -4247,8 +4247,8 @@ static int raid10_resize(struct mddev *mddev, sector_t sectors)
>   
>   	md_set_array_sectors(mddev, size);
>   	if (sectors > mddev->dev_sectors &&
> -	    mddev->recovery_cp > oldsize) {
> -		mddev->recovery_cp = oldsize;
> +	    mddev->resync_offset > oldsize) {
> +		mddev->resync_offset = oldsize;
>   		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   	calc_sectors(conf, sectors);
> @@ -4277,7 +4277,7 @@ static void *raid10_takeover_raid0(struct mddev *mddev, sector_t size, int devs)
>   	mddev->delta_disks = mddev->raid_disks;
>   	mddev->raid_disks *= 2;
>   	/* make sure it will be not marked as dirty */
> -	mddev->recovery_cp = MaxSector;
> +	mddev->resync_offset = MaxSector;
>   	mddev->dev_sectors = size;
>   
>   	conf = setup_conf(mddev);
> @@ -5089,8 +5089,8 @@ static void raid10_finish_reshape(struct mddev *mddev)
>   		return;
>   
>   	if (mddev->delta_disks > 0) {
> -		if (mddev->recovery_cp > mddev->resync_max_sectors) {
> -			mddev->recovery_cp = mddev->resync_max_sectors;
> +		if (mddev->resync_offset > mddev->resync_max_sectors) {
> +			mddev->resync_offset = mddev->resync_max_sectors;
>   			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   		}
>   		mddev->resync_max_sectors = mddev->array_sectors;
> diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
> index c0fb335311aa..56b234683ee6 100644
> --- a/drivers/md/raid5-ppl.c
> +++ b/drivers/md/raid5-ppl.c
> @@ -1163,7 +1163,7 @@ static int ppl_load_distributed(struct ppl_log *log)
>   		    le64_to_cpu(pplhdr->generation));
>   
>   	/* attempt to recover from log if we are starting a dirty array */
> -	if (pplhdr && !mddev->pers && mddev->recovery_cp != MaxSector)
> +	if (pplhdr && !mddev->pers && mddev->resync_offset != MaxSector)
>   		ret = ppl_recover(log, pplhdr, pplhdr_offset);
>   
>   	/* write empty header if we are starting the array */
> @@ -1422,14 +1422,14 @@ int ppl_init_log(struct r5conf *conf)
>   
>   	if (ret) {
>   		goto err;
> -	} else if (!mddev->pers && mddev->recovery_cp == 0 &&
> +	} else if (!mddev->pers && mddev->resync_offset == 0 &&
>   		   ppl_conf->recovered_entries > 0 &&
>   		   ppl_conf->mismatch_count == 0) {
>   		/*
>   		 * If we are starting a dirty array and the recovery succeeds
>   		 * without any issues, set the array as clean.
>   		 */
> -		mddev->recovery_cp = MaxSector;
> +		mddev->resync_offset = MaxSector;
>   		set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
>   	} else if (mddev->pers && ppl_conf->mismatch_count > 0) {
>   		/* no mismatch allowed when enabling PPL for a running array */
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index ca5b0e8ba707..38a193c0fdae 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -3740,7 +3740,7 @@ static int want_replace(struct stripe_head *sh, int disk_idx)
>   	    && !test_bit(Faulty, &rdev->flags)
>   	    && !test_bit(In_sync, &rdev->flags)
>   	    && (rdev->recovery_offset <= sh->sector
> -		|| rdev->mddev->recovery_cp <= sh->sector))
> +		|| rdev->mddev->resync_offset <= sh->sector))
>   		rv = 1;
>   	return rv;
>   }
> @@ -3832,7 +3832,7 @@ static int need_this_block(struct stripe_head *sh, struct stripe_head_state *s,
>   	 * is missing/faulty, then we need to read everything we can.
>   	 */
>   	if (!force_rcw &&
> -	    sh->sector < sh->raid_conf->mddev->recovery_cp)
> +	    sh->sector < sh->raid_conf->mddev->resync_offset)
>   		/* reconstruct-write isn't being forced */
>   		return 0;
>   	for (i = 0; i < s->failed && i < 2; i++) {
> @@ -4097,7 +4097,7 @@ static int handle_stripe_dirtying(struct r5conf *conf,
>   				  int disks)
>   {
>   	int rmw = 0, rcw = 0, i;
> -	sector_t recovery_cp = conf->mddev->recovery_cp;
> +	sector_t resync_offset = conf->mddev->resync_offset;
>   
>   	/* Check whether resync is now happening or should start.
>   	 * If yes, then the array is dirty (after unclean shutdown or
> @@ -4107,14 +4107,14 @@ static int handle_stripe_dirtying(struct r5conf *conf,
>   	 * generate correct data from the parity.
>   	 */
>   	if (conf->rmw_level == PARITY_DISABLE_RMW ||
> -	    (recovery_cp < MaxSector && sh->sector >= recovery_cp &&
> +	    (resync_offset < MaxSector && sh->sector >= resync_offset &&
>   	     s->failed == 0)) {
>   		/* Calculate the real rcw later - for now make it
>   		 * look like rcw is cheaper
>   		 */
>   		rcw = 1; rmw = 2;
> -		pr_debug("force RCW rmw_level=%u, recovery_cp=%llu sh->sector=%llu\n",
> -			 conf->rmw_level, (unsigned long long)recovery_cp,
> +		pr_debug("force RCW rmw_level=%u, resync_offset=%llu sh->sector=%llu\n",
> +			 conf->rmw_level, (unsigned long long)resync_offset,
>   			 (unsigned long long)sh->sector);
>   	} else for (i = disks; i--; ) {
>   		/* would I have to read this buffer for read_modify_write */
> @@ -4770,14 +4770,14 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
>   	if (test_bit(STRIPE_SYNCING, &sh->state)) {
>   		/* If there is a failed device being replaced,
>   		 *     we must be recovering.
> -		 * else if we are after recovery_cp, we must be syncing
> +		 * else if we are after resync_offset, we must be syncing
>   		 * else if MD_RECOVERY_REQUESTED is set, we also are syncing.
>   		 * else we can only be replacing
>   		 * sync and recovery both need to read all devices, and so
>   		 * use the same flag.
>   		 */
>   		if (do_recovery ||
> -		    sh->sector >= conf->mddev->recovery_cp ||
> +		    sh->sector >= conf->mddev->resync_offset ||
>   		    test_bit(MD_RECOVERY_REQUESTED, &(conf->mddev->recovery)))
>   			s->syncing = 1;
>   		else
> @@ -7780,7 +7780,7 @@ static int raid5_run(struct mddev *mddev)
>   	int first = 1;
>   	int ret = -EIO;
>   
> -	if (mddev->recovery_cp != MaxSector)
> +	if (mddev->resync_offset != MaxSector)
>   		pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
>   			  mdname(mddev));
>   
> @@ -7921,7 +7921,7 @@ static int raid5_run(struct mddev *mddev)
>   				mdname(mddev));
>   			mddev->ro = 1;
>   			set_disk_ro(mddev->gendisk, 1);
> -		} else if (mddev->recovery_cp == MaxSector)
> +		} else if (mddev->resync_offset == MaxSector)
>   			set_bit(MD_JOURNAL_CLEAN, &mddev->flags);
>   	}
>   
> @@ -7988,7 +7988,7 @@ static int raid5_run(struct mddev *mddev)
>   	mddev->resync_max_sectors = mddev->dev_sectors;
>   
>   	if (mddev->degraded > dirty_parity_disks &&
> -	    mddev->recovery_cp != MaxSector) {
> +	    mddev->resync_offset != MaxSector) {
>   		if (test_bit(MD_HAS_PPL, &mddev->flags))
>   			pr_crit("md/raid:%s: starting dirty degraded array with PPL.\n",
>   				mdname(mddev));
> @@ -8328,8 +8328,8 @@ static int raid5_resize(struct mddev *mddev, sector_t sectors)
>   
>   	md_set_array_sectors(mddev, newsize);
>   	if (sectors > mddev->dev_sectors &&
> -	    mddev->recovery_cp > mddev->dev_sectors) {
> -		mddev->recovery_cp = mddev->dev_sectors;
> +	    mddev->resync_offset > mddev->dev_sectors) {
> +		mddev->resync_offset = mddev->dev_sectors;
>   		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   	mddev->dev_sectors = sectors;
> @@ -8423,7 +8423,7 @@ static int raid5_start_reshape(struct mddev *mddev)
>   		return -EINVAL;
>   
>   	/* raid5 can't handle concurrent reshape and recovery */
> -	if (mddev->recovery_cp < MaxSector)
> +	if (mddev->resync_offset < MaxSector)
>   		return -EBUSY;
>   	for (i = 0; i < conf->raid_disks; i++)
>   		if (conf->disks[i].replacement)
> @@ -8648,7 +8648,7 @@ static void *raid45_takeover_raid0(struct mddev *mddev, int level)
>   	mddev->raid_disks += 1;
>   	mddev->delta_disks = 1;
>   	/* make sure it will be not marked as dirty */
> -	mddev->recovery_cp = MaxSector;
> +	mddev->resync_offset = MaxSector;
>   
>   	return setup_conf(mddev);
>   }


