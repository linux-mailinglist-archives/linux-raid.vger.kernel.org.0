Return-Path: <linux-raid+bounces-3867-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C5A5B6A3
	for <lists+linux-raid@lfdr.de>; Tue, 11 Mar 2025 03:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF67E1894030
	for <lists+linux-raid@lfdr.de>; Tue, 11 Mar 2025 02:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D91E32D9;
	Tue, 11 Mar 2025 02:23:25 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5081EF01
	for <linux-raid@vger.kernel.org>; Tue, 11 Mar 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659805; cv=none; b=XTZkMP13UY3q0vAZGhdPNkIA1leqrutr9wQT72gw+ZyH+GXpTKJDR7gB0uzTBZCjICKWrUGaKKYgFcod8fzQ5q+CrCNXLZtaM5YZO5J/D7WknXplrFaKk4GzxNN7qfW//ris9vUVI02rLv8Ye/zSPnNNiLuUwsZLGytEjjEfSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659805; c=relaxed/simple;
	bh=BB8gNCu1kzAHiJV/3DIWELVrYkDyxHV/CRAGMqvlfrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ASywP+V3f8iRevtEhNmoVsdA+z7zDTzx8KWVk81gw889eRZIi/nFsyqNlgEbYIx5a8H8P8gcTwlTnggrhOw1Ap+T1p2QClIrVH5LkR066Yw9xcpRu0Vo64NGo7Mcar/gHdLT82+QDY8+KV9ewdllswH2xF5PRp19o7GJ8jJjWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZBcyK4kGGz27gF6;
	Tue, 11 Mar 2025 10:23:53 +0800 (CST)
Received: from kwepemg500011.china.huawei.com (unknown [7.202.181.72])
	by mail.maildlp.com (Postfix) with ESMTPS id E57151A0190;
	Tue, 11 Mar 2025 10:23:18 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 kwepemg500011.china.huawei.com (7.202.181.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 10:23:18 +0800
Message-ID: <b79c7a76-36c7-17aa-fcb1-1050b199e23a@huawei.com>
Date: Tue, 11 Mar 2025 10:23:17 +0800
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] mdadm: Clear extra flags when initializing metadata
To: Blazej Kucman <blazej.kucman@linux.intel.com>
CC: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, Yu Kuai
	<yukuai1@huaweicloud.com>, <xni@redhat.com>, <ncroxon@redhat.com>,
	<linux-raid@vger.kernel.org>, <liubo254@huawei.com>
References: <b894d081-eda9-6b28-5fef-75753838a916@huawei.com>
 <27127b7d-7da6-cd31-01db-6725884a7286@huawei.com>
 <20250310154159.00007ea6@linux.intel.com>
From: Wu Guanghao <wuguanghao3@huawei.com>
In-Reply-To: <20250310154159.00007ea6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500011.china.huawei.com (7.202.181.72)



在 2025/3/10 22:41, Blazej Kucman 写道:
> On Mon, 10 Mar 2025 19:09:36 +0800
> Wu Guanghao <wuguanghao3@huawei.com> wrote:
> 
> Hi,
> Thanks for your patch.
> 
> you are only adding a change to native metadata so it would be good to
> emphasize this in the title, please change "mdadm:" to "super1:"
> 
> There are also a few checkpatch issues,
> 
> 
>> When adding a disk to a RAID1 array, the metadata is read from the
>> existing member disks for sync. However, only the bad_blocks flag are
>> copied, the bad_blocks records are not copied, so the bad_blocks
>> records are all zeros. The kernel function super_1_load() detects
>> bad_blocks flag and reads the bad_blocks record, then sets the bad
>> block using badblocks_set().
> 
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
> description?) #8: 
> the bad_blocks records are not copied, so the bad_blocks records are
> all zeros.
> 
>>
>> After the kernel commit 1726c7746("badblocks: improve badblocks_set()
>> for multiple ranges handling"), if the length of a bad_blocks record
> 
> please use SHA-1 ID - first 12 characters and space between ID and
> (Tile) 
> 
>> is 0, it will return a failure. Therefore the device addition will
>> fail.
>>
>> So when adding a new disk, some flags cannot be sync and need to be
>> cleared.
>>
>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>> ---
>> Changelog:
>> v2:
>>     Add a testcase.
>>     Clear extra replace flag.
>> ---
>>  super1.c                 |  4 ++++
>>  tests/05r1-add-badblocks | 25 +++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>  create mode 100644 tests/05r1-add-badblocks
>>
>> diff --git a/super1.c b/super1.c
>> index fe3c4c64..f4a29f4f 100644
>> --- a/super1.c
>> +++ b/super1.c
>> @@ -1971,6 +1971,10 @@ static int write_init_super1(struct supertype
>> *st) long bm_offset;
>>  	bool raid0_need_layout = false;
>>
>> +	/* Clear extra flags */
>> +	sb->feature_map &= ~__cpu_to_le32(MD_FEATURE_BAD_BLOCKS |
>> +                                          MD_FEATURE_REPLACEMENT);
> 
> ERROR: code indent should use tabs where possible
> #36: FILE: super1.c:1976:
> +                                          MD_FEATURE_REPLACEMENT);$
> 
> WARNING: please, no spaces at the start of a line
> #36: FILE: super1.c:1976:
> +                                          MD_FEATURE_REPLACEMENT);$
> 
> However, in this case the code will fit on one line, the limit is 100
> characters.
> 

Thank you for your feedback. I will modify it in the next version.

>> +
>>  	/* Since linux kernel v5.4, raid0 always has a layout */
>>  	if (has_raid0_layout(sb) && get_linux_version() >= 5004000)
>>  		raid0_need_layout = true;
>> diff --git a/tests/05r1-add-badblocks b/tests/05r1-add-badblocks
>> new file mode 100644
>> index 00000000..88b064f2
>> --- /dev/null
>> +++ b/tests/05r1-add-badblocks
>> @@ -0,0 +1,25 @@
>> +#
>> +# create a raid1 with a drive and set badblocks for the drive.
>> +# add a new drive does not cause an error.
>> +#
>> +
>> +# create raid1
>> +mdadm -CR $md0 -l1 -n2 -e1.0 $dev1 missing
>> +testdev $md0 1 $mdsize1a 64
>> +sleep 3
>> +
>> +# set badblocks for the drive
>> +dev1_name=$(basename $dev1)
>> +echo "10000 100" > /sys/block/md0/md/dev-$dev1_name/bad_blocks
>> +echo "write_error" > /sys/block/md0/md/dev-$dev1_name/state
>> +
>> +# maybe fail but that's ok, as it's only intended to
>> +# record the bad block in the metadata.
>> +mkfs.ext3 $md0
>> +
>> +# re-add and recovery
>> +mdadm $md0 -a $dev2
>> +check recovery
>> +
>> +mdadm -S $md0
>> +
> 
> Since you added the test, would you be able to issue a PR on github
> to get the tests running?
> 

Sure, I will create a PR and run the testcase.

> Thansk,
> Blazej
> 
> .

