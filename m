Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91501CFCF3
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgELSQc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELSQb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 May 2020 14:16:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E38C061A0C
        for <linux-raid@vger.kernel.org>; Tue, 12 May 2020 11:16:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so24699031wmh.3
        for <linux-raid@vger.kernel.org>; Tue, 12 May 2020 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ICsBJ0dpAB5GkBsp5AdOVFVqAZ9YfAHGwWgqW+rFSx0=;
        b=NIxX8Y4UmU8eOsn/Y6gH/UwQ69LbfsM9hLbTogRZJOeplqULOgSQgwaMVs7xJFtxVk
         +/Ofk1QNYZ6xgXfopxJW/njmg4f+3710rii039VrqMPGbiPK73K/UwxiiFzHPglWcOP6
         UkdGq+dfvcYJWTRhR2HTs31/S0WLFnzpoTZ46wnltoihISnPjGPuS5lh7+rNnkERf6Wc
         WF7vC4IXOHBlY7Q5Y2BzqUik4a7A9TsXcieW71suVNVjHOSd1l0XYbGMLFZ/xiCUv2e5
         2o+yA6NUVf0jBrvI0jxlaZf/1gG1TWVA+GsK0SIIsRt+akNXrPqR9trhvjjahnDXFsDQ
         nEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ICsBJ0dpAB5GkBsp5AdOVFVqAZ9YfAHGwWgqW+rFSx0=;
        b=aM3tPEwk+J1xq+1YBzQcXASLcN5lnsw/4ukilOd7HH8SjXrvpaqtwPWm8n8heBK3Be
         wfSBDYBgViWO/c66gZ1LT0xVYl6gADP9UgqYC9Rt7UM04rxQTjfHhohjaCHqjDRKsmVi
         fManFVferpmy/HeSKudkR5xiOBA6lueaXoCUGiBJtHXmx+5VALcKyEydmRaE/f7txpE3
         wZDGqV4DHqDh52Pb+YhlMJTVMiHUUROLeMagZOm5KTM14GQYbdzl7b4Oxd+7XkfXABU/
         Pvs7EesRvaKt6OTgaUtaHchoBzgVqctKm7HRZRySbdbwTsnu5W+fFIvHxe2k1mgmQJds
         UiWA==
X-Gm-Message-State: AGi0PubgVEDHIW6QkVxqD/6rSQs+7/K2u02qsGsBM5B0ovh2Tht0sr7Z
        cZ8XidqYicKZLF9K28JQ6Yym5f2Erxx7fQ==
X-Google-Smtp-Source: APiQypIz/9yUkT3I0B3c1U4bAC3/7mfbYCO3q6t1LLOsn1YnGgEW0rF4Tm1Wq/ISkpT3oxVhmVdejQ==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr39272333wmb.116.1589307389422;
        Tue, 12 May 2020 11:16:29 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48c0:3a00:e80e:f5df:f780:7d57? ([2001:16b8:48c0:3a00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id u10sm9864577wmc.31.2020.05.12.11.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 11:16:28 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com>
 <20200512160712.GB7261@lazy.lzy>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e24b0703-a599-45ef-f6b6-0a713cfa414c@cloud.ionos.com>
Date:   Tue, 12 May 2020 20:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512160712.GB7261@lazy.lzy>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/12/20 6:07 PM, Piergiorgio Sartor wrote:
> On Mon, May 11, 2020 at 11:07:31PM +0200, Guoqing Jiang wrote:
>> On 5/11/20 6:14 PM, Piergiorgio Sartor wrote:
>>> On Mon, May 11, 2020 at 10:58:07AM +0200, Guoqing Jiang wrote:
>>>> Hi Wolfgang,
>>>>
>>>>
>>>> On 5/11/20 8:40 AM, Wolfgang Denk wrote:
>>>>> Dear Guoqing Jiang,
>>>>>
>>>>> In message<2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>  you wrote:
>>>>>> Seems raid6check is in 'D' state, what are the output of 'cat
>>>>>> /proc/19719/stack' and /proc/mdstat?
>>>>> # for i in 1 2 3 4 ; do  cat /proc/19719/stack; sleep 2; echo ; done
>>>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>>>> [<0>] synchronize_rcu+0x47/0x50
>>>>> [<0>] mddev_suspend+0x4a/0x140
>>>>> [<0>] suspend_lo_store+0x50/0xa0
>>>>> [<0>] md_attr_store+0x86/0xe0
>>>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>>>> [<0>] vfs_write+0xb6/0x1a0
>>>>> [<0>] ksys_write+0x4f/0xc0
>>>>> [<0>] do_syscall_64+0x5b/0xf0
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>
>>>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>>>> [<0>] synchronize_rcu+0x47/0x50
>>>>> [<0>] mddev_suspend+0x4a/0x140
>>>>> [<0>] suspend_lo_store+0x50/0xa0
>>>>> [<0>] md_attr_store+0x86/0xe0
>>>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>>>> [<0>] vfs_write+0xb6/0x1a0
>>>>> [<0>] ksys_write+0x4f/0xc0
>>>>> [<0>] do_syscall_64+0x5b/0xf0
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>
>>>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>>>> [<0>] synchronize_rcu+0x47/0x50
>>>>> [<0>] mddev_suspend+0x4a/0x140
>>>>> [<0>] suspend_hi_store+0x44/0x90
>>>>> [<0>] md_attr_store+0x86/0xe0
>>>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>>>> [<0>] vfs_write+0xb6/0x1a0
>>>>> [<0>] ksys_write+0x4f/0xc0
>>>>> [<0>] do_syscall_64+0x5b/0xf0
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>
>>>>> [<0>] __wait_rcu_gp+0x10d/0x110
>>>>> [<0>] synchronize_rcu+0x47/0x50
>>>>> [<0>] mddev_suspend+0x4a/0x140
>>>>> [<0>] suspend_hi_store+0x44/0x90
>>>>> [<0>] md_attr_store+0x86/0xe0
>>>>> [<0>] kernfs_fop_write+0xce/0x1b0
>>>>> [<0>] vfs_write+0xb6/0x1a0
>>>>> [<0>] ksys_write+0x4f/0xc0
>>>>> [<0>] do_syscall_64+0x5b/0xf0
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>> Looks raid6check keeps writing suspend_lo/hi node which causes mddev_suspend
>>>> is called,
>>>> means synchronize_rcu and other synchronize mechanisms are triggered in the
>>>> path ...
>>>>
>>>>> Interesting, why is it in ksys_write / vfs_write / kernfs_fop_write
>>>>> all the time?  I thought it was_reading_  the disks only?
>>>> I didn't read raid6check before, just find check_stripes has
>>>>
>>>>
>>>>       while (length > 0) {
>>>>               lock_stripe -> write suspend_lo/hi node
>>>>               ...
>>>>               unlock_all_stripes -> -> write suspend_lo/hi node
>>>>       }
>>>>
>>>> I think it explains the stack of raid6check, and maybe it is way that
>>>> raid6check works, lock
>>>> stripe, check the stripe then unlock the stripe, just my guess ...
>>> Hi again!
>>>
>>> I made a quick test.
>>> I disabled the lock / unlock in raid6check.
>>>
>>> With lock / unlock, I get around 1.2MB/sec
>>> per device component, with ~13% CPU load.
>>> Wihtout lock / unlock, I get around 15.5MB/sec
>>> per device component, with ~30% CPU load.
>>>
>>> So, it seems the lock / unlock mechanism is
>>> quite expensive.
>> Yes, since mddev_suspend/resume are triggered by the lock/unlock stripe.
>>
>>> I'm not sure what's the best solution, since
>>> we still need to avoid race conditions.
>> I guess there are two possible ways:
>>
>> 1. Per your previous reply, only call raid6check when array is RO, then
>> we don't need the lock.
>>
>> 2. Investigate if it is possible that acquire stripe_lock in
>> suspend_lo/hi_store
>> to avoid the race between raid6check and write to the same stripe. IOW,
>> try fine grained protection instead of call the expensive suspend/resume
>> in suspend_lo/hi_store. But I am not sure it is doable or not right now.
> Could you please elaborate on the
> "fine grained protection" thing?

Even raid6check checks stripe and locks stripe one by one, but the thing
is different in kernel space, locking of one stripe triggers mddev_suspend
and mddev_resume which affect all stripes ...

If kernel can expose interface to actually locking one stripe, then 
raid6check
could use it to actually lock only one stripe (this is what I call fine 
grained)
instead of trigger suspend/resume which are time consuming.

>   
>> BTW, seems there are build problems for raid6check ...
>>
>> mdadm$ make raid6check
>> gcc -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parameter
>> -Wimplicit-fallthrough=0 -O2 -DSendmail=\""/usr/sbin/sendmail -t"\"
>> -DCONFFILE=\"/etc/mdadm.conf\" -DCONFFILE2=\"/etc/mdadm/mdadm.conf\"
>> -DMAP_DIR=\"/run/mdadm\" -DMAP_FILE=\"map\" -DMDMON_DIR=\"/run/mdadm\"
>> -DFAILED_SLOTS_DIR=\"/run/mdadm/failed-slots\" -DNO_COROSYNC -DNO_DLM
>> -DVERSION=\"4.1-74-g5cfb79d\" -DVERS_DATE="\"2020-04-27\"" -DUSE_PTHREADS
>> -DBINDIR=\"/sbin\"  -o sysfs.o -c sysfs.c
>> gcc -O2  -o raid6check raid6check.o restripe.o sysfs.o maps.o lib.o
>> xmalloc.o dlink.o
>> sysfs.o: In function `sysfsline':
>> sysfs.c:(.text+0x2adb): undefined reference to `parse_uuid'
>> sysfs.c:(.text+0x2aee): undefined reference to `uuid_zero'
>> sysfs.c:(.text+0x2af5): undefined reference to `uuid_zero'
>> collect2: error: ld returned 1 exit status
>> Makefile:220: recipe for target 'raid6check' failed
>> make: *** [raid6check] Error 1
> I cannot see this problem.
> I could compile without issue.
> Maybe some library is missing somewhere,
> but I'm not sure where.

Do you try with the fastest mdadm tree? But could be environment issue ...

Thanks,
Guoqing
