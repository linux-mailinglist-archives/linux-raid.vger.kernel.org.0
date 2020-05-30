Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447661E8D26
	for <lists+linux-raid@lfdr.de>; Sat, 30 May 2020 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgE3CPT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 22:15:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728349AbgE3CPS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 22:15:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B574946A8A02B1AD7764;
        Sat, 30 May 2020 10:15:15 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 30 May 2020 10:15:07 +0800
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>, <colyli@suse.de>,
        <xni@redhat.com>, <houtao1@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
 <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com>
 <71f662d7-9aee-a130-c41d-67a691514ef6@cloud.ionos.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <555121b6-fe76-4827-7b8f-7a22ba04ed82@huawei.com>
Date:   Sat, 30 May 2020 10:15:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <71f662d7-9aee-a130-c41d-67a691514ef6@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/29 20:22, Guoqing Jiang wrote:
> On 5/29/20 1:49 PM, Yufen Yu wrote:
>>> The 4k rand write performance drops from 100MB/S to 15MB/S?! How about other
>>> io sizes? Say 16k, 64K and 256K etc, it would be more convincing if 64KB stripe
>>> has better performance than 4KB stripe overall.
>>>
>>
>> Maybe I have not explain clearly. Here, the fio test result shows that 4KB
>> STRIPE_SIZE is not always have better performance. If applications request
>> IO size mostly are bigger than 4KB, likely 1MB in test, set STRIPE_SIZE with
>> a bigger value can get better performance.
>>
>> So, we try to provide a configurable STRIPE_SIZE, rather than fix STRIPE_SIZE as 4096. 
> 
> Which means if you set stripe size to 64KB then you should guarantee the io size should
> always bigger then 1MB, right? Given that, I don't think it makes lots of sense.
> 

No, I think you misunderstood. This patchset just want to optimize RAID5 performance
for systems whose PAGE_SIZE is bigger than 4KB, likely 64KB on ARM64. Without this
patchset, STRIPE_SIZE is equal to 64KB, means each IO size issued to array disk at
least 64KB each time, Right? But filesystems usually issue bio in the unit of 4KB,
means sometimes required 4KB but read or write 64KB on disk actually. That would
waste resources.

After this patchset, we set STRIPE_SIZE as default 4KB. For systems like X86, which
just support 4KB PAGE_SIZE, it will not have any effect. But for 64KB arm64 system,
it **normally** can get better performance on filesystems base on raid5, like dbench test.

fio test just want to say that, we can also configure STRIPE_SIZE with a bigger value
than default 4KB on 64KB ARM64 system when applications mostly issue big IO. It can
get better performance for reducing IO split in RAID5.

Thanks,
Yufen

> Anyway, just my $0.02.
> 
> Thanks,
> Guoqing
