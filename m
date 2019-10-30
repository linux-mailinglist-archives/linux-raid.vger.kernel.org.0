Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B541EE9736
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 08:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfJ3He1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 03:34:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfJ3He1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 03:34:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21F5868A3D0B414F78C6;
        Wed, 30 Oct 2019 15:34:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 15:34:18 +0800
Subject: Re: [PATCH] md: avoid invalid memory access for array sb->dev_roles
To:     Song Liu <songliubraving@fb.com>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
References: <20191029034143.47039-1-yuyufen@huawei.com>
 <0B3C835E-3CC8-4FC7-9DDF-2AF0A043E479@fb.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <9d9d2a54-20ce-9563-4de4-b6455f349986@huawei.com>
Date:   Wed, 30 Oct 2019 15:34:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0B3C835E-3CC8-4FC7-9DDF-2AF0A043E479@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2019/10/30 0:39, Song Liu wrote:
>
>> On Oct 28, 2019, at 8:41 PM, Yufen Yu <yuyufen@huawei.com> wrote:
>>
>> we need to gurantee 'desc_nr' valid before access array of sb->dev_roles.
>>
>> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
>> Addresses-Coverity-ID: 1487373 ("Memory - illegal accesses")
>> Fixes: 6a5cb53aaa4e ("md: no longer compare spare disk superblock events in super_load")
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>> drivers/md/md.c | 18 +++++++++---------
>> 1 file changed, 9 insertions(+), 9 deletions(-)
>>
>>
>> 	 * Calculate the position of the superblock in 512byte sectors.
>> @@ -1674,8 +1675,6 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
>> 	    sb->level != 0)
>> 		return -EINVAL;
>>
>> -	role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
>> -
>> 	if (!refdev) {
>> 		/*
>> 		 * Insist of good event counter while assembling, except for
>> @@ -1683,8 +1682,8 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
>> 		 */
>> 		if (rdev->desc_nr >= 0 &&
>> 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
>> -			(role < MD_DISK_ROLE_MAX ||
>> -			 role == MD_DISK_ROLE_JOURNAL))
>> +			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
>> +			 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
> Same concern for LEVEL_MULTIPATH applies here. And maybe we can make this
> code simpler?

I will send v2 to fix wrong return value for LEVEL_MULTIPATH and try to 
simplify the code.

Thanks,
Yufen

