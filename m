Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCD11C21C
	for <lists+linux-raid@lfdr.de>; Thu, 12 Dec 2019 02:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLLBZD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 20:25:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727351AbfLLBZC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Dec 2019 20:25:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90F78F03F4314B9C943B;
        Thu, 12 Dec 2019 09:25:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 09:24:49 +0800
Subject: Re: [PATCH V2] md: raid1: check whether rdev is null before reference
 in raid1_sync_request func
To:     Song Liu <song@kernel.org>
CC:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        "Song Liu" <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nate Dailey <nate.dailey@stratus.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mingfangsen <mingfangsen@huawei.com>, <guiyao@huawei.com>,
        <yanxiaodan@huawei.com>
References: <b894dad1-56b9-b87f-c6d5-cbcdea8c1add@huawei.com>
 <CAPhsuW7ieqQccS_c0tzALO-crhqysRf+Eg6en3hd6o_DjgfGZA@mail.gmail.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <8d720c3a-9e9a-6835-a6ee-4e0ecdb97a97@huawei.com>
Date:   Thu, 12 Dec 2019 09:24:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7ieqQccS_c0tzALO-crhqysRf+Eg6en3hd6o_DjgfGZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 2019/12/12 2:34, Song Liu wrote:
> On Mon, Dec 9, 2019 at 6:42 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>>
>> In raid1_sync_request func, rdev should be checked whether it is null
>> before reference.
>>
>> --
>> V1->V2: remove Fixes tag suggested by Guoqing Jiang
> 
> For future patches, please put "v1 -> v2" after the SoB tag. And add
> "---" before it.
> Then, this part will be removed during git-am.
> 
> Applied with minor change.
> 
> Thanks,
> Song
>
Thanks for your suggestion.


