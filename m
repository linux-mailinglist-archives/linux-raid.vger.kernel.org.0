Return-Path: <linux-raid+bounces-5127-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6443DB41196
	for <lists+linux-raid@lfdr.de>; Wed,  3 Sep 2025 03:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8ED189652D
	for <lists+linux-raid@lfdr.de>; Wed,  3 Sep 2025 01:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B54204E;
	Wed,  3 Sep 2025 01:00:51 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D851F92E;
	Wed,  3 Sep 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861251; cv=none; b=NXNmJN/qql5Voqkxo7O8EuElW+rgSycSOWJe0h7NQ2hFhNDfFOBLMAxCZwsZn+DpW+RZUzKeSHygbJ4tikH3b6vTls+bS8amLJufjIS6FN9gSiCmw66HOHVjOu+cnrzJ20CBtS7Xo5kcnTZAkSnksafK/e1oDA3nSDIJ9AFg6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861251; c=relaxed/simple;
	bh=hQh1J0LcqjC2SJyZ1/8npbmIMuyYk3vZKuIX5mGK+D0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eHQaHUtGkbnXisq9V4NrBLq9WBaGS2QRY9wVthRKKuXl+oYTHRkTrB8/AQmROddv7M/bqIX+gnF9dKfqgFV9ZWzRoVEugO8KGyRyz5kWIYbXx0GjbKIXe5og6AkMF2sulzss5D+wdAp1SbEsTCi0WXkvlgD8T9WKmvc2j7pEzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cGknC1Z3LzYQv67;
	Wed,  3 Sep 2025 09:00:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD6251A1102;
	Wed,  3 Sep 2025 09:00:45 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIw6k7doI9_NBA--.26156S3;
	Wed, 03 Sep 2025 09:00:44 +0800 (CST)
Subject: Re: [PATCH RFC v3 14/15] block: fix disordered IO in the case
 recursive split
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
 neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-15-yukuai1@huaweicloud.com>
 <e40b076d-583d-406b-b223-005910a9f46f@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0f7345dd-8c6b-a75c-c234-2bb09f842069@huaweicloud.com>
Date: Wed, 3 Sep 2025 09:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e40b076d-583d-406b-b223-005910a9f46f@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIw6k7doI9_NBA--.26156S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4DtFyDur1xArW8tw4xJFb_yoW8Aw1kpr
	WkKryDtrWrGF1Sgw40yFW7KFy0yrWUXw4rGr15Gay7Jr4UZr1qq347XryvgryUCr48CryU
	Zr1vgrnruw4DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/03 1:20, Bart Van Assche 写道:
> On 8/31/25 8:32 PM, Yu Kuai wrote:
>> -void submit_bio_noacct_nocheck(struct bio *bio)
>> +void submit_bio_noacct_nocheck(struct bio *bio, bool split)
>>   {
>>       blk_cgroup_bio_start(bio);
>>       blkcg_bio_issue_init(bio);
>> @@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>        * to collect a list of requests submited by a ->submit_bio 
>> method while
>>        * it is active, and then process them after it returned.
>>        */
>> -    if (current->bio_list)
>> -        bio_list_add(&current->bio_list[0], bio);
>> -    else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
>> +    if (current->bio_list) {
>> +        if (split && !bdev_is_zoned(bio->bi_bdev))
>> +            bio_list_add_head(&current->bio_list[0], bio);
>> +        else
>> +            bio_list_add(&current->bio_list[0], bio);
> 
> The above change will cause write errors for zoned block devices. As I
> have shown before, also for zoned block devices, if a bio is split
> insertion must happen at the head of the list. See e.g.
> "Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio 
> submission order"
> (https://lore.kernel.org/linux-block/a0c89df8-4b33-409c-ba43-f9543fb1b091@acm.org/) 
> 

Do you mean we should remove the bdev_is_zoned() checking? I added this
checking because I'm not quite sure about details in zone device, and
this checking is aimed at prevent functional changes in zone device.

So I don't think this change will cause write errors, the write errors
should already exist before this set, right?

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> .
> 


