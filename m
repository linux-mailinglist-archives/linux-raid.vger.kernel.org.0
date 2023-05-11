Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE326FF452
	for <lists+linux-raid@lfdr.de>; Thu, 11 May 2023 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjEKOaO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 11 May 2023 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbjEKO36 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 11 May 2023 10:29:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65511D8C
        for <linux-raid@vger.kernel.org>; Thu, 11 May 2023 07:29:12 -0700 (PDT)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QHDfY11W7zpSyC;
        Thu, 11 May 2023 22:24:05 +0800 (CST)
Received: from [10.174.177.197] (10.174.177.197) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 22:28:17 +0800
Subject: Re: [PATCH] Fix race of "mdadm --add" and "mdadm --incremental"
To:     Coly Li <colyli@suse.de>
CC:     <jes@trained-monkey.org>, <mwilck@suse.com>,
        <pmenzel@molgen.mpg.de>, <linux-raid@vger.kernel.org>,
        <miaoguanqin@huawei.com>, <louhongxiang@huawei.com>
References: <20230417140144.3013024-1-lixiaokeng@huawei.com>
 <b72aacfa-f99f-0322-5247-aa25aa30cd96@huawei.com>
 <8c6579f8-4510-a3f9-6161-0ea1ee34fec6@huawei.com>
 <DB23F26B-DE0E-422F-8973-7E32832E7571@suse.de>
From:   Li Xiao Keng <lixiaokeng@huawei.com>
Message-ID: <46d2a4fe-f0ef-13f9-8589-2f5e6acb8f47@huawei.com>
Date:   Thu, 11 May 2023 22:28:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DB23F26B-DE0E-422F-8973-7E32832E7571@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2023/5/8 9:40, Coly Li wrote:
> 
> 
>> 2023年5月8日 09:30，Li Xiao Keng <lixiaokeng@huawei.com> 写道：
>>
>> ping
>>
>> On 2023/4/23 9:30, Li Xiao Keng wrote:
>>> ping
>>>
>>> On 2023/4/17 22:01, Li Xiao Keng wrote:
>>>> When we add a new disk to a raid, it may return -EBUSY.
>>>>
>>>> The main process of --add:
>>>> 1. dev_open
>>>> 2. store_super1(st, di->fd) in write_init_super1
>>>> 3. fsync(di->fd) in write_init_super1
>>>> 4. close(di->fd)
>>>> 5. ioctl(ADD_NEW_DISK)
>>>>
>>>> However, there will be some udev(change) event after step4. Then
>>>> "/usr/sbin/mdadm --incremental ..." will be run, and the new disk
>>>> will be add to md device. After that, ioctl will return -EBUSY.
>>>>
> 
> Hi Xiao Keng,
> 
> The above description of the race is not informative enough, I am aware exactly how the race is from, therefore I am not able to response for the fix.
> 
> Coly Li
> 
------
There is a raid1 with sda and sdb. And we add sdc to this raid,
it may return -EBUSY.

The main process of --add:
1. dev_open（sdc) in Manage_add
2. store_super1(st, di->fd) in write_init_super1
3. fsync(fd) in store_super1
4. close(di->fd) in write_init_super1
5. ioctl(ADD_NEW_DISK)

Step 2 and 3 will add sdc to metadata of raid1. There will be
udev(change of sdc) event after step4. Then "/usr/sbin/mdadm
--incremental --export $devnode --offroot $env{DEVLINKS}"
will be run, and the sdc will be added to the raid1. Then
step 5 will return -EBUSY because it checks if device isn't
claimed in md_import_device()->lock_rdev()->blkdev_get_by_dev()
->blkdev_get().

It will be confusing for users because sdc is added first time.
The "incremental" will get map_lock before add sdc to raid1.
So we add map_lock before write_init_super in "mdadm --add"
to fix the race of "add" and "incremental".
------

I'm sorry for no detailed description. Do you have any advice
of the new description?

> 
> 
> 
>>>> Here we add map_lock before write_init_super in "mdadm --add"
>>>> to fix this race.
>>>>
>>>> Signed-off-by: Li Xiao Keng <lixiaokeng@huawei.com>
>>>> Signed-off-by: Guanqin Miao <miaoguanqin@huawei.com>
>>>> ---
>>>> Assemble.c |  5 ++++-
>>>> Manage.c   | 25 +++++++++++++++++--------
>>>> 2 files changed, 21 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/Assemble.c b/Assemble.c
>>>> index 49804941..086890ed 100644
>>>> --- a/Assemble.c
>>>> +++ b/Assemble.c
>>>> @@ -1479,8 +1479,11 @@ try_again:
>>>> * to our list.  We flag them so that we don't try to re-add,
>>>> * but can remove if they turn out to not be wanted.
>>>> */
>>>> - if (map_lock(&map))
>>>> + if (map_lock(&map)) {
>>>> pr_err("failed to get exclusive lock on mapfile - continue anyway...\n");
>>>> + return 1;
>>>> + }
>>>> +
>>>> if (c->update == UOPT_UUID)
>>>> mp = NULL;
>>>> else
>>>> diff --git a/Manage.c b/Manage.c
>>>> index f54de7c6..6a101bae 100644
>>>> --- a/Manage.c
>>>> +++ b/Manage.c
>>>> @@ -703,6 +703,7 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> struct supertype *dev_st;
>>>> int j;
>>>> mdu_disk_info_t disc;
>>>> + struct map_ent *map = NULL;
>>>>
>>>> if (!get_dev_size(tfd, dv->devname, &ldsize)) {
>>>> if (dv->disposition == 'M')
>>>> @@ -900,6 +901,10 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> disc.raid_disk = 0;
>>>> }
>>>>
>>>> + if (map_lock(&map)) {
>>>> + pr_err("failed to get exclusive lock on mapfile when add disk\n");
>>>> + return -1;
>>>> + }
>>>> if (array->not_persistent==0) {
>>>> int dfd;
>>>> if (dv->disposition == 'j')
>>>> @@ -911,9 +916,9 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> dfd = dev_open(dv->devname, O_RDWR | O_EXCL|O_DIRECT);
>>>> if (tst->ss->add_to_super(tst, &disc, dfd,
>>>>  dv->devname, INVALID_SECTORS))
>>>> - return -1;
>>>> + goto unlock;
>>>> if (tst->ss->write_init_super(tst))
>>>> - return -1;
>>>> + goto unlock;
>>>> } else if (dv->disposition == 'A') {
>>>> /*  this had better be raid1.
>>>> * As we are "--re-add"ing we must find a spare slot
>>>> @@ -971,14 +976,14 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> pr_err("add failed for %s: could not get exclusive access to container\n",
>>>>       dv->devname);
>>>> tst->ss->free_super(tst);
>>>> - return -1;
>>>> + goto unlock;
>>>> }
>>>>
>>>> /* Check if metadata handler is able to accept the drive */
>>>> if (!tst->ss->validate_geometry(tst, LEVEL_CONTAINER, 0, 1, NULL,
>>>>    0, 0, dv->devname, NULL, 0, 1)) {
>>>> close(container_fd);
>>>> - return -1;
>>>> + goto unlock;
>>>> }
>>>>
>>>> Kill(dv->devname, NULL, 0, -1, 0);
>>>> @@ -987,7 +992,7 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>>  dv->devname, INVALID_SECTORS)) {
>>>> close(dfd);
>>>> close(container_fd);
>>>> - return -1;
>>>> + goto unlock;
>>>> }
>>>> if (!mdmon_running(tst->container_devnm))
>>>> tst->ss->sync_metadata(tst);
>>>> @@ -998,7 +1003,7 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>>       dv->devname);
>>>> close(container_fd);
>>>> tst->ss->free_super(tst);
>>>> - return -1;
>>>> + goto unlock;
>>>> }
>>>> sra->array.level = LEVEL_CONTAINER;
>>>> /* Need to set data_offset and component_size */
>>>> @@ -1013,7 +1018,7 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> pr_err("add new device to external metadata failed for %s\n", dv->devname);
>>>> close(container_fd);
>>>> sysfs_free(sra);
>>>> - return -1;
>>>> + goto unlock;
>>>> }
>>>> ping_monitor(devnm);
>>>> sysfs_free(sra);
>>>> @@ -1027,7 +1032,7 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> else
>>>> pr_err("add new device failed for %s as %d: %s\n",
>>>>       dv->devname, j, strerror(errno));
>>>> - return -1;
>>>> + goto unlock;
>>>> }
>>>> if (dv->disposition == 'j') {
>>>> pr_err("Journal added successfully, making %s read-write\n", devname);
>>>> @@ -1038,7 +1043,11 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
>>>> }
>>>> if (verbose >= 0)
>>>> pr_err("added %s\n", dv->devname);
>>>> + map_unlock(&map);
>>>> return 1;
>>>> +unlock:
>>>> + map_unlock(&map);
>>>> + return -1;
>>>> }
>>>>
>>>> int Manage_remove(struct supertype *tst, int fd, struct mddev_dev *dv,
>>>>
> 
> .
> 
