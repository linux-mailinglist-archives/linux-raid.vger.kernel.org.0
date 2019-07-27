Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418F877618
	for <lists+linux-raid@lfdr.de>; Sat, 27 Jul 2019 04:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfG0CzB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 26 Jul 2019 22:55:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfG0CzA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 26 Jul 2019 22:55:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 91A9EFD30DB50E82CB97;
        Sat, 27 Jul 2019 10:54:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 10:54:47 +0800
Subject: Re: [PATCH] md/raid1: fix a race between removing rdev and access
 conf->mirrors[i].rdev
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        <liu.song.a23@gmail.com>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <houtao1@huawei.com>, <zou_wei@huawei.com>
References: <20190726060051.16630-1-yuyufen@huawei.com>
 <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <b98073c3-4b81-dd4a-09b1-47e277c24961@huawei.com>
Date:   Sat, 27 Jul 2019 10:54:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/7/26 18:21, Guoqing Jiang wrote:
>
>
> On 7/26/19 8:00 AM, Yufen Yu wrote:
>> We get a NULL pointer dereference oops when test raid1 as follow:
>>
>> mdadm -CR /dev/md1 -l 1 -n 2 /dev/sd[ab]
>>
>> mdadm /dev/md1 -f /dev/sda
>> mdadm /dev/md1 -r /dev/sda
>> mdadm /dev/md1 -a /dev/sda
>> sleep 5
>> mdadm /dev/md1 -f /dev/sdb
>> mdadm /dev/md1 -r /dev/sdb
>> mdadm /dev/md1 -a /dev/sdb
>>
>> After a disk(/dev/sda) has been removed, we add the disk to raid
>> array again, which would trigger recovery action. Since the rdev
>> current state is 'spare', read/write bio can be issued to the disk.
>>
>> Then we set the other disk (/dev/sdb) faulty. Since the raid array
>> is now in degraded state and /dev/sdb is the only 'In_sync' disk,
>> raid1_error() will return but without set faulty success.
>
> I don't think you can set sdb to faulty since it is the last working
> device in raid1 per the comment, unless you did some internal change
> already.
>
>         /*
>          * If it is not operational, then we have already marked it as 
> dead
>          * else if it is the last working disks, ignore the error, let 
> the
>          * next level up know.
>          * else mark the drive as failed
>          */
>

Yes, we can not set sdb faulty *Since the raid array is now in degraded 
state
and /dev/sdb is the only In_sync disk*. And raid1_error() will return in 
follow,
*but without set faulty success*:

     if (test_bit(In_sync, &rdev->flags)
         && (conf->raid_disks - mddev->degraded) == 1) {
         /*
          * Don't fail the drive, act as though we were just a
          * normal single drive.
          * However don't try a recovery from this drive as
          * it is very likely to fail.
          */
         conf->recovery_disabled = mddev->recovery_disabled;
         spin_unlock_irqrestore(&conf->device_lock, flags);
         return;
     }

Here, 'conf->recovery_disabled' is assigned value as 
'mddev->recovery_disabled',
and 'mddev' will be set 'MD_RECOVERY_INTR' flag in md_error().
Then,  md_check_recovery() can go to remove_and_add_spares() and try to 
remove the disk.

raid1_remove_disk()
         if (test_bit(In_sync, &rdev->flags) ||
             atomic_read(&rdev->nr_pending)) {
             err = -EBUSY;
             goto abort;
         }
         /* Only remove non-faulty devices if recovery
          * is not possible.
          */
         if (!test_bit(Faulty, &rdev->flags) &&
             mddev->recovery_disabled != conf->recovery_disabled &&
             mddev->degraded < conf->raid_disks) {
             err = -EBUSY;
             goto abort;
         }
         p->rdev = NULL;

The function cannot 'goto abort', and try to set 'p->rdev = NULL',  
which cause the race
conditions in the patch as a result.

BTW, we have not changed any internal implementation of raid.


>>
>> However, that can interrupt the recovery action and
>> md_check_recovery will try to call remove_and_add_spares() to
>> remove the spare disk. And the race condition between
>> remove_and_add_spares() and raid1_write_request() in follow
>> can cause NULL pointer dereference for conf->mirrors[i].rdev:
>>
>> raid1_write_request()   md_check_recovery    raid1_error()
>> rcu_read_lock()
>> rdev != NULL
>> !test_bit(Faulty, &rdev->flags)
>>
>> conf->recovery_disabled=
>> mddev->recovery_disabled;
>>                                              return busy
>>
>>                          remove_and_add_spares
>>                          raid1_remove_disk
>
> I am not quite follow here, raid1_remove_disk is called under some 
> conditions:
>
>                 if ((this == NULL || rdev == this) &&
>                     rdev->raid_disk >= 0 &&
>                     !test_bit(Blocked, &rdev->flags) &&
>                     ((test_bit(RemoveSynchronized, &rdev->flags) ||
>                      (!test_bit(In_sync, &rdev->flags) &&
>                       !test_bit(Journal, &rdev->flags))) &&
>                     atomic_read(&rdev->nr_pending)==0))
>
> So rdev->raid_disk should not be negative value, and for the spare 
> disk showed
> as 'S' should meet the requirement:
>
>                         if (rdev->raid_disk < 0)
>                                 seq_printf(seq, "(S)"); /* spare */
>
>

Maybe I have not expressed clearly.  I observe the 'spare' state by 
'/sys/block/md1/md/dev-sda/state'.
state_show()
     if (!test_bit(Faulty, &flags) &&
         !test_bit(Journal, &flags) &&
         !test_bit(In_sync, &flags))
         len += sprintf(page+len, "spare%s", sep);

When /dev/sda has been added to the array again, hot_add_disk() just add 
it to mddev->disks list.
Then, md_check_recovery() will invoke remove_and_add_spares() to add the 
rdev in conf->mirrors[i]
array actually.
After that, rdev->raid_disk is not be negative value and we can issue 
bio to the disk.


Thanks,
Yufen

> Thanks,
> Guoqing
>
>> rdev->nr_pending == 0
>>
>> atomic_inc(&rdev->nr_pending);
>> rcu_read_unlock()
>>
>>                          p->rdev=NULL
>>
>> conf->mirrors[i].rdev->data_offset
>> NULL pointer deref!!!
>>
>>                          if (!test_bit(RemoveSynchronized,
>>                            &rdev->flags))
>>                           synchronize_rcu();
>>                           p->rdev=rdev
>>
>> To fix the race condition, we add a new flag 'WantRemove' for rdev,
>> which means rdev will be removed from the raid array.
>> Before access conf->mirrors[i].rdev, we need to ensure the rdev
>> without 'WantRemove' bit.
>>
>> Reported-by: Zou Wei <zou_wei@huawei.com>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/md/md.h    |  4 ++++
>>   drivers/md/raid1.c | 28 ++++++++++++++++++++++------
>>   2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 10f98200e2f8..ebab9340af11 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -205,6 +205,10 @@ enum flag_bits {
>>                    * multiqueue device should check if there
>>                    * is collision between write behind bios.
>>                    */
>> +    WantRemove,        /* Before set conf->mirrors[i] as NULL,
>> +                 * we set the bit first, avoiding access the
>> +                 * conf->mirrors[i] after it set NULL.
>> +                 */
>>   };
>>     static inline int is_badblock(struct md_rdev *rdev, sector_t s, 
>> int sectors,
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 34e26834ad28..838e619cd2d8 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -622,7 +622,8 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>           rdev = rcu_dereference(conf->mirrors[disk].rdev);
>>           if (r1_bio->bios[disk] == IO_BLOCKED
>>               || rdev == NULL
>> -            || test_bit(Faulty, &rdev->flags))
>> +            || test_bit(Faulty, &rdev->flags)
>> +            || test_bit(WantRemove, &rdev->flags))
>>               continue;
>>           if (!test_bit(In_sync, &rdev->flags) &&
>>               rdev->recovery_offset < this_sector + sectors)
>> @@ -751,7 +752,8 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>         if (best_disk >= 0) {
>>           rdev = rcu_dereference(conf->mirrors[best_disk].rdev);
>> -        if (!rdev)
>> +        if (!rdev || test_bit(Faulty, &rdev->flags)
>> +                || test_bit(WantRemove, &rdev->flags))
>>               goto retry;
>>           atomic_inc(&rdev->nr_pending);
>>           sectors = best_good_sectors;
>> @@ -1389,7 +1391,8 @@ static void raid1_write_request(struct mddev 
>> *mddev, struct bio *bio,
>>               break;
>>           }
>>           r1_bio->bios[i] = NULL;
>> -        if (!rdev || test_bit(Faulty, &rdev->flags)) {
>> +        if (!rdev || test_bit(Faulty, &rdev->flags)
>> +                || test_bit(WantRemove, &rdev->flags)) {
>>               if (i < conf->raid_disks)
>>                   set_bit(R1BIO_Degraded, &r1_bio->state);
>>               continue;
>> @@ -1772,6 +1775,7 @@ static int raid1_add_disk(struct mddev *mddev, 
>> struct md_rdev *rdev)
>>                 p->head_position = 0;
>>               rdev->raid_disk = mirror;
>> +            clear_bit(WantRemove, &rdev->flags);
>>               err = 0;
>>               /* As all devices are equivalent, we don't need a full 
>> recovery
>>                * if this was recently any drive of the array
>> @@ -1786,6 +1790,7 @@ static int raid1_add_disk(struct mddev *mddev, 
>> struct md_rdev *rdev)
>>               /* Add this device as a replacement */
>>               clear_bit(In_sync, &rdev->flags);
>>               set_bit(Replacement, &rdev->flags);
>> +            clear_bit(WantRemove, &rdev->flags);
>>               rdev->raid_disk = mirror;
>>               err = 0;
>>               conf->fullsync = 1;
>> @@ -1825,16 +1830,26 @@ static int raid1_remove_disk(struct mddev 
>> *mddev, struct md_rdev *rdev)
>>               err = -EBUSY;
>>               goto abort;
>>           }
>> -        p->rdev = NULL;
>> +
>> +        /*
>> +         * Before set p->rdev = NULL, we set WantRemove bit avoiding
>> +         * race between rdev remove and issue bio, which can cause
>> +         * NULL pointer deference of rdev by conf->mirrors[i].rdev.
>> +         */
>> +        set_bit(WantRemove, &rdev->flags);
>> +
>>           if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>               synchronize_rcu();
>>               if (atomic_read(&rdev->nr_pending)) {
>>                   /* lost the race, try later */
>>                   err = -EBUSY;
>> -                p->rdev = rdev;
>> +                clear_bit(WantRemove, &rdev->flags);
>>                   goto abort;
>>               }
>>           }
>> +
>> +        p->rdev = NULL;
>> +
>>           if (conf->mirrors[conf->raid_disks + number].rdev) {
>>               /* We just removed a device that is being replaced.
>>                * Move down the replacement.  We drain all IO before
>> @@ -2732,7 +2747,8 @@ static sector_t raid1_sync_request(struct mddev 
>> *mddev, sector_t sector_nr,
>>             rdev = rcu_dereference(conf->mirrors[i].rdev);
>>           if (rdev == NULL ||
>> -            test_bit(Faulty, &rdev->flags)) {
>> +            test_bit(Faulty, &rdev->flags) ||
>> +            test_bit(WantRemove, &rdev->flags)) {
>>               if (i < conf->raid_disks)
>>                   still_degraded = 1;
>>           } else if (!test_bit(In_sync, &rdev->flags)) {
>>
>
> .
>


