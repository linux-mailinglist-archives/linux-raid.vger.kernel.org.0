Return-Path: <linux-raid+bounces-4297-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDAEAC4695
	for <lists+linux-raid@lfdr.de>; Tue, 27 May 2025 04:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9A53B4C99
	for <lists+linux-raid@lfdr.de>; Tue, 27 May 2025 02:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D4198E91;
	Tue, 27 May 2025 02:49:57 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55A10A1E;
	Tue, 27 May 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748314197; cv=none; b=iyiBB1lKe1SmvRa+xhzIYsN3NlK3nr6e1kwDtH6qK9cVT6XmfpesKH/E2QRxIc5XXV6rGKXvKeT0axqAhG+Fg+oZq+x+QGV69A5Lu6N/trC+GWswvseV/7dVEAoTsnGu4dhpEQuJuuHublkyBgq2UsquV8t4fkRDWD8PBxTsXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748314197; c=relaxed/simple;
	bh=wqYHAaq/UdwQng5Pd61Fetys7znkp/EWqSXgR0K4aGs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kJxv4VQBXfReOUMqfiFgjt+BIgC44D+XVWMmuTB7rJ5Eig5S+m4sy1Dl3EcYm/YV6Zk49I2kyFsXOUtcpfine/x2na8owgRVeEwBi7OamF961vPU/CcN+OogH1zcHa+/IPMzs5ZVJ35zEUwPw2O+wj/vYDockJ9y1NelPIWNIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b5xtD2Zzbz4f3kvl;
	Tue, 27 May 2025 10:49:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1EBF41A07F2;
	Tue, 27 May 2025 10:49:51 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl9OKDVoaFuHNg--.19652S3;
	Tue, 27 May 2025 10:49:50 +0800 (CST)
Subject: Re: [PATCH 07/23] md/md-bitmap: delay registration of bitmap_ops
 until creating bitmap
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, colyli@kernel.org, song@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250524061320.370630-1-yukuai1@huaweicloud.com>
 <20250524061320.370630-8-yukuai1@huaweicloud.com>
 <CALTww2_03_fVt+KMcmtbGw-kcRsLLpAG7W62e3y0W9SpvhUVtg@mail.gmail.com>
 <12a61dcf-ad39-48e8-132f-c49979b9012b@huaweicloud.com>
 <560ae765-3fa1-42b7-a71c-e078e52e64fd@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <82ed0b5d-d1ba-4e58-7d3b-adeb10b1ad24@huaweicloud.com>
Date: Tue, 27 May 2025 10:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <560ae765-3fa1-42b7-a71c-e078e52e64fd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl9OKDVoaFuHNg--.19652S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWUAFWDKF4DZFW8ZFykuFg_yoW5CFyfpr
	Z7JF13CrW5Xr1fXr12q34UZF9Yqw4kJ3srXryxXF18JrnrtrnIqr4UWF1vgr18Ar48JF1U
	Xr1UJr1xur15XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/05/27 10:15, Xiao Ni 写道:
> 
> 在 2025/5/26 下午3:57, Yu Kuai 写道:
>> Hi,
>>
>> 在 2025/05/26 14:52, Xiao Ni 写道:
>>> On Sat, May 24, 2025 at 2:18 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Currently bitmap_ops is registered while allocating mddev, this is fine
>>>> when there is only one bitmap_ops, however, after introduing a new
>>>> bitmap_ops, user space need a time window to choose which bitmap_ops to
>>>> use while creating new array.
>>>
>>> Could you give more explanation about what the time window is? Is it
>>> between setting llbitmap by bitmap_type and md_bitmap_create?
>>
>> The window after this patch is that user can write the new sysfs after
>> allocating mddev, and before running the array.
> 
> 
> Thanks for the explanation. Is it ok to add it in the commit log message?

ok
> 
>>>
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>   drivers/md/md.c | 86 
>>>> +++++++++++++++++++++++++++++++------------------
>>>>   1 file changed, 55 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>>> index 4eb0c6effd5b..dc4b85f30e13 100644
>>>> --- a/drivers/md/md.c
>>>> +++ b/drivers/md/md.c
>>>> @@ -674,39 +674,50 @@ static void no_op(struct percpu_ref *r) {}
>>>>
>>>>   static bool mddev_set_bitmap_ops(struct mddev *mddev)
>>>>   {
>>>> +       struct bitmap_operations *old = mddev->bitmap_ops;
>>>> +       struct md_submodule_head *head;
>>>> +
>>>> +       if (mddev->bitmap_id == ID_BITMAP_NONE ||
>>>> +           (old && old->head.id == mddev->bitmap_id))
>>>> +               return true;
>>>> +
>>>>          xa_lock(&md_submodule);
>>>> -       mddev->bitmap_ops = xa_load(&md_submodule, mddev->bitmap_id);
>>>> +       head = xa_load(&md_submodule, mddev->bitmap_id);
>>>>          xa_unlock(&md_submodule);
>>>>
>>>> -       if (!mddev->bitmap_ops) {
>>>> -               pr_warn_once("md: can't find bitmap id %d\n", 
>>>> mddev->bitmap_id);
>>>> +       if (WARN_ON_ONCE(!head || head->type != MD_BITMAP)) {
>>>> +               pr_err("md: can't find bitmap id %d\n", 
>>>> mddev->bitmap_id);
>>>>                  return false;
>>>>          }
>>>>
>>>> +       if (old && old->group)
>>>> +               sysfs_remove_group(&mddev->kobj, old->group);
>>>
>>> I think you're handling a competition problem here. But I don't know
>>> how the old/old->group is already created when creating an array.
>>> Could you explain this?
>>
>> It's not possible now, this is because I think we want to be able to
>> switch existing array with old bitmap to new bitmap.
> 
> 
> Can we add the check of old when we really want it?

I'm fine, and there is no doubt we will want it.

Thanks,
Kuai

> 
> Regards
> 
> Xiao
> 
>>
>> Thanks,
>> Kuai
>>
>>>
>>> Regards
>>> Xiao
>>
> 
> 
> .
> 


