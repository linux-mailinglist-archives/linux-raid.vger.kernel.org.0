Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125182224CA
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgGPOCY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 10:02:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728858AbgGPOCY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 10:02:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 179B66DA382B76015DB5;
        Thu, 16 Jul 2020 22:02:05 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 22:01:55 +0800
Subject: Re: [PATCH v6 00/15] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200715124257.3175816-1-yuyufen@huawei.com>
 <CAPhsuW4ON3U9GXygpMsTxWGfQr8XH1H8GHn-VPUmOBfOqAEWdw@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <17e80721-86dc-6be8-5018-222c3b7445a9@huawei.com>
Date:   Thu, 16 Jul 2020 22:01:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4ON3U9GXygpMsTxWGfQr8XH1H8GHn-VPUmOBfOqAEWdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/7/16 15:20, Song Liu wrote:
> On Wed, Jul 15, 2020 at 5:42 AM Yufen Yu <yuyufen@huawei.com> wrote:
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
> [...]
> 
>> V6:
>>   * Convert stripe_size and stripe_sectors from 'unsigned int' to
>>     'unsigned long' avoiding compiler warning.
>>   * Add a new member of stripes_per_page into r5conf, avoiding to
>>     compute each time.
>>   * Cover mddev->private with mddev_lock(mddev) for raid5_store/show_stripe_size().
>>   * Get rid of too many WARN_ON() and BUG_ON().
>>   * Unfold raid5_get_page_index() into raid5_get_dev_page() directly.
> 
> We are running out of time before the upcoming merge window, so we may not
> be able to ship the whole set. How about we ship 01, and 11 in this
> merge window,
> and the rest in the next merge window? Would the array get most of the
> performance benefit with these 2 patches? Do you see other issues with
> this path?
> 

This patchset includes two optimization, dynamically adjust stripe_size to improve
raid array performance and save memory used by stripe_head. If you think we may not
be able to ship the the whole set, I think just ship the first optimization (patch 01
and patch 11) can get better performance.

I will send the first optimization with adopting your suggestion as soon as possible.
Thanks a lot for your review.

Thanks,
Yufen

> Also I would like to minimize changes for PAGE_SIZE==4096 systems. Ideally,
> we can hide these changes from these system in ifdef's, like:
> 
> #if PAGE_SIZE == DEFAULT_STRIPE_SIZE
> #define STRIPE_SIZE            PAGE_SIZE
> #define STRIPE_SHIFT           (PAGE_SHIFT - 9)
> #define STRIPE_SECTORS         (STRIPE_SIZE>>9)
> #endif
> 
> #if PAGE_SIZE != DEFAULT_STRIPE_SIZE
> unsigned long           stripe_size;
> unsigned int            stripe_shift;
> unsigned long           stripe_sectors;
> #endif
> 
> #if PAGE_SIZE != DEFAULT_STRIPE_SIZE
> #define RAID5_STRIPE_SIZE(conf) DEFAULT_STRIPE_SIZE
> #else
> #define RAID5_STRIPE_SIZE(conf) ((conf)->stripe_size)
> #endif
> 
> And then use RAID5_STRIPE_SIZE(conf) in the rest of the code.
> 
> Thanks,
> Song
> .
> 
