Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D211E797A
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE2JdC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 05:33:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2JdB (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 05:33:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9066B6C14C118F2F33ED;
        Fri, 29 May 2020 17:32:59 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 17:32:49 +0800
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, "Xiao Ni" <xni@redhat.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <CAPhsuW7hVgM7yiaBg0Pkaci4NStEdyduCp1+yMf9aguKfm4jKQ@mail.gmail.com>
 <CAPhsuW7DOdPTWX5MNRJULvojFrCQF9_zNH+_ZwkQs4Qug9CpdQ@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <e0947530-003b-5090-70f3-4f6d02219033@huawei.com>
Date:   Fri, 29 May 2020 17:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7DOdPTWX5MNRJULvojFrCQF9_zNH+_ZwkQs4Qug9CpdQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/28 22:28, Song Liu wrote:
> On Thu, May 28, 2020 at 7:10 AM Song Liu <song@kernel.org> wrote:
>>
>> On Wed, May 27, 2020 at 6:20 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>>
>>> Hi, all
>>>
>>>   For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5 will
>>>   issus echo bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64. However,
>>>   filesystem usually issue bio in the unit of 4KB. Then, RAID5 will waste resource
>>>   of disk bandwidth.
>>>
>>
>> Thanks for the patch set.
>>
>> Since this is a big change, I am planning to process this set after
>> upcoming merge window.
>> Please let me know if you need it urgently.

I agree with your plan.

> 
> I haven't thought about this in detail yet: how about compatibility?
> Say we create an
> array with STRIPE_SIZE of 4kB, does it work well after we upgrade kernel to have
> STRIPE_SIZE of 8kB?

Each time upgrade kernel, we need to reboot system to make it effective.
And, system will allocate new stripe_head and buffers base on the new STRIPE_SIZE.
Then everything will be ok and go on running.

STRIPE_SIZE decides each io size issued to array disk and its buffers size in
stripe_head. But each time restart system, we will allocate new buffer and
stripe_head based on the new STRIPE_SIZE. It is no matter what the value before.
So, I think changing STRIPE_SIZE is not problem for upgrade kernel.

Thanks,
Yufen
