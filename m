Return-Path: <linux-raid+bounces-3995-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4732FA8B54F
	for <lists+linux-raid@lfdr.de>; Wed, 16 Apr 2025 11:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A583441169
	for <lists+linux-raid@lfdr.de>; Wed, 16 Apr 2025 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C782F2356A2;
	Wed, 16 Apr 2025 09:29:06 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBC146D65;
	Wed, 16 Apr 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795746; cv=none; b=OYICUm7B61YT4d0Jyu/8/U7VRtPdLf5QTjJ/0id4YQ/UIhNDu7Zu2+gGwNEiZ29AHcM6eVVaQ/76kdGbx/CYm8tmFQ78TVOC1yjIkM4b54Mz9g66+qsd/i+tFtTmefmIepFZ4HXdW3AsvqE+kalYHqripbhISOCPU1mRF/OrGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795746; c=relaxed/simple;
	bh=X5piQBVitXbJPfuWcuJFck+SpJYrrhbh9yYybrinDkk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SObnPfvWScAsSjNsBeJF5BdWdCeZwbtc1jDP9JFcWX9NCWN4cA5nLNUdODVfGc8xjCbCQChrxUuMPzzEEOkcF+HwKufB3/bq4mF0g30OeKhcvNLtOqbMcc2IvdizeoEP4K4Qd8TqLvIvTQsIjbrFIxRN0Fzp58KTpUd4bQFhO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zcwgm5LyDz4f3jdZ;
	Wed, 16 Apr 2025 17:28:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6EA131A058E;
	Wed, 16 Apr 2025 17:29:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe19aeP9nXXWSJg--.56608S3;
	Wed, 16 Apr 2025 17:29:00 +0800 (CST)
Subject: Re: [PATCH 3/4] md: fix is_mddev_idle()
To: Yu Kuai <yukuai1@huaweicloud.com>, Xiao Ni <xni@redhat.com>,
 axboe@kernel.dk, song@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250412073202.3085138-1-yukuai1@huaweicloud.com>
 <20250412073202.3085138-4-yukuai1@huaweicloud.com>
 <c085664e-3a52-4a1c-b973-8d2ba6e5d509@redhat.com>
 <42cbe72e-1db5-1723-789d-a93b5dc95f8f@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4358e07e-f78b-cd32-bbed-c597b8bb4c19@huaweicloud.com>
Date: Wed, 16 Apr 2025 17:28:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <42cbe72e-1db5-1723-789d-a93b5dc95f8f@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe19aeP9nXXWSJg--.56608S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyfuF4DXF1xKF47urW3ZFb_yoWkAFXEvr
	4FkryDZF48JrWkt34ayF4Fvr9FgF4Fya4DJFZ8JF1Ygry8JF9a9r45X3s3trWkKw43Gr1Y
	krnYgF17AFW7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/16 15:42, Yu Kuai 写道:
> Hi,
> 
> 在 2025/04/16 14:20, Xiao Ni 写道:
>>> +static bool is_rdev_idle(struct md_rdev *rdev, bool init)
>>> +{
>>> +    unsigned long last_events = rdev->last_events;
>>> +
>>> +    if (!bdev_is_partition(rdev->bdev))
>>> +        return true;
>>
>>
>> For md array, I think is_rdev_idle is not useful. Because 
>> mddev->last_events must be increased while upper ios come in and idle 
>> will be set to false. For dm array, mddev->last_events can't work. So 
>> is_rdev_idle is for dm array. If member disk is one partition, 
>> is_rdev_idle alwasy returns true, and is_mddev_idle always return 
>> true. It's a bug here. Do we need to check bdev_is_partition here?
> 
> is_rdev_idle() is not used for current array, for example:
> 
> sda1 is used for array md0, and user doesn't issue IO to md0, while
> user issues IO to sda2. In this case, is_mddev_idle() still fail for
> array md0 because is_rdev_idle() fail.

Perhaps the name is_rdev_holder_idle() is better.

Thanks,
Kuai

> 
> This is just inherited from the old behaviour.
> 
> Thanks,
> Kuai
> 
>>
>> Best Regards
>>
>> Xiao
> 
> .
> 


