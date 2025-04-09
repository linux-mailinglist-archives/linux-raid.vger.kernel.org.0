Return-Path: <linux-raid+bounces-3974-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E361A82121
	for <lists+linux-raid@lfdr.de>; Wed,  9 Apr 2025 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859A43BCD2C
	for <lists+linux-raid@lfdr.de>; Wed,  9 Apr 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740B25484C;
	Wed,  9 Apr 2025 09:40:02 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731926ACD;
	Wed,  9 Apr 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191602; cv=none; b=GNVNtblCPLANdi1wT3ovYbXf11zosjy4/QLkRgKb3pa3AzwiilMSzC0RLOPxWoodpT8CaVSKvEgxvjbmH10HPjfIH/vqNlA7lmkroXGRDcxE/sxIK8WfX+ggs5LzJ7rAxwie3RorlywFlj8Z32R5RvrWBVxtbGLieIZVXXij3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191602; c=relaxed/simple;
	bh=iuwJMa3iFyt/JYuwUQxoqvcxR9MG8IH3sb+ikNittPc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dQBslaqu0OMZFuQJd096GrL17vWKR7I70TUFkUVnhBg+IoMNoFpiPY7fGDzBK4+HgbT5JgL0Mi+LmfOuIMU/6d5950MIM1nhF7t0Vh4LZ/rZTw06PEWRaXNwEJPl2HNdS0gOByIgiIJR7Nxo0xIqPGCjEZJwzQqs8yf5waE66m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZXdFD1GBcz1d1CZ;
	Wed,  9 Apr 2025 17:39:12 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id DAFBC1401E0;
	Wed,  9 Apr 2025 17:39:52 +0800 (CST)
Received: from [10.174.179.143] (10.174.179.143) by
 kwepemk500007.china.huawei.com (7.202.194.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 17:39:51 +0800
Subject: Re: [PATCH RFC] md: fix is_mddev_idle()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
CC: <axboe@kernel.dk>, <song@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20250408124125.2535488-1-yukuai1@huaweicloud.com>
 <CALTww29qrsF9ku1ykJwm1AhVuRfuOvFosd2cRSECU=m6aC7PVw@mail.gmail.com>
From: Yu Kuai <yukuai3@huawei.com>
Message-ID: <04e2d21d-7424-9be6-a2ec-e0c0a3154571@huawei.com>
Date: Wed, 9 Apr 2025 17:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww29qrsF9ku1ykJwm1AhVuRfuOvFosd2cRSECU=m6aC7PVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500007.china.huawei.com (7.202.194.92)

Hi,

在 2025/04/09 16:46, Xiao Ni 写道:
> Hi Kuai
> 
> I did a test with your patch. It also brings a big sync speed decrease
> during the test. These are some test results:
> 
> fio --name=read --filename=/dev/md0 --ioengine=libaio --rw=read
> --bs=4k --direct=1 --numjobs=1 --runtime=120 --group_reporting
> original version:
> READ: bw=1845KiB/s (1889kB/s), 1845KiB/s-1845KiB/s
> (1889kB/s-1889kB/s), io=216MiB (227MB), run=120053-120053msec
> sync speed: about 190MB/s
> with my patch:
> READ: bw=19.1MiB/s (20.0MB/s), 19.1MiB/s-19.1MiB/s
> (20.0MB/s-20.0MB/s), io=2286MiB (2397MB), run=120013-120013msec
> sync speed: 80~100MB/sec
> with this patch:
> READ: bw=20.3MiB/s (21.2MB/s), 20.3MiB/s-20.3MiB/s
> (21.2MB/s-21.2MB/s), io=2431MiB (2549MB), run=120001-120001msec
> sync speed: about 40MB/sec
> 
> fio --name=read --filename=/dev/md0 --ioengine=libaio --rw=read
> --bs=4k --direct=1 --numjobs=1 --iodepth=32 --runtime=120
> --group_reporting
> original version:
> READ: bw=9.78MiB/s (10.3MB/s), 9.78MiB/s-9.78MiB/s
> (10.3MB/s-10.3MB/s), io=1174MiB (1231MB), run=120001-120001msec
> sync speed: ～170MB/S
> with my patch:
>   READ: bw=68.3MiB/s (71.6MB/s), 68.3MiB/s-68.3MiB/s
> (71.6MB/s-71.6MB/s), io=8193MiB (8591MB), run=120014-120014msec
> sync speed: ~100MB/sec
> with this patch:
> READ: bw=110MiB/s (115MB/s), 110MiB/s-110MiB/s (115MB/s-115MB/s),
> io=12.8GiB (13.8GB), run=120003-120003msec
> sync speed: ~25MB/sec
> 
> fio --name=write --filename=/dev/md0 --ioengine=libaio --rw=write
> --bs=4k --direct=1 --numjobs=1 --iodepth=32 --runtime=120
> --group_reporting
> original version:
> WRITE: bw=1203KiB/s (1232kB/s), 1203KiB/s-1203KiB/s
> (1232kB/s-1232kB/s), io=142MiB (149MB), run=120936-120936msec
> sync speed: ～170MB/S
> with my patch:
> WRITE: bw=4994KiB/s (5114kB/s), 4994KiB/s-4994KiB/s
> (5114kB/s-5114kB/s), io=590MiB (619MB), run=121076-121076msec
> sync speed: 100MB ~ 110MB/sec
> with this patch:
>    WRITE: bw=10.5MiB/s (11.0MB/s), 10.5MiB/s-10.5MiB/s
> (11.0MB/s-11.0MB/s), io=1261MiB (1323MB), run=120002-120002msec
> sync speed: 13MB/sec
> 
> fio --name=randread --filename=/dev/md0 --ioengine=libaio
> --rw=randread --random_generator=tausworthe64 --bs=4k --direct=1
> --numjobs=1 --runtime=120 --group_reporting
> original version:
> READ: bw=17.5KiB/s (18.0kB/s), 17.5KiB/s-17.5KiB/s
> (18.0kB/s-18.0kB/s), io=2104KiB (2154kB), run=120008-120008msec
> sync speed: ～180MB/S
> with my patch:
> READ: bw=63.5KiB/s (65.0kB/s), 63.5KiB/s-63.5KiB/s
> (65.0kB/s-65.0kB/s), io=7628KiB (7811kB), run=120201-120201msec
> sync speed: 150MB ~ 160MB/sec
> with this patch:
>     READ: bw=266KiB/s (273kB/s), 266KiB/s-266KiB/s (273kB/s-273kB/s),
> io=31.2MiB (32.7MB), run=120001-120001msec
> sync speed: about 15MB/sec
> 
> The sync speed decreases too much with this patch. As we talked, I'm
> good if it's a new project. We can give the upper layer io a high
> priority. But md has run for almost 10 years after patch
> ac8fa4196d20("md: allow resync to go faster when there is competing
> IO."). It's not good to change this (only my thought). I don't think
> it's bad that raid5 tells md the io situation (my rfc
> https://www.spinics.net/lists/raid/msg79342.html)

Yes, sync speed decreases, but foreground IO bandwidth also increases,
and foregroud IO latency is important as well, you might want to check
it as well.

For raid5, this version limit inflight sync IO to 8 stripes, this is the
reason sync speed is low. This can adjust to a higher value and sync
speed will increase.

However, I still believe foreground IO latency and bandwidth is much
more important by default. We already offer the API speed min and speed
max for user if they really want higher sync speed regardless of
foreground IO.

Thanks,
Kuai
> 
> Best Regards
> Xiao
> 
> On Tue, Apr 8, 2025 at 8:50 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> If sync_speed is above speed_min, then is_mddev_idle() will be called
>> for each sync IO to check if the array is idle, and inflihgt sync_io
>> will be limited to one if the array is not idle.
>>
>> However, while mkfs.ext4 for a large raid5 array while recovery is in
>> progress, it's found that sync_speed is already above speed_min while
>> lots of stripes are used for sync IO, causing long delay for mkfs.ext4.
>>
>> Root cause is the following checking from is_mddev_idle():
>>
>> t1: submit sync IO: events1 = completed IO - issued sync IO
>> t2: submit next sync IO: events2  = completed IO - issued sync IO
>> if (events2 - events1 > 64)
>>
>> For consequence, the more sync IO issued, the less likely checking will
>> pass. And when completed normal IO is more than issued sync IO, the
>> condition will finally pass and is_mddev_idle() will return false,
>> however, last_events will be updated hence is_mddev_idle() can only
>> return false once in a while.
>>
>> Fix this problem by changing the checking as following:
>>
>> 1) mddev doesn't have normal IO completed;
>> 2) mddev doesn't have normal IO inflight;
>> 3) if any member disks is partition, and all other partitions doesn't
>>     have IO completed.
>>
>> Noted in order to prevent sync speed to drop conspicuously, the inflight
>> sync IO above speed_min is also increased from 1 to 8.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk.h            |  1 -
>>   block/genhd.c          |  1 +
>>   drivers/md/md.c        | 97 +++++++++++++++++++++++++-----------------
>>   drivers/md/md.h        | 12 +-----
>>   drivers/md/raid1.c     |  3 --
>>   drivers/md/raid10.c    |  9 ----
>>   drivers/md/raid5.c     |  8 ----
>>   include/linux/blkdev.h |  2 +-
>>   8 files changed, 60 insertions(+), 73 deletions(-)
>>
>> diff --git a/block/blk.h b/block/blk.h
>> index 90fa5f28ccab..a78f9df72a83 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -413,7 +413,6 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>>   int blk_dev_init(void);
>>
>>   void update_io_ticks(struct block_device *part, unsigned long now, bool end);
>> -unsigned int part_in_flight(struct block_device *part);
>>
>>   static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>>   {
>> diff --git a/block/genhd.c b/block/genhd.c
>> index e9375e20d866..0ce35bc88196 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -139,6 +139,7 @@ unsigned int part_in_flight(struct block_device *part)
>>
>>          return inflight;
>>   }
>> +EXPORT_SYMBOL_GPL(part_in_flight);
>>
>>   static void part_in_flight_rw(struct block_device *part,
>>                  unsigned int inflight[2])
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index cefa9cba711b..c65483a33d7a 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8585,50 +8585,51 @@ void md_cluster_stop(struct mddev *mddev)
>>          put_cluster_ops(mddev);
>>   }
>>
>> -static int is_mddev_idle(struct mddev *mddev, int init)
>> +static bool is_rdev_idle(struct md_rdev *rdev, bool init)
>>   {
>> -       struct md_rdev *rdev;
>> -       int idle;
>> -       int curr_events;
>> +       int last_events = rdev->last_events;
>>
>> -       idle = 1;
>> -       rcu_read_lock();
>> -       rdev_for_each_rcu(rdev, mddev) {
>> -               struct gendisk *disk = rdev->bdev->bd_disk;
>> +       if (!bdev_is_partition(rdev->bdev))
>> +               return true;
>>
>> -               if (!init && !blk_queue_io_stat(disk->queue))
>> -                       continue;
>> +       rdev->last_events = (int)part_stat_read_accum(rdev->bdev->bd_disk->part0, sectors) -
>> +                           (int)part_stat_read_accum(rdev->bdev, sectors);
>>
>> -               curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
>> -                             atomic_read(&disk->sync_io);
>> -               /* sync IO will cause sync_io to increase before the disk_stats
>> -                * as sync_io is counted when a request starts, and
>> -                * disk_stats is counted when it completes.
>> -                * So resync activity will cause curr_events to be smaller than
>> -                * when there was no such activity.
>> -                * non-sync IO will cause disk_stat to increase without
>> -                * increasing sync_io so curr_events will (eventually)
>> -                * be larger than it was before.  Once it becomes
>> -                * substantially larger, the test below will cause
>> -                * the array to appear non-idle, and resync will slow
>> -                * down.
>> -                * If there is a lot of outstanding resync activity when
>> -                * we set last_event to curr_events, then all that activity
>> -                * completing might cause the array to appear non-idle
>> -                * and resync will be slowed down even though there might
>> -                * not have been non-resync activity.  This will only
>> -                * happen once though.  'last_events' will soon reflect
>> -                * the state where there is little or no outstanding
>> -                * resync requests, and further resync activity will
>> -                * always make curr_events less than last_events.
>> -                *
>> -                */
>> -               if (init || curr_events - rdev->last_events > 64) {
>> -                       rdev->last_events = curr_events;
>> -                       idle = 0;
>> -               }
>> +       if (!init && rdev->last_events > last_events)
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>> +/*
>> + * mddev is idle if following conditions are match since last check:
>> + * 1) mddev doesn't have normal IO completed;
>> + * 2) mddev doesn't have inflight normal IO;
>> + * 3) if any member disk is partition, and other partitions doesn't have IO
>> + *    completed;
>> + *
>> + * Noted this checking rely on IO accounting is enabled.
>> + */
>> +static bool is_mddev_idle(struct mddev *mddev, bool init)
>> +{
>> +       struct md_rdev *rdev;
>> +       bool idle = true;
>> +
>> +       if (!mddev_is_dm(mddev)) {
>> +               int last_events = mddev->last_events;
>> +
>> +               mddev->last_events = (int)part_stat_read_accum(mddev->gendisk->part0, sectors);
>> +               if (!init && (mddev->last_events > last_events ||
>> +                             part_in_flight(mddev->gendisk->part0)))
>> +                       idle = false;
>>          }
>> +
>> +       rcu_read_lock();
>> +       rdev_for_each_rcu(rdev, mddev)
>> +               if (!is_rdev_idle(rdev, init))
>> +                       idle = false;
>>          rcu_read_unlock();
>> +
>>          return idle;
>>   }
>>
>> @@ -8940,6 +8941,21 @@ static sector_t md_sync_position(struct mddev *mddev, enum sync_action action)
>>          }
>>   }
>>
>> +/*
>> + * For raid 456, sync IO is stripe(4k) per IO, for other levels, it's
>> + * RESYNC_PAGES(64k) per IO, we limit inflight sync IO for no more than
>> + * 8 if sync_speed is above speed_min.
>> + */
>> +static int get_active_threshold(struct mddev *mddev)
>> +{
>> +       int max_active = 128 * 8;
>> +
>> +       if (mddev->level == 4 || mddev->level == 5 || mddev->level == 6)
>> +               max_active = 8 * 8;
>> +
>> +       return max_active;
>> +}
>> +
>>   #define SYNC_MARKS     10
>>   #define        SYNC_MARK_STEP  (3*HZ)
>>   #define UPDATE_FREQUENCY (5*60*HZ)
>> @@ -8953,6 +8969,7 @@ void md_do_sync(struct md_thread *thread)
>>          unsigned long update_time;
>>          sector_t mark_cnt[SYNC_MARKS];
>>          int last_mark,m;
>> +       int active_threshold = get_active_threshold(mddev);
>>          sector_t last_check;
>>          int skipped = 0;
>>          struct md_rdev *rdev;
>> @@ -9208,14 +9225,14 @@ void md_do_sync(struct md_thread *thread)
>>                                  msleep(500);
>>                                  goto repeat;
>>                          }
>> -                       if (!is_mddev_idle(mddev, 0)) {
>> +                       if (atomic_read(&mddev->recovery_active) >= active_threshold &&
>> +                           !is_mddev_idle(mddev, 0))
>>                                  /*
>>                                   * Give other IO more of a chance.
>>                                   * The faster the devices, the less we wait.
>>                                   */
>>                                  wait_event(mddev->recovery_wait,
>>                                             !atomic_read(&mddev->recovery_active));
>> -                       }
>>                  }
>>          }
>>          pr_info("md: %s: %s %s.\n",mdname(mddev), desc,
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index dd6a28f5d8e6..6890aa4ac8b4 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -518,6 +518,7 @@ struct mddev {
>>                                                           * adding a spare
>>                                                           */
>>
>> +       int last_events;                /* IO event timestamp */
>>          atomic_t                        recovery_active; /* blocks scheduled, but not written */
>>          wait_queue_head_t               recovery_wait;
>>          sector_t                        recovery_cp;
>> @@ -714,17 +715,6 @@ static inline int mddev_trylock(struct mddev *mddev)
>>   }
>>   extern void mddev_unlock(struct mddev *mddev);
>>
>> -static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>> -{
>> -       if (blk_queue_io_stat(bdev->bd_disk->queue))
>> -               atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
>> -}
>> -
>> -static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
>> -{
>> -       md_sync_acct(bio->bi_bdev, nr_sectors);
>> -}
>> -
>>   struct md_personality
>>   {
>>          struct md_submodule_head head;
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index e366d0bba792..d422bab77580 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -2376,7 +2376,6 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
>>
>>                  wbio->bi_end_io = end_sync_write;
>>                  atomic_inc(&r1_bio->remaining);
>> -               md_sync_acct(conf->mirrors[i].rdev->bdev, bio_sectors(wbio));
>>
>>                  submit_bio_noacct(wbio);
>>          }
>> @@ -3049,7 +3048,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>>                          bio = r1_bio->bios[i];
>>                          if (bio->bi_end_io == end_sync_read) {
>>                                  read_targets--;
>> -                               md_sync_acct_bio(bio, nr_sectors);
>>                                  if (read_targets == 1)
>>                                          bio->bi_opf &= ~MD_FAILFAST;
>>                                  submit_bio_noacct(bio);
>> @@ -3058,7 +3056,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>>          } else {
>>                  atomic_set(&r1_bio->remaining, 1);
>>                  bio = r1_bio->bios[r1_bio->read_disk];
>> -               md_sync_acct_bio(bio, nr_sectors);
>>                  if (read_targets == 1)
>>                          bio->bi_opf &= ~MD_FAILFAST;
>>                  submit_bio_noacct(bio);
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 6ef65b4d1093..12fb01987ff3 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -2426,7 +2426,6 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>>
>>                  atomic_inc(&conf->mirrors[d].rdev->nr_pending);
>>                  atomic_inc(&r10_bio->remaining);
>> -               md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
>>
>>                  if (test_bit(FailFast, &conf->mirrors[d].rdev->flags))
>>                          tbio->bi_opf |= MD_FAILFAST;
>> @@ -2448,8 +2447,6 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>>                          bio_copy_data(tbio, fbio);
>>                  d = r10_bio->devs[i].devnum;
>>                  atomic_inc(&r10_bio->remaining);
>> -               md_sync_acct(conf->mirrors[d].replacement->bdev,
>> -                            bio_sectors(tbio));
>>                  submit_bio_noacct(tbio);
>>          }
>>
>> @@ -2583,13 +2580,10 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>>          d = r10_bio->devs[1].devnum;
>>          if (wbio->bi_end_io) {
>>                  atomic_inc(&conf->mirrors[d].rdev->nr_pending);
>> -               md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
>>                  submit_bio_noacct(wbio);
>>          }
>>          if (wbio2) {
>>                  atomic_inc(&conf->mirrors[d].replacement->nr_pending);
>> -               md_sync_acct(conf->mirrors[d].replacement->bdev,
>> -                            bio_sectors(wbio2));
>>                  submit_bio_noacct(wbio2);
>>          }
>>   }
>> @@ -3757,7 +3751,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>>                  r10_bio->sectors = nr_sectors;
>>
>>                  if (bio->bi_end_io == end_sync_read) {
>> -                       md_sync_acct_bio(bio, nr_sectors);
>>                          bio->bi_status = 0;
>>                          submit_bio_noacct(bio);
>>                  }
>> @@ -4882,7 +4875,6 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
>>          r10_bio->sectors = nr_sectors;
>>
>>          /* Now submit the read */
>> -       md_sync_acct_bio(read_bio, r10_bio->sectors);
>>          atomic_inc(&r10_bio->remaining);
>>          read_bio->bi_next = NULL;
>>          submit_bio_noacct(read_bio);
>> @@ -4942,7 +4934,6 @@ static void reshape_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>>                          continue;
>>
>>                  atomic_inc(&rdev->nr_pending);
>> -               md_sync_acct_bio(b, r10_bio->sectors);
>>                  atomic_inc(&r10_bio->remaining);
>>                  b->bi_next = NULL;
>>                  submit_bio_noacct(b);
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 6389383166c0..ca5b0e8ba707 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -1240,10 +1240,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
>>                  }
>>
>>                  if (rdev) {
>> -                       if (s->syncing || s->expanding || s->expanded
>> -                           || s->replacing)
>> -                               md_sync_acct(rdev->bdev, RAID5_STRIPE_SECTORS(conf));
>> -
>>                          set_bit(STRIPE_IO_STARTED, &sh->state);
>>
>>                          bio_init(bi, rdev->bdev, &dev->vec, 1, op | op_flags);
>> @@ -1300,10 +1296,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
>>                                  submit_bio_noacct(bi);
>>                  }
>>                  if (rrdev) {
>> -                       if (s->syncing || s->expanding || s->expanded
>> -                           || s->replacing)
>> -                               md_sync_acct(rrdev->bdev, RAID5_STRIPE_SECTORS(conf));
>> -
>>                          set_bit(STRIPE_IO_STARTED, &sh->state);
>>
>>                          bio_init(rbi, rrdev->bdev, &dev->rvec, 1, op | op_flags);
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 248416ecd01c..da1a161627ba 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -182,7 +182,6 @@ struct gendisk {
>>          struct list_head slave_bdevs;
>>   #endif
>>          struct timer_rand_state *random;
>> -       atomic_t sync_io;               /* RAID */
>>          struct disk_events *ev;
>>
>>   #ifdef CONFIG_BLK_DEV_ZONED
>> @@ -1117,6 +1116,7 @@ static inline long nr_blockdev_pages(void)
>>
>>   extern void blk_io_schedule(void);
>>
>> +unsigned int part_in_flight(struct block_device *part);
>>   int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>                  sector_t nr_sects, gfp_t gfp_mask);
>>   int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>> --
>> 2.39.2
>>
> 
> 
> .
> 

