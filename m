Return-Path: <linux-raid+bounces-4206-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DADEAB4FD8
	for <lists+linux-raid@lfdr.de>; Tue, 13 May 2025 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39FE189DB8E
	for <lists+linux-raid@lfdr.de>; Tue, 13 May 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C72222A7;
	Tue, 13 May 2025 09:32:24 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF921C9F6;
	Tue, 13 May 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128743; cv=none; b=Srzr99T2pXen4tlnUVq3xvKr1PvyTJkEwZmRg8IZsdJmvZCycU1jmVcSEqOxoBR1cixlBYr6/XiCtOQOdFfogMm3MbtSNmto2eqIZ0MNi5v6anjsRKg190n7d9V1zgWXj2L6fZFI8cKqZMItMQ4lBlAh+5sX8M3Gbwl8jr5wZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128743; c=relaxed/simple;
	bh=nNrYIQy1skPi5qstR5qKheiozyvtxRrmAYWX6yKF368=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XCxSNaa+RFgoGEIruyaZurSbz/ZQatozTTl4ZbcZfLCybpKqXT+fllaTxXoXu55Fe4XAlEI8fnyQGlk9seLvsIGMd59BRwOMPhpM2skrc4Cir0zIR7IhK0NKUZKT+KpISKmdmV3uNHwV4U6B2OW2dNsPE2uD3mS8AM7lk6YOEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZxWT34Bhhz4f3jMw;
	Tue, 13 May 2025 17:31:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C60A1A133A;
	Tue, 13 May 2025 17:32:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl+eESNoLyocMQ--.9820S3;
	Tue, 13 May 2025 17:32:16 +0800 (CST)
Subject: Re: [PATCH RFC md-6.16 v3 15/19] md/md-llbitmap: implement APIs to
 dirty bits and clear bits
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, colyli@kernel.org, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
 <20250512011927.2809400-16-yukuai1@huaweicloud.com>
 <20250512051722.GA1667@lst.de>
 <0de7efeb-6d4a-2fa5-ed14-e2c0bec0257b@huaweicloud.com>
 <20250512132641.GC31781@lst.de> <20250512133048.GA32562@lst.de>
 <69dc5ab6-542d-dcc2-f4ec-0a6a8e49b937@huaweicloud.com>
 <03f64fc7-4e57-2f32-bffc-04836a9df790@huaweicloud.com>
 <20250513064803.GA1508@lst.de>
 <87a53ae0-c4d6-adff-8272-c49d63bf30db@huaweicloud.com>
 <20250513074304.GA2696@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d5ae7af0-dd73-7d6b-f520-c25e411f8f06@huaweicloud.com>
Date: Tue, 13 May 2025 17:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250513074304.GA2696@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl+eESNoLyocMQ--.9820S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr18CF4xJrW5ZFyxArW8JFb_yoWkZrb_ur
	9a9ay7C3srGF1kAayIgFs0qFZ7Gw48Wa47Xa9YqF42g3s8Xa98uFWvy3sxua40yw40y3W3
	Wr97Xw12k3ZF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/05/13 15:43, Christoph Hellwig д��:
> On Tue, May 13, 2025 at 03:14:03PM +0800, Yu Kuai wrote:
>> Yes, following change can work as well.
>>
>> Just wonder, if the array is created by another array, and which is
>> created by another array ...  In this case, the stack depth can be
>> huge. :(  This is super weird case, however, should we keep the old code
>> in this case?
> 
> Yeah, that's a good question.  Stacking multiple arrays using bitmaps
> on top of each other is weird.  But what if other block remappers
> starting to use this for other remapping and they are stacked?  That
> seems much more likely unfotunately, so maybe we can't go down this
> route after all, sorry for leading you to it.

I was thinking about record a stack dev depth in mddev to handle the
weird case inside raid. Is there other stack device have the same
problem? AFAIK, some dm targets like dm-crypt are using workqueue
to handle all IO.

I'm still interested because this can improve first write latency.

> 
> So instead just write a comment documenting why you switch to a
> different stack using the workqueue.

Ok, I'll add comment if we keep using the workqueue.

Thanks,
Kuai

> .
> 


