Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72192745BD4
	for <lists+linux-raid@lfdr.de>; Mon,  3 Jul 2023 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGCMFA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Jul 2023 08:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGCME7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 3 Jul 2023 08:04:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD511F
        for <linux-raid@vger.kernel.org>; Mon,  3 Jul 2023 05:04:57 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qvkzm3y7nzMpfs;
        Mon,  3 Jul 2023 20:01:40 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 20:04:53 +0800
Subject: Re: [PATCH] md/raid1: freeze block layer queue during reshape
From:   Yu Kuai <yukuai3@huawei.com>
To:     Xueshi Hu <xueshi.hu@smartx.com>
CC:     Song Liu <song@kernel.org>, <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <vsag6vp4jokp2k5fkoqb5flklghpakxmglr75vpzgkmzejc47u@ih2255x374rp>
 <658e3fbc-d7bd-3fc9-b82e-0ecb86fd8c49@huawei.com>
 <bawtcsifeew7jtinckwxfrg7bach366uoccecfc5v56xmdhqsn@kj72oenu5j2w>
 <a366b0fc-3ddb-1a8f-9935-4f3ca8cf1013@huawei.com>
Message-ID: <6e3fb0a1-fd76-6003-4603-1358989730d1@huawei.com>
Date:   Mon, 3 Jul 2023 20:04:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a366b0fc-3ddb-1a8f-9935-4f3ca8cf1013@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

在 2023/07/03 19:19, Yu Kuai 写道:
> Hi,
> 
> 在 2023/07/03 17:47, Xueshi Hu 写道:
>> On Mon, Jul 03, 2023 at 09:44:03AM +0800, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2023/07/02 18:04, Xueshi Hu 写道:
>>>> When a raid device is reshaped, in-flight bio may reference outdated
>>>> r1conf::raid_disks and r1bio::poolinfo. This can trigger a bug in
>>>> three possible paths:
>>>>
>>>> 1. In function "raid1d". If a bio fails to submit, it will be resent to
>>>> raid1d for retrying the submission, which increases r1conf::nr_queued.
>>>> If the reshape happens, the in-flight bio cannot be freed normally as
>>>> the old mempool has been destroyed.
>>>> 2. In raid1_write_request. If one raw device is blocked, the kernel 
>>>> will
>>>> allow the barrier and wait for the raw device became ready, this makes
>>>> the raid reshape possible. Then, the local variable "disks" before the
>>>> label "retry_write" is outdated. Additionally, the kernel cannot 
>>>> reuse the
>>>> old r1bio.
>>>> 3. In raid_end_bio_io. The kernel must free the r1bio first and then
>>>> allow the barrier.
>>>>
>>>> By freezing the queue, we can ensure that there are no in-flight bios
>>>> during reshape. This prevents bio from referencing the outdated
>>>> r1conf::raid_disks or r1bio::poolinfo.
>>>
>>> I didn't look into the details of the problem you described, but even if
>>> the problem exist, freeze queue can't help at all, blk_mq_freeze_queue()
>>> for bio-based device can't guarantee that threre are no in-flight bios.
>>>
>>> Thanks,
>>> Kuai
>>>>
>>>> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
>>>> ---
>>>>    drivers/md/raid1.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>>> index dd25832eb045..d8d6825d0af6 100644
>>>> --- a/drivers/md/raid1.c
>>>> +++ b/drivers/md/raid1.c
>>>> @@ -3247,6 +3247,7 @@ static int raid1_reshape(struct mddev *mddev)
>>>>        unsigned long flags;
>>>>        int d, d2;
>>>>        int ret;
>>>> +    struct request_queue *q = mddev->queue;
>>>>        memset(&newpool, 0, sizeof(newpool));
>>>>        memset(&oldpool, 0, sizeof(oldpool));
>>>> @@ -3296,6 +3297,7 @@ static int raid1_reshape(struct mddev *mddev)
>>>>            return -ENOMEM;
>>>>        }
>>>> +    blk_mq_freeze_queue(q);
>>>>        freeze_array(conf, 0);
>>>>        /* ok, everything is stopped */
>>>> @@ -3333,6 +3335,7 @@ static int raid1_reshape(struct mddev *mddev)
>>>>        md_wakeup_thread(mddev->thread);
>>>>        mempool_exit(&oldpool);
>>>> +    blk_mq_unfreeze_queue(q);
>>>>        return 0;
>>>>    }
>>>>
>>
>> Use this bash script, it's easy to trigger the bug
>> 1. Firstly, start fio to make requests on raid device
>> 2. Set one of the raw devices' state into "blocked"
>> 3. Reshape the raid device and "-blocked" the raw device
>>
>> ```
>> parted -s /dev/sda -- mklabel gpt
>> parted /dev/sda -- mkpart primary 0G 1G
>> parted -s /dev/sdc -- mklabel gpt
>> parted /dev/sdc -- mkpart primary 0G 1G
>>
>> yes | mdadm --create /dev/md10 --level=mirror \
>>     --force --raid-devices=2 /dev/sda1 /dev/sdc1
>> mdadm --wait /dev/md10
>>
>> nohup fio fio.job &
>>
>> device_num=2
>> for ((i = 0; i <= 100000; i = i + 1)); do
>>     sleep 1
>>     echo "blocked" >/sys/devices/virtual/block/md10/md/dev-sda1/state
>>     if [[ $((i % 2)) -eq 0 ]]; then
>>         device_num=2
>>     else
>>         device_num=1800
>>     fi
>>     mdadm --grow --force --raid-devices=$device_num /dev/md10
>>     sleep 1
>>     echo "-blocked" >/sys/devices/virtual/block/md10/md/dev-sda1/state
>> done
>> ```
>>
>> The configuration of fio, file fio.job
>> ```
>> [global]
>> ioengine=libaio
>> bs=4k
>> numjobs=1
>> iodepth=128
>> direct=1
>> rate=1M,1M
>>
>> [md10]
>> time_based
>> runtime=-1
>> rw=randwrite
>> filename=/dev/md10
>> ```
>>
>> kernel crashed when trying to free r1bio:
>>
>> [  116.977805]  ? __die+0x23/0x70
>> [  116.977962]  ? page_fault_oops+0x181/0x470
>> [  116.978148]  ? exc_page_fault+0x71/0x180
>> [  116.978331]  ? asm_exc_page_fault+0x26/0x30
>> [  116.978523]  ? bio_put+0xe/0x130
>> [  116.978672]  raid_end_bio_io+0xa1/0xd0
>> [  116.978854]  raid1_end_write_request+0x111/0x350
>> [  116.979063]  blk_update_request+0x114/0x480
>> [  116.979253]  ? __ata_sff_port_intr+0x9c/0x160
>> [  116.979452]  scsi_end_request+0x27/0x1c0
>> [  116.979633]  scsi_io_completion+0x5a/0x6a0
>> [  116.979822]  blk_complete_reqs+0x3d/0x50
>> [  116.980000]  __do_softirq+0x113/0x3aa
>> [  116.980169]  irq_exit_rcu+0x8e/0xb0
>> [  116.980334]  common_interrupt+0x86/0xa0
>> [  116.980508]  </IRQ>
>> [  116.980606]  <TASK>
>> [  116.980704]  asm_common_interrupt+0x26/0x40
>> [  116.980897] RIP: 0010:default_idle+0xf/0x20
> 
> This looks like freeze_array() doen't work as expected.
> 
After a quick look, I think the problem is that before waiting for
blocked rdev in raid1_write_request(), allow_barrier() is called hence
freeze_array() won't wait for this r1_bio, and if old bio pool is freed
by raid1_reshape(), this problem is triggered.

I think the right fix might be freing the old r1_bio and allocate a new
r1_bio in this case.

Thanks,
Kuai
>>
>> As far I know, when a request is allocated,
>> request_queue::q_usage_counter is increased. When the io finished, the
>> request_queue::q_usage_counter is decreased, use nvme driver as an
>> example:
>>
>> nvme_complete_batch()
>>     blk_mq_end_request_batch()
>>         blk_mq_flush_tag_batch()
>>             percpu_ref_put_many(&q->q_usage_counter, nr_tags);
>>
>>
>> So, when blk_mq_freeze_queue() is returned successfully, every in-flight
>> io has returned from hardware, also new requests are blocked.
> 
> This only works for rq-based device, not bio-based device.
> 
> Thanks,
> Kuai
>>
>> Thanks,
>> Hu
>>
>> .
>>
