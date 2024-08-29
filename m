Return-Path: <linux-raid+bounces-2667-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72FE9644CB
	for <lists+linux-raid@lfdr.de>; Thu, 29 Aug 2024 14:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B821F22652
	for <lists+linux-raid@lfdr.de>; Thu, 29 Aug 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969C1B4C34;
	Thu, 29 Aug 2024 12:35:13 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E11AE020
	for <linux-raid@vger.kernel.org>; Thu, 29 Aug 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934913; cv=none; b=CTMezs4xuawr6Ds91gJN2Vpl6S1rAvDTseQ6IvrZvUD0/e0aqx5buWx8hQ6ifp3DUCFRf4UX3my+jnhICX1MZujylURuZ9QTcjPG9gnTPF7lZL5Jp22fBcp++He+MajVBNW1oH8OC5y6HvLlQ6gqKLgOL70u180froq+2E8Ed6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934913; c=relaxed/simple;
	bh=FAx/r8dKtBHgiRBt9nDNLqIJ2fNOGs3i78uxEVHHJIg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T89UIOv/51IXFH0hTjB7Bk3NCNvvBJY2GvxUFLcL6X4mXQWqleVGpfHMEBaah7itD2ymwfuZSXTnVoo7GLQDdOMctv4Qd0yiOcsfXVLI1QnYMBPQ6B+8wjUHKbQaGaOiyYj8F2rgC32EmOa/oOy9x/c0XdaWD8ge9R2IAfQLqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wvghq649cz4f3nbH
	for <linux-raid@vger.kernel.org>; Thu, 29 Aug 2024 20:34:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F8911A0568
	for <linux-raid@vger.kernel.org>; Thu, 29 Aug 2024 20:35:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4X5atBmTBw0DA--.21279S3;
	Thu, 29 Aug 2024 20:35:07 +0800 (CST)
Subject: Re: [PATCH v13 1/1] md: generate CHANGE uevents for md device
To: Kinga Stefaniuk <kinga.stefaniuk@intel.com>, linux-raid@vger.kernel.org
Cc: song@kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240828120212.31865-1-kinga.stefaniuk@intel.com>
 <20240828120212.31865-2-kinga.stefaniuk@intel.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <52d4bf87-4a8d-46c0-556d-7ef42bb147c6@huaweicloud.com>
Date: Thu, 29 Aug 2024 20:35:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240828120212.31865-2-kinga.stefaniuk@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4X5atBmTBw0DA--.21279S3
X-Coremail-Antispam: 1UD129KBjvAXoW3ZF4kGF1kuw1DZryUtFWkWFg_yoW8Zr48Jo
	Z3J34Sv3WrWryFg348tFs7tFZxXryDG3yFyw45urWDu3W5X34qvrW7WFWaqry7Xa93Gr1j
	qwn7JrsavFW5JrWDn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5E7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/08/28 20:02, Kinga Stefaniuk д��:
> In mdadm commit 49b69533e8 ("mdmonitor: check if udev has finished
> events processing") mdmonitor has been learnt to wait for udev to finish
> processing, and later in commit 9935cf0f64f3 ("Mdmonitor: Improve udev
> event handling") pooling for MD events on /proc/mdstat file has been
> deprecated because relying on udev events is more reliable and less bug
> prone (we are not competing with udev).
> 
> After those changes we are still observing missing mdmonitor events in
> some scenarios, especially SpareEvent is likely to be missed. With this
> patch MD will be able to generate more change uevents and wakeup
> mdmonitor more frequently to give it possibility to notice events.
> MD has md_new_events() functionality to trigger events and with this
> patch this function is extended to generate udev CHANGE uevents. It
> cannot be done directly because this function is called on interrupts
> context, so appropriate workqueue is created. Uevents are less time
> critical, it is safe to use workqueue. It is limited to CHANGE event as
> there is no need to generate other uevents for now.
> With this change, mdmonitor events are less likely to be missed. Our
> internal tests suite confirms that, mdmonitor reliability is (again)
> improved.
> Start using irq methods on all_mddevs_lock, because it can be reached
> by interrupt context.
> 
> Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
> Signed-off-by: Kinga Stefaniuk <kinga.stefaniuk@intel.com>
> 
> ---
> v13: fix irqsave methods in md_new_event() and mddev_put()
> v12: change lock spin_lock/unlock methods on all_mddevs_lock
> v11: use irq methods to lock/unlock all_mddevs_lock
> v10: move mddev_get into md_new_event
> v9: add using md_wq and fix if (sync) condition
> v8: fix possible conflict with del_work by adding spin_lock,
>      change default sync value to true, now false only on md_error
> v7: add new work struct for these events, use md_misc_wq workqueue,
>      fix work cancellation
> v6: use another workqueue and only on md_error, make configurable
>      if kobject_uevent is run immediately on event or queued
> v5: fix flush_work missing and commit message fixes
> v4: add more detailed commit message
> v3: fix problems with calling function from interrupt context,
>      add work_queue and queue events notification
> v2: resolve merge conflicts with applying the patch
> 
> Signed-off-by: Kinga Stefaniuk <kinga.stefaniuk@intel.com>
> ---
>   drivers/md/md.c     | 148 +++++++++++++++++++++++++++-----------------
>   drivers/md/md.h     |   3 +-
>   drivers/md/raid10.c |   2 +-
>   drivers/md/raid5.c  |   2 +-
>   4 files changed, 94 insertions(+), 61 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks!
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index d3a837506a36..d36da531003a 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -107,6 +107,7 @@ static int remove_and_add_spares(struct mddev *mddev,
>   static void mddev_detach(struct mddev *mddev);
>   static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
>   static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
> +static inline struct mddev *mddev_get(struct mddev *mddev);
>   
>   /*
>    * Default number of read corrections we'll attempt on an rdev
> @@ -323,6 +324,24 @@ static int start_readonly;
>    */
>   static bool create_on_open = true;
>   
> +/*
> + * Enables to iterate over all existing md arrays
> + * all_mddevs_lock protects this list.
> + */
> +static LIST_HEAD(all_mddevs);
> +static DEFINE_SPINLOCK(all_mddevs_lock);
> +
> +/*
> + * Send every new event to the userspace.
> + */
> +static void md_kobject_uevent_fn(struct work_struct *work)
> +{
> +	struct mddev *mddev = container_of(work, struct mddev, uevent_work);
> +
> +	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
> +	mddev_put(mddev);
> +}
> +
>   /*
>    * We have a system wide 'event count' that is incremented
>    * on any 'interesting' event, and readers of /proc/mdstat
> @@ -335,20 +354,30 @@ static bool create_on_open = true;
>    */
>   static DECLARE_WAIT_QUEUE_HEAD(md_event_waiters);
>   static atomic_t md_event_count;
> -void md_new_event(void)
> +
> +void md_new_event(struct mddev *mddev, bool sync)
>   {
>   	atomic_inc(&md_event_count);
>   	wake_up(&md_event_waiters);
> +
> +	if (mddev_is_dm(mddev))
> +		return;
> +
> +	if (!sync) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&all_mddevs_lock, flags);
> +		mddev = mddev_get(mddev);
> +		spin_unlock_irqrestore(&all_mddevs_lock, flags);
> +		if (mddev == NULL)
> +			return;
> +		queue_work(md_wq, &mddev->uevent_work);
> +		return;
> +	}
> +	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
>   }
>   EXPORT_SYMBOL_GPL(md_new_event);
>   
> -/*
> - * Enables to iterate over all existing md arrays
> - * all_mddevs_lock protects this list.
> - */
> -static LIST_HEAD(all_mddevs);
> -static DEFINE_SPINLOCK(all_mddevs_lock);
> -
>   static bool is_md_suspended(struct mddev *mddev)
>   {
>   	return percpu_ref_is_dying(&mddev->active_io);
> @@ -716,11 +745,13 @@ static void __mddev_put(struct mddev *mddev)
>   
>   void mddev_put(struct mddev *mddev)
>   {
> -	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
> +	unsigned long flags;
> +
> +	if (!atomic_dec_and_lock_irqsave(&mddev->active, &all_mddevs_lock, flags))
>   		return;
>   
>   	__mddev_put(mddev);
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irqrestore(&all_mddevs_lock, flags);
>   }
>   
>   static void md_safemode_timeout(struct timer_list *t);
> @@ -773,6 +804,7 @@ int mddev_init(struct mddev *mddev)
>   	mddev->resync_max = MaxSector;
>   	mddev->level = LEVEL_NONE;
>   
> +	INIT_WORK(&mddev->uevent_work, md_kobject_uevent_fn);
>   	INIT_WORK(&mddev->sync_work, md_start_sync);
>   	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
>   
> @@ -835,7 +867,7 @@ static struct mddev *mddev_alloc(dev_t unit)
>   	if (error)
>   		goto out_free_new;
>   
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	if (unit) {
>   		error = -EEXIST;
>   		if (mddev_find_locked(unit))
> @@ -856,11 +888,11 @@ static struct mddev *mddev_alloc(dev_t unit)
>   	}
>   
>   	list_add(&new->all_mddevs, &all_mddevs);
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   	return new;
>   
>   out_destroy_new:
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   	mddev_destroy(new);
>   out_free_new:
>   	kfree(new);
> @@ -869,9 +901,9 @@ static struct mddev *mddev_alloc(dev_t unit)
>   
>   static void mddev_free(struct mddev *mddev)
>   {
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	list_del(&mddev->all_mddevs);
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   
>   	mddev_destroy(mddev);
>   	kfree(mddev);
> @@ -2898,7 +2930,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
>   	if (mddev->degraded)
>   		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	return 0;
>   }
>   
> @@ -3015,7 +3047,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
>   				md_kick_rdev_from_array(rdev);
>   				if (mddev->pers)
>   					set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
> -				md_new_event();
> +				md_new_event(mddev, true);
>   			}
>   		}
>   	} else if (cmd_match(buf, "writemostly")) {
> @@ -3366,19 +3398,19 @@ static bool md_rdev_overlaps(struct md_rdev *rdev)
>   	struct mddev *mddev;
>   	struct md_rdev *rdev2;
>   
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
>   		if (test_bit(MD_DELETED, &mddev->flags))
>   			continue;
>   		rdev_for_each(rdev2, mddev) {
>   			if (rdev != rdev2 && rdev->bdev == rdev2->bdev &&
>   			    md_rdevs_overlap(rdev, rdev2)) {
> -				spin_unlock(&all_mddevs_lock);
> +				spin_unlock_irq(&all_mddevs_lock);
>   				return true;
>   			}
>   		}
>   	}
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   	return false;
>   }
>   
> @@ -4131,7 +4163,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
>   	if (!mddev->thread)
>   		md_update_sb(mddev, 1);
>   	sysfs_notify_dirent_safe(mddev->sysfs_level);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	rv = len;
>   out_unlock:
>   	mddev_unlock_and_resume(mddev);
> @@ -4658,7 +4690,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
>   		export_rdev(rdev, mddev);
>   	mddev_unlock_and_resume(mddev);
>   	if (!err)
> -		md_new_event();
> +		md_new_event(mddev, true);
>   	return err ? err : len;
>   }
>   
> @@ -5727,12 +5759,12 @@ md_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
>   
>   	if (!entry->show)
>   		return -EIO;
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	if (!mddev_get(mddev)) {
> -		spin_unlock(&all_mddevs_lock);
> +		spin_unlock_irq(&all_mddevs_lock);
>   		return -EBUSY;
>   	}
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   
>   	rv = entry->show(mddev, page);
>   	mddev_put(mddev);
> @@ -5751,12 +5783,12 @@ md_attr_store(struct kobject *kobj, struct attribute *attr,
>   		return -EIO;
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EACCES;
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	if (!mddev_get(mddev)) {
> -		spin_unlock(&all_mddevs_lock);
> +		spin_unlock_irq(&all_mddevs_lock);
>   		return -EBUSY;
>   	}
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   	rv = entry->store(mddev, page, length);
>   	mddev_put(mddev);
>   	return rv;
> @@ -5901,16 +5933,16 @@ struct mddev *md_alloc(dev_t dev, char *name)
>   		/* Need to ensure that 'name' is not a duplicate.
>   		 */
>   		struct mddev *mddev2;
> -		spin_lock(&all_mddevs_lock);
> +		spin_lock_irq(&all_mddevs_lock);
>   
>   		list_for_each_entry(mddev2, &all_mddevs, all_mddevs)
>   			if (mddev2->gendisk &&
>   			    strcmp(mddev2->gendisk->disk_name, name) == 0) {
> -				spin_unlock(&all_mddevs_lock);
> +				spin_unlock_irq(&all_mddevs_lock);
>   				error = -EEXIST;
>   				goto out_free_mddev;
>   			}
> -		spin_unlock(&all_mddevs_lock);
> +		spin_unlock_irq(&all_mddevs_lock);
>   	}
>   	if (name && dev)
>   		/*
> @@ -6276,7 +6308,7 @@ int md_run(struct mddev *mddev)
>   	if (mddev->sb_flags)
>   		md_update_sb(mddev, 0);
>   
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	return 0;
>   
>   bitmap_abort:
> @@ -6635,7 +6667,7 @@ static int do_md_stop(struct mddev *mddev, int mode)
>   		if (mddev->hold_active == UNTIL_STOP)
>   			mddev->hold_active = 0;
>   	}
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	sysfs_notify_dirent_safe(mddev->sysfs_state);
>   	return 0;
>   }
> @@ -7131,7 +7163,7 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
>   	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
>   	if (!mddev->thread)
>   		md_update_sb(mddev, 1);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   
>   	return 0;
>   busy:
> @@ -7202,7 +7234,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
>   	 * array immediately.
>   	 */
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	return 0;
>   
>   abort_export:
> @@ -7971,9 +8003,9 @@ static int md_open(struct gendisk *disk, blk_mode_t mode)
>   	struct mddev *mddev;
>   	int err;
>   
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	mddev = mddev_get(disk->private_data);
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   	if (!mddev)
>   		return -ENODEV;
>   
> @@ -8176,7 +8208,7 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
>   	}
>   	if (mddev->event_work.func)
>   		queue_work(md_misc_wq, &mddev->event_work);
> -	md_new_event();
> +	md_new_event(mddev, false);
>   }
>   EXPORT_SYMBOL(md_error);
>   
> @@ -8354,7 +8386,7 @@ static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>   	__acquires(&all_mddevs_lock)
>   {
>   	seq->poll_event = atomic_read(&md_event_count);
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   
>   	return seq_list_start_head(&all_mddevs, *pos);
>   }
> @@ -8367,7 +8399,7 @@ static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   static void md_seq_stop(struct seq_file *seq, void *v)
>   	__releases(&all_mddevs_lock)
>   {
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   }
>   
>   static int md_seq_show(struct seq_file *seq, void *v)
> @@ -8387,7 +8419,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
>   	if (!mddev_get(mddev))
>   		return 0;
>   
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   	spin_lock(&mddev->lock);
>   	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
>   		seq_printf(seq, "%s : %sactive", mdname(mddev),
> @@ -8458,7 +8490,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
>   		seq_printf(seq, "\n");
>   	}
>   	spin_unlock(&mddev->lock);
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   
>   	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
>   		status_unused(seq);
> @@ -8987,7 +9019,7 @@ void md_do_sync(struct md_thread *thread)
>   	try_again:
>   		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
>   			goto skip;
> -		spin_lock(&all_mddevs_lock);
> +		spin_lock_irq(&all_mddevs_lock);
>   		list_for_each_entry(mddev2, &all_mddevs, all_mddevs) {
>   			if (test_bit(MD_DELETED, &mddev2->flags))
>   				continue;
> @@ -9022,7 +9054,7 @@ void md_do_sync(struct md_thread *thread)
>   							desc, mdname(mddev),
>   							mdname(mddev2));
>   					}
> -					spin_unlock(&all_mddevs_lock);
> +					spin_unlock_irq(&all_mddevs_lock);
>   
>   					if (signal_pending(current))
>   						flush_signals(current);
> @@ -9033,7 +9065,7 @@ void md_do_sync(struct md_thread *thread)
>   				finish_wait(&resync_wait, &wq);
>   			}
>   		}
> -		spin_unlock(&all_mddevs_lock);
> +		spin_unlock_irq(&all_mddevs_lock);
>   	} while (mddev->curr_resync < MD_RESYNC_DELAYED);
>   
>   	max_sectors = md_sync_max_sectors(mddev, action);
> @@ -9073,7 +9105,7 @@ void md_do_sync(struct md_thread *thread)
>   		mddev->curr_resync = MD_RESYNC_ACTIVE; /* no longer delayed */
>   	mddev->curr_resync_completed = j;
>   	sysfs_notify_dirent_safe(mddev->sysfs_completed);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	update_time = jiffies;
>   
>   	blk_start_plug(&plug);
> @@ -9145,7 +9177,7 @@ void md_do_sync(struct md_thread *thread)
>   			/* this is the earliest that rebuild will be
>   			 * visible in /proc/mdstat
>   			 */
> -			md_new_event();
> +			md_new_event(mddev, true);
>   
>   		if (last_check + window > io_sectors || j == max_sectors)
>   			continue;
> @@ -9411,7 +9443,7 @@ static int remove_and_add_spares(struct mddev *mddev,
>   			sysfs_link_rdev(mddev, rdev);
>   			if (!test_bit(Journal, &rdev->flags))
>   				spares++;
> -			md_new_event();
> +			md_new_event(mddev, true);
>   			set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
>   		}
>   	}
> @@ -9530,7 +9562,7 @@ static void md_start_sync(struct work_struct *ws)
>   		__mddev_resume(mddev, false);
>   	md_wakeup_thread(mddev->sync_thread);
>   	sysfs_notify_dirent_safe(mddev->sysfs_action);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	return;
>   
>   not_running:
> @@ -9782,7 +9814,7 @@ void md_reap_sync_thread(struct mddev *mddev)
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	sysfs_notify_dirent_safe(mddev->sysfs_completed);
>   	sysfs_notify_dirent_safe(mddev->sysfs_action);
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	if (mddev->event_work.func)
>   		queue_work(md_misc_wq, &mddev->event_work);
>   	wake_up(&resync_wait);
> @@ -9863,11 +9895,11 @@ static int md_notify_reboot(struct notifier_block *this,
>   	struct mddev *mddev, *n;
>   	int need_delay = 0;
>   
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
>   		if (!mddev_get(mddev))
>   			continue;
> -		spin_unlock(&all_mddevs_lock);
> +		spin_unlock_irq(&all_mddevs_lock);
>   		if (mddev_trylock(mddev)) {
>   			if (mddev->pers)
>   				__md_stop_writes(mddev);
> @@ -9877,9 +9909,9 @@ static int md_notify_reboot(struct notifier_block *this,
>   		}
>   		need_delay = 1;
>   		mddev_put(mddev);
> -		spin_lock(&all_mddevs_lock);
> +		spin_lock_irq(&all_mddevs_lock);
>   	}
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   
>   	/*
>   	 * certain more exotic SCSI devices are known to be
> @@ -10230,11 +10262,11 @@ static __exit void md_exit(void)
>   	}
>   	remove_proc_entry("mdstat", NULL);
>   
> -	spin_lock(&all_mddevs_lock);
> +	spin_lock_irq(&all_mddevs_lock);
>   	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
>   		if (!mddev_get(mddev))
>   			continue;
> -		spin_unlock(&all_mddevs_lock);
> +		spin_unlock_irq(&all_mddevs_lock);
>   		export_array(mddev);
>   		mddev->ctime = 0;
>   		mddev->hold_active = 0;
> @@ -10244,9 +10276,9 @@ static __exit void md_exit(void)
>   		 * destroy_workqueue() below will wait for that to complete.
>   		 */
>   		mddev_put(mddev);
> -		spin_lock(&all_mddevs_lock);
> +		spin_lock_irq(&all_mddevs_lock);
>   	}
> -	spin_unlock(&all_mddevs_lock);
> +	spin_unlock_irq(&all_mddevs_lock);
>   
>   	destroy_workqueue(md_misc_wq);
>   	destroy_workqueue(md_bitmap_wq);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index a0d6827dced9..ab340618828c 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -582,6 +582,7 @@ struct mddev {
>   						*/
>   	struct work_struct flush_work;
>   	struct work_struct event_work;	/* used by dm to report failure event */
> +	struct work_struct uevent_work;
>   	mempool_t *serial_info_pool;
>   	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
>   	struct md_cluster_info		*cluster_info;
> @@ -883,7 +884,7 @@ extern int md_super_wait(struct mddev *mddev);
>   extern int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
>   		struct page *page, blk_opf_t opf, bool metadata_op);
>   extern void md_do_sync(struct md_thread *thread);
> -extern void md_new_event(void);
> +extern void md_new_event(struct mddev *mddev, bool sync);
>   extern void md_allow_write(struct mddev *mddev);
>   extern void md_wait_for_blocked_rdev(struct md_rdev *rdev, struct mddev *mddev);
>   extern void md_set_array_sectors(struct mddev *mddev, sector_t array_sectors);
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 2a9c4ee982e0..f76571079845 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4542,7 +4542,7 @@ static int raid10_start_reshape(struct mddev *mddev)
>   	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	conf->reshape_checkpoint = jiffies;
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	return 0;
>   
>   abort:
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index c14cf2410365..9da091b000d7 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8525,7 +8525,7 @@ static int raid5_start_reshape(struct mddev *mddev)
>   	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	conf->reshape_checkpoint = jiffies;
> -	md_new_event();
> +	md_new_event(mddev, true);
>   	return 0;
>   }
>   
> 


