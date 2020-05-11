Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76D1CD44D
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 10:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEKI6L (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 04:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgEKI6K (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 May 2020 04:58:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B45C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 01:58:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l18so9859868wrn.6
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fp81CoShm0/uEh7sTiT3MDIA4PhMOdZK2rJzONdVEj8=;
        b=fwEi32XnEHc2/AoBl25BOZFlqBeTZO3Gg2JQkgYKNCX8v3mlKLLtxSHIb1MZ9/Ki3n
         0zMF53RC+dh5PATpiaPrIxdz0qvBqEhGqf2dC9ow9sZ3/eXebBjGVdv8l1SqMC2foZmr
         rb0RVSKjPzby6dp9+lepkQ0tW+ZgE+RdkVZ5J2fLE5QRcuEoyZj5kTy1XoYv6OGXPfC2
         dc/SsiK7U4hlIQoB3CFRrqeKdpu1fRJHggeW7SSJrAPhDzs8uXyiET1T9xWUijtKpOMn
         ABhppTVKu/68rSXtyDxVIy/5IOxC74QSW0hG9ztBHLMZUOyI2SuKhWm5KwZ/rp84I9Tl
         P/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fp81CoShm0/uEh7sTiT3MDIA4PhMOdZK2rJzONdVEj8=;
        b=PY2NALNBy1Sc7EXaEuxm05hCoG0hVCTTgXGbMCURxN1CS41SRtrtE4AS4lJW67YEJq
         gNnZEn05+9sf4RIt1jCS7ENWGRr57yOsRwd/HiXNftxmkqDBwf595UDqr2XL69FGdG6s
         8ccUIVOYRLvOFbALAv3A25nSZhH0Z/nb7hfRPP7/uNpoHf1YYRqYEcfuI3pRVzedz5Xc
         CVwTnESfB9TAYKTctlFxk7gIiy23Wejt04rBY5Qc8jQrljZ7jnLYrTJizGpPTF0OrgeE
         YWRD0stNBfrPi8JRQWh9kDOajqFJHZE1R93NlXFCCqqZB+XwX2SF8GmCbhv0hyCTyPPm
         Cg2Q==
X-Gm-Message-State: AGi0PuY8XmnuH2iSZS9QWR5CkkdPXLhNjNTKr3jSKPuvNF4ryprDUhnN
        oXq3vc3Qcgje+TBU2HWUkR1/v+lobbivfA==
X-Google-Smtp-Source: APiQypJIyswgruxfMZWXayKsx+EpQYJnSY/HZTx+xeQQjNw+4egmph96NHqtwGixOwkVlGhQYy9txg==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr18148151wrj.237.1589187488722;
        Mon, 11 May 2020 01:58:08 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48ab:c500:e80e:f5df:f780:7d57? ([2001:16b8:48ab:c500:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id t4sm17444276wri.54.2020.05.11.01.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:58:08 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
To:     Wolfgang Denk <wd@denx.de>
Cc:     linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
Date:   Mon, 11 May 2020 10:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511064022.591C5240E1A@gemini.denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Wolfgang,


On 5/11/20 8:40 AM, Wolfgang Denk wrote:
> Dear Guoqing Jiang,
>
> In message <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com> you wrote:
>> Seems raid6check is in 'D' state, what are the output of 'cat
>> /proc/19719/stack' and /proc/mdstat?
> # for i in 1 2 3 4 ; do  cat /proc/19719/stack; sleep 2; echo ; done
> [<0>] __wait_rcu_gp+0x10d/0x110
> [<0>] synchronize_rcu+0x47/0x50
> [<0>] mddev_suspend+0x4a/0x140
> [<0>] suspend_lo_store+0x50/0xa0
> [<0>] md_attr_store+0x86/0xe0
> [<0>] kernfs_fop_write+0xce/0x1b0
> [<0>] vfs_write+0xb6/0x1a0
> [<0>] ksys_write+0x4f/0xc0
> [<0>] do_syscall_64+0x5b/0xf0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> [<0>] __wait_rcu_gp+0x10d/0x110
> [<0>] synchronize_rcu+0x47/0x50
> [<0>] mddev_suspend+0x4a/0x140
> [<0>] suspend_lo_store+0x50/0xa0
> [<0>] md_attr_store+0x86/0xe0
> [<0>] kernfs_fop_write+0xce/0x1b0
> [<0>] vfs_write+0xb6/0x1a0
> [<0>] ksys_write+0x4f/0xc0
> [<0>] do_syscall_64+0x5b/0xf0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> [<0>] __wait_rcu_gp+0x10d/0x110
> [<0>] synchronize_rcu+0x47/0x50
> [<0>] mddev_suspend+0x4a/0x140
> [<0>] suspend_hi_store+0x44/0x90
> [<0>] md_attr_store+0x86/0xe0
> [<0>] kernfs_fop_write+0xce/0x1b0
> [<0>] vfs_write+0xb6/0x1a0
> [<0>] ksys_write+0x4f/0xc0
> [<0>] do_syscall_64+0x5b/0xf0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> [<0>] __wait_rcu_gp+0x10d/0x110
> [<0>] synchronize_rcu+0x47/0x50
> [<0>] mddev_suspend+0x4a/0x140
> [<0>] suspend_hi_store+0x44/0x90
> [<0>] md_attr_store+0x86/0xe0
> [<0>] kernfs_fop_write+0xce/0x1b0
> [<0>] vfs_write+0xb6/0x1a0
> [<0>] ksys_write+0x4f/0xc0
> [<0>] do_syscall_64+0x5b/0xf0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Looks raid6check keeps writing suspend_lo/hi node which causes 
mddev_suspend is called,
means synchronize_rcu and other synchronize mechanisms are triggered in 
the path ...

> Interesting, why is it in ksys_write / vfs_write / kernfs_fop_write
> all the time?  I thought it was _reading_ the disks only?

I didn't read raid6check before, just find check_stripes has


     while (length > 0) {
             lock_stripe -> write suspend_lo/hi node
             ...
             unlock_all_stripes -> -> write suspend_lo/hi node
     }

I think it explains the stack of raid6check, and maybe it is way that 
raid6check works, lock
stripe, check the stripe then unlock the stripe, just my guess ...

> And iostat does not report any writes either?

Because CPU is busying with mddev_suspend I think.

> # iostat /dev/sd[efhijklm] | cat
> Linux 5.6.8-300.fc32.x86_64 (atlas.denx.de)     2020-05-11      _x86_64_        (8 CPU)
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>             0.18    0.00    1.07    0.17    0.00   98.58
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
> sde              20.30       368.76         0.10         0.00  277022327      75178          0
> sdf              20.28       368.77         0.10         0.00  277030081      75170          0
> sdh              20.30       368.74         0.10         0.00  277007903      74854          0
> sdi              20.30       368.79         0.10         0.00  277049113      75246          0
> sdj              20.82       368.76         0.10         0.00  277022363      74986          0
> sdk              20.30       368.73         0.10         0.00  277002179      76322          0
> sdl              20.29       368.78         0.10         0.00  277039743      74982          0
> sdm              20.29       368.75         0.10         0.00  277018163      74958          0
>
>
> # cat /proc/mdstat
> Personalities : [raid1] [raid10] [raid6] [raid5] [raid4]
> md3 : active raid10 sdc1[0] sdd1[1]
>        234878976 blocks 512K chunks 2 far-copies [2/2] [UU]
>        bitmap: 0/2 pages [0KB], 65536KB chunk
>
> md0 : active raid6 sdm[15] sdl[14] sdi[8] sde[12] sdj[9] sdk[10] sdh[13] sdf[11]
>        11720301024 blocks super 1.2 level 6, 16k chunk, algorithm 2 [8/8] [UUUUUUUU]
>
> md1 : active raid1 sdb3[0] sda3[1]
>        484118656 blocks [2/2] [UU]
>
> md2 : active raid1 sdb1[0] sda1[1]
>        255936 blocks [2/2] [UU]
>
> unused devices: <none>
>
>>> 3 days later:
>> Is raid6check still in 'D' state as before?
> Yes, nothing changed, still running:
>
> top - 08:39:30 up 8 days, 16:41,  3 users,  load average: 1.00, 1.00, 1.00
> Tasks: 243 total,   1 running, 242 sleeping,   0 stopped,   0 zombie
> %Cpu0  :  0.0 us,  0.3 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.3 hi,  0.0 si,  0.0 st
> %Cpu1  :  1.0 us,  5.4 sy,  0.0 ni, 92.2 id,  0.7 wa,  0.3 hi,  0.3 si,  0.0 st
> %Cpu2  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu3  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> MiB Mem :  24034.6 total,  10920.6 free,   1883.0 used,  11231.1 buff/cache
> MiB Swap:   7828.5 total,   7828.5 free,      0.0 used.  21756.5 avail Mem
>
>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    19719 root      20   0    2852   2820   2020 D   7.6   0.0 679:04.39 raid6check

I think the stack of raid6check is pretty much the same as before.

Since the estimated time of 12TB array is about 57 days, if the 
estimated time is linear to
the number of stripes in the same machine, then it is how raid6check 
works as I guessed.

Thanks,
Guoqing
