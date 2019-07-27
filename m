Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697F977713
	for <lists+linux-raid@lfdr.de>; Sat, 27 Jul 2019 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfG0FzL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 27 Jul 2019 01:55:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfG0FzL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 27 Jul 2019 01:55:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90ECAACDCD1F5D8835B8;
        Sat, 27 Jul 2019 13:55:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 13:55:06 +0800
Subject: Re: [RFC PATCH 0/3] md: export internal stats through debugfs
To:     Bob Liu <bob.liu@oracle.com>, <linux-raid@vger.kernel.org>,
        <songliubraving@fb.com>
CC:     <neilb@suse.com>, <linux-block@vger.kernel.org>,
        <snitzer@redhat.com>, <agk@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20190702132918.114818-1-houtao1@huawei.com>
 <1ebcf2e8-f3ce-7417-4060-b9264a5a4e51@oracle.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <9e74accf-14c6-91f7-55ca-6bdabe0fb878@huawei.com>
Date:   Sat, 27 Jul 2019 13:55:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1ebcf2e8-f3ce-7417-4060-b9264a5a4e51@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 2019/7/23 7:30, Bob Liu wrote:
> On 7/2/19 9:29 PM, Hou Tao wrote:
>> Hi,
>>
>> There are so many io counters, stats and flags in md, so I think
>> export these info to userspace will be helpful for online-debugging,
> 
> For online-debugging, I'd suggest you have a try eBPF which can be very helpful.
> 

Thanks for your suggestion. Using an eBPF program to read these internal status
from a host which is fully under your control is a good choice, but when
the dependencies of an eBPF program (e.g., the minor version of the kernel
and the kernel configuration which will influence the struct layout) is
out-of-your-control, it's not a good choice.

Thanks,
Tao

> -Bob
> 
>> especially when the vmlinux file and the crash utility are not
>> available. And these info can also be utilized during code
>> understanding.
>>
>> MD has already exported some stats through sysfs files under
>> /sys/block/mdX/md, but using sysfs file to export more internal
>> stats are not a good choice, because we need to create a single
>> sysfs file for each internal stat according to the use convention
>> of sysfs and there are too many internal stats. Further, the
>> newly-created sysfs files would become APIs for userspace tools,
>> but that is not we wanted, because these files are related with
>> internal stats and internal stats may change from time to time.
>>
>> And I think debugfs is a better choice. Because we can show multiple
>> related stats in a debugfs file, and the debugfs file will never be
>> used as an userspace API.
>>
>> Two debugfs files are created to expose these internal stats:
>> * iostat: io counters and io related stats (e.g., mddev->active_io,
>> 	r1conf->nr_pending, or r1confi->retry_list)
>> * stat: normal stats/flags (e.g., mddev->recovery, conf->array_frozen)
>>
>> Because internal stats are spreaded all over md-core and md-personality,
>> so both md-core and md-personality will create these two debugfs files
>> under different debugfs directory.
>>
>> Patch 1 factors out the debugfs files creation routine for md-core and
>> md-personality, patch 2 creates two debugfs files: iostat & stat under
>> /sys/kernel/debug/block/mdX for md-core, and patch 3 creates two debugfs
>> files: iostat & stat under /sys/kernel/debug/block/mdX/raid1 for md-raid1.
>>
>> The following lines show the hierarchy and the content of these debugfs
>> files for a RAID1 device:
>>
>> $ pwd
>> /sys/kernel/debug/block/md0
>> $ tree
>> .
>> ├── iostat
>> ├── raid1
>> │   ├── iostat
>> │   └── stat
>> └── stat
>>
>> $ cat iostat
>> active_io 0
>> sb_wait 0 pending_writes 0
>> recovery_active 0
>> bitmap pending_writes 0
>>
>> $ cat stat
>> flags 0x20
>> sb_flags 0x0
>> recovery 0x0
>>
>> $ cat raid1/iostat
>> retry_list active 0
>> bio_end_io_list active 0
>> pending_bio_list active 0 cnt 0
>> sync_pending 0
>> nr_pending 0
>> nr_waiting 0
>> nr_queued 0
>> barrier 0
>>
>> $ cat raid1/stat
>> array_frozen 0
>>
>> I'm not sure whether the division of internal stats is appropriate and
>> whether the internal stats in debugfs files are sufficient, so questions
>> and comments are weclome.
>>
>> Regards,
>> Tao
>>
>> Hou Tao (3):
>>   md-debugfs: add md_debugfs_create_files()
>>   md: export inflight io counters and internal stats in debugfs
>>   raid1: export inflight io counters and internal stats in debugfs
>>
>>  drivers/md/Makefile     |  2 +-
>>  drivers/md/md-debugfs.c | 35 ++++++++++++++++++
>>  drivers/md/md-debugfs.h | 16 +++++++++
>>  drivers/md/md.c         | 65 ++++++++++++++++++++++++++++++++++
>>  drivers/md/md.h         |  1 +
>>  drivers/md/raid1.c      | 78 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/md/raid1.h      |  1 +
>>  7 files changed, 197 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/md/md-debugfs.c
>>  create mode 100644 drivers/md/md-debugfs.h
>>
> 
> 
> .
> 

