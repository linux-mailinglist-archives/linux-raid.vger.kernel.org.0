Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB61E7C45
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE2Ltb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 07:49:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgE2Lta (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 07:49:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AB74A06007ED9282E40;
        Fri, 29 May 2020 19:49:28 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 19:49:19 +0800
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>, <colyli@suse.de>,
        <xni@redhat.com>, <houtao1@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com>
Date:   Fri, 29 May 2020 19:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/29 6:07, Guoqing Jiang wrote:
> On 5/27/20 3:19 PM, Yufen Yu wrote:
>> Hi, all
>>
>>   For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5 will
>>   issus echo bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64. However,
>>   filesystem usually issue bio in the unit of 4KB. Then, RAID5 will waste resource
>>   of disk bandwidth.
> 
> Could you explain a little bit about "waste resource"? Does it mean the chance for
> full stripe write is limited because of  the incompatible between fs (4KB bio) and
> raid5 (64KB stripe unit)?

Applications may request 4KB data, but RAID5 will issue 64KB size bio to disk, which
will waste disk bandwidth and more cpu time to compute xor. Detail performance data
can see in previous email:
https://www.spinics.net/lists/raid/msg64261.html

> 
>>   To solve the problem, this patchset provide a new config CONFIG_MD_RAID456_STRIPE_SHIFT
>>   to let user config STRIPE_SIZE. The default value is 1, means 4096(1<<9).
>>
>>   Normally, using default STRIPE_SIZE can get better performance. And NeilBrown have
>>   suggested just to fix the STRIPE_SIZE as 4096.But, out test result show that
>>   big value of STRIPE_SIZE may have better performance when size of issued IOs are
>>   mostly bigger than 4096. Thus, in this patchset, we still want to set STRIPE_SIZE
>>   as a configureable value.
> 
> I think it is better to define stripe size as 4K if it fits to generally scenario, and also
> aligns with fs.
> 
>>   In current implementation, grow_buffers() uses alloc_page() to allocate the buffers
>>   for each stripe_head. With the change, it means we allocate 64K buffers but just
>>   use 4K of them. To save memory, we try to 'compress' multiple buffers of stripe_head
>>   to only one real page. Detail shows in patch #2.
>>
>>   To evaluate the new feature, we create raid5 device '/dev/md5' with 4 SSD disk
>>   and test it on arm64 machine with 64KB PAGE_SIZE.
>>   1) We format /dev/md5 with mkfs.ext4 and mount ext4 with default configure on
>>      /mnt directory. Then, trying to test it by dbench with command:
>>      dbench -D /mnt -t 1000 10. Result show as:
>>      'STRIPE_SHIFT = 64KB'
>>        Operation      Count    AvgLat    MaxLat
>>        ----------------------------------------
>>        NTCreateX    9805011     0.021    64.728
>>        Close        7202525     0.001     0.120
>>        Rename        415213     0.051    44.681
>>        Unlink       1980066     0.079    93.147
>>        Deltree          240     1.793     6.516
>>        Mkdir            120     0.004     0.007
>>        Qpathinfo    8887512     0.007    37.114
>>        Qfileinfo    1557262     0.001     0.030
>>        Qfsinfo      1629582     0.012     0.152
>>        Sfileinfo     798756     0.040    57.641
>>        Find         3436004     0.019    57.782
>>        WriteX       4887239     0.021    57.638
>>        ReadX        15370483     0.005    37.818
>>        LockX          31934     0.003     0.022
>>        UnlockX        31933     0.001     0.021
>>        Flush         687205    13.302   530.088
>>       Throughput 307.799 MB/sec  10 clients  10 procs  max_latency=530.091 ms
>>       -------------------------------------------------------
>>      'STRIPE_SIZE = 4KB'
>>        Operation      Count    AvgLat    MaxLat
>>        ----------------------------------------
>>        NTCreateX    11999166     0.021    36.380
>>        Close        8814128     0.001     0.122
>>        Rename        508113     0.051    29.169
>>        Unlink       2423242     0.070    38.141
>>        Deltree          300     1.885     7.155
>>        Mkdir            150     0.004     0.006
>>        Qpathinfo    10875921     0.007    35.485
>>        Qfileinfo    1905837     0.001     0.032
>>        Qfsinfo      1994304     0.012     0.125
>>        Sfileinfo     977450     0.029    26.489
>>        Find         4204952     0.019     9.361
>>        WriteX       5981890     0.019    27.804
>>        ReadX        18809742     0.004    33.491
>>        LockX          39074     0.003     0.025
>>        UnlockX        39074     0.001     0.014
>>        Flush         841022    10.712   458.848
>>       Throughput 376.777 MB/sec  10 clients  10 procs  max_latency=458.852 ms
>>       -------------------------------------------------------
> 
> What is the default io unit size of dbench?

Since dbench runs on ext4 filesystem, so I think most io size is about 4KB.

> 
>>    2) We try to evaluate IO throughput for /dev/md5 by fio with config:
>>       [4KB randwrite]
>>       direct=1
>>       numjob=2
>>       iodepth=64
>>       ioengine=libaio
>>       filename=/dev/md5
>>       bs=4KB
>>       rw=randwrite
>>       [64KB write]
>>       direct=1
>>       numjob=2
>>       iodepth=64
>>       ioengine=libaio
>>       filename=/dev/md5
>>       bs=1MB
>>       rw=write
>>      The fio test result as follow:
>>                     +                   +
>>                     | STRIPE_SIZE(64KB) | STRIPE_SIZE(4KB)
>>       +----------------------------------------------------+
>>       4KB randwrite |     15MB/s        |      100MB/s
>>       +----------------------------------------------------+
>>       1MB write     |   1000MB/s        |      700MB/s
>>      The result show that when size of io is bigger than 4KB (64KB),
>>      64KB STRIPE_SIZE has much higher IOPS. But for 4KB randwrite, that
>>      means, size of io issued to device are smaller, 4KB STRIPE_SIZE
>>      have better performance.
> 
> The 4k rand write performance drops from 100MB/S to 15MB/S?! How about other
> io sizes? Say 16k, 64K and 256K etc, it would be more convincing if 64KB stripe
> has better performance than 4KB stripe overall.
> 

Maybe I have not explain clearly. Here, the fio test result shows that 4KB
STRIPE_SIZE is not always have better performance. If applications request
IO size mostly are bigger than 4KB, likely 1MB in test, set STRIPE_SIZE with
a bigger value can get better performance.

So, we try to provide a configurable STRIPE_SIZE, rather than fix STRIPE_SIZE as 4096.

Thanks,
Yufen
