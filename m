Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89AAFB4A
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfIKLVv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 07:21:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfIKLVv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Sep 2019 07:21:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 190DB971D6B7D194E5EF;
        Wed, 11 Sep 2019 19:21:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 19:21:46 +0800
Subject: Re: [PATCH v3 0/2] skip spare disk as freshest disk
To:     Song Liu <liu.song.a23@gmail.com>
CC:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20190911030142.49105-1-yuyufen@huawei.com>
 <CAPhsuW7Q=YsMkMQGMS54vskTRjM24oRMWP7534n_pkOhyGvJUA@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <3c5a5ede-d1a1-dd55-2dde-73b72a9c475d@huawei.com>
Date:   Wed, 11 Sep 2019 19:21:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7Q=YsMkMQGMS54vskTRjM24oRMWP7534n_pkOhyGvJUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/9/11 17:38, Song Liu wrote:
> On Wed, Sep 11, 2019 at 3:44 AM Yufen Yu <yuyufen@huawei.com> wrote:
>> Hi,
>>          For this patchset , we add a new entry .disk_is_spare in super_type
>>          to check if the disk is in 'spare' state. If a disk is in spare,
>>          analyze_sbs() should skip the disk to be freshest disk. Otherwise,
>>          it may cause md run fail. There is a fail example in the second patch.
>>
> I think we need go a different path. I am sorry that some of early comments
> are misleading.
>
> We can extend the output of load_super() to have "2" for spares. And this
> _should_ make the code simpler.
>
> Does this make sense?
>

I think we don't need to add extra output value '2'.

For now, only analyze_sbs() use the output of load_super(). The others 
caller just
check whether load_super() have failed, which will return a negative value.

My first version patch directly modify load_super() and return '0' for 
'spare' disk.
Then analyze_sbs() can skip the spare disk as fresher disk. I think it 
does work.
https://www.spinics.net/lists/raid/msg63136.html

BTW, I don't know how to return '2' from load_super(), which pass events 
test as
you say in the first patch. At the same time , it does not affect the 
other caller.

Thanks
Yufen


>
>


