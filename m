Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000679377A
	for <lists+linux-raid@lfdr.de>; Wed,  6 Sep 2023 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjIFIvj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Sep 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjIFIvj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Sep 2023 04:51:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAAC128
        for <linux-raid@vger.kernel.org>; Wed,  6 Sep 2023 01:51:34 -0700 (PDT)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rgbc83NBXzNmqy;
        Wed,  6 Sep 2023 16:47:52 +0800 (CST)
Received: from [10.174.177.197] (10.174.177.197) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 16:51:32 +0800
Subject: Re: [PATCH v2] Fix race of "mdadm --add" and "mdadm --incremental"
To:     Martin Wilck <mwilck@suse.com>, Coly Li <colyli@suse.de>
CC:     Jes Sorensen <jes@trained-monkey.org>,
        <linux-raid@vger.kernel.org>, <louhongxiang@huawei.com>,
        miaoguanqin <miaoguanqin@huawei.com>
References: <bcc2d161-521b-ea19-b090-9822925645e5@huawei.com>
 <kjdwwbkqj6fuaijow2nldh5ofbxymto2mzqcullb57jtx6q6h2@46kropdd4lql>
 <12823520a0fe774908bd0830f59d05d2e7c06126.camel@suse.com>
From:   Li Xiao Keng <lixiaokeng@huawei.com>
Message-ID: <a56df487-ef9a-9c90-87a6-5ae0a0ffe9f0@huawei.com>
Date:   Wed, 6 Sep 2023 16:51:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12823520a0fe774908bd0830f59d05d2e7c06126.camel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.197]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2023/9/6 3:08, Martin Wilck wrote:
> On Wed, 2023-09-06 at 00:17 +0800, Coly Li wrote:
>> Hi Xiao Keng,
>>
>> Thanks for the updated version, I add my comments inline.
>>
>> On Tue, Sep 05, 2023 at 08:02:06PM +0800, Li Xiao Keng wrote:
>>> When we add a new disk to a raid, it may return -EBUSY.
>>
>> Where is above -EBUSY from? do you mean mdadm command returns
>> -EBUSY or it is returned by some specific function in mdadm
>> source code.
>>

Because the new disk is added to the raid by "mdadm --incremental",
the "mdadm --add" will return the err.

>>>
>>> The main process of --add:
>>> 1. dev_open
>>> 2. store_super1(st, di->fd) in write_init_super1
>>> 3. fsync(di->fd) in write_init_super1
>>> 4. close(di->fd)
>>> 5. ioctl(ADD_NEW_DISK)
>>>
>>> However, there will be some udev(change) event after step4. Then
>>> "/usr/sbin/mdadm --incremental ..." will be run, and the new disk
>>> will be add to md device. After that, ioctl will return -EBUSY.
>>>
>>
>> Dose returning -EBUSY hurt anything? Or only returns -EBUSY and
>> other stuffs all work as expected?
> 
> IIUC, it does not. The manual --add command will fail. Li Xiao Keng has
> described the problem in earlier emails.
Yes！ The disk is add to the raid, but the manual --add command will fail.
We will decide the next action based on the return value.

>  
>>> Here we add map_lock before write_init_super in "mdadm --add"
>>> to fix this race.
>>>
>>
>> I am not familiar this part of code, but I see ignoring the failure
>> from map_lock() in Assemble() is on purpose by Neil. Therefore I
>> just guess simply return from Assemble when map_lock() fails might
>> not be what you wanted.
>>
>>
>>> Signed-off-by: Li Xiao Keng <lixiaokeng@huawei.com>
>>> Signed-off-by: Guanqin Miao <miaoguanqin@huawei.com>
>>> ---
>>>  Assemble.c |  5 ++++-
>>>  Manage.c   | 25 +++++++++++++++++--------
>>>  2 files changed, 21 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Assemble.c b/Assemble.c
>>> index 49804941..086890ed 100644
>>> --- a/Assemble.c
>>> +++ b/Assemble.c
>>> @@ -1479,8 +1479,11 @@ try_again:
>>>          * to our list.  We flag them so that we don't try to re-
>>> add,
>>>          * but can remove if they turn out to not be wanted.
>>>          */
>>> -       if (map_lock(&map))
>>> +       if (map_lock(&map)) {
>>>                 pr_err("failed to get exclusive lock on mapfile -
>>> continue anyway...\n");
>>> +               return 1;
>>
>> Especially when the error message noticed "continue anyway" but a
>> return 1
>> followed, the behavior might be still confusing.
> 
> Now as you're saying it, I recall I had the same comment last time ;-)
> 
I'm very sorry for this stupid mistake. I I find I send v1 patch but not
v2. I will send patch v2 to instead of it.

-	if (map_lock(&map))
-		pr_err("failed to get exclusive lock on mapfile - continue anyway...\n");
+	if (map_lock(&map)) {
+		pr_err("failed to get exclusive lock on mapfile when assemble raid.\n");
+		return 1;
+	}

> I might add that "return 1" is dangerous, as it pretends that
> Manage_add() was successful and actually added a device, which is not
> the case. In the special case that Li Xiao Keng wants to fix, it's true
> (sort of) because the asynchronous "mdadm -I" will have added the
> device already. But there could be other races where Assemble_map()
> can't obtain the lock and still the device will not be added later.
> 

Do I missunstandings
"AFAICS it would only help if the code snipped above did not only
pr_err() but exit if it can't get an exclusive lock." ?

Anyway, map_lock is a blocking function. If it can't get the lock, it blocks.
If map_lock() return error, Assemble() return 1. When -add unlock it,
Assemble() will go ahead but not return at map_lock().

Do you think it should remain as it is? Like:

	if (map_lock(&map))
		pr_err("failed to get exclusive lock on mapfile - continue anyway...\n");

>>>
>>> +       if (map_lock(&map)) {
>>> +               pr_err("failed to get exclusive lock on mapfile
>>> when add disk\n");
>>> +               return -1;
>>> +       }
>>>         if (array->not_persistent==0) {
>>>                 int dfd;
>>>                 if (dv->disposition == 'j')
>>> @@ -911,9 +916,9 @@ int Manage_add(int fd, int tfd, struct
>>> mddev_dev *dv,
>>>                 dfd = dev_open(dv->devname, O_RDWR |

