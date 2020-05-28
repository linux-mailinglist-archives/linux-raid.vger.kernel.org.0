Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3C1E578C
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 08:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgE1G3b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 02:29:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgE1G3b (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 02:29:31 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD17CF990CA0622473A8;
        Thu, 28 May 2020 14:29:28 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 14:29:23 +0800
Subject: Re: [PATCH v3 01/11] md/raid5: add CONFIG_MD_RAID456_STRIPE_SHIFT to
 set STRIPE_SIZE
To:     Xiao Ni <xni@redhat.com>, <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <colyli@suse.de>,
        <houtao1@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <20200527131933.34400-2-yuyufen@huawei.com>
 <71d6df77-6abf-dec5-46b7-ebc7cd6f6b54@redhat.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <c5c78a7b-e24f-31aa-f783-920452ec59c9@huawei.com>
Date:   Thu, 28 May 2020 14:29:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <71d6df77-6abf-dec5-46b7-ebc7cd6f6b54@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/27 23:16, Xiao Ni wrote:
> 
> 
> On 05/27/2020 09:19 PM, Yufen Yu wrote:
>> In RAID5, if issued bio size is bigger than STRIPE_SIZE, it will be split
>> in the unit of STRIPE_SIZE and process them one by one. Even for size
>> less then STRIPE_SIZE, RAID5 also request data from disk at least of
>> STRIPE_SIZE.
>>
>> Nowdays, STRIPE_SIZE is equal to the value of PAGE_SIZE. Since filesystem
>> usually issue bio in the unit of 4KB, there is no problem for PAGE_SIZE as
>> 4KB. But, for 64KB PAGE_SIZE, bio from filesystem requests 4KB data while
>> RAID5 issue IO at least STRIPE_SIZE (64KB) each time. That will waste
>> resource of disk bandwidth and compute xor.
>>
>> To avoding the waste, we want to add a new CONFIG option to adjust
>> STREIPE_SIZE. Default value is 4096. User can also set the value bigger
>> than 4KB for some special requirements, such as we know the issued io
>> size is more than 4KB.
>>
>> To evaluate the new feature, we create raid5 device '/dev/md5' with
>> 4 SSD disk and test it on arm64 machine with 64KB PAGE_SIZE.
>>
>> 1) We format /dev/md5 with mkfs.ext4 and mount ext4 with default
>>   configure on /mnt directory. Then, trying to test it by dbench with
>>   command: dbench -D /mnt -t 1000 10. Result show as:
>>
>>   'STRIPE_SIZE = 64KB'
>>
>>    Operation      Count    AvgLat    MaxLat
>>    ----------------------------------------
>>    NTCreateX    9805011     0.021    64.728
>>    Close        7202525     0.001     0.120
>>    Rename        415213     0.051    44.681
>>    Unlink       1980066     0.079    93.147
>>    Deltree          240     1.793     6.516
>>    Mkdir            120     0.004     0.007
>>    Qpathinfo    8887512     0.007    37.114
>>    Qfileinfo    1557262     0.001     0.030
>>    Qfsinfo      1629582     0.012     0.152
>>    Sfileinfo     798756     0.040    57.641
>>    Find         3436004     0.019    57.782
>>    WriteX       4887239     0.021    57.638
>>    ReadX        15370483     0.005    37.818
>>    LockX          31934     0.003     0.022
>>    UnlockX        31933     0.001     0.021
>>    Flush         687205    13.302   530.088
>>
>>   Throughput 307.799 MB/sec  10 clients  10 procs  max_latency=530.091 ms
>>   -------------------------------------------------------
>>
>>   'STRIPE_SIZE = 4KB'
>>
>>    Operation      Count    AvgLat    MaxLat
>>    ----------------------------------------
>>    NTCreateX    11999166     0.021    36.380
>>    Close        8814128     0.001     0.122
>>    Rename        508113     0.051    29.169
>>    Unlink       2423242     0.070    38.141
>>    Deltree          300     1.885     7.155
>>    Mkdir            150     0.004     0.006
>>    Qpathinfo    10875921     0.007    35.485
>>    Qfileinfo    1905837     0.001     0.032
>>    Qfsinfo      1994304     0.012     0.125
>>    Sfileinfo     977450     0.029    26.489
>>    Find         4204952     0.019     9.361
>>    WriteX       5981890     0.019    27.804
>>    ReadX        18809742     0.004    33.491
>>    LockX          39074     0.003     0.025
>>    UnlockX        39074     0.001     0.014
>>    Flush         841022    10.712   458.848
>>
>>   Throughput 376.777 MB/sec  10 clients  10 procs  max_latency=458.852 ms
>>   -------------------------------------------------------
>>
>>   It show that setting STREIP_SIZE as 4KB has higher thoughput, i.e.
>>   (376.777 vs 307.799) and has smaller latency (530.091 vs 458.852)
>>   than that setting as 64KB.
>>
>>   2) We try to evaluate IO throughput for /dev/md5 by fio with config:
>>
>>   [4KB randwrite]
>>   direct=1
>>   numjob=2
>>   iodepth=64
>>   ioengine=libaio
>>   filename=/dev/md5
>>   bs=4KB
>>   rw=randwrite
>>
>>   [64KB write]
>>   direct=1
>>   numjob=2
>>   iodepth=64
>>   ioengine=libaio
>>   filename=/dev/md5
>>   bs=1MB
>>   rw=write
>>
>>   The result as follow:
>>
>>                 +                   +
>>                 | STRIPE_SIZE(64KB) | STRIPE_SIZE(4KB)
>>   +----------------------------------------------------+
>>   4KB randwrite |     15MB/s        |      100MB/s
>>   +----------------------------------------------------+
>>   1MB write     |   1000MB/s        |      700MB/s
>>
>>   The result show that when size of io is bigger than 4KB (64KB),
>>   64KB STRIPE_SIZE has much higher IOPS. But for 4KB randwrite, that
>>   means, size of io issued to device are smaller, 4KB STRIPE_SIZE
>>   have better performance.
>>
>> Thus, we provide a configure to set STRIPE_SIZE when PAGE_SIZE is bigger
>> than 4096. Normally, default value (4096) can get relatively good
>> performance. But if each issued io is bigger than 4096, setting value more
>> than 4096 may get better performance.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/md/Kconfig | 21 +++++++++++++++++++++
>>   drivers/md/raid5.h |  4 +++-
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index d6d5ab23c088..629324f92c42 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -157,6 +157,27 @@ config MD_RAID456
>>         If unsure, say Y.
>> +config MD_RAID456_STRIPE_SHIFT
>> +    int "RAID4/RAID5/RAID6 stripe size shift"
>> +    default "1"
>> +    depends on MD_RAID456
>> +    help
>> +      When set the value as 'N', stripe size will be set as 'N << 9',
>> +      which is a multiple of 4KB.
>> +
>> +      The default value is 1, that means the default stripe size is
>> +      4096(1 << 9). Just setting as a bigger value when PAGE_SIZE is
>> +      bigger than 4096. In that case, you can set it as 2(8KB),
>> +      4(16K), 16(64K).
>> +
>> +      When you try to set a big value, likely 16 on arm64 with 64KB
>> +      PAGE_SIZE, that means, you know size of each io that issued to
>> +      raid device is more than 4096. Otherwise just use default value.
>> +
>> +      Normally, using default value can get better performance.
>> +      Only change this value if you know what you are doing.
>> +
>> +
>>   config MD_MULTIPATH
>>       tristate "Multipath I/O support"
>>       depends on BLK_DEV_MD
>> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
>> index f90e0704bed9..b25f107dafc7 100644
>> --- a/drivers/md/raid5.h
>> +++ b/drivers/md/raid5.h
>> @@ -472,7 +472,9 @@ struct disk_info {
>>    */
>>   #define NR_STRIPES        256
>> -#define STRIPE_SIZE        PAGE_SIZE
>> +#define CONFIG_STRIPE_SIZE    (CONFIG_MD_RAID456_STRIPE_SHIFT << 9)
>> +#define STRIPE_SIZE        \
>> +    (CONFIG_STRIPE_SIZE > PAGE_SIZE ? PAGE_SIZE : CONFIG_STRIPE_SIZE)
> Hi Yufen
> 
> Is it what you want? Or it should be:
> 
> +#define STRIPE_SIZE \
> + (CONFIG_STRIPE_SIZE > PAGE_SIZE ? CONFIG_STRIPE_SIZE : PAGE_SIZE)
>>   #define STRIPE_SHIFT        (PAGE_SHIFT - 9)
>>   #define STRIPE_SECTORS        (STRIPE_SIZE>>9)
>>   #define    IO_THRESHOLD        1
> 
Yes, I think it is what I want.
STRIPE_SIZE should not be bigger than PAGE_SIZE. So, if CONFIG_STRIPE_SIZE
is bigger, we just set it as PAGE_SIZE.

Thanks,
Yufen
