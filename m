Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F317D8B0F
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbfJPIdk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 04:33:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37470 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388364AbfJPIdj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 04:33:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8A79BB7BD1A9B26CCAC7;
        Wed, 16 Oct 2019 16:33:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:33:35 +0800
Subject: Re: [PATCH v4] md: no longer compare spare disk superblock events in
 super_load
To:     Song Liu <songliubraving@fb.com>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
References: <20191016080003.38348-1-yuyufen@huawei.com>
 <E660B713-3623-4C8E-BF22-41ACC09F26DD@fb.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <262b85c6-8e55-62f6-7861-43db7e9ecc25@huawei.com>
Date:   Wed, 16 Oct 2019 16:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <E660B713-3623-4C8E-BF22-41ACC09F26DD@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/10/16 15:46, Song Liu wrote:
>
>> On Oct 16, 2019, at 1:00 AM, Yufen Yu <yuyufen@huawei.com> wrote:
>>
>> We have a test case as follow:
>>
>>   mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
>> 	--assume-clean --bitmap=internal
>>   mdadm -S /dev/md1
>>   mdadm -A /dev/md1 /dev/sd[b-c] --run --force
>>
>>   mdadm --zero /dev/sda
>>   mdadm /dev/md1 -a /dev/sda
>>
>>   echo offline > /sys/block/sdc/device/state
>>   echo offline > /sys/block/sdb/device/state
>>   sleep 5
>>   mdadm -S /dev/md1
>>
>>   echo running > /sys/block/sdb/device/state
>>   echo running > /sys/block/sdc/device/state
>>   mdadm -A /dev/md1 /dev/sd[a-c] --run --force
>>
>> When we readd /dev/sda to the array, it started to do recovery.
>> After offline the other two disks in md1, the recovery have
>> been interrupted and superblock update info cannot be written
>> to the offline disks. While the spare disk (/dev/sda) can continue
>> to update superblock info.
>>
>> After stopping the array and assemble it, we found the array
>> run fail, with the follow kernel message:
>>
>> [  172.986064] md: kicking non-fresh sdb from array!
>> [  173.004210] md: kicking non-fresh sdc from array!
>> [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
>> [  173.022406] md1: failed to create bitmap (-5)
>> [  173.023466] md: md1 stopped.
>>
>> Since both sdb and sdc have the value of 'sb->events' smaller than
>> that in sda, they have been kicked from the array. However, the only
>> remained disk sda is in 'spare' state before stop and it cannot be
>> added to conf->mirrors[] array. In the end, raid array assemble
>> and run fail.
>>
>> In fact, we can use the older disk sdb or sdc to assemble the array.
>> That means we should not choose the 'spare' disk as the fresh disk in
>> analyze_sbs().
>>
>> To fix the problem, we do not compare superblock events when it is
>> a spare disk, as same as validate_super.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Please add "---" before "v1->v2:". etc. This will hint git to not
> include these change lists during git-am.

OK

>> v1->v2:
>>   fix wrong return value in super_90_load
>> v2->v3:
>>   adjust the patch format to avoid scripts/checkpatch.pl warning
>> v3->v4:
>>   fix the bug pointed out by Song, when the spare disk is the first
>>   device for load_super
>> ---
>> drivers/md/md.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
>> 1 file changed, 51 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 1be7abeb24fd..fc6ae8276a92 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -1149,7 +1149,15 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>> 		rdev->desc_nr = sb->this_disk.number;
>>
>> 	if (!refdev) {
>> -		ret = 1;
>> +		/*
>> +		 * Insist on good event counter while assembling, except
>> +		 * for spares (which don't need an event count)
>> +		 */
>> +		if (sb->disks[rdev->desc_nr].state & (
>> +			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
>> +			ret = 1;
>> +		else
>> +			ret = 0;
> Have you tried only passing a couple spare disks to mdadm -A? I guess
> we will end up with freshest == NULL in analyze_sbs(), which will
> crash in validate_super().

Yes, freshest can be 'NULL'. So, I have added a test in analyze_sbs() in 
the patch.

+       /* Cannot find a valid fresh disk */
+       if (!freshest) {
+               pr_warn("md: cannot find a valid disk\n");
+               return -EINVAL;
+       }
+

Thanks,
Yufen


