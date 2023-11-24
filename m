Return-Path: <linux-raid+bounces-18-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485937F6A5B
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 03:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30F928183E
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426CC658;
	Fri, 24 Nov 2023 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369F1A5;
	Thu, 23 Nov 2023 17:59:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sbypp15P7z4f3jry;
	Fri, 24 Nov 2023 09:59:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D936C1A05C4;
	Fri, 24 Nov 2023 09:59:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxGSA2BlSO0SBw--.61513S3;
	Fri, 24 Nov 2023 09:59:47 +0800 (CST)
Subject: Re: [PATCH -next 6/8] md: factor out a helper to stop sync_thread
To: Yu Kuai <yukuai1@huaweicloud.com>, Xiao Ni <xni@redhat.com>
Cc: song@kernel.org, neilb@suse.de, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
 <20231110172834.3939490-7-yukuai1@huaweicloud.com>
 <CALTww2-ivzhRRMYBoVSZ32uRUPL8Lii=z3SHGbMijsximdn=7A@mail.gmail.com>
 <CALTww2-YiGbw9HAA-hvEbCmWuOHpdHkx1KCBciRW9d6r=j44nQ@mail.gmail.com>
 <df362513-42a5-ea85-6bc4-784bba263f1b@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b94b2298-2ffb-23f2-ab1b-157ab786d6a1@huaweicloud.com>
Date: Fri, 24 Nov 2023 09:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df362513-42a5-ea85-6bc4-784bba263f1b@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxGSA2BlSO0SBw--.61513S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr45Kw48JFyDJrWxAr17trb_yoW7Ar43p3
	yfJas8Jr48Jry3ZrZrK3WDAayrZw12vrWDtry3Wa4fJw1Syr47KFyY9F18AFWkta95ta1U
	Zw4rJFW3uFy8Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/11/21 21:01, Yu Kuai 写道:
>>>
>>> It looks like the three roles (md_set_readonly, do_md_stop and
>>> stop_sync_thread) need to wait for different events. We can move these
>>> codes out this helper function and make this helper function to be
>>> more common.
>>
>> Or get lock again before returning this function and leave the wait here?

How about following patch?

  drivers/md/md.c | 89 
+++++++++++++++++++++++++++++++++++------------------------------------------------------
  1 file changed, 35 insertions(+), 54 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78f32a2e434c..fe46b67f6e87 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4868,35 +4868,18 @@ action_show(struct mddev *mddev, char *page)
         return sprintf(page, "%s\n", action_names[get_sync_action(mddev)]);
  }

-static int stop_sync_thread(struct mddev *mddev)
+static void prepare_to_stop_sync_thread(struct mddev *mddev)
+       __releases(&mddev->reconfig_mutex)
  {
-       int err = mddev_lock(mddev);
-
-       if (err)
-               return err;
-
-       /*
-        * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
-        * held.
-        */
-       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-               mddev_unlock(mddev);
-               return 0;
-       }
-
-       if (work_pending(&mddev->sync_work))
-               flush_workqueue(md_misc_wq);
-
         set_bit(MD_RECOVERY_INTR, &mddev->recovery);
         /*
-        * Thread might be blocked waiting for metadata update which 
will now
-        * never happen
+        * Thread might be blocked waiting for metadata update which
+        * will now never happen.
          */
         md_wakeup_thread_directly(mddev->sync_thread);
-
         mddev_unlock(mddev);
-
-       return 0;
+       if (work_pending(&mddev->sync_work))
+               flush_work(&mddev->sync_work);
  }

  static int idle_sync_thread(struct mddev *mddev)
@@ -4905,13 +4888,17 @@ static int idle_sync_thread(struct mddev *mddev)
         int err;

         clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-       err = stop_sync_thread(mddev);
+       err = mddev_lock(mddev);
         if (err)
                 return err;

-       err = wait_event_interruptible(resync_wait,
+       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+               prepare_to_stop_sync_thread(mddev);
+               err = wait_event_interruptible(resync_wait,
                         sync_seq != atomic_read(&mddev->sync_seq) ||
                         !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+       }
+
         return err;
  }

@@ -4920,12 +4907,15 @@ static int frozen_sync_thread(struct mddev *mddev)
         int err;

         set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-       err = stop_sync_thread(mddev);
+       err = mddev_lock(mddev);
         if (err)
                 return err;

-       err = wait_event_interruptible(resync_wait,
+       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+               prepare_to_stop_sync_thread(mddev);
+               err = wait_event_interruptible(resync_wait,
                         !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+       }

         return err;
  }
@@ -6350,11 +6340,11 @@ static void md_clean(struct mddev *mddev)
  static void __md_stop_writes(struct mddev *mddev)
  {
         set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-       if (work_pending(&mddev->sync_work))
-               flush_workqueue(md_misc_wq);
-       if (mddev->sync_thread) {
-               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-               md_reap_sync_thread(mddev);
+       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+               prepare_to_stop_sync_thread(mddev);
+               wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+                                                 &mddev->recovery));
+               mddev_lock_nointr(mddev);
         }

         del_timer_sync(&mddev->safemode_timer);
@@ -6447,18 +6437,15 @@ static int md_set_readonly(struct mddev *mddev, 
struct block_device *bdev)
                 did_freeze = 1;
                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
         }
-       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-               set_bit(MD_RECOVERY_INTR, &mddev->recovery);

-       /*
-        * Thread might be blocked waiting for metadata update which 
will now
-        * never happen
-        */
-       md_wakeup_thread_directly(mddev->sync_thread);
+       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+               prepare_to_stop_sync_thread(mddev);
+               wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+                                                 &mddev->recovery));
+       } else {
+               mddev_unlock(mddev);
+       }

-       mddev_unlock(mddev);
-       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
-                                         &mddev->recovery));
         wait_event(mddev->sb_wait,
                    !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
         mddev_lock_nointr(mddev);
@@ -6509,19 +6496,13 @@ static int do_md_stop(struct mddev *mddev, int mode,
                 did_freeze = 1;
                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
         }
-       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-
-       /*
-        * Thread might be blocked waiting for metadata update which 
will now
-        * never happen
-        */
-       md_wakeup_thread_directly(mddev->sync_thread);

-       mddev_unlock(mddev);
-       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
-                                         &mddev->recovery));
-       mddev_lock_nointr(mddev);
+       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+               prepare_to_stop_sync_thread(mddev);
+               wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+                                                 &mddev->recovery));
+               mddev_lock_nointr(mddev);
+       }

         mutex_lock(&mddev->open_mutex);
         if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||


