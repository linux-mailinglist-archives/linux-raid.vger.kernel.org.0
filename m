Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130341CBE1C
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgEIGkx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 May 2020 02:40:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4369 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbgEIGkx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 9 May 2020 02:40:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B4E7C714F35DDAB737E2;
        Sat,  9 May 2020 14:40:51 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 14:40:45 +0800
Subject: Re: [PATCH RFC v2 2/8] md/raid5: add a member of r5pages for struct
 stripe_head
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, "Xiao Ni" <xni@redhat.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200421123952.49025-1-yuyufen@huawei.com>
 <20200421123952.49025-3-yuyufen@huawei.com>
 <CAPhsuW4GxrgnToy=7HowOmWKBOqySdY=-n1KO-fYV+Thof7mtw@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <b7ce5578-61f6-a8a6-68da-7e357a1c44c9@huawei.com>
Date:   Sat, 9 May 2020 14:40:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4GxrgnToy=7HowOmWKBOqySdY=-n1KO-fYV+Thof7mtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/9 7:58, Song Liu wrote:
> On Tue, Apr 21, 2020 at 5:40 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>
> [...]
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>> +
>> +/*
>> + * We want to 'compress' multiple buffers to one real page for
>> + * stripe_head when PAGE_SIZE is biggger than STRIPE_SIZE. If their
>> + * values are equal, no need to use this strategy. For now, it just
>> + * support raid level less than 5.
>> + */
> 
> I don't think "compress" is the right terminology here. It is more
> like "share" a page.
> Why not support raid6 here?
> 

Thanks a lot for your reviewing and suggestion.
Since it need to modify more existing code to support raid6, this series
have not do it. I will try to support raid6 in next version.

Thanks,
Yufen
