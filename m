Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2920F1ADEE7
	for <lists+linux-raid@lfdr.de>; Fri, 17 Apr 2020 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgDQN75 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Apr 2020 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730563AbgDQN74 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Apr 2020 09:59:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876ADC061A0C
        for <linux-raid@vger.kernel.org>; Fri, 17 Apr 2020 06:59:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y24so3107709wma.4
        for <linux-raid@vger.kernel.org>; Fri, 17 Apr 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=DnY7zkQKTbcK+kojxTIffVLhvzHxRs4JxP1OBhDJ9EU=;
        b=gl3VkCYO44i6egzypYunu/wSrcZNMs2EYcZzlSBw7nsUqp1VNJO5BMdAYNQ2V++siS
         rWdyWshibl9vELaw1hM1T3kUqqU0rAQm8PEr39ma7qzA4C+6GhQog+SUvjz6ADz8mpfT
         tdj8gpSwvEI2uA7tck/bUn9BnjToQQOOssSv3asNJDBsFLt0Cwo/uAuJ7JYfZ8XDyyjZ
         gTBdmboH9TTCJH8P9y3bozs0Wi34IPaqwNq/OlXmQ8EkeaD4yJOlqpBNawFcZHdddfFh
         gIM+N6QBwUryK2r3Tu4y+FWcUXrtHOGEh1Fck5dyWRFrRC3SSONnnKAoVhjr0ZkS0ixI
         WHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DnY7zkQKTbcK+kojxTIffVLhvzHxRs4JxP1OBhDJ9EU=;
        b=O2fNM9oS3rBVTAjrkDu2tzFR+ATc1wSapWZasP+DqtoB1eGs29n70ftXBf7h7GpuKo
         7tgvHl3DHqS23sN96nJG8zSKc2cfWDoJkQQ5GXkCwzoxT+/tyvj0rtFxaGTgvvfRrtDT
         OVWGuc74gU1/1tSkDpJmsa+hhAYvYwSCfexCZxTzJV9YcdnN0p3g2R2epQv87MvyJtXc
         dapDm38TNfiHewYpeCTT/0jgJbhXSHwQ0jcziSiXC9iQjA96IiW3vYQABJ0x9ZNGZXc/
         TpLJgnN+44UMcPQL1BYFwDJNKPMfMZdJWwNWUCPTAYEt5y3JTob2XnsOpje5zaajK53N
         dohQ==
X-Gm-Message-State: AGi0Pub9IEfzoaxtlTWNgn5pIlP0dL/3YwYVSwBlGkg4m9E/RQiFY8QC
        /98DfkZ8DULE6zrlpAq6aT+NdpVeF9M=
X-Google-Smtp-Source: APiQypIvBH1vtbA291bfhMjkF17Pnl5uag1FUD0pF7ykBsDJkTS+qvGBpO/PcmZXYnHkiGhSyZoHhA==
X-Received: by 2002:a1c:6545:: with SMTP id z66mr3416714wmb.81.1587131994994;
        Fri, 17 Apr 2020 06:59:54 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48af:7200:34d4:fc5b:d862:dbd2? ([2001:16b8:48af:7200:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id b4sm27099313wrv.42.2020.04.17.06.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 06:59:54 -0700 (PDT)
Subject: Re: Unable to fail/remove journal device
To:     Andre Tomt <andre@tomt.net>,
        linux-raid <linux-raid@vger.kernel.org>
References: <59985bfe-2786-b4a9-64a4-283f5de98f82@tomt.net>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <3a352fcd-095e-5cab-ffbd-5394544fbcb8@cloud.ionos.com>
Date:   Fri, 17 Apr 2020 15:59:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <59985bfe-2786-b4a9-64a4-283f5de98f82@tomt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30.03.20 01:35, Andre Tomt wrote:
> I'm having a issue here where I am unable to get a journal device 
> removed from a raid6 array. From what I could gather from mailing list 
> posts and documentation, one should set the journal mode to 
> write-through, fail the journal and remove it, then restart the array 
> (perhaps with force).
>
> But this isnt working. The journal just gets re-added on array 
> startup. I've done this successfully before, in the same way, I think.
>
> I also tried a bigger hammer, wipefs the journal device too, to "make 
> sure", the array will come up but refuse any writes.
>
> For now, the journal device has been restored and the array is back to 
> read-write, but I really need to get it removed at some point 
> (preferably without re-building metadata with --assume-clean)
>
> Any ideas? Is this way just out of date?
>
> mdadm: 4.1-5ubuntu1
> kernel: 5.5.13
>
> # cat /proc/mdstat
> md2 : active (auto-read-only) raid6 sdm1[0] sde1[11] sdk1[10] sdt1[9] 
> sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] sdd1[1] 
> nvme0n1p1[12](J)
>
>       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
> [12/12] [UUUUUUUUUUUU]
>
>
> # echo write-through > /sys/block/md2/md/journal_mode
> # mdadm --fail /dev/md2 /dev/nvme0n1p1
> mdadm: set /dev/nvme0n1p1 faulty in /dev/md2
>
> # mdadm --remove /dev/md2 /dev/nvme0n1p1
>
> mdadm: hot removed /dev/nvme0n1p1 from /dev/md2
>
> # cat /proc/mdstat
> md2 : active (auto-read-only) raid6 sdm1[0] sde1[11] sdk1[10] sdt1[9] 
> sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] sdd1[1]
>
>       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
> [12/12] [UUUUUUUUUUUU]
>
>

Not know journal well, but I guess it is better to change the 
consistency_policy before stop array
by "echo resync > /sys/block/md2/md/consistency_policy" since journal 
device is not available.

Thanks,
Guoqing

> # mdadm --stop /dev/md2
>
> mdadm: stopped /dev/md2
>
>
> # mdadm --assemble /dev/md2 --force
>
> mdadm: /dev/md2 has been started with 12 drives and 1 journal.
>  <-- !?
> # cat /proc/mdstat
> md2 : active (auto-read-only) raid6 sdm1[0] nvme0n1p1[12](J) sde1[11] 
> sdk1[10] sdt1[9] sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] 
> sdr1[2] sdd1[1]
>
>                                             ^^^
>       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
> [12/12] [UUUUUUUUUUUU]
>
>
> Okay then. Hammer time. Do all that again, wipefs the journal device, 
> force start the array:
>
> # mdadm --assemble /dev/md2 --force
>
> mdadm: Journal is missing or stale, starting array read only.
>
> mdadm: /dev/md2 has been started with 12 drives.
>
> # cat /proc/mdstat
> md2 : active (read-only) raid6 sdm1[0] sde1[11] sdk1[10] sdt1[9] 
> sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] sdd1[1]
>
>       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
> [12/12] [UUUUUUUUUUUU]
>
>
> Then it is just stuck in read-only.

