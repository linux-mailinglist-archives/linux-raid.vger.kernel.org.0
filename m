Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB07897F
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfG2KRH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 06:17:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36180 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbfG2KRG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 06:17:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so58836889edq.3
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JSy7C7kBb0Lspbr5ujH0Glzx2hVRGaPS1+BXzAHrh8=;
        b=EDOIFE3fsJPdZ1HvXAS5FiWYuGiNwWX73z4NCWpIAqVcNSlbrj0qRTx4eMSLMDUSbv
         lFa2HJuofRfg1yaDr+emnIPQLAs/VoM2QRshTh/yxpTEH7mK9UvVIG+ynyzuWwM5PpN2
         hWiMekY2mYgqXRjsetKJAU41dElomtuytaGeBO4CTnmePll8igMxLGaVDoF4ZmgfW4+a
         Ay4Q0+VSWEL75TULO/BI/L1dRUhWqgJeW/0lTc2pUXQVQYETtSzP8GxjgIiEhAGRU20c
         v5LVLw1SFs8JW34agY8VdOASVpM+m7QktvkVL7S8QCT9fRmdyshHik6VE0hPkuLXC5+X
         /x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JSy7C7kBb0Lspbr5ujH0Glzx2hVRGaPS1+BXzAHrh8=;
        b=K5qRljHndF2hNntFjcRWSeIACziab7LLhzX9w0VW01QMM/pFaAHAzeV0K/XQKTbLGZ
         P/mMTI5ALe8k7SuDgIUt0fYhc1H/2wQ941FZhKBDOS+J4LA494of9CRa0c07Wu9wFkhg
         f/+x1ON9Apjfpx1svq3+6dJ6ekKxxwRI6PXrqAGBiS8KM/VmWWCDPCnyKGOMAJxLIy2c
         xeaylfImY6fbTkQ6cFROkWtyL0qcG0QoSLXD4hZIXY4NtGLGpoJJW5Yb+7kAZDQtYtQN
         P/f+jOjAkCdvV+26uTdtTJq5zNerFqMmUgPoRmBpnuuC80+Nd8cqhI7Zr4H+HHj5AV+V
         MK0A==
X-Gm-Message-State: APjAAAVnydohtubsz+02frLV3b3RlJOwTeaG9Zj1tpmC+ZefJkMOOiLb
        QWT4WPvc6zatF2uWCBxA1tls+zYFfH0=
X-Google-Smtp-Source: APXvYqxOOoX5CkDQa7DC8F49jOL9amSSP1yeJQYeEZw0ik/8AiNAbBobciOfcRX0yDNF3ttKkbb8Fg==
X-Received: by 2002:a17:906:f91:: with SMTP id q17mr39736ejj.297.1564395424132;
        Mon, 29 Jul 2019 03:17:04 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:e5f9:3830:1b1f:5b33? ([2001:1438:4010:2540:e5f9:3830:1b1f:5b33])
        by smtp.gmail.com with ESMTPSA id o21sm15314368edt.26.2019.07.29.03.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:17:03 -0700 (PDT)
Subject: Re: [PATCH] md/raid1: fix a race between removing rdev and access
 conf->mirrors[i].rdev
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     liu.song.a23@gmail.com
Cc:     neilb@suse.com, houtao1@huawei.com, zou_wei@huawei.com,
        linux-raid@vger.kernel.org
References: <20190726060051.16630-1-yuyufen@huawei.com>
 <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
 <b98073c3-4b81-dd4a-09b1-47e277c24961@huawei.com>
 <538db63a-d316-5783-f45b-b8310d19b7b9@cloud.ionos.com>
 <d3bec7ef-4e35-8a32-8b11-cda5e99b453d@cloud.ionos.com>
Message-ID: <3e6b5faf-a588-8cf0-1c49-8ffd15532a19@cloud.ionos.com>
Date:   Mon, 29 Jul 2019 12:17:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d3bec7ef-4e35-8a32-8b11-cda5e99b453d@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now actually add list to CC ..., sorry about it.

On 7/29/19 12:15 PM, Guoqing Jiang wrote:
> Forgot to cc list ...
> 
> On 7/29/19 12:03 PM, Guoqing Jiang wrote:
>>
>>
>> On 7/27/19 4:54 AM, Yufen Yu wrote:
>>>
>>>
>>> On 2019/7/26 18:21, Guoqing Jiang wrote:
>>>>
>>>>
>>>> On 7/26/19 8:00 AM, Yufen Yu wrote:
>>>>> We get a NULL pointer dereference oops when test raid1 as follow:
>>>>>
>>>>> mdadm -CR /dev/md1 -l 1 -n 2 /dev/sd[ab]
>>>>>
>>>>> mdadm /dev/md1 -f /dev/sda
>>>>> mdadm /dev/md1 -r /dev/sda
>>>>> mdadm /dev/md1 -a /dev/sda
>>>>> sleep 5
>>>>> mdadm /dev/md1 -f /dev/sdb
>>>>> mdadm /dev/md1 -r /dev/sdb
>>>>> mdadm /dev/md1 -a /dev/sdb
>>>>>
>>>>> After a disk(/dev/sda) has been removed, we add the disk to raid
>>>>> array again, which would trigger recovery action. Since the rdev
>>>>> current state is 'spare', read/write bio can be issued to the disk.
>>>>>
>>>>> Then we set the other disk (/dev/sdb) faulty. Since the raid array
>>>>> is now in degraded state and /dev/sdb is the only 'In_sync' disk,
>>>>> raid1_error() will return but without set faulty success.
>>>>
>>>> I don't think you can set sdb to faulty since it is the last working
>>>> device in raid1 per the comment, unless you did some internal change
>>>> already.
>>>>
>>>>         /*
>>>>          * If it is not operational, then we have already marked it as dead
>>>>          * else if it is the last working disks, ignore the error, let the
>>>>          * next level up know.
>>>>          * else mark the drive as failed
>>>>          */
>>>>
>>>
>>> Yes, we can not set sdb faulty *Since the raid array is now in degraded state
>>> and /dev/sdb is the only In_sync disk*. And raid1_error() will return in follow,
>>> *but without set faulty success*:
>>>
>>>      if (test_bit(In_sync, &rdev->flags)
>>>          && (conf->raid_disks - mddev->degraded) == 1) {
>>>          /*
>>>           * Don't fail the drive, act as though we were just a
>>>           * normal single drive.
>>>           * However don't try a recovery from this drive as
>>>           * it is very likely to fail.
>>>           */
>>>          conf->recovery_disabled = mddev->recovery_disabled;
>>>          spin_unlock_irqrestore(&conf->device_lock, flags);
>>>          return;
>>>      }
>>>
>>> Here, 'conf->recovery_disabled' is assigned value as 'mddev->recovery_disabled',
>>> and 'mddev' will be set 'MD_RECOVERY_INTR' flag in md_error().
>>> Then,  md_check_recovery() can go to remove_and_add_spares() and try to remove the disk.
>>>
>>> raid1_remove_disk()
>>>          if (test_bit(In_sync, &rdev->flags) ||
>>>              atomic_read(&rdev->nr_pending)) {
>>>              err = -EBUSY;
>>>              goto abort;
>>>          }
>>>          /* Only remove non-faulty devices if recovery
>>>           * is not possible.
>>>           */
>>>          if (!test_bit(Faulty, &rdev->flags) &&
>>>              mddev->recovery_disabled != conf->recovery_disabled &&
>>>              mddev->degraded < conf->raid_disks) {
>>>              err = -EBUSY;
>>>              goto abort;
>>>          }
>>>          p->rdev = NULL;
>>>
>>> The function cannot 'goto abort', and try to set 'p->rdev = NULL', which cause the race
>>> conditions in the patch as a result.
>>>
>>> BTW, we have not changed any internal implementation of raid.
>>>
>>>
>>>>>
>>>>> However, that can interrupt the recovery action and
>>>>> md_check_recovery will try to call remove_and_add_spares() to
>>>>> remove the spare disk. And the race condition between
>>>>> remove_and_add_spares() and raid1_write_request() in follow
>>>>> can cause NULL pointer dereference for conf->mirrors[i].rdev:
>>>>>
>>>>> raid1_write_request()   md_check_recovery    raid1_error()
>>>>> rcu_read_lock()
>>>>> rdev != NULL
>>>>> !test_bit(Faulty, &rdev->flags)
>>>>>
>>>>> conf->recovery_disabled=
>>>>> mddev->recovery_disabled;
>>>>>                                              return busy
>>>>>
>>>>>                          remove_and_add_spares
>>>>>                          raid1_remove_disk
>>>>
>>>> I am not quite follow here, raid1_remove_disk is called under some conditions:
>>>>
>>>>                 if ((this == NULL || rdev == this) &&
>>>>                     rdev->raid_disk >= 0 &&
>>>>                     !test_bit(Blocked, &rdev->flags) &&
>>>>                     ((test_bit(RemoveSynchronized, &rdev->flags) ||
>>>>                      (!test_bit(In_sync, &rdev->flags) &&
>>>>                       !test_bit(Journal, &rdev->flags))) &&
>>>>                     atomic_read(&rdev->nr_pending)==0))
>>>>
>>>> So rdev->raid_disk should not be negative value, and for the spare disk showed
>>>> as 'S' should meet the requirement:
>>>>
>>>>                         if (rdev->raid_disk < 0)
>>>>                                 seq_printf(seq, "(S)"); /* spare */
>>>>
>>>>
>>>
>>> Maybe I have not expressed clearly.  I observe the 'spare' state by 
>>> '/sys/block/md1/md/dev-sda/state'.
>>> state_show()
>>>      if (!test_bit(Faulty, &flags) &&
>>>          !test_bit(Journal, &flags) &&
>>>          !test_bit(In_sync, &flags))
>>>          len += sprintf(page+len, "spare%s", sep);
>>
>> Hmm, so there are two different definitions about "spare" ...
>>
>>>
>>> When /dev/sda has been added to the array again, hot_add_disk() just add it to mddev->disks list.
>>> Then, md_check_recovery() will invoke remove_and_add_spares() to add the rdev in conf->mirrors[i]
>>> array actually.
>>> After that, rdev->raid_disk is not be negative value and we can issue bio to the disk.
>>>
>>
>> Thanks a lot for the detailed explanation!
>>
>> For the issue, maybe a better way is to call "p->rdev = NULL" after synchronize_rcu().
>> Could you try the below change? Thanks.
>>
>>
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 34e26834ad28..867808bed325 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -1825,16 +1825,17 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                          err = -EBUSY;
>>                          goto abort;
>>                  }
>> -               p->rdev = NULL;
>>                  if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>                          synchronize_rcu();
>> +                       p->rdev = NULL;
>>                          if (atomic_read(&rdev->nr_pending)) {
>>                                  /* lost the race, try later */
>>                                  err = -EBUSY;
>>                                  p->rdev = rdev;
>>                                  goto abort;
>>                          }
>> -               }
>> +               } else
>> +                       p->rdev = NULL;
>>                  if (conf->mirrors[conf->raid_disks + number].rdev) {
>>                          /* We just removed a device that is being replaced.
>>                           * Move down the replacement.  We drain all IO before
>>
>>
>> And I think the change should apply to raid10 as well, but let's see the above works or not.
>>
> 
> Seems raid10_error doesn't have the code about recovery_disabled, then it is not necessary for raid10.
> 
> Thanks,
> Guoqing
