Return-Path: <linux-raid+bounces-4840-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C453B22313
	for <lists+linux-raid@lfdr.de>; Tue, 12 Aug 2025 11:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371E53BAE7A
	for <lists+linux-raid@lfdr.de>; Tue, 12 Aug 2025 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0172DECD8;
	Tue, 12 Aug 2025 09:22:59 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADA2E7F1D;
	Tue, 12 Aug 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990579; cv=none; b=jiMT2Se+5fFTrJUMVshZJODhp0rgGuY2pNDg4XZP6xJLrKOLbsaainViqwyQR/1mUwUWGcPNA6cTs+jy52UwrHrsJpPi472mYus7U7Eqg/41vON2HsFlL/dtXYU0lODxClXdEatRU6fyf0vVeY5RKfmjWEU2bljWdMgH3CkyulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990579; c=relaxed/simple;
	bh=BvsZ0k0PbkyGqn8TkG/C/Ho4zobrlBEj7ZSvG/qpFTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3MgjNIRb8D08KovCfVTwrz2W3QLxkTfut4CdK3URs/J+qk31FUbigAkoK92kDFGLuTxhdX8qixjMRvdi5WkZwcZjZPg98wNy7JTt9biv4nsbZ4ZT/ARWxJ3y/P1SSr9M5ajtCpOvZPoK9ieduJpKbPtjuJmsvVaMPBvBpayaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0B11861E647BA;
	Tue, 12 Aug 2025 11:22:25 +0200 (CEST)
Message-ID: <1775d473-a77f-4ac8-8195-8547dd48d754@molgen.mpg.de>
Date: Tue, 12 Aug 2025 11:22:24 +0200
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] md: fix sync_action incorrect display during
 resync
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: song@kernel.org, yukuai3@huawei.com, linan122@huawei.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
 zhengqixing@huawei.com
References: <20250812021738.3722569-1-zhengqixing@huaweicloud.com>
 <20250812021738.3722569-3-zhengqixing@huaweicloud.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812021738.3722569-3-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Zheng,


Thank you for your patch.

Am 12.08.25 um 04:17 schrieb Zheng Qixing:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> During raid resync, if a disk becomes faulty, the operation is
> briefly interrupted. The MD_RECOVERY_RECOVER flag triggered by
> the disk failure causes sync_action to incorrectly show "recover"
> instead of "resync". The same issue affects reshape operations.
> 
> Reproduction steps:
>    mdadm -Cv /dev/md1 -l1 -n4 -e1.2 /dev/sd{a..d} // -> resync happended
>    mdadm -f /dev/md1 /dev/sda                     // -> resync interrupted
>    cat sync_action
>    -> recover
> 
> Add progress checks in md_sync_action() for resync/recover/reshape
> to ensure the interface correctly reports the actual operation type.
> 
> Fixes: 4b10a3bc67c1 ("md: ensure resync is prioritized over recovery")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   drivers/md/md.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4ea956a80343..798428d0870b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4845,9 +4845,34 @@ static bool rdev_needs_recovery(struct md_rdev *rdev, sector_t sectors)
>   	return false;
>   }
>   
> +static enum sync_action md_get_active_sync_action(struct mddev *mddev)
> +{
> +	struct md_rdev *rdev;
> +	bool is_recover = false;

`is_recover` sounds strange to me, but I am not an expert with the code. 
Maybe `needs_recovery`?

> +
> +	if (mddev->resync_offset < MaxSector)
> +		return ACTION_RESYNC;
> +
> +	if (mddev->reshape_position != MaxSector)
> +		return ACTION_RESHAPE;
> +
> +	rcu_read_lock();
> +	rdev_for_each_rcu(rdev, mddev) {
> +		if (rdev->raid_disk >= 0 &&
> +		    rdev_needs_recovery(rdev, MaxSector)) {
> +			is_recover = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return is_recover ? ACTION_RECOVER : ACTION_IDLE;
> +}
> +
>   enum sync_action md_sync_action(struct mddev *mddev)
>   {
>   	unsigned long recovery = mddev->recovery;
> +	enum sync_action active_action;
>   
>   	/*
>   	 * frozen has the highest priority, means running sync_thread will be
> @@ -4871,8 +4896,17 @@ enum sync_action md_sync_action(struct mddev *mddev)
>   	    !test_bit(MD_RECOVERY_NEEDED, &recovery))
>   		return ACTION_IDLE;
>   
> -	if (test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
> -	    mddev->reshape_position != MaxSector)
> +	/*
> +	 * Check if any sync operation (resync/recover/reshape) is
> +	 * currently active. This ensures that only one sync operation
> +	 * can run at a time. Returns the type of active operation, or
> +	 * ACTION_IDLE if none are active.
> +	 */
> +	active_action = md_get_active_sync_action(mddev);
> +	if (active_action != ACTION_IDLE)
> +		return active_action;
> +
> +	if (test_bit(MD_RECOVERY_RESHAPE, &recovery))
>   		return ACTION_RESHAPE;
>   
>   	if (test_bit(MD_RECOVERY_RECOVER, &recovery))

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

