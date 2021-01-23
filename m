Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601ED30154F
	for <lists+linux-raid@lfdr.de>; Sat, 23 Jan 2021 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbhAWNFA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 23 Jan 2021 08:05:00 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40891 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbhAWNE4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 23 Jan 2021 08:04:56 -0500
Received: from [192.168.0.5] (ip5f5aed2c.dynamic.kabel-deutschland.de [95.90.237.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 13E3E20645D5A;
        Sat, 23 Jan 2021 14:04:11 +0100 (CET)
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
 <95fbd558-5e46-7a6a-43ac-bcc5ae8581db@cloud.ionos.com>
 <77244d60-1c2d-330e-71e6-4907d4dd65fc@molgen.mpg.de>
 <7c5438c7-2324-cc50-db4d-512587cb0ec9@molgen.mpg.de>
 <b289ae15-ff82-b36e-4be4-a1c8bbdbacd7@cloud.ionos.com>
 <37c158cb-f527-34f5-2482-cae138bc8b07@molgen.mpg.de>
 <efb8d47b-ab9b-bdb9-ee2f-fb1be66343b1@molgen.mpg.de>
 <55e30408-ac63-965f-769f-18be5fd5885c@molgen.mpg.de>
 <d95aa962-9750-c27c-639a-2362bdb32f41@cloud.ionos.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <30576384-682c-c021-ff16-bebed8251365@molgen.mpg.de>
Date:   Sat, 23 Jan 2021 14:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d95aa962-9750-c27c-639a-2362bdb32f41@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Guoqing,

On 20.01.21 17:33, Guoqing Jiang wrote:
> Hi Donald,
> 
> On 1/19/21 12:30, Donald Buczek wrote:
>> Dear md-raid people,
>>
>> I've reported a problem in this thread in December:
>>
>> "We are using raid6 on several servers. Occasionally we had failures, where a mdX_raid6 process seems to go into a busy loop and all I/O to the md device blocks. We've seen this on various kernel versions." It was clear, that this is related to "mdcheck" running, because we found, that the command, which should stop the scrubbing in the morning (`echo idle > /sys/devices/virtual/block/md1/md/sync_action`) is also blocked.
>>
>> On 12/21/20, I've reported, that the problem might be caused by a failure of the underlying block device driver, because I've found "inflight" counters of the block devices not being zero. However, this is not the case. We were able to run into the mdX_raid6 looping condition a few times again, but the non-zero inflight counters have not been observed again.
>>
>> I was able to collect a lot of additional information from a blocked system.
>>
>> - The `cat idle > /sys/devices/virtual/block/md1/md/sync_action` command is waiting at kthread_stop to stop the sync thread. [ https://elixir.bootlin.com/linux/latest/source/drivers/md/md.c#L7989 ]
>>
>> - The sync thread ("md1_resync") does not finish, because its blocked at
>>
>> [<0>] raid5_get_active_stripe+0x4c4/0x660     # [1]
>> [<0>] raid5_sync_request+0x364/0x390
>> [<0>] md_do_sync+0xb41/0x1030
>> [<0>] md_thread+0x122/0x160
>> [<0>] kthread+0x118/0x130
>> [<0>] ret_from_fork+0x22/0x30
>>
>> [1] https://elixir.bootlin.com/linux/latest/source/drivers/md/raid5.c#L735
>>
>> - yes, gdb confirms that `conf->cache_state` is 0x03 ( R5_INACTIVE_BLOCKED + R5_ALLOC_MORE )
> 
> The resync thread is blocked since it can't get sh from inactive list, so R5_ALLOC_MORE and R5_INACTIVE_BLOCKED are set, that is why `echo idle > /sys/devices/virtual/block/md1/md/sync_action` can't stop sync thread.
> 
>>
>> - We have lots of active stripes:
>>
>> root@deadbird:~/linux_problems/mdX_raid6_looping# cat /sys/block/md1/md/stripe_cache_active
>> 27534
> 
> There are too many active stripes, so this is false:
> 
> atomic_read(&conf->active_stripes) < (conf->max_nr_stripes * 3 / 4)
> 
> so raid5_get_active_stripe has to wait till it becomes true, either increase max_nr_stripes or decrease active_stripes.
> 
> 1. Increase max_nr_stripes
> since "mdX_raid6 process seems to go into a busy loop" and R5_ALLOC_MORE is set, if there is enough memory, I suppose mdX_raid6 (raid5d) could alloc new stripe in grow_one_stripe and increase max_nr_stripes. So please check the memory usage of your system.
> 
> Another thing is you can try to increase the number of sh manually by write new number to stripe_cache_size if there is enough memory.
> 
> 2. Or decrease active_stripes
> This is suppose to be done by do_release_stripe, but STRIPE_HANDLE is set
> 
>> - handle_stripe() doesn't make progress:
>>
>> echo "func handle_stripe =pflt" > /sys/kernel/debug/dynamic_debug/control
>>
>> In dmesg, we see the debug output from https://elixir.bootlin.com/linux/latest/source/drivers/md/raid5.c#L4925 but never from https://elixir.bootlin.com/linux/latest/source/drivers/md/raid5.c#L4958:
>>
>> [171908.896651] [1388] handle_stripe:4929: handling stripe 4947089856, state=0x2029 cnt=1, pd_idx=9, qd_idx=10
>>                  , check:4, reconstruct:0
>> [171908.896657] [1388] handle_stripe:4929: handling stripe 4947089872, state=0x2029 cnt=1, pd_idx=9, qd_idx=10
>>                  , check:4, reconstruct:0
>> [171908.896669] [1388] handle_stripe:4929: handling stripe 4947089912, state=0x2029 cnt=1, pd_idx=9, qd_idx=10
>>                  , check:4, reconstruct:0
>>
>> The sector numbers repeat after some time. We have only the following variants of stripe state and "check":
>>
>> state=0x2031 cnt=1, check:0 # ACTIVE        +INSYNC+REPLACED+IO_STARTED, check_state_idle
>> state=0x2029 cnt=1, check:4 # ACTIVE+SYNCING       +REPLACED+IO_STARTED, check_state_check_result
>> state=0x2009 cnt=1, check:0 # ACTIVE+SYNCING                +IO_STARTED, check_state_idle
>>
>> - We have MD_SB_CHANGE_PENDING set:
> 
> because MD_SB_CHANGE_PENDING flag. So do_release_stripe can't call atomic_dec(&conf->active_stripes).
> 
> Normally, SB_CHANGE_PENDING is cleared from md_update_sb which could be called by md_reap_sync_thread. But md_reap_sync_thread stuck with unregister sync_thread (it was blocked in raid5_get_active_stripe).
> 
> 
> Still I don't understand well why mdX_raid6 in a busy loop, maybe raid5d can't break from the while(1) loop because "if (!batch_size && !released)" is false. I would assume released is '0' since
>  >      released_stripes = {
>  >          first = 0x0
>  >      }
> And __get_priority_stripe fetches sh from conf->handle_list and delete
> it from handle_list, handle_stripe marks the state of the sh with STRIPE_HANDLE, then do_release_stripe put the sh back to handle_list.
> So batch_size can't be '0', and handle_active_stripes in the loop
> repeats the process in the busy loop. This is my best guess to explain the busy loop situation.
> 
>>
>> root@deadbird:~/linux_problems/mdX_raid6_looping# cat /sys/block/md1/md/array_state
>> write-pending
>>
>> gdb confirms that sb_flags = 6 (MD_SB_CHANGE_CLEAN + MD_SB_CHANGE_PENDING)
> 
> since rdev_set_badblocks could set them, could you check if there is badblock of underlying device (sd*)?

The problem is, we are still not able to run a system into the deadlocked state by a repeatable procedure. So I was not yet able to explicitly check for badblocks.

However, on the production systems, which locked up, and on the test systems, which we managed to lock up, there always was some file system activity to the affected devices aside from mdcheck itself. This alone would explain any clean->write-pending transitions and might be a required condition for the problem to happen. I'm currently trying to explicitly exercise this path (by write/fsync()/sleep), with no result yet.

Btw: When you monitor md/stripe_cache_active during a ongoing "check" on an otherwise idle system, you see a variety of values up to a certain maximum value, which is visible most of the time. But this maximum value seems to continuously increase. Also, when you start the check at higher blocks (via md/sync_min) right away, the maximum value seems to be higher. Can this be explained? Bigger seek gap between superblocks and active data area? But should this increase the number of active stripes?

Best
   Donald

>> So it can be assumed that handle_stripe breaks out at https://elixir.bootlin.com/linux/latest/source/drivers/md/raid5.c#L4939
>>
>> - The system can manually be freed from the deadlock:
>>
>> When `echo active > /sys/block/md1/md/array_state` is used, the scrubbing and other I/O continue. Probably because of https://elixir.bootlin.com/linux/latest/source/drivers/md/md.c#L4520
> 
> Hmm, seems clear SB_CHANGE_PENDING made the trick, so the blocked process can make progress.
> 
>>
>> I, of coruse, don't fully understand it yet. Any ideas?
>>
>> I append some data from a hanging raid... (mddev, r5conf and a sample stripe_head from handle_list with it first disks)
> 
> These data did help for investigation!
> 
> Thanks,
> Guoqing
