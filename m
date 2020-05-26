Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE241CDF37
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgEKPjt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 11:39:49 -0400
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90]:33098 "EHLO
        vsmx012.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730084AbgEKPjt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 11:39:49 -0400
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id F110BF3501D;
        Mon, 11 May 2020 15:39:46 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.216.232])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 9017919AEA2;
        Mon, 11 May 2020 15:39:40 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 04BFdbMU003297
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 May 2020 17:39:37 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 04BFdbIf003296;
        Mon, 11 May 2020 17:39:37 +0200
Date:   Mon, 11 May 2020 17:39:37 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
Subject: Re: raid6check extremely slow ?
Message-ID: <20200511153937.GA3225@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 11, 2020 at 10:58:07AM +0200, Guoqing Jiang wrote:
> Hi Wolfgang,
> 
> 
> On 5/11/20 8:40 AM, Wolfgang Denk wrote:
> > Dear Guoqing Jiang,
> > 
> > In message <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com> you wrote:
> > > Seems raid6check is in 'D' state, what are the output of 'cat
> > > /proc/19719/stack' and /proc/mdstat?
> > # for i in 1 2 3 4 ; do  cat /proc/19719/stack; sleep 2; echo ; done
> > [<0>] __wait_rcu_gp+0x10d/0x110
> > [<0>] synchronize_rcu+0x47/0x50
> > [<0>] mddev_suspend+0x4a/0x140
> > [<0>] suspend_lo_store+0x50/0xa0
> > [<0>] md_attr_store+0x86/0xe0
> > [<0>] kernfs_fop_write+0xce/0x1b0
> > [<0>] vfs_write+0xb6/0x1a0
> > [<0>] ksys_write+0x4f/0xc0
> > [<0>] do_syscall_64+0x5b/0xf0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > [<0>] __wait_rcu_gp+0x10d/0x110
> > [<0>] synchronize_rcu+0x47/0x50
> > [<0>] mddev_suspend+0x4a/0x140
> > [<0>] suspend_lo_store+0x50/0xa0
> > [<0>] md_attr_store+0x86/0xe0
> > [<0>] kernfs_fop_write+0xce/0x1b0
> > [<0>] vfs_write+0xb6/0x1a0
> > [<0>] ksys_write+0x4f/0xc0
> > [<0>] do_syscall_64+0x5b/0xf0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > [<0>] __wait_rcu_gp+0x10d/0x110
> > [<0>] synchronize_rcu+0x47/0x50
> > [<0>] mddev_suspend+0x4a/0x140
> > [<0>] suspend_hi_store+0x44/0x90
> > [<0>] md_attr_store+0x86/0xe0
> > [<0>] kernfs_fop_write+0xce/0x1b0
> > [<0>] vfs_write+0xb6/0x1a0
> > [<0>] ksys_write+0x4f/0xc0
> > [<0>] do_syscall_64+0x5b/0xf0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > [<0>] __wait_rcu_gp+0x10d/0x110
> > [<0>] synchronize_rcu+0x47/0x50
> > [<0>] mddev_suspend+0x4a/0x140
> > [<0>] suspend_hi_store+0x44/0x90
> > [<0>] md_attr_store+0x86/0xe0
> > [<0>] kernfs_fop_write+0xce/0x1b0
> > [<0>] vfs_write+0xb6/0x1a0
> > [<0>] ksys_write+0x4f/0xc0
> > [<0>] do_syscall_64+0x5b/0xf0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Looks raid6check keeps writing suspend_lo/hi node which causes mddev_suspend
> is called,
> means synchronize_rcu and other synchronize mechanisms are triggered in the
> path ...
> 
> > Interesting, why is it in ksys_write / vfs_write / kernfs_fop_write
> > all the time?  I thought it was _reading_ the disks only?
> 
> I didn't read raid6check before, just find check_stripes has
> 
> 
> ��� while (length > 0) {
> ��� ��� ��� lock_stripe -> write suspend_lo/hi node
> ��� ��� ��� ...
> ��� ��� ��� unlock_all_stripes -> -> write suspend_lo/hi node
> ��� }
> 
> I think it explains the stack of raid6check, and maybe it is way that
> raid6check works, lock
> stripe, check the stripe then unlock the stripe, just my guess ...

Yes, that's the way it works.
raid6check lock the stripe, check it, release it.
This is required in order to avoid race conditions
between raid6check and some write to the stripe.

The alternative is to set the array R/O and do
the check, avoiding the lock / unlock.

This could be a way to test if the problem is
really here.
That is, remove the lock / unlock (I guess
there should be only one pair, but better
check) and check with the array in R/O mode.

Hope this helps,

bye,

pg
 
> > And iostat does not report any writes either?
> 
> Because CPU is busying with mddev_suspend I think.
> 
> > # iostat /dev/sd[efhijklm] | cat
> > Linux 5.6.8-300.fc32.x86_64 (atlas.denx.de)     2020-05-11      _x86_64_        (8 CPU)
> > 
> > avg-cpu:  %user   %nice %system %iowait  %steal   %idle
> >             0.18    0.00    1.07    0.17    0.00   98.58
> > 
> > Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
> > sde              20.30       368.76         0.10         0.00  277022327      75178          0
> > sdf              20.28       368.77         0.10         0.00  277030081      75170          0
> > sdh              20.30       368.74         0.10         0.00  277007903      74854          0
> > sdi              20.30       368.79         0.10         0.00  277049113      75246          0
> > sdj              20.82       368.76         0.10         0.00  277022363      74986          0
> > sdk              20.30       368.73         0.10         0.00  277002179      76322          0
> > sdl              20.29       368.78         0.10         0.00  277039743      74982          0
> > sdm              20.29       368.75         0.10         0.00  277018163      74958          0
> > 
> > 
> > # cat /proc/mdstat
> > Personalities : [raid1] [raid10] [raid6] [raid5] [raid4]
> > md3 : active raid10 sdc1[0] sdd1[1]
> >        234878976 blocks 512K chunks 2 far-copies [2/2] [UU]
> >        bitmap: 0/2 pages [0KB], 65536KB chunk
> > 
> > md0 : active raid6 sdm[15] sdl[14] sdi[8] sde[12] sdj[9] sdk[10] sdh[13] sdf[11]
> >        11720301024 blocks super 1.2 level 6, 16k chunk, algorithm 2 [8/8] [UUUUUUUU]
> > 
> > md1 : active raid1 sdb3[0] sda3[1]
> >        484118656 blocks [2/2] [UU]
> > 
> > md2 : active raid1 sdb1[0] sda1[1]
> >        255936 blocks [2/2] [UU]
> > 
> > unused devices: <none>
> > 
> > > > 3 days later:
> > > Is raid6check still in 'D' state as before?
> > Yes, nothing changed, still running:
> > 
> > top - 08:39:30 up 8 days, 16:41,  3 users,  load average: 1.00, 1.00, 1.00
> > Tasks: 243 total,   1 running, 242 sleeping,   0 stopped,   0 zombie
> > %Cpu0  :  0.0 us,  0.3 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.3 hi,  0.0 si,  0.0 st
> > %Cpu1  :  1.0 us,  5.4 sy,  0.0 ni, 92.2 id,  0.7 wa,  0.3 hi,  0.3 si,  0.0 st
> > %Cpu2  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > %Cpu3  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > %Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > %Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > %Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > %Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > MiB Mem :  24034.6 total,  10920.6 free,   1883.0 used,  11231.1 buff/cache
> > MiB Swap:   7828.5 total,   7828.5 free,      0.0 used.  21756.5 avail Mem
> > 
> >      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> >    19719 root      20   0    2852   2820   2020 D   7.6   0.0 679:04.39 raid6check
> 
> I think the stack of raid6check is pretty much the same as before.
> 
> Since the estimated time of 12TB array is about 57 days, if the estimated
> time is linear to
> the number of stripes in the same machine, then it is how raid6check works
> as I guessed.
> 
> Thanks,
> Guoqing

-- 

piergiorgio
