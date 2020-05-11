Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B731CE717
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgEKVHf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729120AbgEKVHe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 17:07:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7132EC061A0C
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 14:07:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so12732020wrp.12
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/dJCOv26qUUNde9KruAcXbeXDvP8ECpH4yilowsoDvY=;
        b=TDXoVkfMRpwCxFAwJHSW9wEX7yNtU9R9zwXXlaaqs4Gwiyak75huU4w4pNykv+pEkB
         7waZWv+TlRTOci8A1c7fEXBgfJV1kUXrxKqskX3gWwXHgDFy0N9VRvLyyrKhzvCgMjHv
         Q2ZoT+57L/RjfSVINgsYryjLqlVxzAcalStdzn++Zf1aGFlX+Na1N4ijEoA3caEjHDIF
         ijn8oAfXsBnOnCpaDvad4RC0iRvTbaUJ23DkEolVNLxZ/SE5saw4RhXXf/paoXVb76ze
         YT4JtrG0adwdLPF0d5Ws/m2IfIjppSzr3Nrsi1RJECQxmBR2VEU7bGreS/R9AiGPU8e9
         bVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/dJCOv26qUUNde9KruAcXbeXDvP8ECpH4yilowsoDvY=;
        b=Sbc6kTW6N9PbVSdVd1zpeHKQmHSKUQJ//gCT50IC44pL2eG4FuWWPr5iEGxQBMvRGe
         qlwN+dbf8tvLO7b1/S4vnXLxoF/fXJ4piNbsgfNmSeknGTZI4xHgrc4GWvQPz8dBuN3/
         hcooSCSbigcjw4sHCaTbRJA0/FqeLRDO7N/yj9ny0qPk8bmBC262/xQpHE3ziGOAb1py
         S2FpNXYrxK/mPPzofG9AQ53DJV4ymqa0hWw++wAzTl167dTzGWPPhaw7hx3poLKhL9XX
         UiadmnlEPnk5LXaO7yrA1adSEoZz6yxicP6ZVNtwF74rQ/lIZ2Ur57aJn2yiFXHPbQ02
         xslA==
X-Gm-Message-State: AGi0PuY0piUhcYNZECwJt79dNHPLUP8/0WlRsJgjBwQU1NmoXPhghfuy
        IYGioizlSNsef0Cuku+X+2//tbxj5J+vyw==
X-Google-Smtp-Source: APiQypIecpoHJz/Mlors0evEn+JjGXv9+Y6RFjwjV7Pw/4AhIPxw1FUz5jiJQ+WM2AZkSV7aB9bnUQ==
X-Received: by 2002:adf:c38c:: with SMTP id p12mr22361675wrf.357.1589231252841;
        Mon, 11 May 2020 14:07:32 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48ab:c500:e80e:f5df:f780:7d57? ([2001:16b8:48ab:c500:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id g184sm13908253wmg.1.2020.05.11.14.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 14:07:32 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com>
Date:   Mon, 11 May 2020 23:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511161415.GA8049@lazy.lzy>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/11/20 6:14 PM, Piergiorgio Sartor wrote:
> On Mon, May 11, 2020 at 10:58:07AM +0200, Guoqing Jiang wrote:
>> Hi Wolfgang,
>>
>>
>> On 5/11/20 8:40 AM, Wolfgang Denk wrote:
>>> Dear Guoqing Jiang,
>>>
>>> In message<2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>  you wrote:
>>>> Seems raid6check is in 'D' state, what are the output of 'cat
>>>> /proc/19719/stack' and /proc/mdstat?
>>> # for i in 1 2 3 4 ; do  cat /proc/19719/stack; sleep 2; echo ; done
>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>> [<0>] synchronize_rcu+0x47/0x50
>>> [<0>] mddev_suspend+0x4a/0x140
>>> [<0>] suspend_lo_store+0x50/0xa0
>>> [<0>] md_attr_store+0x86/0xe0
>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>> [<0>] vfs_write+0xb6/0x1a0
>>> [<0>] ksys_write+0x4f/0xc0
>>> [<0>] do_syscall_64+0x5b/0xf0
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>> [<0>] synchronize_rcu+0x47/0x50
>>> [<0>] mddev_suspend+0x4a/0x140
>>> [<0>] suspend_lo_store+0x50/0xa0
>>> [<0>] md_attr_store+0x86/0xe0
>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>> [<0>] vfs_write+0xb6/0x1a0
>>> [<0>] ksys_write+0x4f/0xc0
>>> [<0>] do_syscall_64+0x5b/0xf0
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>> [<0>] synchronize_rcu+0x47/0x50
>>> [<0>] mddev_suspend+0x4a/0x140
>>> [<0>] suspend_hi_store+0x44/0x90
>>> [<0>] md_attr_store+0x86/0xe0
>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>> [<0>] vfs_write+0xb6/0x1a0
>>> [<0>] ksys_write+0x4f/0xc0
>>> [<0>] do_syscall_64+0x5b/0xf0
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>> [<0>] synchronize_rcu+0x47/0x50
>>> [<0>] mddev_suspend+0x4a/0x140
>>> [<0>] suspend_hi_store+0x44/0x90
>>> [<0>] md_attr_store+0x86/0xe0
>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>> [<0>] vfs_write+0xb6/0x1a0
>>> [<0>] ksys_write+0x4f/0xc0
>>> [<0>] do_syscall_64+0x5b/0xf0
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> Looks raid6check keeps writing suspend_lo/hi node which causes mddev_suspend
>> is called,
>> means synchronize_rcu and other synchronize mechanisms are triggered in the
>> path ...
>>
>>> Interesting, why is it in ksys_write / vfs_write / kernfs_fop_write
>>> all the time?  I thought it was_reading_  the disks only?
>> I didn't read raid6check before, just find check_stripes has
>>
>>
>>      while (length > 0) {
>>              lock_stripe -> write suspend_lo/hi node
>>              ...
>>              unlock_all_stripes -> -> write suspend_lo/hi node
>>      }
>>
>> I think it explains the stack of raid6check, and maybe it is way that
>> raid6check works, lock
>> stripe, check the stripe then unlock the stripe, just my guess ...
> Hi again!
>
> I made a quick test.
> I disabled the lock / unlock in raid6check.
>
> With lock / unlock, I get around 1.2MB/sec
> per device component, with ~13% CPU load.
> Wihtout lock / unlock, I get around 15.5MB/sec
> per device component, with ~30% CPU load.
>
> So, it seems the lock / unlock mechanism is
> quite expensive.

Yes, since mddev_suspend/resume are triggered by the lock/unlock stripe.

> I'm not sure what's the best solution, since
> we still need to avoid race conditions.

I guess there are two possible ways:

1. Per your previous reply, only call raid6check when array is RO, then
we don't need the lock.

2. Investigate if it is possible that acquire stripe_lock in 
suspend_lo/hi_store
to avoid the race between raid6check and write to the same stripe. IOW,
try fine grained protection instead of call the expensive suspend/resume
in suspend_lo/hi_store. But I am not sure it is doable or not right now.


BTW, seems there are build problems for raid6check ...

mdadm$ make raid6check
gcc -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parameter 
-Wimplicit-fallthrough=0 -O2 -DSendmail=\""/usr/sbin/sendmail -t"\" 
-DCONFFILE=\"/etc/mdadm.conf\" -DCONFFILE2=\"/etc/mdadm/mdadm.conf\" 
-DMAP_DIR=\"/run/mdadm\" -DMAP_FILE=\"map\" -DMDMON_DIR=\"/run/mdadm\" 
-DFAILED_SLOTS_DIR=\"/run/mdadm/failed-slots\" -DNO_COROSYNC -DNO_DLM 
-DVERSION=\"4.1-74-g5cfb79d\" -DVERS_DATE="\"2020-04-27\"" 
-DUSE_PTHREADS -DBINDIR=\"/sbin\"  -o sysfs.o -c sysfs.c
gcc -O2  -o raid6check raid6check.o restripe.o sysfs.o maps.o lib.o 
xmalloc.o dlink.o
sysfs.o: In function `sysfsline':
sysfs.c:(.text+0x2adb): undefined reference to `parse_uuid'
sysfs.c:(.text+0x2aee): undefined reference to `uuid_zero'
sysfs.c:(.text+0x2af5): undefined reference to `uuid_zero'
collect2: error: ld returned 1 exit status
Makefile:220: recipe for target 'raid6check' failed
make: *** [raid6check] Error 1


Thanks,
Guoqing
