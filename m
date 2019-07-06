Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2360EFE
	for <lists+linux-raid@lfdr.de>; Sat,  6 Jul 2019 06:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfGFEti (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 6 Jul 2019 00:49:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGFEti (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 6 Jul 2019 00:49:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9E28E79059B659F3216;
        Sat,  6 Jul 2019 12:49:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 6 Jul 2019
 12:49:22 +0800
Subject: Re: md0: bitmap file is out of date, resync
To:     Mathias G <newsnet-mg-2016@tuxedo.ath.cx>,
        Song Liu <liu.song.a23@gmail.com>
CC:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
 <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
Date:   Sat, 6 Jul 2019 12:49:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 2019/6/28 18:57, Mathias G wrote:
> Hi Song
> 
> On 21.06.19 21:51, Mathias G wrote:
>>> Question: are you running the two drives with write cache on?
>>> If yes, and if your application is not heavy on writes, could you try
>>> turn off HDD write cache and see if the issue repros?
>> Thanks for this. I just disabled the write cache with hdparm in rc.local
>> for both RAID members and will let you know if the problem occurs again.
> 
> Today the problem occurred again:
> 
> kern.log
>> Jun 28 12:39:11 $hostname kernel: [    2.098096] md/raid1:md0: not clean -- starting background reconstruction
>> Jun 28 12:39:11 $hostname kernel: [    2.098099] md/raid1:md0: active with 2 out of 2 mirrors

"not clean" means the resync has not been completed yet. Is the array still "not clean" in the previous boot/reboot or not ?
If it is only "not clean" in the reproduced boot, that may mean the final update of MD super block is lost and the lagging
behind of the events in bitmap super-block will be possible.

If the array is also "not clean" in the previous boot/reboot, could you please check when does the status of array
change from "clean" to "not clean" ?

Is the RAID array (md0) used as rootfs or other fs ? And how do you reproduce the problem ? Just rebooting continuously
until the problem reoccurs ? And not suddenly power-cut ?

Regards,
Tao

>> Jun 28 12:39:11 $hostname kernel: [    2.098201] md0: bitmap file is out of date (236662 < 236663) -- forcing full recovery
>> Jun 28 12:39:11 $hostname kernel: [    2.098252] md0: bitmap file is out of date, doing full recovery
> 
> And the write cache is disabled for both RAID members:
>> # hdparm -i /dev/sdb |grep WriteCache
>>  AdvancedPM=yes: disabled (255) WriteCache=disabled
> 
>> # hdparm -i /dev/sdc |grep WriteCache
>>  AdvancedPM=no WriteCache=disabled
> 
> I'm a little at a loss..
> 

