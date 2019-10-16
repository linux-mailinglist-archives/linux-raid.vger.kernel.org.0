Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1AFD8B6A
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391806AbfJPIlo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 04:41:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390010AbfJPIln (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 04:41:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E9B3A7309757CD71FFE0;
        Wed, 16 Oct 2019 16:41:41 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:41:39 +0800
Subject: Re: [PATCH v4] md: no longer compare spare disk superblock events in
 super_load
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>
References: <20191016080003.38348-1-yuyufen@huawei.com>
Message-ID: <94b8f9a6-6f00-a9cc-a3ff-a4280073c622@huawei.com>
Date:   Wed, 16 Oct 2019 16:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191016080003.38348-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/10/16 16:00, Yufen Yu wrote:
> We have a test case as follow:
>
>    mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
> 	--assume-clean --bitmap=internal
>    mdadm -S /dev/md1
>    mdadm -A /dev/md1 /dev/sd[b-c] --run --force
>
>    mdadm --zero /dev/sda
>    mdadm /dev/md1 -a /dev/sda
>
>    echo offline > /sys/block/sdc/device/state
>    echo offline > /sys/block/sdb/device/state
>    sleep 5
>    mdadm -S /dev/md1
>
>    echo running > /sys/block/sdb/device/state
>    echo running > /sys/block/sdc/device/state
>    mdadm -A /dev/md1 /dev/sd[a-c] --run --force
>
> When we readd /dev/sda to the array, it started to do recovery.
> After offline the other two disks in md1, the recovery have
> been interrupted and superblock update info cannot be written
> to the offline disks. While the spare disk (/dev/sda) can continue
> to update superblock info.
>
> After stopping the array and assemble it, we found the array
> run fail, with the follow kernel message:
>
> [  172.986064] md: kicking non-fresh sdb from array!
> [  173.004210] md: kicking non-fresh sdc from array!
> [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
> [  173.022406] md1: failed to create bitmap (-5)
> [  173.023466] md: md1 stopped.
>
> Since both sdb and sdc have the value of 'sb->events' smaller than
> that in sda, they have been kicked from the array. However, the only
> remained disk sda is in 'spare' state before stop and it cannot be
> added to conf->mirrors[] array. In the end, raid array assemble
> and run fail.
>
> In fact, we can use the older disk sdb or sdc to assemble the array.
> That means we should not choose the 'spare' disk as the fresh disk in
> analyze_sbs().
>
> To fix the problem, we do not compare superblock events when it is
> a spare disk, as same as validate_super.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>
> v1->v2:
>    fix wrong return value in super_90_load
> v2->v3:
>    adjust the patch format to avoid scripts/checkpatch.pl warning
> v3->v4:
>    fix the bug pointed out by Song, when the spare disk is the first
>    device for load_super
> ---
>   drivers/md/md.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 51 insertions(+), 6 deletions(-)
>
>
> @@ -3597,7 +3632,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
>    * Check a full RAID array for plausibility
>    */
>   
> -static void analyze_sbs(struct mddev *mddev)
> +static int analyze_sbs(struct mddev *mddev)
>   {
>   	int i;
>   	struct md_rdev *rdev, *freshest, *tmp;
> @@ -3618,6 +3653,12 @@ static void analyze_sbs(struct mddev *mddev)
>   			md_kick_rdev_from_array(rdev);
>   		}
>   
> +	/* Cannot find a valid fresh disk */
> +	if (!freshest) {
> +		pr_warn("md: cannot find a valid disk\n");
> +		return -EINVAL;
> +	}
> +
>   	super_types[mddev->major_version].
>   		validate_super(mddev, freshest);
>   
> @@ -3652,6 +3693,8 @@ static void analyze_sbs(struct mddev *mddev)
>   			clear_bit(In_sync, &rdev->flags);
>   		}
>   	}
> +
> +	return 0;
>   }
>   
>   /* Read a fixed-point number.
> @@ -5570,7 +5613,9 @@ int md_run(struct mddev *mddev)
>   	if (!mddev->raid_disks) {
>   		if (!mddev->persistent)
>   			return -EINVAL;
> -		analyze_sbs(mddev);
> +		err = analyze_sbs(mddev);
> +		if (err)
> +			return -EINVAL;
>   	}
>   
>   	if (mddev->level != LEVEL_NONE)

Since freshest can be 'NULL' when all disks are spare. For that
case we return '-EINVAL'.

Thanks,
Yufen

