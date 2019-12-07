Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36AF115AB8
	for <lists+linux-raid@lfdr.de>; Sat,  7 Dec 2019 03:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLGCZO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Dec 2019 21:25:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfLGCZN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 6 Dec 2019 21:25:13 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E477C6A43F9BBF306F30;
        Sat,  7 Dec 2019 10:25:10 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Dec 2019
 10:25:03 +0800
Subject: Re: [PATCH] md/raid1: check whether rdev is null before reference in
 raid1_sync_request func
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, <neilb@suse.de>,
        <songliubraving@fb.com>, <axboe@kernel.dk>, <yuyufen@huawei.com>,
        <houtao1@huawei.com>, <tglx@linutronix.de>,
        <nate.dailey@stratus.com>, <song@kernel.org>,
        <linux-raid@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>, <guiyao@huawei.com>
References: <e83c3d31-2deb-9d96-4bec-2db73acb109a@huawei.com>
 <9f387d93-9e30-055d-47a3-2d22a148d43a@cloud.ionos.com>
From:   "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>
Message-ID: <33077a08-ab9a-5573-aee7-df1e76f44bdb@huawei.com>
Date:   Sat, 7 Dec 2019 10:25:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9f387d93-9e30-055d-47a3-2d22a148d43a@cloud.ionos.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2019/12/6 18:02, Guoqing Jiang wrote:
> 
> 
> On 12/6/19 10:40 AM, liuzhiqiang (I) wrote:
>> In raid1_sync_request func, rdev should be checked whether it is null
>> before reference.
> 
> Do you have real calltrace about it?
Thanks for your comment.
Actually, it is reported by one static scanning tool.
> 
>> Fixes: 06f603851f("md/raid1: avoid reading known bad blocks during resync")
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>   drivers/md/raid1.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index a409ab6f30bc..0dea35052efe 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -2782,7 +2782,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>>                   write_targets++;
>>               }
>>           }
>> -        if (bio->bi_end_io) {
>> +        if (rdev != NULL && bio->bi_end_io) {
>>               atomic_inc(&rdev->nr_pending);
>>               bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
>>               bio_set_dev(bio, rdev->bdev);
> 
> If "bio->bi_end_io" is true, I think it implys rdev exists because bio->bi_end_io is set
> when rdev != NUL.  I don't object to add it to make it explicitly, but it is not a fix.
> 
ok, i will remove the fixes tag in v2 patch.


> Thanks,
> Guoqing
> 
> .

