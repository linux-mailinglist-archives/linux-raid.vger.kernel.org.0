Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0895ABD66B
	for <lists+linux-raid@lfdr.de>; Wed, 25 Sep 2019 04:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411399AbfIYChs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Sep 2019 22:37:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389764AbfIYChs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 24 Sep 2019 22:37:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 70BDD9AACD6A96869ADF;
        Wed, 25 Sep 2019 10:37:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 10:37:41 +0800
Subject: Re: [PATCH] md: no longer compare spare disk superblock events in
 super_load
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.de>
References: <20190902071623.21388-1-yuyufen@huawei.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <cbef4c78-dbe1-20e8-3c31-f96ec6a99275@huawei.com>
Date:   Wed, 25 Sep 2019 10:37:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190902071623.21388-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/9/2 15:16, Yufen Yu wrote:
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 24638ccedce4..350e1f152e97 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1092,7 +1092,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>   {
>   	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>   	mdp_super_t *sb;
> -	int ret;
> +	int ret = 0;
>   
>   	/*
>   	 * Calculate the position of the superblock (512byte sectors),
> @@ -1160,10 +1160,13 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>   		}
>   		ev1 = md_event(sb);
>   		ev2 = md_event(refsb);
> -		if (ev1 > ev2)
> -			ret = 1;
> -		else
> -			ret = 0;
> +
> +		/* Insist on good event counter while assembling, except
> +		 * for spares (which don't need an event count) */
> +		if (sb->disks[rdev->desc_nr].state & (
> +			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> +			if (ev1 > ev2)
> +				ret = 1;
>   	}
>   	rdev->sectors = rdev->sb_start;

super_90_load will set 'ret = -EINVAL' before checking event count, as 
follow:

     ret = read_disk_sb(rdev, MD_SB_BYTES);
     if (ret)
         return ret;

     ret = -EINVAL;

So, we cannot write 'if' statement like that, which will  lead to 
super_90_load
return '-EINVAL' for spare disks. Then, test cases in mdadm , such as 
00linear, 00raid0,
will report failed.

I will resend the fixed version.

Thanks,
Yufen


