Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFAAE8CC
	for <lists+linux-raid@lfdr.de>; Tue, 10 Sep 2019 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfIJLDU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 07:03:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbfIJLDU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Sep 2019 07:03:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E63A6ED0BA6BCD333069;
        Tue, 10 Sep 2019 19:03:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 19:03:14 +0800
Subject: Re: [PATCH] md: no longer compare spare disk superblock events in
 super_load
To:     Song Liu <liu.song.a23@gmail.com>
CC:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>, <neilb@suse.de>
References: <20190902071623.21388-1-yuyufen@huawei.com>
 <CAPhsuW6DsR3qJg5M81UZQCoXCENfZ_b-q8h5G4QBPn9fbitudQ@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <7f018cbc-8ada-1868-9793-3e66846d350d@huawei.com>
Date:   Tue, 10 Sep 2019 19:03:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6DsR3qJg5M81UZQCoXCENfZ_b-q8h5G4QBPn9fbitudQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/9/4 4:52, Song Liu wrote:
> On Mon, Sep 2, 2019 at 12:04 AM Yufen Yu <yuyufen@huawei.com> wrote:
>> We have a test case as follow:
>>
>>    mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] --assume-clean --bitmap=internal
>>    mdadm -S /dev/md1
>>    mdadm -A /dev/md1 /dev/sd[b-c] --run --force
>>
>>    mdadm --zero /dev/sda
>>    mdadm /dev/md1 -a /dev/sda
>>
>>    echo offline > /sys/block/sdc/device/state
>>    echo offline > /sys/block/sdb/device/state
>>    sleep 5
>>    mdadm -S /dev/md1
>>
>>    echo running > /sys/block/sdb/device/state
>>    echo running > /sys/block/sdc/device/state
>>    mdadm -A /dev/md1 /dev/sd[a-c] --run --force
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
>> added to conf->mirrors[] array. In the end, raid array assemble and run fail.
>>
>> In fact, we can use the older disk sdb or sdc to assemble the array.
>> That means we should not choose the 'spare' disk as the fresh disk in
>> analyze_sbs().
>>
>> To fix the problem, we do not compare superblock events when it is
>> a spare disk, as same as validate_super.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/md/md.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 24638ccedce4..350e1f152e97 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -1092,7 +1092,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>>   {
>>          char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>>          mdp_super_t *sb;
>> -       int ret;
>> +       int ret = 0;
>>
>>          /*
>>           * Calculate the position of the superblock (512byte sectors),
>> @@ -1160,10 +1160,13 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>>                  }
>>                  ev1 = md_event(sb);
>>                  ev2 = md_event(refsb);
>> -               if (ev1 > ev2)
>> -                       ret = 1;
>> -               else
>> -                       ret = 0;
>> +
>> +               /* Insist on good event counter while assembling, except
>> +                * for spares (which don't need an event count) */
>> +               if (sb->disks[rdev->desc_nr].state & (
>> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
>> +                       if (ev1 > ev2)
>> +                               ret = 1;
> Instead of skipping the test, I guess we should make sure refsb passes
> a non-spare sb?
> In other words, we should fix the refdev of the super_*_load function.
>
> Does this make sense?

I agree with your suggestion. Since ->load_super is called in multiple 
point, modify
super_*_load directly may cause other problem. We can just fix 
analyze_sbs() to skip
spare disk.

Thanks
Yufen



