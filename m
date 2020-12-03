Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9C2CD4CF
	for <lists+linux-raid@lfdr.de>; Thu,  3 Dec 2020 12:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgLCLnR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Dec 2020 06:43:17 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39761 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbgLCLnR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 3 Dec 2020 06:43:17 -0500
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6636120647D81;
        Thu,  3 Dec 2020 12:42:32 +0100 (CET)
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
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <37c158cb-f527-34f5-2482-cae138bc8b07@molgen.mpg.de>
Date:   Thu, 3 Dec 2020 12:42:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b289ae15-ff82-b36e-4be4-a1c8bbdbacd7@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Guoqing,

On 12/3/20 2:55 AM, Guoqing Jiang wrote:
> Hi Donald,
> 
> On 12/2/20 18:28, Donald Buczek wrote:
>> Dear Guoqing,
>>
>> unfortunately the patch didn't fix the problem (unless I messed it up with my logging). This is what I used:
>>
>>      --- a/drivers/md/md.c
>>      +++ b/drivers/md/md.c
>>      @@ -9305,6 +9305,14 @@ void md_check_recovery(struct mddev *mddev)
>>                              clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>>                              goto unlock;
>>                      }
> 
> I think you can add the check of RECOVERY_CHECK in above part instead of add a new part.

I understand that. I did it this way to get a log only when the changed expression makes a difference (original block not triggering and using goto and and modified block triggering) and even if both of us make some stupid error with boolean expressions.

> 
>>      +               if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
>>      +                   (!test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
>>      +                    test_bit(MD_RECOVERY_CHECK, &mddev->recovery))) {
>>      +                       /* resync/recovery still happening */
>>      +                       pr_info("md: XXX BUGFIX applied\n");
>>      +                       clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>>      +                       goto unlock;
>>      +               }
>>                      if (mddev->sync_thread) {
>>                              md_reap_sync_thread(mddev);
>>                              goto unlock;
> 
> 
>>
>> With pausing and continuing the check four times an hour, I could trigger the problem after about 48 hours. This time, the other device (md0) has locked up on `echo idle > /sys/devices/virtual/block/md0/md/sync_action` , while the check of md1 is still ongoing:
> 
> Without the patch, md0 was good while md1 was locked. So the patch switches the status of the two arrays, a little weird ...

I think its just random. There is a slight chance for a deadlock depending on I/O to the device or other system load when stopping the resync. In the last experiment, both md0 and md1 where changed from "check" to "idle" for about 400 times before one of it blocked.

OTOH - and I don't understand this at all - it looks like md0 hung again after reboot to a 5.4 kernel at the very first "check" to "idle" transition which seems to contradict the "slight" chance and "once after 400 attempts".

> What is the stack of the process? I guess it is same as the stack of 23333 in your previous mail, but just to confirm.

Of md0_raid6 thread ?  Sorry, didn't take the data before reboot this time, and concentrated on the non-terminating md0_resync thread.

>>      Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
>>      md1 : active raid6 sdk[0] sdj[15] sdi[14] sdh[13] sdg[12] sdf[11] sde[10] sdd[9] sdc[8] sdr[7] sdq[6] sdp[5] sdo[4] sdn[3] sdm[2] sdl[1]
>>            109394518016 blocks super 1.2 level 6, 512k chunk, algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
>>            [=>...................]  check =  8.5% (666852112/7813894144) finish=1271.2min speed=93701K/sec
>>            bitmap: 0/59 pages [0KB], 65536KB chunk
>>      md0 : active raid6 sds[0] sdah[15] sdag[16] sdaf[13] sdae[12] sdad[11] sdac[10] sdab[9] sdaa[8] sdz[7] sdy[6] sdx[17] sdw[4] sdv[3] sdu[2] sdt[1]
>>            109394518016 blocks super 1.2 level 6, 512k chunk, algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
>>            [>....................]  check =  0.2% (19510348/7813894144) finish=253779.6min speed=511K/sec
>>            bitmap: 0/59 pages [0KB], 65536KB chunk
>>
>> after 1 minute:
>>
>>      Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
>>      md1 : active raid6 sdk[0] sdj[15] sdi[14] sdh[13] sdg[12] sdf[11] sde[10] sdd[9] sdc[8] sdr[7] sdq[6] sdp[5] sdo[4] sdn[3] sdm[2] sdl[1]
>>            109394518016 blocks super 1.2 level 6, 512k chunk, algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
>>            [=>...................]  check =  8.6% (674914560/7813894144) finish=941.1min speed=126418K/sec
>>            bitmap: 0/59 pages [0KB], 65536KB chunk
>>      md0 : active raid6 sds[0] sdah[15] sdag[16] sdaf[13] sdae[12] sdad[11] sdac[10] sdab[9] sdaa[8] sdz[7] sdy[6] sdx[17] sdw[4] sdv[3] sdu[2] sdt[1]
>>            109394518016 blocks super 1.2 level 6, 512k chunk, algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
>>            [>....................]  check =  0.2% (19510348/7813894144) finish=256805.0min speed=505K/sec
>>            bitmap: 0/59 pages [0KB], 65536KB chunk
>>
>> A data point, I didn't mention in my previous mail, is that the mdX_resync thread is not gone when the problem occurs:
>>
>>      buczek@done:/scratch/local/linux (v5.10-rc6-mpi)$ ps -Af|fgrep [md
>>      root       134     2  0 Nov30 ?        00:00:00 [md]
>>      root      1321     2 27 Nov30 ?        12:57:14 [md0_raid6]
>>      root      1454     2 26 Nov30 ?        12:37:23 [md1_raid6]
>>      root      5845     2  0 16:20 ?        00:00:30 [md0_resync]
>>      root      5855     2 13 16:20 ?        00:14:11 [md1_resync]
>>      buczek    9880  9072  0 18:05 pts/0    00:00:00 grep -F [md
>>      buczek@done:/scratch/local/linux (v5.10-rc6-mpi)$ sudo cat /proc/5845/stack
>>      [<0>] md_bitmap_cond_end_sync+0x12d/0x170
>>      [<0>] raid5_sync_request+0x24b/0x390
>>      [<0>] md_do_sync+0xb41/0x1030
>>      [<0>] md_thread+0x122/0x160
>>      [<0>] kthread+0x118/0x130
>>      [<0>] ret_from_fork+0x1f/0x30
>>
>> I guess, md_bitmap_cond_end_sync+0x12d is the `wait_event(bitmap->mddev->recovery_wait,atomic_read(&bitmap->mddev->recovery_active) == 0);` in md-bitmap.c.
>>
> 
> Could be, if so, then I think md_done_sync was not triggered by the path md0_raid6 -> ... -> handle_stripe.

Ok. Maybe I find a way to add some logging there.

> I'd suggest to compare the stacks between md0 and md1 to find the difference.

Compare stack of md0_raid6 and md1_raid6?

Okay, but when one md is deadlocked, the other is operating just normally. I/O can be done and you can even start and stop a resync on it. So I'd expect the stack of the operating raid to be varying.

Thanks.

   Donald

> 
> Thanks,
> Guoqing


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
