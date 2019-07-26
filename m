Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6935876366
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jul 2019 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfGZKWA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 26 Jul 2019 06:22:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41946 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGZKWA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 26 Jul 2019 06:22:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so52791847eds.8
        for <linux-raid@vger.kernel.org>; Fri, 26 Jul 2019 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=suGnXUxFyN46QiQFivhE0LdyPNc4sAoZtDzOjgPqlUQ=;
        b=QCvExKVNznrTCbJc7js2G+h/nlQou56QcZzvzZc3KSrJT00iBsBaq2E7exAuvXbyEg
         tivc5dMvVb1kAIQXyyY5/BnHzA54xALjU6aNjL2vZTQ+b3QUXPPx54TdrPo9Fy/NSoqt
         OKpVDhATBeL/YebZ9pIU/mgDKerzBLdYc2CpiCpftN7FFk50m4AIAceDtwhANAx+yyHE
         wFRtOLo4VkmyPzDav+GXnWdYxvCl9FQg7Q5tR3vceEhloOUryw4cSCAVgYBStERVPW4F
         5AARhLN7Qup1tmRxZl3ODtvrdVfQYG4rJgq/+16eppgxPR6tPL3LZr4TeNZmifrIeBky
         cqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=suGnXUxFyN46QiQFivhE0LdyPNc4sAoZtDzOjgPqlUQ=;
        b=aA6gcgHe8aMKXOMJ6LWM50GTnkAklHRp0y5RuE9cX6bU634WzfAxdrAQHLt1rUMwi6
         EHfwtPyQyiIhMIASRe57iinpxq8ReP57yFYclRMWY82SNen6LOn/06kc7OdunhSb27Gk
         LKeTLgve31wunN9iEHk7n2o3Su9ZEJtXdDLs6E89UR+17CX2da/ptHU6yVKs07sjMDDz
         uGBLHLIMdNX7dyr/Ix6qsptAp9WwcL0jgUBvvSO+2FByD82GlPegUz+Kz5zef2XxDmdS
         r2qE7OSk2sTybIoMmj1sQGSaoTovDYV8TtDT3RVx/tN8+LVfCPv5M91lk96tsd9BLkNO
         Cg9A==
X-Gm-Message-State: APjAAAX1wGgyIyKQao75EaS8EkH6hLQROBJN0bfzS5TEwXjd6pIxAQlI
        w657ba6KERs7/WimROty7ZVW39rZIXs=
X-Google-Smtp-Source: APXvYqx/0FS8nBAuxRUcOPbzN5zLfvzq+o7AbQseGBzSt/UbblMmjULpPw6V19Xye/9BUniF1MlZWQ==
X-Received: by 2002:a50:ba19:: with SMTP id g25mr81602567edc.123.1564136517472;
        Fri, 26 Jul 2019 03:21:57 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:8976:de00:6817:8b02? ([2001:1438:4010:2540:8976:de00:6817:8b02])
        by smtp.gmail.com with ESMTPSA id p15sm8220478ejr.1.2019.07.26.03.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 03:21:56 -0700 (PDT)
Subject: Re: [PATCH] md/raid1: fix a race between removing rdev and access
 conf->mirrors[i].rdev
To:     Yufen Yu <yuyufen@huawei.com>, liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org, neilb@suse.com, houtao1@huawei.com,
        zou_wei@huawei.com
References: <20190726060051.16630-1-yuyufen@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
Date:   Fri, 26 Jul 2019 12:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726060051.16630-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/26/19 8:00 AM, Yufen Yu wrote:
> We get a NULL pointer dereference oops when test raid1 as follow:
> 
> mdadm -CR /dev/md1 -l 1 -n 2 /dev/sd[ab]
> 
> mdadm /dev/md1 -f /dev/sda
> mdadm /dev/md1 -r /dev/sda
> mdadm /dev/md1 -a /dev/sda
> sleep 5
> mdadm /dev/md1 -f /dev/sdb
> mdadm /dev/md1 -r /dev/sdb
> mdadm /dev/md1 -a /dev/sdb
> 
> After a disk(/dev/sda) has been removed, we add the disk to raid
> array again, which would trigger recovery action. Since the rdev
> current state is 'spare', read/write bio can be issued to the disk.
> 
> Then we set the other disk (/dev/sdb) faulty. Since the raid array
> is now in degraded state and /dev/sdb is the only 'In_sync' disk,
> raid1_error() will return but without set faulty success.

I don't think you can set sdb to faulty since it is the last working
device in raid1 per the comment, unless you did some internal change
already.

         /*
          * If it is not operational, then we have already marked it as dead
          * else if it is the last working disks, ignore the error, let the
          * next level up know.
          * else mark the drive as failed
          */

> 
> However, that can interrupt the recovery action and
> md_check_recovery will try to call remove_and_add_spares() to
> remove the spare disk. And the race condition between
> remove_and_add_spares() and raid1_write_request() in follow
> can cause NULL pointer dereference for conf->mirrors[i].rdev:
> 
> raid1_write_request()   md_check_recovery    raid1_error()
> rcu_read_lock()
> rdev != NULL
> !test_bit(Faulty, &rdev->flags)
> 
>                                             conf->recovery_disabled=
>                                               mddev->recovery_disabled;
>                                              return busy
> 
>                          remove_and_add_spares
>                          raid1_remove_disk

I am not quite follow here, raid1_remove_disk is called under some conditions:

                 if ((this == NULL || rdev == this) &&
                     rdev->raid_disk >= 0 &&
                     !test_bit(Blocked, &rdev->flags) &&
                     ((test_bit(RemoveSynchronized, &rdev->flags) ||
                      (!test_bit(In_sync, &rdev->flags) &&
                       !test_bit(Journal, &rdev->flags))) &&
                     atomic_read(&rdev->nr_pending)==0))

So rdev->raid_disk should not be negative value, and for the spare disk showed
as 'S' should meet the requirement:

                         if (rdev->raid_disk < 0)
                                 seq_printf(seq, "(S)"); /* spare */


Thanks,
Guoqing

>                          rdev->nr_pending == 0
> 
> atomic_inc(&rdev->nr_pending);
> rcu_read_unlock()
> 
>                          p->rdev=NULL
> 
> conf->mirrors[i].rdev->data_offset
> NULL pointer deref!!!
> 
>                          if (!test_bit(RemoveSynchronized,
>                            &rdev->flags))
>                           synchronize_rcu();
>                           p->rdev=rdev
> 
> To fix the race condition, we add a new flag 'WantRemove' for rdev,
> which means rdev will be removed from the raid array.
> Before access conf->mirrors[i].rdev, we need to ensure the rdev
> without 'WantRemove' bit.
> 
> Reported-by: Zou Wei <zou_wei@huawei.com>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   drivers/md/md.h    |  4 ++++
>   drivers/md/raid1.c | 28 ++++++++++++++++++++++------
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 10f98200e2f8..ebab9340af11 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -205,6 +205,10 @@ enum flag_bits {
>   				 * multiqueue device should check if there
>   				 * is collision between write behind bios.
>   				 */
> +	WantRemove,		/* Before set conf->mirrors[i] as NULL,
> +				 * we set the bit first, avoiding access the
> +				 * conf->mirrors[i] after it set NULL.
> +				 */
>   };
>   
>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 34e26834ad28..838e619cd2d8 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -622,7 +622,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   		rdev = rcu_dereference(conf->mirrors[disk].rdev);
>   		if (r1_bio->bios[disk] == IO_BLOCKED
>   		    || rdev == NULL
> -		    || test_bit(Faulty, &rdev->flags))
> +		    || test_bit(Faulty, &rdev->flags)
> +			|| test_bit(WantRemove, &rdev->flags))
>   			continue;
>   		if (!test_bit(In_sync, &rdev->flags) &&
>   		    rdev->recovery_offset < this_sector + sectors)
> @@ -751,7 +752,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   
>   	if (best_disk >= 0) {
>   		rdev = rcu_dereference(conf->mirrors[best_disk].rdev);
> -		if (!rdev)
> +		if (!rdev || test_bit(Faulty, &rdev->flags)
> +				|| test_bit(WantRemove, &rdev->flags))
>   			goto retry;
>   		atomic_inc(&rdev->nr_pending);
>   		sectors = best_good_sectors;
> @@ -1389,7 +1391,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>   			break;
>   		}
>   		r1_bio->bios[i] = NULL;
> -		if (!rdev || test_bit(Faulty, &rdev->flags)) {
> +		if (!rdev || test_bit(Faulty, &rdev->flags)
> +				|| test_bit(WantRemove, &rdev->flags)) {
>   			if (i < conf->raid_disks)
>   				set_bit(R1BIO_Degraded, &r1_bio->state);
>   			continue;
> @@ -1772,6 +1775,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   
>   			p->head_position = 0;
>   			rdev->raid_disk = mirror;
> +			clear_bit(WantRemove, &rdev->flags);
>   			err = 0;
>   			/* As all devices are equivalent, we don't need a full recovery
>   			 * if this was recently any drive of the array
> @@ -1786,6 +1790,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   			/* Add this device as a replacement */
>   			clear_bit(In_sync, &rdev->flags);
>   			set_bit(Replacement, &rdev->flags);
> +			clear_bit(WantRemove, &rdev->flags);
>   			rdev->raid_disk = mirror;
>   			err = 0;
>   			conf->fullsync = 1;
> @@ -1825,16 +1830,26 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   			err = -EBUSY;
>   			goto abort;
>   		}
> -		p->rdev = NULL;
> +
> +		/*
> +		 * Before set p->rdev = NULL, we set WantRemove bit avoiding
> +		 * race between rdev remove and issue bio, which can cause
> +		 * NULL pointer deference of rdev by conf->mirrors[i].rdev.
> +		 */
> +		set_bit(WantRemove, &rdev->flags);
> +
>   		if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>   			synchronize_rcu();
>   			if (atomic_read(&rdev->nr_pending)) {
>   				/* lost the race, try later */
>   				err = -EBUSY;
> -				p->rdev = rdev;
> +				clear_bit(WantRemove, &rdev->flags);
>   				goto abort;
>   			}
>   		}
> +
> +		p->rdev = NULL;
> +
>   		if (conf->mirrors[conf->raid_disks + number].rdev) {
>   			/* We just removed a device that is being replaced.
>   			 * Move down the replacement.  We drain all IO before
> @@ -2732,7 +2747,8 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>   
>   		rdev = rcu_dereference(conf->mirrors[i].rdev);
>   		if (rdev == NULL ||
> -		    test_bit(Faulty, &rdev->flags)) {
> +		    test_bit(Faulty, &rdev->flags) ||
> +			test_bit(WantRemove, &rdev->flags)) {
>   			if (i < conf->raid_disks)
>   				still_degraded = 1;
>   		} else if (!test_bit(In_sync, &rdev->flags)) {
> 
