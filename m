Return-Path: <linux-raid+bounces-949-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CF86AEBD
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 13:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFE61C2130C
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17E73539;
	Wed, 28 Feb 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYg4ATIW"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4A7350A
	for <linux-raid@vger.kernel.org>; Wed, 28 Feb 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122069; cv=none; b=ebhoraepOy4iw0iO6Sttr6hM8h6uxa1Dfy56mi0upD1MKcJPTTy1g0ygWvHJGrquUtNsA33o9NUyknIqh5zRn7GR9OTcuZPYspZeBRnfg+STn8+CF7/3HmE0tjvEA7RJGtbDAN1iZn1KzIagsiQNttIIKSBXlwemA0XGflyDF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122069; c=relaxed/simple;
	bh=hHm/I4P+cHnU34VH12YhigWDqOadRt/vfK79+wBcH7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEhBx0b7nCROBtTuW4ktNQKea/oyOhyvwdeEqG9Pjsxsyu+kTwbyWkVWLIWyadpx2XHAybfh7/S4v5ncbsAG9E5eyub/5G168kY/K1KB4+T93wsGbB5qkYCoWq04em+xTptLYL/Jnmg6hsuqo6ghrA6/AXdW/vRBrKZ1ud8mP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYg4ATIW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709122065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfh31fq56Jds7QolJswbvo93Q4xLp5Ucmf6Kos63TTA=;
	b=aYg4ATIWL1MZfkoLpu4ysMT9NO+7DMrSbUiLkGgWrdSZQ9M1lW/hyosh3swdEw8X3MwALe
	eQ/MwJfsrG8Vnhts0eGMDjeFbWTwOpleVcQv3fkzQk/PMu1bnLqrB6jfQdYThycP5N89RK
	yMcP/1tzOEyqYLRJnKgqu4YWMs4ctKg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-lh39HEVGMmC64GsHQyvdPQ-1; Wed, 28 Feb 2024 07:07:44 -0500
X-MC-Unique: lh39HEVGMmC64GsHQyvdPQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dc6b99b045so8391915ad.0
        for <linux-raid@vger.kernel.org>; Wed, 28 Feb 2024 04:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122061; x=1709726861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hfh31fq56Jds7QolJswbvo93Q4xLp5Ucmf6Kos63TTA=;
        b=mNLZKhhvpqF+wTmjhI5SriK4AGo5O1ZkKKvenW7GBrvuGpSA2qPdnnH5+7AKSBDuJw
         cf17zT8D/20TkYabWKzyOnMWVYRFDKTc8D8XHaeko15QdIaNVrbtkzRIPsMCXfbAbiGO
         VfJQInrdlW7sdLWVfDyPrnGY0wfhniFbWy3YP+YCmTz0lIEqPSTaqpiaU0Ig1VDIaHDp
         luGK+tZQYDAFWJ3GnCEiiiO42lu4xI+d7TpPKVFFiYNb8KvzT2uPHtLZk9o0umr2rQea
         g/2WVekiSIXDttsAi7fKHjG30rVPPLSQS9A6iHkIeQe1j15cFTZN5PR+js/z/3JU7g+K
         LetA==
X-Forwarded-Encrypted: i=1; AJvYcCW5x4jIxsf23FrlOjC2CazltXJ/3lKPCcna921PEU+X1jwzEKTRcdlBUorbiSpL1u3XUbdAfBUjYE19x2PgQq0nwP3V1vAzXNiOSQ==
X-Gm-Message-State: AOJu0YxS7XUTBJ+Wq1tf2GBAZzE2s2BWtQiWUb0+qCuxa28H2mWL0ciY
	nt/Dj97movfxcnFz5yu4FY/67qPmUMW8mF/s2pSU+3gYAJ3a9OLEN4Bo4bue6AzXd3jXF/ThtfP
	pujxH383KdsMUkn7vDmc8dH7oVCdLdEjsC6E3bdwFNbfR5MIiu73t5cJN3mTSKxzIvaCETk5Y
X-Received: by 2002:a17:902:eccc:b0:1dc:b008:f678 with SMTP id a12-20020a170902eccc00b001dcb008f678mr3106654plh.18.1709122061066;
        Wed, 28 Feb 2024 04:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOb5p6CJ7/VGdWKlNQI/6VTgRkL8MOLpLKfbU5r9Mza3kNigm/oN7pThv8sNGkTHKADWR/pg==
X-Received: by 2002:a17:902:eccc:b0:1dc:b008:f678 with SMTP id a12-20020a170902eccc00b001dcb008f678mr3106618plh.18.1709122060551;
        Wed, 28 Feb 2024 04:07:40 -0800 (PST)
Received: from [10.72.120.8] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ko5-20020a17090307c500b001d9bd8fa492sm3142858plb.211.2024.02.28.04.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 04:07:40 -0800 (PST)
Message-ID: <d233fc29-e3ab-4761-9368-c203efc0466e@redhat.com>
Date: Wed, 28 Feb 2024 20:07:34 +0800
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/14] md: don't register sync_thread for reshape
 directly
To: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com,
 heinzm@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org,
 yukuai3@huawei.com, neilb@suse.de, shli@fb.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-5-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
In-Reply-To: <20240201092559.910982-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/1 下午5:25, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, if reshape is interrupted, then reassemble the array will
> register sync_thread directly from pers->run(), in this case
> 'MD_RECOVERY_RUNNING' is set directly, however, there is no guarantee
> that md_do_sync() will be executed, hence stop_sync_thread() will hang
> because 'MD_RECOVERY_RUNNING' can't be cleared.


Hi Kuai

I have a question here. Is it the reason sync_thread can't run 
md_do_sync because kthread_should_stop, so it doesn't have the chance to 
set MD_RECOVERY_DONE? Why creating sync thread in md_check_recovery 
doesn't have this problem? Could you explain more about this?

Best Regards

Xiao

>
> Last patch make sure that md_do_sync() will set MD_RECOVERY_DONE,
> however, following hang can still be triggered by dm-raid test
> shell/lvconvert-raid-reshape.sh occasionally:
>
> [root@fedora ~]# cat /proc/1982/stack
> [<0>] stop_sync_thread+0x1ab/0x270 [md_mod]
> [<0>] md_frozen_sync_thread+0x5c/0xa0 [md_mod]
> [<0>] raid_presuspend+0x1e/0x70 [dm_raid]
> [<0>] dm_table_presuspend_targets+0x40/0xb0 [dm_mod]
> [<0>] __dm_destroy+0x2a5/0x310 [dm_mod]
> [<0>] dm_destroy+0x16/0x30 [dm_mod]
> [<0>] dev_remove+0x165/0x290 [dm_mod]
> [<0>] ctl_ioctl+0x4bb/0x7b0 [dm_mod]
> [<0>] dm_ctl_ioctl+0x11/0x20 [dm_mod]
> [<0>] vfs_ioctl+0x21/0x60
> [<0>] __x64_sys_ioctl+0xb9/0xe0
> [<0>] do_syscall_64+0xc6/0x230
> [<0>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
>
> Meanwhile mddev->recovery is:
> MD_RECOVERY_RUNNING |
> MD_RECOVERY_INTR |
> MD_RECOVERY_RESHAPE |
> MD_RECOVERY_FROZEN
>
> Fix this problem by remove the code to register sync_thread directly
> from raid10 and raid5. And let md_check_recovery() to register
> sync_thread.
>
> Fixes: f67055780caa ("[PATCH] md: Checkpoint and allow restart of raid5 reshape")
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c     |  5 ++++-
>   drivers/md/raid10.c | 16 ++--------------
>   drivers/md/raid5.c  | 29 ++---------------------------
>   3 files changed, 8 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index c65dfd156090..6c5d0a372927 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9372,6 +9372,7 @@ static void md_start_sync(struct work_struct *ws)
>   	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
>   	int spares = 0;
>   	bool suspend = false;
> +	char *name;
>   
>   	if (md_spares_need_change(mddev))
>   		suspend = true;
> @@ -9404,8 +9405,10 @@ static void md_start_sync(struct work_struct *ws)
>   	if (spares)
>   		md_bitmap_write_all(mddev->bitmap);
>   
> +	name = test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) ?
> +			"reshape" : "resync";
>   	rcu_assign_pointer(mddev->sync_thread,
> -			   md_register_thread(md_do_sync, mddev, "resync"));
> +			   md_register_thread(md_do_sync, mddev, name));
>   	if (!mddev->sync_thread) {
>   		pr_warn("%s: could not start resync thread...\n",
>   			mdname(mddev));
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 7412066ea22c..a5f8419e2df1 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4175,11 +4175,7 @@ static int raid10_run(struct mddev *mddev)
>   		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>   		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -		rcu_assign_pointer(mddev->sync_thread,
> -			md_register_thread(md_do_sync, mddev, "reshape"));
> -		if (!mddev->sync_thread)
> -			goto out_free_conf;
> +		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   
>   	return 0;
> @@ -4573,16 +4569,8 @@ static int raid10_start_reshape(struct mddev *mddev)
>   	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>   	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -
> -	rcu_assign_pointer(mddev->sync_thread,
> -			   md_register_thread(md_do_sync, mddev, "reshape"));
> -	if (!mddev->sync_thread) {
> -		ret = -EAGAIN;
> -		goto abort;
> -	}
> +	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	conf->reshape_checkpoint = jiffies;
> -	md_wakeup_thread(mddev->sync_thread);
>   	md_new_event();
>   	return 0;
>   
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8497880135ee..6a7a32f7fb91 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7936,11 +7936,7 @@ static int raid5_run(struct mddev *mddev)
>   		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>   		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -		rcu_assign_pointer(mddev->sync_thread,
> -			md_register_thread(md_do_sync, mddev, "reshape"));
> -		if (!mddev->sync_thread)
> -			goto abort;
> +		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   
>   	/* Ok, everything is just fine now */
> @@ -8506,29 +8502,8 @@ static int raid5_start_reshape(struct mddev *mddev)
>   	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>   	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -	rcu_assign_pointer(mddev->sync_thread,
> -			   md_register_thread(md_do_sync, mddev, "reshape"));
> -	if (!mddev->sync_thread) {
> -		mddev->recovery = 0;
> -		spin_lock_irq(&conf->device_lock);
> -		write_seqcount_begin(&conf->gen_lock);
> -		mddev->raid_disks = conf->raid_disks = conf->previous_raid_disks;
> -		mddev->new_chunk_sectors =
> -			conf->chunk_sectors = conf->prev_chunk_sectors;
> -		mddev->new_layout = conf->algorithm = conf->prev_algo;
> -		rdev_for_each(rdev, mddev)
> -			rdev->new_data_offset = rdev->data_offset;
> -		smp_wmb();
> -		conf->generation --;
> -		conf->reshape_progress = MaxSector;
> -		mddev->reshape_position = MaxSector;
> -		write_seqcount_end(&conf->gen_lock);
> -		spin_unlock_irq(&conf->device_lock);
> -		return -EAGAIN;
> -	}
> +	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	conf->reshape_checkpoint = jiffies;
> -	md_wakeup_thread(mddev->sync_thread);
>   	md_new_event();
>   	return 0;
>   }


