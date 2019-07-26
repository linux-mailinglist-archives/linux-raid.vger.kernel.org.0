Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A875D33
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jul 2019 04:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGZCrZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 25 Jul 2019 22:47:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfGZCrZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 25 Jul 2019 22:47:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8516FA1187D1382CBF4A;
        Fri, 26 Jul 2019 10:47:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 10:47:19 +0800
Subject: Re: [PATCH 2/3] md: don't set In_sync if array is frozen
To:     Guoqing Jiang <jgq516@gmail.com>, <liu.song.a23@gmail.com>
CC:     <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
 <20190724090921.13296-3-guoqing.jiang@cloud.ionos.com>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <42036d10-faf8-69de-e710-c44baac243bb@huawei.com>
Date:   Fri, 26 Jul 2019 10:47:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190724090921.13296-3-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, Guoqing


On 2019/7/24 17:09, Guoqing Jiang wrote:
> When a disk is added to array, the following path is called in mdadm.
>
> Manage_subdevs -> sysfs_freeze_array
>                 -> Manage_add
>                 -> sysfs_set_str(&info, NULL, "sync_action","idle")
>
> Then from kernel side, Manage_add invokes the path (add_new_disk ->
> validate_super = super_1_validate) to set In_sync flag.
>
> Since In_sync means "device is in_sync with rest of array", and the new
> added disk need to resync thread to help the synchronization of data.
> And md_reap_sync_thread would call spare_active to set In_sync for the
> new added disk finally. So don't set In_sync if array is in frozen.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>   drivers/md/md.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0ced0933d246..d0223316064d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1826,8 +1826,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
>   				if (!(le32_to_cpu(sb->feature_map) &
>   				      MD_FEATURE_RECOVERY_BITMAP))
>   					rdev->saved_raid_disk = -1;
> -			} else
> -				set_bit(In_sync, &rdev->flags);
> +			} else {
> +				/*
> +				 * If the array is FROZEN, then the device can't
> +				 * be in_sync with rest of array.
> +				 */
> +				if (!test_bit(MD_RECOVERY_FROZEN,
> +					      &mddev->recovery))
> +					set_bit(In_sync, &rdev->flags);
> +			}
>   			rdev->raid_disk = role;
>   			break;
>   		}

super_1_validate() set rdev with 'In_sync', while add_new_disk() will 
clear the flag bit again after that.

         clear_bit(In_sync, &rdev->flags); /* just to be sure */

So, I think there is no bad influence without test FROZEN. Am I ignoring 
anything?


