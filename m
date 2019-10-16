Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8922AD86F2
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 05:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfJPDsq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 23:48:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfJPDsq (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Oct 2019 23:48:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02B34823A1713A782D25;
        Wed, 16 Oct 2019 11:48:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 11:48:43 +0800
Subject: Re: [PATCH v3] md: no longer compare spare disk superblock events in
 super_load
To:     Song Liu <liu.song.a23@gmail.com>
CC:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
References: <20191015030230.13642-1-yuyufen@huawei.com>
 <CAPhsuW5hF-SkCX4n7dJnZfEwFnTF=egjwCOJxt695Fuh6L8K3A@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <348e419c-5656-c8fa-5ec5-e39dda8a9b0d@huawei.com>
Date:   Wed, 16 Oct 2019 11:48:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5hF-SkCX4n7dJnZfEwFnTF=egjwCOJxt695Fuh6L8K3A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/10/16 0:13, Song Liu wrote:
> On Mon, Oct 14, 2019 at 10:35 PM Yufen Yu <yuyufen@huawei.com> wrote:
>> We have a test case as follow:
>>
>>    mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
>>          --assume-clean --bitmap=internal
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
>> Cc: <stable@vger.kernel.org>
> I don't think we need to cc stable here, as this is not a critical fix.
>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>>
>> v1->v2:
>>    fix wrong return value in super_90_load
>> v2->v3:
>>    adjust the patch format to avoid scripts/checkpatch.pl warning
>> ---
>>   drivers/md/md.c | 51 +++++++++++++++++++++++++++++--------------------
>>   1 file changed, 30 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 1be7abeb24fd..1be1deca3e3a 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -1097,7 +1097,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>>   {
>>          char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>>          mdp_super_t *sb;
>> -       int ret;
>> +       int ret = 0;
>>
>>          /*
>>           * Calculate the position of the superblock (512byte sectors),
>> @@ -1111,14 +1111,12 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>>          if (ret)
>>                  return ret;
>>
>> -       ret = -EINVAL;
>> -
> I think ret is handled correctly in existing code. I would not recommend this
> type of refactoring.

Yes, there is no problem for existing code. But, after adding follow test:

+               if (sb->disks[rdev->desc_nr].state & (
+                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
+                       if (ev1 > ev2)
+                               ret = 1;


If the current disk is spare or events is smaller, then ret will be set 
as default '-EINVAL',
which is not expected. Just as super_1_load(), I refactor the return.

If you don't like it, I can modify the test as following without 
refactoring:

+               if (sb->disks[rdev->desc_nr].state & (
+                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)) &&
+                       (ev1 > ev2))
                         ret = 1;
                 else
                         ret = 0;

>
>>          bdevname(rdev->bdev, b);
>>          sb = page_address(rdev->sb_page);
>>
>>          if (sb->md_magic != MD_SB_MAGIC) {
>>                  pr_warn("md: invalid raid superblock magic on %s\n", b);
>> -               goto abort;
>> +               return -EINVAL;
>>          }
>>
>>          if (sb->major_version != 0 ||
>> @@ -1126,15 +1124,15 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>>              sb->minor_version > 91) {
>>                  pr_warn("Bad version number %d.%d on %s\n",
>>                          sb->major_version, sb->minor_version, b);
>> -               goto abort;
>> +               return -EINVAL;
>>          }
>>
>>          if (sb->raid_disks <= 0)
>> -               goto abort;
>> +               return -EINVAL;
>>
>>          if (md_csum_fold(calc_sb_csum(sb)) != md_csum_fold(sb->sb_csum)) {
>>                  pr_warn("md: invalid superblock checksum on %s\n", b);
>> -               goto abort;
>> +               return -EINVAL;
>>          }
>>
>>          rdev->preferred_minor = sb->md_minor;
>> @@ -1156,19 +1154,24 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>>                  if (!md_uuid_equal(refsb, sb)) {
>>                          pr_warn("md: %s has different UUID to %s\n",
>>                                  b, bdevname(refdev->bdev,b2));
>> -                       goto abort;
>> +                       return -EINVAL;
>>                  }
>>                  if (!md_sb_equal(refsb, sb)) {
>>                          pr_warn("md: %s has same UUID but different superblock to %s\n",
>>                                  b, bdevname(refdev->bdev, b2));
>> -                       goto abort;
>> +                       return -EINVAL;
>>                  }
>>                  ev1 = md_event(sb);
>>                  ev2 = md_event(refsb);
>> -               if (ev1 > ev2)
>> -                       ret = 1;
>> -               else
>> -                       ret = 0;
>> +
>> +               /*
>> +                * Insist on good event counter while assembling, except
>> +                * for spares (which don't need an event count)
>> +                */
>> +               if (sb->disks[rdev->desc_nr].state & (
>> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
>> +                       if (ev1 > ev2)
>> +                               ret = 1;
> Just realized this:
>
> If the first device being passed to load_super is a spare device, we still
> have the same problem, no?

Good catch!

My local test with one spare disk and one normal disk shows that,
no matter what order of two disks in 'mdadm -A', spare disk cannot
be the first device in mddev->disks list. I think mdadm tool have
ordered all disks by events. So, test case will be OK.

But, I think we need to resolve the problem completely.

Yufen,
Thanks




