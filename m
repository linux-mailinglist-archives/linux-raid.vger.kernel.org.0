Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5121EE520
	for <lists+linux-raid@lfdr.de>; Thu,  4 Jun 2020 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgFDNRb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 4 Jun 2020 09:17:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgFDNRb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 4 Jun 2020 09:17:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A90D5C8DC5FAC7F8CED7;
        Thu,  4 Jun 2020 21:17:29 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 4 Jun 2020 21:17:22 +0800
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, "Coly Li" <colyli@suse.de>,
        Xiao Ni <xni@redhat.com>, Hou Tao <houtao1@huawei.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
 <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com>
 <71f662d7-9aee-a130-c41d-67a691514ef6@cloud.ionos.com>
 <555121b6-fe76-4827-7b8f-7a22ba04ed82@huawei.com>
 <9acfb512-88ee-b4b0-88d4-94841e72d31a@cloud.ionos.com>
 <CAPhsuW4UMDKhpGL71R6FY1-Q_u6On68ku4C=xp0UzSaEaCNGkg@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <72b83f59-db43-6809-d975-4ec3c2c83cd4@huawei.com>
Date:   Thu, 4 Jun 2020 21:17:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4UMDKhpGL71R6FY1-Q_u6On68ku4C=xp0UzSaEaCNGkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/6/2 14:59, Song Liu wrote:
>> I do think the flexibility is not enough, if someone set stripe size to
>> 64KB by any chance,
>> people could complain the performance of raid5 really sucks if the io is
>> not big. And it is
>> not realistic to let people rebuild the module in case the io size is
>> changed, so it would be
>> more helpful if the stripe size can be changed dynamically without
>> recompile code.
> 
> Agreed that it is not ideal to recompile the kernel/module to change stripe
> size. It is also possible that multiple arrays in one system have different
> optimal stripe sizes. I guess it shouldn't be too complicated to make this
> configurable per array?
> 

Yeah. Thanks a lot for suggestion. I admit that the current implementation is really
not good. To make it more flexible and provide each stripe_size for raid arrays, I plan
to move stripe_size into r5conf and make it dynamically changeable by sysfs interface.

Thanks,
Yufen
