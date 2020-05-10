Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC071CCE81
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 00:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgEJWQQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 10 May 2020 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgEJWQQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 10 May 2020 18:16:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D57C061A0C
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 15:16:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e16so8591433wra.7
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=L4n/rLV5koyc6S17WmG4mEJK74dB0i2zYdZOMPaiqFY=;
        b=DZU3cl6JWa13GApkFXr+lq5wGW47UrgOcdaR43UY8RTi16dSkAOD78XxZpBBcu+JBJ
         sy+ZdnB/9XBzdeK1INW/W90r6g5yxwSISp40Mbs/zhfJV/+lEBSD2MGxQ3in65jad5Wy
         xkvBx4tO48MZ1US+anG5PMchPFa1Or3/CDNg5cJRc2OWxAr7orxWTVP9K/bUv4/MbNW6
         Fi9bKQVg126MevMw2JSboZQkUbbaKrVpNjQPAWhfxC3f00a5ngunaMeLG8tMtyfv75LP
         A1nDhJC16aaVyK5cLW0hWsOj6GuA4jc2/MzgLiu+yBbf6+mXdq7mR2oi99hR6E1dO4f3
         ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L4n/rLV5koyc6S17WmG4mEJK74dB0i2zYdZOMPaiqFY=;
        b=jddQumgM3wcBXTrKoJ0vXeWFNn2jUdJS8nQ57SJbMEOkKVwUc67Ai0XovZNmqqd6pO
         /IC3HcNg7fLGk8hZZmfZYC/sSSylMCX76BgyAAGsCwCiiFYYrWNL+6QmJ1nv/lLxmq5O
         VynljL0B66vaSJQsylBalfxg3J9j7yrzriCiCIHdUFigetLH44Bftzc3e4p3Y7fXmkv1
         bceL7cN5RjmRuHnpkZm6jc0Ry9NbwW6Z0AVfKFIsolAp0tCvq4T42/ysrYSTax5E2kJV
         iQUukw8FV1iwb5ihqEtQV8uUqBnRIfC0WcB3De2ryMpWftPEZzVlIvBz/wfFNhWpQpMt
         /qhA==
X-Gm-Message-State: AGi0PublsCoh74btuphSQX7YoTRWTe8ZVKwjWMlA5CTwkYtwaqqvnKye
        tHfaiDKOGJYT8w4R5FgWPfTtzyx2GmFXEA==
X-Google-Smtp-Source: APiQypLjuWsWgTVQCblUlVJg7tTW/8n2Z+zyvI2nFFwV21+yD62yZFlHOGrvortsPnM+2MQKkjRFmw==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr14570619wrs.279.1589148973076;
        Sun, 10 May 2020 15:16:13 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4897:7400:e80e:f5df:f780:7d57? ([2001:16b8:4897:7400:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id c16sm14120731wrv.62.2020.05.10.15.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 15:16:12 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
To:     Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
Date:   Mon, 11 May 2020 00:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510120725.20947240E1A@gemini.denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/10/20 2:07 PM, Wolfgang Denk wrote:
> Hi,
>
> I'm running raid6check on a 12 TB (8 x 2 TB harddisks)
> RAID6 array and wonder why it is so extremely slow...
> It seems to be reading the disks only a about 400 kB/s,
> which results in an estimated time of some 57 days!!!
> to complete checking the array.  The system is basically idle, there
> is neither any significant CPU load nor any other I/o (no to the
> tested array, nor to any other storage on this system).
>
> Am I doing something wrong?
>
>
> The command I'm running is simply:
>
> # raid6check /dev/md0 0 0
>
> This is with mdadm-4.1 on a Fedora 32 system (mdadm-4.1-4.fc32.x86_64).
>
> The array data:
>
> # mdadm --detail /dev/md0
> /dev/md0:
>             Version : 1.2
>       Creation Time : Thu Nov  7 19:30:03 2013
>          Raid Level : raid6
>          Array Size : 11720301024 (11177.35 GiB 12001.59 GB)
>       Used Dev Size : 1953383504 (1862.89 GiB 2000.26 GB)
>        Raid Devices : 8
>       Total Devices : 8
>         Persistence : Superblock is persistent
>
>         Update Time : Mon May  4 22:12:02 2020
>               State : active
>      Active Devices : 8
>     Working Devices : 8
>      Failed Devices : 0
>       Spare Devices : 0
>
>              Layout : left-symmetric
>          Chunk Size : 16K
>
> Consistency Policy : resync
>
>                Name : atlas.denx.de:0  (local to host atlas.denx.de)
>                UUID : 4df90724:87913791:1700bb31:773735d0
>              Events : 181544
>
>      Number   Major   Minor   RaidDevice State
>        12       8       64        0      active sync   /dev/sde
>        11       8       80        1      active sync   /dev/sdf
>        13       8      112        2      active sync   /dev/sdh
>         8       8      128        3      active sync   /dev/sdi
>         9       8      144        4      active sync   /dev/sdj
>        10       8      160        5      active sync   /dev/sdk
>        14       8      176        6      active sync   /dev/sdl
>        15       8      192        7      active sync   /dev/sdm
>
> # iostat /dev/sd[efhijklm]
> Linux 5.6.8-300.fc32.x86_64 (atlas.denx.de)     2020-05-07      _x86_64_        (8 CPU)
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>             0.18    0.01    1.11    0.21    0.00   98.49
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
> sde              19.23       388.93         0.09         0.00  158440224      35218          0
> sdf              19.20       388.94         0.09         0.00  158447574      34894          0
> sdh              19.23       388.89         0.08         0.00  158425596      34178          0
> sdi              19.23       388.99         0.09         0.00  158466326      34690          0
> sdj              20.18       388.93         0.09         0.00  158439780      34766          0
> sdk              19.23       388.88         0.09         0.00  158419988      35366          0
> sdl              19.20       388.97         0.08         0.00  158457352      34426          0
> sdm              19.21       388.92         0.08         0.00  158435748      34566          0
>
>
> top - 09:08:19 up 4 days, 17:10,  3 users,  load average: 1.00, 1.00, 1.00
> Tasks: 243 total,   1 running, 242 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  0.2 us,  0.5 sy,  0.0 ni, 98.5 id,  0.1 wa,  0.6 hi,  0.1 si,  0.0 st
> MiB Mem :  24034.6 total,  11198.4 free,   1871.8 used,  10964.3 buff/cache
> MiB Swap:   7828.5 total,   7828.5 free,      0.0 used.  21767.6 avail Mem
>
>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    19719 root      20   0    2852   2820   2020 D   5.1   0.0 285:40.07 raid6check

Seems raid6check is in 'D' state, what are the output of 'cat 
/proc/19719/stack' and /proc/mdstat?

>     1123 root      20   0       0      0      0 S   0.3   0.0  25:47.54 md0_raid6
>    37816 root      20   0       0      0      0 I   0.3   0.0   0:00.08 kworker/3:1-events
>    37903 root      20   0  219680   4540   3716 R   0.3   0.0   0:00.02 top
> ...
>
>
> HDD in use:
>
> /dev/sde : ST2000NM0033-9ZM175
> /dev/sdf : ST2000NM0033-9ZM175
> /dev/sdh : ST2000NM0033-9ZM175
> /dev/sdi : ST2000NM0033-9ZM175
> /dev/sdj : ST2000NM0033-9ZM175
> /dev/sdk : ST2000NM0033-9ZM175
> /dev/sdl : ST2000NM0033-9ZM175
> /dev/sdm : ST2000NM0008-2F3100
>
>
> 3 days later:

Is raid6check still in 'D' state as before?

Thanks,
Guoqing
