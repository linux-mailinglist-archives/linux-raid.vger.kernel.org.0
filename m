Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC320196A45
	for <lists+linux-raid@lfdr.de>; Sun, 29 Mar 2020 01:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgC2Aab (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 28 Mar 2020 20:30:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37119 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgC2Aab (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 28 Mar 2020 20:30:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so16630490wrm.4
        for <linux-raid@vger.kernel.org>; Sat, 28 Mar 2020 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rJhF8kMFCsYs9dH0P0kYciceJM+nYm12eSkr2DUaG/4=;
        b=Oc4zLShqneajDTdd3AfX8FA+Oe4sO/0ErhRUs57iqrCwggw1DNIqT9MhwVC6CTA0Hf
         nxTJ9bWlQLpWaSY4qLqDCk+mOs2Z+DQUKiZcmgdVnAd7UEylCZxAaviSW8C2j+kP1zfx
         vYn4BluKuKf8O0he6+O2ogc5Py7UvYVKbsAG5sI2Zwh98QGa3pz0yILt3lK61vEVnCzy
         yYOcPHIbbL6LDsvp7PWHpiy+W4MKhjQ4HxhztyxTmYmcRwR+hoerrMBRLliTG0AEB7mC
         //GTFqWyLjYl2CTp1GCT1JThJ/Eg/Hj0oukFQgzAcSqEanPUCfepJ5ItYfikeKzK7gha
         6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJhF8kMFCsYs9dH0P0kYciceJM+nYm12eSkr2DUaG/4=;
        b=Pd8lK3Ns4H4BHeSp4KmYHKPlb6/Bsl4u8PZsYRH12WiULN0+LFnFX3YftCpEudm9XC
         U0ANI3sx4iPyaGvnUUU904pXwUmplByEIhRI6OEo6sWh5bJ9qNxYbj6FKspce+YIevcI
         tEE+VRqTnk40++Kb/YlJg4K/Jz5jj0LLRT3gYFPk97UI2daNICqwf0Lx0jck8mt4BMM/
         Ozo/aKjww64ZcX+6D72YRBnZ3F4a3e6sB3rSTbydL9WBIfB3rqtYLKdE3YfAAnQuwHvz
         PtxlrDR6IOIPHDX77Av5UfSS9dnkTLuI0j6CNX6ObPUphLBcPLevMiBbHPaSJzKd1aXy
         mYPQ==
X-Gm-Message-State: ANhLgQ1wcN94LiS7TpqzSSs45nrw+Aaip7KbKqH1rwwMtY4JAYA5TfOm
        Tp0jMG5Nr1VzWz1sUoK8+4TEcZZ6SE0=
X-Google-Smtp-Source: ADFU+vuK0+A6VIrrWB7OgKDoKcO3KbloblZFKMHdanqMm9bwdYTviDG4nQDvI0QEazFvD2ip1NP0nA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr6816478wrw.235.1585441828246;
        Sat, 28 Mar 2020 17:30:28 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4809:f600:1d90:b47c:300d:f695? ([2001:16b8:4809:f600:1d90:b47c:300d:f695])
        by smtp.gmail.com with ESMTPSA id y4sm3766253wrl.40.2020.03.28.17.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 17:30:27 -0700 (PDT)
Subject: Re: [BUG REPORT] suspicious deadlock when stopping md raid5 on
 5.6-rc7 kernel
To:     Coly Li <colyli@suse.de>, linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <4a0ac66e-3deb-313a-60bb-ae1a2d45b751@suse.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <84c00170-d564-8e1e-3bbc-6eebf27cfe31@cloud.ionos.com>
Date:   Sun, 29 Mar 2020 01:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4a0ac66e-3deb-313a-60bb-ae1a2d45b751@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 3/26/20 3:26 AM, Coly Li wrote:
> Hi Song and Guoqing,
> 
> Here is the step how I encounter the lockdep warning (yes lockdep engine
> enabled),
> 
> export IMSM_NO_PLATFORM=1
> mdadm -CR imsm0 -e imsm -n 4 /dev/nvme{0,1,2,3}n1
> mdadm -CR vol5 -l 5 -n 3 /dev/nvme{0,1,2}n1 --assume-clean
> mdadm --manage --stop /dev/md126
> (The warning message shows up when I run the above line to stop md126)
> mdadm --manage --stop /dev/md127
> 
> The kernel is just upstream Linux kernel with 5.6-rc7 tag. I use 4 NVMe
> SSD to reproduce another issue, and encounter the following warning by
> the above steps,
> 
> [ 1604.255664] ======================================================
> [ 1604.329616] WARNING: possible circular locking dependency detected
> [ 1604.403579] 5.6.0-rc7-default #5 Tainted: G            E
> [ 1604.471295] ------------------------------------------------------
> [ 1604.545253] kworker/5:0/843 is trying to acquire lock:
> [ 1604.606731] ffff8889ff2d11e8 (kn->count#256){++++}, at:
> kernfs_remove+0x1f/0x30
> [ 1604.694230]
> [ 1604.694230] but task is already holding lock:
> [ 1604.764026] ffff888a1d3b7e10
> ((work_completion)(&rdev->del_work)){+.+.}, at: process_one_work+0x42b/0xb30
> [ 1604.878564]
> [ 1604.878564] which lock already depends on the new lock.
> [ 1604.878564]
> [ 1604.976436]
> [ 1604.976436] the existing dependency chain (in reverse order) is:
> [ 1605.065993]
> [ 1605.065993] -> #4 ((work_completion)(&rdev->del_work)){+.+.}:
> [ 1605.152443]        process_one_work+0x4b5/0xb30
> [ 1605.206643]        worker_thread+0x65/0x5a0
> [ 1605.256688]        kthread+0x1d9/0x200
> [ 1605.301535]        ret_from_fork+0x3a/0x50
> [ 1605.350527]
> [ 1605.350527] -> #3 ((wq_completion)md_misc){+.+.}:
> [ 1605.424495]        flush_workqueue+0xfb/0x990
> [ 1605.476653]        __md_stop_writes+0x34/0x1f0 [md_mod]
> [ 1605.539206]        do_md_stop+0x2b8/0xb40 [md_mod]
> [ 1605.596561]        array_state_store+0x297/0x450 [md_mod]
> [ 1605.661196]        md_attr_store+0xb3/0x100 [md_mod]
> [ 1605.720598]        kernfs_fop_write+0x1a0/0x240
> [ 1605.774799]        vfs_write+0xff/0x280
> [ 1605.820679]        ksys_write+0x120/0x170
> [ 1605.868646]        do_syscall_64+0x78/0x330
> [ 1605.918686]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1605.985361]
> [ 1605.985361] -> #2 (&mddev->open_mutex){+.+.}:
> [ 1606.055161]        __mutex_lock+0x12f/0xd20
> [ 1606.105233]        do_md_stop+0x1ee/0xb40 [md_mod]
> [ 1606.162587]        array_state_store+0x297/0x450 [md_mod]
> [ 1606.227219]        md_attr_store+0xb3/0x100 [md_mod]
> [ 1606.286618]        kernfs_fop_write+0x1a0/0x240
> [ 1606.340822]        vfs_write+0xff/0x280
> [ 1606.386703]        ksys_write+0x120/0x170
> [ 1606.434660]        do_syscall_64+0x78/0x330
> [ 1606.484704]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1606.551380]
> [ 1606.551380] -> #1 (&mddev->reconfig_mutex){+.+.}:
> [ 1606.625341]        __mutex_lock+0x12f/0xd20
> [ 1606.675412]        rdev_attr_store+0x6f/0xf0 [md_mod]
> [ 1606.735853]        kernfs_fop_write+0x1a0/0x240
> [ 1606.790050]        vfs_write+0xff/0x280
> [ 1606.835931]        ksys_write+0x120/0x170
> [ 1606.883888]        do_syscall_64+0x78/0x330
> [ 1606.933927]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1607.000604]
> [ 1607.000604] -> #0 (kn->count#256){++++}:
> [ 1607.065213]        __lock_acquire+0x1ba8/0x1f50
> [ 1607.119413]        lock_acquire+0xf3/0x240
> [ 1607.168408]        __kernfs_remove+0x45b/0x4f0
> [ 1607.221563]        kernfs_remove+0x1f/0x30
> [ 1607.270564]        kobject_del+0x50/0xa0
> [ 1607.317515]        md_delayed_delete+0x15/0x20 [md_mod]
> [ 1607.380035]        process_one_work+0x50c/0xb30
> [ 1607.434238]        worker_thread+0x65/0x5a0
> [ 1607.484279]        kthread+0x1d9/0x200
> [ 1607.529116]        ret_from_fork+0x3a/0x50
> [ 1607.578110]
> [ 1607.578110] other info that might help us debug this:
> [ 1607.578110]
> [ 1607.673903] Chain exists of:
> [ 1607.673903]   kn->count#256 --> (wq_completion)md_misc -->
> (work_completion)(&rdev->del_work)
> [ 1607.673903]
> [ 1607.827946]  Possible unsafe locking scenario:
> [ 1607.827946]
> [ 1607.898780]        CPU0                    CPU1
> [ 1607.952980]        ----                    ----
> [ 1608.007173]   lock((work_completion)(&rdev->del_work));
> [ 1608.069690]                                lock((wq_completion)md_misc);
> [ 1608.149887]
> lock((work_completion)(&rdev->del_work));
> [ 1608.242563]   lock(kn->count#256);
> [ 1608.283238]
> [ 1608.283238]  *** DEADLOCK ***

Seems lots of works are attached to md_misc_wq, I think the deadlock is caused by competing the same 
work queue, need to investigate more. And I vaguely recall there was report about md check hang, 
which I guess could be related to flush_workqueue as well.


> [ 1608.283238]
> [ 1608.354078] 2 locks held by kworker/5:0/843:
> [ 1608.405152]  #0: ffff8889eecc9948 ((wq_completion)md_misc){+.+.}, at:
> process_one_work+0x42b/0xb30
> [ 1608.512399]  #1: ffff888a1d3b7e10
> ((work_completion)(&rdev->del_work)){+.+.}, at: process_one_work+0x42b/0xb30
> [ 1608.632130]
> [ 1608.632130] stack backtrace:
> [ 1608.684254] CPU: 5 PID: 843 Comm: kworker/5:0 Tainted: G            E
>      5.6.0-rc7-default #5
> [ 1608.787332] Hardware name: Lenovo ThinkSystem SR650
> -[7X05CTO1WW]-/-[7X05CTO1WW]-, BIOS -[IVE148M-2.41]- 10/31/2019
> [ 1608.912287] Workqueue: md_misc md_delayed_delete [md_mod]
> [ 1608.976886] Call Trace:
> [ 1609.006132]  dump_stack+0xb7/0x10b
> [ 1609.046814]  check_noncircular+0x2c4/0x320
> [ 1609.095818]  ? print_circular_bug.isra.36+0x240/0x240
> [ 1609.156279]  ? __lockdep_free_key_range+0xb0/0xb0
> [ 1609.212564]  ? __lock_acquire+0x1ba8/0x1f50
> [ 1609.262606]  __lock_acquire+0x1ba8/0x1f50
> [ 1609.310574]  ? register_lock_class+0x8c0/0x8c0
> [ 1609.363741]  lock_acquire+0xf3/0x240
> [ 1609.406501]  ? kernfs_remove+0x1f/0x30
> [ 1609.451349]  __kernfs_remove+0x45b/0x4f0
> [ 1609.498267]  ? kernfs_remove+0x1f/0x30
> [ 1609.543106]  ? kernfs_fop_readdir+0x3b0/0x3b0
> [ 1609.595240]  kernfs_remove+0x1f/0x30
> [ 1609.638003]  kobject_del+0x50/0xa0
> [ 1609.678721]  md_delayed_delete+0x15/0x20 [md_mod]
> [ 1609.735005]  process_one_work+0x50c/0xb30
> [ 1609.782974]  ? pwq_dec_nr_in_flight+0x120/0x120
> [ 1609.837188]  worker_thread+0x65/0x5a0
> [ 1609.880997]  ? process_one_work+0xb30/0xb30
> [ 1609.931037]  kthread+0x1d9/0x200
> [ 1609.969638]  ? kthread_create_worker_on_cpu+0xc0/0xc0
> [ 1610.030080]  ret_from_fork+0x3a/0x50
> [ 1809.448921] md: md127 stopped.
> 

Thanks,
Guoqing
