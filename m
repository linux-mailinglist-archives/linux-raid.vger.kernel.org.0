Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBC2188AC
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jul 2020 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgGHNPD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jul 2020 09:15:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729069AbgGHNPD (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 Jul 2020 09:15:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E67CDCB35F0F19DD098;
        Wed,  8 Jul 2020 21:14:59 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Jul 2020 21:14:49 +0800
Subject: Re: [PATCH v5 00/16] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <CAPhsuW7PgJV-bjaa8v=Zrhd0MqPmjew1dF-Qi0FP6i-809YAQg@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <0dd1ebed-2802-2bef-48f0-87bbdd2ee8e5@huawei.com>
Date:   Wed, 8 Jul 2020 21:14:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7PgJV-bjaa8v=Zrhd0MqPmjew1dF-Qi0FP6i-809YAQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/7/3 7:00, Song Liu wrote:
> On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>
>> Hi, all
>>
>>   For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5
>>   will issue each bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64.
>>   However, filesystem usually issue bio in the unit of 4KB. Then, RAID5 may
>>   waste resource of disk bandwidth.
>>
>>   To solve the problem, this patchset try to set stripe_size as a configuare
>>   value. The default value is 4096. We will add a new sysfs entry and set it
>>   by writing a new value, likely:
>>
>>          echo 16384 > /sys/block/md1/md/stripe_size
> 
> Higher level question: do we need to support page size that is NOT 4kB
> times power
> of 2? Meaning, do we need to support 12kB, 20kB, 24kB, etc. If we only
> supports, 4kB,
> 8kB, 16kB, 32kB, etc. some of the logic can be simpler.

Yeah, I think we just support 4kb, 8kb, 16kb, 32kb... is enough.
But Sorry that I don't know what logic can be simpler in current implementation.
I mean it also need to allocate page, and record page offset.

Thanks,
Yufen

